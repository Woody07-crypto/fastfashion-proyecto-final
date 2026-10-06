from reportlab.lib.pagesizes import letter
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.units import inch
from reportlab.lib.colors import HexColor
from reportlab.platypus import (
    SimpleDocTemplate,
    Paragraph,
    Spacer,
    Table,
    TableStyle,
    HRFlowable,
)
import os

out = os.path.join(os.path.dirname(__file__), "Refactorizacion_Formulario_Form.pdf")

doc = SimpleDocTemplate(
    out,
    pagesize=letter,
    leftMargin=0.85 * inch,
    rightMargin=0.85 * inch,
    topMargin=0.7 * inch,
    bottomMargin=0.7 * inch,
)

styles = getSampleStyleSheet()
title = ParagraphStyle(
    "TitleES",
    parent=styles["Heading1"],
    fontSize=16,
    textColor=HexColor("#1A1F2E"),
    spaceAfter=6,
    leading=20,
)
h2 = ParagraphStyle(
    "H2ES",
    parent=styles["Heading2"],
    fontSize=12,
    textColor=HexColor("#0F766E"),
    spaceBefore=12,
    spaceAfter=6,
    leading=16,
)
body = ParagraphStyle(
    "BodyES",
    parent=styles["Normal"],
    fontSize=10,
    leading=14,
    textColor=HexColor("#1A1F2E"),
    spaceAfter=6,
)
small = ParagraphStyle(
    "SmallES",
    parent=styles["Normal"],
    fontSize=9,
    leading=12,
    textColor=HexColor("#444444"),
)

story = []
story.append(Paragraph("Actividad: refactoriza un formulario con Form", title))
story.append(Paragraph("Proyecto final — FastFashion (Equipo 5)", body))
story.append(
    Paragraph(
        "Documento de cambios del formulario de alta de prenda",
        small,
    )
)
story.append(Spacer(1, 6))
story.append(HRFlowable(width="100%", thickness=1, color=HexColor("#0F766E")))
story.append(Spacer(1, 8))

story.append(Paragraph("1. Formulario elegido", h2))
story.append(
    Paragraph(
        "Se eligió el formulario <b>Agregar prenda</b> del módulo Closet "
        "(archivo <b>lib/screens/add_garment_screen.dart</b>). "
        "Es el diálogo de registro de imagen/prenda declarado en el alcance "
        "de FastFashion.",
        body,
    )
)

story.append(Paragraph("2. Huecos detectados (versión anterior)", h2))
story.append(
    Paragraph(
        "La versión previa usaba <b>TextField</b> + controllers, sin <b>Form</b> "
        "ni validadores. Problemas identificados:",
        body,
    )
)
story.append(Paragraph("• Nombre vacío o demasiado corto se podía guardar.", body))
story.append(
    Paragraph(
        "• Color aceptaba números o símbolos (ej. 123).",
        body,
    )
)
story.append(
    Paragraph(
        "• Notas vacías o demasiado cortas/largas no se rechazaban.",
        body,
    )
)
story.append(Paragraph("• El botón Guardar no bloqueaba datos inválidos.", body))

story.append(Paragraph("3. Refactorización aplicada", h2))
story.append(
    Paragraph(
        "Se refactorizó usando <b>Form</b>, <b>GlobalKey&lt;FormState&gt;</b>, "
        "<b>TextFormField</b> y <b>validator</b>. "
        "El guardado llama a <b>_formKey.currentState.validate()</b> y solo "
        "confirma si todo es válido.",
        body,
    )
)

