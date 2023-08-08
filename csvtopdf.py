import os
import pandas as pd
from reportlab.lib.pagesizes import letter, landscape
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, PageBreak
from reportlab.lib import colors
from reportlab.lib.units import inch
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.platypus import Paragraph, Spacer

# Path to the folder containing CSV files
csv_folder = r"C:\Users\skans\OneDrive\Desktop\dash"

# PDF output file
pdf_output_path = 'report.pdf'

# Margins for the PDF pages
left_margin = 0.1 * inch
right_margin = 0.1 * inch
top_margin = 0.1 * inch
bottom_margin = 0.1 * inch

# Maximum length for cell content before truncating
max_cell_length = 20

# Function to truncate cell content with ellipsis
def truncate_with_ellipsis(text, max_length):
    return text if len(text) <= max_length else text[:max_length-3] + '...'

# Function to apply truncation function with a specified max length
def apply_truncate(text):
    return truncate_with_ellipsis(str(text), max_cell_length)

# Create a PDF document in landscape orientation with reduced margins
doc = SimpleDocTemplate(pdf_output_path, pagesize=landscape(letter),
                        leftMargin=left_margin, rightMargin=right_margin,
                        topMargin=top_margin, bottomMargin=bottom_margin)

# Create an empty list to hold all table elements
all_tables = []

# Iterate through each CSV file in the folder
for filename in os.listdir(csv_folder):
    if filename.endswith('.csv'):
        csv_path = os.path.join(csv_folder, filename)
        df = pd.read_csv(csv_path, encoding='ISO-8859-1')

        # Truncate cell content exceeding max_cell_length
        df = df.applymap(apply_truncate)

        # Convert DataFrame to a list of lists for the Table object
        table_data = [df.columns.tolist()] + df.values.tolist()

        # Calculate available width for the table
        available_width = doc.width - left_margin - right_margin

        # Calculate dynamic column widths based on the longest entry
        col_widths = []
        for col in range(len(table_data[0])):
            max_width = min(max([len(str(row[col])) for row in table_data]), max_cell_length)
            col_widths.append(min(max_width * 10, available_width / len(table_data[0])))

        # Define the dynamic style based on calculated values
        dynamic_style = TableStyle([
            ('BACKGROUND', (0, 0), (-1, 0), colors.grey),
            ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),
            ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
            ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
            ('BOTTOMPADDING', (0, 0), (-1, 0), 12),
            ('FONTSIZE', (0, 0), (-1, 0), 10),  # Set a fixed font size
            ('BACKGROUND', (0, 1), (-1, -1), colors.beige),
            ('GRID', (0, 0), (-1, -1), 1, colors.black),
        ])

        # Create a table from the table data
        table = Table(table_data, colWidths=col_widths, repeatRows=1)
        table.setStyle(dynamic_style)

        # Add a spacer and title above each table
        title = Paragraph(f"<b>CSV: {filename}</b>", getSampleStyleSheet()['Title'])
        all_tables.extend([title, Spacer(0, 0.2 * inch), table])

# Build the PDF document with all tables (each table on a separate sheet)
doc.build(all_tables)

print("PDF report with all CSVs in separate sheets, reduced margins, dynamically adjusted column widths, and truncated cell content has been generated successfully.")
