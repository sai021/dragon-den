import json
from pathlib import Path
import sys
import tempfile
import tkinter as tk
import unittest

sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'tools'))
import palettes
from palette_editor import Editor

class EditorTests(unittest.TestCase):
    def test_colour_preview_save_and_default(self):
        root=tk.Tk();root.withdraw()
        try:
            with tempfile.TemporaryDirectory() as directory:
                source=Path(directory)/'dragons.json';output=Path(directory)/'DragonPresets.h'
                source.write_text(palettes.SOURCE.read_text(encoding='utf-8'),encoding='utf-8')
                editor=Editor(root,source,output);root.update_idletasks()
                self.assertEqual(editor.collect(),editor.clean)
                self.assertEqual(len(editor.canvas.find_all()),64)
                editor.selected.set('glory');editor.load()
                editor.colors['wings']='#123456';editor.effects['glitter'].set(True)
                editor.default.set(True);editor.refresh();editor.save()
                data=json.loads(source.read_text());p=next(p for p in data['presets'] if p['id']=='glory')
                self.assertEqual(p['zones']['wings'],'#123456')
                self.assertIn('glitter',p['effects']);self.assertEqual(data['default'],'glory')
                self.assertTrue(source.with_suffix('.json.bak').exists())
                palettes.generate(source,output,check=True)
                self.assertEqual(editor.collect(),editor.clean)
                wing=editor.map.index('LW');item=editor.canvas.find_all()[wing]
                self.assertEqual(editor.canvas.itemcget(item,'fill'),'#123456')
                editor.settings['period_ms'].set('0')
                with self.assertRaises(ValueError):editor.collect()
        finally:root.destroy()

if __name__=='__main__':unittest.main()
