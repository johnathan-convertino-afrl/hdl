
source ../../scripts/adi_env.tcl
source ../../scripts/adi_project_intel.tcl

adi_project adrv9371x_hanpilot

source $ad_hdl_dir/projects/common/hanpilot/hanpilot_system_assign.tcl
source $ad_hdl_dir/projects/common/hanpilot/hanpilot_sodimm_plddr4_assign.tcl

# sma clk out
set_location_assignment PIN_AN21 -to sma_clkout
set_location_assignment PIN_AM21   -to "sma_clkout(n)"
set_instance_assignment -name IO_STANDARD "1.8 V" -to sma_clkout
set_instance_assignment -name IO_STANDARD LVDS -to "sma_clkout(n)"

# ad9371

set_location_assignment PIN_P31   -to ref_clk0               ; ## D04  FMC_HPC_GBTCLK0_M2C_P (NC)
set_location_assignment PIN_P30   -to "ref_clk0(n)"          ; ## D05  FMC_HPC_GBTCLK0_M2C_N (NC)
set_location_assignment PIN_K31   -to ref_clk1               ; ## B20  FMC_HPC_GBTCLK1_M2C_P
set_location_assignment PIN_K30   -to "ref_clk1(n)"          ; ## B21  FMC_HPC_GBTCLK1_M2C_N

set_location_assignment PIN_R33   -to rx_serial_data[0]      ; ## A02  FMC_HPC_DP1_M2C_P
set_location_assignment PIN_R32   -to "rx_serial_data[0](n)" ; ## A03  FMC_HPC_DP1_M2C_N
set_location_assignment PIN_M35   -to rx_serial_data[1]      ; ## A06  FMC_HPC_DP2_M2C_P
set_location_assignment PIN_M34   -to "rx_serial_data[1](n)" ; ## A07  FMC_HPC_DP2_M2C_N
set_location_assignment PIN_P35   -to rx_serial_data[2]      ; ## C06  FMC_HPC_DP0_M2C_P
set_location_assignment PIN_P34   -to "rx_serial_data[2](n)" ; ## C07  FMC_HPC_DP0_M2C_N
set_location_assignment PIN_N33   -to rx_serial_data[3]      ; ## A10  FMC_HPC_DP3_M2C_P
set_location_assignment PIN_N32   -to "rx_serial_data[3](n)" ; ## A11  FMC_HPC_DP3_M2C_N
set_location_assignment PIN_L37   -to tx_serial_data[0]      ; ## A22  FMC_HPC_DP1_C2M_P (tx_serial_data_p[3])
set_location_assignment PIN_L36   -to "tx_serial_data[0](n)" ; ## A23  FMC_HPC_DP1_C2M_N (tx_serial_data_n[3])
set_location_assignment PIN_K39   -to tx_serial_data[1]      ; ## A26  FMC_HPC_DP2_C2M_P (tx_serial_data_p[0])
set_location_assignment PIN_K38   -to "tx_serial_data[1](n)" ; ## A27  FMC_HPC_DP2_C2M_N (tx_serial_data_n[0])
set_location_assignment PIN_M39   -to tx_serial_data[2]      ; ## C02  FMC_HPC_DP0_C2M_P (tx_serial_data_p[1])
set_location_assignment PIN_M38   -to "tx_serial_data[2](n)" ; ## C03  FMC_HPC_DP0_C2M_N (tx_serial_data_n[1])
set_location_assignment PIN_J37   -to tx_serial_data[3]      ; ## A30  FMC_HPC_DP3_C2M_P (tx_serial_data_p[2])
set_location_assignment PIN_J36   -to "tx_serial_data[3](n)" ; ## A31  FMC_HPC_DP3_C2M_N (tx_serial_data_n[2])

set_instance_assignment -name XCVR_VCCR_VCCT_VOLTAGE 1_0V -to rx_serial_data
set_instance_assignment -name XCVR_VCCR_VCCT_VOLTAGE 1_0V -to tx_serial_data

set_instance_assignment -name IO_STANDARD LVDS -to ref_clk0
set_instance_assignment -name IO_STANDARD LVDS -to ref_clk1
set_instance_assignment -name IO_STANDARD "HIGH SPEED DIFFERENTIAL I/O" -to rx_serial_data
set_instance_assignment -name IO_STANDARD "HIGH SPEED DIFFERENTIAL I/O" -to tx_serial_data

# Merge RX and TX into single transceiver
for {set i 0} {$i < 4} {incr i} {
  set_instance_assignment -name XCVR_RECONFIG_GROUP xcvr_${i} -to rx_serial_data[${i}]
  set_instance_assignment -name XCVR_RECONFIG_GROUP xcvr_${i} -to tx_serial_data[${i}]
}

