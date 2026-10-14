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
            <text x="0" y="195" size="1.778" layer="97">DRAGON LAMP | GPIO12 MATRIX / GPIO11 TOUCH / GPIO9 LDR / GPIO10 VOLTAGE</text>
            <text x="0" y="188" size="1.778" layer="97">Module wiring schematic. Named nets join every matching label. No PCB footprints assigned.</text>
            <text x="0" y="15" size="1.778" layer="97">J1 represents the existing USB-C breakout: onboard CC1/CC2 each have 5.1k to GND; D+/D- unused.</text>
            <text x="0" y="10" size="1.778" layer="97">Use external J1 power OR ESP32 USB power. Do not connect both powered sources without isolation.</text>
            <text x="0" y="5" size="1.778" layer="97">1000uF polarity: PLUS to +5V, MINUS to GND. Divider: 100k upper / 20k lower; 5V gives 0.833V.</text>
            <text x="0" y="0" size="1.778" layer="97">PC detection requires a data cable to ESP32 native USB. A power-only breakout cannot signal a PC host.</text>
          </plain>
          <moduleinsts />
          <instances>
            <instance part="U1" gate="G$1" x="25" y="145" smashed="no" />
            <instance part="J1" gate="G$1" x="25" y="95" smashed="no" />
            <instance part="M1" gate="G$1" x="100" y="150" smashed="no" />
            <instance part="R1" gate="G$1" x="100" y="110" smashed="no" />
            <instance part="C1" gate="G$1" x="100" y="65" smashed="no" />
            <instance part="U2" gate="G$1" x="175" y="150" smashed="no" />
            <instance part="C2" gate="G$1" x="175" y="110" smashed="no" />
            <instance part="LDR1" gate="G$1" x="250" y="150" smashed="no" />
            <instance part="R2" gate="G$1" x="250" y="110" smashed="no" />
            <instance part="C3" gate="G$1" x="250" y="65" smashed="no" />
            <instance part="R3" gate="G$1" x="325" y="150" smashed="no" />
            <instance part="R4" gate="G$1" x="325" y="110" smashed="no" />
            <instance part="C4" gate="G$1" x="325" y="65" smashed="no" />
          </instances>
          <busses />
          <nets>
            <net name="+5V" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="5V" />
                <wire x1="7.220000000000002" y1="162.78" x2="19.92" y2="162.78" width="0.1524" layer="91" />
                <label x="7.220000000000002" y="162.78" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J1" gate="G$1" pin="VBUS" />
                <wire x1="7.220000000000002" y1="100.08" x2="19.92" y2="100.08" width="0.1524" layer="91" />
                <label x="7.220000000000002" y="100.08" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="M1" gate="G$1" pin="5V" />
                <wire x1="82.22" y1="157.62" x2="94.92" y2="157.62" width="0.1524" layer="91" />
                <label x="82.22" y="157.62" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="C1" gate="G$1" pin="PLUS" />
                <wire x1="82.22" y1="70.08" x2="94.92" y2="70.08" width="0.1524" layer="91" />
                <label x="82.22" y="70.08" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="R3" gate="G$1" pin="1" />
                <wire x1="307.22" y1="155.08" x2="319.92" y2="155.08" width="0.1524" layer="91" />
                <label x="307.22" y="155.08" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="+3V3" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="3V3" />
                <wire x1="7.220000000000002" y1="160.24" x2="19.92" y2="160.24" width="0.1524" layer="91" />
                <label x="7.220000000000002" y="160.24" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="U2" gate="G$1" pin="VCC" />
                <wire x1="157.22" y1="157.62" x2="169.92" y2="157.62" width="0.1524" layer="91" />
                <label x="157.22" y="157.62" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="C2" gate="G$1" pin="1" />
                <wire x1="157.22" y1="115.08" x2="169.92" y2="115.08" width="0.1524" layer="91" />
                <label x="157.22" y="115.08" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="LDR1" gate="G$1" pin="1" />
                <wire x1="232.22" y1="155.08" x2="244.92" y2="155.08" width="0.1524" layer="91" />
                <label x="232.22" y="155.08" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="GND" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GND" />
                <wire x1="7.220000000000002" y1="157.7" x2="19.92" y2="157.7" width="0.1524" layer="91" />
                <label x="7.220000000000002" y="157.7" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J1" gate="G$1" pin="GND" />
                <wire x1="7.220000000000002" y1="97.54" x2="19.92" y2="97.54" width="0.1524" layer="91" />
                <label x="7.220000000000002" y="97.54" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="M1" gate="G$1" pin="GND" />
                <wire x1="82.22" y1="155.08" x2="94.92" y2="155.08" width="0.1524" layer="91" />
                <label x="82.22" y="155.08" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="C1" gate="G$1" pin="MINUS" />
                <wire x1="82.22" y1="67.54" x2="94.92" y2="67.54" width="0.1524" layer="91" />
                <label x="82.22" y="67.54" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="U2" gate="G$1" pin="GND" />
                <wire x1="157.22" y1="155.08" x2="169.92" y2="155.08" width="0.1524" layer="91" />
                <label x="157.22" y="155.08" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="C2" gate="G$1" pin="2" />
                <wire x1="157.22" y1="112.54" x2="169.92" y2="112.54" width="0.1524" layer="91" />
                <label x="157.22" y="112.54" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="R2" gate="G$1" pin="2" />
                <wire x1="232.22" y1="112.54" x2="244.92" y2="112.54" width="0.1524" layer="91" />
                <label x="232.22" y="112.54" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="C3" gate="G$1" pin="2" />
                <wire x1="232.22" y1="67.54" x2="244.92" y2="67.54" width="0.1524" layer="91" />
                <label x="232.22" y="67.54" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="R4" gate="G$1" pin="2" />
                <wire x1="307.22" y1="112.54" x2="319.92" y2="112.54" width="0.1524" layer="91" />
                <label x="307.22" y="112.54" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="C4" gate="G$1" pin="2" />
                <wire x1="307.22" y1="67.54" x2="319.92" y2="67.54" width="0.1524" layer="91" />
                <label x="307.22" y="67.54" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="LED_DATA" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO12" />
                <wire x1="7.220000000000002" y1="155.16" x2="19.92" y2="155.16" width="0.1524" layer="91" />
                <label x="7.220000000000002" y="155.16" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="R1" gate="G$1" pin="1" />
                <wire x1="82.22" y1="115.08" x2="94.92" y2="115.08" width="0.1524" layer="91" />
                <label x="82.22" y="115.08" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="TOUCH_OUT" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO11" />
                <wire x1="7.220000000000002" y1="152.62" x2="19.92" y2="152.62" width="0.1524" layer="91" />
                <label x="7.220000000000002" y="152.62" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="U2" gate="G$1" pin="OUT" />
                <wire x1="157.22" y1="152.54" x2="169.92" y2="152.54" width="0.1524" layer="91" />
                <label x="157.22" y="152.54" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="LDR_ADC" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO9" />
                <wire x1="7.220000000000002" y1="150.08" x2="19.92" y2="150.08" width="0.1524" layer="91" />
                <label x="7.220000000000002" y="150.08" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="LDR1" gate="G$1" pin="2" />
                <wire x1="232.22" y1="152.54" x2="244.92" y2="152.54" width="0.1524" layer="91" />
                <label x="232.22" y="152.54" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="R2" gate="G$1" pin="1" />
                <wire x1="232.22" y1="115.08" x2="244.92" y2="115.08" width="0.1524" layer="91" />
                <label x="232.22" y="115.08" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="C3" gate="G$1" pin="1" />
                <wire x1="232.22" y1="70.08" x2="244.92" y2="70.08" width="0.1524" layer="91" />
                <label x="232.22" y="70.08" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="VBUS_ADC" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO10" />
                <wire x1="7.220000000000002" y1="147.54" x2="19.92" y2="147.54" width="0.1524" layer="91" />
                <label x="7.220000000000002" y="147.54" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="R3" gate="G$1" pin="2" />
                <wire x1="307.22" y1="152.54" x2="319.92" y2="152.54" width="0.1524" layer="91" />
                <label x="307.22" y="152.54" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="R4" gate="G$1" pin="1" />
                <wire x1="307.22" y1="115.08" x2="319.92" y2="115.08" width="0.1524" layer="91" />
                <label x="307.22" y="115.08" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="C4" gate="G$1" pin="1" />
                <wire x1="307.22" y1="70.08" x2="319.92" y2="70.08" width="0.1524" layer="91" />
                <label x="307.22" y="70.08" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="LED_DIN" class="0">
              <segment>
                <pinref part="M1" gate="G$1" pin="DIN" />
                <wire x1="82.22" y1="152.54" x2="94.92" y2="152.54" width="0.1524" layer="91" />
                <label x="82.22" y="152.54" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="R1" gate="G$1" pin="2" />
                <wire x1="82.22" y1="112.54" x2="94.92" y2="112.54" width="0.1524" layer="91" />
                <label x="82.22" y="112.54" size="1.27" layer="95" />
              </segment>
            </net>
          </nets>
        </sheet>
      </sheets>
      <errors />
    </schematic>
  </drawing>
</eagle>