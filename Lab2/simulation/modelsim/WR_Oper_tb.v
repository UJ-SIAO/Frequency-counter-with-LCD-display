`timescale 1ns/1ns
module WR_Oper_tb();

reg	rst_n;
reg	CLK_50M;
reg	LCD_RS_IN;
reg	LCD_RW_IN;
reg	[7:0]LCD_DATA_IN;
reg	enable;
wire	LCD_RS;
wire	LCD_RW;
wire	[7:0]LCD_DATA;
wire	flag_busy;
wire	LCD_EN;
WR_Oper	uut(
	.enable(enable),
	.rst_n(rst_n),
	.CLK_50M(CLK_50M),
	.LCD_RS_IN(LCD_RS_IN),
	.LCD_RW_IN(LCD_RW_IN),
	.LCD_DATA_IN(LCD_DATA_IN),
	.LCD_RS(LCD_RS),
	.LCD_RW(LCD_RW),
	.LCD_EN(LCD_EN),
	.LCD_DATA(LCD_DATA),
	.flag_busy(flag_busy)
);

always	
	#10 CLK_50M =~CLK_50M;
initial
begin
	enable=1;
	CLK_50M=0;
	rst_n=1;
	LCD_RS_IN=0;
	LCD_RW_IN=0;
	LCD_DATA_IN=8'd0;
	#10
	rst_n=0;
	#10
	rst_n=1;
	#100
	LCD_RS_IN=1;
	#1
	LCD_RW_IN=1;
	#1
	LCD_DATA_IN=8'd8;
	$stop;
	
end

endmodule
