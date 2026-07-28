 


BAF4P1
Reference Manual








Rev. [0.1]
15 Jul 2026

Revision History
Rev	Date	Author	Description 
0.1	10/05/2024	Xin	1)	Add typical application scenario configuration steps
2)	Add detail description in overview and block diagram section
0.2	22/05/2024	Xin	1） Add zmeas reg ctrl[7] and change zmeas reg ctrl description to match with real meaning
2） add bit4 of pmu_ctrl for FIFO disable
0.3	23/05/2024	Jaya	Trim and analog register tables are created
0.4	24/05/2024	Xin	Add bit7 of reg_ctrl of bioelectric for ppg mode
0.5	28/05/2024	Xin 	Add  ppg mode description, sync with ppg_controller
0.6	30/05/2024	Xin 	Add bit1,bit2 in int status for bioelectric module, it is for ppg mode only
0.7	31/05/2024	Xin	Add bit1 of bioelectric_ctrl for restart calculation option when switch back to filter
0.8	03/06/2024	Xin	Add bit5 of pmu_ctrl for ppg_ctrl disable
0.9	05/06/2024	Xin	Add 0x3A register for ac lead off detection and sdm clock output
1.0	11/06/2024	Xin	Add 0x3B register for zmeas clock divider
1.1	13/06/2024	Xin	1) Add 0x3B-0x3D register for update zmeas clock divider and check interval
2)Add bio electricity test flow chapter
3) add bioelectric bit2 of reg_ctrl for bio interrupt enable
4) add bio interrupt status bit 0x4, 0x76
5) add bit6 of 0x41 pmu_reg for disable bio clock divider
1.2	17/06/2024	Xin	1)	Add device status bit6,5 for lead off interupt
2)	Add 0x78-0x7e, 0x85-0x86 for dc and square wave form generation
3)	0x87-0x8a for lead off control
4)	Change 0x3A default value and bit width for aclead off
5)	Remove redundant analog signals in analog top
1.3	25/06/2024	Xin	1)	Move square data high/low to flash
1.4	25/06/2024	Zhen 	Added 5 analog trims
1.5	02/07/2024	Xin	1)	Change acleadoff_clk_sel default to 10(32K)
2)	Add 0x49(RLD_CLK_SEL) register for RLD clock generation
1.6	04/07/2024	Xin	Change reg_freq_val default to 1(500hz)

1.7	17/7/2024	Zhen	Added the fuction about reading/writing 256 bytes of flash, see section1.8.5
1.8	22/08/2024	Xin	Add the bioelectric_en disable flow
1.9	29/08/2024	Xin	Change the i/z meas diagram and bio electrical diagram
Add more description for bio electrical description
Remove redundant register and description of zmeas
2.0	25/03/2025	Xin	Add more detail description of PPG_LED_TIME_SEL and PPG_LED_FREQ_SEL
2.1	26/03/2026	Xin	Add 0x7B to 0x7E register  and bit6 of 0x72 for flexible programmable ledon and period
2.2	27/03/2026	Xin	1)	Add LEAD_OFF_CTRL following bits for more flexible setting
Bit6: leadoff high/low active
0: high active
1: low active
Bit5:4 lead off switch/duration selector
00: switch&duration
01: switch only
10: duration only
11: switch&duration
2)	LEADOFF_INT for leadoff interrupt status
3.0	8/7/2026	Zhen 	1.	port the flash code of BMS6 to BAF4P1(flash comtroller and flash bist )
2.	Modify the code based on the original architecture of baf1p4(trims, coeffs,ATM etc)

 Contents

REVISION HISTORY	1
CONTENTS	4
FEATURES	14
APPLICATIONS	14
1. OVERVIEW	14
1.1. BLOCK DIAGRAM	16
2. REGISTERS	19
2.1. REGISTER MAP	19
3. ALWAYS ON POWER DOMAIN	23
3.1. OVERVIEW	23
3.2. SHADOW REGISTERS	24
4. SWITCHABLE POWER DOMAIN	26
4.1. SYSTEM CONTROL	26
4.1.1. Reset Control	27
4.1.2. Clock Control	27
4.1.3. Power managRDnt unit (PMU)	27
4.2. REGISTERS	28
5. FLASH CONTROLLER	30
5.1. OVERVIEW	30
5.2. BLOCK DIAGRAM	31
5.3. FUNCTION	31
5.3.1. Reload analog trim	32
5.3.2. Reload Redundancy Parameter	33
5.3.3. Write Analog Trim Data to Flash NVR0 Memory	33
5.3.4. Read Data from Flash NVR0 Memory	33
5.3.5. Write Data to Flash Memory (MAIN - 32K, NVR0 (512-byte except for first 32-address of TRIMs, RND (512-byte)	34
5.3.6. Write function for TRIM registers (to write from SPI into AO shadow registers)	34
5.3.7. Sector erase	35
5.3.8. Chip erase	35
5.3.9. Deep Standby mode	36
5.3.10. DEBUG MODE	36
5.4. FLASH BIST CONTROLLER	36
5.4.1. Block Diagram	36
5.5. PIN TABLE	37
5.6. ATM MODE	38
5.6.1. Introduction	38
5.6.2. Protection NVR0	40
5.7. FSM	40
5.8. TEST BENCH	40
5.9. TIMING	41
5.10. REGISTERS	41
5.10.1. FLASH_DEBUG1: Offset Address: 0x50	43
5.10.2. FLASH_DEBUG2: Offset Address: 0x51	43
5.10.3. FLASH_TRIM0: Offset Address: 0x52	44
5.10.4. FLASH_TRIM1: Offset Address: 0x53	44
5.10.5. FLASH_TRIM2: Offset Address: 0x54	44
5.10.6. FLASH_TRIM3: Offset Address: 0x55	44
5.10.7. FLASH_TRIM4: Offset Address: 0x56	44
5.10.8. FLASH_TRIM5: Offset Address: 0x57	45
5.10.9. FLASH_TRIM6: Offset Address: 0x58	45
5.10.10. FLASH_TRIM7: Offset Address: 0x59	45
5.10.11. FLASH_TRIM8: Offset Address: 0x5A	45
5.10.12. FLASH_TRIM9: Offset Address: 0x5B	45
5.10.13. FLASH_TRIM10: Offset Address: 0x5C	46
5.10.14. FLASH_TRIM11: Offset Address: 0x5D	46
5.10.15. FLASH_TRIM12: Offset Address: 0x5E	46
5.10.16. FLASH_TRIM13: Offset Address: 0x5F	46
5.10.17. FLASH_TRIM14: Offset Address: 0x60	47
5.10.18. FLASH_TRIM15: Offset Address: 0x61	47
5.10.19. FLASH_TRIM16: Offset Address: 0x62	47
5.10.20. FLASH_TRIM17: Offset Address: 0x63	47
5.10.21. FLASH_TRIM18: Offset Address: 0x64	47
5.10.22. FLASH_TRIM19: Offset Address: 0x65	48
5.10.23. FLASH_TRIM20: Offset Address: 0x66	48
5.10.24. FLASH_UNLOCK: Offset Address: 0x67	48
5.10.25. FLASH_CTRL: Offset Address: 0x68	48
5.10.26. FLASH_DATA00: Offset Address: 0x69	49
5.10.27. FLASH_ADDR00: Offset Address: 0x6A	49
5.10.28. FLASH_ADDR01: Offset Address: 0x6B	49
5.10.29. FLASH_NVR_PRO_BYTE00: Offset Address: 0x6E	49
5.10.30. FLASH_NVR_PRO_BYTE01: Offset Address: 0x6F	49
5.10.31. FLASH_UNLOCK_PRO: Offset Address: 0x70	50
5.10.32. FLASH_EME_DATA00: Offset Address: 0x6C	50
5.10.33. FLASH_RND_ADDR: Offset Address: 0x6D	50
5.10.34. DEVICE_INT_STATUS_0: Offset Address: 0xD0	50
5.10.35. DEVICE_INT_STATUS_1: Offset Address: 0xD1	51
6. ANALOG REGISTERS	53
6.1. REGISTERS	53
6.1.1. Analog Registers	53
6.1.2. Analog Debug Registers	59
7. BIOELECTRIC FILTER	62
7.1. BLOCK DIAGRAM	62
7.2. CONFIGURATION SEQUENCE	63
7.2.1. Single channel conversion mode	63
7.2.2. Single channel continuous conversion mode	65
7.2.3. Group conversion mode	66
7.3. NOTCH FILTER (50 HZ)	67
7.3.1. Unstable time for filter	67
7.3.2. The following are the design specifications for the low-pass filter.	68
7.3.3. Filter coefficient	68
7.3.4. Coefficient calculation	69
7.3.5. Register	71
7.4. BIOELECTRIC REGISTERS	71
7.4.1. BIOELECTRIC_REG_CTRL_0: Offset Address: 01h	71
7.4.2. BIOELECTRIC_CH_MODE: Offset Address: 03h (Bioelectric_channel_mode_register)source	75
7.4.3. BIOELECTRIC_INT: Offset Address: 04h (bioelectric_interrupt_register)	75
7.4.4. BIOELECTRIC_REG_SEQ: Offset Address: 05h (Sequence Control Register)	76
7.4.5. BIOELECTRIC_REG_RSTVAL: Offset Address: 06h (Reset Count Register)	77
7.4.6. BIOELECTRIC_CH0DATA_0: Offset Address :07h (Channel 0 LSB Data)	77
7.4.7. BIOELECTRIC_CH0DATA_1: Offset Address :08h (Channel 0 MSB Data)	77
7.4.8. BIOELECTRIC_CH1DATA_0: Offset Address 09h (Channel 1 LSB Data)	77
7.4.9. BIOELECTRIC_CH1DATA_1: Offset Address 0Ah (Channel 1 MSB Data)	78
7.4.10. BIOELECTRIC_CH2DATA_0: Offset Address :0Bh (Channel 2 LSB Data)	78
7.4.11. BIOELECTRIC_CH2DATA_1: Offset Address: 0Ch (Channel 2 MSB Data)	78
7.4.12. BIOELECTRIC_GRP_CTRL: Offset Address: 0Dh	78
7.4.13. BIOELECTRIC_CHA_NUM_LO: Offset Address: 0Eh (Channel number of ADC _LSB)	79
7.4.14. BIOELECTRIC_CHA_NUM_HI: Offset Address: 0Fh (Channel number of ADC_MSB)	79
7.4.15. BIOELECTRIC_ALARM_INT: Offset Address: 10h	79
7.4.16. BIOELECTRIC_ALARM_INT_EN: Offset Address: 11h	79
7.4.17. BIOELECTRIC_THRESHOLD_HI_0: Offset Address: 12h	80
7.4.18. BIOELECTRIC_THRESHOLD_HI_1: Offset Address: 13h	80
7.4.19. BIOELECTRIC_THRESHOLD_LO_0: Offset Address: 14h	80
7.4.20. BIOELECTRIC_THRESHOLD_LO_1: Offset Address: 15h	80
7.4.21. BIOELECTRIC_INPUT_FORMAT: Offset Address: 16h	80
7.4.22. BIOELECTRIC_EN: Offset Address: Offset Address:17h	80
7.4.23. BIOELECTRIC_CH0DATA_MAX_0: Offset Address :18h (Bioelectric channel0 max value lsb bits)	81
7.4.24. BIOELECTRIC_CH0DATA_MAX_1: Offset Address :19h (Bioelectric channel0 max value msb bits)	81
7.4.25. BIOELECTRIC_CH0DATA_MIN_0: Offset Address :1Ah (Bioelectric channel0 min value lsb bits)	81
7.4.26. BIOELECTRIC_CH0DATA_MIN_1: Offset Address :1Bh (Bioelectric channel1 min value msb bits)	81
7.4.27. BIOELECTRIC_CH0DATA_DELTA_0: Offset Address :1Ch (Bioelectric channel0 delta value Register lsb)	82
7.4.28. BIOELECTRIC_CH0DATA_DELTA_1: Offset Address :1Dh (Bioelectric channel0 delta value Register msb)	82
7.4.29. NOTCH_FILTER_EN: Offset Address :1Eh (notch filter enable)	82
7.4.30. LEADOFF_INT: Offset Address: 1Fh (leadoff_interrupt_register)	82
8. ZMEAS	83
8.1. BLOCK DIAGRAM	83
8.2. CONFIGURATION SEQUENCE	84
8.3. APB ZMEAS REGISTERS:	1
8.3.1. ZMEAS_REG_CTRL_0: Offset Address:0x20	1
8.3.2. ZMEAS_REG_CTRL_1: Offset Address:0x21	1
8.3.3. ZMEAS_REG_CTRL_2: Offset Address:0x22	2
8.3.4. ZMEAS_REG_CTRL_3: Offset Address:0x23	2
8.3.5. ZMEAS_EN: Offset Address:0x40	3
8.3.6. ZMEAS_SYNC_EN: Offset Address:0x41	3
9. SPI FIFO	4
9.1. FIFO FEATURES	4
9.2. CONFIGURATION SEQUENCE	4
9.3. FORMAT OF FIFO DATA	5
9.4. REGISTERS	5
9.4.1. FIFO_WR_PTR_REG (FIFO Write Pointer): Offset Address: 80h	6
9.4.2. FIFO_RD_PTR_REG (FIFO Read Pointer): Offset Address: 81h	6
9.4.3. FIFO Counter 1: Offset Address: 82h	6
9.4.4. FIFO Counter 2: Offset Address: 83h	7
9.4.5. FIFO Configuration 1: Offset Address: 84h	7
9.4.6. FIFO Configuration 2: Offset Address: 85h	8
9.4.7. FIFO Configuration 3: Offset Address: 86h	9
9.4.8. IFO Status: Offset Address: 87h	11
9.4.9. FIFO Data 1: Offset Address: 88h	12
9.4.10. FIFO Data 2: Offset Address: 89h	12
10. GPIO	14
10.1. GPIO_PU_CTRL: OFFSET ADDRESS: 90H	14
10.2. GPIO_PU_RESETN: OFFSET ADDRESS: 91H	14
10.3. GPIO_PD_TESTMODE: OFFSET ADDRESS: 92H	14
11. PPG CONTROLLER	15
12. BIO ELECTRICITY	27
12.1. REGISTERS	30
12.1.1. BIOELECTRIC_CH_MODE: Offset Address:03h (Channel Mode Register)	30
12.1.2. BIOELECTRIC_INPUT_FORMAT: Offset Address: 16h	31
12.1.3. ZMEAS_REG_CTRL_0: REG_CTRL Register - Offset Address:0x20-0x23	31
12.1.4. MCLK_DIV_REG: Offset Address: 0x51	31
12.1.5. CHECK_CLK_DIV_HI  & CHECK_CLK_DIV_L0: Offset Address: 0x52-0x53	32
12.1.6. BIOELECTRIC_REG_CTRL_0 (Control Register): Offset Address: 01h	32
12.1.7. BIOELECTRIC_INT: Offset Address: 04h	32
12.1.8. BIOELECTRIC_EN: Offset Address: 17h	32
12.1.9. (Bioelectric channel0 max value Register): Offset Address: 18h-19h	32
12.1.10. (Bioelectric channel0 max value Register): Offset Address: 1Ah-1Bh	33
12.1.11. (Bioelectric channel0 delta value Register): Offset Address: 1Ch-1Dh	33
12.1.12. DATA_TYPE_SEL: Offset Address: 0x76	33
12.1.13. DC_DATA_REG_0: Offset Address: 0x77	34
12.1.14. DC_DATA_REG_1: Offset Address: 0x78	34
12.1.15. SQU_CLK_DIV_0: Offset Address: 0x79	34
12.1.16. SQU_DIV_CLK_1: Offset Address: 0x7A	34
13. LEAD OFF DETECTION:	35
13.1. REGISTERS	35
13.1.1. LEADOFF_CTRL: Offset Address: 0x93	35
13.1.2. LEADOFF_TGT_0: Offset Address: 0x94	37
13.1.3. LEADOFF_TGT_1: Offset Address: 0x95	37
13.1.4. LEADOFF_SWITCH_TGT: Offset Address: 0x96	37
13.1.5. BIOELECTRIC_INT: Offset Address: 04h	37
14. SPI CONTROLLER	38
14.1. OVER_VIEW:	38
14.2. FUNCTIONAL DESCRIPTION:	39
14.3. INTERFACE	39
14.4. SPI SLAVE CONTROLLER SPECIFICATION:	41
14.4.1. Communication:	41
14.4.2. SPI Modes:	42
14.4.3. Data communication format between Master and Slave	42
14.4.4. SPI-Timing Characteristics:	49
15. TYPICAL APPLICATION SCENARIO	50
15.1. BIOELECTRIC CONFIGURATION SEQUENCE:	50
15.2. ZMEAS CONFIGURATION SEQUENCE:	51
16. SAMPLE DEMO	52
NEW CHANGES FOR USING 256 BYTES OF FLASH	53

 
Figure 1 . Top Level Block Diagram of BAF4P1	16
Figure 2 . Analog PMU of BAF4P1	17
Figure. 5  Switchable domain clock control Block Diagram	27
Figure. 6  Flash Controller Block Diagram	31
Figure. 7  BIOELECTRIC Block Diagram	63
Figure. 8  ZMEAS Block Diagram	84
 




Features
·	Power supply: 2.6V-3.6V
·	Low leakage current in disabled mode: ≤100nA
·	Low power consumption: 
o	≤ 6µA, 3V power supply, three-electrode bias mode.
The sensor acquisition circuit:
o	Noise level: ≤ 6µV, 
o	Accuracy: 15 bits, 
o	Current detection accuracy: ≤ 100pA, up to 30µA.
·	ADC 
o	clock 64K. 
o	OSR: 32 ~ 1024.
o	 FIFO (128 Words).
·	0.3V~2V electrode bias voltage range, with a precision of 10 bits.
·	Integrated programable feedback resistors.
·	Flash size: 32K Bytes.
·	On-chip temperature sensor: ± 0.1℃.
·	Packaging: WLCSP.




	
Applications
·	Electrochemical sensor
·	Continuous glucose monitoring
·	Sweat sensors
·	Wearable devices

1. Overview

The BAF4 is an ultra-low power, low-voltage programmable analog front-end (AFE) ECG, PPG and impedance (only resistance (not phase)) spectroscopy chip. This chip is compatible with 3V battery power supplies. The analog front-end circuit of BAF4 is mainly composed of low-noise operational amplifiers and a 16-bit high-precision ADC (plus 50 Hz notch filter). The working electrode bias voltage accuracy can reach up to 10 bits, supporting three-electrode and four-electrode electrochemical sensors. In bias standby mode, the current of BAF4 is as low as 4uA, and during current acquisition, it is as low as 35uA, with leakage current less than 100nA when the system is shut down. The system integrates an impedance detection module for measuring electrochemical impedance, as well as a high-precision temperature sensor to ensure the safety of the sensor.
The BAF4 has both analog and digital design. Digital design has two domains (switchable and always on). Always on domain (top_dig_always_on) will contain system control (reset and clock control) as well as Shadow Registers block. The main job of always on domain is to keep trim values while most of the chip is in low power mode (switchable domain will have no power).
The switchable domain (top_dig) contains I/Z MeasurRDnt control blocks, flash controller, SPI slave, system control (PMU, reset, clock ctrl units), and pin mux for handling IO cells.
The digital top block (Nanochap_BAF4) will include both switchable and Always On units as well as analog top and IO cells. It also connects to the test bench via IO cell INOUT pads.
Switchable domain will be turned off when chip is set to low power mode. Next figure shows that modules such as SPI, Flash, IO pins, and measurRDnt units will not work during low power mode.




 1.1. Block Diagram
Figure 1. Top Level Block Diagram of BAF4P1
 


 Figure 2. Analog PMU of BAF4P1
 

source: PMU SYSTEM DIAGRAM.VSDX



 Figure 3.  System diagram of BAF4P1
 

source: BAF4_SYSTEM DIAGRAM.VSDX








 2. Registers
2.1. Register Map
Address	I-MeasurRDnt Registers	Attribute	Default Value
01h	BIOELECTRIC_REG_CTRL_0		
02h	BIOELECTRIC_REG_CTRL_1		
03h	BIOELECTRIC_CH_MODE		
04h	BIOELECTRIC_INT		
05h	BIOELECTRIC_REG_SEQ		
06h	BIOELECTRIC_REG_RSTVAL		
07h	BIOELECTRIC_CH0DATA_0		
08h	BIOELECTRIC_CH0DATA_1		
09h	BIOELECTRIC_CH1DATA_0		
0Ah	BIOELECTRIC_CH1DATA_1		
0Bh	BIOELECTRIC_CH2DATA_0		
0Ch	BIOELECTRIC_CH2DATA_1		
0Dh	BIOELECTRIC_GRP_CTL		
0Eh	BIOELECTRIC_CHA_NUM_LO		
0Fh	BIOELECTRIC_CHA_NUM_HI		
10h	BIOELECTRIC_ALARM_INT 		
11h	BIOELECTRIC_ALARM_INT_EN		
12h	BIOELECTRIC_THRESHOLD_HI_0		
13h	BIOELECTRIC_THRESHOLD_HI_1		
14h	BIOELECTRIC_THRESHOLD_LO_0		
15h	BIOELECTRIC_THRESHOLD_LO_1		
16h	BIOELECTRIC_INPUT_FORMAT		
17h	BIOELECTRIC_EN		
18h	BIOELECTRIC_CH0DATA_MAX_0		
19h	BIOELECTRIC_CH0DATA_MAX_1		
1Ah	BIOELECTRIC_CH0DATA_MIN_0		
1Bh	BIOELECTRIC_CH0DATA_MIN_1		
1Ch	BIOELECTRIC_CH0DATA_DELTA_0		
1Dh	BIOELECTRIC_CH0DATA_DELTA_1		
1Eh	NOTCH_FILTER_EN		
 Z-MeasurRDnt Registers
20h	ZMEAS_REG_CTRL_0		
21h	ZMEAS_REG_CTRL_1		
22h	ZMEAS_REG_CTRL_2		
23h	ZMEAS_REG_CTRL_3		
24h	ZMEAS_REG_STATUS_0		
25h	ZMEAS_REG_STATUS_1		
26h	ZMEAS_REG_DATAOUT_0		
27h	ZMEAS_REG_DATAOUT_1		
28h	ZMEAS_REG_DATAOUT_2		
29h	ZMEAS_REG_DATAOUT_3		
2Ah	ZMEAS_ADC_ROM_REG_0		
2Bh	ZMEAS_ADC_ROM_REG_1		
2Ch	ZMEAS_ADC_ROM_REG_2		
2Dh	ZMEAS_ADC_ROM_REG_3		
2Eh	ZMEAS_SUMMATION_OFFSET_FORREAL_0		
2Fh	ZMEAS_SUMMATION_OFFSET_FORREAL_1		
30h	ZMEAS_SUMMATION_OFFSET_FORREAL_2		
31h	ZMEAS_SUMMATION_OFFSET_FORREAL_3		
32h	ZMEAS_SUMMATION_REAL_0		
33h	ZMEAS_SUMMATION_REAL_1		
34h	ZMEAS_SUMMATION_REAL_2		
35h	ZMEAS_SUMMATION_REAL_3		
36h	ZMEAS_SUMMATION_IMAG_0		
37h	ZMEAS_SUMMATION_IMAG_1		
38h	ZMEAS_SUMMATION_IMAG_2		
39h	ZMEAS_SUMMATION_IMAG_3		
3Ah	ZMEAS_SUMMATION_SHIFT_0		
3Bh	ZMEAS_SUMMATION_SHIFT_1		
3Ch	ZMEAS_SUMMATION_SHIFT_2		
3Dh	ZMEAS_SUMMATION_SHIFT_3		
3Eh	ZMEAS_INT		
3Fh	ZMEAS_ADC_INT		
40h	ZMEAS_EN		
41h	ZMEAS_SYNC_EN		
42h  	ANA_Z_ADC_DAC_EN		
43h	ANA_Z_ADC_DAC_EN_SEL		
System Control Register
49h	RLD_CLK_REG		
4Ah  	LEADOFF_CLK_REG		
4Bh	MCLK_DIV		
4Ch	CHECK_CLK_DIV_HI		
4Dh	CHECK_CLK_DIV_LO		
Clock_Ctrl_Resisters
4Eh	CLK_CTRL_REG		
PMU Registers
4Fh	PMU_REG0		
Flash Registers
50h	FLASH_DEBUG1		
51h	FLASH_DEBUG2		
Flash Trim
52h	FLASH_TRIMDATA0		
53h	FLASH_TRIMDATA1		
54h	FLASH_TRIMDATA2		
55h	FLASH_TRIMDATA3		
56h	FLASH_TRIMDATA4		
57h	FLASH_TRIMDATA5		
58h	FLASH_TRIMDATA6		
59h	FLASH_TRIMDATA7		
5Ah	FLASH_TRIMDATA8		
5Bh	FLASH_TRIMDATA9		
5Ch	FLASH_TRIMDATA10		
5Dh	FLASH_TRIMDATA11 		
5Eh	FLASH_TRIMDATA12		
5Fh	FLASH_TRIMDATA13		
60h	FLASH_TRIMDATA14		
61h	FLASH_TRIMDATA15		
62h	FLASH_TRIMDATA16		
63h	FLASH_TRIMDATA17		
64h	FLASH_TRIMDATA18		
65h	FLASH_TRIMDATA19		
66h	FLASH_TRIMDATA20		
67H	FLASH_UNLOCK		
68H	FLASH_WR_DATA		
69H	FLASH_ADDR		
6AH	FLASH_ENE_DATA		
DEVICE INTERRUPT STATUS
70h	DEVICE_INT_STATUS_0		
71h	DEVICE_INT_STATUS_1		
PPG Registers
72h	PPG_REG_CTRL_1		
73h	PPG_LED_TIME_SEL		
74h	PPG_LED_FREQ_SEL		
75h	PPG_LED_STATUS		
7Bh	PPG_LED_ON_L		
7Ch	PPG_LED_ON_H		
7Dh	PPG_LED_FREQ_L		
7Eh	PPG_LED_FREQ_H		
BIO ELECTRIC FLOW Registers
76h	DATA_TYPE_SEL		
77h	DC_DATA_REG_0		
78h	DC_DATA_REG_1		
79h	SQU_CLK_DIV_0		
7Ah	SQU_CLK_DIV_1		
FIFO Registers
80h	FIFO_WR_PTR_REG		
81h	FIFO_RD_PTR_REG		
82h	FIFO_COUNTER_1_REG		
83h	FIFO_COUNTER_2_REG		
84h	FIFO_CONFIG_1_REG		
85h	FIFO_CONFIG_2_REG		
86h	FIFO_CONFIG_3_REG		
87h	FIFO_STATUS_REG		
88h	FIFO_DATA_REG1		
89h	FIFO_DATA_REG2		
GPIO Registers
90h	GPIO_PU_CTR		
91h	GPIO_PU_RESETn		
92h	GPIO_PD_TESTMODE		
LEAD_OFF Registers
93h	LEADOFF_CTRL		
94h	LEADOFF_TGT_0		
95h	LEADOFF_TGT_1		
96h	LEADOFF_SWITCH_TGT		
ANANLOG REGISTERS
9Fh	ANA_TSC_1		
A0h	ANA_BUFFER		
A1h	ANA_ECG_CTRL_1		
A2h	ANA_ECG_CTRL_2		
A3h	ANA_DC_LEAD_OFF_CTRL		
A4h	ANA_TSC		
PPG/LED Register
A5h	ANA_PPG_LED_SEL		
A6h	ANA_PPG_DAC0_CTRL_REG0		
A7h	ANA_PPG_DAC0_CTRL_REG1		
A8h	ANA_PPG_DAC1_CTRL_REG0		
A9h	ANA_PPG_DAC1_CTRL_REG1		
AAh	ANA_PPG_TIA_IDAC		
ABh	ANA_PPG_TIA_GAIN		
ACh	ANA_PPG_TEST_REG		
ADh	ANA_PPG_LED_EN_REG		
AEh	ANA_PPG_CTRL_REG		
AFh	ANA_SDM_REG		
ANA BIST REGISTERS
B0h	ANA_BIST		
ANA_LEAD_OFF REGISTER
B1h	ANA_LEAD_OFF_EN		
SPARE_REGISTER
B2h	A2D_SPARE_REG0		
B3h	A2D_LOFF_STATN		
B4h	A2D_LOFF_STATP		
B5h	A2D_ACLEADOFF_STATN		
B6h	A2D_ACLEADOFF_STATP		
ANALOG DEBUG REGISTERS
C0h	ALWAYS_ON_ANA_TRIM_DEBUG	Read-only; returns the AO trim selected by ao_trim_sel (write 1–10 to DEBUG_MODE_TYPE to select trim1–trim10)

3. Always on power domain
3.1. Overview
This power domain includes pin-mux, reset control, clock control and shadow register module.
Figure below shows how always on block shadow register values (connected to analog) getting updated from switchable domain registers.
 

Figure 4.  Always on Block Diagram

1) All SPI trim registers are READ ONLY (using 256 KHz SPI clk). However, users can write SPI trim registers using a 1 MHz external clock, if this pin is bonded out and available.
2) Trim values can ONLY be written via Flash BIST operation or SPI as specified above.
3) “flash reset done” is only generated if trim_tag (address 0x0000 in NVR1) matches 0x5A. Otherwise, Flash trim values (if any), will not be loaded and provided to Analog domain and default AO values will be provided to Analog
4) Trim values will be loaded to shadow registers ONLY after “flash reset done” (flash reading) procedure.
5) Trim values can be read via SPI trim registers (before going to AO domain) or debug registers (final regs after AO domain going to Analog domain).
6) Always On reset will reset analog trim values to default values (e.g. 1000 or 0).
7) Switchable reset will reset SPI trim values to default 0. But these values will not affect anything, until we write them into flash and reload into AO shadow registers
8) SPI analog control registers can ONLY be written to shadow register by write always_on_spi_write (bit7 of CLK_CTRL_REG)

