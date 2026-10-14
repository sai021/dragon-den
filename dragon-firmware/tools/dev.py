#!/usr/bin/env python3
"""Portable Arduino CLI setup, build, upload and monitor helper."""
import argparse
import os
from pathlib import Path
import shutil
import subprocess
import sys
from palettes import generate as generate_palettes
from embed_web import generate as generate_web

ROOT = Path(__file__).resolve().parents[1]
FQBN = 'esp32:esp32:esp32s3:USBMode=hwcdc,CDCOnBoot=cdc,FlashSize=4M,PSRAM=enabled,PartitionScheme=custom'
INDEX = 'https://espressif.github.io/arduino-esp32/package_esp32_index.json'

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('action', choices=['setup', 'ports', 'build', 'upload', 'monitor'])
    parser.add_argument('--port', help='For example COM5 or /dev/cu.usbmodem123')
    parser.add_argument('--cli', default=os.environ.get('ARDUINO_CLI', 'arduino-cli'))
    parser.add_argument('--fqbn', default=FQBN, help='Override for your verified board configuration')
    args = parser.parse_args()
    if args.action in ('upload', 'monitor') and not args.port:
        parser.error('--port is required; run ports first')
    cli = shutil.which(args.cli)
    if not cli:
        parser.error('Install Arduino CLI and add it to PATH, or use --cli with its full path. See OTHER-COMPUTER.md.')
    def run(*items):
        subprocess.run([cli, *items], check=True)
    if args.action == 'setup':
        run('core', 'update-index', '--additional-urls', INDEX)
        run('core', 'install', 'esp32:esp32@3.2.1', '--additional-urls', INDEX)
        run('lib', 'install', 'Adafruit NeoPixel@1.12.5')
    elif args.action == 'ports':
        run('board', 'list')
    elif args.action == 'monitor':
        run('monitor', '-p', args.port, '--config', 'baudrate=115200')
    else:
        generate_palettes()
        generate_web()
        build = ROOT / 'build'
        run('compile', '--fqbn', args.fqbn, '--build-path', str(build), str(ROOT / 'DragonPrototype'))
        app = build / 'DragonPrototype.ino.bin'
        if app.exists() and app.stat().st_size > 0x180000:
            parser.error(f'application is {app.stat().st_size} bytes; custom app partition is 0x180000 bytes')
        if args.action == 'upload':
            run('upload', '--fqbn', args.fqbn, '--port', args.port,
                '--input-dir', str(build), str(ROOT / 'DragonPrototype'))

if __name__ == '__main__':
    try:
        main()
    except subprocess.CalledProcessError as error:
        sys.exit(error.returncode)