set_location_assignment PIN_M10   -to rx_sync               ; ## G09  FMC_HPC_LA03_P
set_location_assignment PIN_M11   -to rx_sync(n)            ; ## G10  FMC_HPC_LA03_N
set_location_assignment PIN_F2    -to rx_os_sync            ; ## G27  FMC_HPC_LA25_P (Sniffer)
set_location_assignment PIN_G2    -to rx_os_sync(n)         ; ## G28  FMC_HPC_LA25_N (Sniffer)
set_location_assignment PIN_T9    -to tx_sync               ; ## H07  FMC_HPC_LA02_P
set_location_assignment PIN_T10   -to tx_sync(n)            ; ## H08  FMC_HPC_LA02_N
set_location_assignment PIN_N11   -to sysref                ; ## G36  FMC_HPC_LA33_P
set_location_assignment PIN_P11   -to sysref(n)             ; ## G37  FMC_HPC_LA33_N

set_instance_assignment -name IO_STANDARD LVDS -to rx_sync
set_instance_assignment -name IO_STANDARD LVDS -to rx_os_sync
set_instance_assignment -name IO_STANDARD LVDS -to tx_sync
set_instance_assignment -name IO_STANDARD LVDS -to sysref
set_instance_assignment -name INPUT_TERMINATION DIFFERENTIAL -to tx_sync
set_instance_assignment -name INPUT_TERMINATION DIFFERENTIAL -to sysref

# fmc-i2c 
set_location_assignment PIN_J9   -to fmc_i2c_scl
set_location_assignment PIN_F4   -to fmc_i2c_sda

set_instance_assignment -name IO_STANDARD "1.8 V" -to fmc_i2c_scl
set_instance_assignment -name IO_STANDARD "1.8 V" -to fmc_i2c_sda

set_location_assignment PIN_H7    -to spi_csn_ad9528        ; ## D15  FMC_HPC_LA09_N
set_location_assignment PIN_G6    -to spi_csn_ad9371        ; ## D14  FMC_HPC_LA09_P
set_location_assignment PIN_L9    -to spi_clk               ; ## H13  FMC_HPC_LA07_P
set_location_assignment PIN_L10   -to spi_mosi              ; ## H14  FMC_HPC_LA07_N
set_location_assignment PIN_M9    -to spi_miso              ; ## G12  FMC_HPC_LA08_P

set_instance_assignment -name IO_STANDARD "1.8 V" -to spi_csn_ad9528
set_instance_assignment -name IO_STANDARD "1.8 V" -to spi_csn_ad9371
set_instance_assignment -name IO_STANDARD "1.8 V" -to spi_clk
set_instance_assignment -name IO_STANDARD "1.8 V" -to spi_mosi
set_instance_assignment -name IO_STANDARD "1.8 V" -to spi_miso

set_location_assignment PIN_R7    -to ad9528_reset_b        ; ## D26  FMC_HPC_LA26_P
set_location_assignment PIN_T8    -to ad9528_sysref_req     ; ## D27  FMC_HPC_LA26_N
set_location_assignment PIN_D5    -to ad9371_tx1_enable     ; ## D17  FMC_HPC_LA13_P
set_location_assignment PIN_B7    -to ad9371_tx2_enable     ; ## C18  FMC_HPC_LA14_P
set_location_assignment PIN_D6    -to ad9371_rx1_enable     ; ## D18  FMC_HPC_LA13_N
set_location_assignment PIN_C7    -to ad9371_rx2_enable     ; ## C19  FMC_HPC_LA14_N
set_location_assignment PIN_J10   -to ad9371_test           ; ## D11  FMC_HPC_LA05_P (DNI/NC)
set_location_assignment PIN_U9    -to ad9371_reset_b        ; ## H10  FMC_HPC_LA04_P
set_location_assignment PIN_U10   -to ad9371_gpint          ; ## H11  FMC_HPC_LA04_N

set_instance_assignment -name IO_STANDARD "1.8 V" -to ad9528_reset_b
set_instance_assignment -name IO_STANDARD "1.8 V" -to ad9528_sysref_req
set_instance_assignment -name IO_STANDARD "1.8 V" -to ad9371_tx1_enable
set_instance_assignment -name IO_STANDARD "1.8 V" -to ad9371_tx2_enable
set_instance_assignment -name IO_STANDARD "1.8 V" -to ad9371_rx1_enable
set_instance_assignment -name IO_STANDARD "1.8 V" -to ad9371_rx2_enable
set_instance_assignment -name IO_STANDARD "1.8 V" -to ad9371_test
set_instance_assignment -name IO_STANDARD "1.8 V" -to ad9371_reset_b
set_instance_assignment -name IO_STANDARD "1.8 V" -to ad9371_gpint

# single ended default