3.2. Shadow Registers
Shadow registers are used to store the registers which will control analog module because we should guarantee these registers have power when switchable domain does power down.
The shadow registers include two sources, one is from SPI controller, another is from flash controller. We use SPI controller to config registers to control analog module and we use flash controller to get the trim value to trim analog module performance.
 


Every time the switchable domain goes from power down to power on, the flash will automatically load the trim value to flash trim shadow registers and some of these trim registers can be read back by SPI for debugging purposes. The analog control register can be written to SPI control register by SPI controller, however, these registers cannot control analog directly, they must be written to shadow registers using the always_on_spi_write register (bit7 of CLK_CTRL_REG), then these shadow registers can control analog top directly.
Note: every time set always_on_spi_write, you must guarantee the always_on_spi_write is 0, then set the always_on_spi_write, otherwise, you need reset always_on_spi_write to 0 firstly, then set always_on_spi_write to 1, that means you must let the always_on_spi_write has a change from low to high.
4. Switchable Power domain
4.1. System control
This block contains the clock control, reset control and pmu
4.1.1. Reset Control
In this block, flash reset and the normal reset have their own POR timers respectively. The final POR after timer will be synchronized with different clocks such as SPI and system clock and will generate different reset signals.
4.1.2. Clock Control
This block is responsible for generating clocks for the rest of the switchable power domain modules.
The following diagram shows the clock control unit connections and how the output clocks are generated. As can be seen, all the output clocks are 50% duty cycle, MEAS/ZMEAS clock are divisible from the original clocks.
 

Figure. 5 Switchable domain clock control Block Diagram

4.1.3. Power managRDnt unit (PMU)
This unit has a state machine which will manage putting the switchable power domain into the clock gating mode and returning from the clock gating mode. The entire chip can also be turned off (including always on power domain) through an external pin called CHP_EN (managed by analog switches).
SPI register bit sleepdeep can put the switchable power domain into clock gating mode. Once in this mode, the fclk from above clock control module will be disabled. SPI register bit hresetq can wake up the switchable power domain returning to normal model from the clock gating mode. Flash controller can get into the deep sleep mode along with/without the switchable power domain
4.2. Registers
RLD_CLK_REG: Offset Address: 0x49
Bit	Field Name	Attribute	Default	Field Description
7:2	RESERVED	RO	0	reserved
1:0	RLD_CLK_SEL	WR	2’b00	This clock will be used as RLD clock
00: 64K
01: 32K
10: 16K
11: 8K

LEAD_OFF_CLK_REG: Offset Address: 0x4A
Bit	Field Name	Attribute	Default	Field Description
7:3	RESERVED	RO	0	reserved
2	SDM_CLK_GPIO_PHA_SEL	WR	1’b0	SDM clock send to external GPIO
0: same phase as bioelectric_dig_adc_clk
1: invert phase of bioelectric_dig_adc_clk
1:0	ACLEADOFF_CLK_SEL	WR	2’b10	This clock will be used as AC lead off detection circuit
00: 128K
01: 64K
10: 32K
11: 16K

MCLK_DIV: Offset Address: 0x4B
Bit	Field Name	Attribute	Default	Field Description
7:0	MCLK_DIV	WR	8’h13	This clock will be used as zmeas main clock for generate different SINWAVE of DAC
0: same as fclk, 256K
N: 256k/(N+1)
Default is 256k/20=12.8K, if default SINWAVE is 500hz(256K main clock), then SINWAVE is 500/20=25hz

CHECK_CLK_DIV_HI: Offset Address: 0x4C           
Bit	Field Name	Attribute	Default	Field Description
7:0	CHECK_CLK_DIV_HI	WR	8’h03	 
This check clock diver higher bits.
This check_clk_div_hi and check_clk_div_lo fields together will be used as checking the SINC result of ADC, base frequency is 1K hz
0: 0.5K hz
N: 1k/(N+1)
Default is 1k/(9999+1)=1hz

CHECK_CLK_DIV_LO: Offset Address: 0x4D             
Bit	Field Name	Attribute	Default	Field Description
7:0	CHECK_CLK_DIV_LO	WR	8’hE7	This check clock diver lower bits.

This check_clk_div_hi and check_clk_div_lo fields together will be used as checking the SINC result of ADC, base frequency is 1K hz
0: 0.5K hz
N: 1k/(N+1)
Default is 1k/(9999+1) = 1hz

CLK_CTRL_REG: Offset Address: 0x4E
Bit	Field Name	Attribute	Default	Field Description
7	ALWAYS_ON_SPI_WRITE	WR	0	Always On SPI Write 
6	BIOELECTRIC_ADC_INV	WR	0	BIOELECTRIC ADC CLK inverter
5:3	ICLK_DIV	WR	3’b010	ICLK_Divider (base CLK= 256 KHz internal or external clock)
000: divided by 2
001: divided by 4
010: divided by 8
011: divided by 16
100: divided by 32
101: divided by 64
110: divided by 128
111: divided by 256
2:1	PCLK_DIV	WR	2’b00	PCLK Divider
00: divided by 1
01: divided by 2
10: divided by 4
11: divided by 8
0	FCLK_DYNEN 	WR	0	FCLK Dynamic enable

PMU_REG: Offset Address: 0x4F
Bit	Field Name	Attribute	Default	Field Description
7	RESERVED	-	0	Reserved
6	BIO_DISABLE	WR	0	Bio test disable
0: Enable
1: Disable
5	PPG_CTRL_DISABLE	WR	0	PPG controller disable
1: Disable
0: Enable
4	FIFO_DISABLE	WR	0	 FIFO disable
1: Disable
0: Enable
3	FLASH_DPSTB_EN	WR	0	FLASH Deep Sleep Enable
1: Enable
0: Disable
2	HRESETREQ	WR	1’b0	Soft Reset Enable
1: Enable
0: Disable
1	SLEEPDEEP	WR	1’b0	Sleep Deep Enable
1: Enable
0: Disable
0	PMUENABLE 	WR	1	PMU Enable
1: Enable
0: Disable






5. FLASH Controller
5.1. Overview
The FLASH IP is GSMC Embedded FLASH IP has many sectors. Each Sector has 512-byte.
32Kx8-bit (MAIN Region for User Purpose) (64 Sectors).
2 Non-Volatile Register (NVR0（1st NVR）region for User Purpose and NVR1（2nd NVR） region for Manufacturer Purpose Only) Sectors.
1 Redundant (RND region for Manufacture Purpose only in case a need of re-mapping when Main Region has a bad sector) Sector. 
Before investigating this chapter, please investigate the following documents first, it will be good to understand the FLASH IP:
logical/chip_top/imp/tech/HHG_FS13Q7P6_FPFLE032K09DA_32Kx8/datasheet/HHG_FPFLE032K09DA_DS.pdf or the link : 
HHG_FPFLE032K09DA_DS.PDF
logical/chip_top/imp/tech/HHG_FS13Q7P6_FPFLE032K09DA_32Kx8/application_notes/HHG_FPFLE032K09DA_AP.pdf  or the link: 
HHG_FPFLE032K09DA_AP.PDF

5.2. Block Diagram

A functional block diagram of the flash controller is shown as below.
  

Figure. 6 Flash Controller Block Diagram
5.3. Function
There are some functions: reload Analog Trim, reload redundancy parameter, write Analog Trim to Flash, read data from Flash, write data to Flash, sector erase, chip erase, ATM modes, protection NVR0, these features are described in detail as below
5.3.1. Reload analog trim
 

5.3.1.1. Reload Function for Flash IP Trim Tag (the value of NVR1 Trim Tag is 0x5A)
After power on, read NVR1 Trim Tag (1-byte), read Flash IP trimming configuration (8-byte), read Analog NVR1 Trim Tag (1-byte) and read Analog trimming configuration (28-byte data if trim tag is matched)
After chip power is on, will reload configuration data in Flash to SPI registers if Trim Tag is matched, then reload Trim.
	The value of FLASH IP Trim Tag is 0x5A
      Read the value of trim bits tag (the address is 0x0210 of FLASH NVR1):  If the value is 0x5A, then read the value of trimming configuration region (the address is 0x0200~0x0207 of FLASH NVR1), at the same time, write the data that read into Flash IP Configuration registers.
	The value of FLASH IP Trim Tag is not 0x5A
       Read the value of Trim Tag bits (the address is 0x0210 of FLASH NVR1): If the value is not 0x5A, then doesn’t read the value of trimming configuration region (the address is 0x0200~0x0207 of FLASH NVR1). As a result, there is no update on Flash IP Configuration registers.
5.3.1.2. The value of Analog Trim Tag is 0x5A
1.	Read the value of Analog Trim Tag, the address is 0x0000 of FLASH NVR0, and it is used to judge whether to use Analog Trim or not (Analog Trim will be used if Analog Trim Tag is 0x5A).
2.	Read the value of Analog trimming information in FLASH, (the address is 0x0001~0x001F of FLASH NVR0), at the same time, write the data that read into Analog Trim registers.
3.	The Analog Trim Data (updated the value from) can be read by SPI bus, the SPI register addresses are 0x43~0x61.
5.3.1.3. The value of Analog Trim Tag is not 0x5A
1.	Read the value of Analog Trim Tag, the address is 0x0000 of FLASH NVR0, and it is used to judge whether to use analog trim or not (Analog Trim will not be used if Analog Trim Tag is not 0x5A).
2.	Cannot update the value of Analog Trim Data registers from FLASH.
3.	The Analog Trim Data(default values) can be read by SPI bus, the SPI register addresses are 0x43~0x61.

5.3.2. Reload Redundancy Parameter
For loading the bad Main Array sector information from FLASH NVR1 (0x3F).
1. The factory stores the bad Main Array sector information in FLASH NVR1.
2. After Chip power on, and after reloading Trim Data, will reload redundancy data to RND_REG.

5.3.3. Write Analog Trim Data to Flash NVR0 Memory
1.	Data ready: write the data to SPI Trim Data registers.
2.	Set FLASH_UNLOCK_PRO to 0xAA.
3.	Set FLASH_NVR_PRO_BYTE00 to 0xAA.
4.	Set FLASH_NVR_PRO_BYTE01 to 0xAA.
5.	Set “UNLOCK” bit in FLASH_UNLOCK register to 1'b1. After this operation is completed, the “unlock” bit of FLASH_UNLOCK register will be automatically cleared.
6.	Power down, and power on.
7.	Read the value that is written on step 1.
8.	Check whether the written data and read data are consistent.
5.3.4. Read Data from Flash NVR0 Memory
This function is used to read data from flash via SPI.
1.	Set FLASH_UNLOCK_PRO register to 0xAA.
2.	Write FLASH_ADDR00, FLASH_ADDR01 registers to give the addresses.
3.	Set “spi_rd_command” bit-2 in FLASH_UNLOCK register to enable Data Read Command to FLASH. After this operation is completed, the “spi_rd_command” bit-2 in FLASH_UNLOCK register will be automatically cleared (if SPI Clock is less than 300Khz, maybe FLASH_UNLOCK register can’t be automatically cleared, please clear manually).
4.	Read bit-2 of FLASH_UNLOCK register until bit-2 is 0.
5.	Go back to step 2 to read the next data.

