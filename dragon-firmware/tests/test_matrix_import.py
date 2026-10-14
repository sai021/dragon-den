import csv
from pathlib import Path
import sys
import unittest

sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'tools'))
import import_matrix
import palettes

class MatrixImportTests(unittest.TestCase):
    def test_every_source_pixel_and_name(self):
        catalog=import_matrix.load_catalog()
        with import_matrix.SOURCE.open(encoding='utf-8-sig',newline='') as f:
            rows=list(csv.DictReader(f))
        self.assertEqual(len(catalog['presets']),81)
        grid=palettes.layout()
        for p,row in zip(catalog['presets'],rows):
            self.assertEqual(p['name'],row['Dragon Name'])
            tokens=row['8x8 Matrix Hardware Array (64 Pixels Map)'].split(',')
            actual=palettes.pixel_colors(p)
            for i,token in enumerate(tokens):
                hue,gain=token.split('|');gain=int(gain)
                rgb=[v*gain//255 for v in palettes.color(hue)]
                if grid[i] in ('LE','RE') and any(rgb):rgb=[v+(255-v)*gain//1275 for v in rgb]
                self.assertEqual(palettes.color(actual[i]),tuple(rgb))
        sunny=next(p for p in catalog['presets'] if p['id']=='sunny')
        self.assertEqual(sunny['effect_zones']['breathe'],['FACE','BODY'])
        self.assertEqual(set(sunny['effect_zones']['glitter']),{'LE','RE','LW','RW'})

    def test_edges_can_change_without_wings(self):
        p=import_matrix.load_catalog()['presets'][0]
        original=palettes.pixel_colors(p)
        p['zones']['edges']='#123456'
        changed=palettes.pixel_colors(p)
        for i,z in enumerate(palettes.layout()):
            self.assertEqual(changed[i],'#123456' if z in ('LE','RE') else original[i])

if __name__=='__main__':unittest.main()
