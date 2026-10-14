<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE eagle SYSTEM "eagle.dtd">
<eagle version="9.6.2">
  <drawing>
    <settings>
      <setting alwaysvectorfont="no" />
      <setting verticaltext="up" />
    </settings>
    <grid distance="0.05" unitdist="inch" unit="inch" style="lines" multiple="1" display="no" altdistance="0.025" altunitdist="inch" altunit="inch" />
    <layers>
      <layer number="1" name="Top" color="4" fill="1" visible="yes" active="yes" />
      <layer number="16" name="Bottom" color="1" fill="1" visible="yes" active="yes" />
      <layer number="17" name="Pads" color="2" fill="1" visible="yes" active="yes" />
      <layer number="20" name="Dimension" color="15" fill="1" visible="yes" active="yes" />
      <layer number="21" name="tPlace" color="7" fill="1" visible="yes" active="yes" />
      <layer number="25" name="tNames" color="7" fill="1" visible="yes" active="yes" />
      <layer number="27" name="tValues" color="7" fill="1" visible="yes" active="yes" />
      <layer number="29" name="tStop" color="7" fill="1" visible="yes" active="yes" />
      <layer number="30" name="bStop" color="7" fill="1" visible="yes" active="yes" />
      <layer number="51" name="tDocu" color="7" fill="1" visible="yes" active="yes" />
      <layer number="91" name="Nets" color="2" fill="1" visible="yes" active="yes" />
      <layer number="92" name="Busses" color="1" fill="1" visible="yes" active="yes" />
      <layer number="93" name="Pins" color="2" fill="1" visible="yes" active="yes" />
      <layer number="94" name="Symbols" color="4" fill="1" visible="yes" active="yes" />
      <layer number="95" name="Names" color="7" fill="1" visible="yes" active="yes" />
      <layer number="96" name="Values" color="7" fill="1" visible="yes" active="yes" />
      <layer number="97" name="Info" color="7" fill="1" visible="yes" active="yes" />
      <layer number="98" name="Guide" color="6" fill="1" visible="yes" active="yes" />
    </layers>
    <schematic xreflabel="%F%N/%S.%C%R" xrefpart="/%S.%C%R">
      <libraries>
        <library name="Dragon_KiCad_Official">
          <description>Converted official KiCad 8.0.0 symbols; see included license. Module connectors are logical wiring terminals.</description>
          <packages>
            <package name="R_VERTICAL_P2.54">
              <description>Provisional through-hole footprint: verify actual component dimensions. Header pin order is the schematic harness order.</description>
              <circle x="-1.27" y="0" radius="1.25" width="0.15" layer="21" />
              <pad name="1" x="-1.27" y="0" drill="0.9" diameter="1.8" shape="square" />
              <pad name="2" x="1.27" y="0" drill="0.9" diameter="1.8" shape="round" />
              <text x="-2" y="6" size="1.27" layer="25">&gt;NAME</text>
              <text x="-2" y="-7" size="1.27" layer="27">&gt;VALUE</text>
            </package>
            <package name="C_DISC_P5.00">
              <description>Provisional through-hole footprint: verify actual component dimensions. Header pin order is the schematic harness order.</description>
              <wire x1="-2.5" y1="-1.25" x2="2.5" y2="-1.25" width="0.15" layer="21" />
              <wire x1="2.5" y1="-1.25" x2="2.5" y2="1.25" width="0.15" layer="21" />
              <wire x1="2.5" y1="1.25" x2="-2.5" y2="1.25" width="0.15" layer="21" />
              <wire x1="-2.5" y1="1.25" x2="-2.5" y2="-1.25" width="0.15" layer="21" />
              <pad name="1" x="-2.5" y="0" drill="0.9" diameter="1.8" shape="square" />
              <pad name="2" x="2.5" y="0" drill="0.9" diameter="1.8" shape="round" />
              <text x="-2" y="6" size="1.27" layer="25">&gt;NAME</text>
              <text x="-2" y="-7" size="1.27" layer="27">&gt;VALUE</text>
            </package>
            <package name="HEADER_1X2_P2.54">
              <description>Provisional through-hole footprint: verify actual component dimensions. Header pin order is the schematic harness order.</description>
              <wire x1="-1.27" y1="-1.27" x2="3.81" y2="-1.27" width="0.15" layer="21" />
              <wire x1="3.81" y1="-1.27" x2="3.81" y2="1.27" width="0.15" layer="21" />
              <wire x1="3.81" y1="1.27" x2="-1.27" y2="1.27" width="0.15" layer="21" />
              <wire x1="-1.27" y1="1.27" x2="-1.27" y2="-1.27" width="0.15" layer="21" />
              <pad name="1" x="0.0" y="0" drill="1" diameter="1.8" shape="square" />
              <pad name="2" x="2.54" y="0" drill="1" diameter="1.8" shape="round" />
              <text x="-2" y="6" size="1.27" layer="25">&gt;NAME</text>
              <text x="-2" y="-7" size="1.27" layer="27">&gt;VALUE</text>
            </package>
            <package name="HEADER_1X3_P2.54">
              <description>Provisional through-hole footprint: verify actual component dimensions. Header pin order is the schematic harness order.</description>
              <wire x1="-1.27" y1="-1.27" x2="6.35" y2="-1.27" width="0.15" layer="21" />
              <wire x1="6.35" y1="-1.27" x2="6.35" y2="1.27" width="0.15" layer="21" />
              <wire x1="6.35" y1="1.27" x2="-1.27" y2="1.27" width="0.15" layer="21" />
              <wire x1="-1.27" y1="1.27" x2="-1.27" y2="-1.27" width="0.15" layer="21" />
              <pad name="1" x="0.0" y="0" drill="1" diameter="1.8" shape="square" />
              <pad name="2" x="2.54" y="0" drill="1" diameter="1.8" shape="round" />
              <pad name="3" x="5.08" y="0" drill="1" diameter="1.8" shape="round" />
              <text x="-2" y="6" size="1.27" layer="25">&gt;NAME</text>
              <text x="-2" y="-7" size="1.27" layer="27">&gt;VALUE</text>
            </package>
            <package name="HEADER_1X8_P2.54">
              <description>Provisional through-hole footprint: verify actual component dimensions. Header pin order is the schematic harness order.</description>
              <wire x1="-1.27" y1="-1.27" x2="19.05" y2="-1.27" width="0.15" layer="21" />
              <wire x1="19.05" y1="-1.27" x2="19.05" y2="1.27" width="0.15" layer="21" />
              <wire x1="19.05" y1="1.27" x2="-1.27" y2="1.27" width="0.15" layer="21" />
              <wire x1="-1.27" y1="1.27" x2="-1.27" y2="-1.27" width="0.15" layer="21" />
              <pad name="1" x="0.0" y="0" drill="1" diameter="1.8" shape="square" />
              <pad name="2" x="2.54" y="0" drill="1" diameter="1.8" shape="round" />
              <pad name="3" x="5.08" y="0" drill="1" diameter="1.8" shape="round" />
              <pad name="4" x="7.62" y="0" drill="1" diameter="1.8" shape="round" />
              <pad name="5" x="10.16" y="0" drill="1" diameter="1.8" shape="round" />
              <pad name="6" x="12.7" y="0" drill="1" diameter="1.8" shape="round" />
              <pad name="7" x="15.24" y="0" drill="1" diameter="1.8" shape="round" />
              <pad name="8" x="17.78" y="0" drill="1" diameter="1.8" shape="round" />
              <text x="-2" y="6" size="1.27" layer="25">&gt;NAME</text>
              <text x="-2" y="-7" size="1.27" layer="27">&gt;VALUE</text>
            </package>
          </packages>
          <symbols>
            <symbol name="Device_R">
              <wire x1="-1.016" y1="-2.54" x2="-1.016" y2="2.54" width="0.254" layer="94" />
              <wire x1="-1.016" y1="2.54" x2="1.016" y2="2.54" width="0.254" layer="94" />
              <wire x1="1.016" y1="2.54" x2="1.016" y2="-2.54" width="0.254" layer="94" />
              <wire x1="1.016" y1="-2.54" x2="-1.016" y2="-2.54" width="0.254" layer="94" />
              <pin name="1" x="0" y="3.81" visible="off" length="point" direction="pas" rot="R270" />
              <wire x1="0" y1="3.81" x2="-0.0" y2="2.54" width="0.127" layer="94" />
              <pin name="2" x="0" y="-3.81" visible="off" length="point" direction="pas" rot="R90" />
              <wire x1="0" y1="-3.81" x2="0.0" y2="-2.54" width="0.127" layer="94" />
              <text x="4" y="2" size="1.27" layer="95">&gt;NAME</text>
              <text x="4" y="-1" size="1.27" layer="96">&gt;VALUE</text>
            </symbol>
            <symbol name="Device_C">
              <wire x1="-2.032" y1="-0.762" x2="2.032" y2="-0.762" width="0.508" layer="94" />
              <wire x1="-2.032" y1="0.762" x2="2.032" y2="0.762" width="0.508" layer="94" />
              <pin name="1" x="0" y="3.81" visible="off" length="point" direction="pas" rot="R270" />
              <wire x1="0" y1="3.81" x2="-0.0" y2="1.016" width="0.127" layer="94" />
              <pin name="2" x="0" y="-3.81" visible="off" length="point" direction="pas" rot="R90" />
              <wire x1="0" y1="-3.81" x2="0.0" y2="-1.016" width="0.127" layer="94" />
              <text x="4" y="2" size="1.27" layer="95">&gt;NAME</text>
              <text x="4" y="-1" size="1.27" layer="96">&gt;VALUE</text>
            </symbol>
            <symbol name="Connector_Generic_Conn_01x02">
              <wire x1="-1.27" y1="-2.413" x2="-1.27" y2="-2.667" width="0.1524" layer="94" />
              <wire x1="-1.27" y1="-2.667" x2="0.0" y2="-2.667" width="0.1524" layer="94" />
              <wire x1="0.0" y1="-2.667" x2="0.0" y2="-2.413" width="0.1524" layer="94" />
              <wire x1="0.0" y1="-2.413" x2="-1.27" y2="-2.413" width="0.1524" layer="94" />
              <wire x1="-1.27" y1="0.127" x2="-1.27" y2="-0.127" width="0.1524" layer="94" />
              <wire x1="-1.27" y1="-0.127" x2="0.0" y2="-0.127" width="0.1524" layer="94" />
              <wire x1="0.0" y1="-0.127" x2="0.0" y2="0.127" width="0.1524" layer="94" />
              <wire x1="0.0" y1="0.127" x2="-1.27" y2="0.127" width="0.1524" layer="94" />
              <wire x1="-1.27" y1="1.27" x2="-1.27" y2="-3.81" width="0.254" layer="94" />
              <wire x1="-1.27" y1="-3.81" x2="1.27" y2="-3.81" width="0.254" layer="94" />
              <wire x1="1.27" y1="-3.81" x2="1.27" y2="1.27" width="0.254" layer="94" />
              <wire x1="1.27" y1="1.27" x2="-1.27" y2="1.27" width="0.254" layer="94" />
              <pin name="1" x="-5.08" y="0" visible="off" length="point" direction="pas" rot="R0" />
              <wire x1="-5.08" y1="0" x2="-1.27" y2="0.0" width="0.127" layer="94" />
              <text x="-4.08" y="0.5" size="1.016" layer="95">1</text>
              <pin name="2" x="-5.08" y="-2.54" visible="off" length="point" direction="pas" rot="R0" />
              <wire x1="-5.08" y1="-2.54" x2="-1.27" y2="-2.54" width="0.127" layer="94" />
              <text x="-4.08" y="-2.04" size="1.016" layer="95">2</text>
              <text x="4" y="2" size="1.27" layer="95">&gt;NAME</text>
              <text x="4" y="-1" size="1.27" layer="96">&gt;VALUE</text>
            </symbol>
            <symbol name="Connector_Generic_Conn_01x03">
              <wire x1="-1.27" y1="-2.413" x2="-1.27" y2="-2.667" width="0.1524" layer="94" />
              <wire x1="-1.27" y1="-2.667" x2="0.0" y2="-2.667" width="0.1524" layer="94" />
              <wire x1="0.0" y1="-2.667" x2="0.0" y2="-2.413" width="0.1524" layer="94" />
              <wire x1="0.0" y1="-2.413" x2="-1.27" y2="-2.413" width="0.1524" layer="94" />
              <wire x1="-1.27" y1="0.127" x2="-1.27" y2="-0.127" width="0.1524" layer="94" />
              <wire x1="-1.27" y1="-0.127" x2="0.0" y2="-0.127" width="0.1524" layer="94" />
              <wire x1="0.0" y1="-0.127" x2="0.0" y2="0.127" width="0.1524" layer="94" />
              <wire x1="0.0" y1="0.127" x2="-1.27" y2="0.127" width="0.1524" layer="94" />
              <wire x1="-1.27" y1="2.667" x2="-1.27" y2="2.413" width="0.1524" layer="94" />
              <wire x1="-1.27" y1="2.413" x2="0.0" y2="2.413" width="0.1524" layer="94" />
              <wire x1="0.0" y1="2.413" x2="0.0" y2="2.667" width="0.1524" layer="94" />
              <wire x1="0.0" y1="2.667" x2="-1.27" y2="2.667" width="0.1524" layer="94" />
              <wire x1="-1.27" y1="3.81" x2="-1.27" y2="-3.81" width="0.254" layer="94" />
              <wire x1="-1.27" y1="-3.81" x2="1.27" y2="-3.81" width="0.254" layer="94" />
              <wire x1="1.27" y1="-3.81" x2="1.27" y2="3.81" width="0.254" layer="94" />
              <wire x1="1.27" y1="3.81" x2="-1.27" y2="3.81" width="0.254" layer="94" />
              <pin name="1" x="-5.08" y="2.54" visible="off" length="point" direction="pas" rot="R0" />
              <wire x1="-5.08" y1="2.54" x2="-1.27" y2="2.54" width="0.127" layer="94" />
              <text x="-4.08" y="3.04" size="1.016" layer="95">1</text>
              <pin name="2" x="-5.08" y="0" visible="off" length="point" direction="pas" rot="R0" />
              <wire x1="-5.08" y1="0" x2="-1.27" y2="0.0" width="0.127" layer="94" />
              <text x="-4.08" y="0.5" size="1.016" layer="95">2</text>
              <pin name="3" x="-5.08" y="-2.54" visible="off" length="point" direction="pas" rot="R0" />
              <wire x1="-5.08" y1="-2.54" x2="-1.27" y2="-2.54" width="0.127" layer="94" />
              <text x="-4.08" y="-2.04" size="1.016" layer="95">3</text>
              <text x="4" y="2" size="1.27" layer="95">&gt;NAME</text>
              <text x="4" y="-1" size="1.27" layer="96">&gt;VALUE</text>
            </symbol>
            <symbol name="Connector_Generic_Conn_01x08">
              <wire x1="-1.27" y1="-10.033" x2="-1.27" y2="-10.287" width="0.1524" layer="94" />
              <wire x1="-1.27" y1="-10.287" x2="0.0" y2="-10.287" width="0.1524" layer="94" />
              <wire x1="0.0" y1="-10.287" x2="0.0" y2="-10.033" width="0.1524" layer="94" />
              <wire x1="0.0" y1="-10.033" x2="-1.27" y2="-10.033" width="0.1524" layer="94" />
              <wire x1="-1.27" y1="-7.493" x2="-1.27" y2="-7.747" width="0.1524" layer="94" />
              <wire x1="-1.27" y1="-7.747" x2="0.0" y2="-7.747" width="0.1524" layer="94" />
              <wire x1="0.0" y1="-7.747" x2="0.0" y2="-7.493" width="0.1524" layer="94" />
              <wire x1="0.0" y1="-7.493" x2="-1.27" y2="-7.493" width="0.1524" layer="94" />
              <wire x1="-1.27" y1="-4.953" x2="-1.27" y2="-5.207" width="0.1524" layer="94" />
              <wire x1="-1.27" y1="-5.207" x2="0.0" y2="-5.207" width="0.1524" layer="94" />
              <wire x1="0.0" y1="-5.207" x2="0.0" y2="-4.953" width="0.1524" layer="94" />
              <wire x1="0.0" y1="-4.953" x2="-1.27" y2="-4.953" width="0.1524" layer="94" />
              <wire x1="-1.27" y1="-2.413" x2="-1.27" y2="-2.667" width="0.1524" layer="94" />
              <wire x1="-1.27" y1="-2.667" x2="0.0" y2="-2.667" width="0.1524" layer="94" />
              <wire x1="0.0" y1="-2.667" x2="0.0" y2="-2.413" width="0.1524" layer="94" />
              <wire x1="0.0" y1="-2.413" x2="-1.27" y2="-2.413" width="0.1524" layer="94" />
              <wire x1="-1.27" y1="0.127" x2="-1.27" y2="-0.127" width="0.1524" layer="94" />
              <wire x1="-1.27" y1="-0.127" x2="0.0" y2="-0.127" width="0.1524" layer="94" />
              <wire x1="0.0" y1="-0.127" x2="0.0" y2="0.127" width="0.1524" layer="94" />
              <wire x1="0.0" y1="0.127" x2="-1.27" y2="0.127" width="0.1524" layer="94" />
              <wire x1="-1.27" y1="2.667" x2="-1.27" y2="2.413" width="0.1524" layer="94" />
              <wire x1="-1.27" y1="2.413" x2="0.0" y2="2.413" width="0.1524" layer="94" />
              <wire x1="0.0" y1="2.413" x2="0.0" y2="2.667" width="0.1524" layer="94" />
              <wire x1="0.0" y1="2.667" x2="-1.27" y2="2.667" width="0.1524" layer="94" />
              <wire x1="-1.27" y1="5.207" x2="-1.27" y2="4.953" width="0.1524" layer="94" />
              <wire x1="-1.27" y1="4.953" x2="0.0" y2="4.953" width="0.1524" layer="94" />
              <wire x1="0.0" y1="4.953" x2="0.0" y2="5.207" width="0.1524" layer="94" />
              <wire x1="0.0" y1="5.207" x2="-1.27" y2="5.207" width="0.1524" layer="94" />
              <wire x1="-1.27" y1="7.747" x2="-1.27" y2="7.493" width="0.1524" layer="94" />
              <wire x1="-1.27" y1="7.493" x2="0.0" y2="7.493" width="0.1524" layer="94" />
              <wire x1="0.0" y1="7.493" x2="0.0" y2="7.747" width="0.1524" layer="94" />
              <wire x1="0.0" y1="7.747" x2="-1.27" y2="7.747" width="0.1524" layer="94" />
              <wire x1="-1.27" y1="8.89" x2="-1.27" y2="-11.43" width="0.254" layer="94" />
              <wire x1="-1.27" y1="-11.43" x2="1.27" y2="-11.43" width="0.254" layer="94" />
              <wire x1="1.27" y1="-11.43" x2="1.27" y2="8.89" width="0.254" layer="94" />
              <wire x1="1.27" y1="8.89" x2="-1.27" y2="8.89" width="0.254" layer="94" />
              <pin name="1" x="-5.08" y="7.62" visible="off" length="point" direction="pas" rot="R0" />
              <wire x1="-5.08" y1="7.62" x2="-1.27" y2="7.62" width="0.127" layer="94" />
              <text x="-4.08" y="8.120000000000001" size="1.016" layer="95">1</text>
              <pin name="2" x="-5.08" y="5.08" visible="off" length="point" direction="pas" rot="R0" />
              <wire x1="-5.08" y1="5.08" x2="-1.27" y2="5.08" width="0.127" layer="94" />
              <text x="-4.08" y="5.58" size="1.016" layer="95">2</text>
              <pin name="3" x="-5.08" y="2.54" visible="off" length="point" direction="pas" rot="R0" />
              <wire x1="-5.08" y1="2.54" x2="-1.27" y2="2.54" width="0.127" layer="94" />
              <text x="-4.08" y="3.04" size="1.016" layer="95">3</text>
              <pin name="4" x="-5.08" y="0" visible="off" length="point" direction="pas" rot="R0" />
              <wire x1="-5.08" y1="0" x2="-1.27" y2="0.0" width="0.127" layer="94" />
              <text x="-4.08" y="0.5" size="1.016" layer="95">4</text>
              <pin name="5" x="-5.08" y="-2.54" visible="off" length="point" direction="pas" rot="R0" />
              <wire x1="-5.08" y1="-2.54" x2="-1.27" y2="-2.54" width="0.127" layer="94" />
              <text x="-4.08" y="-2.04" size="1.016" layer="95">5</text>
              <pin name="6" x="-5.08" y="-5.08" visible="off" length="point" direction="pas" rot="R0" />
              <wire x1="-5.08" y1="-5.08" x2="-1.27" y2="-5.08" width="0.127" layer="94" />
              <text x="-4.08" y="-4.58" size="1.016" layer="95">6</text>
              <pin name="7" x="-5.08" y="-7.62" visible="off" length="point" direction="pas" rot="R0" />
              <wire x1="-5.08" y1="-7.62" x2="-1.27" y2="-7.62" width="0.127" layer="94" />
              <text x="-4.08" y="-7.12" size="1.016" layer="95">7</text>
              <pin name="8" x="-5.08" y="-10.16" visible="off" length="point" direction="pas" rot="R0" />
              <wire x1="-5.08" y1="-10.16" x2="-1.27" y2="-10.16" width="0.127" layer="94" />
              <text x="-4.08" y="-9.66" size="1.016" layer="95">8</text>
              <text x="4" y="2" size="1.27" layer="95">&gt;NAME</text>
              <text x="4" y="-1" size="1.27" layer="96">&gt;VALUE</text>
            </symbol>
          </symbols>
          <devicesets>
            <deviceset name="Device_R" prefix="R" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="Device_R" x="0" y="0" />
              </gates>
              <devices>
                <device name="-THT" package="R_VERTICAL_P2.54">
                  <connects>
                    <connect gate="G$1" pin="1" pad="1" />
                    <connect gate="G$1" pin="2" pad="2" />
                  </connects>
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="Device_C" prefix="C" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="Device_C" x="0" y="0" />
              </gates>
              <devices>
                <device name="-THT" package="C_DISC_P5.00">
                  <connects>
                    <connect gate="G$1" pin="1" pad="1" />
                    <connect gate="G$1" pin="2" pad="2" />
                  </connects>
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="Connector_Generic_Conn_01x02" prefix="J" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="Connector_Generic_Conn_01x02" x="0" y="0" />
              </gates>
              <devices>
                <device name="-THT" package="HEADER_1X2_P2.54">
                  <connects>
                    <connect gate="G$1" pin="1" pad="1" />
                    <connect gate="G$1" pin="2" pad="2" />
                  </connects>
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="Connector_Generic_Conn_01x03" prefix="J" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="Connector_Generic_Conn_01x03" x="0" y="0" />
              </gates>
              <devices>
                <device name="-THT" package="HEADER_1X3_P2.54">
                  <connects>
                    <connect gate="G$1" pin="1" pad="1" />
                    <connect gate="G$1" pin="2" pad="2" />
                    <connect gate="G$1" pin="3" pad="3" />
                  </connects>
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="Connector_Generic_Conn_01x08" prefix="J" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="Connector_Generic_Conn_01x08" x="0" y="0" />
              </gates>
              <devices>
                <device name="-THT" package="HEADER_1X8_P2.54">
                  <connects>
                    <connect gate="G$1" pin="1" pad="1" />
                    <connect gate="G$1" pin="2" pad="2" />
                    <connect gate="G$1" pin="3" pad="3" />
                    <connect gate="G$1" pin="4" pad="4" />
                    <connect gate="G$1" pin="5" pad="5" />
                    <connect gate="G$1" pin="6" pad="6" />
                    <connect gate="G$1" pin="7" pad="7" />
                    <connect gate="G$1" pin="8" pad="8" />
                  </connects>
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
        <part name="J1" library="Dragon_KiCad_Official" deviceset="Connector_Generic_Conn_01x08" device="-THT" value="ESP32 1x8 socket" />
        <part name="J2" library="Dragon_KiCad_Official" deviceset="Connector_Generic_Conn_01x03" device="-THT" value="Matrix input" />
        <part name="J3" library="Dragon_KiCad_Official" deviceset="Connector_Generic_Conn_01x03" device="-THT" value="TTP223 module" />
        <part name="J4" library="Dragon_KiCad_Official" deviceset="Connector_Generic_Conn_01x02" device="-THT" value="USB-C breakout 5V" />
        <part name="R1" library="Dragon_KiCad_Official" deviceset="Device_R" device="-THT" value="330R" />
        <part name="C2" library="Dragon_KiCad_Official" deviceset="Device_C" device="-THT" value="100nF" />
        <part name="J5" library="Dragon_KiCad_Official" deviceset="Connector_Generic_Conn_01x02" device="-THT" value="Off-board LDR" />
        <part name="R3" library="Dragon_KiCad_Official" deviceset="Device_R" device="-THT" value="10k" />
        <part name="C3" library="Dragon_KiCad_Official" deviceset="Device_C" device="-THT" value="100nF optional" />
        <part name="R4" library="Dragon_KiCad_Official" deviceset="Device_R" device="-THT" value="100k / 1%" />
        <part name="R5" library="Dragon_KiCad_Official" deviceset="Device_R" device="-THT" value="20k / 1%" />
        <part name="C4" library="Dragon_KiCad_Official" deviceset="Device_C" device="-THT" value="100nF" />
      </parts>
      <sheets>
        <sheet>
          <plain>
            <wire x1="49.32" y1="179.4" x2="50.52" y2="180.6" width="0.15" layer="97" />
            <wire x1="49.32" y1="180.6" x2="50.52" y2="179.4" width="0.15" layer="97" />
            <text x="60" y="175.0" size="1.25" layer="97">1 = 5V / VBUS</text>
            <text x="60" y="172.0" size="1.25" layer="97">2 = GND</text>
            <text x="60" y="169.0" size="1.25" layer="97">3 = 3V3</text>
            <text x="60" y="166.0" size="1.25" layer="97">4 = GPIO13 / unused</text>
            <text x="60" y="163.0" size="1.25" layer="97">5 = GPIO12 / matrix</text>
            <text x="60" y="160.0" size="1.25" layer="97">6 = GPIO11 / touch</text>
            <text x="60" y="157.0" size="1.25" layer="97">7 = GPIO10 / voltage</text>
            <text x="60" y="154.0" size="1.25" layer="97">8 = GPIO9 / LDR</text>
            <text x="15" y="246.0" size="3" layer="97">DRAGON LAMP - MODULE WIRING SCHEMATIC</text>
            <text x="15" y="240.0" size="1.6" layer="97">Official KiCad 8 symbols. J1 follows supplied physical row order: 5V, GND, 3V3, 13, 12, 11, 10, 9. Other connectors are wired interfaces.</text>
            <text x="125" y="203.0" size="1.4" layer="97">J2: 1=5V, 2=GND, 3=DIN</text>
            <text x="190" y="203.0" size="1.4" layer="97">J3: 1=3V3, 2=GND, 3=OUT</text>
            <text x="245" y="211.0" size="2" layer="97">LIGHT DIVIDER</text>
            <text x="325" y="211.0" size="2" layer="97">SUPPLY DIVIDER</text>
            <text x="15" y="46.0" size="1.6" layer="97">J4: 1=VBUS, 2=GND. Existing USB-C breakout includes CC resistors; D+/D- unused.</text>
            <text x="15" y="41.0" size="1.6" layer="97">Use PC USB into ESP32 OR external 5V at J4; never both powered without source isolation.</text>
            <text x="15" y="36.0" size="1.6" layer="97">External supply: branch matrix power directly from source. All grounds common. 1000uF bulk capacitor is OFF BOARD across USB breakout VBUS/GND.</text>
            <text x="15" y="31.0" size="1.6" layer="97">TTP223 and LDR share 3.3V. C2 is PCB bypass; keep a 100nF bypass near the remote TTP223 too. C4 is near GPIO10. C3 is optional filtering.</text>
            <text x="15" y="26.0" size="1.6" layer="97">Divider: GPIO10 = VBUS / 6; at 5.00V expect 0.833V. J5: 1=3V3, 2=GPIO9 to remote LDR. No microphone.</text>
            <text x="15" y="21.0" size="1.6" layer="97">Direct 3.3V LED data matches prototype; add a suitable 5V logic buffer if required by the actual matrix.</text>
          </plain>
          <moduleinsts />
          <instances>
            <instance part="J1" gate="G$1" x="55" y="180.0" smashed="yes" rot="R0">
              <attribute name="NAME" x="59" y="182.0" size="1.27" layer="95" />
              <attribute name="VALUE" x="59" y="179.0" size="1.27" layer="96" />
            </instance>
            <instance part="J2" gate="G$1" x="145" y="190.0" smashed="yes" rot="R0">
              <attribute name="NAME" x="149" y="192.0" size="1.27" layer="95" />
              <attribute name="VALUE" x="149" y="189.0" size="1.27" layer="96" />
            </instance>
            <instance part="J3" gate="G$1" x="215" y="190.0" smashed="yes" rot="R0">
              <attribute name="NAME" x="219" y="192.0" size="1.27" layer="95" />
              <attribute name="VALUE" x="219" y="189.0" size="1.27" layer="96" />
            </instance>
            <instance part="J4" gate="G$1" x="55" y="140.0" smashed="yes" rot="R0">
              <attribute name="NAME" x="59" y="142.0" size="1.27" layer="95" />
              <attribute name="VALUE" x="59" y="139.0" size="1.27" layer="96" />
            </instance>
            <instance part="R1" gate="G$1" x="115" y="187.46" smashed="yes" rot="R270">
              <attribute name="NAME" x="119" y="189.46" size="1.27" layer="95" />
              <attribute name="VALUE" x="119" y="186.46" size="1.27" layer="96" />
            </instance>
            <instance part="C2" gate="G$1" x="230" y="140.0" smashed="yes" rot="R0">
              <attribute name="NAME" x="234" y="142.0" size="1.27" layer="95" />
              <attribute name="VALUE" x="234" y="139.0" size="1.27" layer="96" />
            </instance>
            <instance part="J5" gate="G$1" x="280.08" y="195.0" smashed="yes" rot="R0">
              <attribute name="NAME" x="284.08" y="197.0" size="1.27" layer="95" />
              <attribute name="VALUE" x="284.08" y="194.0" size="1.27" layer="96" />
            </instance>
            <instance part="R3" gate="G$1" x="275" y="140.0" smashed="yes" rot="R0">
              <attribute name="NAME" x="279" y="142.0" size="1.27" layer="95" />
              <attribute name="VALUE" x="279" y="139.0" size="1.27" layer="96" />
            </instance>
            <instance part="C3" gate="G$1" x="300" y="140.0" smashed="yes" rot="R0">
              <attribute name="NAME" x="304" y="142.0" size="1.27" layer="95" />
              <attribute name="VALUE" x="304" y="139.0" size="1.27" layer="96" />
            </instance>
            <instance part="R4" gate="G$1" x="345" y="195.0" smashed="yes" rot="R0">
              <attribute name="NAME" x="349" y="197.0" size="1.27" layer="95" />
              <attribute name="VALUE" x="349" y="194.0" size="1.27" layer="96" />
            </instance>
            <instance part="R5" gate="G$1" x="345" y="140.0" smashed="yes" rot="R0">
              <attribute name="NAME" x="349" y="142.0" size="1.27" layer="95" />
              <attribute name="VALUE" x="349" y="139.0" size="1.27" layer="96" />
            </instance>
            <instance part="C4" gate="G$1" x="375" y="140.0" smashed="yes" rot="R0">
              <attribute name="NAME" x="379" y="142.0" size="1.27" layer="95" />
              <attribute name="VALUE" x="379" y="139.0" size="1.27" layer="96" />
            </instance>
          </instances>
          <busses />
          <nets>
            <net name="+3V3" class="0">
              <segment>
                <pinref part="J1" gate="G$1" pin="3" />
                <pinref part="J3" gate="G$1" pin="1" />
                <pinref part="C2" gate="G$1" pin="1" />
                <pinref part="J5" gate="G$1" pin="1" />
                <wire x1="25.0" y1="182.54" x2="49.92" y2="182.54" width="0.1524" layer="91" />
                <wire x1="25.0" y1="225.0" x2="25.0" y2="182.54" width="0.1524" layer="91" />
                <wire x1="200.0" y1="192.54" x2="209.92" y2="192.54" width="0.1524" layer="91" />
                <wire x1="200.0" y1="225.0" x2="200.0" y2="192.54" width="0.1524" layer="91" />
                <wire x1="230.0" y1="225.0" x2="230.0" y2="143.81" width="0.1524" layer="91" />
                <wire x1="275.0" y1="225.0" x2="275.0" y2="195.0" width="0.1524" layer="91" />
                <wire x1="25.0" y1="225.0" x2="200.0" y2="225.0" width="0.1524" layer="91" />
                <wire x1="200.0" y1="225.0" x2="230.0" y2="225.0" width="0.1524" layer="91" />
                <wire x1="230.0" y1="225.0" x2="275.0" y2="225.0" width="0.1524" layer="91" />
                <junction x="200.0" y="225.0" />
                <junction x="230.0" y="225.0" />
                <label x="25.0" y="225.0" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="+5V" class="0">
              <segment>
                <pinref part="J1" gate="G$1" pin="1" />
                <pinref part="J2" gate="G$1" pin="1" />
                <pinref part="J4" gate="G$1" pin="1" />
                <pinref part="R4" gate="G$1" pin="1" />
                <wire x1="20.0" y1="187.62" x2="49.92" y2="187.62" width="0.1524" layer="91" />
                <wire x1="20.0" y1="235.0" x2="20.0" y2="187.62" width="0.1524" layer="91" />
                <wire x1="10.0" y1="140.0" x2="49.92" y2="140.0" width="0.1524" layer="91" />
                <wire x1="10.0" y1="235.0" x2="10.0" y2="140.0" width="0.1524" layer="91" />
                <wire x1="130.0" y1="192.54" x2="139.92" y2="192.54" width="0.1524" layer="91" />
                <wire x1="130.0" y1="235.0" x2="130.0" y2="192.54" width="0.1524" layer="91" />
                <wire x1="345.0" y1="235.0" x2="345.0" y2="198.81" width="0.1524" layer="91" />
                <wire x1="10.0" y1="235.0" x2="20.0" y2="235.0" width="0.1524" layer="91" />
                <wire x1="20.0" y1="235.0" x2="130.0" y2="235.0" width="0.1524" layer="91" />
                <wire x1="130.0" y1="235.0" x2="345.0" y2="235.0" width="0.1524" layer="91" />
                <junction x="20.0" y="235.0" />
                <junction x="130.0" y="235.0" />
                <label x="10.0" y="235.0" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="GND" class="0">
              <segment>
                <pinref part="J1" gate="G$1" pin="2" />
                <pinref part="J2" gate="G$1" pin="2" />
                <pinref part="J3" gate="G$1" pin="2" />
                <pinref part="J4" gate="G$1" pin="2" />
                <pinref part="C2" gate="G$1" pin="2" />
                <pinref part="R3" gate="G$1" pin="2" />
                <pinref part="C3" gate="G$1" pin="2" />
                <pinref part="R5" gate="G$1" pin="2" />
                <pinref part="C4" gate="G$1" pin="2" />
                <wire x1="30.0" y1="185.08" x2="49.92" y2="185.08" width="0.1524" layer="91" />
                <wire x1="30.0" y1="185.08" x2="30.0" y2="110.0" width="0.1524" layer="91" />
                <wire x1="15.0" y1="137.46" x2="49.92" y2="137.46" width="0.1524" layer="91" />
                <wire x1="15.0" y1="137.46" x2="15.0" y2="110.0" width="0.1524" layer="91" />
                <wire x1="132.0" y1="190.0" x2="139.92" y2="190.0" width="0.1524" layer="91" />
                <wire x1="132.0" y1="190.0" x2="132.0" y2="110.0" width="0.1524" layer="91" />
                <wire x1="202.0" y1="190.0" x2="209.92" y2="190.0" width="0.1524" layer="91" />
                <wire x1="202.0" y1="190.0" x2="202.0" y2="110.0" width="0.1524" layer="91" />
                <wire x1="230.0" y1="136.19" x2="230.0" y2="110.0" width="0.1524" layer="91" />
                <wire x1="275.0" y1="136.19" x2="275.0" y2="110.0" width="0.1524" layer="91" />
                <wire x1="300.0" y1="136.19" x2="300.0" y2="110.0" width="0.1524" layer="91" />
                <wire x1="345.0" y1="136.19" x2="345.0" y2="110.0" width="0.1524" layer="91" />
                <wire x1="375.0" y1="136.19" x2="375.0" y2="110.0" width="0.1524" layer="91" />
                <wire x1="15.0" y1="110.0" x2="30.0" y2="110.0" width="0.1524" layer="91" />
                <wire x1="30.0" y1="110.0" x2="132.0" y2="110.0" width="0.1524" layer="91" />
                <wire x1="132.0" y1="110.0" x2="202.0" y2="110.0" width="0.1524" layer="91" />
                <wire x1="202.0" y1="110.0" x2="230.0" y2="110.0" width="0.1524" layer="91" />
                <wire x1="230.0" y1="110.0" x2="275.0" y2="110.0" width="0.1524" layer="91" />
                <wire x1="275.0" y1="110.0" x2="300.0" y2="110.0" width="0.1524" layer="91" />
                <wire x1="300.0" y1="110.0" x2="345.0" y2="110.0" width="0.1524" layer="91" />
                <wire x1="345.0" y1="110.0" x2="375.0" y2="110.0" width="0.1524" layer="91" />
                <junction x="300.0" y="110.0" />
                <junction x="345.0" y="110.0" />
                <junction x="230.0" y="110.0" />
                <junction x="132.0" y="110.0" />
                <junction x="275.0" y="110.0" />
                <junction x="202.0" y="110.0" />
                <junction x="30.0" y="110.0" />
                <label x="15.0" y="110.0" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="GPIO10_VSENSE" class="0">
              <segment>
                <pinref part="J1" gate="G$1" pin="7" />
                <pinref part="R4" gate="G$1" pin="2" />
                <pinref part="R5" gate="G$1" pin="1" />
                <pinref part="C4" gate="G$1" pin="1" />
                <wire x1="42.62" y1="172.38" x2="49.92" y2="172.38" width="0.1524" layer="91" />
                <wire x1="42.62" y1="172.38" x2="42.62" y2="65.0" width="0.1524" layer="91" />
                <wire x1="42.62" y1="65.0" x2="330.0" y2="65.0" width="0.1524" layer="91" />
                <wire x1="330.0" y1="165.0" x2="330.0" y2="65.0" width="0.1524" layer="91" />
                <wire x1="345.0" y1="191.19" x2="345.0" y2="165.0" width="0.1524" layer="91" />
                <wire x1="345.0" y1="165.0" x2="345.0" y2="143.81" width="0.1524" layer="91" />
                <wire x1="330.0" y1="165.0" x2="345.0" y2="165.0" width="0.1524" layer="91" />
                <wire x1="345.0" y1="165.0" x2="375.0" y2="165.0" width="0.1524" layer="91" />
                <wire x1="375.0" y1="165.0" x2="375.0" y2="143.81" width="0.1524" layer="91" />
                <junction x="345.0" y="165.0" />
                <label x="47.62" y="65.0" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="GPIO11_TOUCH" class="0">
              <segment>
                <pinref part="J1" gate="G$1" pin="6" />
                <pinref part="J3" gate="G$1" pin="3" />
                <wire x1="40.08" y1="174.92" x2="49.92" y2="174.92" width="0.1524" layer="91" />
                <wire x1="40.08" y1="174.92" x2="40.08" y2="85.0" width="0.1524" layer="91" />
                <wire x1="40.08" y1="85.0" x2="190.0" y2="85.0" width="0.1524" layer="91" />
                <wire x1="190.0" y1="187.46" x2="190.0" y2="85.0" width="0.1524" layer="91" />
                <wire x1="190.0" y1="187.46" x2="209.92" y2="187.46" width="0.1524" layer="91" />
                <label x="45.08" y="85.0" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="GPIO12_LED" class="0">
              <segment>
                <pinref part="J1" gate="G$1" pin="5" />
                <pinref part="R1" gate="G$1" pin="2" />
                <wire x1="37.54" y1="177.46" x2="49.92" y2="177.46" width="0.1524" layer="91" />
                <wire x1="37.54" y1="177.46" x2="37.54" y2="95.0" width="0.1524" layer="91" />
                <wire x1="37.54" y1="95.0" x2="100.0" y2="95.0" width="0.1524" layer="91" />
                <wire x1="100.0" y1="187.46" x2="100.0" y2="95.0" width="0.1524" layer="91" />
                <wire x1="100.0" y1="187.46" x2="111.19" y2="187.46" width="0.1524" layer="91" />
                <label x="42.54" y="95.0" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="GPIO9_LDR" class="0">
              <segment>
                <pinref part="J1" gate="G$1" pin="8" />
                <pinref part="J5" gate="G$1" pin="2" />
                <pinref part="R3" gate="G$1" pin="1" />
                <pinref part="C3" gate="G$1" pin="1" />
                <wire x1="45.16" y1="169.84" x2="49.92" y2="169.84" width="0.1524" layer="91" />
                <wire x1="45.16" y1="169.84" x2="45.16" y2="75.0" width="0.1524" layer="91" />
                <wire x1="45.16" y1="75.0" x2="260.0" y2="75.0" width="0.1524" layer="91" />
                <wire x1="260.0" y1="165.0" x2="260.0" y2="75.0" width="0.1524" layer="91" />
                <wire x1="275.0" y1="192.46" x2="275.0" y2="165.0" width="0.1524" layer="91" />
                <wire x1="275.0" y1="165.0" x2="275.0" y2="143.81" width="0.1524" layer="91" />
                <wire x1="260.0" y1="165.0" x2="275.0" y2="165.0" width="0.1524" layer="91" />
                <wire x1="275.0" y1="165.0" x2="300.0" y2="165.0" width="0.1524" layer="91" />
                <wire x1="300.0" y1="165.0" x2="300.0" y2="143.81" width="0.1524" layer="91" />
                <junction x="275.0" y="165.0" />
                <label x="50.16" y="75.0" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="LED_DIN" class="0">
              <segment>
                <pinref part="J2" gate="G$1" pin="3" />
                <pinref part="R1" gate="G$1" pin="1" />
                <wire x1="118.81" y1="187.46" x2="139.92" y2="187.46" width="0.1524" layer="91" />
              </segment>
            </net>
          </nets>
        </sheet>
      </sheets>
      <errors />
    </schematic>
  </drawing>
</eagle>