5.3.5. Write Data to Flash Memory (MAIN - 32K, NVR0 (512-byte except for first 32-address of TRIMs, RND (512-byte)
This function is used to write data to Flash via SPI, if a program for Main Array is needed, set FLASH_CTRL-bit4 to 1’b0 or if a program for NVR0 is required, set bit-4 of FLASH_CTRL Register to 1’b1, data will be programmed as below:
Note: the first 128 addresses of NVR0 (TRIM Data Region) can’t be accessed by this function
1.	Set FLASH_UNLOCK_PRO register to 0xAA.
2.	If programming NVR0 region
Ø	Yes: 
Set FLASH_NVR_PRO_BYTE00 register to 0xAA.
Set FLASH_NVR_PRO_BYTE01 register to 0xAA.
Ø	No: go to step3
3.	Write FLASH_ADDR00, FLASH_ADDR01 registers to give the addresses
4.	Write FLASH_DATA00 register to give the data 
5.	Write bit-3 of FLASH_UNLOCK register  register bit-3 to enable SPI_WR_COMMAND, after this operation is completed, the FLASH_UNLOCK register will be automatically cleared (if SPI Clock is less than 40KHz, maybe FLASH_UNLOCK register can’t be automatically cleared, it should be manually cleared).
6.	Read bit-3 of FLASH_UNLOCK register until bit-3 is 0.
7.	Go back to step 2 to write the next data.

5.3.6. Write function for TRIM registers (to write from SPI into AO shadow registers)
In order to update the AO shadow registers without writing into Flash trim locations, we can use the following steps. In this case, the SPI trim registers go to the flash first and then update AO shadow registers using SPI_WRITE, without having to use FLASH_UNLOCK. Then the user can go to step 2 in the previous section to also write the final value to the flash. 
1.	Data ready: write the data to SPI reg
2.	Set SPI_WRITE bit to 1 in FLASH_UNLOCK register
3.	Wait at least 3 AO clocks, then set SPI_WRITE bit to 0 in FLASH_UNLOCK register
4.	Check whether the written data and read data are consistent, written DATA from SPI REG should be the same of DATA on AO TRIM registers

5.3.7. Sector erase
This function is used to erase data via SPI, if erasing main array is needed, set FLASH_CTRL-bit4 to 0, if it is required to erase NVR0~NVR1, set FLASH_CTRL-bit4 to 1; user can select external clock(1mhz) or internal clock (128khz)

1.	Set FLASH_UNLOCK_PRO register (0x6C) to 0xAA
2.	If erasing NVR0 region
Ø	Yes: 
Set FLASH_NVR_PRO_BYTE00 register (0x6A) to 0xAA
Set FLASH_NVR_PRO_BYTE01 register (0x6B) to 0xAA
Ø	No: go to step3
3.	Configure FLASH_ADDR01 register (0x69) to give the sector address.
4.	Set 1’b1 to bit-4 of FLASH_UNLOCK register (0x65) to enable SPI_SER after this operation is completed, the SPI_SER will be automatically cleared.
5.	Read bit-4 of FLASH_UNLOCK register (0x65) until the bit-4 is 0.
6.	Read the data again (will be 0xFFFF_FFFF) to confirm if it is successfully erased.
7.	Go back to step 2 to erase the next sector if needed.

5.3.8. Chip erase
Note that chip erase only erases main array and RDN sectors, user can select external clock (1Mhz) or internal clock (128Khz)
1.	Set FLASH_UNLOCK_PRO (0x6C) to 0xAA
2.	Write 1’b1 to FLASH_UNLOCK register (0x65) by setting bit-5 to enable spi_cer after this operation is completed, the spi_cer will be automatically cleared.
3.	Read bit-5 of FLASH_UNLOCK register (0x65) until bit-5 is 0.
4.	Read the data again (will be 0xFFFF_FFFF) to confirm if it is successfully erased.

5.3.9. Deep Standby mode
The device enters the Deep Standby mode when both DPSTB and CEb are high, all internal circuitries are not enabled during this mode
This function will be valid when enabling PMU register bit[3], that is when write this bit to 1 via SPI, flash state machina will enter DPSLEEP state, then flash IP will enter Deep Standby mode, flash_fclk will be gate
5.3.10. DEBUG MODE
Used for reading and writing tests on the trim register in the flash controller
READ step:
1. Set DEBUG_MODE_TYPE register to 0x01, enter READ DEBUG MODE
2. Set FLASH_ADDR00 registers， Set the address of the trim register to be read
3. Read data via SPI, the address is FLASH_EME_DATA00

WIRTE step:
1. Set FLASH_ADDR00 registers， Set the address of the trim register be to written
2. Set FLASH_DATA00 registers， Set the data of the trim register be to written
3. Set DEBUG_MODE_TYPE register to 0x02, enter WRITE DEBUG MODE
4. Read data via SPI, the address is FLASH_EME_DATA00


5.4. Flash Bist Controller
5.4.1. Block Diagram
 


5.5. Pin table
Name 	Direction 	Width 	Description 
Input signals
TCK	I 	1 	BIST Clock
TDI	I 	1 	BIST Data Input
RESETb	I 	1 	BIST Reset
TESTEN	I 	1	BIST Mode Enable
Output signals
OEN	O	1	Output Enable Signal
TDO	O	1	BIST Data Output
Interface - flash_bist
BIST_FLASH_NVR 	O	1 	NVR=1 to select the flash IP NVR sectors 
BIST_FLASH_CEb 	O	1 	To active the flash IP 
BIST_FLASH_WEb 	O	1 	To control program/erase HV operation 
BIST_FLASH_PROG 	O	1 	To indicate program operation 
BIST_FLASH_PROG2 	O	1 	To enable YMUX during program 
BIST_FLASH_ERASE 	O	1 	To indicate erase operation 
BIST_FLASH_CHIP 	O	1 	To indicate chip selection 
BIST_FLASH_OEb 	O	1 	To gate the data output buffers 
BIST_FLASH_VREAD1 	O	1 	Enable Margin read for program cell verification 
BIST_FLASH_VREAD2 	O	1 	Enable Margin read for program cell verification 
BIST_FLASH_TMEN 	O	1 	Enable test modes for flash IP 
BIST_FLASH_ADDR 	O	15 	To provide memory addressed 
BIST_FLASH_WDATA 	O	32 	To receive input data from bist mode 
BIST_FLASH_DPSTB 	O	1 	High to enable deep power down standby mode 
BIST_TESTSEL 	O	1 	Select the flash 
BIST_TESTSEL_OTHER 	O	1 	Select other flash  
BIST_FLASH_CONFEN	O	1 	Write configuration data to register
BIST_FLASH_RND	O	1 	Select redundant sector
BIST_FLASH_VMON1	O	1 	indicate block selection
BIST_FLASH_VMON2	O	1 	Test pin
BIST_FLASH_BLOCK	O	1 	Test pin 
BIST_FLASH_RDATA 	I	32 	Read data from flash IP


When flash_bist_en is asserted (set TESTMOD[1:0]=2’b10 and IOPAD_GPIO[5] = 0)
More information, please refer to this document:
logical/chip_top/imp/tech/HHG_FS13Q7P6_FPFLE032K09DA_32Kx8/BIST/Datasheet/BIS_ FPFLE032K09DA _DS.pdf or the link:
BIS_ FPFLE032K09DA _DS.PDF






5.6. ATM mode
5.6.1. Introduction
This function is used to write Analog trim to Analog trim reg and Flash by GPIO in Analog test mode, this process is to write the data in the pads in Analog test mode to the Analog trim registers and then use the UNLOCK signal to write the data in Analog Trim registers to Flash memory.
 

5.6.1.1. Write Analog trim register by GPIO

1.	Enter Analog test mode 
2.	Select ATMx according to the Analog Trim that user wants to test 
3.	trim data is written by using GPIO 
4.	data from the pad in test mode is automatically written to the corresponding Analog trim register in spi_ao_flash.sv for use in Analog test mode next time.

Program the value of Analog trim reg to flash
            After all ATM tests are finished, and the validator wants to write data from the Analog Trim register into FLASH NVR0, then just asserting unlock, the trim value is automatically written to the Flash NVR0. 
In summary, every change of IO pad values will immediately go to the Analog Trim registers (if external clock is supplied) and, as a result, will change the Analog D2A trim values consequently. Now, if validator is happy with the trim value results, they can unlock, or, without turning off the power, go to the next ATM mode, without losing current Analog trim register trim values, and continue with the new trim values (which again reflect immediately, after each clock, on the respective Analog Trim registers). Validator can write at the end of each ATM mode or (without powering off and losing previous ATM mode trim values) after the final ATM mode by the UNLOCK IO cell. 
Notes:
Trim values of all ATM modes will remain in Analog Trim (as long as the chip is powered) and will be written into the flash, each time UNLOCK is activated, regardless of which ATM step we are at. As a result, if any previous trim values in the memory are not final, do not UNLOCK, otherwise all trim values will be written at once. More specifically, when the flash is programmed, it is required to use the external clock, because the internal clock is 128Khz (7.8us), Tpgs and Tprog can’t use this clock.

5.6.2. Protection NVR0
There are two registers that is used to protect NVR0, that is, if user want to program or erase NVR0, need to set those registers to specified value, otherwise user can’t program/erase NVR0.

5.7. FSM
The FSM functions mainly allow proper sequencing of FLASH write signals and to control the ownership of the Flash input control between the read and write slave.
The read slave listens directly to SPI signals for incoming requests and functions exactly like a single cycle memory slave. If a valid read request is detected, the address is registered, and data is returned on the next clock. 
A 20-bit timer is used to provide a timing count for State Transitions. An 8-bit state register is used to store the current state. The timer is reset to 0 whenever a next state transition is detected. 
Each state then will drive the appropriate trigger high/low for one cycle to the outdrv registers to signal that the respective async signals need to be driven high or low or maintain previous driven levels.
To enable control signals between read/write, bit[6] of the state registers which indicates either READ or PROG branch is used as the control. Hence, if bit[6] is asserted (PROG) then all control signals will be taken from the write slave and conversely from the read slave when bit[6] is 0 (READ)
And given that the 20-bit counter is only required in the actual write control, it is only enabled once the FSM transitions to the PROG branch reduce unnecessary toggling
5.8. Test Bench
Application scenario	Test point
Chip power on	Reload configuration Datas from NVR1 (depend on Flash IP Trim Tag)
Reload Analog trims from NVR0 (depend on Analog Trim Tag)
1. Flash IP Trim tag-valid, Analog trim tag-valid
2. Flash IP Trim tag-valid, Analog trim tag-invalid
3. Flash IP Trim tag-invalid, Analog trim tag-valid
4. Flash IP Trim tag-invalid, Analog trim tag-invalid
Reload RDN data from NVR1 (must be reload)
Wakeup flash from LP mode	1. Chip Power on 
2. Turn off flash power 
3. Turn on flash power
4. Analog/Digital Trim already is valid in always_on, no need to reload Analog Trim again
5. Reload configuration Datas from NVR1(must be reload each Flash domain power on)
6. Reload redundant data from NVR1(must be reloaded each Flash domain power on)
read	Read data from main memory/ NVR0/RDN
A request only read one data
write	Write data to main memory/NVR0/RDN
There are two commands for writing:
Be used to Analog trim, only use to write Analog trim, can’t program other addresses
Be used to write data to flash apart from Analog trim, that is it can’t access the addresses of Analog trim
Sector erase	Erase data from Main memory/NVR0/RDN
A request only erases 1 sector
Chip erase 	Erase main memory/ RDN
If enable RDN bit, erase main memory and RDN
If disable RDN bit, only erase main memory
HV	Write 256 bytes consecutively to see if the timing is ok (the max of Thv is 3ms), need to consider clock jitter
Replace bad sector by RDN	Replace bad sector which info will be stored in the lest byte of NVR1
ATM	Check if the data from IO can be wrote into flash correctly
Protection	0x6a/0x6b, check if SPI can access flash legitimately
Sleep mode	Flash deep standby mode, check flash status and if the clock of flash controller is clocked

Reload truth table:
Wakeup chip or clear reload_done, (Flash IP trims, Analog Trim, RDN sector) will be reloaded immediately.

Reload done0: Reload is on going	Flash IP trims
0: Trim Tag is 0x5a（not reload）
1: Trim Tag is not 0x5a(reload)	Analog Trim
0: Trim Tag is 0x5a(not reload)
1: Trim Tag is not 0x5a(reload)	RDN sector
1: need to reload(reload)
0	0	0	1
0	0	1	1
0	1	0	1
0	1	1	1

5.9. Timing
	Parameter 	System Clock(128khz)	External Clock(1mhz)
 
 
 
Program 	Tnvrs	-	7 clocks
	Tpgs	-	3 clocks
	Tpgh	-	1 clock
	Tprog	-	7 clocks
	Tads	-	2 clocks
	Tadh	-	1 clock
	Trcv	-	6 clocks
 
 
Erase	Tnvrs	2 clocks	7 clocks
	Sector erase	526 clocks	4500 clocks
	Chip erase	4375 clocks	35000 clocks
	Trcv	10 clocks	55 clocks


5.10. Registers
FLASH address	SPI address	Type	Default	Signal Name	Flash signals
 	50h	R	00h	debug1	
 	51h	R	00h	debug2	
0x00	52h	RW	5ah	Trim tag	d2a_trim0_from_flash0
0x01	53h	RW	10h	Analog trim1（BGH_VTRIM）	d2a_trim0_from_flash1
0x02	54h	RW	40h	Analog trim2（BGH_CTRM）	d2a_trim0_from_flash2
0x03	55h	RW	02h	Analog trim3（LDO1V5_TRIM）	d2a_trim0_from_flash3
0x04	56h	RW	20h	Analog trim4（OSC_TRIM）	d2a_trim0_from_flash4
0x05	57h	RW	01h	Analog trim5（OSC_ISEL）	d2a_trim0_from_flash5
0x06	58h	RW	00h	Analog trim6 (D2A DCLEADOFF_COMP_TH TRIM)	d2a_trim0_from_flash6
0x07	59h	RW	00h	Analog trim7 (D2A DCLEADOFF ISEL TRIM)	d2a_trim0_from_flash7
0x08	5Ah	RW	04h	Analog trim8 (D2A ACLEADOFF VTHNSEL TRIM)	d2a_trim0_from_flash8
0x09	5Bh	RW	04h	Analog trim9 (D2A ACLEADOFF VTHPSEL TRIM)	d2a_trim0_from_flash9
0x0a	5Ch	RW	01h	Analog trim10 (D2A ACLEADOFF ISEL TRIM)	d2a_trim0_from_flash10
0x0b	5Dh	RW	c0h	Digital trim0[7:0]（VSEL_TRIM_H[7:0)	d2a_trim0_from_flash11
0x0c	5Eh	RW	00h	Digital trim0[9:8]（VSEL_TRIM_H[9:8])	d2a_trim0_from_flash12
0x0d	5Fh	RW	80h	Digital trim1[7:0] (VSEL_TRIM_L[7:0])	d2a_trim0_from_flash13
0x0e	60h	RW	00h	Digital trim1[9:8] (VSEL_TRIM_L[9:8])	d2a_trim0_from_flash14
0x0f	61h	RW	00h	AO Spare register0	d2a_trim0_from_flash15
0x10	62h	RW	00h	AO Spare register1	d2a_trim0_from_flash16
0x11	63h	RW	00h	AO Spare register2	d2a_trim0_from_flash17
0x12	64h	RW	00h	AO Spare register3	d2a_trim0_from_flash18
0x13	65h	RW	00h	SW Spare register0	d2a_trim0_from_flash19
0x14	66h	RW	00h	SW Spare register1	d2a_trim0_from_flash20
	67h	RW	00h	UNLOCK	
0x15				Scaleconst1[7:0]	Scaleconst1
0x16				Scaleconst1[15:8]	Scaleconst1
0x17				coeff_b1_section1[7:0]	coeff_b1_section1
0x18				coeff_b1_section1[15:8]	coeff_b1_section1
0x19				coeff_b2_section1[7:0]	coeff_b2_section1
0x1a				coeff_b2_section1[15:8]	coeff_b2_section1
0x1b				coeff_b3_section1[7:0]	coeff_b3_section1
0x1c				coeff_b3_section1[15:8]	coeff_b3_section1
0x1d				coeff_a2_section1[7:0]	coeff_a2_section1
0x1e				coeff_a2_section1[15:8]	coeff_a2_section1
0x1f				coeff_a3_section1[7:0]	coeff_a3_section1
0x20				coeff_a3_section1[15:8]	coeff_a3_section1
0x21				Scaleconst2[7:0]	Scaleconst2
0x22				Scaleconst2[15:8]	Scaleconst2
0x23				coeff_b1_section2[7:0]	coeff_b1_section2
0x24				coeff_b1_section2[15:8]	coeff_b1_section2
0x25				coeff_b2_section2[7:0]	coeff_b2_section2
0x26				coeff_b2_section2[15:8]	coeff_b2_section2
0x27				coeff_b3_section2[7:0]	coeff_b3_section2
0x28				coeff_b3_section2[15:8]	coeff_b3_section2
0x29				coeff_a2_section2[7:0]	coeff_a2_section2
0x2a				coeff_a2_section2[15:8]	coeff_a2_section2
0x2b				coeff_a3_section2[7:0]	coeff_a3_section2
0x2c				coeff_a3_section2[15:8]	coeff_a3_section2

5.10.1. FLASH_DEBUG1: Offset Address: 0x50
Bit	Field Name	Attribute	Default	Field Description
7	FLASH_BLOCK	RO	0	Debug flash signal: BLOCK
6	FLASH_OEB	RO	1	Debug flash signal: OEb
5	FLASH_CHIP	RO	0	Debug flash signal: CHIP
4	FLASH_ERASE	RO	0	Debug flash signal: ERASE
3	FLASH_PROG2	RO	0	Debug flash signal: PROG2
2	FLASH_PROG	RO	0	Debug flash signal: PROG
1	FLASH_WEB	RO	1	Debug flash signal: WEb
0	FLASH_CEB	RO	1	Debug flash signal: CEb

5.10.2. FLASH_DEBUG2: Offset Address: 0x51
Bit	Field Name	Attribute	Default	Field Description
7	VALID_TRIM_TAG_STS	RO	0	After flash busy becomes low: 
1: analog trim tag is invalid
0: analog trim tag is valid（5A）
6	FLASH_BUSY_STS	RO	0	Debug flash busy
5	FLASH_TMEN	RO	0	Debug flash signal: TMEN
4	FLASH_DEEP_PD	RO	0	Debug flash signal: DEEPPD
3	FLASH_RED	RO	0	Debug flash signal: RED
2	FLASH_NVR	RO	0	Debug flash signal: NVR
1	FLASH_PORB	RO	0	Debug flash signal: PORb
0	FLASH_VALID_CONFEN	RO	0	Debug flash signal: CONFEN_valid

5.10.3. FLASH_TRIM0: Offset Address: 0x52
Bit	Field Name	Attribute	Default	Field Description
7:0	FLASH_TRIM0	R/W	8’b0	FLASH to Analog Trim0 (TRIM TAG REG)
This register is read with SPI_CLK so the initial default values are 8’b0. If trim tag is unsuccessful, the default values from flash is 8’b0. After successful trim tag, final flash value will be read by spi
 
5.10.4. FLASH_TRIM1: Offset Address: 0x53
Bit	Field Name	Attribute	Default	Field Description
7:0	FLASH_TRIM1	R/W	8’b0	FLASH to Analog Trim1(BGH_VTRIM)
This register is read with SPI_CLK so the initial default values are 8’b0. If trim tag is unsuccessful, the default values from flash is 8’b0. After successful trim tag, final flash value will be read by spi

5.10.5. FLASH_TRIM2: Offset Address: 0x54
Bit	Field Name	Attribute	Default	Field Description
7:0	FLASH_TRIM2	R/W	8’b0	FLASH to Analog Trim2(BGH_CTRIM)
This register is read with SPI_CLK so the initial default values are 8’b0. If trim tag is unsuccessful, the default values from flash is 8’b0. After successful trim tag, final flash value will be read by spi

5.10.6. FLASH_TRIM3: Offset Address: 0x55
Bit	Field Name	Attribute	Default	Field Description
7:0	FLASH_TRIM3	R/W	8’b0	FLASH to Analog Trim3(LDO1V5_VTRIM)
This register is read with SPI_CLK so the initial default values are 8’b0. If trim tag is unsuccessful, the default values from flash is 8’b0. After successful trim tag, final flash value will be read by spi

5.10.7. FLASH_TRIM4: Offset Address: 0x56
Bit	Field Name	Attribute	Default	Field Description
7:0	FLASH_TRIM4	R/W	8’b0	FLASH to Analog Trim4(OSC_TRIM)
This register is read with SPI_CLK so the initial default values are 8’b0. If trim tag is unsuccessful, the default values from flash is 8’b0. After successful trim tag, final flash value will be read by spi

5.10.8. FLASH_TRIM5: Offset Address: 0x57
Bit	Field Name	Attribute	Default	Field Description
7:0	FLASH_TRIM5	R/W	8’b0	FLASH to Analog Trim5 (OSC_ISEL_SEL)
This register is read with SPI_CLK so the initial default values are 8’b0. If trim tag is unsuccessful, the default values from flash is 8’b0. After successful trim tag, final flash value will be read by SPI

5.10.9. FLASH_TRIM6: Offset Address: 0x58
Bit	Field Name	Attribute	Default	Field Description
7:0	FLASH_TRIM6	R/W	8’b0	FLASH to Analog Trim6 (D2A_DCLEADOFF_COMP_TH_TRIM)
This register is read with SPI_CLK, so the initial default values are 8’b0. If trim tag is unsuccessful, the default values from flash is 8’b0. After successful trim tag, final flash value will be read by SPI 

5.10.10. FLASH_TRIM7: Offset Address: 0x59
Bit	Field Name	Attribute	Default	Field Description
7:0	FLASH_TRIM7	R/W	8’b0	FLASH to Analog Trim7 (D2A_DCLEADOFF_ISEL_TRIM)
This register is read with SPI_CLK, so the initial default values are 8’b0. If trim tag is unsuccessful, the default values from flash is 8’b0. After successful trim tag, final flash value will be read by SPI

5.10.11. FLASH_TRIM8: Offset Address: 0x5A
Bit	Field Name	Attribute	Default	Field Description
7:0	FLASH_TRIM8	R/W	8’b0	FLASH to Analog Trim8(D2A_ACLEADOFF_VTHNSEL_TRIM)
This register is read with SPI_CLK so the initial default values are 8’b0. If trim tag is unsuccessful, the default values from flash is 8’b0. After successful trim tag, final flash value will be read by SPI

5.10.12. FLASH_TRIM9: Offset Address: 0x5B
Bit	Field Name	Attribute	Default	Field Description
7:0	FLASH_TRIM9	R/W	8’b0	FLASH to Analog Trim9(D2A_ACLEADOFF_VTHPSEL_TRIM)
This register is read with SPI_CLK so the initial default values are 8’b0. If trim tag is unsuccessful, the default values from flash is 8’b0. After successful trim tag, final flash value will be read by SPI

5.10.13. FLASH_TRIM10: Offset Address: 0x5C
Bit	Field Name	Attribute	Default	Field Description
7:0	FLASH_TRIM10	R/W	8’b0	FLASH to Analog Trim10(D2A_ACLEADOFF_ISEL_TRIM)
This register is read with SPI_CLK so the initial default values are 8’b0. If trim tag is unsuccessful, the default values from flash is 8’b0. After successful trim tag, final flash value will be read by SPI

5.10.14. FLASH_TRIM11: Offset Address: 0x5D
Bit	Field Name	Attribute	Default	Field Description
7:0	FLASH_TRIM11	R/W	8’b0	FLASH to digitial Trim0(VSEL TRIM_H[7:0])
This register is read with SPI_CLK so the initial default values are 10’b0. If trim tag is unsuccessful, the default values from flash is 10’b0. After successful trim tag, final flash value will be read by spi

5.10.15. FLASH_TRIM12: Offset Address: 0x5E
Bit	Field Name	Attribute	Default	Field Description
7:0	FLASH_TRIM12	R/W	8’b0	FLASH to digitial Trim0(VSEL TRIM_H[9:8])
This register is read with SPI_CLK so the initial default values are 10’b0. If trim tag is unsuccessful, the default values from flash is 10’b0. After successful trim tag, final flash value will be read by spi

5.10.16. FLASH_TRIM13: Offset Address: 0x5F
Bit	Field Name	Attribute	Default	Field Description
7:0	FLASH_TRIM13	R/W	8’b0	FLASH to digitial Trim1(VSEL TRIM_L[7:0])
This register is read with SPI_CLK so the initial default values are 10’b0. If trim tag is unsuccessful, the default values from flash is 10’b0. After successful trim tag, final flash value will be read by spi

5.10.17. FLASH_TRIM14: Offset Address: 0x60
Bit	Field Name	Attribute	Default	Field Description
7:0	FLASH_TRIM14	R/W	8’b0	FLASH to digitial Trim1(VSEL TRIM_L[9:8])
This register is read with SPI_CLK so the initial default values are 10’b0. If trim tag is unsuccessful, the default values from flash is 10’b0. After successful trim tag, final flash value will be read by SPI

5.10.18. FLASH_TRIM15: Offset Address: 0x61
Bit	Field Name	Attribute	Default	Field Description
7:0	FLASH_TRIM15	R/W	8’b0	FLASH to Analog Trim15 (AO spare register)
This register is read with SPI_CLK so the initial default values are 8’b0. If trim tag is unsuccessful, the default values from flash is 8’b0. After successful trim tag, final flash value will be read by SPI 

5.10.19. FLASH_TRIM16: Offset Address: 0x62
Bit	Field Name	Attribute	Default	Field Description
7:0	FLASH_TRIM16	R/W	8’b0	FLASH to Analog Trim16 (AO spare register)
This register is read with SPI_CLK so the initial default values are 8’b0. If trim tag is unsuccessful, the default values from flash is 8’b0. After successful trim tag, final flash value will be read by SPI

5.10.20. FLASH_TRIM17: Offset Address: 0x63
Bit	Field Name	Attribute	Default	Field Description
7:0	FLASH_TRIM17	R/W	8’b0	FLASH to Analog Trim17(AO spare register)
This register is read with SPI_CLK so the initial default values are 8’b0. If trim tag is unsuccessful, the default values from flash is 8’b0. After successful trim tag, final flash value will be read by SPI

5.10.21. FLASH_TRIM18: Offset Address: 0x64
Bit	Field Name	Attribute	Default	Field Description
7:0	FLASH_TRIM18	R/W	8’b0	FLASH to Analog Trim18(AO spare register)
This register is read with SPI_CLK so the initial default values are 8’b0. If trim tag is unsuccessful, the default values from flash is 8’b0. After successful trim tag, final flash value will be read by SPI

5.10.22. FLASH_TRIM19: Offset Address: 0x65
Bit	Field Name	Attribute	Default	Field Description
7:0	FLASH_TRIM19	R/W	8’b0	FLASH to Analog Trim19(SW spare register)
This register is read with SPI_CLK so the initial default values are 8’b0. If trim tag is unsuccessful, the default values from flash is 8’b0. After successful trim tag, final flash value will be read by SPI

5.10.23. FLASH_TRIM20: Offset Address: 0x66
Bit	Field Name	Attribute	Default	Field Description
7:0	FLASH_TRIM120	R/W	8’b0	FLASH to Analog Trim20( SW spare register)
This register is read with SPI_CLK so the initial default values are 8’b0. If trim tag is unsuccessful, the default values from flash is 8’b0. After successful trim tag, final flash value will be read by SPI

5.10.24. FLASH_UNLOCK: Offset Address: 0x67
Bit	Field Name	Attribute	Default	Field Description
7:6	RESERVED	RO	2’b00	Not use
   5	FLASH_CER	R/W	1’b0	Chip erase command
4	FLASH_SER	R/W	1’b0	Sector erase command
3	FLASH_WR_COMMAND	R/W	1’b0	The command is used to write data to flash
  2	FLASH_RD_COMMAND	R/W	1’b0	The command is used to read data from flash, all addresses can be read
1	RESERVED	RO	1’b0	Not use
0	UNLOCK	R/W	1’b0	The command is used to write trim value from SPI registers to NVR0
In order to do UNLOCK, Flash MUST have a clock of 1Mhz (external CLK)
 
5.10.25. FLASH_CTRL: Offset Address: 0x68
Bit	Field Name	Attribute	Default	Field Description
7:5	RESERVED	RO	3’b000	Reserved
  4	NVR 	R/W	1’b0	Enable NVR Accession
1: Enable
0: Disable
3:2	RESERVED	RO	2’b00	Reserved
1:0	RESERVED	RO	2’b00	Reserved
 
5.10.26. FLASH_DATA00: Offset Address: 0x69
Bit	Field Name	Attribute	Default	Field Description
7:0	FLASH DATA00	R/W	8’hFF	The data that will be wrote into flash DIN[7:0]
 
5.10.27. FLASH_ADDR00: Offset Address: 0x6A
Bit	Field Name	Attribute	Default	Field Description
7:0	BYTES_ADDRESS_SELECTION	R/W	8’h00	Select which address is being obtained in a row
 
5.10.28. FLASH_ADDR01: Offset Address: 0x6B
Bit	Field Name	Attribute	Default	Field Description
7	RESERVED	R	1’b0	 
6:0	ROW_SELECTION	R/W	7’h00	Row Selection is being obtained

ROW_SELECTION[0]: be used to select row 
ROW_SELECTION[6:1]: be used to select sector 
 
5.10.29. FLASH_NVR_PRO_BYTE00: Offset Address: 0x6E
Bit	Field Name	Attribute	Default	Field Description
7:0	FLASH_NVR_PRO_BYTE00	RW	8’h00	FLASH_NVR_PRO_BYTE[7:0]
It is used to obtain the operation permission on the NVR0 sector. The NVR0 can be operated only when the half-word is 0xAAAA
 
5.10.30. FLASH_NVR_PRO_BYTE01: Offset Address: 0x6F
Bit	Field Name	Attribute	Default	Field Description
7:0	FLASH_NVR_PRO_BYTE01	RW	8’h00	FLASH_NVR_PRO_BYTE[15:8]
It is used to obtain the operation permission on the NVR0 sector. The NVR0 can be operated only when the half-word is 0xAAAA
 
5.10.31. FLASH_UNLOCK_PRO: Offset Address: 0x70
Bit	Field Name	Attribute	Default	Field Description
7:0	FLASH_UNLOCK_PRO	RW	8’h00	PASSWORD For UNLOCK 
This byte is used to obtain permission to operate UNLOCK registers.  It is able to operate UNLOCK registers only when the byte is 0xAA
 
5.10.32. FLASH_EME_DATA00: Offset Address: 0x6C
Bit	Field Name	Attribute	Default	Field Description
7:0	FLASH EME DATA00	R	8’h00	READ DATA REGISTER
The data that is read from flash DOUT[7:0]
 
5.10.33. FLASH_RND_ADDR: Offset Address: 0x6D
Bit	Field Name	Attribute	Default	Field Description
7:0	FLASH_RND_ADDR	R	8’hFF	the information about RDN sector replacement is stored in NVR1
-FLASH_RND_ADDR[7]: 
0: Enable RDN sector
1: Disable RDN sector
-FLASH_RND_ADDR[6]: not used
-FLASH_RND_ADDR[5:0]: 
the addresses of main array that is replaced by RDN sector (because Main Size is 32KB, there are 64 sectors so we use 6-bit to identify the bad sector to replace)

5.10.34. DEVICE_INT_STATUS_0: Offset Address: 0xD0
Bit	Field Name	Attribute	Default	Field Description
7	RESERVED	RO	4’b0	Reserved
6	LEAD_OFF_SWITCH_INT_STS	RO	1’b0	Lead off switch interrupt
this switch interrupt includes all switch type, no matter it is N or P, ac or dc
5	LEAD_OFF_SWITCH_INT_STS	RO 	1’b0	lead off duration interrupt
this duration interrupt includes all duration type, no matter it is N or P, ac or dc
4	BIOELEC_CHECKING_INT	RO	1’b0	Bio electricity checking interrupt
3	BIOELEC_INT_STS1	RO 	1’b0	bioelectric_int_sts1(only for ppg mode)
2	BIOELEC_INT_STS0	RO	1’b0	bioelectric_int_sts0(only for ppg mode)
1	ZMEAS_INT_STS	RO	1’B0	Zmeas_interrupt
0	ZMEAS_ADC_INT_STS	RO	1’b0	zmeas_adc_interrupt

5.10.35. DEVICE_INT_STATUS_1: Offset Address: 0xD1
Bit	Field Name	Attribute	Default	Field Description
7	RESERVED	RO	1’b0	Reserved
6	BIOELEC_INT_STS	RO	1’B0	bioelectric_interrupt_status
5	BIOELEC_ALARM_INT_STS	RO	1’b0	bioelectric_interrupt_alarm_ststus
4	FIFO_ERROR_INT_STS	RO	1’b0	fifo_error
3	FIFO_ALMOST_EMPTY_INT_STS	RO	1’B1	fifo_a_empty
2	FIFO_ALMOST_FULL_INT_STS	RO	1’B0	fifo_a_full
1	FIFO_EMPTY_INT_STS	RO	1’B1	fifo_empty
0	FIFO_FULL_INT_STS	RO	1’b0	fifo_full

PPG REGISTERS:
PPG_REG_CTRL_1: Offset Address: 0x72
Bit	Field Name	Attribute	Default	Field Description
7	RESERVED	RO	2’b0	Reserved
6	PPG_LED_PROG_SEL	R/W	1’b0	PPG_LED_PROG_SEL
5	PPG_SYNC_BYPASS_EN	R/W	1’b0	PPG_SYNC_BYPASS
4:2	PPG_MODE_SEL	RW	3’b000	PPG_MODE_SEL (Mode Selection)
1	PPG_IDAC_LED_SEL	RW	1’b0	PPG_IDAC_LED_SEL
0	PPG_EN	RW	1’b0	PPG Enable

PPG_LED_TIME_SEL: Offset Address: 0x73
Bit	Field Name	Attribute	Default	Field Description
7:4	RESERVED	RO	4’b0	RESERVED
3:0	PPG LED_TIME_SEL	RW	4’b0	PPG LED_TIME_SEL

PPG_LED_FREQ_SEL: Offset Address: 0x74
Bit	Field Name	Attribute	Default	Field Description
7:4	RESERVED	RO	4’b0	RESERVED
3:0	PPG_LED_FREQ_SEL	RW	4’b0	PPG LED_FREQ_SEL

PPG_LED_STATUS: Offset Address: 0x75
Bit	Field Name	Attribute	Default	Field Description
7:1	RESERVED	RO	4’b0	RESERVED
0	PPG_LED_STS	RO	1’b0	PPG_LED_STATUS

PPG_LED_ON_L: Offset Address: 0x7B
Bit	Field Name	Attribute	Default	Field Description
7:0	LED_ON_L	R/W	8’b0	LED_ON_L

PPG_LED_ON_H: Offset Address: 0x7C
Bit	Field Name	Attribute	Default	Field Description
7:6	RESERVED	RO		
5:0	LED_ON_H	R/W	6’b0	LED_ON_H

PPG_LED_FREQ_L: Offset Address: 0x7D
Bit	Field Name	Attribute	Default	Field Description
7:0	LED_FREQ_L	R/W	8’b0	LED_FREQ_L

PPG_LED_FREQ_H: Offset Address: 0x7E
Bit	Field Name	Attribute	Default	Field Description
7:6	RESERVED	RO		
5:0	LED_FREQ_H	R/W	6’b0	LED_FREQ_H


6. Analog Registers

  Below are the set of analog registers which stores the values needed for the analog block, these registers are configurable through the SPI by enabling SPI Write AO bit.
6.1. Registers
6.1.1. Analog Registers

6.1.1.1. ANA_TSC_1: Offset Address: 0x9F
Bit	Field Name	Attribute	Default	Field Description
7:1	RESERVED	RO	7’B000	Reserved
0		R/W	1’b0	TSC_INA_EN


	
6.1.1.2. ANA_BUFFER: Offset Address: 0xA0
Bit	Field Name	Attribute	Default	Field Description
7:5	RESERVED	RO	3’b0	Reserved
4	ECG_ELECTRODE_EN	R/W	1’B0	ECG_ELECTRODE_EN (Electrode mode switch)
3	RLD_CHOP_EN	R/W	1’B0	RLD_CHOP_EN
2	RLD_AMP_EN 	R/W	1’B0	RLD_AMP_EN 
1	BG1P2_BUF_EN	R/W	1’B0	BG1P2_BUF_EN
0	VCM1P5_BUF_EN 	R/W	1’B0	VCM1P5_BUF_EN 


6.1.1.3. ANA_ECG_CTRL_1   Offset Address: 0xA1
Bit	Field Name	Attribute	Default	Field Description
7:5	ECG_DDA_GSEL	R/W	3’H0	ECG_DDA_GSEL
4:2	ECG_PGA_GSEL	R/W	3’H0	ECG_PGA_GSEL
1	ECG_LPF_EN	R/W	1’B1	ECG_LPF_EN
0	ECG_PGA_EN	R/W	1’B1	ECG_PGA_EN

6.1.1.4. ANA_ECG_CTRL_2: Offset Address: 0xA2
Bit	Field Name	Attribute	Default	Field Description
7	RESERVED	RO	1’h0	Reserved    
6	ECG_CAL_EN	R/W	1’B0	ECG_CAL_EN
5:4	ECG_DDA_ISEL	R/W	2’H0	ECG_DDA_ISEL
3	ECG_DDA_CHOP_EN	R/W	1’B0	ECG_DDA_CHOP_EN
2	ECG_DDA_EN	R/W	1’B1	ECG_DDA_EN
1:0	ECG_DDA_CLKSEL	R/W	2’b0	ECG_DDA_CLKSEL

6.1.1.5. ANA_DC_LEAD_OFF_CTRL:  Offset Address: 0xA3
Bit	Field Name	Attribute	Default	Field Description
7:2	RESERVED	RO	6’H0	Reserved
1	DC_LEAD_OFF_VIN_FLIP	R/W	1’B0	DC_LEAD_OFF_VIN_FLIP
0	DC_LEAD_OFF_RMODE_EN	R/W	1’b0	DC_LEAD_OFF_RMODE_EN (1 refers to resistor mode, and 0 refers to current mode)

6.1.1.6. ANA_TSC: Offset Address: 0xA4
Bit	Field Name	Attribute	Default	Field Description
7:5	TSC_INA_GEL	R/W	3’B000	TSC_INA_GEL
4	TSC_EN	R/W	1’B0	TSC_EN
3:1	TSC_BJT_SEL	R/W	3’B000	TSC_BJT_SEL
0	TSC_OUT_SEL	R/W	1’b0	TSC_OUT_SEL

6.1.1.7. ANA_PPG_LED_SEL: Offset Address: 0xA5
Bit	Field Name	Attribute	Default	Field Description
7:3	RESERVED	RO	-	Reserved
2:1	PPG_LED_SEL	R/W	2’H0	PPG_LED_SEL
0	PPG_LED_DAC_SEL	R/W	1’B0	PPG_LED_DAC_SEL



6.1.1.8. ANA_PPG_DAC0_CTRL_REG0: Offset Address: 0xA6
Bit	Field Name	Attribute	Default	Field Description
7:0	PPG_DAC0_VSEL7:0]	R/W	8’H0	PPG_DAC0_VSEL7:0]

