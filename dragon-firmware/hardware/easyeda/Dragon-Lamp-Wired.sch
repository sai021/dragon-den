<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE eagle SYSTEM "eagle.dtd">
<eagle version="9.6.2">
  <drawing>
    <settings>
      <setting alwaysvectorfont="no" />
      <setting verticaltext="up" />
    </settings>
    <grid distance="0.1" unitdist="inch" unit="inch" style="lines" multiple="1" display="no" altdistance="0.01" altunitdist="inch" altunit="inch" />
    <layers>
      <layer number="91" name="Nets" color="2" fill="1" visible="yes" active="yes" />
      <layer number="92" name="Busses" color="1" fill="1" visible="yes" active="yes" />
      <layer number="93" name="Pins" color="2" fill="1" visible="yes" active="yes" />
      <layer number="94" name="Symbols" color="4" fill="1" visible="yes" active="yes" />
      <layer number="95" name="Names" color="7" fill="1" visible="yes" active="yes" />
      <layer number="96" name="Values" color="7" fill="1" visible="yes" active="yes" />
      <layer number="97" name="Info" color="7" fill="1" visible="yes" active="yes" />
      <layer number="98" name="Guide" color="6" fill="1" visible="yes" active="yes" />
    </layers>
    <schematic xreflabel="%F%N/%S.%C%R" xrefpart="/ %S.%C%R">
      <libraries>
        <library name="DragonModules">
          <description>Logical module terminals; assign verified footprints before PCB layout.</description>
          <packages />
          <symbols>
            <symbol name="ESP32_S3">
              <wire x1="0" y1="0" x2="30.48" y2="0" width="0.254" layer="94" />
              <wire x1="30.48" y1="0" x2="30.48" y2="20.32" width="0.254" layer="94" />
              <wire x1="30.48" y1="20.32" x2="0" y2="20.32" width="0.254" layer="94" />
              <wire x1="0" y1="20.32" x2="0" y2="0" width="0.254" layer="94" />
              <text x="0" y="22.86" size="1.778" layer="95">&gt;NAME</text>
              <text x="0" y="-3.81" size="1.27" layer="96">&gt;VALUE</text>
              <pin name="5V" x="-5.08" y="17.78" visible="pin" length="middle" direction="pas" rot="R0" />
              <pin name="3V3" x="-5.08" y="15.24" visible="pin" length="middle" direction="pas" rot="R0" />
              <pin name="GND" x="-5.08" y="12.7" visible="pin" length="middle" direction="pas" rot="R0" />
              <pin name="GPIO12" x="-5.08" y="10.16" visible="pin" length="middle" direction="pas" rot="R0" />
              <pin name="GPIO11" x="-5.08" y="7.620000000000001" visible="pin" length="middle" direction="pas" rot="R0" />
              <pin name="GPIO9" x="-5.08" y="5.08" visible="pin" length="middle" direction="pas" rot="R0" />
              <pin name="GPIO10" x="-5.08" y="2.539999999999999" visible="pin" length="middle" direction="pas" rot="R0" />
            </symbol>
            <symbol name="MATRIX">
              <wire x1="0" y1="0" x2="30.48" y2="0" width="0.254" layer="94" />
              <wire x1="30.48" y1="0" x2="30.48" y2="10.16" width="0.254" layer="94" />
              <wire x1="30.48" y1="10.16" x2="0" y2="10.16" width="0.254" layer="94" />
              <wire x1="0" y1="10.16" x2="0" y2="0" width="0.254" layer="94" />
              <text x="0" y="12.7" size="1.778" layer="95">&gt;NAME</text>
              <text x="0" y="-3.81" size="1.27" layer="96">&gt;VALUE</text>
              <pin name="5V" x="-5.08" y="7.62" visible="pin" length="middle" direction="pas" rot="R0" />
              <pin name="GND" x="-5.08" y="5.08" visible="pin" length="middle" direction="pas" rot="R0" />
              <pin name="DIN" x="-5.08" y="2.54" visible="pin" length="middle" direction="pas" rot="R0" />
            </symbol>
            <symbol name="TTP223">
              <wire x1="0" y1="0" x2="30.48" y2="0" width="0.254" layer="94" />
              <wire x1="30.48" y1="0" x2="30.48" y2="10.16" width="0.254" layer="94" />
              <wire x1="30.48" y1="10.16" x2="0" y2="10.16" width="0.254" layer="94" />
              <wire x1="0" y1="10.16" x2="0" y2="0" width="0.254" layer="94" />
              <text x="0" y="12.7" size="1.778" layer="95">&gt;NAME</text>
              <text x="0" y="-3.81" size="1.27" layer="96">&gt;VALUE</text>
              <pin name="VCC" x="-5.08" y="7.62" visible="pin" length="middle" direction="pas" rot="R0" />
              <pin name="GND" x="-5.08" y="5.08" visible="pin" length="middle" direction="pas" rot="R0" />
              <pin name="OUT" x="-5.08" y="2.54" visible="pin" length="middle" direction="pas" rot="R0" />
            </symbol>
            <symbol name="USB_C_BREAKOUT">
              <wire x1="0" y1="0" x2="30.48" y2="0" width="0.254" layer="94" />
              <wire x1="30.48" y1="0" x2="30.48" y2="7.62" width="0.254" layer="94" />
              <wire x1="30.48" y1="7.62" x2="0" y2="7.62" width="0.254" layer="94" />
              <wire x1="0" y1="7.62" x2="0" y2="0" width="0.254" layer="94" />
              <text x="0" y="10.16" size="1.778" layer="95">&gt;NAME</text>
              <text x="0" y="-3.81" size="1.27" layer="96">&gt;VALUE</text>
              <pin name="VBUS" x="-5.08" y="5.08" visible="pin" length="middle" direction="pas" rot="R0" />
              <pin name="GND" x="-5.08" y="2.54" visible="pin" length="middle" direction="pas" rot="R0" />
            </symbol>
            <symbol name="RESISTOR">
              <wire x1="0" y1="0" x2="30.48" y2="0" width="0.254" layer="94" />
              <wire x1="30.48" y1="0" x2="30.48" y2="7.62" width="0.254" layer="94" />
              <wire x1="30.48" y1="7.62" x2="0" y2="7.62" width="0.254" layer="94" />
              <wire x1="0" y1="7.62" x2="0" y2="0" width="0.254" layer="94" />
              <text x="0" y="10.16" size="1.778" layer="95">&gt;NAME</text>
              <text x="0" y="-3.81" size="1.27" layer="96">&gt;VALUE</text>
              <pin name="1" x="-5.08" y="5.08" visible="pin" length="middle" direction="pas" rot="R0" />
              <pin name="2" x="-5.08" y="2.54" visible="pin" length="middle" direction="pas" rot="R0" />
            </symbol>
            <symbol name="CAPACITOR">
              <wire x1="0" y1="0" x2="30.48" y2="0" width="0.254" layer="94" />
              <wire x1="30.48" y1="0" x2="30.48" y2="7.62" width="0.254" layer="94" />
              <wire x1="30.48" y1="7.62" x2="0" y2="7.62" width="0.254" layer="94" />
              <wire x1="0" y1="7.62" x2="0" y2="0" width="0.254" layer="94" />
              <text x="0" y="10.16" size="1.778" layer="95">&gt;NAME</text>
              <text x="0" y="-3.81" size="1.27" layer="96">&gt;VALUE</text>
              <pin name="1" x="-5.08" y="5.08" visible="pin" length="middle" direction="pas" rot="R0" />
              <pin name="2" x="-5.08" y="2.54" visible="pin" length="middle" direction="pas" rot="R0" />
            </symbol>
            <symbol name="ELECTROLYTIC">
              <wire x1="0" y1="0" x2="30.48" y2="0" width="0.254" layer="94" />
              <wire x1="30.48" y1="0" x2="30.48" y2="7.62" width="0.254" layer="94" />
              <wire x1="30.48" y1="7.62" x2="0" y2="7.62" width="0.254" layer="94" />
              <wire x1="0" y1="7.62" x2="0" y2="0" width="0.254" layer="94" />
              <text x="0" y="10.16" size="1.778" layer="95">&gt;NAME</text>
              <text x="0" y="-3.81" size="1.27" layer="96">&gt;VALUE</text>
              <pin name="PLUS" x="-5.08" y="5.08" visible="pin" length="middle" direction="pas" rot="R0" />
              <pin name="MINUS" x="-5.08" y="2.54" visible="pin" length="middle" direction="pas" rot="R0" />
            </symbol>
            <symbol name="LDR">
              <wire x1="0" y1="0" x2="30.48" y2="0" width="0.254" layer="94" />
              <wire x1="30.48" y1="0" x2="30.48" y2="7.62" width="0.254" layer="94" />
              <wire x1="30.48" y1="7.62" x2="0" y2="7.62" width="0.254" layer="94" />
              <wire x1="0" y1="7.62" x2="0" y2="0" width="0.254" layer="94" />
              <text x="0" y="10.16" size="1.778" layer="95">&gt;NAME</text>
              <text x="0" y="-3.81" size="1.27" layer="96">&gt;VALUE</text>
              <pin name="1" x="-5.08" y="5.08" visible="pin" length="middle" direction="pas" rot="R0" />
              <pin name="2" x="-5.08" y="2.54" visible="pin" length="middle" direction="pas" rot="R0" />
            </symbol>
          </symbols>
          <devicesets>
            <deviceset name="ESP32_S3" prefix="X" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="ESP32_S3" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="MATRIX" prefix="X" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="MATRIX" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="TTP223" prefix="X" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="TTP223" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="USB_C_BREAKOUT" prefix="X" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="USB_C_BREAKOUT" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="RESISTOR" prefix="X" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="RESISTOR" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="CAPACITOR" prefix="X" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="CAPACITOR" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="ELECTROLYTIC" prefix="X" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="ELECTROLYTIC" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="LDR" prefix="X" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="LDR" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
          </devicesets>
        </library>
      </libraries>
      <attributes />
      <variantdefs />
      <classes>
        <class number="0" name="default" width="0" drill="0">
          <clearance class="0" value="0.254" />
        </class>
      </classes>
      <parts>
        <part name="U1" library="DragonModules" deviceset="ESP32_S3" device="" value="ESP32-S3 module" />
        <part name="J1" library="DragonModules" deviceset="USB_C_BREAKOUT" device="" value="External 5V breakout" />
        <part name="M1" library="DragonModules" deviceset="MATRIX" device="" value="WS2812B 8x8" />
        <part name="R1" library="DragonModules" deviceset="RESISTOR" device="" value="330R recommended" />
        <part name="C1" library="DragonModules" deviceset="ELECTROLYTIC" device="" value="1000uF / 10V" />
        <part name="U2" library="DragonModules" deviceset="TTP223" device="" value="TTP223 / active-high momentary" />
        <part name="C2" library="DragonModules" deviceset="CAPACITOR" device="" value="100nF near TTP223" />
        <part name="LDR1" library="DragonModules" deviceset="LDR" device="" value="Photosensitive resistor" />
        <part name="R2" library="DragonModules" deviceset="RESISTOR" device="" value="10k" />
        <part name="C3" library="DragonModules" deviceset="CAPACITOR" device="" value="100nF optional LDR filter" />
        <part name="R3" library="DragonModules" deviceset="RESISTOR" device="" value="100k / 1%" />
        <part name="R4" library="DragonModules" deviceset="RESISTOR" device="" value="20k / 1%" />
        <part name="C4" library="DragonModules" deviceset="CAPACITOR" device="" value="100nF near GPIO10" />
      </parts>
      <sheets>
        <sheet>
          <plain>
            <text x="0" y="100" size="2" layer="97">DRAGON LAMP - EXPLICIT WIRES - GPIO12 MATRIX / GPIO11 TOUCH / GPIO9 LDR / GPIO10 VOLTAGE</text>
            <text x="0" y="94" size="2" layer="97">Junction dots mean connected. Crossings without dots are not connected. Module symbols have no PCB footprints.</text>
            <text x="0" y="-50" size="2" layer="97">Use external J1 power OR ESP32 USB power; no simultaneous supplies without isolation. J1 has onboard CC resistors.</text>
            <text x="0" y="-56" size="2" layer="97">C1: PLUS to +5V, MINUS to GND. R3=100k upper; R4=20k lower. Supply sense is VBUS/6.</text>
            <text x="0" y="-62" size="2" layer="97">C2 bypasses touch supply; C3 is optional LDR filtering. PC detection requires native ESP32 USB data.</text>
          </plain>
          <moduleinsts />
          <instances>
            <instance part="U1" gate="G$1" x="30" y="50" smashed="no" />
            <instance part="J1" gate="G$1" x="95" y="50" smashed="no" />
            <instance part="M1" gate="G$1" x="160" y="50" smashed="no" />
            <instance part="R1" gate="G$1" x="225" y="50" smashed="no" />
            <instance part="C1" gate="G$1" x="290" y="50" smashed="no" />
            <instance part="U2" gate="G$1" x="355" y="50" smashed="no" />
            <instance part="C2" gate="G$1" x="420" y="50" smashed="no" />
            <instance part="LDR1" gate="G$1" x="485" y="50" smashed="no" />
            <instance part="R2" gate="G$1" x="550" y="50" smashed="no" />
            <instance part="C3" gate="G$1" x="615" y="50" smashed="no" />
            <instance part="R3" gate="G$1" x="680" y="50" smashed="no" />
            <instance part="R4" gate="G$1" x="745" y="50" smashed="no" />
            <instance part="C4" gate="G$1" x="810" y="50" smashed="no" />
          </instances>
          <busses />
          <nets>
            <net name="+5V" class="0">
              <segment>
                <wire x1="4.6" y1="0.0" x2="82.3" y2="0.0" width="0.254" layer="91" />
                <wire x1="82.3" y1="0.0" x2="144.76" y2="0.0" width="0.254" layer="91" />
                <wire x1="144.76" y1="0.0" x2="277.3" y2="0.0" width="0.254" layer="91" />
                <wire x1="277.3" y1="0.0" x2="667.3" y2="0.0" width="0.254" layer="91" />
                <pinref part="U1" gate="G$1" pin="5V" />
                <wire x1="24.92" y1="67.78" x2="4.6" y2="67.78" width="0.1524" layer="91" />
                <wire x1="4.6" y1="67.78" x2="4.6" y2="0.0" width="0.1524" layer="91" />
                <junction x="4.6" y="0.0" />
                <pinref part="J1" gate="G$1" pin="VBUS" />
                <wire x1="89.92" y1="55.08" x2="82.3" y2="55.08" width="0.1524" layer="91" />
                <wire x1="82.3" y1="55.08" x2="82.3" y2="0.0" width="0.1524" layer="91" />
                <junction x="82.3" y="0.0" />
                <pinref part="M1" gate="G$1" pin="5V" />
                <wire x1="154.92" y1="57.62" x2="144.76" y2="57.62" width="0.1524" layer="91" />
                <wire x1="144.76" y1="57.62" x2="144.76" y2="0.0" width="0.1524" layer="91" />
                <junction x="144.76" y="0.0" />
                <pinref part="C1" gate="G$1" pin="PLUS" />
                <wire x1="284.92" y1="55.08" x2="277.3" y2="55.08" width="0.1524" layer="91" />
                <wire x1="277.3" y1="55.08" x2="277.3" y2="0.0" width="0.1524" layer="91" />
                <junction x="277.3" y="0.0" />
                <pinref part="R3" gate="G$1" pin="1" />
                <wire x1="674.92" y1="55.08" x2="667.3" y2="55.08" width="0.1524" layer="91" />
                <wire x1="667.3" y1="55.08" x2="667.3" y2="0.0" width="0.1524" layer="91" />
                <junction x="667.3" y="0.0" />
                <label x="4.6" y="0.0" size="1.778" layer="95" />
              </segment>
            </net>
            <net name="+3V3" class="0">
              <segment>
                <wire x1="7.14" y1="-5.08" x2="339.76" y2="-5.08" width="0.254" layer="91" />
                <wire x1="339.76" y1="-5.08" x2="407.3" y2="-5.08" width="0.254" layer="91" />
                <wire x1="407.3" y1="-5.08" x2="472.3" y2="-5.08" width="0.254" layer="91" />
                <pinref part="U1" gate="G$1" pin="3V3" />
                <wire x1="24.92" y1="65.24" x2="7.14" y2="65.24" width="0.1524" layer="91" />
                <wire x1="7.14" y1="65.24" x2="7.14" y2="-5.08" width="0.1524" layer="91" />
                <junction x="7.14" y="-5.08" />
                <pinref part="U2" gate="G$1" pin="VCC" />
                <wire x1="349.92" y1="57.62" x2="339.76" y2="57.62" width="0.1524" layer="91" />
                <wire x1="339.76" y1="57.62" x2="339.76" y2="-5.08" width="0.1524" layer="91" />
                <junction x="339.76" y="-5.08" />
                <pinref part="C2" gate="G$1" pin="1" />
                <wire x1="414.92" y1="55.08" x2="407.3" y2="55.08" width="0.1524" layer="91" />
                <wire x1="407.3" y1="55.08" x2="407.3" y2="-5.08" width="0.1524" layer="91" />
                <junction x="407.3" y="-5.08" />
                <pinref part="LDR1" gate="G$1" pin="1" />
                <wire x1="479.92" y1="55.08" x2="472.3" y2="55.08" width="0.1524" layer="91" />
                <wire x1="472.3" y1="55.08" x2="472.3" y2="-5.08" width="0.1524" layer="91" />
                <junction x="472.3" y="-5.08" />
                <label x="7.14" y="-5.08" size="1.778" layer="95" />
              </segment>
            </net>
            <net name="GND" class="0">
              <segment>
                <wire x1="9.68" y1="-10.16" x2="84.84" y2="-10.16" width="0.254" layer="91" />
                <wire x1="84.84" y1="-10.16" x2="147.3" y2="-10.16" width="0.254" layer="91" />
                <wire x1="147.3" y1="-10.16" x2="279.84" y2="-10.16" width="0.254" layer="91" />
                <wire x1="279.84" y1="-10.16" x2="342.3" y2="-10.16" width="0.254" layer="91" />
                <wire x1="342.3" y1="-10.16" x2="409.84" y2="-10.16" width="0.254" layer="91" />
                <wire x1="409.84" y1="-10.16" x2="539.84" y2="-10.16" width="0.254" layer="91" />
                <wire x1="539.84" y1="-10.16" x2="604.84" y2="-10.16" width="0.254" layer="91" />
                <wire x1="604.84" y1="-10.16" x2="734.84" y2="-10.16" width="0.254" layer="91" />
                <wire x1="734.84" y1="-10.16" x2="799.84" y2="-10.16" width="0.254" layer="91" />
                <pinref part="U1" gate="G$1" pin="GND" />
                <wire x1="24.92" y1="62.7" x2="9.68" y2="62.7" width="0.1524" layer="91" />
                <wire x1="9.68" y1="62.7" x2="9.68" y2="-10.16" width="0.1524" layer="91" />
                <junction x="9.68" y="-10.16" />
                <pinref part="J1" gate="G$1" pin="GND" />
                <wire x1="89.92" y1="52.54" x2="84.84" y2="52.54" width="0.1524" layer="91" />
                <wire x1="84.84" y1="52.54" x2="84.84" y2="-10.16" width="0.1524" layer="91" />
                <junction x="84.84" y="-10.16" />
                <pinref part="M1" gate="G$1" pin="GND" />
                <wire x1="154.92" y1="55.08" x2="147.3" y2="55.08" width="0.1524" layer="91" />
                <wire x1="147.3" y1="55.08" x2="147.3" y2="-10.16" width="0.1524" layer="91" />
                <junction x="147.3" y="-10.16" />
                <pinref part="C1" gate="G$1" pin="MINUS" />
                <wire x1="284.92" y1="52.54" x2="279.84" y2="52.54" width="0.1524" layer="91" />
                <wire x1="279.84" y1="52.54" x2="279.84" y2="-10.16" width="0.1524" layer="91" />
                <junction x="279.84" y="-10.16" />
                <pinref part="U2" gate="G$1" pin="GND" />
                <wire x1="349.92" y1="55.08" x2="342.3" y2="55.08" width="0.1524" layer="91" />
                <wire x1="342.3" y1="55.08" x2="342.3" y2="-10.16" width="0.1524" layer="91" />
                <junction x="342.3" y="-10.16" />
                <pinref part="C2" gate="G$1" pin="2" />
                <wire x1="414.92" y1="52.54" x2="409.84" y2="52.54" width="0.1524" layer="91" />
                <wire x1="409.84" y1="52.54" x2="409.84" y2="-10.16" width="0.1524" layer="91" />
                <junction x="409.84" y="-10.16" />
                <pinref part="R2" gate="G$1" pin="2" />
                <wire x1="544.92" y1="52.54" x2="539.84" y2="52.54" width="0.1524" layer="91" />
                <wire x1="539.84" y1="52.54" x2="539.84" y2="-10.16" width="0.1524" layer="91" />
                <junction x="539.84" y="-10.16" />
                <pinref part="C3" gate="G$1" pin="2" />
                <wire x1="609.92" y1="52.54" x2="604.84" y2="52.54" width="0.1524" layer="91" />
                <wire x1="604.84" y1="52.54" x2="604.84" y2="-10.16" width="0.1524" layer="91" />
                <junction x="604.84" y="-10.16" />
                <pinref part="R4" gate="G$1" pin="2" />
                <wire x1="739.92" y1="52.54" x2="734.84" y2="52.54" width="0.1524" layer="91" />
                <wire x1="734.84" y1="52.54" x2="734.84" y2="-10.16" width="0.1524" layer="91" />
                <junction x="734.84" y="-10.16" />
                <pinref part="C4" gate="G$1" pin="2" />
                <wire x1="804.92" y1="52.54" x2="799.84" y2="52.54" width="0.1524" layer="91" />
                <wire x1="799.84" y1="52.54" x2="799.84" y2="-10.16" width="0.1524" layer="91" />
                <junction x="799.84" y="-10.16" />
                <label x="9.68" y="-10.16" size="1.778" layer="95" />
              </segment>
            </net>
            <net name="LED_DATA" class="0">
              <segment>
                <wire x1="12.22" y1="-15.24" x2="212.3" y2="-15.24" width="0.254" layer="91" />
                <pinref part="U1" gate="G$1" pin="GPIO12" />
                <wire x1="24.92" y1="60.16" x2="12.22" y2="60.16" width="0.1524" layer="91" />
                <wire x1="12.22" y1="60.16" x2="12.22" y2="-15.24" width="0.1524" layer="91" />
                <junction x="12.22" y="-15.24" />
                <pinref part="R1" gate="G$1" pin="1" />
                <wire x1="219.92" y1="55.08" x2="212.3" y2="55.08" width="0.1524" layer="91" />
                <wire x1="212.3" y1="55.08" x2="212.3" y2="-15.24" width="0.1524" layer="91" />
                <junction x="212.3" y="-15.24" />
                <label x="12.22" y="-15.24" size="1.778" layer="95" />
              </segment>
            </net>
            <net name="TOUCH_OUT" class="0">
              <segment>
                <wire x1="14.76" y1="-20.32" x2="344.84" y2="-20.32" width="0.254" layer="91" />
                <pinref part="U1" gate="G$1" pin="GPIO11" />
                <wire x1="24.92" y1="57.62" x2="14.76" y2="57.62" width="0.1524" layer="91" />
                <wire x1="14.76" y1="57.62" x2="14.76" y2="-20.32" width="0.1524" layer="91" />
                <junction x="14.76" y="-20.32" />
                <pinref part="U2" gate="G$1" pin="OUT" />
                <wire x1="349.92" y1="52.54" x2="344.84" y2="52.54" width="0.1524" layer="91" />
                <wire x1="344.84" y1="52.54" x2="344.84" y2="-20.32" width="0.1524" layer="91" />
                <junction x="344.84" y="-20.32" />
                <label x="14.76" y="-20.32" size="1.778" layer="95" />
              </segment>
            </net>
            <net name="LDR_ADC" class="0">
              <segment>
                <wire x1="17.3" y1="-25.4" x2="474.84" y2="-25.4" width="0.254" layer="91" />
                <wire x1="474.84" y1="-25.4" x2="537.3" y2="-25.4" width="0.254" layer="91" />
                <wire x1="537.3" y1="-25.4" x2="602.3" y2="-25.4" width="0.254" layer="91" />
                <pinref part="U1" gate="G$1" pin="GPIO9" />
                <wire x1="24.92" y1="55.08" x2="17.3" y2="55.08" width="0.1524" layer="91" />
                <wire x1="17.3" y1="55.08" x2="17.3" y2="-25.4" width="0.1524" layer="91" />
                <junction x="17.3" y="-25.4" />
                <pinref part="LDR1" gate="G$1" pin="2" />
                <wire x1="479.92" y1="52.54" x2="474.84" y2="52.54" width="0.1524" layer="91" />
                <wire x1="474.84" y1="52.54" x2="474.84" y2="-25.4" width="0.1524" layer="91" />
                <junction x="474.84" y="-25.4" />
                <pinref part="R2" gate="G$1" pin="1" />
                <wire x1="544.92" y1="55.08" x2="537.3" y2="55.08" width="0.1524" layer="91" />
                <wire x1="537.3" y1="55.08" x2="537.3" y2="-25.4" width="0.1524" layer="91" />
                <junction x="537.3" y="-25.4" />
                <pinref part="C3" gate="G$1" pin="1" />
                <wire x1="609.92" y1="55.08" x2="602.3" y2="55.08" width="0.1524" layer="91" />
                <wire x1="602.3" y1="55.08" x2="602.3" y2="-25.4" width="0.1524" layer="91" />
                <junction x="602.3" y="-25.4" />
                <label x="17.3" y="-25.4" size="1.778" layer="95" />
              </segment>
            </net>
            <net name="VBUS_ADC" class="0">
              <segment>
                <wire x1="19.84" y1="-30.48" x2="669.84" y2="-30.48" width="0.254" layer="91" />
                <wire x1="669.84" y1="-30.48" x2="732.3" y2="-30.48" width="0.254" layer="91" />
                <wire x1="732.3" y1="-30.48" x2="797.3" y2="-30.48" width="0.254" layer="91" />
                <pinref part="U1" gate="G$1" pin="GPIO10" />
                <wire x1="24.92" y1="52.54" x2="19.84" y2="52.54" width="0.1524" layer="91" />
                <wire x1="19.84" y1="52.54" x2="19.84" y2="-30.48" width="0.1524" layer="91" />
                <junction x="19.84" y="-30.48" />
                <pinref part="R3" gate="G$1" pin="2" />
                <wire x1="674.92" y1="52.54" x2="669.84" y2="52.54" width="0.1524" layer="91" />
                <wire x1="669.84" y1="52.54" x2="669.84" y2="-30.48" width="0.1524" layer="91" />
                <junction x="669.84" y="-30.48" />
                <pinref part="R4" gate="G$1" pin="1" />
                <wire x1="739.92" y1="55.08" x2="732.3" y2="55.08" width="0.1524" layer="91" />
                <wire x1="732.3" y1="55.08" x2="732.3" y2="-30.48" width="0.1524" layer="91" />
                <junction x="732.3" y="-30.48" />
                <pinref part="C4" gate="G$1" pin="1" />
                <wire x1="804.92" y1="55.08" x2="797.3" y2="55.08" width="0.1524" layer="91" />
                <wire x1="797.3" y1="55.08" x2="797.3" y2="-30.48" width="0.1524" layer="91" />
                <junction x="797.3" y="-30.48" />
                <label x="19.84" y="-30.48" size="1.778" layer="95" />
              </segment>
            </net>
            <net name="LED_DIN" class="0">
              <segment>
                <wire x1="149.84" y1="-35.56" x2="214.84" y2="-35.56" width="0.254" layer="91" />
                <pinref part="M1" gate="G$1" pin="DIN" />
                <wire x1="154.92" y1="52.54" x2="149.84" y2="52.54" width="0.1524" layer="91" />
                <wire x1="149.84" y1="52.54" x2="149.84" y2="-35.56" width="0.1524" layer="91" />
                <junction x="149.84" y="-35.56" />
                <pinref part="R1" gate="G$1" pin="2" />
                <wire x1="219.92" y1="52.54" x2="214.84" y2="52.54" width="0.1524" layer="91" />
                <wire x1="214.84" y1="52.54" x2="214.84" y2="-35.56" width="0.1524" layer="91" />
                <junction x="214.84" y="-35.56" />
                <label x="149.84" y="-35.56" size="1.778" layer="95" />
              </segment>
            </net>
          </nets>
        </sheet>
      </sheets>
      <errors />
    </schematic>
  </drawing>
</eagle>