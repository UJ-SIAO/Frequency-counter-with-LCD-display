`timescale 1ns/1ns
module showHz_tb();

reg CLK_50M;
reg rst_n;
reg SMA_CLKIN;
reg Enable;
wire LCD_EN;
wire [7:0]LCD_DATA;
wire LCD_RW;
wire LCD_RS;

showHz	uut(
	.CLK_50M(CLK_50M),
	.rst_n(rst_n),
	.SMA_CLKIN(SMA_CLKIN),
	.LCD_RS(LCD_RS),
	.LCD_RW(LCD_RW),
	.LCD_EN(LCD_EN),
	.LCD_DATA(LCD_DATA),
	.Enable(Enable)
);

always 	
	#10 CLK_50M=~CLK_50M;
always
	#20 SMA_CLKIN=~SMA_CLKIN;

initial
begin
	CLK_50M=0;
	SMA_CLKIN=0;
	rst_n=1;
	Enable=0;
	#10
	rst_n=0;
	#10
	rst_n=1;
	#500
	Enable=1;
	$stop;
end



endmodule