6.1.1.9. ANA_PPG_DAC0_CTRL_REG1: Offset Address: 0xA7
Bit	Field Name	Attribute	Default	Field Description
7:5	RESERVED	RO	-	Reserved
4	PPG_DAC0_EN	R/W	1’B0	PPG_DAC0_EN
3:0	PPG_DAC0_VSEL [11:8]	R/W	4’H0	PPG_DAC0_VSEL [11:8]

6.1.1.10. ANA_PPG_DAC1_CTRL_REG0: Offset Address: 0xA8
Bit	Field Name	Attribute	Default	Field Description
7:0	PPG_DAC1_VSEL [7:0]
	R/W	8’H0	PPG_DAC1_VSEL [7:0]

6.1.1.11. ANA_PPG_DAC1_CTRL_REG1: Offset Address: 0xA9
Bit	Field Name	Attribute	Default	Field Description
7:5	RESERVED	RO	-	Reserved
4	PPG_DAC1_EN	R/W	1’B0	PPG_DAC1_EN
3:0	PPG_DAC1_VSEL [11:8]	R/W	4’H0	PPG_DAC1_VSEL [11:8]

6.1.1.12. ANA_PPG_TIA_IDAC: Offset Address: 0xAA
Bit	Field Name	Attribute	Default	Field Description
7:0	PPG_TIA_IDAC	R/W	8’H0	PPG_TIA_IDAC Value

6.1.1.13. ANA_PPG_TIA_GAIN: Offset Address: 0xAB
Bit	Field Name	Attribute	Default	Field Description
7:4	RESERVED	RO	4’h0	Reserved
3:0	PPG_TIA_GAIN	R/W	4’H0	PPG_TIA_GAIN
 6.1.1.14. ANA_PPG_TEST_REG: Offset Address: 0xAC
Bit	Field Name	Attribute	Default	Field Description
7:6	RESERVED	RO	2’b0	Reserved
5:4	PPG_PDV_REF_SEL	R/W	2’H0	PPG_PDV_REF_SEL
3:2 	PPG_TEST_IN	R/W	2’H0	PPG_TEST_IN
1:0	PPG_TEST_OUT	R/W	2’H0	PPG_TEST_OUT

6.1.1.15. ANA_PPG_LED_EN_REG: Offset Address: 0xAD
Bit	Field Name	Attribute	Default	Field Description
7:6	RESERVED	-	2’b0	Reserved
5	PPG_DAC_BUFFER_EN	R/W	1’b0	PPG_DAC_BUFFER_EN
4	PPG_TIA_VREF_BUFFER_EN	R/W	1’B0	PPG_TIA_VREF_BUFFER_EN
 3	PPG_BUFFER_EN	R/W	1’H0	PPG_BUFFER_EN
2	PPG_SH_EN	R/W	1’H0 	PPG_SH_EN
1	PPG_AF_EN	R/W	1’H0	PPG_AF_EN
0	 PPG_LED_STANDBYEN     	R/W	1’B0	 PPG_LED_STANDBYEN     

6.1.1.16. ANA_PPG_CTRL_REG: Offset Address: 0xAE
Bit	Field Name	Attribute	Default	Field Description
7:3	RESERVED	RO	5’b0	Reserved
2	PPG_LED_EN	R/W	1’H0	PPG_LED_EN
1	PPG_TIA_EN 	R/W	1’B0	PPG_TIA_EN 
0 	PPG_SH_CK	R/W	1’B0	PPG_SH_CK

6.1.1.17. ANA_SDM_REG: Offset Address: 0xAF
Bit	Field Name	Attribute	Default	Field Description
7:3	RESERVED	RO	5’b0	Reserved
2	SDM_EN	R/W	1’B0	SDM_EN
1:0 	SDM_BIAS[1:0]	R/W	3’h0	SDM_BIAS[1:0]

6.1.1.18. ANA_BIST: Offset Address: 0xB0
Bit	Field Name	Attribute	Default	Field Description
7:4	RESERVED	RO	4’b0	Reserved
3	BIST_EN	R/W	1’B0	BIST_EN
2:0 	BIST_ISEL	R/W	3’h0	BIST_ISEL

6.1.1.19. ANA_LEAD_OFF_EN:  Offset Address: 0xB1
Bit	Field Name	Attribute	Default	Field Description
7:2	RESERVED	RO	6’B0	Reserved
1	AC_ECG_LEAD_OFF_EN	R/W	1’B0	AC_ECG_LEAD_OFF_EN
0	DC_ECG_LEAD_OFF_EN	R/W	1’B0	DC_ECG_LEAD_OFF_EN

6.1.1.20.  A2D_SPARE_REG0: Offset Address: 0xB2
Bit	Field Name	Attribute	Default	Field Description
7:0	A2D_SPARE_REG_0	RO	8’H0	Analog to Digital spare register 0

6.1.1.21. A2D_LOFF_STATN: Offset Address: 0xB3
Bit	Field Name	Attribute	Default	Field Description
7:1	RESERVED	RO	7’h0	Reserved
0	ECG_DC_LEAD_OFF_STATN	RO	1’b0	Analog to Digital   ECG_DC_LEAD_OFF_STATN

6.1.1.22. A2D_LOFF_STATP: Offset Address: 0xB4
Bit	Field Name	Attribute	Default	Field Description
7:1	RESERVED	RO	7’h0	Reserved
0	ECG_DC_LEAD_OFF_STATP	RO	1’b0	Analog to Digital   ECG_DC_LEAD_OFF_STATP 




6.1.1.23. A2D_ACLEADOFF_STATN: Offset Address: 0xB5
Bit	Field Name	Attribute	Default	Field Description
7:1	RESERVED	RO	7’h0	Reserved
0	ECG_AC_LEAD_OFF_STATN	RO	1’b0	Analog to Digital   ECG_AC_LEAD_OFF_STATN 

6.1.1.24. A2D_ACLEADOFF_STATP: Offset Address: 0xB6
Bit	Field Name	Attribute	Default	Field Description
7:1	RESERVED	RO	7’h0	Reserved
0	ECG_AC_LEAD_OFF_STATP	RO	1’b0	Analog to Digital   ECG_AC_LEAD_OFF_STATP

6.1.2. Analog Debug Registers
(Analog register values from the always on shadow register, to check whether the user configured analog register values are properly loaded to the shadow registers in the always on block)
(Analog Register values are loaded to the shadow registers in the always_on_block, when the always_on_spi_write=1 (CLK_CTRL_REG[7]), generally user need to supply the always_on_spi_write pulse (0->1) after configuring the analog registers (to load those values in always on shadow register)

6.1.2.1. ALWAYS_ON_ANA_TRIM1: Offset Address: 0xC0
Bit	Field Name	Attribute	Default	Field Description
7:5	RESERVED	RO	3’b0	Spare bits
4:0	BGH_VTRIM	RO	5’b10000	bgh_vtrim value in _always_on. Default value 5’b10000. Value changes at SPI read to final flash value, if trim tag successful.

6.1.2.2. ALWAYS_ON_ANA_TRIM2: Offset Address: 0xC1
Bit	Field Name	Attribute	Default	Field Description
7	RESERVED	RO	1’b0	Spare bits
6:0	BGH_CTRIM	RO	7’b1000000	bgh_ctrim value in _always_on. Default value 7’b1000000. Value changes at SPI read to final flash value, if trim tag successful

6.1.2.3. ALWAYS_ON_ANA_TRIM3: Offset Address: 0xC2
Bit	Field Name	Attribute	Default	Field Description
7:2	RESERVED	RO	6’b0	Spare bits
1:0	LDO1V5_TRIM	RO	2’b10	ldo1v5_trim value in _always_on. Default value 2’b10. Value changes at SPI read to final flash value, if trim tag successful

6.1.2.4. ALWAYS_ON_ANA_TRIM4: Offset Address: 0xC3
Bit	Field Name	Attribute	Default	Field Description
7:6	RESERVED	RO	2’b0	Spare bits
5:0	OSC_TRIM	RO	6’b100000	osc_trim value in _always_on. Default value 6’b100000. Value changes at SPI read to final flash value, if trim tag successful

6.1.2.5. ALWAYS_ON_ANA_TRIM5: Offset Address: 0xC4
Bit	Field Name	Attribute	Default	Field Description
7:1	RESERVED	RO	2’b0	Spare bits
0	OSC_ISEL	RO	1’b1	OSC_ISELvalue in _always_on. Default value 1’b1. Value changes at SPI read to final flash value, if trim tag successful

6.1.2.6. ALWAYS_ON_ANA_TRIM6: Offset Address: 0xC5
Bit	Field Name	Attribute	Default	Field Description
7:6	RESERVED	RO	5’b0	Spare bits
2:0	DCLEADOFF_COMP_TH	RO	3‘b000	DCLEADOFF_COMP_TH value in _always_on. Default value 3’b000. Value changes at SPI read to final flash value, if trim tag successful

6.1.2.7. ALWAYS_ON_ANA_TRIM7: Offset Address: 0xC6
Bit	Field Name	Attribute	Default	Field Description
7:6	RESERVED	RO	5’b0	Spare bits
2:0	DCLEADOFF_ISEL	RO	3’b000	DCLEADOFF_ISEL value in _always_on. Default value 3’b000. Value changes at SPI read to final flash value, if trim tag successful

6.1.2.8. ALWAYS_ON_ANA_TRIM8: Offset Address: 0xC7
Bit	Field Name	Attribute	Default	Field Description
7:3	RESERVED	RO	5’b0	Spare bits
2:0	ACLEADOFF_VTHNSEL	RO	3’b100	ACLEADOFF_VTHNSEL value in _always_on. Default value 3’b100. Value changes at SPI read to final flash value, if trim tag successful

6.1.2.9. ALWAYS_ON_ANA_TRIM9: Offset Address: 0xC8
Bit	Field Name	Attribute	Default	Field Description
7:3	RESERVED	RO	5’b0	Spare bits
2:0	ACLEADOFF_VTHPSEL	RO	3’b100	ACLEADOFF_VTHPSEL value in _always_on. Default value 3’b100. Value changes at SPI read to final flash value, if trim tag successful

6.1.2.10. ALWAYS_ON_ANA_TRIM10: Offset Address: 0xC9
Bit	Field Name	Attribute	Default	Field Description
7:4	RESERVED	RO	4’b0	Spare bits
3:0	ACLEADOFF_ISEL	RO	4’b1	ACLEADOFF_ISEL value in _always_on. Default value 4’b0001. Value changes at SPI read to final flash value, if trim tag successful




7. BIOELECTRIC FILTER
7.1. Block Diagram
The SD16 module consists of an on-chip programmable gain amplifier (PGA), and a sigma-delta analog-to-digital converter (ADC).
The ADC has up to eight fully differential multiplexed analog input pairs. The converter is based on a first order
Sigma-delta modulator whose output is over sampled followed by a digital decimation filter. 
Digital filter is a cascaded integrator-comb (CIC) filter with programmable rate change from 32 to 2048.
Features of the SD16 module include:
• 16-bit first-order sigma-delta architecture
• Up to eight multiplexed differential analog inputs
• Programmable sigma-delta output sampling frequency
• CIC filter
• Programmable filter parameter
• Low power
The digital block includes three modules: CIC digital filter, SPI Register and BIOELECTRIC CTRL. 
SPI Register module decodes SPI bus and generate register to other modules.
CIC (cascade integrator comb) is a simple, hardware economical decimation filter, and convert serial ADC data to parallel 16-bit data.
BIOELECTRIC CTRL module samples the 16-bit data from filter when EOC, and based on different channel mode, generate interrupt status, and load the convert data to registers. 
 
Figure. 7 BIOELECTRIC Block Diagram
7.2.  Configuration Sequence
7.2.1. Single channel conversion mode
1)	Select iclk (SDM clk) frequency using CLK_CTRL_REG register
2)	Enable BIOELECTRIC by writing into BIOELECTRIC_EN register, which will start generating SDM adc clk
3)	Select input data format using BIOELECTRIC_INPUT_FORMAT register
4)	Enable interrupt & configure CIC rate using BIOELECTRIC_CTRL register
5)	Set CHMOD 2’b00 to select single channel conversion mode using BIOELECTRIC_CHANNEL_MODE register
6)	Configure channel number & conversion data format in BIOELECTRIC_ CHANNEL_MODE register
7)	Start conversion by setting SD16RST 1’b0 to release reset for CIC digital filter using BIOELECTRIC_SEQ_CTRL register 
8)	When conversion completes, SD16EOC is asserted, then hardware loads the conversion data into registers of channel 0, then hardware generated interrupt in GPIO4
9)	Wait for either interrupt in GPIO4 or poll for interrupt status which indicates conversion is completed.
10)	Set SD16RST to 1’b1 to stop conversion
11)	Read the conversion data of channel 0 using BIOELECTRIC_CH0DATA and then clear interrupt


 
 7.2.2. Single channel continuous conversion mode

