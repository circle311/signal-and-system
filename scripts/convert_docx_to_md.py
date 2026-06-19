from __future__ import annotations

import argparse
import re
from pathlib import Path
from typing import Iterable

from docx import Document
from docx.document import Document as DocumentType
from docx.oxml.table import CT_Tbl
from docx.oxml.text.paragraph import CT_P
from docx.table import Table
from docx.text.paragraph import Paragraph


def iter_blocks(parent: DocumentType) -> Iterable[Paragraph | Table]:
    for child in parent.element.body.iterchildren():
        if isinstance(child, CT_P):
            yield Paragraph(child, parent)
        elif isinstance(child, CT_Tbl):
            yield Table(child, parent)


def clean_cell(text: str) -> str:
    return " ".join(text.replace("\n", " ").split()).replace("|", "\\|")


def escape_markdown(text: str) -> str:
    return text.replace("\\", "\\\\").replace("*", "\\*").replace("_", "\\_")


def paragraph_to_markdown(paragraph: Paragraph, media_dir: Path) -> list[str]:
    text_parts: list[str] = []
    image_parts: list[str] = []

    for node in paragraph._element.iter():
        if node.tag.endswith("}t") and node.text:
            text_parts.append(node.text)

    for run in paragraph.runs:
        drawings = run._element.xpath(".//a:blip")
        for drawing in drawings:
            rel_id = drawing.get(
                "{http://schemas.openxmlformats.org/officeDocument/2006/relationships}embed"
            )
            if not rel_id:
                continue
            image_part = paragraph.part.related_parts[rel_id]
            ext = Path(image_part.partname).suffix or ".png"
            media_dir.mkdir(parents=True, exist_ok=True)
            image_name = f"image-{len(list(media_dir.glob('image-*'))) + 1}{ext}"
            image_path = media_dir / image_name
            image_path.write_bytes(image_part.blob)
            image_parts.append(f"![{image_name}](media/{image_name})")

    text = "".join(text_parts).strip()
    style_name = (paragraph.style.name if paragraph.style is not None else "").lower()

    if not text and not image_parts:
        return []

    lines: list[str] = []
    heading_match = re.search(r"heading\s+(\d+)", style_name)
    if heading_match and text:
        level = max(1, min(6, int(heading_match.group(1))))
        lines.append(f"{'#' * level} {text}")
    elif style_name.startswith("title") and text:
        lines.append(f"# {text}")
    elif style_name.startswith("subtitle") and text:
        lines.append(f"_{escape_markdown(text)}_")
    elif text:
        lines.append(text)

    lines.extend(image_parts)
    return lines


def table_to_markdown(table: Table) -> list[str]:
    rows = [[clean_cell(cell.text) for cell in row.cells] for row in table.rows]
    if not rows:
        return []

    width = max(len(row) for row in rows)
    normalized = [row + [""] * (width - len(row)) for row in rows]
    header = normalized[0]
    separator = ["---"] * width
    body = normalized[1:]

    lines = [
        "| " + " | ".join(header) + " |",
        "| " + " | ".join(separator) + " |",
    ]
    lines.extend("| " + " | ".join(row) + " |" for row in body)
    return lines


def convert(input_path: Path, output_path: Path) -> None:
    document = Document(input_path)
    media_dir = output_path.parent / "media"
    lines: list[str] = []

    for block in iter_blocks(document):
        if isinstance(block, Paragraph):
            block_lines = paragraph_to_markdown(block, media_dir)
        else:
            block_lines = table_to_markdown(block)

        if block_lines:
            lines.extend(block_lines)
            lines.append("")

    output_path.write_text("\n".join(lines).rstrip() + "\n", encoding="utf-8")


def main() -> None:
    parser = argparse.ArgumentParser(description="Convert a DOCX file to Markdown.")
    parser.add_argument("input", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    convert(args.input, args.output)


if __name__ == "__main__":
    main()
