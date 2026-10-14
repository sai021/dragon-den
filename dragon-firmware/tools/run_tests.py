"""Run the project's Python and native C++ regression suites without a board."""
import argparse
import os
from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
SUITES = ('core', 'load', 'power', 'presets', 'sensors', 'startup', 'voltage', 'connection', 'library', 'creations')

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--cxx', default='c++', help='C++17 compiler executable')
    parser.add_argument('--zig', help='Use this Zig executable in C++ mode instead')
    args = parser.parse_args()
    output = ROOT / '.tools' / 'regression-tests'
    output.mkdir(parents=True, exist_ok=True)
    subprocess.run([sys.executable, '-m', 'unittest', 'discover', '-s', 'tests', '-p', 'test_*.py'], cwd=ROOT, check=True)
    compiler = [args.zig, 'c++'] if args.zig else [args.cxx]
    for suite in SUITES:
        executable = output / ('test_' + suite + ('.exe' if os.name == 'nt' else ''))
        subprocess.run(compiler + ['-std=c++17', '-I', str(ROOT / 'tests/fakes'), str(ROOT / 'tests' / ('test_' + suite + '.cpp')), '-o', str(executable)], cwd=ROOT, check=True)
        subprocess.run([str(executable)], cwd=ROOT, check=True)
    print('All Python tests and ten native C++ suites passed.')

if __name__ == '__main__':
    main()