1)	Select iclk (SDM clk) frequency using CLK_CTRL_REG register
2)	Enable BIOELECTRIC by writing into BIOELECTRIC_EN register, which will start generating SDM adc clk
3)	Select input data format using BIOELECTRIC_INPUT_FORMAT register
4)	Disable interrupt & configure CIC rate using BIOELECTRIC_CTRL register
5)	Set CHMOD 2’b01 to select single channel continuous conversion mode using BIOELECTRIC_CHANNEL_MODE register
6)	Configure channel number & conversion data format in BIOELECTRIC_ CHANNEL_MODE register
7)	Start conversion by setting SD16RST 1’b0 to release reset for CIC digital filter using BIOELECTRIC_SEQ_CTRL register
8)	When conversion complete, SD16EOC is asserted, then hardware loads the conversion data into registers of channel 0
9)	After few conversions, software set SD16RST to 1’b1 to finish conversion, read the conversion data 	of channel 0 using BIOELECTRIC_CH0DATA or using SPI_FIFO
 
 7.2.3. Group conversion mode
1)	Select iclk (SDM clk) frequency using CLK_CTRL_REG register 
2)	 Enable BIOELECTRIC by writing into BIOELECTRIC_EN register, which will start generating SDM adc clk
3)	Select input data format using BIOELECTRIC_INPUT_FORMAT register
4)	Enable interrupt & configure CIC rate using BIOELECTRIC_CTRL register
5)	Out of 8 ADC channels, select the 3 channels for group conversion by setting GRPCHNUM using BIOELECTRIC_CHA_NUM_LO & BIOELECTRIC_CHA_NUM_HI registers
6)	Set CHMOD 2’b10 to select group channel conversion mode using BIOELECTRIC_CHANNEL_MODE register
7)	Start conversion by setting SD16RST 1’b0 to release reset for CIC digital filter using BIOELECTRIC_SEQ_CTRL register
8)	When channel 0 conversion complete, SD16EOC is asserted, then hardware loads the conversion 	data into registers of channel 0, channel number plus 1, go to channel 1 and until channel 2 conversion complete, then hardware generate interrupt
There are 2 options afterwards:
9)	If only need one time 3 channels data, CPU detects interrupt, then enter interrupt handler, set SD16RST to 1’b1, 	read the conversion data of channel 0/1/2, clear interrupt
10)	If continuously need the 3 channels data, then don’t care about the interrupt until you want to stop the filter.


 

For ADC, there are 9 channels, but only 3 channels can be filtered by SINC. From register CHANNEL NUMBER of ADC, 3 channels can be selected, you can select any 3 channels from 9 channels, the bit3 to bit0 indicate data in the channel number will be filtered out to SINCA, the bit7 to bit4 indicate the data in the channel number will be filtered out to SINCB, and the bit11 to bit8 indicate the data in the channel number will be filtered out to SINCC. 
7.3. Notch filter (50 Hz)
An IIR notch filter is also implRDnted at the output of bioelectric (SINC filter) which is ADC 16 bit output. This ADC output will be filtered for any 50 Hz noise. In fact, the stop band of the filter can be changed to any stop band by changing the coefficients. Not only the stop band, other characteristics can also be changed by the change of the coefficients: stop bandwidth, stopband attenuation, gain, filter type (Butterworth, Chebyshev)
To change design parameters of the filter, you need to ensure that you use Matlab Filter Designer tool with Response Type: Bandstop, Design Method: IIR, and Match exactly: stopband, as options (see figure below). Final filter design must have Order 4 and Sections 2 and the following fixed parameters for quantization. Green underlined sections must be the same as figures below. Yellow highlighted values can be changed to generate new coefficients/filter.

7.3.1. Unstable time for filter
Notch filter require a certain stabilization period after system initialization before valid data output. This settling time corresponds to 1% of the noise amplitude. Specifically, given the noise amplitude as A, stable data output is allowed only when the noise amplitude fluctuation falls within the range of -0.01A to +0.01A.
Convert to dB:
Auntable_time = -20log10(A/0.01A) = -40dB

That is, after the unstable period, the noise attenuation is not less than 40 dB.

The notch filter has an unstable period of about 800 milliseconds, during which no data will be output. This duration is configurable via SPI registers 0xB9 and 0xBA.
Note: Data interrupts are output normally if any notch filter is disabled. Interrupts will only be sent after the full stabilization time when all notch filters are enabled.


 





Now you can use the parameters generated above to change the filter response and characteristic as required. There are already default values in the design for 1000 Hz sampling rate and 50 Hz notch.

7.3.2. The following are the design specifications for the low-pass filter.
Parameter 	Value 	Description 
Order 	8-order and 4 -section	The filter is of 8th order and divided into 4 cascaded sections.
Apass1	1dB	Maximum passband ripple
Astop	50dB	Stopband attenuation
Apass2	1dB	Maximum passband ripple
Fs	Set by user	Data Rate
Fpass 1	46.5	Passband cutoff frequency
Fstop1	49	Stopband cutoff frequency
Fstop 2	51	Stopband cutoff frequency
Fpass 2	53.75	Passband cutoff frequency
coefficients	16	The filter coefficients are quantized into 16-bit binary values, including 1 sign bit, 1 integer bit and 14 fractional bits.




7.3.3. Filter coefficient

FLASH ADDR
{MSB,LSB}	coefficients	Default value of {0XBE,0xBD,0xBC}
(Fs=1000)
{0x16,0x15}	Scaleconst1/
Scaleconst2	0x3f9f
{0x18,0x17}	Coeff_b2_section1	0x8609
{0x1a,0x19}	Coeff_a2_section1	0x87a1
{0x1c,0x1b}	Coeff_a3_section1	0x3f39
{0x1e,0x1d}	Coeff_b2_section2	8680
{0x20,0x1f}	Coeff_a2_section2	0x865d
{0x22,0x21}	Coeff_a3_section2	0x3f4a
{0x24,0x23}	Scaleconst3/
Scaleconst4	0x3f1c
{0x26,0x25}	Coeff_b2_section3	0x862b
{0x28,0x27}	Coeff_a2_section3	0x883d
{0x2a,0x29}	Coeff_a3_section3	0x3e30
{0x2c,0x2b}	Coeff_b2_section4	0x865c
{0x2e,0x2d}	Coeff_a2_section4	0x87ae
{0x30,0x2f}	Coeff_a3_section4	0x3e42






7.3.4. Coefficient calculation

import subprocess
import sys
import os
 
def run_matlab_filter_design(fs_value):
    script_name = "temp_gen_filter.m"

    matlab_code = f"""
Fs = {fs_value};
Fpass1 = 46.5; Fstop1 = 49; Fstop2 = 51; Fpass2 = 53.75;
Apass1 = 1; Astop = 50; Apass2 = 1; match = 'stopband';
 
h = fdesign.bandstop(Fpass1, Fstop1, Fstop2, Fpass2, Apass1, Astop, Apass2, Fs);
Hd = design(h, 'cheby2', 'MatchExactly', match);
 
set(Hd, 'Arithmetic', 'fixed', 'CoeffWordLength', 16, 'CoeffAutoScale', false, ...
    'NumFracLength', 14, 'DenFracLength', 14, 'ScaleValueFracLength', 14);
 
sos = Hd.sosMatrix;
g = Hd.ScaleValues;
 
for i = 1:size(sos, 1)
    sc = dec2bin(typecast(int32(g(i) * 2^14), 'uint32'), 16);
    b1 = dec2bin(typecast(int32(sos(i,1) * 2^14), 'uint32'), 16);
    b2 = dec2bin(typecast(int32(sos(i,2) * 2^14), 'uint32'), 16);
    b3 = dec2bin(typecast(int32(sos(i,3) * 2^14), 'uint32'), 16);
    a2 = dec2bin(typecast(int32(sos(i,5) * 2^14), 'uint32'), 16);
    a3 = dec2bin(typecast(int32(sos(i,6) * 2^14), 'uint32'), 16);
 
    fprintf('scaleconst%d = 16''b%s\\n', i, sc(end-15:end));
    fprintf('coeff_b1_section%d = 16''b%s\\n', i, b1(end-15:end));
    fprintf('coeff_b2_section%d = 16''b%s\\n', i, b2(end-15:end));
    fprintf('coeff_b3_section%d = 16''b%s\\n', i, b3(end-15:end));
    fprintf('coeff_a2_section%d = 16''b%s\\n', i, a2(end-15:end));
    fprintf('coeff_a3_section%d = 16''b%s\\n', i, a3(end-15:end));
end
 
if length(g) > size(sos,1)
    last_sc = dec2bin(typecast(int32(g(end) * 2^14), 'uint32'), 16);
    fprintf('final_scale = 16''b%s\\n', last_sc(end-15:end));
end
exit;
"""
 
    # 1. Write the code to a temporary .m file
    with open(script_name, "w") as f:
        f.write(matlab_code)
 
    # 2. Run MATLAB on that file
    # -nodesktop -nosplash -r runs the script
    cmd = ["matlab", "-batch", script_name.replace(".m", "")]
 
    try:
        result = subprocess.run(cmd, capture_output=True, text=True, check=True)
        print(result.stdout)
    except subprocess.CalledProcessError as e:
        print(f"Error running MATLAB:\n{e.stderr}\n{e.stdout}")
    finally:
        # 3. Clean up the temporary file
        if os.path.exists(script_name):
            os.remove(script_name)
 
if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python get_coeffs.py <sampling_frequency>")
        sys.exit(1)

    fs_arg = sys.argv[1]
    run_matlab_filter_design(fs_arg)

7.3.5.  Register 

NF_UNSTABLE_TIME_0: Offset Address: 97h
Bit	Field Name	Attribute	Default	Field Description
7:0	NF_UNSTABLE_TIME	RW	00h	Notch filter unstable time（LSB）

NF_UNSTABLE_TIME_1: Offset Address: 98h
Bit	Field Name	Attribute	Default	Field Description
7:0	NF_UNSTABLE_TIME	RW	00h	Notch filter unstable time（MSB）

7.4. BIOELECTRIC Registers
7.4.1. BIOELECTRIC_REG_CTRL_0: Offset Address: 01h
Bit	Field Name	Attribute	Default	Field Description
7	PPG_MODE	RW	0b	PPG mode:
0: normal mode
1: ppg mode, means the channel will assign with led_status of ppg
6:4	CIC_RATE	RW	001b	Digital filter decimation:
000: 32
001: 64
010: 128
011: 256
100: 512
101: 1024
110: 2048(option)
111: Reserved
3	RESERVED	RO	0	Reserved
2	BIO_INT_EN	RW	0	Bio electricity interrupt enable
1	RESTART_EN	RW	0	This option is only used in ppg_mode
0: don’t restart to calculate when switch back to current filter
1: restart to calculate when switch back to current filter
0	ADC_INT_EN	RW	0	Interrupt Enable (End of ADC conversion interrupt. Disable this bit when FIFO interrupt is used.)

BIOELECTRIC_REG_CTRL_1: Offset Address: 02h
If DATA_TYPE_SEL is 2’b11, then DDS output (ROM sine wave) will be sent to ECG Calibration. However, ECG calibration requires an 8-bit sine wave that is much smaller than the DDS waveform. More specifically, the new sine wave must be between max value VSEL_TRIM_H<7:0> and min value VSEL_TRIM_L<7:0>. Two bits of VSEL_TRIM_H<9:8> and VSEL_TRIM_L<9:8> are used for changing ECG CAL DAC full voltage range (explained later). The LSB 8 bits and MSB 2 bits are trim values decided during CP test. 
The LSB 8 bits will result, first, in the DDS sine wave shifted right (divided by a power of 2), then offset is automatically added during positive side of sine wave and negative side of sine wave such that min and max values exactly fall on the 8-bit trim high and low values, respectively.
This register in the following table can be used to manually determine the amount of shift right, or let the hardware automatically perform the shift right depending on the low and high trim values. 
SHR_MAN_VAL value is used for manual shift right (divide by power of 2). That is, Sine wave of ROM which is from 0 to 10’h3FF, will be shift right by this value (divide by 2^ SHR_MAN_VAL).
As mentioned above, then positive (negative) side of sine wave is offset such that the new maximum (minimum) value is not 10’h3FF (0), rather it will be equal to the value of VSEL_TRIM_H<7:0> (VSEL_TRIM_L<7:0>) trim register. That is, the offset is automatically added (regardless of what SHR_MAN_EN is) to this new Sine wave after shift right, so that its min value is increased from 0 to VSEL_TRIM_L<7:0> and its max value is reduced from 10’h3FF to VSEL_TRIM_H<7:0>. Please note that output sine wave to ECG CAL is not the original 10-bit, rather it will be 8-bit now.
If DDS range (which is 10’3FF) cannot be divided by a power of 2 to achieve the new DDS range (VSEL_TRIM_H<7:0> - VSEL_TRIM_L<7:0>), then some values in the middle of sine wave are skipped. However, min and max values are guaranteed to be generated by the new sine wave. To be more specific, the final sine wave for ECG calculation in automatic mode will be [{Sine wave (between 0 and 10’h3FF)]} / {2^(10-⌊log2(VSEL_TRIM_H<7:0> -VSEL_TRIM_L<7:0> + 1)⌋)} (10 is the number of the original DDS bits). Then offset is added to match High trim or Low trim. 
Please note that, since ONLY divide by power of 2 (shift right) is being supported, then if the target waveform amplitude is, for example, 254, the automatic division will have to shift right the ROM waveform (with max value 1023) until the waveform will fit into 0 to 254. The nearest shift right will result in 0 to 127 sine wavefoms NOT a 0 to 255 sine wavefoms. Because 255 is larger than 254 and cannot fit into the target range of 0 to 254. After the shift right, to achieve 254 from a 128-sine-waveform, an offset will, however, be applied automatically to match the min and max (TRIM_H and TRIM_L) values like the figure below:
 

Bit	Field Name	Attribute	Default	Field Description
7:5	RESERVED	RW	8’h0	Reserved
4:1	SHR_MAN_VAL	RW	4’h0	If SHR_MAN_EN is 1, then SHR_MAN_VAL value is used for manual shift right (divide by power of 2). That is, Sine wave of ROM which is from 0 to 10’h3FF, will be shift right by this value (divide by 2^ SHR_MAN_VAL).
0	SHR_MAN_EN	RW	0	1: Enable manual entry of divide by a power of 2 of DDS ROM sine wave as explained in the SHR_MAN_VAL field.
0: Divide by power of 2 of DDS sine wave is performed automatically. Specifically, S=10-⌊log2(VSEL_TRIM_H<7:0> -VSEL_TRIM_L<7:0>)⌋ is used for manual shift right (divide by power of 2). That is, Sine wave of ROM which is from 0 to 10’h3FF, will be shift right by S (divide by 2^ S).

As mentioned before, VSEL_TRIM_H<9:8> and VSEL_TRIM_L<9:8> are used for changing ECG CAL DAC voltage full range as per table below:
Bit	Field Name	Flash/SPI address	Default	Field Description
	VSEL_TRIM_H<9:8>
VSEL_TRIM_L<9:8>	0x0E/0x60
	2’h0	Both H and L values should be same and can be one of following options:
0: VH-VL: 4 mV
1: VH-VL: 4.8 mV
2: VH-VL: 6 mV
3: VH-VL: 8 mV

In PPG mode, only 2 channels can be looped. When led_status of the ppg controller is 1, then the data generated by the filter is from the second PPG LED, so use the second filter, otherwise, the data is from the first LED, use first filter. The bit17 and bit16 stored in FIFO with data will also indicate the corresponding LED channel
When LED_STATUS equals 1 and D2A_PPG_SH_CK is 0, then turn on the filter1, otherwise, when LED_STATUS equals 0 and D2A_PPG_SH_CK is 0, turn on the filter0.
LED0 data is tagged with 00(LED_STATUS equals 0), and LED1 data is tagged with 01(LED_STATUS equals 1).
The preferred sequence to config registers is if we want to use PPG mode:
•	Set ppg_mode to 1
•	Turn on ppg controller
•	BIOELECTRIC single mode
•	Set bioelectric_en to 1


 7.4.2. BIOELECTRIC_CH_MODE: Offset Address: 03h (Bioelectric_channel_mode_register)source 
Bit	Field Name	Attribute	Default	Field Description
7:4	CHA_NUM	RW	0	Channel number select:
0000: channel 0
0001: channel 1
0010: channel 2 
0011: channel 3
0100: channel 4
0101: channel 5
0110: channel 6
0111: channel 7
3	CHA_RSV	RW	0	Reserved
2	FORMAT_SEL	RW	0	Data after digital filter format select
0: signed twos complRDnt
1: unsigned integer 
1:0	CHA_MODE	RW	00b	Channel mode select:
00: Single channel conversion mode
01: Single channel continuous conversion mode
10: Group conversion mode (support channel 0/1/2, above channel 3 is not supported)
11: Reserved

7.4.3. BIOELECTRIC_INT: Offset Address: 04h (bioelectric_interrupt_register)
Bit	Field Name	Attribute	Default	Field Description
7:6 	RESERVED	RO	0 	Reserved
5 	INT_SWITCH_STS 	RW1C 	0 	Lead off switch interrupt, write 1, interrupt status will be cleared 
Note: the int_switch include all switch interrupt, no matter it is N or P, ac or dc
4 	INT_DURATION_STS 	RW1C 	0 	Lead off duration interrupt，write 1, interrupt status will be cleared 
Note: the int_duration include all duration interrupt, no matter it is N or P, ac or dc
3	BIO_INT_STS 	RW1C 	0 	 Bio electricity checking interrupt 
2	INT_STS1  	RW1C 	0 	In ppg mode, every time channel1 samples EOC will generate interrupt status  
1	INT_STS0 	RW1C 	0 	In ppg mode, every time channel0 samples EOC will generate interrupt status  
0	INT_STS  	RW1C 	0 	In single channel mode, every time samples EOC will generate interrupt status  

Note: Here, RW1C means write bit 1 of this register to write to clear


7.4.4. BIOELECTRIC_REG_SEQ: Offset Address: 05h (Sequence Control Register)
Bit	Field Name	Attribute	Default	Field Description
7:3	RESERVED	RO	5’b0	Reserved
2	SD16RST	RW	1’b1	A/D converter software reset control bit 
0: Disable 
1: Enable
1:0	RESERVED	RW	2’b11	Reserved

 7.4.5. BIOELECTRIC_REG_RSTVAL: Offset Address: 06h (Reset Count Register)
Bit	Field Name	Attribute	Default	Field Description
7:0	RST_COUNT	RW	50h	In group conversion mode, when channel number change, reset of filter should be last some time to sample the correct from ADC  

7.4.6. BIOELECTRIC_CH0DATA_0: Offset Address :07h (Channel 0 LSB Data)
Bit	Field Name	Attribute	Default	Field Description
7:0	CHA0_DATA_LSB	RO	0	Channel_0_data LSB Bits [7:0]
In single channel mode, each channel data is stored into the register, the latter channel data will override the former
In group mode, only channel 0 data is stored into the register

7.4.7. BIOELECTRIC_CH0DATA_1: Offset Address :08h (Channel 0 MSB Data)
Bit	Field Name	Attribute	Default	Field Description
7:0	CHA0_DATA_MSB	RO	0	Channel_0_data MSB Bits [15:8]
In single channel mode, each channel data is stored into the register, the latter channel data will override the former
In group mode, only channel 0 data is stored into the register

7.4.8. BIOELECTRIC_CH1DATA_0: Offset Address 09h (Channel 1 LSB Data)
Bit	Field Name	Attribute	Default	Field Description
7:0	CHA1_DATA_LSB	RO	0	Channel_1_data LSB bits [7:0]
In single channel mode, this register is not used 
In group mode, only channel 1 data is stored into the register

7.4.9. BIOELECTRIC_CH1DATA_1: Offset Address 0Ah (Channel 1 MSB Data)
Bit	Field Name	Attribute	Default	Field Description
7:0	CHA1_DATA_MSB	RO	0	Channel_1_data MSB bits [15:8]
In single channel mode, this register is not used 
In group mode, only channel 1 data is stored into the register

7.4.10. BIOELECTRIC_CH2DATA_0: Offset Address :0Bh (Channel 2 LSB Data)
Bit	Field Name	Attribute	Default	Field Description
7:0	CHA2_DATA_LSB	RO	0	Channel_2_data LSB Bits [7:0]
In single channel mode, this register is not used 
In group mode, only channel 2 data is stored into the register  

7.4.11. BIOELECTRIC_CH2DATA_1: Offset Address: 0Ch (Channel 2 MSB Data)
Bit	Field Name	Attribute	Default	Field Description
7:0	CHA2_DATA_MSB	RO	0	Channel_2_data MSB Bits [15:8]
In single channel mode, this register is not used 
In group mode, only channel 2 data is stored into the register
 
7.4.12. BIOELECTRIC_GRP_CTRL: Offset Address: 0Dh 
Bit	Field Name	Attribute	Default	Field Description
7:1	RESERVED	R0	7’h0	RESERVED
0	BIOELECTRIC_GRP_CTRL	RW	0	Bioelectric grp control

7.4.13. BIOELECTRIC_CHA_NUM_LO: Offset Address: 0Eh (Channel number of ADC _LSB)
Bit	Field Name	Attribute	Default	Field Description
7:0	CHANNEL NUMBER of ADC_LSB	WR	8’h10	There are 8 channels of ADC However, there are 3 SINC filters at the ADC outputs, only 3 channels can be selected to be filtered in auto scan mode
[3:0] channel number which input to SINCA 
[7:4] channel number which input to SINCB


7.4.14. BIOELECTRIC_CHA_NUM_HI: Offset Address: 0Fh (Channel number of ADC_MSB)
Bit	Field Name	Attribute	Default	Field Description
7:4	RESERVED	RO	2’H0	RESERVED
3:0	CHANNEL NUMBER of ADC_MSB	WR	8’h02	There are 8 channels of ADC However, there are 3 SINC filters at the ADC outputs, only 3 channels can be selected to be filtered in auto scan mode
[3:0] channel number which input to SINCC  

