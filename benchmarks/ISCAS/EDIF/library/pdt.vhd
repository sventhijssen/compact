-- pdt.vhd
--
--	Package contenete i componenti elementari per compilare
--	i file iscas
--


package	gate_lib is
	component And_gate 
		port( 
			I1, I2 : in bit;
			O : out bit
		);
	end component;

	component And3_gate
		port( 
			I1, I2, I3 : in bit;
			O : out bit
		);
	end component;
		
	component And4_gate
		port( 
			I1, I2, I3, I4 : in bit;
			O : out bit
		);
	end component;

	component And5_gate
		port( 
			I1, I2, I3, I4, I5 : in bit;
			O : out bit
		);
	end component;

	component Nand_gate
		port( 
			I1, I2 : in bit;
			O : out bit
		);
	end component;

	component Nand3_gate
		port( 
			I1, I2, I3 : in bit;
			O : out bit
		);
	end component;
		
	component Nand4_gate
		port( 
			I1, I2, I3, I4 : in bit;
			O : out bit
		);
	end component;

	component Nand5_gate
		port( 
			I1, I2, I3, I4, I5 : in bit;
			O : out bit
		);
	end component;

	component Or_gate
		port( 
			I1, I2 : in bit;
			O : out bit
		);
	end component;

	component Or3_gate
		port( 
			I1, I2, I3 : in bit;
			O : out bit
		);
	end component;
		
	component Or4_gate
		port( 
			I1, I2, I3, I4 : in bit;
			O : out bit
		);
	end component;

	component Or5_gate
		port( 
			I1, I2, I3, I4, I5 : in bit;
			O : out bit
		);
	end component;

	component Nor_gate
		port( 
			I1, I2 : in bit;
			O : out bit
		);
	end component;

	component Nor3_gate
		port( 
			I1, I2, I3 : in bit;
			O : out bit
		);
	end component;
		
	component Nor4_gate
		port( 
			I1, I2, I3, I4 : in bit;
			O : out bit
		);
	end component;

	component Nor5_gate
		port( 
			I1, I2, I3, I4, I5 : in bit;
			O : out bit
		);
	end component;

	component Xor_gate
		port( 
			I1, I2 : in bit;
			O : out bit
		);
	end component;

	component Xor3_gate
		port( 
			I1, I2, I3 : in bit;
			O : out bit
		);
	end component;
		
	component Xor4_gate
		port( 
			I1, I2, I3, I4 : in bit;
			O : out bit
		);
	end component;

	component Xor5_gate
		port( 
			I1, I2, I3, I4, I5 : in bit;
			O : out bit
		);
	end component;

	component Xnor_gate
		port( 
			I1, I2 : in bit;
			O : out bit
		);
	end component;

	component Xnor3_gate
		port( 
			I1, I2, I3 : in bit;
			O : out bit
		);
	end component;
		
	component Xnor4_gate
		port( 
			I1, I2, I3, I4 : in bit;
			O : out bit
		);
	end component;

	component Xnor5_gate
		port( 
			I1, I2, I3, I4, I5 : in bit;
			O : out bit
		);
	end component;

	component Inv_gate
		port(
			I1 : in bit;
			O : out bit
		);
	end component;

	component Buf_gate
		port(
			I1 : in bit;
			O : out bit
		);
	end component;

	component Flip_Flop_D
		port(
			CK : in bit;
			D : out bit;
			Q : out bit
		);
	end component;

	component Flip_Flop_D_reset
		port(
			CK, D, RESET : in bit;
			Q : out bit
		);
	end component;

	component Flip_Flop_D_preset
		port(
			CK, D, PRESET : in bit;
			Q : out bit
		);
	end component;

	component Flip_Flop_D_reset_preset
		port(
			CK, D, RESET, PRESET : in bit;
			Q : out bit
		);
	end component;
end gate_lib;

entity And_gate is
	port(
		I1, I2 : in bit;
		O : out bit
	);
end And_gate;

architecture behav of And_gate is
begin
P1: process( I1, I2 )
begin
	O <= I1 and I2;
end process;
end behav;

entity And3_gate is
	port(
		I1, I2, I3 : in bit;
		O : out bit
	);
end And3_gate;

architecture behav of And3_gate is
begin
P1: process( I1, I2, I3 )
begin
	O <= I1 and (I2 and I3);
end process;
end behav;

entity And4_gate is
	port(
		I1, I2, I3, I4 : in bit;
		O : out bit
	);
end And4_gate;

