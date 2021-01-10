`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/21 00:45:19
// Design Name: 
// Module Name: Bpmusic
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
//�ߵ������궨��
        `define        L1  262 //����1
        `define        L2  294 //����2
        `define        L3  330 //����3
        `define        L4  349 //����4
        `define        L5  392 //����5
        `define        L6  440 //����6
        `define        L7  494 //����7
         
        `define        C1  523 //����1 
        `define        C2  587 //����2 
        `define        C3  659 //����3 
        `define        C4  699 //����4 
        `define        C5  784 //����5 
        `define        C6  880 //����6 
        `define        C7  988 //����7 
         
        `define        H1  1046 //����1 
        `define        H2  1175 //����2 
        `define        H3  1319 //����3 
        `define        H4  1397 //����4 
        `define        H5  1568 //����5 
        `define        H6  1760 //����6 
        `define        H7  1976 //����7
module Bpmusic(
	input			clk,
	input			rst_n,
	input   payperiod,
	output reg	beep
);
//250ms��תһ��,��Ҫ����12500000
localparam state_top=24'd12500000-1;
reg [47:0] state_cnt;

always@(posedge clk or negedge rst_n)
	if(!rst_n)
		state_cnt<=0;
	else if(state_cnt<state_top)
		state_cnt<=state_cnt+1;
	else
		state_cnt<=0;
//״̬��ת��־�ź�
wire state_cnt_done=(state_cnt==state_top)?1:0;
		
reg [5:0] state;
reg [41:0] cnt_top;
always@(posedge clk or negedge rst_n)
	if(!rst_n)
		state<=0;
	else if(state_cnt_done)begin
            if(state<63)
                state<=state+1;
            else
                state<=0;
	end
	else
		state<=state;
	
	
	
always@(*)
	begin
		case(state)
			0	:cnt_top<=`C1;	
			1	:cnt_top<=`C2;
			2	:cnt_top<=`C3;
			3	:cnt_top<=`C4;
			4	:cnt_top<=`C5;
			5	:cnt_top<=`C5;
			6	:cnt_top<=`C5;
			7	:cnt_top<=`C3;
			8	:cnt_top<=`C4;
			9	:cnt_top<=`C4;
			10	:cnt_top<=`C4;
			11	:cnt_top<=`C2;
			12	:cnt_top<=`C1;
			13	:cnt_top<=`C3;
			14	:cnt_top<=`C5;
			15	:cnt_top<=0;//��
			16	:cnt_top<=`C1;
			17	:cnt_top<=`C2;
			18	:cnt_top<=`C3;
			19	:cnt_top<=`C4;
			20	:cnt_top<=`C5;
			21	:cnt_top<=`C5;
			22	:cnt_top<=`C5;
			23	:cnt_top<=`C3;
			24	:cnt_top<=`C4;
			25	:cnt_top<=`C4;
			26	:cnt_top<=`C4;
			27	:cnt_top<=`C2;
			28	:cnt_top<=`C1;
			29	:cnt_top<=`C3;
			30	:cnt_top<=`C1;
			31	:cnt_top<=0;//��
            32  :cnt_top<=`C6;
            33    :cnt_top<=`C6;
            34    :cnt_top<=`C6;
            35    :cnt_top<=`C4;
            36    :cnt_top<=`C5;
            37    :cnt_top<=`C5;
            38    :cnt_top<=`C5;
            39    :cnt_top<=`C3;
            40    :cnt_top<=`C4;
            41    :cnt_top<=`C4;
            42    :cnt_top<=`C4;
            43    :cnt_top<=`C2;
            44    :cnt_top<=`C1;
            45    :cnt_top<=`C3;
            46    :cnt_top<=`C5;
            47    :cnt_top<=0;//��
            48    :cnt_top<=`C6;
            49    :cnt_top<=`C6;
            50    :cnt_top<=`C6;
            51    :cnt_top<=`C4;
            52    :cnt_top<=`C5;
            53    :cnt_top<=`C5;
            54    :cnt_top<=`C5;
            55    :cnt_top<=`C3;
            56    :cnt_top<=`C4;
            57    :cnt_top<=`C4;
            58    :cnt_top<=`C4;
            59    :cnt_top<=`C2;
            60    :cnt_top<=`C1;
            61    :cnt_top<=`C3;
            62    :cnt_top<=`C1;
            63    :cnt_top<=0;//��
			default:;
		endcase
	end
reg [53:0] cnt;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		cnt=0;
	else begin 
	if(cnt<50_000_000/cnt_top-1)
		cnt=cnt+1;
	else 
		cnt=0;
		
    end
end

always@(posedge clk or negedge rst_n)
	if(!rst_n || payperiod)
	   begin
		beep=0;
		end
	else
		beep=(cnt<cnt_top/2)?1:0;
endmodule