7.4.15. BIOELECTRIC_ALARM_INT: Offset Address: 10h
Bit	Field Name	Attribute	Default	Field Description
7:1	RESERVED	-	0	Reserved
0	Bioelectric alarm interrupt	RO, write to clear	0	Bioelectric alarm interrupt status
When the bioelectric output is higher than threshold high (address is 0x3A-0x3B) or lower than threshold low(0x3C-0x3D), then interrupt
7.4.16.  BIOELECTRIC_ALARM_INT_EN: Offset Address: 11h
Bit	Field Name	Attribute	Default	Field Description
7:1	RESERVED	-	0	Reserved
0	BIOELEC_ALARM INT_EN	WR	0	Bioelectric alarm interrupt enable
1: enable
0: disable

7.4.17. BIOELECTRIC_THRESHOLD_HI_0: Offset Address: 12h
Bit	Field Name	Attribute	Default	Field Description
7:0	BIOELEC_ALARM_THRESHOLD_HIGH_LSB_VALUE	WR	8’hff	Bioelectric alarm high threshold LSB Bits

7.4.18. BIOELECTRIC_THRESHOLD_HI_1: Offset Address: 13h
Bit	Field Name	Attribute	Default	Field Description
7:0	BIOELEC_ALARM_THRESHOLD_HIGH_MSB_VALUE	WR	8’hff	Bioelectric alarm high threshold MSB Bits

7.4.19. BIOELECTRIC_THRESHOLD_LO_0: Offset Address: 14h
Bit	Field Name	Attribute	Default	Field Description
7:0	BIOELEC_ALARM_THRESHOLD_LOW_LSB_VALUE	WR	0	Bioelectric alarm low threshold LSB bits    

7.4.20. BIOELECTRIC_THRESHOLD_LO_1: Offset Address: 15h
Bit	Field Name	Attribute	Default	Field Description
7:0	BIOELEC_ALARM_THRESHOLD_LOW_MSB_VALUE	WR	0	Bioelectric alarm low threshold MSB bits

7.4.21. BIOELECTRIC_INPUT_FORMAT: Offset Address: 16h
Bit	Field Name	Attribute	Default	Field Description
7:2	RESERVED	RO	0	Reserved
1:0	BIOELEC_INPUT_FORMAT	WR	10	Bioelectric input format:
00: 0 is treated as 0, 1 is treated as 1
01: 0 is treated as 1, and 1 is treated as -1
Others: 0 treated as -1, and 1 is treated as 1

7.4.22. BIOELECTRIC_EN: Offset Address: Offset Address:17h
Bit	Field Name	Attribute	Default	Field Description
7:1	RESERVED	RO	0	Reserved
0	BIOELECTRIC_EN	WR	0	Bioelectric enable
0: disable
1: enable

Note: if want to disable the bioelectric_en to save power when bioelectric will not be used, should wait for any BIOELECTRIC_INT, then disable bioelectric_en, otherwise, there is the possibility that bioelectric_en is low but at the same time, the bioelectric is done, this bioelectric_done  pulse will keep active because bioelectric_en is to gate the bioelectric clock.

7.4.23. BIOELECTRIC_CH0DATA_MAX_0: Offset Address :18h (Bioelectric channel0 max value lsb bits)
Bit	Field Name	Attribute	Default	Field Description
7:0	BIOELEC_MAX_VALUE_LSB	RO	0H	Bioelectric max value lsb in checking period

7.4.24. BIOELECTRIC_CH0DATA_MAX_1: Offset Address :19h (Bioelectric channel0 max value msb bits)
Bit	Field Name	Attribute	Default	Field Description
7:0	BIOELEC_MAX_VALUE_MSB	RO	0H	Bioelectric max value msb in checking period

7.4.25. BIOELECTRIC_CH0DATA_MIN_0: Offset Address :1Ah (Bioelectric channel0 min value lsb bits) 
Bit	Field Name	Attribute	Default	Field Description
7:0	BIOELEC_MIN_VALUE_LSB	RO	0H	Bioelectric min value lsb  in checking period

7.4.26. BIOELECTRIC_CH0DATA_MIN_1: Offset Address :1Bh (Bioelectric channel1 min value msb bits) 
Bit	Field Name	Attribute	Default	Field Description
7:0	BIOELECTRIC_MIN_VALUE_MSB	RO	0H	Bioelectric min value msb  in checking period

7.4.27. BIOELECTRIC_CH0DATA_DELTA_0: Offset Address :1Ch (Bioelectric channel0 delta value Register lsb)
Bit	Field Name	Attribute	Default	Field Description
7:0	BIOELECTRIC_DELTA_VALUE_LSB	RO	0H	Bioelectric delta value lsb bits in checking period which means max value minus min value

7.4.28. BIOELECTRIC_CH0DATA_DELTA_1: Offset Address :1Dh (Bioelectric channel0 delta value Register msb)
Bit	Field Name	Attribute	Default	Field Description
7:0	BIOELECTRIC_DELTA_VALUE_MSB	RO	0H	Bioelectric delta value msb bits in checking period which means max value minus min value

7.4.29. NOTCH_FILTER_EN: Offset Address :1Eh (notch filter enable)
Bit	Field Name	Attribute	Default	Field Description
7:3	RESERVED	RO	0H	reserved
2:1	GAIN_SEL	RW	0H	00:no gain
01: x2 gain
10:x4 gain
11:no gain
Note that if we want to use gain, the output of filter  must obey the below conditions, otherwise we can’t use gain function:
if output always is  less than 16'h2fff,we can get x2 gain, 
if output always is  less than 16'h1fff,we can get x2 gain，0x4 gain, 



0	NOTCH_FILTER_EN	RW	0H	Notch filter enable

7.4.30. LEADOFF_INT: Offset Address: 1Fh (leadoff_interrupt_register)
Bit	Field Name	Attribute	Default	Field Description
7:0 	LEADOFF_INT	RW1C	0 	int_sts_switch_acloff_statp,int_sts_duration_acloff_statp,int_sts_switch_acloff_statn,int_sts_duration_acloff_statn,  int_sts_switch_loff_statp,int_sts_duration_loff_statp,int_sts_switch_loff_statn,int_sts_duration_loff_statn

Note: Here, RW1C means write bit 1 of  BIOELECTRIC_INT (0x4) to write to clear

8. ZMEAS
System consists of digital frequency generator that can excite the target impedance (Zunknown) with user specified allowable frequency and process the response signal from the impedance.
8.1. Block Diagram
The system is arranged as Analog Blocks followed by Digital Controller as shown in Figure 1. The ZMEAS system can be configured by the user as per the allowable user configuration specifications using SPI.
 


 Figure. 8 ZMEAS Block Diagram
8.2. Configuration Sequence
The sequence expected to be followed by firmware control for functional mode of ZMEAS is 
1.	Enable ZMEAS by writing into ZMEAS_EN register
2.	Configure the zmeas module in NO-OP CTRL[15:13] (MODE) =000
3.	Configure all the settings CTRL[D12:D0] and [D31:D16]
4.	Configure zmeas in INIT mode i.e. MODE=001, maintain reset reg_ctrl[] values
5.	START_CALC with f/w delay: MODE=011
6.	Wait for data be generated
7. Configure ZMEAS module in STANDBY mode by making MODE=110
8.3. APB ZMEAS Registers:
8.3.1. ZMEAS_REG_CTRL_0: Offset Address:0x20
Bit	Field Name	Attribute	Default	Field Description
7	D2A_Z_TX_GSEL_1	RW	0	Tx gain selector bit1
6	MEASURE_CALIBRATE 
	
RW	0	0: measurRDnt mode 
1: calibration mode 
5:4	TRX_CTRL 
	RW	0	Bit0:  Tx gain selector bit0
control the amplitude of sin wave coming out of DAC.
00:150mV, 01:300mV, 10:450mV 11:600mV
Bit1: zmeas enable
This enable is just for analog module only
3	RESERVED	RO	0	Reserved
2	PGA_GAIN 
	RW	0
	0: gain 1X 
1: gain 3x 
1	RESERVED	RO	0	Reserved
0	RESET_MEASURRDNT 
	RW	0
	0: normal operation 
1: zmeas will reset itself to wait for next user 
controlled MODE and INIT values: To Review

8.3.2. ZMEAS_REG_CTRL_1: Offset Address:0x21
Bit	Field Name	Attribute	Default	Field Description
7:5	REG_MODE	RW	3’h0	Sets control mode
000: NO OPERATION
001: INIT
011: START_CALC
010: POWER_DOWN
110: STANDBY
4	REPEAT_CALCULATION 
	RW 
	0	1: repeat_calculation, 
0: 512p DFT only once 
3	RESERVED	-	-	Reserved
2
	
ENABLE_INTR 
	
RW	0 
	0: interrupt generation not enabled 
1: interrupt generation enabled for indicating Real and Imaginary values for impedance 
measurRDnts are ready for read. 
1	RESERVED	-	-	Reserved
0	ENABLE_ADC_INTR
	
RW	0 
	0: adc interrupt generation not enabled 
1: interrupt generation enabled for indicating 
ADC_IN data every 16KHz, once adc_en. 
This can be used for letting uC calculate DFT. 

8.3.3. ZMEAS_REG_CTRL_2: Offset Address:0x22
Bit	Field Name	Attribute	Default	Field Description
7:4	REG_SETTLING_TIME_VAL_LSB	RW	0	number of cycle delay between start calculation or repeat calculation command and ADC commencRDnt time.
(LSB bits)
3	RESERVED	-	-	Reserved
2:0	REG_FREQ_VAL	RW	1	user can select frequency for impedance measurRDnt, out of the available frequency 
001: 500Hz
010: 1KHz
011: 2KHz
100: 4KHz
000: no frequency

8.3.4. ZMEAS_REG_CTRL_3: Offset Address:0x23
Bit	Field Name	Attribute	Default	Field Description
8:5	REG_NUMBER_OF_REPEAT_CYCLE_VAL	RW	0	number of repeats to facilitate average successive readings by repeating current frequency point calculation. Control register should have repeat flag set. i.e. control_reg=0x7000. User can enter any value from [1,2,3,4,5,6,7,8]
4:0	REG_SETTLING_TIME_VAL_MSB	RW	0	number of cycle delay between start calculation or repeat calculation command and ADC commencRDnt time.
(MSB_Bits)

8.3.5. ZMEAS_EN: Offset Address:0x40
Bit	Field Name	Attribute	Field Description
7:2	RESERVED	RO	RESERVED
1	ZMEAS_PHASE_DITHER_EN	W/R	zmeas_phase_dither_en
0	ZMEAS_EN	WR	Zmeas enable

8.3.6. ZMEAS_SYNC_EN: Offset Address:0x41
Bit	Field Name	Attribute	Default	Field Description
7:1	RESERVED	RO	0	RESERVED
0	ZMEAS_SYNC_EN	WR	1	Zmeas sync enable
0: keep reg_ctrl as SPI clock domain
1: sync reg_ctrl to pclk clock domain


 9. SPI FIFO
There is also a synchronous FIFO available in the switch able power domain, the measured bioelectric data is input to the FIFO, and output of the FIFO is mapped to the register which can be accessed via SPI slave. FIFO status empty, full, half full etc are mapped to registers which also can be accessed via SPI slave, the before mentioned status can be combined to generate interrupt, the interrupt signal is connected to pinmux module and then connected to INTB pin, that can be used to notify any external device. So, if interrupt is detected by external device such as MCU, then external device can read the FIFO status from SPI, to know if FIFO need to be read or stop read. Details of this block, please refer to the synchronous FIFO document.
9.1. FIFO Features
FIFO has size of 128 and each of elRDnt is 18-bit running with the frequency of 256Khz
9.2. Configuration Sequence
1- Set Conversion Mode (CHA_MODE) in (Channel Mode Register) to select mode (Single, Continuous, Group) 
  + Channel Mode Register at address 0x03, set bit [1:0] 
    - 00:  Single channel conversion mode
    - 01:  Single channel continuous conversion mode 
  - 10:  Group conversion mode (support channel 0/1/2, above channel 3 is not supported) 
