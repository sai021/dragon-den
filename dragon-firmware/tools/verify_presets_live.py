"""Short serial smoke test for installed presets; restores blue at the end."""
import time
from pathlib import Path
import serial

def main():
    port=serial.Serial(port=None,baudrate=115200,timeout=.15,write_timeout=2)
    port.dtr=False;port.rts=False;port.port='COM17';port.open()
    logpath=Path(__file__).resolve().parents[1]/'.tools'/'dragon-presets-live.log'
    try:
        with logpath.open('w',encoding='utf-8') as log:
            for dragon in ('glory','moonwatcher','winter','sundew','mightyclaws','blue'):
                port.reset_input_buffer()
                port.write(f'dragon {dragon}\nstatus\n'.encode())
                end=time.monotonic()+2;confirmed=False
                while time.monotonic()<end:
                    line=port.readline().decode(errors='replace').strip()
                    if not line:continue
                    log.write(line+'\n');log.flush()
                    if line.startswith(('dragon=','startup_pending=')):print(line,flush=True)
                    confirmed|=line.startswith(f'dragon={dragon} ')
                if not confirmed:raise RuntimeError(f'No confirmation for {dragon}')
            print('PASS: six installed preset selections confirmed; blue restored.',flush=True)
    finally:
        port.write(b'dragon blue\n')
        port.close()

if __name__=='__main__':main()
