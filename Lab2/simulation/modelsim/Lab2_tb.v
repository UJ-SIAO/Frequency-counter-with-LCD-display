`timescale 1ns/1ns
module Lab2_tb();

reg CLK_50M;
reg rst_n;
reg SMA_CLKIN;
wire LCD_EN;
wire [7:0]LCD_DATA;
wire LCD_RW;
wire LCD_RS;
wire LCD_ON;
wire LCD_BLON;
wire flag_complete1;
Lab2 uut(
	.CLK_50M(CLK_50M),
	.SMA_CLKIN(SMA_CLKIN),
	.rst_n(rst_n),
	.LCD_RS(LCD_RS),
	.LCD_RW(LCD_RW),
	.LCD_EN(LCD_EN),
	.LCD_DATA(LCD_DATA),
	.LCD_ON(LCD_ON),
	.LCD_BLON(LCD_BLON),
	.flag_complete1(flag_complete1)
);

always
	#10 CLK_50M=~CLK_50M;
always
	#25 SMA_CLKIN=~SMA_CLKIN;

initial
begin
	CLK_50M=0;
	SMA_CLKIN=0;
	rst_n=1;
	#10
	rst_n=0;
	#10
	rst_n=1;
	#500
	$stop;

end

endmodule