2- Set SD16RST (bit-2 of Sequence Control Register) to 0 to do software reset
3- Set BIOELECTRIC_EN (bit-0 of BIOELECTRIC enable Register) to 1 to enable and DATA will be transfer to FIFO
4- Set FIFO_A_FULL_LEVEL (bit[7:0] of FIFO Configuration 1 Register to set level of FIFO Almost Full (should be 80% of FIFO)
5- Set FIFO_A_FULL_INT_EN (bit-5 of FIFO Configuration 3 Register to 1’b1 to trigger FIFO Interrupt Pin for Almost Full 
6- Waiting for FIFO Interrupt Pin to be triggered or polling almost full status bit (bit-5 of FIFO Status Register) to be triggered
7- Clear all status bit by writing 8’hF8 to FIFO Status Register) clear all status bit.
8- Issue burst read request from SPI to FIFO with burst size number is defined by FIFO_A_FULL_LEVEL (bit[7:0] of FIFO Configuration 1 Register) 
or USER can read FIFO_DATA_COUNT (8-bit of FIFO Counter 2) to get available items in FIFO.
9- Repeating this step and continue to read the FIFO
There is another way to use FIFO Empty Status instead of using FIFO Almost Full Status
- Or User can additionally use FIFO Empty Status in (FIFO Status Register) and FIFO Empty Interrupt to know when Software needs to stop or continue reading FIFO. 
This is often used in Single Read request from SPI Master.
- FIFO_ERR or FIFO_A_EMPTY or FIFO_FULL in (FIFO Status Register) are supported to support more features for Users.
- FIFO_ERR and FIFO_FULL in (FIFO Status Register) should not happen because when this condition has happened, then DATA will be lost because BIOELECTRIC is always sending DATA to FIFO and never stop sending.
9.3. Format of FIFO Data
Table 1: FIFO DATA FORMAT (FIFO_DATA[17:0]) 
 
Table 2: FIFO BYTE DATA ORDER
 
9.4. Registers
 9.4.1. FIFO_WR_PTR_REG (FIFO Write Pointer): Offset Address: 80h	
Bit	Field Name	Attribute	Default	Field Description
7:0		RO	00h	FIFO Write Pointer
FIFO_WR_PTR[7:0] points to the FIFO location where the next item is to be written. This pointer advances for each item pushed on to the FIFO by the internal conversion process. The write pointer is an 8-bit counter and wraps around to count 0x00 on the next item after count 0xFF

9.4.2. FIFO_RD_PTR_REG (FIFO Read Pointer): Offset Address: 81h	
Bit	Field Name	Attribute	Default	Field Description
7:0		RO	00h	FIFO Read Pointer
FIFO_RD_PTR[7:0] points to the location where the next item from the FIFO is read using the serial interface. This advances each time an item is read from the FIFO. The read pointer can be both read and written to. This allows an item to be reread from the FIFO if it has not already been overwritten. The read pointer is updated from an 8-bit counter and wraps around to count 0x00 from count 0xFF. Writing to the read pointer can affect the state of status register bits related to the FIFO and lead to unexpected behavior. Writing to the FIFO read pointer should be used for debug purposes only.


9.4.3. FIFO Counter 1: Offset Address: 82h	
Bit	Field Name	Attribute	Default	Field Description
7		RO	0	Reserved
6:0		RO	0	OVF_COUNTER[6:0] logs the number of items lost if the FIFO is not read in a timely fashion. This counter holds/ saturates at count value 0x7F. When a complete item is popped from the FIFO (when the read pointer advances), the OVF_COUNTER is reset to zero. This counter is essentially a debug tool. It should be read immediately before reading the FIFO in order to check if an overflow condition has occurred.
9.4.4. FIFO Counter 2: Offset Address: 83h 		
Bit	Field Name	Attribute	Default	Field Description
7:0		RO	0	        FIFO DATA COUNT [7]: 1 when full of FIFO happened
FIFO_DATA_COUNT [6:0] is a read-only register which holds the number of items available in the FIFO for the processor to read. This incrRDnts when a new item is pushed to the FIFO, and decrRDnts when the processor reads an item from the FIFO.


9.4.5. FIFO Configuration 1: Offset Address: 84h	
Bit	Field Name	Attribute	Default	Field Description
7:0		RW	5Fh	FIFO Almost Full Level
FIFO_A_FULL_LEVEL[7:0] sets the watermark for the FIFO and determines when FIFO_A_FULL_STS gets asserted. The FIFO_A_FULL_STS bit is set when the FIFO contains FIFO_A_FULL_LEVEL[7:0] items. If the FIFO_A_FULL_EN  interrupt enable bit is set an interrupt is asserted on the FIFO INT pin. This condition should prompt the applications processor to read samples out of the FIFO before it fills. The FIFO_A_FULL_STS bit and the interrupt on the FIFO INT pin are cleared when the status register is written 1. The microcontroller can read both the FIFO_WR_PTR and FIFO_RD_PTR to calculate the number of items available in the FIFO, or just read the OVF_COUNTER and FIFO_DATA_COUNT registers, and read as many items as needed to empty the FIFO. Alternatively, if the microcontroller always responds much faster than the selected sample rate, it can read FIFO_A_FULL_LEVEL[7:0] items when it detects an A_FULL interrupt to empty the FIFO.


9.4.6. FIFO Configuration 2: Offset Address: 85h 	
Bit	Field Name	Attribute	Default	Field Description
7:0		RW	1Fh	FIFO Almost Empty Level
FIFO_A_EMPTY_LEVEL[7:0] sets the watermark for the FIFO and determines when FIFO_A_EMPTY_STS  gets asserted. The FIFO_A_EMPTY_STS bit is set when the FIFO contains FIFO_A_EMPTY_LEVEL[7:0] items. If the FIFO_A_EMPTY_EN  interrupt enable bit is set an interrupt is asserted on the FIFO INT pin. This condition should prompt the applications processor to read samples out of the FIFO before it fills. The FIFO_A_EMPTY_STS bit and the interrupt on the FIFO INT pin are cleared when the status register is written 1. 


9.4.7. FIFO Configuration 3: Offset Address: 86h	
Bit	Field Name	Attribute	Default	Field Description
7	FIFO_ERROR_INT_EN	RW	0	FIFO_ERR_INT_EN: Error Interrupt Enable
The FIFO_ERR_INT_EN bit defines the interrupt output to PIN behavior when the FIFO_ERR_STS is 1. If FIFO_ERR_INT_EN is set low, FIFO INT pin will be not connected to FIFO_RR_STS. If FIFO_ERR_INT_EN is set high, then the FIFO INT pin will be connected to FIFO_ERR_STS.
6	FIFO_ALMOST_EMPTY_INT_EN
	RW	0	FIFO_A_EMPTY_INT_EN: Almost Empty Interrupt Enable
The FIFO_ A_EMPTY _INT_EN bit defines the interrupt output to PIN behavior when the FIFO_A_EMPTY_STS is 1. If FIFO_ A_EMPTY _INT_EN is set low, FIFO INT pin will be not connected to FIFO_A_EMPTY_STS. If FIFO_ A_EMPTY _INT_EN is set high, then the FIFO INT pin will be connected to FIFO_A_EMPTY_STS.
5	FIFO_ALMOST_FULL_INT_EN	RW	0	FIFO_A_FULL_INT_EN: Almost Full Interrupt Enable
The FIFO_ A_FULL _INT_EN bit defines the interrupt output to PIN behavior when the FIFO_A_FULL_STS is 1. If FIFO_ A_FULL _INT_EN is set low, FIFO INT pin will be not connected to FIFO_A_FULL_STS. If FIFO_ A_FULL _INT_EN is set high, then the FIFO INT pin will be connected to FIFO_A_FULL_STS.
4	FIFO_EMPTY_INT_EN	RW	0	FIFO_EMPTY_INT_EN: Empty Interrupt Enable
The FIFO_FULL_INT_EN bit defines the interrupt output to PIN behavior when the FIFO_FULL_STS is 1. If FIFO_FULL_INT_EN is set low, FIFO INT pin will be not connected to FIFO_FULL_STS. If FIFO_FULL_INT_EN is set high, then the FIFO INT pin will be connected to FIFO_FULL_STS.
3	FIFO_FULL_INT_EN	RW	0	FIFO_FULL_INT_EN: Full Interrupt Enable
The FIFO_FULL_INT_EN bit defines the interrupt output to PIN behavior when the FIFO_FULL_STS is 1. If FIFO_FULL_INT_EN is set low, FIFO INT pin will be not connected to FIFO_FULL_STS. If FIFO_FULL_INT_EN is set high, then the FIFO INT pin will be connected to FIFO_FULL_STS.
2	FIFO_TAG_EN	RW	0	FIFO_TAG_EN: Tag Out Enable
The FIFO_TAG_EN bit defines the DATA format sending from SPI Slave to SPI Master. If FIFO_TAG_EN is set high, then the SPI Slave will send 3 bytes (TAGS, MSB, LSB) to SPI Master. If FIFO_TAG_EN is set low, then the SPI Slave will send 2 bytes (MSB, LSB) to SPI Master only.
1	FIFO_ROLL_EN	RW	0	FIFO_ROLL_EN: FIFO Roll Enable
The FIFO_ROLL_EN bit defines the rollover behavior when the FIFO is full. If FIFO_ROLL_EN is set low, then a new data sample is not written to the FIFO and is lost when the FIFO is full. If FIFO_ROLL_EN is set high, then the FIFO rolls over to the first location and a new data sample is written to the FIFO, overwriting the old data sample.
0	FIFO_FLUSH_EN	RW	0	FIFO_FLUSH_EN: FIFO Flush Enable
The FIFO_FLUSH_EN bit is used for flushing the FIFO. If FIFO_FLUSH_EN is set high then the FIFO is emptied and the FIFO_WR_PTR[7:0], FIFO_RD_PTR[7:0], FIFO_DATA_CNT[8:0] and FIFO_OVF_CNT[6:0] are reset to zero.

F
9.4.8. IFO Status: Offset Address: 87h
Bit	Field Name	Attribute	Default	Field Description
7	FIFO_ERROR_INT_STS	RW1C	0	FIFO_ERR_STS: Error Status
1: writing to FIFO when FIFO is full or Reading FIFO when FIFO is empty
0: Normal
6	FIFO_ALMOST_EMPTY_INT_STS
	RW1C	1	FIFO_A_EMPTY_STS: Almost Empty Status
1: when number of available items in FIFO is equal to FIFO Almost Empty Level
Write 1 to clear this bit to 1’b0
5	FIFO_ALMOST_FULL_INT_STS	RW1C	0	FIFO_A_FULL_STS: Almost Full Status
1: when number of available items in FIFO is equal to FIFO Almost Full Level
Write 1 to clear this bit to 1’b0
4	FIFO_EMPTY_INT_STS	RW1C	1	FIFO_EMPTY_STS: Empty Status
1: when number of available items in FIFO is 00
Write 1 to clear this bit to 1’b0
3	FIFO_FULL_INT_STS	RW1C	0	FIFO_FULL_STS: Full Status
1: when number of available items in FIFO is 128
Write 1 to clear this bit to 1’b0
2	RESERVED	RO	0	Reserved
1:0	FIFO_TAGS
	RO	0	FIFO_TAGS: 2-bit Tags of DATA Format in FIFO
A- Not in PPG Mode
2’b00: DATA in FIFO are from channel 0 of BIOELECTRIC in Group mode
2’b01: DATA in FIFO are from channel 1 of BIOELECTRIC in Group mode
2’b10: DATA in FIFO are from channel 2 of BIOELECTRIC in Group mode
2’b11: DATA in FIFO are from channel 3 of BIOELECTRIC in SINGLE mode or Continuous Single mode
B- PPG Mode is enabled (Filter0 and Filter1 are used only and in Single mode only).
2’b00: 
2’b01: 
2’b10: No supported
2’b11: No supported


9.4.9. FIFO Data 1: Offset Address: 88h
Bit	Field Name	Attribute	Default	Field Description
7:0	FIFO_MSB_DATA	RO	00	MSB Byte of DATA from FIFO
FIFO_DATA1[7:0] is a read-only register used to retrieve MSB Byte data from the FIFO. This is for debug mode, used for reading MSB Byte DATA from FIFO in current FIFO Read Pointer. Reading this doesn’t make the change FIFO Read Pointer


9.4.10. FIFO Data 2: Offset Address: 89h
Bit	Field Name	Attribute	Default	Field Description
7:0	FIFO_LSB_DATA	RO	00	LSB Byte of DATA from FIFO
FIFO_DATA2[7:0] is a read-only register used to retrieve LSB Byte data from the FIFO. This is for debug mode, used for reading LSB Byte DATA from FIFO in current FIFO Read Pointer. Reading this doesn’t make the change FIFO Read Pointer

 10. GPIO 

10.1. GPIO_PU_CTRL: Offset Address: 90h
Bit	Field Name	Attribute	Default	Field Description
7:3	RESERVED	-	-	Reserved
2:0	GPIO_PU_EN	
RW	3’b000	GPIO PULL UP CONTROL REGISTER
0: FLOATING
1: PULL UP
note that the default is 111 in rtl

10.2. GPIO_PU_RESETN: Offset Address: 91h
Bit	Field Name	Attribute	Default	Field Description
7:1	RESERVED	-	-	Reserved
0	EXT_RESET_PU_EN	
RW	1’b1	EXTERNAL RESET PULL UP CONTROL REGISTER
0: FLOATING
1: PULL UP

10.3. GPIO_PD_TESTMODE: Offset Address: 92h
Bit	Field Name	Attribute	Default	Field Description
7:2	RESERVED	-	-	Reserved
1:0	TESTMODE_PD_EN	
RW	2’b11	TESTMODE PULL DOWN CONTROL REGISTER
0: FLOATING
1: PULL DOWN





11. PPG controller
Available SPI registers	Directly connecting	FSM
ppg_enable	ppg_enable = 0 (mode 1)	ppg_enable = 1 (mode 2)
Registers used in Mode1 or Mode 2:		Spi ppg reg -->ppg_controller-->analog ppg
Spi_to_ppg_ LEDDAC_SEL	D2A_ LEDDAC_SEL	Changed automatically by FSM
Spi_to_ppg_ LEDSEL<1:0>	D2A_ LEDSEL<1:0>	Changed automatically by FSM
Spi_to_ppg_LED_STANDBYEN	D2A_LED_STANDBYEN	Changed automatically by FSM
Spi_to_ppg_ LED_EN	D2A_ LED_EN	Changed automatically by FSM
Spi_to_ppg_ TIA_IDAC<7:0>	D2A_ TIA_IDAC<7:0>	D2A_ TIA_IDAC<7:0> (two register words available in FSM for LED0 and 1)
Spi_to_ppg_TIA_GAIN<3:0>	D2A_TIA_GAIN<3:0>	D2A_TIA_GAIN<3:0> (two register words available in FSM for LED0 and 1)
Spi_to_ppg_ EN_PPG_AF	D2A_ EN_PPG_AF	Changed automatically by FSM
Spi_to_ppg_ PPG_SH_CK	D2A_ PPG_SH_CK	Changed automatically by FSM
Spi_to_ppg_ EN_PPG_SH	D2A_ EN_PPG_SH	Changed automatically by FSM
Spi_to_ppg_EN_TIA	D2A_EN_TIA	Changed automatically by FSM
Spi_to_ppg_EN_PPG_BUFFER
 	D2A_ EN_PPG_BUFFER
 	Changed automatically by FSM
Spi_to_ppg_EN_PPGDAC_BUFFER
 	D2A_EN_PPGDAC_BUFFER
 	Changed automatically by FSM
Spi_to_ppg_ EN_TIA_VREFBUFFER	D2A_ EN_TIA_VREFBUFFER	Changed automatically by FSM
Sync_by_pass		0: use sync module;1: don’t use sync module;
Spi_to_ppg_PPG_DAC0_VSEL	PPG_DAC0_VSEL	FSM may perform sync
Spi_to_ppg_ PPG_DAC0_EN	PPG_DAC0_EN	FSM may perform sync
Spi_to_ppg_PPG_DAC1_VSEL	PPG_DAC1_VSEL	FSM may perform sync
Spi_to_ppg_ PPG_DAC1_EN	PPG_DAC1_EN	FSM may perform sync
Spi_to_ppg_PPG_TEST_OUT	PPG_TEST_OUT	FSM may perform sync
Spi_to_ppg_PPG_TEST_IN	PPG_TEST_IN	FSM may perform sync
Spi_to_ppg_PPG_PDV_REF_SEL	PG_PDV_REF_SEL	FSM may perform sync
Registers used in Mode2 only: 	Spi ppg control reg -->ppg_controller-->ppg FSM--> analog ppg	
ppg_mode_sel<2:0>	 	ppg_mode_sel<2:0>
ppg_led_time_sel<3:0>	 	ppg_led_time_sel<3:0>
ppg_led_Freq_sel<3:0>	 	ppg_led_Freq_sel<3:0>
ppg_idac_led_Sel	 	ppg_idac_led_Sel
		

block	Registers Name	Description	Default
LED DAC control	PPG_DAC0_VSEL <11:0>	 	00 0000 0000
	PPG_DAC1_VSEL <11:0>	 	00 0000 0000
	PPG_DAC0_EN
	 	0
	PPG_DAC1_EN
	 	0
	D2A_ LEDDAC_SEL (controlled by FSM in Mode 2)	“0” select  LEDDAC0;
”1” select  LEDDAC1	0
LED Drivier control	D2A_LED_STANDBYEN  (controlled by FSM in Mode 2)	 	0
	D2A_ LED_EN  (controlled by FSM in Mode 2)	 	0
	D2A_ LEDSEL<1:0>  (controlled by FSM in Mode 2)	00=  RED
01=  INFRED
10=  GREEN1
11=  GREEN0	00
 
PPG TIA control	D2A_VREF_SEL<1:0>	00              1.6-1.4=0.2V
01              1.7-1.5=0.4V
10              1.8-1.2=0.6V
11              1.9-1.1=0.8V	00
	D2A_ EN_TIA_VREFBUFFER  (controlled by FSM in Mode 2)	 	0
	D2A_EN_TIA  (controlled by FSM in Mode 2)	 	0
	D2A_TIA_GAIN<3:0>  (controlled by FSM in Mode 2)	1111= 6M 
1110=4.5M 
1101=3.5M 
1100=2.5M 
1011=1.5M
1010=1.1M
1001=0.85M
1000=0.6M
0111=0.5M
0110=0.32M
0101=0.16M
0100=0.08M
0011=0.04M
0010=0.02M
0001=0.01M
0000=1.4K	0000
	D2A_ TIA_IDAC<7:0> (controlled by FSM in Mode 2)	0000 0000=0A;
 
0000 0001~0111 1111
=65nA~65nA*127;
 
1000 0001~1111 1111
=2uA~2uA*127	0000 0000
PPG AF control	D2A_ EN_PPG_AF (controlled by FSM in Mode 2)	 	0
PPG SH control	D2A_ PPG_SH_CK (controlled by FSM in Mode 2)
 	 	0
	D2A_ EN_PPG_SH (controlled by FSM in Mode 2)	 	0
PPG Buffer control	D2A_ EN_PPG_BUFFER (controlled by FSM in Mode 2)	 	0
 	D2A_PPG_TEST_IN<1:0>	 	00 @ controller control mode
	D2A_PPG_TEST_OUT<1:0>	 	00 @ controller control mode

Spi digital signals all from SPI
CONTROL MODE, once received SPI then repeat the configuration 
There are four LED drivers in the PPG system, their name can be organised in the below table.
RED	LED_A
INFRED	LED_B
GREEN1	LED_C
GREEN0	LED_D
 
When PPG system is working, any of two LEDs are chosen to flash alternatively as shown in the Fig 1. During the enable of LED flashing, corresponding DC offset cancelation current should be applied. Each chosen LED is controlled by a DAC. There, two DACs are required.
 
Fig 1. LED driver method
The required digital controller diagram is shown in the Fig 2.
 

Fig 2. Diagram of digital controller (NEEDS update. This is from BMS3)
Updated:
 

The PPG working method is illustrated in the Figure 3.
 



 
Fig 3. PPG function
Where, the function of Mode_Sel is illustrated in the below table.
Mode Sel (FSM input from SPI)	LED1	LED2
000	LED_A	LED_A
001	LED_A	LED_B
010	LED_A	LED_C
011	LED_B	LED_B
100	LED_B	LED_C
101	LED_C	LED_C
110	LED_C	LED_D
111	LED_A	LED_A



For TIA_GAIN and TIA_IDAC, there are two sets of register arrays (reg1 and reg2) in FSM respectively. When IDAC_LEDSEL changes from 0 to 1, data is written to reg1. When IDAC_LEDSEL changes from 1 to 0, data is written to reg2(write data only when IDAC_LEDSEL changes) 
The D2A_LEDDAC_SEL choose the input reference (which is also the DAC buffer output) of the LED_BUFFER.
In PPG analog, the D2A_LEDSEL<1:0> control the LED_BUFFER connections to four LED switches as shown in the blow table.
 
LEDSEL (FSM output)	BUFFER connection
0	LED_A
1	LED_B
2	LED_C
3	LED_D

on_time_sel<3:0> (FSM input from SPI)	duration	unit
0	125	us
1	150	us
2	175	us
3	200	us
4	225	us
5	250	us
6	275	us
7	300	us
8	325	us
9	350	us
10	375	us
11	400	us
12	425	us
13	450	us
14	475	us
 
Period<3:0> (FSM input from SPI)	duration	unit
0	10	ms
1	12	ms
2	14	ms
3	16	ms
4	18	ms
5	20	ms
6	22	ms
7	24	ms
8	26	ms
9	28	ms
10	30	ms
11	32	ms
12	34	ms
13	36	ms
14	38	ms
15	40	ms

 

 


 

PPG REGISTERS:
 
PPG_REG_CTRL_1: Offset Address: 0x72
Bit	Field Name	Attribute	Default	Field Description
7	RESERVED	RO	0	Reserved
6	PPG_LED_PROG_SEL	R/W	1’b0	PPG_LED_PROG_SEL
0: use the 0x73/0x74 to select ON time and Period time
1: use the 0x7B – 0x7E to select ON time and Period time
5	PPG_SYNC_BYPASS	R/W	1’B0	PPG_SYNC_BYPASS
4:2	PPG_MODE_SEL	RW	3’b000	PPG_MODE_SEL (Mode Selection)
1	PPG_IDAC_LED_SEL	RW	1’b0	PPG_IDAC_LED_SEL
0	PPG_EN	RW	1’b0	PPG Enable

PPG_LED_TIME_SEL: Offset Address: 0x73
Bit	Field Name	Attribute	Default	Field Description
7:4	RESERVED	RO	4’b0	RESERVED
3:0	PPG LED_TIME_SEL	RW	4’b0	PPG LED_TIME_SEL

on_time_sel<3:0>	duration	unit
0	125	us
1	150	us
2	175	us
3	200	us
4	225	us
5	250	us
6	275	us
7	300	us
8	325	us
9	350	us
10	375	us
11	400	us
12	425	us
13	450	us
14	475	us
15	500	us



PPG_LED_FREQ_SEL: Offset Address: 0x74
Bit	Field Name	Attribute	Default	Field Description
7:4	RESERVED	RO	4’b0	RESERVED
3:0	PPG LED_FRQ_SEL	RW	4’b0	PPG LED_FRQ_SEL









Period<3:0>	duration	unit
0	10	ms
1	12	ms
2	14	ms
3	16	ms
4	18	ms
5	20	ms
6	22	ms
7	24	ms
8	26	ms
9	28	ms
10	30	ms
11	32	ms
12	34	ms
13	36	ms
14	38	ms
15	40	ms

PPG_LED_STATUS: Offset Address: 0x75
Bit	Field Name	Attribute	Default	Field Description
7:1		RO	4’b0	RESERVED
0		RO	1’b0	PPG_LED_STATUS

PPG_LED_ON_L: Offset Address: 0x7B
Bit	Field Name	Attribute	Default	Field Description
7:0		R/W	8’b0	LED_ON time of low 8 bits

PPG_LED_ON_H: Offset Address: 0x7C
Bit	Field Name	Attribute	Default	Field Description
5:0		R/W	6’b0	LED_ON time of high 6 bits

PPG_LED_FREQ_L: Offset Address: 0x7D
Bit	Field Name	Attribute	Default	Field Description
7:0		R/W	8’b0	LED_FREQ time of low 8 bits

PPG_LED_FREQ_H: Offset Address: 0x7E
Bit	Field Name	Attribute	Default	Field Description
5:0		R/W	6’b0	LED_FREQ time of high 6 bits





12. Bio Electricity 
 


MCLK divider is for generate MCLK for different SINWAVE frequency, the internal SINWAVE generator is based on 256KHz, so in order to generate lower SINWAVE frequency, lower the MCLK is needed, for example, the SINWAVE is 500Hz in 256Khz, then if you want to get 25Hz, then you need to config the N1 to 19(20-1) to get 25hz SINWAVE. The N1 range is 1 to 255.
N1 default is 19, which means default SINWAVE is 25Hz
The frequency range of the sinwave is 1.9HZ to 500HZ (500HZ/N1)

Except the SINWAVE, it is also needed to provide the DC and square waveform by mux, DC waveform can be configured the DC level by register; square waveform also can be configured the low level and high level by register; and square waveform period also can be configured by the register, the unit frequency is 1Khz, default is 64Hz (62.5Hz now)
 So the frequency range of a square wave is 1K/65536 to 1Khz

The ADC clock is for SINC filter clock generator, the N2 can be 0 to 7, indicating divided by 2, 4, 8, ....256 and the OSR of SINC filter also can be configured, the OSR range is 32, 64, 128, ..., 2048.
So the data rate should be:
The adc clock frequency range is:
128K, 64K, 32K, 16K, 8K,4K,2K,1K
The OSR range is 32, 64, 128, 256, 512, 1024, 2048
Then the data rate is adc clock/OSR
So, the data rate range maximum is 128k/32, and the minimum is 1k/2048.
 
freq(khz)	osr	data rate(khz)	data rate(hz)
128	32	4	4000
	64	2	2000
	128	1	1000
	256	0.5	500
	512	0.25	250
	1024	0.125	125
	2048	0.0625	62.5
64	32	2	2000
	64	1	1000
	128	0.5	500
	256	0.25	250
	512	0.125	125
	1024	0.0625	62.5
	2048	0.03125	31.25
32	32	1	1000
	64	0.5	500
	128	0.25	250
	256	0.125	125
	512	0.0625	62.5
	1024	0.03125	31.25
	2048	0.015625	15.625
16	32	0.5	500
	64	0.25	250
	128	0.125	125
	256	0.0625	62.5
	512	0.03125	31.25
	1024	0.015625	15.625
	2048	0.0078125	7.8125
8	32	0.25	250
	64	0.125	125
	128	0.0625	62.5
	256	0.03125	31.25
	512	0.015625	15.625
	1024	0.0078125	7.8125
	2048	0.00390625	3.90625
4	32	0.125	125
	64	0.0625	62.5
	128	0.03125	31.25
	256	0.015625	15.625
	512	0.0078125	7.8125
	1024	0.00390625	3.90625
	2048	0.001953125	1.953125
2	32	0.0625	62.5
	64	0.03125	31.25
	128	0.015625	15.625
	256	0.0078125	7.8125
	512	0.00390625	3.90625
	1024	0.001953125	1.953125
	2048	0.000976563	0.9765625
1	32	0.03125	31.25
	64	0.015625	15.625
	128	0.0078125	7.8125
	256	0.00390625	3.90625
	512	0.001953125	1.953125
	1024	0.000976563	0.9765625
	2048	0.000488281	0.48828125

The check clock divider is interval time for checking the SINC filter result, N3 can be 1 to 65535, which means divider by 2,3... to 65535. N3 default is 999(1000-1), which means the checking interval is 1s. The checking frequency of 1Hz, 2Hz, 4Hz, 8Hz, 12Hz, 16Hz, 20Hz are preferred
The check period frequency range is 1K/65536 to 1Khz and accordingly, the check period is 1ms to 8696s, which is (N/1000)s, N is 2 to 65535.

And check in every checking period separately.
The SINC value comparing is based on unsigned number, so this following register set to 1
12.1. Registers
12.1.1. BIOELECTRIC_CH_MODE: Offset Address:03h (Channel Mode Register) 
Bit 	Field Name 	Attribute	Default 	Field Description 
2 	FORMAT_SEL 	RW 	0 	Data after digital filter format select 
0: signed twos complRDnt 
1: unsigned integer  
 
And this register is preferred to set to 10
12.1.2. BIOELECTRIC_INPUT_FORMAT: Offset Address: 16h 
Bit 	Field Name 	Attribute 	Default 	Field Description 
31:2 	- 	RO 	0 	Reserved 
1:0 	Bioelectric_input_format 	WR 	10 	Bioelectric input format: 
00: 0 is treated as 0, 1 is treated as 1 
01: 0 is treated as 1, and 1 is treated as -1 
Others: 0 treated as -1, and 1 is treated as 1 
 
12.1.3. ZMEAS_REG_CTRL_0: REG_CTRL Register - Offset Address:0x20-0x23
Bit 	Field Name 	Attribute 	Default 	Field Description 
18:16 	reg_freq_val 	RW 	0 	user can select frequency for impedance measurRDnt, out of the available frequency  
001: 500Hz 
010: 1KHz 
011: 2KHz 
100: 4KHz 
others: no frequency 
7 	d2a_z_tx_gsel_1 	RW 	0 	Tx gain selector bit1 
5:4 	TRX_CTRL  
 	 
RW 	0  
 	Bit0:  Tx gain selector bit0 
control the amplitude of sin wave coming out of DAC. 
00:150mV, 01:300mV, 10:450mV 11:600mV 
Bit1: zmeas enable 
This enable is just for analog module only 
 
12.1.4. MCLK_DIV_REG: Offset Address: 0x51 
Bit 	Field Name 	Attribute 	Default 	Field Description 
7:0 	Mclk_div 	WR 	8’h13 	This clock will be used as zmeas main clock for generate different SINWAVE of DAC 
0: same as fclk, 256K 
N: 256k/(N+1) 
Default is 256k/20=12.8K, if default SINWAVE is 500hz(256K main clock), then SINWAVE is 500/20=25hz 

12.1.5. CHECK_CLK_DIV_HI  & CHECK_CLK_DIV_L0: Offset Address: 0x52-0x53 
0x52 is high 8 bits, 0x53 is low 8 bits 
Bit 	Field Name 	Attribute 	Default 	Field Description 
15:0 	Check_clk_div 	WR 	16’h3e7 	This check interval will be used as checking the SINC result of ADC, base frequency is 1Khz 
0: 0.5Khz 
N: 1KHz/(N+1) 
Default is 1Khz / (9999+1) = 1Hz 
 
12.1.6.  BIOELECTRIC_REG_CTRL_0 (Control Register): Offset Address: 01h 
Bit 	Field Name 	Attribute 	Default 	Field Description 
2 	Bio_int_en 	RW 	0 	Bio electricity interrupt enable 
 
12.1.7. BIOELECTRIC_INT: Offset Address: 04h 
Bit 	Field Name 	Attribute 	Default 	Field Description 
5	Int_switch_sts	RW1C	0	Lead off switch interrupt
4	Int_duration_sts	RW1C	0	Lead off duration interrupt
3 	BIO_INT_STS 	RW1C 	0 	Bio electricity checking interrupt 
Note: Here, RW1C means write bit0 of this register to write to clear

12.1.8. BIOELECTRIC_EN: Offset Address: 17h 
Bit 	Field Name 	Attribute 	Default 	Field Description 
31:1 	- 	RO 	0 	Reserved 
0 	Bioelectric_en 	WR 	0 	BIOELECTRIC enable 
 
BIOELECTRIC_CH0DATA_MAX_0 && BIOELECTRIC_CH0DATA_MAX_1
12.1.9.  (Bioelectric channel0 max value Register): Offset Address: 18h-19h 
Bit 	Field Name 	Attribute 	Default 	Field Description 
15:0 	Bioelectric_max_value 	RO 	0H 	Bioelectric max value in checking period 
19h is high 8 bits, 18h is low 8 bits

BIOELECTRIC_CH0DATA_MIN_0 && BIOELECTRIC_CH0DATA_MIN_1
12.1.10. (Bioelectric channel0 max value Register): Offset Address: 1Ah-1Bh 
Bit 	Field Name 	Attribute 	Default 	Field Description 
15:0 	Bioelectric_min_value 	RO 	0H 	Bioelectric min value in checking period
1Bh is high 8 bits, 1Ah is low 8 bits

BIOELECTRIC_CH0DATA_DELTA_0 && BIOELECTRIC_CH0DATA_DELTA_1
12.1.11. (Bioelectric channel0 delta value Register): Offset Address: 1Ch-1Dh 
Bit 	Field Name 	Attribute 	Default 	Field Description 
15:0 	Bioelectric_delta_value 	RO 	0H 	Bioelectric delta value in checking period,which means max value minus min value 
1Dh is high 8 bits, 1Ch is low 8 bits
 
The following is the sample simulation result
 

12.1.12. DATA_TYPE_SEL: Offset Address: 0x76 
Bit 	Field Name 	Attribute 	Default 	Field Description 
1:0 	Data_type_sel	WR 	0	00: SINWAVE
01: DC
10: square wave
11: ECG CAL SINWAVE

12.1.13. DC_DATA_REG_0: Offset Address: 0x77 
Bit 	Field Name 	Attribute 	Default 	Field Description 
7:0 	DC_DATA_REG_0	WR 	8’h0	DC value low 8 bits

Square waveform high level value and low-level value is stored in flash, they will be reloaded from flash at the reset of the first beginning and at the same time, user can config these register by SPI.
12.1.14. DC_DATA_REG_1: Offset Address: 0x78 
Bit 	Field Name 	Attribute 	Default 	Field Description 
1:0 	DC_DATA_REG_1	WR 	2‘b1	DC value high 2 bits


12.1.15. SQU_CLK_DIV_0: Offset Address: 0x79
Bit 	Field Name 	Attribute 	Default 	Field Description 
7:0 	SQU_CLK_DIV_0	WR 	8’hf	Square wave divider value low 8 bits

12.1.16. SQU_DIV_CLK_1: Offset Address: 0x7A 
Bit 	Field Name 	Attribute 	Default 	Field Description 
7:0 	SQU_CLK_DIV_1	WR 	2’h0	Square wave divider value high 8 bits


Square data high/low is at flash trim, which is same as DDS_TRIM (not used temporarily)
FLASH address	SPI address	Type	Default	Signal Name	Flash signals
0x0b	5Dh	RW	00h	Digital trim0[7:0] (VSEL_TRIM_H[7:0)	d2a_trim0_from_flash11
0x0c	5Eh	RW	00h	Digital trim0[9:8] (VSEL_TRIM_H[9:8])	d2a_trim0_from_flash12
0x0d	5Fh	RW	00h	Digital trim1[7:0] (VSEL_TRIM_L[7:0])	d2a_trim0_from_flash13
0x0e	60h	RW	00h	Digital trim1[9:8] (VSEL_TRIM_L[9:8])	d2a_trim0_from_flash14

13. Lead off detection: 
 
There are 2 kinds of lead off detections: 1 is pulse detection, another one is duration detection, but these 2 can be happened at the same time. If pulse goes down from 1 to 0, then duration counter will be counted again from 0 and pulse goes to target value, or duration goes to target value will reset all the counter to 0.
Doing these 2 detections at the same time.
 
The duration counter unit clock is 1Khz
Leadoff detection will generate an interrupt when matching the leadoff condition.

13.1. Registers
13.1.1. LEADOFF_CTRL: Offset Address: 0x93 
Bit 	Field Name 	Attribute 	Default 	Field Description 
6:0 	LEADOFF_CTRL	WR 	5’h0	Bit6: leadoff high/low active
0: high active
1: low active
Bit5:4 lead off switch/duration selector
00: switch&duration
01: switch only
10: duration only
11: switch&duration
Bit3: leadoff_int_en, lead off interrupt enable
Bit2: leadoff_det_en, lead off detection feature enable
Bit1:0: lead off type selector
00: N&P all active
01: N active only
10: P active only
11: N&P all active

 13.1.2. LEADOFF_TGT_0: Offset Address: 0x94
Bit 	Field Name 	Attribute 	Default 	Field Description 
7:0 	LEADOFF_TGT_0	WR 	8’hff	Lead off duration counter target value low 8 bits

13.1.3. LEADOFF_TGT_1: Offset Address: 0x95
Bit 	Field Name 	Attribute 	Default 	Field Description 
7:0 	LEADOFF_TGT_1	WR 	8’h0	Lead off duration counter target value high 8 bits

These two registers are used for the counter in duration mode. 
This lead off target value is for duration detection, base clock is 1Khz

13.1.4. LEADOFF_SWITCH_TGT: Offset Address: 0x96
Bit 	Field Name 	Attribute 	Default 	Field Description 
7:0 	LEADOFF_SWITCH_TGT	WR 	8’h3F	Lead off switch counter target value 8 bits

This register is used for the counter in pulse mode. 
13.1.5. BIOELECTRIC_INT: Offset Address: 04h 
Bit 	Field Name 	Attribute 	Default 	Field Description 
5	Int_switch_sts	RW1C	0	Lead off switch (Pulse mode) interrupt
4	Int_duration_sts	RW1C	0	Lead off duration interrupt
LEAD_OFF_CLK_REG: 0x4A 
 
LEAD_OFF _CLK_REG is used to set the clock for the AC lead off detection.
Note: 
1) Here, RW1C means write bit 1 of this register to write to clear.
2) Lead-off detection includes DC lead-off and AC lead-off, normally, these 2 lead-off detections cannot happen at the same time, so it is necessary to config these 2 lead-off enable separately.
3)  Incase analog and digital control are not matched, the analog lead-off enable is different from digital lead-off enable.
14. SPI CONTROLLER
14.1. OVER_VIEW:
       In BAF4 project, the off-chip SPI master can configure the BAF4 Registers and read the BAF4 FIFO through this SPI top block interfaces. Where this SPI top has the SPI register block which is used to store the configuration values of the Register as well as its system status values. The register in the register block can be read/write through SPI slave controller which provides the SPI protocol compatibility for the SPI register access. Apart from this register read/writes the SPI Controller will burst read the data from the FIFO and sends those data to the SPI Master. SPI controller can write/read data to/from the register block, but it can only read data from the FIFO block.