set_location_assignment PIN_E6    -to ad9371_gpio[0]        ; ## H19  FMC_HPC_LA15_P
set_location_assignment PIN_E7    -to ad9371_gpio[1]        ; ## H20  FMC_HPC_LA15_N
set_location_assignment PIN_E5    -to ad9371_gpio[2]        ; ## G18  FMC_HPC_LA16_P
set_location_assignment PIN_F5    -to ad9371_gpio[3]        ; ## G19  FMC_HPC_LA16_N
set_location_assignment PIN_C4    -to ad9371_gpio[4]        ; ## H25  FMC_HPC_LA21_P
set_location_assignment PIN_D4    -to ad9371_gpio[5]        ; ## H26  FMC_HPC_LA21_N
set_location_assignment PIN_K8    -to ad9371_gpio[6]        ; ## C22  FMC_HPC_LA18_CC_P
set_location_assignment PIN_L8    -to ad9371_gpio[7]        ; ## C23  FMC_HPC_LA18_CC_N
set_location_assignment PIN_U12   -to ad9371_gpio[8]        ; ## G25  FMC_HPC_LA22_N     (LVDS_1N)
set_location_assignment PIN_R8    -to ad9371_gpio[9]        ; ## H22  FMC_HPC_LA19_P     (LVDS_2P)
set_location_assignment PIN_P9    -to ad9371_gpio[10]       ; ## H23  FMC_HPC_LA19_N     (LVDS_2N)
set_location_assignment PIN_F7    -to ad9371_gpio[11]       ; ## G21  FMC_HPC_LA20_P     (LVDS_3P)
set_location_assignment PIN_G7    -to ad9371_gpio[12]       ; ## G22  FMC_HPC_LA20_N     (LVDS_3N)
set_location_assignment PIN_H1    -to ad9371_gpio[13]       ; ## G31  FMC_HPC_LA29_N     (LVDS_4N)
set_location_assignment PIN_G1    -to ad9371_gpio[14]       ; ## G30  FMC_HPC_LA29_P     (LVDS_4P)
set_location_assignment PIN_U11   -to ad9371_gpio[15]       ; ## G24  FMC_HPC_LA22_P     (LVDS_1P)
set_location_assignment PIN_B5    -to ad9371_gpio[16]       ; ## G16  FMC_HPC_LA12_N     (LVDS_5N)
set_location_assignment PIN_A5    -to ad9371_gpio[17]       ; ## G15  FMC_HPC_LA12_P     (LVDS_5P)
set_location_assignment PIN_K10   -to ad9371_gpio[18]       ; ## D12  FMC_HPC_LA05_N

set_instance_assignment -name IO_STANDARD "1.8 V" -to ad9371_gpio[0]
set_instance_assignment -name IO_STANDARD "1.8 V" -to ad9371_gpio[1]
set_instance_assignment -name IO_STANDARD "1.8 V" -to ad9371_gpio[2]
set_instance_assignment -name IO_STANDARD "1.8 V" -to ad9371_gpio[3]
set_instance_assignment -name IO_STANDARD "1.8 V" -to ad9371_gpio[4]
set_instance_assignment -name IO_STANDARD "1.8 V" -to ad9371_gpio[5]
set_instance_assignment -name IO_STANDARD "1.8 V" -to ad9371_gpio[6]
set_instance_assignment -name IO_STANDARD "1.8 V" -to ad9371_gpio[7]
set_instance_assignment -name IO_STANDARD "1.8 V" -to ad9371_gpio[8]
set_instance_assignment -name IO_STANDARD "1.8 V" -to ad9371_gpio[9]
set_instance_assignment -name IO_STANDARD "1.8 V" -to ad9371_gpio[10]
set_instance_assignment -name IO_STANDARD "1.8 V" -to ad9371_gpio[11]
set_instance_assignment -name IO_STANDARD "1.8 V" -to ad9371_gpio[12]
set_instance_assignment -name IO_STANDARD "1.8 V" -to ad9371_gpio[13]
set_instance_assignment -name IO_STANDARD "1.8 V" -to ad9371_gpio[14]
set_instance_assignment -name IO_STANDARD "1.8 V" -to ad9371_gpio[15]
set_instance_assignment -name IO_STANDARD "1.8 V" -to ad9371_gpio[16]
set_instance_assignment -name IO_STANDARD "1.8 V" -to ad9371_gpio[17]
set_instance_assignment -name IO_STANDARD "1.8 V" -to ad9371_gpio[18]

#fix for ddr clocking region issues
set_global_assignment -name AUTO_RESERVE_CLKUSR_FOR_CALIBRATION OFF
set_global_assignment -name OPTIMIZATION_MODE "SUPERIOR PERFORMANCE WITH MAXIMUM PLACEMENT EFFORT"

execute_flow -compile