architecture behav of And4_gate is
begin
P1: process( I1, I2, I3, I4 )
begin
	O <= I1 and (I2 and (I3 and I4));
end process;
end behav;

entity And5_gate is
	port(
		I1, I2, I3, I4, I5 : in bit;
		O : out bit
	);
end And5_gate;

architecture behav of And5_gate is
begin
P1: process( I1, I2, I3, I4, I5 )
begin
	O <= I1 and I2 and I3 and I4 and I5;
end process;
end behav;

entity Nand_gate is
	port(
		I1, I2 : in bit;
		O : out bit
	);
end Nand_gate;

architecture behav of Nand_gate is
begin
P1: process( I1, I2 )
begin
	O <= I1 nand I2;
end process;
end behav;

entity Nand3_gate is
	port(
		I1, I2, I3 : in bit;
		O : out bit
	);
end Nand3_gate;

architecture behav of Nand3_gate is
begin
P1: process( I1, I2, I3 )
begin
	O <= Not(I1 and (I2 and I3));
end process;
end behav;

entity Nand4_gate is
	port(
		I1, I2, I3, I4 : in bit;
		O : out bit
	);
end Nand4_gate;

architecture behav of Nand4_gate is
begin
P1: process( I1, I2, I3, I4 )
begin
	O <= Not(I1 and (I2 and (I3 and I4)));
end process;
end behav;

entity Nand5_gate is
	port(
		I1, I2, I3, I4, I5 : in bit;
		O : out bit
	);
end Nand5_gate;

architecture behav of Nand5_gate is
begin
P1: process( I1, I2, I3, I4, I5 )
begin
	O <= Not (I1 and (I2 and (I3 and (I4 and I5))));
end process;
end behav;

entity Or_gate is
	port(
		I1, I2 : in bit;
		O : out bit
	);
end Or_gate;

architecture behav of Or_gate is
begin
P1: process( I1, I2 )
begin
	O <= I1 or I2;
end process;
end behav;

entity Or3_gate is
	port(
		I1, I2, I3 : in bit;
		O : out bit
	);
end Or3_gate;

architecture behav of Or3_gate is
begin
P1: process( I1, I2, I3 )
begin
	O <= I1 or I2 or I3;
end process;
end behav;

entity Or4_gate is
	port(
		I1, I2, I3, I4 : in bit;
		O : out bit
	);
end Or4_gate;

architecture behav of Or4_gate is
begin
P1: process( I1, I2, I3, I4 )
begin
	O <= I1 or I2 or I3 or I4;
end process;
end behav;

entity Or5_gate is
	port(
		I1, I2, I3, I4, I5 : in bit;
		O : out bit
	);
end Or5_gate;

architecture behav of Or5_gate is
begin
P1: process( I1, I2, I3, I4, I5 )
begin
	O <= I1 or I2 or I3 or I4 or I5;
end process;
end behav;

entity Nor_gate is
	port(
		I1, I2 : in bit;
		O : out bit
	);
end Nor_gate;

architecture behav of Nor_gate is
begin
P1: process( I1, I2 )
begin
	O <= I1 nor I2;
end process;
end behav;

entity Nor3_gate is
	port(
		I1, I2, I3 : in bit;
		O : out bit
	);
end Nor3_gate;

architecture behav of Nor3_gate is
begin
P1: process( I1, I2, I3 )
begin
	O <= Not(I1 or (I2 or I3));
end process;
end behav;

entity Nor4_gate is
	port(
		I1, I2, I3, I4 : in bit;
		O : out bit
	);
end Nor4_gate;

architecture behav of Nor4_gate is
begin
P1: process( I1, I2, I3, I4 )
begin
	O <= Not(I1 or (I2 or (I3 or I4)));
end process;
end behav;

entity Nor5_gate is
	port(
		I1, I2, I3, I4, I5 : in bit;
		O : out bit
	);
end Nor5_gate;

architecture behav of Nor5_gate is
begin
P1: process( I1, I2, I3, I4, I5 )
begin
	O <= Not(I1 or (I2 or (I3 or (I4 or I5))));
end process;
end behav;

entity Xor_gate is
	port(
		I1, I2 : in bit;
		O : out bit
	);
end Xor_gate;

architecture behav of Xor_gate is
begin
P1: process( I1, I2 )
begin
	O <= I1 xor I2;
end process;
end behav; 

entity Xor3_gate is
	port(
		I1, I2, I3 : in bit;
		O : out bit
	);