2.BLOCK_DIAGRAM:

Figure 1. SPI slave block diagram
 
14.2. Functional Description:
  SPI controller will receive the SPI command formats from the SPI master and based on the command format it can write/read the data from the register block and sends to the spi_master.
        The command format to access the registers are write/write busrt, read, read_burst command’s where the slave controller will automatically incrRDnt the register access address in the burst mode. 
    The SPI slave controller can read the fifo data from the fifo in a burst mode using the FIFO read command. Whenever the SPI controller receives the fifo_rd_cmd, it will send the fifo_rd_req_n signal  to the FIFO, to request the data  from the FIFO,  after receiving the fifo data the spi_controller will send the data to the spi_master.The FIFO after pushing the data from FIFO will incrRDnt the fifo rd_ptr. 
 (note, the FIFO data can be read through the fifo_data_register(readonly), from the register block. But these registers are only for the debug purpose)
                   
14.3. Interface
Table ‎1. SPI top Interface
IO	Direction	Bit	Definition
Off chip SPI interface			
I_CS	Input	1	Chip select from SPI Master
I_SCLK	Input	1	SPI clock from SPI Master
 I_MOSI	Input	1	SPI Master out slave input. (Line for the Master to send data to the Slave.)
O_MISO	Output	1	SPI Master in slave output. (Line for the slave to send data to the master).
Internal system I/F			
I_rst_n	Input	1	System reset
I_scanclk	Input 	1	Scan clk
SCANMODE	Input	1	Scan mode enable input
FIFO I/F			
Fifo_data_rd	Input	16	Fifo read data from fifo (to spi_controller)
Fifo_pntr_rd	Input	8	Fifo read pointer
Fifo_pntr_wr	Input  	8	Fifo write pointer
Fifo empty	Input	1	Fifo empty signal
Fifo a full	Input 	1	Fifo almost full
Fifo_data	Input	16	Fifo retrieved data from fifo to the SPI reg
Fifo error	Input	1	Fifo error signal
Fifo a empty	Input 	1	Fifo almost empty
Fifo_rd_req_n	Output	1	Fifo read request (spi cntr to fifo)
Fifo_flush 	Output 	1	Fifo flush
Fifo_roll	Output 	1	Fifo roll
Fifo_a_full	Output 	1	Fifo almost full
I MeasurRDnt  I/F			
bioelectric_ch0data	Input	16	I_measurRDnt ch0 data
bioelectric_ch1data	Input	16	I_measurRDnt ch1 data
bioelectric_ch2data	Input 	16	I_measurRDnt ch2 data
bioelectric_int_sts	Input 	1	BioelectricsurRDnt int
bioelectric_int_clr	Input	1	BioelectricurRDnt interrupt clear
bioelectric_reg_ctrl	Output	16	BioelectricurRDnt control reg values
bioelectric_reg_ch	Output	7	BioelectricurRDnt reg ch
bioelectric_reg_seq	Output	3	I measurRDnt reg seq
bioelectric_reg_rstval	Output	8	I Measurment reg rst value
Z MeasurRDnt I/F			
zmeas_int_clr	output	1	ZMeasurent interrupt clear
zmeas_adc_int_clr	output	1	Z MeasurRDnt ADC Interrupt clear
zmeas_reg_ctrl	output	31	Z MeasuRDnt control register value
zmeas_reg_status	input	16	Z MeasurRDnt register status
zmeas_reg_dataout	Input	16	Z MeasurRDnt data out
zmeas_xn_data	Input	10	Z MeasurRDnt xn data
zmeas_sine_for_dft	Input	10	Z MaasurRDnt sine for DFT
zmeas_cosine_for_dft	Input 	10	Z MeasurRDnt cosine for DFT
zmeas_summation_offset_forreal	Input	29	zmeas_summation_offset_forreal
zmeas_summation_real	Input 	29	zmeas_summation_real
zmeas_summation_imag	Input	29	zmeas_summation_imag
zmeas_shiftedreal_inter	Input	16	zmeas_shiftedreal_inter
zmeas_dft_cnt	Input 	12	zmeas_dft_cnt
reg_zmeas_int	Input 	1	 Z MeasurRDnt Interrupt
reg_zmeas_adc_int	Input	1	Z MeasuRDnt adc interrupt
Clk_ctrl I/F			
fclk_dynen	Output	1	Fclk dynamic enable
pclk_div	Output	2	Pclk divider
iclk_div	Output	3	I clk divider
Flash I/F			
flash_regs	Output	8	Flash register output ,array of size 8 each array value has 8 bit
Unlock	Output	1	Unlock
DEBUG_FLASH	Output	16	Debug flag register
PMS I/F			
ext_wake_sts	Input 	1	External wake status
psw_wake_sts	Input	1	Psw wake status
pmuenable	Input	1	PMU enable
Hresetreq	Output	1	Hreset request
Sleepdeep	Output	1	Sleep deep
ext_wake_clr	Output	1	External wake clear
psw_wake_clr	Output	1	Psw wake clear
ext_wake_mod	Output 	1	External wake mode
psw_wake_mod	Output	1	Psw wake mode
ext_wake_en	Output	1	External wake enable
psw_wake_en	Output	1	Psw wake enable
hresetreq_wake_en	Output 	1	Hrequest wake enable
hfosc_slpen	Output 	1	Hfosc sleep enable
clk_stable_val	Output	32	Clk stable value
flash_dpstb_en	Output 	1	flash_dpstb_enable
14.4. SPI Slave Controller Specification:
  SPI Slave Controller Features:
           *   8bit data length format
          *   Supports SPIMODE-2 (CPOL=0, CHPA=0)
          *  Supports write/write burst command
          *  Supports read/read burst command
           *  Supports fifo_rd_cmd/fifo read burst command 
14.4.1. Communication:
The master transmits the data to the slave via the MOSI (Master Output, Slave Input line) and receives data from the slave via the MISO (Master Input, Slave Output line). SPI communication is always initiated by the master by making chip select low, and sending the SCLK(Clock) to the slave. For the successful data transmission, the master and slave should agree upon clock frequency, clock polarity (CPOL), and clock phase (CPHA). where this Clock Polarity and Clock Phase are two properties work together to define when the bits are output and when they are sampled.  The spi_slave controller ‘s Clock Polarity and Clock Phase are fixed. They are not configurable, so it’s Spi_Master responsibility to send the data’s based upon the agreed mode between the master and slave.
This SPI slave controller works in SPI-MODE: 0. where the Clock polarity=0, and Clock_phase-0. Where the data transmission takes place on the rising edge of the clock.
14.4.2. SPI Modes:
•	Clock polarity: 
o	0: SCK to 0 when idle
o	1: SCK to 1 when idle        
•	Clock phase:
o	0: The first clock transition is the first data capture edge
o	1: The second clock transition is the first data capture edge
             
                                                                    
Figure ‎52. SPI modes

•	When the data frame transfer is complete (all the bits are shifted) the information between the master and slave is exchanged.
14.4.3. Data communication format between Master and Slave
The SPI slave controller communicates with master by using the rd/wr cycle format.
32 bits write cycle format
WR_ADDR (7:0) +CMD (7:0) +WR_DATA (7:0) +PADDING_BITS (7:0)
24 bits Read cycle format
RD_ADDR (7:0) +CMD (7:0) +PADDING_BITS (7:0) 
Table ‎52. Command Instruction Structure
MSB (7)	6	5	4	3	2	1	LSB (0)
wr/rd cmd	FIFO 
Access 	Burst En	Reserved	Reserved	Reserved	Reserved	Reserved
Bit:7  - Wr/rd cmd 
•	1 =>Write command 
•	0 =>read command
Bit:6   - FIFO cmd
•	1=>FIFO rd/wr cmd
•	0=> REG Rd/Wd cmd
Bit:5 - Burst en
•	1=>Burst command
•	0=> not a Burst command
Bit: 4:0       Reserved

14.4.3.1. Write cycle:
Whenever Master wants to write into the registers of the spi_register block. Master initiates the Transmission by making chip select (cs_n) low and supply the sclk, then send’s the 4bytes of write cycle date on MOSI. 
The write cycle data contains 8bit write address followed by 8bit wr_cmd,8-bit wr_data and padding bits of length 8.
 
   
Figure ‎43. Write Cycle

The SPI slave controller will sample wr_cycle data and sends the wr_addr, wr_data, wr_en to the spi_register block.
(During 1st sclk the cs and mosi will be latched to the internal latches (cs_n, mosi_d), on the 2nd sclk the mosi_d data will be latched to the rx_buffer), padding bits are added to provide the sclk, to output the data which is received from the master as it’s in the miso line during the full duplex mode).
In full duplex mode, the MISO line will output don’t cares during the wr_address phase, and wr_address on cmd phase, and cmd in the  wr_data phase, and wr_data in the padding bit phase.
14.4.3.2. Write burst:
 For register burst write access, additional groups of 8 SCLK cycles are applied after the initial 24 cycles.  Which will be followed by 8 padding bits. The register address is automatically incrRDnted after the 24th SCLK cycle and after each subsequent group of 8 SCLK cycles. The data bytes received after the first 24 SCLK cycles are sequentially written to their automatically calculated address. Therefore, if a transaction is (24 + (8 x N) ) SCLK cycles long, N + 1 adjacent registers are written starting at the address specified by the first byte.
 

  
14.4.3.3. Read cycle
Whenever Master wants to read from the registers in the SPI Register block. Master initiates the Transmission by making chip select (cs_n) low and supply the SCLK, then send’s the 3bytes of read cycle date on MOSI.
Where The Read cycle data contains 8bit read address which will be followed by 8bit rd_cmd, and 1 bytes of padding bits.

 
                                              Figure ‎44. Read cycle

The SPI slave controller samples the read cycle data and sends the rd_addr and read enable to the spi_register block during the first 2 phase of the read cycle, during the last phase (padding bytes-1) outputs the data read from the spi_register block through the miso line.
Single-byte register read transactions fetch the requested data before the 16th SCLK rising edge and present the MSB of the requested data on the following SCLK falling edge, allowing the microcontroller to latch the data MSB on the 17th SCLK rising edge. To conclude the transaction, CSB is de-asserted after the 24th SCLK rising edge.

14.4.3.4. Read Burst:
 For register burst read access, additional groups of 8 SCLK cycles are applied after the initial 24 cycles. The register address is automatically incrRDnted after the 24th SCLK cycle and after each subsequent group of 8 SCLK cycles. The content of those automatically calculated addresses is retrieved each time a new group of 8 SCLK cycles are applied. Therefore, if a transaction is (24 + (8 x N)) SCLK cycles long, N + 1 adjacent registers are read starting at the address specified by the first byte.


 

 
14.4.3.5. FIFO_RD_CMD:
This fifo_rd_cmd are used to read the fifo datas as a burst through spi_controller.
(Ffio dats  are read by two ways. 1. BY reading the fifo_data_register’s in the register block using read -cmd . 2. By fifo_rd_cmd ,where the fifo data’s can be read from the fifo as a burst data’s)
  FIFO_RD_CMD’s are 2 types
   1.  Fifo_rd_cmd  4 bytes-> to read the  fifo data(with out tag)
   2. Fifo_rd_cmd  5 bytes-> to read the  fifo_data(with tag)
14.4.3.5.1.	FIFO_rd_cmd ->4 bytes:
 The SPI read transactions for FIFO_DATA  access has a minimum of 4 bytes. The first byte is the address byte for FIFO_DATA; the second byte is the command byte; and the next two bytes are the data bytes, as the FIFO data is 16-bit wide. Burst transactions allow to access adjacent FIFO locations, as the FIFO Read Pointer is automatically incrRDnted after each group of two data bytes. The register address, however, is not incrRDnted with FIFO_DATA burst transactions.


 


14.4.3.5.2.	FIFO_rd_cmd ->5 bytes:
    This command read the fifo data along with the tag and send to the spi_master, The first byte is the address byte for FIFO_DATA; the second byte is the command byte; and the next two bytes are the data bytes, the last byte reperesents the tag . Burst transactions allow to access adjacent FIFO locations, as the FIFO Read Pointer is automatically incrRDnted after each group of two data bytes. The register address, however, is not incrRDnted with FIFO_DATA burst transactions.     
 




  










14.4.4.  SPI-Timing Characteristics:
Parmeter	Symbol	Conditions	
 Min              	Typ	Max	Units
SCLK Frequency	fSCLK		                           		1	Mhz
SCLK Period	tCP		1000			ns
SCLK Pulse width High	tCH		400			ns
SCLK Pulse Width Low	tCL		400			ns
CS fall to SCLK rise  Time	tCSSO		400			ns
SCLK Fall to CS rise Time	tCSH1		400			ns
CS pulse width High	tCSPW		500			ns
MOSI  to SCLK Rise Setup time	tDS		200			ns
MOSI  to SCLK Rise Holdtime	tDH		200			ns
SCLK Fall to MISO Transition	tDOT				100	ns

 



15. Typical Application Scenario
15.1. BIOELECTRIC Configuration Sequence:
1. Select iclk (SDM clk) frequency using CLK_CTRL_REG register
2. Enable BIOELECTRIC by writing into BIOELECTRIC_EN register
3. Select input format using BIOELECTRIC_INPUT_FORMAT register
4. Enable interrupt & configure CIC rate using BIOELECTRIC_REG_CTRL_0
5. Set CHMOD 2’b00 to select single channel conversion mode, CHMOD 2’b01 to select single channel continuous conversion mode or CHMOD 2’b10 to select group conversion mode using BIOELECTRIC_CH_MODE register
6. Configure channel number & conversion data format in BIOELECTRIC_CH_MODE register. For Group mode, select the 3 channels for group conversion by setting GRPCHNUM using BIOELECTRIC_CHA_NUM_LO & BIOELECTRIC_CHA_NUM_HI registers
7. Start conversion by setting SD16RST 1’b0 to release reset for CIC digital filter using BIOELECTRIC_REG_SEQ register
8. Wait for interrupt, set SD16RST to 1’b1 to stop conversion
9. For Single channel mode, Read the conversion data of channel 0 using BIOELECTRIC_CH0DATA and then clear interrupt. For Group mode, Read the conversion data of 3 channels; channel 0 using BIOELECTRIC_CH0DATA, channel 1 using BIOELECTRIC_CH1DATA, channel 2 using BIOELECTRIC_CH2DATA and then clear interrupt
10. If customer want to use fifo to read the bioelectric data, refer to the chapter 9.2 for details

15.2. ZMEAS Configuration Sequence:
1. Enable ZMEAS by writing into ZMEAS_EN register
2. Enable Calibration mode to estimate the calibrated impedance using “measure_calibrate = 1”
3. Set No Operation mode by setting reg_mode as 0 using ZMEAS_REG_CTRL register
4. Configure pga gain, output voltage range, settling time, frequency value; and then set INIT mode by setting reg_mode as 1 using ZMEAS_REG_CTRL. INIT mode will enable DDS.
5. Enable interrupt and set CALC mode by setting reg_mode as 3 using ZMEAS_REG_CTRL. CALC mode will start measurRDnt by enabling ADC.
6. Wait for interrupt, read status using ZMEAS_REG_STATUS and read calibrated impedance data using ZMEAS_REG_DATAOUT and then clear interrupt
7. Enable MeasurRDnt mode to estimate the measured impedance using “measure_calibrate = 0”
8. Set No Operation mode by setting reg_mode as 0 using ZMEAS_REG_CTRL register
9. Configure pga gain, output voltage range, settling time, frequency value; and then set INIT mode by setting reg_mode as 1 using  ZMEAS_REG_CTRL. INIT mode will enable DDS.
10. Enable interrupt and set CALC mode by setting reg_mode as 3 using ZMEAS_REG_CTRL. CALC mode will start measurRDnt by enabling ADC.
11. Wait for interrupt, read status using ZMEAS_REG_STATUS and read measured impedance data using ZMEAS_REG_DATAOUT and then clear interrupt
12. Estimate final unknown impedance from these calibration & measurRDnt data

16.  SAMPLE DEMO
1.	Enter bist mode by setting {TEST_MODE1, TEST_MODE0} = 2'b10
2.	Program NVR0 address 0x0: 0x5A (valid tag)
3.	Program NVR0 address 0x1 ~ 0x7 with the desired analog trim values.
4.	Once program is done, enter normal mode by setting {TEST_MODE1, TEST_MODE0} = 2'b00
5.	Turn off power, then turn on to check if after power on reset, flash reload has been done.
6.	Read the flash trim values from FLASH_TRIM0~6 registers to confirm the updated trim values.
7.	Set desired values for Analog Registers
8.	Set always_on_spi_write bit 7 of CLK_CTRL_REG to load those values to always on shadow registers.
9.	Read the Analog debug registers to confirm the updated analog settings.
10.	Enter low power mode by pulling down the external wakeup to 0.
11.	After some delay, enter active mode by setting wakeup=1
12.	Read the Analog debug registers to make sure the trim values as well as always on analog signals are not affected during low power mode.









New changes for using 256 bytes of flash
Register:
Flash data registers:
FLASH_WR_DATA: Offset Address: 0x68
Bit	Field Name	Attribute	Default	Field Description
7:0	Flash data	R/W	8’b0	The data that will be wrote into flash

FLASH_ADDR: Offset Address: 0x69
Bit	Field Name	Attribute	Default	Field Description
7:0	Flash addr	R/W	8’b0	This is for programing the DATA of NVR1 of Flash from address of 0x100 to address of 0x1FF, what is used to read/wrote 


FLASH_RD_DATA: Offset Address: 0x6a
Bit	Field Name	Attribute	Default	Field Description
7:0	Flash data	R	8’b0	The data that is read from flash

FLASH_UNLOCK: Offset Address: 0x67
Bit	Field Name	Attribute	Default	Field Description
7:3	KEY_TRIM/KEY_SPI	R/W	5’b0	Key word:
KEY_TRIM: 5’b10101, must be set this value when writing trim data
KEY_SPI    : 5’b01010, must be set this value when writing flash high part (from 0x100 to 0x1ff) 
  2	Flash_read command	R/W	1’b0	Read command
1	FLASH_WRITE	R/W	1’b0	SPI write 
0	FLASH_UNLOCK	R/W	1’b0	FLASH UNLOCK
In order to do UNLOCK, Flash MUST have a clock of 1Mhz (external clk)

Step:
Write:
1.	Write Flash Address register to give the address
2.	Write Flash Data register to give the data
3.	Write Unlock register bit[7:3] to give KEY_SPI (or step3/4 can be done together) 
4.	Write Unlock register bit-0 to enable Flash Unlock
5.	Read Unlock register bit-0 until bit-0 is 0
6.	Go back step 1 to write next data
read:
1. Write Flash Addr Register to give the address
2. Write Unlock register bit[7:3] to give KEY_SPI (or step2/3 can be done together)
3. Write Unlock register bit-2 to enable read command, then wait 1us, write this bit to 0
4. Read FLASH_RD_DATA register to get the data
5. Go back step1 to read next data
Note: SPI Address is from 0x00 to 0xFF,
           Flash Address is from 0x100 to 0x1FF (SPI Address + 0x100)
