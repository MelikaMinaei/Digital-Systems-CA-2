`timescale 1ns/1ns
module NAND_gate_with_transistors(input a, b, output w);
	supply1 VDD;
	supply0 GND;
	wire i;
	pmos#(5, 6, 7)T1(w, VDD, a);
	pmos#(5, 6, 7)T2(w, VDD, b);
	nmos#(3, 4, 5)T3(w, i, a);
	nmos#(3, 4, 5)T4(i, GND, b);
endmodule
module TB_NAND_T();
	logic a, b;
	wire w;
	
	NAND_gate_with_transistors Q1(a, b, w);
	initial begin
	a = 0;
	b = 0;
	#100; a = 0; b = 1; #50;
	a = 0; b = 0;
	#100; a = 1; b = 0; #50;
	a = 0; b = 0;
	#100; a = 1; b = 1; #50;
	
	a = 0; b = 1;
	#100; a = 0; b = 1; #50;
	a = 0; b = 1;
	#100; a = 1; b = 0; #50;
	a = 0; b = 1;
	#100; a = 0; b = 0; #50;
	
	a = 1; b = 0;
	#100; a = 0; b = 1; #50;
	a = 1; b = 0;
	#100; a = 0; b = 0; #50;
	a = 1; b = 0;
	#100; a = 1; b = 1; #50;
	
	a = 1; b = 1;
	#100; a = 0; b = 1; #50;
	a = 1; b = 1;
	#100; a = 1; b = 0; #50;
	a = 1; b = 1;
	#100; a = 0; b = 0; #50;
	end
endmodule
module Tristatebuffer_with_transistors(input a, en, output w);
	supply1 VDD;
	supply0 GND;
	wire w1, w2, w3;
	pmos#(5, 6, 7)T1(w1, VDD, a);
	pmos#(5, 6, 7)T2(w, w1, w3);
	nmos#(3, 4, 5)T3(w, w2, en);
	nmos#(3, 4, 5)T4(w2, GND, a);
	nmos#(3, 4, 5)T5(w3, VDD, en);
	pmos#(5, 6, 7)T6(w3, GND, en);
endmodule
module TB_BUFF_T();
	logic a, en;
	wire w;
	
	Tristatebuffer_with_transistors Q2(a, en, w);
	initial begin
	a = 0;
	en = 0;
	#100; a = 0; en = 1; #50;
	a = 0; en = 0;
	#100; a = 1; en = 0; #50;
	a = 0; en = 0;
	#100; a = 1; en = 1; #50;
	
	a = 0; en = 1;
	#100; a = 0; en = 1; #50;
	a = 0; en = 1;
	#100; a = 1; en = 0; #50;
	a = 0; en = 1;
	#100; a = 0; en = 0; #50;
	
	a = 1; en = 0;
	#100; a = 0; en = 1; #50;
	a = 1; en = 0;
	#100; a = 0; en = 0; #50;
	a = 1; en = 0;
	#100; a = 1; en = 1; #50;
	
	a = 1; en = 1;
	#100; a = 0; en = 1; #50;
	a = 1; en = 1;
	#100; a = 1; en = 0; #50;
	a = 1; en = 1;
	#100; a = 0; en = 0; #50;

	a = 1'bz; en = 0;
	#100; a = 1; en = 0; #50;
	a = 1'bz; en = 1;
	#100; a = 1; en = 1; #50;
	a = 1'bz; en = 1;
	#100; a = 0; en = 1; #50;
	$stop;
	end
endmodule
module MUX_with_NAND(input a, b, c, d, s1, s0, output w);
	wire w1, w2, w3, w4, w5, w6, w7, w8, w9, w10;
	NAND_gate_with_transistors G1(s0, 1'b1, w1);
	NAND_gate_with_transistors G2(a, w1, w2);
	NAND_gate_with_transistors G3(b, s0, w3);
	NAND_gate_with_transistors G4(c, w1, w4);
	NAND_gate_with_transistors G5(d, s0, w5);
	NAND_gate_with_transistors G6(w2, w3, w6);
	NAND_gate_with_transistors G7(w4, w5, w7);
	NAND_gate_with_transistors G8(w6, w9, w8);
	NAND_gate_with_transistors G9(s1, 1'b1, w9);
	NAND_gate_with_transistors G10(s1, w7, w10);
	NAND_gate_with_transistors G11(w8, w10, w);
endmodule
module TB_MUX4to1_NAND();
	logic a, b, c, d, s1, s0;
	wire w;
	MUX_with_NAND Q3(a, b, c, d, s1, s0, w);
	initial begin
	s0 = 0; s1 = 0;
	#100; a = 0; b = 0; c = 0; d = 0; #50;
	#100; a = 0; b = 0; c = 0; d = 1; #50;
	#100; a = 0; b = 0; c = 1; d = 0; #50;
	#100; a = 0; b = 0; c = 1; d = 1; #50;
	#100; a = 0; b = 1; c = 0; d = 0; #50;
	#100; a = 0; b = 1; c = 0; d = 1; #50;
	#100; a = 0; b = 1; c = 1; d = 0; #50;
	#100; a = 0; b = 1; c = 1; d = 1; #50;
	#100; a = 1; b = 0; c = 0; d = 0; #50;
	#100; a = 1; b = 0; c = 0; d = 1; #50;
	#100; a = 1; b = 0; c = 1; d = 0; #50;
	#100; a = 1; b = 0; c = 1; d = 1; #50;
	#100; a = 1; b = 1; c = 0; d = 0; #50;
	#100; a = 1; b = 1; c = 0; d = 1; #50;
	#100; a = 1; b = 1; c = 1; d = 0; #50;
	#100; a = 1; b = 1; c = 1; d = 1; #50;

	s0 = 0; s1 = 1;
	#100; a = 0; b = 0; c = 0; d = 0; #50;
	#100; a = 0; b = 0; c = 0; d = 1; #50;
	#100; a = 0; b = 0; c = 1; d = 0; #50;
	#100; a = 0; b = 0; c = 1; d = 1; #50;
	#100; a = 0; b = 1; c = 0; d = 0; #50;
	#100; a = 0; b = 1; c = 0; d = 1; #50;
	#100; a = 0; b = 1; c = 1; d = 0; #50;
	#100; a = 0; b = 1; c = 1; d = 1; #50;
	#100; a = 1; b = 0; c = 0; d = 0; #50;
	#100; a = 1; b = 0; c = 0; d = 1; #50;
	#100; a = 1; b = 0; c = 1; d = 0; #50;
	#100; a = 1; b = 0; c = 1; d = 1; #50;
	#100; a = 1; b = 1; c = 0; d = 0; #50;
	#100; a = 1; b = 1; c = 0; d = 1; #50;
	#100; a = 1; b = 1; c = 1; d = 0; #50;
	#100; a = 1; b = 1; c = 1; d = 1; #50;

	s0 = 1; s1 = 0;
	#100; a = 0; b = 0; c = 0; d = 0; #50;
	#100; a = 0; b = 0; c = 0; d = 1; #50;
	#100; a = 0; b = 0; c = 1; d = 0; #50;
	#100; a = 0; b = 0; c = 1; d = 1; #50;
	#100; a = 0; b = 1; c = 0; d = 0; #50;
	#100; a = 0; b = 1; c = 0; d = 1; #50;
	#100; a = 0; b = 1; c = 1; d = 0; #50;
	#100; a = 0; b = 1; c = 1; d = 1; #50;
	#100; a = 1; b = 0; c = 0; d = 0; #50;
	#100; a = 1; b = 0; c = 0; d = 1; #50;
	#100; a = 1; b = 0; c = 1; d = 0; #50;
	#100; a = 1; b = 0; c = 1; d = 1; #50;
	#100; a = 1; b = 1; c = 0; d = 0; #50;
	#100; a = 1; b = 1; c = 0; d = 1; #50;
	#100; a = 1; b = 1; c = 1; d = 0; #50;
	#100; a = 1; b = 1; c = 1; d = 1; #50;

	s0 = 1; s1 = 1;
	#100; a = 0; b = 0; c = 0; d = 0; #50;
	#100; a = 0; b = 0; c = 0; d = 1; #50;
	#100; a = 0; b = 0; c = 1; d = 0; #50;
	#100; a = 0; b = 0; c = 1; d = 1; #50;
	#100; a = 0; b = 1; c = 0; d = 0; #50;
	#100; a = 0; b = 1; c = 0; d = 1; #50;
	#100; a = 0; b = 1; c = 1; d = 0; #50;
	#100; a = 0; b = 1; c = 1; d = 1; #50;
	#100; a = 1; b = 0; c = 0; d = 0; #50;
	#100; a = 1; b = 0; c = 0; d = 1; #50;
	#100; a = 1; b = 0; c = 1; d = 0; #50;
	#100; a = 1; b = 0; c = 1; d = 1; #50;
	#100; a = 1; b = 1; c = 0; d = 0; #50;
	#100; a = 1; b = 1; c = 0; d = 1; #50;
	#100; a = 1; b = 1; c = 1; d = 0; #50;
	#100; a = 1; b = 1; c = 1; d = 1; #50;
	end
endmodule
module MUX_with_Tristate(input a, b, c, d, s1, s0, output w);
	wire w1, w2, w4, w7;
	NAND_gate_with_transistors G1(s0, s0, w1);
	NAND_gate_with_transistors G7(s1, s1, w7);
	Tristatebuffer_with_transistors G2(a, w1, w2);
	Tristatebuffer_with_transistors G3(b, s0, w2);
	Tristatebuffer_with_transistors G4(c, w1, w4);
	Tristatebuffer_with_transistors G5(d, s0, w4);
	Tristatebuffer_with_transistors G6(w2, w7, w);
	Tristatebuffer_with_transistors G8(w4, s1, w);
endmodule
module TB_MUX4to1_Tristate();
	logic a, b, c, d, s1, s0;
	wire w;
	MUX_with_Tristate Q4(a, b, c, d, s1, s0, w);
	initial begin
	s0 = 0; s1 = 0;
	#100; a = 0; b = 0; c = 0; d = 0; #50;
	#100; a = 0; b = 0; c = 0; d = 1; #50;
	#100; a = 0; b = 0; c = 1; d = 0; #50;
	#100; a = 0; b = 0; c = 1; d = 1; #50;
	#100; a = 0; b = 1; c = 0; d = 0; #50;
	#100; a = 0; b = 1; c = 0; d = 1; #50;
	#100; a = 0; b = 1; c = 1; d = 0; #50;
	#100; a = 0; b = 1; c = 1; d = 1; #50;
	#100; a = 1; b = 0; c = 0; d = 0; #50;
	#100; a = 1; b = 0; c = 0; d = 1; #50;
	#100; a = 1; b = 0; c = 1; d = 0; #50;
	#100; a = 1; b = 0; c = 1; d = 1; #50;
	#100; a = 1; b = 1; c = 0; d = 0; #50;
	#100; a = 1; b = 1; c = 0; d = 1; #50;
	#100; a = 1; b = 1; c = 1; d = 0; #50;
	#100; a = 1; b = 1; c = 1; d = 1; #50;

	s0 = 0; s1 = 1;
	#100; a = 0; b = 0; c = 0; d = 0; #50;
	#100; a = 0; b = 0; c = 0; d = 1; #50;
	#100; a = 0; b = 0; c = 1; d = 0; #50;
	#100; a = 0; b = 0; c = 1; d = 1; #50;
	#100; a = 0; b = 1; c = 0; d = 0; #50;
	#100; a = 0; b = 1; c = 0; d = 1; #50;
	#100; a = 0; b = 1; c = 1; d = 0; #50;
	#100; a = 0; b = 1; c = 1; d = 1; #50;
	#100; a = 1; b = 0; c = 0; d = 0; #50;
	#100; a = 1; b = 0; c = 0; d = 1; #50;
	#100; a = 1; b = 0; c = 1; d = 0; #50;
	#100; a = 1; b = 0; c = 1; d = 1; #50;
	#100; a = 1; b = 1; c = 0; d = 0; #50;
	#100; a = 1; b = 1; c = 0; d = 1; #50;
	#100; a = 1; b = 1; c = 1; d = 0; #50;
	#100; a = 1; b = 1; c = 1; d = 1; #50;

	s0 = 1; s1 = 0;
	#100; a = 0; b = 0; c = 0; d = 0; #50;
	#100; a = 0; b = 0; c = 0; d = 1; #50;
	#100; a = 0; b = 0; c = 1; d = 0; #50;
	#100; a = 0; b = 0; c = 1; d = 1; #50;
	#100; a = 0; b = 1; c = 0; d = 0; #50;
	#100; a = 0; b = 1; c = 0; d = 1; #50;
	#100; a = 0; b = 1; c = 1; d = 0; #50;
	#100; a = 0; b = 1; c = 1; d = 1; #50;
	#100; a = 1; b = 0; c = 0; d = 0; #50;
	#100; a = 1; b = 0; c = 0; d = 1; #50;
	#100; a = 1; b = 0; c = 1; d = 0; #50;
	#100; a = 1; b = 0; c = 1; d = 1; #50;
	#100; a = 1; b = 1; c = 0; d = 0; #50;
	#100; a = 1; b = 1; c = 0; d = 1; #50;
	#100; a = 1; b = 1; c = 1; d = 0; #50;
	#100; a = 1; b = 1; c = 1; d = 1; #50;

	s0 = 1; s1 = 1;
	#100; a = 0; b = 0; c = 0; d = 0; #50;
	#100; a = 0; b = 0; c = 0; d = 1; #50;
	#100; a = 0; b = 0; c = 1; d = 0; #50;
	#100; a = 0; b = 0; c = 1; d = 1; #50;
	#100; a = 0; b = 1; c = 0; d = 0; #50;
	#100; a = 0; b = 1; c = 0; d = 1; #50;
	#100; a = 0; b = 1; c = 1; d = 0; #50;
	#100; a = 0; b = 1; c = 1; d = 1; #50;
	#100; a = 1; b = 0; c = 0; d = 0; #50;
	#100; a = 1; b = 0; c = 0; d = 1; #50;
	#100; a = 1; b = 0; c = 1; d = 0; #50;
	#100; a = 1; b = 0; c = 1; d = 1; #50;
	#100; a = 1; b = 1; c = 0; d = 0; #50;
	#100; a = 1; b = 1; c = 0; d = 1; #50;
	#100; a = 1; b = 1; c = 1; d = 0; #50;
	#100; a = 1; b = 1; c = 1; d = 1; #50;
	end
endmodule
module comparing_MUXes();
	TB_MUX4to1_NAND first();
	TB_MUX4to1_Tristate second();
endmodule

