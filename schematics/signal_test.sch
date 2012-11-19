<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE eagle SYSTEM "eagle.dtd">
<eagle version="6.2">
<drawing>
<settings>
<setting alwaysvectorfont="no"/>
<setting verticaltext="up"/>
</settings>
<grid distance="0.1" unitdist="inch" unit="inch" style="lines" multiple="1" display="no" altdistance="0.01" altunitdist="inch" altunit="inch"/>
<layers>
<layer number="1" name="Top" color="4" fill="1" visible="no" active="no"/>
<layer number="16" name="Bottom" color="1" fill="1" visible="no" active="no"/>
<layer number="17" name="Pads" color="2" fill="1" visible="no" active="no"/>
<layer number="18" name="Vias" color="2" fill="1" visible="no" active="no"/>
<layer number="19" name="Unrouted" color="6" fill="1" visible="no" active="no"/>
<layer number="20" name="Dimension" color="15" fill="1" visible="no" active="no"/>
<layer number="21" name="tPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="22" name="bPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="23" name="tOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="24" name="bOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="25" name="tNames" color="7" fill="1" visible="no" active="no"/>
<layer number="26" name="bNames" color="7" fill="1" visible="no" active="no"/>
<layer number="27" name="tValues" color="7" fill="1" visible="no" active="no"/>
<layer number="28" name="bValues" color="7" fill="1" visible="no" active="no"/>
<layer number="29" name="tStop" color="7" fill="3" visible="no" active="no"/>
<layer number="30" name="bStop" color="7" fill="6" visible="no" active="no"/>
<layer number="31" name="tCream" color="7" fill="4" visible="no" active="no"/>
<layer number="32" name="bCream" color="7" fill="5" visible="no" active="no"/>
<layer number="33" name="tFinish" color="6" fill="3" visible="no" active="no"/>
<layer number="34" name="bFinish" color="6" fill="6" visible="no" active="no"/>
<layer number="35" name="tGlue" color="7" fill="4" visible="no" active="no"/>
<layer number="36" name="bGlue" color="7" fill="5" visible="no" active="no"/>
<layer number="37" name="tTest" color="7" fill="1" visible="no" active="no"/>
<layer number="38" name="bTest" color="7" fill="1" visible="no" active="no"/>
<layer number="39" name="tKeepout" color="4" fill="11" visible="no" active="no"/>
<layer number="40" name="bKeepout" color="1" fill="11" visible="no" active="no"/>
<layer number="41" name="tRestrict" color="4" fill="10" visible="no" active="no"/>
<layer number="42" name="bRestrict" color="1" fill="10" visible="no" active="no"/>
<layer number="43" name="vRestrict" color="2" fill="10" visible="no" active="no"/>
<layer number="44" name="Drills" color="7" fill="1" visible="no" active="no"/>
<layer number="45" name="Holes" color="7" fill="1" visible="no" active="no"/>
<layer number="46" name="Milling" color="3" fill="1" visible="no" active="no"/>
<layer number="47" name="Measures" color="7" fill="1" visible="no" active="no"/>
<layer number="48" name="Document" color="7" fill="1" visible="no" active="no"/>
<layer number="49" name="Reference" color="7" fill="1" visible="no" active="no"/>
<layer number="51" name="tDocu" color="6" fill="9" visible="no" active="no"/>
<layer number="52" name="bDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="91" name="Nets" color="2" fill="1" visible="yes" active="yes"/>
<layer number="92" name="Busses" color="1" fill="1" visible="yes" active="yes"/>
<layer number="93" name="Pins" color="2" fill="1" visible="no" active="yes"/>
<layer number="94" name="Symbols" color="4" fill="1" visible="yes" active="yes"/>
<layer number="95" name="Names" color="7" fill="1" visible="yes" active="yes"/>
<layer number="96" name="Values" color="7" fill="1" visible="yes" active="yes"/>
<layer number="97" name="Info" color="7" fill="1" visible="yes" active="yes"/>
<layer number="98" name="Guide" color="6" fill="1" visible="yes" active="yes"/>
</layers>
<schematic xreflabel="%F%N/%S.%C%R" xrefpart="/%S.%C%R">
<libraries>
<library name="atmel">
<description>&lt;b&gt;AVR Devices&lt;/b&gt;&lt;p&gt;
Configurable logic, microcontrollers, nonvolatile memories&lt;p&gt;
Based on the following sources:&lt;p&gt;
&lt;ul&gt;
&lt;li&gt;www.atmel.com
&lt;li&gt;CD-ROM : Configurable Logic Microcontroller Nonvolatile Memory
&lt;li&gt;CadSoft download site, www.cadsoft.de or www.cadsoftusa.com , file at90smcu_v400.zip
&lt;li&gt;avr.lbr
&lt;/ul&gt;
&lt;author&gt;Revised by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
<package name="TQFP44">
<description>&lt;b&gt;44-lead Thin Quad Flat Package&lt;/b&gt;</description>
<wire x1="-4.8" y1="4.4" x2="-4.4" y2="4.8" width="0.2032" layer="21"/>
<wire x1="-4.4" y1="4.8" x2="4.4" y2="4.8" width="0.2032" layer="21"/>
<wire x1="4.4" y1="4.8" x2="4.8" y2="4.4" width="0.2032" layer="21"/>
<wire x1="4.8" y1="4.4" x2="4.8" y2="-4.4" width="0.2032" layer="21"/>
<wire x1="4.8" y1="-4.4" x2="4.4" y2="-4.8" width="0.2032" layer="21"/>
<wire x1="4.4" y1="-4.8" x2="-4.4" y2="-4.8" width="0.2032" layer="21"/>
<wire x1="-4.4" y1="-4.8" x2="-4.8" y2="-4.4" width="0.2032" layer="21"/>
<wire x1="-4.8" y1="-4.4" x2="-4.8" y2="4.4" width="0.2032" layer="21"/>
<circle x="-4" y="4" radius="0.2827" width="0.254" layer="21"/>
<smd name="1" x="-5.8" y="4" dx="1.5" dy="0.5" layer="1"/>
<smd name="2" x="-5.8" y="3.2" dx="1.5" dy="0.5" layer="1"/>
<smd name="3" x="-5.8" y="2.4" dx="1.5" dy="0.5" layer="1"/>
<smd name="4" x="-5.8" y="1.6" dx="1.5" dy="0.5" layer="1"/>
<smd name="5" x="-5.8" y="0.8" dx="1.5" dy="0.5" layer="1"/>
<smd name="6" x="-5.8" y="0" dx="1.5" dy="0.5" layer="1"/>
<smd name="7" x="-5.8" y="-0.8" dx="1.5" dy="0.5" layer="1"/>
<smd name="8" x="-5.8" y="-1.6" dx="1.5" dy="0.5" layer="1"/>
<smd name="9" x="-5.8" y="-2.4" dx="1.5" dy="0.5" layer="1"/>
<smd name="10" x="-5.8" y="-3.2" dx="1.5" dy="0.5" layer="1"/>
<smd name="11" x="-5.8" y="-4" dx="1.5" dy="0.5" layer="1"/>
<smd name="12" x="-4" y="-5.8" dx="0.5" dy="1.5" layer="1"/>
<smd name="13" x="-3.2" y="-5.8" dx="0.5" dy="1.5" layer="1"/>
<smd name="14" x="-2.4" y="-5.8" dx="0.5" dy="1.5" layer="1"/>
<smd name="15" x="-1.6" y="-5.8" dx="0.5" dy="1.5" layer="1"/>
<smd name="16" x="-0.8" y="-5.8" dx="0.5" dy="1.5" layer="1"/>
<smd name="17" x="0" y="-5.8" dx="0.5" dy="1.5" layer="1"/>
<smd name="18" x="0.8" y="-5.8" dx="0.5" dy="1.5" layer="1"/>
<smd name="19" x="1.6" y="-5.8" dx="0.5" dy="1.5" layer="1"/>
<smd name="20" x="2.4" y="-5.8" dx="0.5" dy="1.5" layer="1"/>
<smd name="21" x="3.2" y="-5.8" dx="0.5" dy="1.5" layer="1"/>
<smd name="22" x="4" y="-5.8" dx="0.5" dy="1.5" layer="1"/>
<smd name="23" x="5.8" y="-4" dx="1.5" dy="0.5" layer="1"/>
<smd name="24" x="5.8" y="-3.2" dx="1.5" dy="0.5" layer="1"/>
<smd name="25" x="5.8" y="-2.4" dx="1.5" dy="0.5" layer="1"/>
<smd name="26" x="5.8" y="-1.6" dx="1.5" dy="0.5" layer="1"/>
<smd name="27" x="5.8" y="-0.8" dx="1.5" dy="0.5" layer="1"/>
<smd name="28" x="5.8" y="0" dx="1.5" dy="0.5" layer="1"/>
<smd name="29" x="5.8" y="0.8" dx="1.5" dy="0.5" layer="1"/>
<smd name="30" x="5.8" y="1.6" dx="1.5" dy="0.5" layer="1"/>
<smd name="31" x="5.8" y="2.4" dx="1.5" dy="0.5" layer="1"/>
<smd name="32" x="5.8" y="3.2" dx="1.5" dy="0.5" layer="1"/>
<smd name="33" x="5.8" y="4" dx="1.5" dy="0.5" layer="1"/>
<smd name="34" x="4" y="5.8" dx="0.5" dy="1.5" layer="1"/>
<smd name="35" x="3.2" y="5.8" dx="0.5" dy="1.5" layer="1"/>
<smd name="36" x="2.4" y="5.8" dx="0.5" dy="1.5" layer="1"/>
<smd name="37" x="1.6" y="5.8" dx="0.5" dy="1.5" layer="1"/>
<smd name="38" x="0.8" y="5.8" dx="0.5" dy="1.5" layer="1"/>
<smd name="39" x="0" y="5.8" dx="0.5" dy="1.5" layer="1"/>
<smd name="40" x="-0.8" y="5.8" dx="0.5" dy="1.5" layer="1"/>
<smd name="41" x="-1.6" y="5.8" dx="0.5" dy="1.5" layer="1"/>
<smd name="42" x="-2.4" y="5.8" dx="0.5" dy="1.5" layer="1"/>
<smd name="43" x="-3.2" y="5.8" dx="0.5" dy="1.5" layer="1"/>
<smd name="44" x="-4" y="5.8" dx="0.5" dy="1.5" layer="1"/>
<text x="-3.81" y="6.985" size="1.778" layer="25">&gt;NAME</text>
<text x="-4.445" y="-8.7551" size="1.778" layer="27">&gt;VALUE</text>
<rectangle x1="-6.1001" y1="3.8001" x2="-4.95" y2="4.1999" layer="51"/>
<rectangle x1="-6.1001" y1="3" x2="-4.95" y2="3.4" layer="51"/>
<rectangle x1="-6.1001" y1="2.1999" x2="-4.95" y2="2.5999" layer="51"/>
<rectangle x1="-6.1001" y1="1.4" x2="-4.95" y2="1.8001" layer="51"/>
<rectangle x1="-6.1001" y1="0.5999" x2="-4.95" y2="1" layer="51"/>
<rectangle x1="-6.1001" y1="-0.1999" x2="-4.95" y2="0.1999" layer="51"/>
<rectangle x1="-6.1001" y1="-1" x2="-4.95" y2="-0.5999" layer="51"/>
<rectangle x1="-6.1001" y1="-1.8001" x2="-4.95" y2="-1.4" layer="51"/>
<rectangle x1="-6.1001" y1="-2.5999" x2="-4.95" y2="-2.1999" layer="51"/>
<rectangle x1="-6.1001" y1="-3.4" x2="-4.95" y2="-3" layer="51"/>
<rectangle x1="-6.1001" y1="-4.1999" x2="-4.95" y2="-3.8001" layer="51"/>
<rectangle x1="-4.1999" y1="-6.1001" x2="-3.8001" y2="-4.95" layer="51"/>
<rectangle x1="-3.4" y1="-6.1001" x2="-3" y2="-4.95" layer="51"/>
<rectangle x1="-2.5999" y1="-6.1001" x2="-2.1999" y2="-4.95" layer="51"/>
<rectangle x1="-1.8001" y1="-6.1001" x2="-1.4" y2="-4.95" layer="51"/>
<rectangle x1="-1" y1="-6.1001" x2="-0.5999" y2="-4.95" layer="51"/>
<rectangle x1="-0.1999" y1="-6.1001" x2="0.1999" y2="-4.95" layer="51"/>
<rectangle x1="0.5999" y1="-6.1001" x2="1" y2="-4.95" layer="51"/>
<rectangle x1="1.4" y1="-6.1001" x2="1.8001" y2="-4.95" layer="51"/>
<rectangle x1="2.1999" y1="-6.1001" x2="2.5999" y2="-4.95" layer="51"/>
<rectangle x1="3" y1="-6.1001" x2="3.4" y2="-4.95" layer="51"/>
<rectangle x1="3.8001" y1="-6.1001" x2="4.1999" y2="-4.95" layer="51"/>
<rectangle x1="4.95" y1="-4.1999" x2="6.1001" y2="-3.8001" layer="51"/>
<rectangle x1="4.95" y1="-3.4" x2="6.1001" y2="-3" layer="51"/>
<rectangle x1="4.95" y1="-2.5999" x2="6.1001" y2="-2.1999" layer="51"/>
<rectangle x1="4.95" y1="-1.8001" x2="6.1001" y2="-1.4" layer="51"/>
<rectangle x1="4.95" y1="-1" x2="6.1001" y2="-0.5999" layer="51"/>
<rectangle x1="4.95" y1="-0.1999" x2="6.1001" y2="0.1999" layer="51"/>
<rectangle x1="4.95" y1="0.5999" x2="6.1001" y2="1" layer="51"/>
<rectangle x1="4.95" y1="1.4" x2="6.1001" y2="1.8001" layer="51"/>
<rectangle x1="4.95" y1="2.1999" x2="6.1001" y2="2.5999" layer="51"/>
<rectangle x1="4.95" y1="3" x2="6.1001" y2="3.4" layer="51"/>
<rectangle x1="4.95" y1="3.8001" x2="6.1001" y2="4.1999" layer="51"/>
<rectangle x1="3.8001" y1="4.95" x2="4.1999" y2="6.1001" layer="51"/>
<rectangle x1="3" y1="4.95" x2="3.4" y2="6.1001" layer="51"/>
<rectangle x1="2.1999" y1="4.95" x2="2.5999" y2="6.1001" layer="51"/>
<rectangle x1="1.4" y1="4.95" x2="1.8001" y2="6.1001" layer="51"/>
<rectangle x1="0.5999" y1="4.95" x2="1" y2="6.1001" layer="51"/>
<rectangle x1="-0.1999" y1="4.95" x2="0.1999" y2="6.1001" layer="51"/>
<rectangle x1="-1" y1="4.95" x2="-0.5999" y2="6.1001" layer="51"/>
<rectangle x1="-1.8001" y1="4.95" x2="-1.4" y2="6.1001" layer="51"/>
<rectangle x1="-2.5999" y1="4.95" x2="-2.1999" y2="6.1001" layer="51"/>
<rectangle x1="-3.4" y1="4.95" x2="-3" y2="6.1001" layer="51"/>
<rectangle x1="-4.1999" y1="4.95" x2="-3.8001" y2="6.1001" layer="51"/>
</package>
<package name="QFN44ML8X8">
<description>&lt;b&gt;44-Lead Plastic Quad Flat No Lead Package (ML)&lt;/b&gt; 8x8 mm Body (QFN)&lt;p&gt;
Source: http://ww1.microchip.com/downloads/en/devicedoc/39632c.pdf</description>
<wire x1="-3.9" y1="-3.9" x2="3.9" y2="-3.9" width="0.2032" layer="51"/>
<wire x1="3.9" y1="-3.9" x2="3.9" y2="3.9" width="0.2032" layer="51"/>
<wire x1="3.9" y1="3.9" x2="-3.9" y2="3.9" width="0.2032" layer="51"/>
<wire x1="-3.9" y1="3.9" x2="-3.9" y2="-3.9" width="0.2032" layer="51"/>
<smd name="1" x="-3.7875" y="3.25" dx="0.45" dy="0.33" layer="1" roundness="40" stop="no"/>
<smd name="2" x="-3.7875" y="2.6" dx="0.45" dy="0.33" layer="1" stop="no"/>
<smd name="3" x="-3.7875" y="1.95" dx="0.45" dy="0.33" layer="1" stop="no"/>
<smd name="4" x="-3.7875" y="1.3" dx="0.45" dy="0.33" layer="1" stop="no"/>
<smd name="5" x="-3.7875" y="0.65" dx="0.45" dy="0.33" layer="1" stop="no"/>
<smd name="6" x="-3.7875" y="0" dx="0.45" dy="0.33" layer="1" stop="no"/>
<smd name="7" x="-3.7875" y="-0.65" dx="0.45" dy="0.33" layer="1" stop="no"/>
<smd name="8" x="-3.7875" y="-1.3" dx="0.45" dy="0.33" layer="1" stop="no"/>
<smd name="9" x="-3.7875" y="-1.95" dx="0.45" dy="0.33" layer="1" stop="no"/>
<smd name="10" x="-3.7875" y="-2.6" dx="0.45" dy="0.33" layer="1" stop="no"/>
<smd name="11" x="-3.7875" y="-3.25" dx="0.45" dy="0.33" layer="1" roundness="40" stop="no"/>
<smd name="12" x="-3.25" y="-3.7875" dx="0.45" dy="0.33" layer="1" roundness="40" rot="R90" stop="no"/>
<smd name="13" x="-2.6" y="-3.7875" dx="0.45" dy="0.33" layer="1" rot="R90" stop="no"/>
<smd name="14" x="-1.95" y="-3.7875" dx="0.45" dy="0.33" layer="1" rot="R90" stop="no"/>
<smd name="15" x="-1.3" y="-3.7875" dx="0.45" dy="0.33" layer="1" rot="R90" stop="no"/>
<smd name="16" x="-0.65" y="-3.7875" dx="0.45" dy="0.33" layer="1" rot="R90" stop="no"/>
<smd name="17" x="0" y="-3.7875" dx="0.45" dy="0.33" layer="1" rot="R90" stop="no"/>
<smd name="18" x="0.65" y="-3.7875" dx="0.45" dy="0.33" layer="1" rot="R90" stop="no"/>
<smd name="19" x="1.3" y="-3.7875" dx="0.45" dy="0.33" layer="1" rot="R90" stop="no"/>
<smd name="20" x="1.95" y="-3.7875" dx="0.45" dy="0.33" layer="1" rot="R90" stop="no"/>
<smd name="21" x="2.6" y="-3.7875" dx="0.45" dy="0.33" layer="1" rot="R90" stop="no"/>
<smd name="22" x="3.25" y="-3.7875" dx="0.45" dy="0.33" layer="1" roundness="40" rot="R90" stop="no"/>
<smd name="23" x="3.7875" y="-3.25" dx="0.45" dy="0.33" layer="1" roundness="40" rot="R180" stop="no"/>
<smd name="24" x="3.7875" y="-2.6" dx="0.45" dy="0.33" layer="1" rot="R180" stop="no"/>
<smd name="25" x="3.7875" y="-1.95" dx="0.45" dy="0.33" layer="1" rot="R180" stop="no"/>
<smd name="26" x="3.7875" y="-1.3" dx="0.45" dy="0.33" layer="1" rot="R180" stop="no"/>
<smd name="27" x="3.7875" y="-0.65" dx="0.45" dy="0.33" layer="1" rot="R180" stop="no"/>
<smd name="28" x="3.7875" y="0" dx="0.45" dy="0.33" layer="1" rot="R180" stop="no"/>
<smd name="29" x="3.7875" y="0.65" dx="0.45" dy="0.33" layer="1" rot="R180" stop="no"/>
<smd name="30" x="3.7875" y="1.3" dx="0.45" dy="0.33" layer="1" rot="R180" stop="no"/>
<smd name="31" x="3.7875" y="1.95" dx="0.45" dy="0.33" layer="1" rot="R180" stop="no"/>
<smd name="32" x="3.7875" y="2.6" dx="0.45" dy="0.33" layer="1" rot="R180" stop="no"/>
<smd name="33" x="3.7875" y="3.25" dx="0.45" dy="0.33" layer="1" roundness="40" rot="R180" stop="no"/>
<smd name="34" x="3.25" y="3.7875" dx="0.45" dy="0.33" layer="1" roundness="40" rot="R270" stop="no"/>
<smd name="35" x="2.6" y="3.7875" dx="0.45" dy="0.33" layer="1" rot="R270" stop="no"/>
<smd name="36" x="1.95" y="3.7875" dx="0.45" dy="0.33" layer="1" rot="R270" stop="no"/>
<smd name="37" x="1.3" y="3.7875" dx="0.45" dy="0.33" layer="1" rot="R270" stop="no"/>
<smd name="38" x="0.65" y="3.7875" dx="0.45" dy="0.33" layer="1" rot="R270" stop="no"/>
<smd name="39" x="0" y="3.7875" dx="0.45" dy="0.33" layer="1" rot="R270" stop="no"/>
<smd name="40" x="-0.65" y="3.7875" dx="0.45" dy="0.33" layer="1" rot="R270" stop="no"/>
<smd name="41" x="-1.3" y="3.7875" dx="0.45" dy="0.33" layer="1" rot="R270" stop="no"/>
<smd name="42" x="-1.95" y="3.7875" dx="0.45" dy="0.33" layer="1" rot="R270" stop="no"/>
<smd name="43" x="-2.6" y="3.7875" dx="0.45" dy="0.33" layer="1" rot="R270" stop="no"/>
<smd name="44" x="-3.25" y="3.7875" dx="0.45" dy="0.33" layer="1" roundness="40" rot="R270" stop="no"/>
<smd name="EXP" x="0" y="0" dx="6" dy="6" layer="1" stop="no"/>
<text x="-3.9" y="4.55" size="1.27" layer="25">&gt;NAME</text>
<text x="-3.9" y="-5.525" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="-4.05" y1="3.05" x2="-3.525" y2="3.45" layer="29"/>
<rectangle x1="-4.05" y1="2.4" x2="-3.525" y2="2.8" layer="29"/>
<rectangle x1="-4.05" y1="1.75" x2="-3.525" y2="2.15" layer="29"/>
<rectangle x1="-4.05" y1="1.1" x2="-3.525" y2="1.5" layer="29"/>
<rectangle x1="-4.05" y1="0.45" x2="-3.525" y2="0.85" layer="29"/>
<rectangle x1="-4.05" y1="-0.2" x2="-3.525" y2="0.2" layer="29"/>
<rectangle x1="-4.05" y1="-0.85" x2="-3.525" y2="-0.45" layer="29"/>
<rectangle x1="-4.05" y1="-1.5" x2="-3.525" y2="-1.1" layer="29"/>
<rectangle x1="-4.05" y1="-2.15" x2="-3.525" y2="-1.75" layer="29"/>
<rectangle x1="-4.05" y1="-2.8" x2="-3.525" y2="-2.4" layer="29"/>
<rectangle x1="-4.05" y1="-3.45" x2="-3.525" y2="-3.05" layer="29"/>
<rectangle x1="-3.5125" y1="-3.9875" x2="-2.9875" y2="-3.5875" layer="29" rot="R90"/>
<rectangle x1="-2.8625" y1="-3.9875" x2="-2.3375" y2="-3.5875" layer="29" rot="R90"/>
<rectangle x1="-2.2125" y1="-3.9875" x2="-1.6875" y2="-3.5875" layer="29" rot="R90"/>
<rectangle x1="-1.5625" y1="-3.9875" x2="-1.0375" y2="-3.5875" layer="29" rot="R90"/>
<rectangle x1="-0.9125" y1="-3.9875" x2="-0.3875" y2="-3.5875" layer="29" rot="R90"/>
<rectangle x1="-0.2625" y1="-3.9875" x2="0.2625" y2="-3.5875" layer="29" rot="R90"/>
<rectangle x1="0.3875" y1="-3.9875" x2="0.9125" y2="-3.5875" layer="29" rot="R90"/>
<rectangle x1="1.0375" y1="-3.9875" x2="1.5625" y2="-3.5875" layer="29" rot="R90"/>
<rectangle x1="1.6875" y1="-3.9875" x2="2.2125" y2="-3.5875" layer="29" rot="R90"/>
<rectangle x1="2.3375" y1="-3.9875" x2="2.8625" y2="-3.5875" layer="29" rot="R90"/>
<rectangle x1="2.9875" y1="-3.9875" x2="3.5125" y2="-3.5875" layer="29" rot="R90"/>
<rectangle x1="3.525" y1="-3.45" x2="4.05" y2="-3.05" layer="29" rot="R180"/>
<rectangle x1="3.525" y1="-2.8" x2="4.05" y2="-2.4" layer="29" rot="R180"/>
<rectangle x1="3.525" y1="-2.15" x2="4.05" y2="-1.75" layer="29" rot="R180"/>
<rectangle x1="3.525" y1="-1.5" x2="4.05" y2="-1.1" layer="29" rot="R180"/>
<rectangle x1="3.525" y1="-0.85" x2="4.05" y2="-0.45" layer="29" rot="R180"/>
<rectangle x1="3.525" y1="-0.2" x2="4.05" y2="0.2" layer="29" rot="R180"/>
<rectangle x1="3.525" y1="0.45" x2="4.05" y2="0.85" layer="29" rot="R180"/>
<rectangle x1="3.525" y1="1.1" x2="4.05" y2="1.5" layer="29" rot="R180"/>
<rectangle x1="3.525" y1="1.75" x2="4.05" y2="2.15" layer="29" rot="R180"/>
<rectangle x1="3.525" y1="2.4" x2="4.05" y2="2.8" layer="29" rot="R180"/>
<rectangle x1="3.525" y1="3.05" x2="4.05" y2="3.45" layer="29" rot="R180"/>
<rectangle x1="2.9875" y1="3.5875" x2="3.5125" y2="3.9875" layer="29" rot="R270"/>
<rectangle x1="2.3375" y1="3.5875" x2="2.8625" y2="3.9875" layer="29" rot="R270"/>
<rectangle x1="1.6875" y1="3.5875" x2="2.2125" y2="3.9875" layer="29" rot="R270"/>
<rectangle x1="1.0375" y1="3.5875" x2="1.5625" y2="3.9875" layer="29" rot="R270"/>
<rectangle x1="0.3875" y1="3.5875" x2="0.9125" y2="3.9875" layer="29" rot="R270"/>
<rectangle x1="-0.2625" y1="3.5875" x2="0.2625" y2="3.9875" layer="29" rot="R270"/>
<rectangle x1="-0.9125" y1="3.5875" x2="-0.3875" y2="3.9875" layer="29" rot="R270"/>
<rectangle x1="-1.5625" y1="3.5875" x2="-1.0375" y2="3.9875" layer="29" rot="R270"/>
<rectangle x1="-2.2125" y1="3.5875" x2="-1.6875" y2="3.9875" layer="29" rot="R270"/>
<rectangle x1="-2.8625" y1="3.5875" x2="-2.3375" y2="3.9875" layer="29" rot="R270"/>
<rectangle x1="-3.5125" y1="3.5875" x2="-2.9875" y2="3.9875" layer="29" rot="R270"/>
<rectangle x1="-3.8375" y1="0.65" x2="-0.6625" y2="3.8375" layer="51"/>
<rectangle x1="-2.9625" y1="-2.9625" x2="2.9625" y2="2.9625" layer="29"/>
</package>
</packages>
<symbols>
<symbol name="ATMEGA644">
<wire x1="-22.86" y1="45.72" x2="20.32" y2="45.72" width="0.254" layer="94"/>
<wire x1="20.32" y1="45.72" x2="20.32" y2="-45.72" width="0.254" layer="94"/>
<wire x1="20.32" y1="-45.72" x2="-22.86" y2="-45.72" width="0.254" layer="94"/>
<wire x1="-22.86" y1="-45.72" x2="-22.86" y2="45.72" width="0.254" layer="94"/>
<text x="-22.86" y="-48.26" size="1.778" layer="96">&gt;VALUE</text>
<text x="-22.86" y="46.99" size="1.778" layer="95">&gt;NAME</text>
<pin name="(PCINT31/OC2A)PD7" x="25.4" y="-25.4" length="middle" rot="R180"/>
<pin name="(PCINT30/OC2B/ICP)PD6" x="25.4" y="-27.94" length="middle" rot="R180"/>
<pin name="(PCINT29/OC1A)PD5" x="25.4" y="-30.48" length="middle" rot="R180"/>
<pin name="(PCINT28/OC1B)PD4" x="25.4" y="-33.02" length="middle" rot="R180"/>
<pin name="(PCINT27/INT1)PD3" x="25.4" y="-35.56" length="middle" rot="R180"/>
<pin name="(PCINT26/INT0)PD2" x="25.4" y="-38.1" length="middle" rot="R180"/>
<pin name="(PCINT25/TXD0)PD1" x="25.4" y="-40.64" length="middle" rot="R180"/>
<pin name="(PCINT24/RXD0)PD0" x="25.4" y="-43.18" length="middle" rot="R180"/>
<pin name="(PCINT23/TOSC2)PC7" x="25.4" y="-2.54" length="middle" direction="out" rot="R180"/>
<pin name="(PCINT22/TOSC1)PC6" x="25.4" y="-5.08" length="middle" direction="out" rot="R180"/>
<pin name="(PCINT21/TDI)PC5" x="25.4" y="-7.62" length="middle" direction="out" rot="R180"/>
<pin name="(PCINT20/TDO)PC4" x="25.4" y="-10.16" length="middle" direction="out" rot="R180"/>
<pin name="(PCINT19/TMS)PC3" x="25.4" y="-12.7" length="middle" direction="out" rot="R180"/>
<pin name="(PCINT18/TCK)PC2" x="25.4" y="-15.24" length="middle" direction="out" rot="R180"/>
<pin name="(PCINT17/SDA)PC1" x="25.4" y="-17.78" length="middle" direction="out" rot="R180"/>
<pin name="(PCINT16/SCL)PC0" x="25.4" y="-20.32" length="middle" direction="out" rot="R180"/>
<pin name="(PCINT15/SCK)PB7" x="25.4" y="20.32" length="middle" rot="R180"/>
<pin name="(PCINT14/MISO)PB6" x="25.4" y="17.78" length="middle" rot="R180"/>
<pin name="(PCINT13/MOSI)PB5" x="25.4" y="15.24" length="middle" rot="R180"/>
<pin name="(PCINT12/OC0B/!SS!)PB4" x="25.4" y="12.7" length="middle" rot="R180"/>
<pin name="(PCINT11/OC0A/AIN1)PB3" x="25.4" y="10.16" length="middle" rot="R180"/>
<pin name="(PCINT10/INT2/AIN0)PB2" x="25.4" y="7.62" length="middle" rot="R180"/>
<pin name="(PCINT9/CLKO/T1)PB1" x="25.4" y="5.08" length="middle" rot="R180"/>
<pin name="(PCINT8/XCK0/T0)PB0" x="25.4" y="2.54" length="middle" rot="R180"/>
<pin name="(PCINT6/ADC6)PA6" x="25.4" y="40.64" length="middle" rot="R180"/>
<pin name="(PCINT7/ADC7)PA7" x="25.4" y="43.18" length="middle" rot="R180"/>
<pin name="(PCINT5/ADC5)PA5" x="25.4" y="38.1" length="middle" rot="R180"/>
<pin name="(PCINT4/ADC4)PA4" x="25.4" y="35.56" length="middle" rot="R180"/>
<pin name="(PCINT3/ADC3)PA3" x="25.4" y="33.02" length="middle" rot="R180"/>
<pin name="(PCINT2/ADC2)PA2" x="25.4" y="30.48" length="middle" rot="R180"/>
<pin name="(PCINT1/ADC1)PA1" x="25.4" y="27.94" length="middle" rot="R180"/>
<pin name="(PCINT0/ADC0)PA0" x="25.4" y="25.4" length="middle" rot="R180"/>
<pin name="AVCC" x="-27.94" y="15.24" length="middle" direction="pwr"/>
<pin name="AREF" x="-27.94" y="17.78" length="middle" direction="pas"/>
<pin name="XTAL1" x="-27.94" y="22.86" length="middle"/>
<pin name="XTAL2" x="-27.94" y="25.4" length="middle"/>
<pin name="VCC@1" x="-27.94" y="40.64" length="middle" direction="pwr"/>
<pin name="VCC" x="-27.94" y="43.18" length="middle" direction="pwr"/>
<pin name="GND@1" x="-27.94" y="-40.64" length="middle" direction="pwr"/>
<pin name="GND" x="-27.94" y="-43.18" length="middle" direction="pwr"/>
<pin name="RESET" x="-27.94" y="30.48" length="middle" direction="in" function="dot"/>
<pin name="GND@2" x="-27.94" y="-38.1" length="middle" direction="pwr"/>
<pin name="GND@3" x="-27.94" y="-35.56" length="middle" direction="pwr"/>
<pin name="VCC@2" x="-27.94" y="38.1" length="middle" direction="pwr"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="ATMEGA644" prefix="IC">
<description>&lt;b&gt;8-bit Microcontroller&lt;/b&gt; with 64K Bytes In-System Programmable Flash&lt;p&gt;
Source: http://www.atmel.com/dyn/resources/prod_documents/doc2593.pdf</description>
<gates>
<gate name="G$1" symbol="ATMEGA644" x="0" y="0"/>
</gates>
<devices>
<device name="A" package="TQFP44">
<connects>
<connect gate="G$1" pin="(PCINT0/ADC0)PA0" pad="37"/>
<connect gate="G$1" pin="(PCINT1/ADC1)PA1" pad="36"/>
<connect gate="G$1" pin="(PCINT10/INT2/AIN0)PB2" pad="42"/>
<connect gate="G$1" pin="(PCINT11/OC0A/AIN1)PB3" pad="43"/>
<connect gate="G$1" pin="(PCINT12/OC0B/!SS!)PB4" pad="44"/>
<connect gate="G$1" pin="(PCINT13/MOSI)PB5" pad="1"/>
<connect gate="G$1" pin="(PCINT14/MISO)PB6" pad="2"/>
<connect gate="G$1" pin="(PCINT15/SCK)PB7" pad="3"/>
<connect gate="G$1" pin="(PCINT16/SCL)PC0" pad="19"/>
<connect gate="G$1" pin="(PCINT17/SDA)PC1" pad="20"/>
<connect gate="G$1" pin="(PCINT18/TCK)PC2" pad="21"/>
<connect gate="G$1" pin="(PCINT19/TMS)PC3" pad="22"/>
<connect gate="G$1" pin="(PCINT2/ADC2)PA2" pad="35"/>
<connect gate="G$1" pin="(PCINT20/TDO)PC4" pad="23"/>
<connect gate="G$1" pin="(PCINT21/TDI)PC5" pad="24"/>
<connect gate="G$1" pin="(PCINT22/TOSC1)PC6" pad="25"/>
<connect gate="G$1" pin="(PCINT23/TOSC2)PC7" pad="26"/>
<connect gate="G$1" pin="(PCINT24/RXD0)PD0" pad="9"/>
<connect gate="G$1" pin="(PCINT25/TXD0)PD1" pad="10"/>
<connect gate="G$1" pin="(PCINT26/INT0)PD2" pad="11"/>
<connect gate="G$1" pin="(PCINT27/INT1)PD3" pad="12"/>
<connect gate="G$1" pin="(PCINT28/OC1B)PD4" pad="13"/>
<connect gate="G$1" pin="(PCINT29/OC1A)PD5" pad="14"/>
<connect gate="G$1" pin="(PCINT3/ADC3)PA3" pad="34"/>
<connect gate="G$1" pin="(PCINT30/OC2B/ICP)PD6" pad="15"/>
<connect gate="G$1" pin="(PCINT31/OC2A)PD7" pad="16"/>
<connect gate="G$1" pin="(PCINT4/ADC4)PA4" pad="33"/>
<connect gate="G$1" pin="(PCINT5/ADC5)PA5" pad="32"/>
<connect gate="G$1" pin="(PCINT6/ADC6)PA6" pad="31"/>
<connect gate="G$1" pin="(PCINT7/ADC7)PA7" pad="30"/>
<connect gate="G$1" pin="(PCINT8/XCK0/T0)PB0" pad="40"/>
<connect gate="G$1" pin="(PCINT9/CLKO/T1)PB1" pad="41"/>
<connect gate="G$1" pin="AREF" pad="29"/>
<connect gate="G$1" pin="AVCC" pad="27"/>
<connect gate="G$1" pin="GND" pad="6"/>
<connect gate="G$1" pin="GND@1" pad="18"/>
<connect gate="G$1" pin="GND@2" pad="28"/>
<connect gate="G$1" pin="GND@3" pad="39"/>
<connect gate="G$1" pin="RESET" pad="4"/>
<connect gate="G$1" pin="VCC" pad="5"/>
<connect gate="G$1" pin="VCC@1" pad="17"/>
<connect gate="G$1" pin="VCC@2" pad="38"/>
<connect gate="G$1" pin="XTAL1" pad="8"/>
<connect gate="G$1" pin="XTAL2" pad="7"/>
</connects>
<technologies>
<technology name="">
<attribute name="MF" value="" constant="no"/>
<attribute name="MPN" value="ATMEGA644PV-10AU" constant="no"/>
<attribute name="OC_FARNELL" value="1455123" constant="no"/>
<attribute name="OC_NEWARK" value="58M3748" constant="no"/>
</technology>
</technologies>
</device>
<device name="M" package="QFN44ML8X8">
<connects>
<connect gate="G$1" pin="(PCINT0/ADC0)PA0" pad="37"/>
<connect gate="G$1" pin="(PCINT1/ADC1)PA1" pad="36"/>
<connect gate="G$1" pin="(PCINT10/INT2/AIN0)PB2" pad="42"/>
<connect gate="G$1" pin="(PCINT11/OC0A/AIN1)PB3" pad="43"/>
<connect gate="G$1" pin="(PCINT12/OC0B/!SS!)PB4" pad="44"/>
<connect gate="G$1" pin="(PCINT13/MOSI)PB5" pad="1"/>
<connect gate="G$1" pin="(PCINT14/MISO)PB6" pad="2"/>
<connect gate="G$1" pin="(PCINT15/SCK)PB7" pad="3"/>
<connect gate="G$1" pin="(PCINT16/SCL)PC0" pad="19"/>
<connect gate="G$1" pin="(PCINT17/SDA)PC1" pad="20"/>
<connect gate="G$1" pin="(PCINT18/TCK)PC2" pad="21"/>
<connect gate="G$1" pin="(PCINT19/TMS)PC3" pad="22"/>
<connect gate="G$1" pin="(PCINT2/ADC2)PA2" pad="35"/>
<connect gate="G$1" pin="(PCINT20/TDO)PC4" pad="23"/>
<connect gate="G$1" pin="(PCINT21/TDI)PC5" pad="24"/>
<connect gate="G$1" pin="(PCINT22/TOSC1)PC6" pad="25"/>
<connect gate="G$1" pin="(PCINT23/TOSC2)PC7" pad="26"/>
<connect gate="G$1" pin="(PCINT24/RXD0)PD0" pad="9"/>
<connect gate="G$1" pin="(PCINT25/TXD0)PD1" pad="10"/>
<connect gate="G$1" pin="(PCINT26/INT0)PD2" pad="11"/>
<connect gate="G$1" pin="(PCINT27/INT1)PD3" pad="12"/>
<connect gate="G$1" pin="(PCINT28/OC1B)PD4" pad="13"/>
<connect gate="G$1" pin="(PCINT29/OC1A)PD5" pad="14"/>
<connect gate="G$1" pin="(PCINT3/ADC3)PA3" pad="34"/>
<connect gate="G$1" pin="(PCINT30/OC2B/ICP)PD6" pad="15"/>
<connect gate="G$1" pin="(PCINT31/OC2A)PD7" pad="16"/>
<connect gate="G$1" pin="(PCINT4/ADC4)PA4" pad="33"/>
<connect gate="G$1" pin="(PCINT5/ADC5)PA5" pad="32"/>
<connect gate="G$1" pin="(PCINT6/ADC6)PA6" pad="31"/>
<connect gate="G$1" pin="(PCINT7/ADC7)PA7" pad="30"/>
<connect gate="G$1" pin="(PCINT8/XCK0/T0)PB0" pad="40"/>
<connect gate="G$1" pin="(PCINT9/CLKO/T1)PB1" pad="41"/>
<connect gate="G$1" pin="AREF" pad="29"/>
<connect gate="G$1" pin="AVCC" pad="27"/>
<connect gate="G$1" pin="GND" pad="6"/>
<connect gate="G$1" pin="GND@1" pad="18"/>
<connect gate="G$1" pin="GND@2" pad="28"/>
<connect gate="G$1" pin="GND@3" pad="39"/>
<connect gate="G$1" pin="RESET" pad="4"/>
<connect gate="G$1" pin="VCC" pad="5"/>
<connect gate="G$1" pin="VCC@1" pad="17"/>
<connect gate="G$1" pin="VCC@2" pad="38"/>
<connect gate="G$1" pin="XTAL1" pad="8"/>
<connect gate="G$1" pin="XTAL2" pad="7"/>
</connects>
<technologies>
<technology name="">
<attribute name="MF" value="" constant="no"/>
<attribute name="MPN" value="ATMEGA644PV-10MU" constant="no"/>
<attribute name="OC_FARNELL" value="1748529" constant="no"/>
<attribute name="OC_NEWARK" value="26R5637" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="crystal">
<description>&lt;b&gt;Crystals and Crystal Resonators&lt;/b&gt;&lt;p&gt;
&lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
<package name="HC49U">
<description>&lt;b&gt;Crystal Filter&lt;/b&gt;&lt;p&gt;
Source: www.ilsiamerica.com .. C1 IXF Series.pdf</description>
<wire x1="-2.921" y1="-2.286" x2="2.921" y2="-2.286" width="0.4064" layer="21"/>
<wire x1="-2.921" y1="2.286" x2="2.921" y2="2.286" width="0.4064" layer="21"/>
<wire x1="-2.921" y1="-1.778" x2="2.921" y2="-1.778" width="0.1524" layer="21"/>
<wire x1="2.921" y1="1.778" x2="-2.921" y2="1.778" width="0.1524" layer="21"/>
<wire x1="2.921" y1="1.778" x2="2.921" y2="-1.778" width="0.1524" layer="21" curve="-180"/>
<wire x1="2.921" y1="2.286" x2="2.921" y2="-2.286" width="0.4064" layer="21" curve="-180"/>
<wire x1="-2.921" y1="2.286" x2="-2.921" y2="-2.286" width="0.4064" layer="21" curve="180"/>
<wire x1="-2.921" y1="1.778" x2="-2.921" y2="-1.778" width="0.1524" layer="21" curve="180"/>
<wire x1="-0.25" y1="1" x2="0.25" y2="1" width="0.1524" layer="51"/>
<wire x1="0.25" y1="1" x2="0.25" y2="-0.25" width="0.1524" layer="51"/>
<wire x1="0.25" y1="-0.25" x2="-0.25" y2="-0.25" width="0.1524" layer="51"/>
<wire x1="-0.25" y1="-0.25" x2="-0.25" y2="1" width="0.1524" layer="51"/>
<wire x1="0.75" y1="1" x2="0.75" y2="0.25" width="0.1524" layer="51"/>
<wire x1="0.75" y1="0.25" x2="0.75" y2="-0.5" width="0.1524" layer="51"/>
<wire x1="-0.75" y1="1" x2="-0.75" y2="0.25" width="0.1524" layer="51"/>
<wire x1="-0.75" y1="0.25" x2="-0.75" y2="-0.5" width="0.1524" layer="51"/>
<wire x1="0.75" y1="0.25" x2="1.5" y2="0.25" width="0.1524" layer="51"/>
<wire x1="-0.75" y1="0.25" x2="-1.5" y2="0.25" width="0.1524" layer="51"/>
<wire x1="-0.75" y1="-0.5" x2="0.75" y2="-0.5" width="0.1524" layer="51"/>
<wire x1="0" y1="-1.25" x2="0" y2="-0.625" width="0.1524" layer="51"/>
<pad name="1" x="-2.413" y="0" drill="0.7" diameter="1.2"/>
<pad name="2" x="-0.027" y="0" drill="0.7" diameter="1.2"/>
<pad name="3" x="2.413" y="0" drill="0.7" diameter="1.2"/>
<text x="-5.08" y="2.921" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-5.08" y="-4.191" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
</packages>
<symbols>
<symbol name="CRYSTAL-FILTER-3-POL">
<wire x1="1.016" y1="0" x2="2.54" y2="0" width="0.1524" layer="94"/>
<wire x1="-2.54" y1="0" x2="-1.016" y2="0" width="0.1524" layer="94"/>
<wire x1="-0.381" y1="1.524" x2="-0.381" y2="-1.524" width="0.254" layer="94"/>
<wire x1="-0.381" y1="-1.524" x2="0.381" y2="-1.524" width="0.254" layer="94"/>
<wire x1="0.381" y1="-1.524" x2="0.381" y2="1.524" width="0.254" layer="94"/>
<wire x1="0.381" y1="1.524" x2="-0.381" y2="1.524" width="0.254" layer="94"/>
<wire x1="1.016" y1="1.778" x2="1.016" y2="-1.778" width="0.254" layer="94"/>
<wire x1="-1.016" y1="1.778" x2="-1.016" y2="-1.778" width="0.254" layer="94"/>
<wire x1="-1.778" y1="1.905" x2="-1.778" y2="2.54" width="0.1524" layer="94"/>
<wire x1="-1.778" y1="2.54" x2="1.778" y2="2.54" width="0.1524" layer="94"/>
<wire x1="1.778" y1="2.54" x2="1.778" y2="1.905" width="0.1524" layer="94"/>
<wire x1="1.778" y1="-1.905" x2="1.778" y2="-2.54" width="0.1524" layer="94"/>
<wire x1="-1.778" y1="-2.54" x2="1.778" y2="-2.54" width="0.1524" layer="94"/>
<wire x1="-1.778" y1="-2.54" x2="-1.778" y2="-1.905" width="0.1524" layer="94"/>
<text x="2.54" y="1.016" size="1.778" layer="95">&gt;NAME</text>
<text x="2.54" y="-2.54" size="1.778" layer="96">&gt;VALUE</text>
<text x="-2.159" y="-1.143" size="0.8636" layer="93">1</text>
<text x="-1.016" y="-3.683" size="0.8636" layer="93">2</text>
<text x="1.524" y="-1.143" size="0.8636" layer="93">3</text>
<pin name="3" x="2.54" y="0" visible="off" length="point" direction="pas" swaplevel="1" rot="R270"/>
<pin name="1" x="-2.54" y="0" visible="off" length="point" direction="pas" swaplevel="1"/>
<pin name="2" x="0" y="-5.08" visible="off" length="short" direction="pas" rot="R90"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="12M10AHC49HT" prefix="QF">
<description>&lt;b&gt;Monolithic Crystal Filters&lt;/b&gt;&lt;p&gt;
Source: www.vanlong.com</description>
<gates>
<gate name="G$1" symbol="CRYSTAL-FILTER-3-POL" x="0" y="0"/>
</gates>
<devices>
<device name="" package="HC49U">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
<connect gate="G$1" pin="3" pad="3"/>
</connects>
<technologies>
<technology name="">
<attribute name="MF" value="" constant="no"/>
<attribute name="MPN" value="" constant="no"/>
<attribute name="OC_FARNELL" value="unknown" constant="no"/>
<attribute name="OC_NEWARK" value="unknown" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="docu-dummy">
<description>Dummy symbols</description>
<packages>
</packages>
<symbols>
<symbol name="CAPACITOR">
<wire x1="0" y1="-5.08" x2="0" y2="-2.032" width="0.1524" layer="94"/>
<wire x1="0" y1="-0.508" x2="0" y2="2.54" width="0.1524" layer="94"/>
<rectangle x1="-2.032" y1="-2.032" x2="2.032" y2="-1.524" layer="94"/>
<rectangle x1="-2.032" y1="-1.016" x2="2.032" y2="-0.508" layer="94"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="C" prefix="C">
<description>&lt;b&gt;CAPACITOR&lt;/b&gt;</description>
<gates>
<gate name="G$1" symbol="CAPACITOR" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="resistor-shunt">
<description>&lt;b&gt;Isabellenhuette SMD Shunt Resistors&lt;/b&gt;&lt;p&gt;
www.isabellenhuette.de&lt;p&gt;
&lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
<package name="BVS">
<description>&lt;b&gt;SMD SHUNT RESISTOR&lt;/b&gt;</description>
<wire x1="-4.9" y1="-2.5" x2="-2.5" y2="-2.5" width="0.2032" layer="51"/>
<wire x1="-2.5" y1="-2.5" x2="2.5" y2="-2.5" width="0.2032" layer="21"/>
<wire x1="2.5" y1="-2.5" x2="4.9" y2="-2.5" width="0.2032" layer="51"/>
<wire x1="4.9" y1="-2.5" x2="4.9" y2="2.5" width="0.2032" layer="51"/>
<wire x1="4.9" y1="2.5" x2="2.5" y2="2.5" width="0.2032" layer="51"/>
<wire x1="2.5" y1="2.5" x2="-2.5" y2="2.5" width="0.2032" layer="21"/>
<wire x1="-2.5" y1="2.5" x2="-4.9" y2="2.5" width="0.2032" layer="51"/>
<wire x1="-4.9" y1="2.5" x2="-4.9" y2="-2.5" width="0.2032" layer="51"/>
<wire x1="-2.5" y1="-2.5" x2="-2.5" y2="2.5" width="0.2032" layer="21"/>
<wire x1="2.5" y1="2.5" x2="2.5" y2="-2.5" width="0.2032" layer="21"/>
<smd name="1" x="-4.1402" y="0" dx="2.7" dy="6.2" layer="1"/>
<smd name="2" x="4.1402" y="0" dx="2.7" dy="6.2" layer="1"/>
<text x="-2.1336" y="0.7874" size="1.27" layer="25">&gt;NAME</text>
<text x="-2.1336" y="-1.9812" size="1.27" layer="27">&gt;VALUE</text>
</package>
</packages>
<symbols>
<symbol name="R">
<wire x1="2.54" y1="0.889" x2="-2.54" y2="0.889" width="0.254" layer="94"/>
<wire x1="-2.54" y1="-0.889" x2="2.54" y2="-0.889" width="0.254" layer="94"/>
<wire x1="-2.54" y1="0.889" x2="-2.54" y2="-0.889" width="0.254" layer="94"/>
<wire x1="2.54" y1="0.889" x2="2.54" y2="-0.889" width="0.254" layer="94"/>
<text x="-3.81" y="1.3716" size="1.778" layer="95">&gt;NAME</text>
<text x="-3.81" y="-2.921" size="1.778" layer="96">&gt;VALUE</text>
<pin name="2" x="-5.08" y="0" visible="off" length="short" direction="pas" swaplevel="1"/>
<pin name="1" x="5.08" y="0" visible="off" length="short" direction="pas" swaplevel="1" rot="R180"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="BVS" prefix="R" uservalue="yes">
<description>&lt;b&gt;SMD SHUNT RESISTOR&lt;/b&gt;</description>
<gates>
<gate name="G$1" symbol="R" x="0" y="0"/>
</gates>
<devices>
<device name="" package="BVS">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name="">
<attribute name="MF" value="" constant="no"/>
<attribute name="MPN" value="" constant="no"/>
<attribute name="OC_FARNELL" value="unknown" constant="no"/>
<attribute name="OC_NEWARK" value="unknown" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
</libraries>
<attributes>
</attributes>
<variantdefs>
</variantdefs>
<classes>
<class number="0" name="default" width="0" drill="0">
</class>
</classes>
<parts>
<part name="IC1" library="atmel" deviceset="ATMEGA644" device="A"/>
<part name="20MHZ" library="crystal" deviceset="12M10AHC49HT" device="" value=""/>
<part name="C1" library="docu-dummy" deviceset="C" device=""/>
<part name="C2" library="docu-dummy" deviceset="C" device=""/>
<part name="R1" library="resistor-shunt" deviceset="BVS" device="" value="1k"/>
<part name="R2" library="resistor-shunt" deviceset="BVS" device="" value="2k"/>
<part name="R3" library="resistor-shunt" deviceset="BVS" device="" value="1k"/>
<part name="R4" library="resistor-shunt" deviceset="BVS" device="" value="2k"/>
<part name="R6" library="resistor-shunt" deviceset="BVS" device="" value="2k"/>
<part name="R5" library="resistor-shunt" deviceset="BVS" device="" value="1k"/>
</parts>
<sheets>
<sheet>
<plain>
<text x="20.32" y="96.52" size="1.778" layer="91">Vcc</text>
<text x="20.32" y="25.4" size="1.778" layer="91">GND</text>
<text x="152.4" y="86.36" size="1.778" layer="91">R</text>
<text x="154.94" y="86.36" size="1.778" layer="91">G</text>
<text x="157.48" y="86.36" size="1.778" layer="91">B</text>
<text x="139.7" y="86.36" size="1.778" layer="91">HSYNC</text>
<text x="129.54" y="86.36" size="1.778" layer="91">VSYNC</text>
</plain>
<instances>
<instance part="IC1" gate="G$1" x="60.96" y="48.26"/>
<instance part="20MHZ" gate="G$1" x="17.78" y="73.66" rot="R90"/>
<instance part="C1" gate="G$1" x="10.16" y="71.12" rot="R90"/>
<instance part="C2" gate="G$1" x="10.16" y="76.2" rot="R90"/>
<instance part="R1" gate="G$1" x="142.24" y="50.8"/>
<instance part="R2" gate="G$1" x="142.24" y="43.18"/>
<instance part="R3" gate="G$1" x="142.24" y="35.56"/>
<instance part="R4" gate="G$1" x="142.24" y="27.94"/>
<instance part="R6" gate="G$1" x="142.24" y="12.7"/>
<instance part="R5" gate="G$1" x="142.24" y="20.32"/>
</instances>
<busses>
</busses>
<nets>
<net name="N$1" class="0">
<segment>
<pinref part="IC1" gate="G$1" pin="VCC"/>
<wire x1="33.02" y1="91.44" x2="20.32" y2="91.44" width="0.1524" layer="91"/>
<wire x1="20.32" y1="91.44" x2="20.32" y2="88.9" width="0.1524" layer="91"/>
<pinref part="IC1" gate="G$1" pin="VCC@1"/>
<wire x1="33.02" y1="88.9" x2="20.32" y2="88.9" width="0.1524" layer="91"/>
<wire x1="20.32" y1="88.9" x2="20.32" y2="86.36" width="0.1524" layer="91"/>
<pinref part="IC1" gate="G$1" pin="VCC@2"/>
<wire x1="20.32" y1="86.36" x2="33.02" y2="86.36" width="0.1524" layer="91"/>
<wire x1="20.32" y1="91.44" x2="20.32" y2="96.52" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$2" class="0">
<segment>
<pinref part="IC1" gate="G$1" pin="GND@3"/>
<wire x1="33.02" y1="12.7" x2="20.32" y2="12.7" width="0.1524" layer="91"/>
<wire x1="20.32" y1="12.7" x2="20.32" y2="25.4" width="0.1524" layer="91"/>
<wire x1="20.32" y1="12.7" x2="20.32" y2="10.16" width="0.1524" layer="91"/>
<pinref part="IC1" gate="G$1" pin="GND@2"/>
<wire x1="33.02" y1="10.16" x2="20.32" y2="10.16" width="0.1524" layer="91"/>
<wire x1="20.32" y1="10.16" x2="20.32" y2="7.62" width="0.1524" layer="91"/>
<pinref part="IC1" gate="G$1" pin="GND@1"/>
<wire x1="33.02" y1="7.62" x2="20.32" y2="7.62" width="0.1524" layer="91"/>
<wire x1="20.32" y1="7.62" x2="20.32" y2="5.08" width="0.1524" layer="91"/>
<pinref part="IC1" gate="G$1" pin="GND"/>
<wire x1="20.32" y1="5.08" x2="33.02" y2="5.08" width="0.1524" layer="91"/>
<wire x1="7.62" y1="76.2" x2="7.62" y2="25.4" width="0.1524" layer="91"/>
<wire x1="7.62" y1="25.4" x2="20.32" y2="25.4" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$3" class="0">
<segment>
<pinref part="IC1" gate="G$1" pin="(PCINT16/SCL)PC0"/>
<wire x1="86.36" y1="27.94" x2="111.76" y2="27.94" width="0.1524" layer="91"/>
<pinref part="R6" gate="G$1" pin="2"/>
<wire x1="137.16" y1="12.7" x2="111.76" y2="12.7" width="0.1524" layer="91"/>
<wire x1="111.76" y1="12.7" x2="111.76" y2="27.94" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$4" class="0">
<segment>
<pinref part="IC1" gate="G$1" pin="(PCINT17/SDA)PC1"/>
<wire x1="86.36" y1="30.48" x2="116.84" y2="30.48" width="0.1524" layer="91"/>
<pinref part="R5" gate="G$1" pin="2"/>
<wire x1="137.16" y1="20.32" x2="116.84" y2="20.32" width="0.1524" layer="91"/>
<wire x1="116.84" y1="20.32" x2="116.84" y2="30.48" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$5" class="0">
<segment>
<pinref part="IC1" gate="G$1" pin="(PCINT18/TCK)PC2"/>
<wire x1="119.38" y1="33.02" x2="86.36" y2="33.02" width="0.1524" layer="91"/>
<pinref part="R4" gate="G$1" pin="2"/>
<wire x1="137.16" y1="27.94" x2="119.38" y2="27.94" width="0.1524" layer="91"/>
<wire x1="119.38" y1="27.94" x2="119.38" y2="33.02" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$6" class="0">
<segment>
<pinref part="IC1" gate="G$1" pin="(PCINT19/TMS)PC3"/>
<wire x1="137.16" y1="35.56" x2="86.36" y2="35.56" width="0.1524" layer="91"/>
<pinref part="R3" gate="G$1" pin="2"/>
</segment>
</net>
<net name="N$8" class="0">
<segment>
<pinref part="IC1" gate="G$1" pin="(PCINT21/TDI)PC5"/>
<wire x1="86.36" y1="40.64" x2="132.08" y2="40.64" width="0.1524" layer="91"/>
<wire x1="132.08" y1="40.64" x2="132.08" y2="50.8" width="0.1524" layer="91"/>
<pinref part="R1" gate="G$1" pin="2"/>
<wire x1="132.08" y1="50.8" x2="137.16" y2="50.8" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$9" class="0">
<segment>
<pinref part="IC1" gate="G$1" pin="XTAL2"/>
<wire x1="33.02" y1="73.66" x2="25.4" y2="73.66" width="0.1524" layer="91"/>
<wire x1="25.4" y1="73.66" x2="25.4" y2="76.2" width="0.1524" layer="91"/>
<wire x1="25.4" y1="76.2" x2="17.78" y2="76.2" width="0.1524" layer="91"/>
<pinref part="20MHZ" gate="G$1" pin="3"/>
<wire x1="17.78" y1="76.2" x2="12.7" y2="76.2" width="0.1524" layer="91"/>
<junction x="17.78" y="76.2"/>
</segment>
</net>
<net name="N$10" class="0">
<segment>
<pinref part="IC1" gate="G$1" pin="XTAL1"/>
<wire x1="33.02" y1="71.12" x2="12.7" y2="71.12" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$7" class="0">
<segment>
<pinref part="R2" gate="G$1" pin="2"/>
<wire x1="137.16" y1="43.18" x2="137.16" y2="38.1" width="0.1524" layer="91"/>
<pinref part="IC1" gate="G$1" pin="(PCINT20/TDO)PC4"/>
<wire x1="137.16" y1="38.1" x2="86.36" y2="38.1" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$11" class="0">
<segment>
<pinref part="R6" gate="G$1" pin="1"/>
<pinref part="R5" gate="G$1" pin="1"/>
<wire x1="147.32" y1="12.7" x2="147.32" y2="15.24" width="0.1524" layer="91"/>
<wire x1="147.32" y1="15.24" x2="147.32" y2="20.32" width="0.1524" layer="91"/>
<wire x1="147.32" y1="15.24" x2="157.48" y2="15.24" width="0.1524" layer="91"/>
<wire x1="157.48" y1="15.24" x2="157.48" y2="86.36" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$12" class="0">
<segment>
<pinref part="R4" gate="G$1" pin="1"/>
<pinref part="R3" gate="G$1" pin="1"/>
<wire x1="147.32" y1="27.94" x2="147.32" y2="33.02" width="0.1524" layer="91"/>
<wire x1="147.32" y1="33.02" x2="147.32" y2="35.56" width="0.1524" layer="91"/>
<wire x1="147.32" y1="33.02" x2="154.94" y2="33.02" width="0.1524" layer="91"/>
<wire x1="154.94" y1="33.02" x2="154.94" y2="86.36" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$13" class="0">
<segment>
<pinref part="R2" gate="G$1" pin="1"/>
<pinref part="R1" gate="G$1" pin="1"/>
<wire x1="147.32" y1="43.18" x2="147.32" y2="48.26" width="0.1524" layer="91"/>
<wire x1="147.32" y1="48.26" x2="147.32" y2="50.8" width="0.1524" layer="91"/>
<wire x1="147.32" y1="48.26" x2="152.4" y2="48.26" width="0.1524" layer="91"/>
<wire x1="152.4" y1="48.26" x2="152.4" y2="86.36" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$14" class="0">
<segment>
<pinref part="IC1" gate="G$1" pin="(PCINT8/XCK0/T0)PB0"/>
<wire x1="86.36" y1="50.8" x2="127" y2="50.8" width="0.1524" layer="91"/>
<wire x1="127" y1="50.8" x2="127" y2="55.88" width="0.1524" layer="91"/>
<wire x1="127" y1="55.88" x2="139.7" y2="55.88" width="0.1524" layer="91"/>
<wire x1="139.7" y1="55.88" x2="139.7" y2="86.36" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$15" class="0">
<segment>
<pinref part="IC1" gate="G$1" pin="(PCINT9/CLKO/T1)PB1"/>
<wire x1="86.36" y1="53.34" x2="124.46" y2="53.34" width="0.1524" layer="91"/>
<wire x1="124.46" y1="53.34" x2="124.46" y2="58.42" width="0.1524" layer="91"/>
<wire x1="124.46" y1="58.42" x2="129.54" y2="58.42" width="0.1524" layer="91"/>
<wire x1="129.54" y1="58.42" x2="129.54" y2="86.36" width="0.1524" layer="91"/>
</segment>
</net>
</nets>
</sheet>
</sheets>
</schematic>
</drawing>
</eagle>
