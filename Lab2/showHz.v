module showHz(
	CLK_50M,
	rst_n,
	SMA_CLKIN,
	LCD_RS,
	LCD_RW,
	LCD_EN,
	LCD_DATA,
	Enable
	);

input CLK_50M;
input rst_n;
input SMA_CLKIN;
input Enable;
output LCD_RS;
output LCD_RW;
output LCD_EN;
output [7:0]LCD_DATA;

reg LCD_RS_IN;
reg LCD_RW_IN;
reg LCD_EN_IN;
reg [7:0]LCD_DATA_IN;

reg [31:0]counter_sec;
reg flag_sec;
reg [31:0]counter_Hz;
reg [31:0]Hz;
wire flag_Hz_pos;
wire flag_Hz_neg;
wire flag_busy;
reg [31:0]counter_busy;
reg RS;
reg RW;
wire [7:0]Ins8;
wire [7:0]Ins7;
wire [7:0]Ins6;
wire [7:0]Ins5;
wire [7:0]Ins4;
wire [7:0]Ins3;
wire [7:0]Ins2;
wire [7:0]Ins1;
reg [7:0]Ins;
wire [3:0]Hz_8;
wire [3:0]Hz_7;
wire [3:0]Hz_6;
wire [3:0]Hz_5;
wire [3:0]Hz_4;
wire [3:0]Hz_3;
wire [3:0]Hz_2;
wire [3:0]Hz_1;
reg flag_enable;

reg [4:0]state=0;
reg [4:0]next_state=1;

parameter	LCD_H = 8'b01001000;
parameter	LCD_z = 8'b01111010;
parameter	LCD_E = 8'b01000101;
parameter	S0_adr=0;
parameter	S0=1;
//parameter	S1_adr=2;
parameter	S1=3;
//parameter	S2_adr=4;
parameter	S2=5;
//parameter	S3_adr=6;
parameter	S3=7;
//parameter	S4_adr=8;
parameter	S4=9;
//parameter	S5_adr=10;
parameter	S5=11;
//parameter	S6_adr=12;
parameter	S6=13;
//parameter	S7_adr=14;
parameter	S7=15;
//parameter	S8_adr=16;
parameter	S8=17;
//parameter	S9_adr=18;
parameter	S9=19;

always@(posedge CLK_50M or negedge rst_n)
begin
	if(!rst_n)
		flag_enable<=1'b0;
	else
		flag_enable<=1'b1;
end