data = [
    [
        Paragraph("<b>Campo</b>", small),
        Paragraph("<b>Regla (rechaza si…)</b>", small),
        Paragraph("<b>Mensaje</b>", small),
    ],
    [
        Paragraph("Nombre", small),
        Paragraph("Vacío, &lt; 3 o &gt; 40 caracteres", small),
        Paragraph(
            "El nombre es obligatorio / Usa al menos 3 caracteres",
            small,
        ),
    ],
    [
        Paragraph("Color", small),
        Paragraph(
            "Vacío, números, símbolos o longitud fuera de 3–20",
            small,
        ),
        Paragraph(
            "Solo letras (3–20). Rechaza números o símbolos",
            small,
        ),
    ],
    [
        Paragraph("Notas", small),
        Paragraph("Vacío, &lt; 5 o &gt; 120 caracteres", small),
        Paragraph(
            "Agrega una nota breve / Máximo 120 caracteres",
            small,
        ),
    ],
]
table = Table(data, colWidths=[1.2 * inch, 3.0 * inch, 2.5 * inch])
table.setStyle(
    TableStyle(
        [
            ("BACKGROUND", (0, 0), (-1, 0), HexColor("#E6F4F2")),
            ("GRID", (0, 0), (-1, -1), 0.5, HexColor("#B0BEC5")),
            ("VALIGN", (0, 0), (-1, -1), "TOP"),
            ("LEFTPADDING", (0, 0), (-1, -1), 6),
            ("RIGHTPADDING", (0, 0), (-1, -1), 6),
            ("TOPPADDING", (0, 0), (-1, -1), 5),
            ("BOTTOMPADDING", (0, 0), (-1, -1), 5),
        ]
    )
)
story.append(table)
story.append(Spacer(1, 8))
story.append(
    Paragraph(
        "Cumple el requisito: <b>al menos tres campos rechazan datos "
        "inválidos antes de guardar</b>.",
        body,
    )
)

story.append(Paragraph("4. Comparación antes / después", h2))
comp = [
    [Paragraph("<b>Antes</b>", small), Paragraph("<b>Después</b>", small)],
    [
        Paragraph("TextField sin validator", small),
        Paragraph("TextFormField + validator", small),
    ],
    [
        Paragraph("Sin Form / GlobalKey", small),
        Paragraph("Form(key: _formKey)", small),
    ],
    [
        Paragraph("_save() siempre hacía pop", small),
        Paragraph("_save() valida y bloquea si hay error", small),
    ],
    [
        Paragraph("add_garment_screen_antes.dart", small),
        Paragraph("add_garment_screen.dart (en uso)", small),
    ],
]
t2 = Table(comp, colWidths=[3.35 * inch, 3.35 * inch])
t2.setStyle(
    TableStyle(
        [
            ("BACKGROUND", (0, 0), (-1, 0), HexColor("#F6F1E8")),
            ("GRID", (0, 0), (-1, -1), 0.5, HexColor("#B0BEC5")),
            ("VALIGN", (0, 0), (-1, -1), "TOP"),
            ("LEFTPADDING", (0, 0), (-1, -1), 6),
            ("RIGHTPADDING", (0, 0), (-1, -1), 6),
            ("TOPPADDING", (0, 0), (-1, -1), 5),
            ("BOTTOMPADDING", (0, 0), (-1, -1), 5),
        ]
    )
)
story.append(t2)

story.append(Paragraph("5. Alternativas evaluadas (IA)", h2))
story.append(
    Paragraph(
        "Se pidieron reglas alternativas y se evaluó si aplicaban al "
        "contexto de FastFashion:",
        body,
    )
)
story.append(
    Paragraph(
        "<b>Aceptada:</b> validar color solo con letras (nombre del color). "
        "Aplica porque el mockup clasifica por color textual, no por código hex.",
        body,
    )
)
story.append(
    Paragraph(
        "<b>Aceptada:</b> AutovalidateMode.onUserInteraction para feedback "
        "inmediato.",
        body,
    )
)
story.append(
    Paragraph(
        "<b>Rechazada:</b> exigir URL de imagen obligatoria con regex compleja. "
        "No aplica aún: la carga real de imagen queda fuera de este mockup.",
        body,
    )
)
story.append(
    Paragraph(
        "<b>Rechazada:</b> validar email/teléfono en este formulario. "
        "No corresponde al registro de prendas.",
        body,
    )
)

story.append(Paragraph("6. Cómo comprobar", h2))
story.append(Paragraph("1. Abrir Closet → Agregar prenda.", body))
story.append(
    Paragraph("2. Intentar guardar con nombre vacío → debe rechazar.", body)
)
story.append(Paragraph("3. Color 123 → debe rechazar.", body))
story.append(
    Paragraph(
        "4. Nota \"ok\" → debe rechazar (&lt; 5 caracteres).",
        body,
    )
)
story.append(
    Paragraph(
        "5. Completar los tres campos válidos → guarda y vuelve al Closet.",
        body,
    )
)

story.append(Spacer(1, 14))
story.append(HRFlowable(width="100%", thickness=0.5, color=HexColor("#B0BEC5")))
story.append(Spacer(1, 6))
story.append(
    Paragraph(
        "Archivos: lib/screens/add_garment_screen.dart (refactor) · "
        "lib/screens/add_garment_screen_antes.dart (referencia).",
        small,
    )
)

doc.build(story)
print("PDF OK:", out)
