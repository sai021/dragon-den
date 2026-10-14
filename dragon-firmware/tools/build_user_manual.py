"""Build the printable end-user manual from docs/USER-MANUAL.md."""
from pathlib import Path
import re
from xml.sax.saxutils import escape
from reportlab.lib import colors
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import ParagraphStyle
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, PageBreak

ROOT=Path(__file__).resolve().parents[2]
OUTPUT=ROOT/'output/pdf/dragon-den-user-manual.pdf'
PURPLE=colors.HexColor('#34304e')
TEAL=colors.HexColor('#236a70')

def inline(text):
    return re.sub(r'\*\*(.+?)\*\*',r'<b>\1</b>',escape(text))

def build():
    OUTPUT.parent.mkdir(parents=True,exist_ok=True)
    styles={
      'title':ParagraphStyle('title',fontName='Helvetica-Bold',fontSize=30,leading=35,textColor=PURPLE,spaceAfter=10),
      'subtitle':ParagraphStyle('subtitle',fontName='Helvetica',fontSize=13,leading=18,textColor=TEAL,spaceAfter=24),
      'heading':ParagraphStyle('heading',fontName='Helvetica-Bold',fontSize=15,leading=19,textColor=PURPLE,spaceBefore=15,spaceAfter=9,keepWithNext=True),
      'body':ParagraphStyle('body',fontName='Helvetica',fontSize=11.7,leading=16.4,textColor=colors.HexColor('#34343e'),spaceAfter=11),
      'list':ParagraphStyle('list',fontName='Helvetica',fontSize=11.7,leading=16.4,textColor=colors.HexColor('#34343e'),leftIndent=20,firstLineIndent=0,bulletIndent=1,spaceAfter=9),
    }
    def decoration(canvas,doc):
        width,height=A4;canvas.saveState()
        canvas.setFillColor(TEAL);canvas.rect(0,height-9,width,9,fill=1,stroke=0)
        canvas.setFont('Helvetica-Bold',9);canvas.setFillColor(PURPLE);canvas.drawString(52,height-35,'DRAGON DEN  /  USER MANUAL')
        canvas.setStrokeColor(colors.HexColor('#dddbe6'));canvas.line(52,42,width-52,42)
        canvas.setFont('Helvetica',8);canvas.setFillColor(colors.HexColor('#686574'))
        canvas.drawString(52,28,'Prototype edition 0.1  |  15 October 2026')
        canvas.drawRightString(width-52,28,f'{doc.page} / 6');canvas.restoreState()
    story=[]
    for page_index,chunk in enumerate((ROOT/'docs/USER-MANUAL.md').read_text(encoding='utf-8').split('<!-- page -->')):
        if page_index:story.append(PageBreak())
        lines=chunk.strip().splitlines();i=0;subtitle=True
        while i<len(lines):
            line=lines[i].strip()
            if not line:i+=1;continue
            if line.startswith('# '):story.append(Paragraph(inline(line[2:]),styles['title']));i+=1;continue
            if line.startswith('## '):story.append(Paragraph(inline(line[3:]),styles['heading']));subtitle=False;i+=1;continue
            match=re.match(r'^(\d+)\.\s+(.+)|^-\s+(.+)',line)
            if match:
                text=match.group(2) or match.group(3);bullet=(match.group(1)+'.') if match.group(1) else '\u2022';i+=1
                while i<len(lines) and lines[i].strip() and not re.match(r'^(?:\d+\.|-|#)\s',lines[i].strip()):text+=' '+lines[i].strip();i+=1
                story.append(Paragraph(inline(text),styles['list'],bulletText=bullet));continue
            text=line;i+=1
            while i<len(lines) and lines[i].strip() and not re.match(r'^(?:\d+\.|-|#)\s',lines[i].strip()):text+=' '+lines[i].strip();i+=1
            story.append(Paragraph(inline(text),styles['subtitle'] if subtitle else styles['body']));subtitle=False
    doc=SimpleDocTemplate(str(OUTPUT),pagesize=A4,rightMargin=52,leftMargin=52,topMargin=62,bottomMargin=58,title='Dragon Den - User Manual',author='Dragon Den',subject='Touch controls, phone setup, profiles and custom dragons')
    doc.build(story,onFirstPage=decoration,onLaterPages=decoration)
    print(OUTPUT)

if __name__=='__main__':build()