always@(posedge CLK_50M or negedge rst_n)
begin
	if(!rst_n)
		counter_sec<=32'b1;
	else
	begin
		if(Enable)
			if(counter_sec==32'd50000000)
				counter_sec<=32'd0;
			else
				counter_sec<=counter_sec+1;			
	end
end

edge_detect edge_detect1(
   .clk(CLK_50M),
   .rst_n(rst_n),
   .data_in(SMA_CLKIN),
   .pos_edge(flag_Hz_pos),
   .neg_edge(flag_Hz_neg)	
	);

always@(posedge CLK_50M or negedge rst_n)
begin
	if(!rst_n)
		counter_Hz<=32'd0;
	else
	begin
	if(Enable)
		begin
			if(counter_sec==32'd0)
				counter_Hz<=32'd0;
			else
			begin
				if(flag_Hz_pos)
					counter_Hz<=counter_Hz+1;
				else
					counter_Hz<=counter_Hz;
			end
		end
	end
end

always@(posedge CLK_50M or negedge rst_n)
begin
	if(!rst_n)
		Hz<=32'd0;
	else
	begin
		if(Enable)
		begin	
			if(counter_sec==32'd50000000)
				Hz<=counter_Hz;
			else
				Hz<=Hz;
		end
	end
end

always@(*)
begin
	if(!rst_n)
		next_state<=S0;
	else
	begin
		if(Enable)
		begin
			case(state)
				S0:begin
						next_state<=S1;
						RS<=1;
						RW<=0;
						Ins<=Ins8;
					end
				S1:begin
						next_state<=S2;
						RS<=1;
						RW<=0;
						Ins<=Ins7;
					end
				S2:begin
						next_state<=S3;
						RS<=1;
						RW<=0;
						Ins<=Ins6;
					end
				S3:begin
						next_state<=S4;
						RS<=1;
						RW<=0;
						Ins<=Ins5;
					end
				S4:begin
						next_state<=S5;
						RS<=1;
						RW<=0;
						Ins<=Ins4;
					end
				S5:begin
						next_state<=S6;
						RS<=1;
						RW<=0;
						Ins<=Ins3;
					end
				S6:begin
						next_state<=S7;
						RS<=1;
						RW<=0;
						Ins<=Ins2;
					end
				S7:begin
						next_state<=S8;
						RS<=1;
						RW<=0;
						Ins<=Ins1;
					end
				S8:begin
						next_state<=S9;
						RS<=1;
						RW<=0;
						Ins<=8'b01001000;
					end
				S9:begin
						next_state<=S0_adr;
						RS<=1;
						RW<=0;
						Ins<=8'b01111010;
					end
				S0_adr:begin
							next_state<=S0;
							RS<=0;
							RW<=0;
							Ins<=8'b10000000;
						end
				/*S1_adr:begin
							next_state<=S1;
							RS<=0;
							RW<=0;
							Ins<=8'b10000001;
						end
				S2_adr:begin
							next_state<=S2;
							RS<=0;
							RW<=0;
							Ins<=8'b10000010;
						end
				S3_adr:begin
							next_state<=S3;
							RS<=0;
							RW<=0;
							Ins<=8'b10000011;
						end
				S4_adr:begin
							next_state<=S4;
							RS<=0;
							RW<=0;
							Ins<=8'b10000100;
						end
				S5_adr:begin
							next_state<=S5;
							RS<=0;
							RW<=0;
							Ins<=8'b10000101;
						end
				S6_adr:begin
							next_state<=S6;
							RS<=0;
							RW<=0;
							Ins<=8'b10000110;
						end
				S7_adr:begin
							next_state<=S7;
							RS<=0;
							RW<=0;
							Ins<=8'b10000111;
						end
				S8_adr:begin
							next_state<=S8;
							RS<=0;
							RW<=0;
							Ins<=8'b10001000;
						end
				S9_adr:begin
							next_state<=S9;
							RS<=0;
							RW<=0;
							Ins<=8'b10001001;
						end*/
					
				default:begin	
							next_state<=S0_adr;
							RS<=1;
							RW<=0;
							Ins<=8'b01111010;					
							end	
			endcase
		end
	end
end

assign Hz_8=Hz/10000000%10;
assign Hz_7=Hz/1000000%10;
assign Hz_6=Hz/100000%10;
assign Hz_5=Hz/10000%10;
assign Hz_4=Hz/1000%10;
assign Hz_3=Hz/100%10;
assign Hz_2=Hz/10%10;
assign Hz_1=Hz%10;

select slect_8(
	.CLK_50M(CLK_50M),
	.rst_n(rst_n),
	.select_in(Hz_8),
	.select_out(Ins8)	
);
select slect_7(
	.CLK_50M(CLK_50M),
	.rst_n(rst_n),
	.select_in(Hz_7),
	.select_out(Ins7)	
);
select slect_6(
	.CLK_50M(CLK_50M),
	.rst_n(rst_n),
	.select_in(Hz_6),
	.select_out(Ins6)	
);
select slect_5(
	.CLK_50M(CLK_50M),
	.rst_n(rst_n),
	.select_in(Hz_5),
	.select_out(Ins5)	
);
select slect_4(
	.CLK_50M(CLK_50M),
	.rst_n(rst_n),
	.select_in(Hz_4),
	.select_out(Ins4)	
);
select slect_3(
	.CLK_50M(CLK_50M),
	.rst_n(rst_n),
	.select_in(Hz_3),
	.select_out(Ins3)	
);
select slect_2(
	.CLK_50M(CLK_50M),
	.rst_n(rst_n),
	.select_in(Hz_2),
	.select_out(Ins2)	
);
select slect_1(
	.CLK_50M(CLK_50M),
	.rst_n(rst_n),
	.select_in(Hz_1),
	.select_out(Ins1)	
);


always@(posedge CLK_50M or negedge rst_n)
begin
	if(!rst_n)
		state<=S0_adr;
	else
	begin
		if(Enable)
		begin
			if(counter_busy==32'd50200)
			begin
				state<=next_state;
			end
		end
	end		
end

WR_Oper	WR_Oper2(
	.enable(Enable),
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
	
always@(posedge CLK_50M or negedge rst_n)
begin
	if(!rst_n)
		counter_busy<=32'd0;
	else
	begin
		if(Enable)
		begin	
			if(!flag_busy)
				counter_busy<=counter_busy+1;
			else
				counter_busy<=31'd0;
		end
	end	
end

always@(posedge CLK_50M or negedge rst_n)
begin
	if(!rst_n)
	begin
		LCD_RS_IN<=1'b0;
		LCD_RW_IN<=1'b0;
		LCD_DATA_IN<=8'b0;
	end
	else
	begin
		if(Enable)
		begin	
			if(!flag_busy)
			begin
				if(counter_busy==32'd50000)
				begin
					LCD_RS_IN<=RS;
					LCD_RW_IN<=RW;
					LCD_DATA_IN<=Ins;
				end
				else
				begin
					LCD_RS_IN<=LCD_RS_IN;
					LCD_RW_IN<=LCD_RW_IN;
					LCD_DATA_IN<=LCD_DATA_IN;				
				end
			end
			else
			begin
				LCD_RS_IN<=LCD_RS_IN;
				LCD_RW_IN<=LCD_RW_IN;
				LCD_DATA_IN<=LCD_DATA_IN;
			end
		end
	end	
end

endmodule