end Xor3_gate;

architecture behav of Xor3_gate is
begin
P1: process( I1, I2, I3 )
begin
	O <= I1 xor I2 xor I3;
end process;
end behav; 

entity Xor4_gate is
	port(
		I1, I2, I3, I4 : in bit;
		O : out bit
	);
end Xor4_gate;

architecture behav of Xor4_gate is
begin
P1: process( I1, I2, I3, I4 )
begin
	O <= I1 xor I2 xor I3 xor I4;
end process;
end behav; 

entity Xor5_gate is
	port(
		I1, I2, I3, I4, I5 : in bit;
		O : out bit
	);
end Xor5_gate;

architecture behav of Xor5_gate is
begin
P1: process( I1, I2, I3, I4, I5 )
	variable	cnt : integer;
begin
	O <= I1 xor I2 xor I3 xor I4 xor I5;
end process;
end behav;

entity Xnor_gate is
	port(
		I1, I2 : in bit;
		O : out bit
	);
end Xnor_gate;

architecture behav of Xnor_gate is
begin
P1: process( I1, I2 )
begin
	O <= not(I1 xor I2);
end process;
end behav; 

entity Xnor3_gate is
	port(
		I1, I2, I3 : in bit;
		O : out bit
	);
end Xnor3_gate;

architecture behav of Xnor3_gate is
begin
P1: process( I1, I2, I3 )
	variable	cnt : integer;
begin
	O <= not(I1 xor I2 xor I3);
end process;
end behav; 

entity Xnor4_gate is
	port(
		I1, I2, I3, I4 : in bit;
		O : out bit
	);
end Xnor4_gate;

architecture behav of Xnor4_gate is
begin
P1: process( I1, I2, I3, I4 )
begin
	O <= not(I1 xor I2 xor I3 xor I4);
end process;
end behav; 

entity Xnor5_gate is
	port(
		I1, I2, I3, I4, I5 : in bit;
		O : out bit
	);
end Xnor5_gate;

architecture behav of Xnor5_gate is
begin
P1: process( I1, I2, I3, I4, I5 )
	variable	cnt : integer;
begin
	O <= not(I1 xor I2 xor I3 xor I4 xor I5);
end process;
end behav;

entity Inv_gate is
	port(
		I1 : in bit;
		O : out bit
	);
end Inv_gate;

architecture behav of Inv_gate is
begin
P1: process( I1 )
begin
	O <= not I1;
end process;
end behav;

entity Buf_gate is
	port(
		I1 : in bit;
		O : out bit
	);
end Buf_gate;

architecture behav of Buf_gate is
begin
P1: process( I1 )
begin
	O <= I1;
end process;
end behav;

entity Flip_Flop_D is
	port (
		CK : in bit;
		D : in bit;
		Q : out bit
	);
end Flip_Flop_D;

architecture behav of Flip_Flop_D is
begin
P1: process( CK )
begin
	if CK'event and CK = '1' then
		Q <= D;
	end if;
end process;
end behav;

entity Flip_Flop_D_reset is
	port (
		CK : in bit;
		D : in bit;
		RESET : in bit;
		Q : out bit
	);
end Flip_Flop_D_reset;

architecture behav of Flip_Flop_D_reset is
begin
P1: process( CK, RESET )
begin
	if RESET = '1' then
		Q <= '0';
	elsif CK'event and CK = '1' then
		Q <= D;
	end if;
end process;
end behav;

entity Flip_Flop_D_preset is
	port (
		CK : in bit;
		D : in bit;
		PRESET : in bit;
		Q : out bit
	);
end Flip_Flop_D_preset;

architecture behav of Flip_Flop_D_preset is
begin
P1: process( CK, PRESET )
begin
	if PRESET = '1' then
		Q <= '1';
	elsif CK'event and CK = '1' then
		Q <= D;
	end if;
end process;
end behav;

entity Flip_Flop_D_reset_preset is
	port (
		CK : in bit;
		D : in bit;
		RESET : in bit;
		PRESET : in bit;
		Q : out bit
	);
end Flip_Flop_D_reset_preset;

architecture behav of Flip_Flop_D_reset_preset is
begin
P1: process( CK, RESET, PRESET )
begin
	if (RESET = '1' and PRESET = '0')
	   or (RESET = '1' and PRESET = '1')  then
		Q <= '0';
	elsif PRESET = '1' then
		Q <= '1';
	elsif CK'event and CK = '1' then
		Q <= D;
	end if;
end process;
end behav;
