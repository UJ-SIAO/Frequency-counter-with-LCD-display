`timescale 1ns/1ns
module init_tb();
reg CLK_50M;
reg rst_n;
reg Enable;
wire LCD_EN;
wire [7:0]LCD_DATA;
wire LCD_RW;
wire LCD_RS;
wire LCD_ON;
wire flag_complete;
init	uut(
	.CLK_50M(CLK_50M),
	.LCD_DATA(LCD_DATA),
	.LCD_EN(LCD_EN),
	.LCD_RW(LCD_RW),
	.LCD_RS(LCD_RS),
	.LCD_ON(LCD_ON),
	.rst_n(rst_n),
	.Enable(Enable),
	.flag_complete(flag_complete)
);

always
	#10 CLK_50M=~CLK_50M;

initial
begin
	CLK_50M=0;
	rst_n=1;
	Enable=0;
	#10
	rst_n=0;
	#10
	rst_n=1;
	#1000
	Enable=1;
	$stop;
end

endmodule	