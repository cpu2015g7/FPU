library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity fmul is
  port (
    fmul_in0, fmul_in1 : in std_logic_vector (31 downto 0);
    fmul_out : out std_logic_vector (31 downto 0));
end fmul;

architecture fmulchan of fmul is
  signal ex_in0, ex_in1, ex_bg, ex_sm : std_logic_vector (7 downto 0);
  signal man_in0, man_in1, man_bg, man_sm : std_logic_vector (22 downto 0);
  constant zero23 : std_logic_vector (22 downto 0) := (others => '0');
  
  signal cat0 : std_logic_vector (63 downto 0); -- bg & sm
  signal bg, sm : std_logic_vector (31 downto 0);
  signal sgn_out : std_logic;
  
  signal cat1 : std_logic_vector (56 downto 0); -- ex0 & manprd0
  signal cat_ls : std_logic_vector (54 downto 0);
  signal ex0 : std_logic_vector (8 downto 0);
  signal manprd_sub : std_logic_vector (46 downto 0);
  signal manprd0 : std_logic_vector (47 downto 0);
  
  signal cat2 : std_logic_vector (56 downto 0); -- carrysign & ex1 & manprd1
  signal carrysign : std_logic := '0';
  signal ex1 : std_logic_vector (8 downto 0);
  signal manprd1 : std_logic_vector (46 downto 0);
  
  signal shift0 : std_logic_vector (6 downto 0);  
  signal shift : std_logic_vector (5 downto 0);
  signal mansub0 : std_logic_vector (23 downto 0);
  signal mansub1 : std_logic_vector (22 downto 0);
  signal mancut : std_logic_vector (46 downto 0);
  
  signal ex20 : std_logic_vector (8 downto 0); 
  signal ex2 : std_logic_vector (7 downto 0);
  
  signal out0, out00, out01 : std_logic_vector (31 downto 0);
  signal fmul_exman_out, exman_out0, exman_out00, exman_out1, exman_out10 : std_logic_vector (30 downto 0);

begin
  cat0 <= fmul_in0 & fmul_in1 when fmul_in0(30 downto 0) > fmul_in1(30 downto 0) else
         fmul_in1 & fmul_in0;
  bg <= cat0(63 downto 32);
  sm <= cat0(31 downto 0);
  
  ex_in0 <= fmul_in0(30 downto 23);
  ex_in1 <= fmul_in1(30 downto 23);
  ex_bg <= bg(30 downto 23);
  ex_sm <= sm(30 downto 23);
  man_in0 <= fmul_in0(22 downto 0);
  man_in1 <= fmul_in1(22 downto 0);
  man_bg <= bg(22 downto 0);
  man_sm <= sm(22 downto 0);
  
  sgn_out <= fmul_in0(31) xor fmul_in1(31);
  
  out00 <= fmul_in1(31 downto 23) & '1' & fmul_in1(21 downto 0) when ex_sm = x"ff" and man_sm > 0 else
           bg(31 downto 23) & '1' & bg(21 downto 0);
  out01 <= sgn_out & x"ff" & zero23 when ex_sm & man_sm > 0 else
           x"ffc00000";
  out0  <= out00 when man_bg > 0 else
           out01;
  
  
  manprd_sub <= ('1' & man_bg) * man_sm;
  cat_ls <= (ex_bg+ 1) & manprd_sub                    when manprd_sub(46) = '1'                  else
             ex_bg     & manprd_sub (45 downto 0) & "0" when manprd_sub(45) = '1' or ex_bg = x"00" else
            (ex_bg- 1) & manprd_sub (44 downto 0) & "00" when manprd_sub(44) = '1' or ex_bg = x"01" else
            (ex_bg- 2) & manprd_sub (43 downto 0) & "000" when manprd_sub(43) = '1' or ex_bg = x"02" else
            (ex_bg- 3) & manprd_sub (42 downto 0) & "0000" when manprd_sub(42) = '1' or ex_bg = x"03" else
            (ex_bg- 4) & manprd_sub (41 downto 0) & "00000" when manprd_sub(41) = '1' or ex_bg = x"04" else
            (ex_bg- 5) & manprd_sub (40 downto 0) & "000000" when manprd_sub(40) = '1' or ex_bg = x"05" else
            (ex_bg- 6) & manprd_sub (39 downto 0) & "0000000" when manprd_sub(39) = '1' or ex_bg = x"06" else
            (ex_bg- 7) & manprd_sub (38 downto 0) & "00000000" when manprd_sub(38) = '1' or ex_bg = x"07" else
            (ex_bg- 8) & manprd_sub (37 downto 0) & "000000000" when manprd_sub(37) = '1' or ex_bg = x"08" else
            (ex_bg- 9) & manprd_sub (36 downto 0) & "0000000000" when manprd_sub(36) = '1' or ex_bg = x"09" else
            (ex_bg-10) & manprd_sub (35 downto 0) & "00000000000" when manprd_sub(35) = '1' or ex_bg = x"0a" else
            (ex_bg-11) & manprd_sub (34 downto 0) & "000000000000" when manprd_sub(34) = '1' or ex_bg = x"0b" else
            (ex_bg-12) & manprd_sub (33 downto 0) & "0000000000000" when manprd_sub(33) = '1' or ex_bg = x"0c" else
            (ex_bg-13) & manprd_sub (32 downto 0) & "00000000000000" when manprd_sub(32) = '1' or ex_bg = x"0d" else
            (ex_bg-14) & manprd_sub (31 downto 0) & "000000000000000" when manprd_sub(31) = '1' or ex_bg = x"0e" else
            (ex_bg-15) & manprd_sub (30 downto 0) & "0000000000000000" when manprd_sub(30) = '1' or ex_bg = x"0f" else
            (ex_bg-16) & manprd_sub (29 downto 0) & "00000000000000000" when manprd_sub(29) = '1' or ex_bg = x"10" else
            (ex_bg-17) & manprd_sub (28 downto 0) & "000000000000000000" when manprd_sub(28) = '1' or ex_bg = x"11" else
            (ex_bg-18) & manprd_sub (27 downto 0) & "0000000000000000000" when manprd_sub(27) = '1' or ex_bg = x"12" else
            (ex_bg-19) & manprd_sub (26 downto 0) & "00000000000000000000" when manprd_sub(26) = '1' or ex_bg = x"13" else
            (ex_bg-20) & manprd_sub (25 downto 0) & "000000000000000000000" when manprd_sub(25) = '1' or ex_bg = x"14" else
            (ex_bg-21) & manprd_sub (24 downto 0) & "0000000000000000000000" when manprd_sub(24) = '1' or ex_bg = x"15" else
            (ex_bg-22) & manprd_sub (23 downto 0) & "00000000000000000000000";
  cat1 <= (('0' & ex_in0) + ('0' & ex_in1)) & (('1' & man_in0) * ('1' & man_in1)) when ex_sm > 0 else
          '0' & cat_ls(54 downto 47) & '0' & cat_ls(46 downto 0);
  ex0 <= cat1(56 downto 48);
  manprd0 <= cat1(47 downto 0);
  
  cat2 <= manprd0(0) & (ex0 + 1) & manprd0(47 downto 1) when manprd0(47) = '1' else
          '0' & ex0 & manprd0(46 downto 0);
  carrysign <= cat2(56);
  ex1 <= cat2(55 downto 47);
  manprd1 <= cat2(46 downto 0);
  
  
  shift0 <= 55 - ("00" & ex1(4 downto 0));
  shift <= shift0(5 downto 0);  -- from 24 to 47
  mansub0 <=      manprd1(46 downto 23) when shift = "011000" else
             "0" & manprd1(46 downto 24) when shift = "011001" else
             "00" & manprd1(46 downto 25) when shift = "011010" else
             "000" & manprd1(46 downto 26) when shift = "011011" else
             "0000" & manprd1(46 downto 27) when shift = "011100" else
             "00000" & manprd1(46 downto 28) when shift = "011101" else
             "000000" & manprd1(46 downto 29) when shift = "011110" else
             "0000000" & manprd1(46 downto 30) when shift = "011111" else
             "00000000" & manprd1(46 downto 31) when shift = "100000" else
             "000000000" & manprd1(46 downto 32) when shift = "100001" else
             "0000000000" & manprd1(46 downto 33) when shift = "100010" else
             "00000000000" & manprd1(46 downto 34) when shift = "100011" else
             "000000000000" & manprd1(46 downto 35) when shift = "100100" else
             "0000000000000" & manprd1(46 downto 36) when shift = "100101" else
             "00000000000000" & manprd1(46 downto 37) when shift = "100110" else
             "000000000000000" & manprd1(46 downto 38) when shift = "100111" else
             "0000000000000000" & manprd1(46 downto 39) when shift = "101000" else
             "00000000000000000" & manprd1(46 downto 40) when shift = "101001" else
             "000000000000000000" & manprd1(46 downto 41) when shift = "101010" else
             "0000000000000000000" & manprd1(46 downto 42) when shift = "101011" else
             "00000000000000000000" & manprd1(46 downto 43) when shift = "101100" else
             "000000000000000000000" & manprd1(46 downto 44) when shift = "101101" else
             "0000000000000000000000" & manprd1(46 downto 45) when shift = "101110" else
             "00000000000000000000000" & manprd1(46 downto 46);
  mansub1 <= mansub0(23 downto 1);
  mancut <= "00000000000000000000000" & manprd1(23 downto 0) when shift = "011000" else
            "0000000000000000000000" & manprd1(24 downto 0) when shift = "011001" else
            "000000000000000000000" & manprd1(25 downto 0) when shift = "011010" else
            "00000000000000000000" & manprd1(26 downto 0) when shift = "011011" else
            "0000000000000000000" & manprd1(27 downto 0) when shift = "011100" else
            "000000000000000000" & manprd1(28 downto 0) when shift = "011101" else
            "00000000000000000" & manprd1(29 downto 0) when shift = "011110" else
            "0000000000000000" & manprd1(30 downto 0) when shift = "011111" else
            "000000000000000" & manprd1(31 downto 0) when shift = "100000" else
            "00000000000000" & manprd1(32 downto 0) when shift = "100001" else
            "0000000000000" & manprd1(33 downto 0) when shift = "100010" else
            "000000000000" & manprd1(34 downto 0) when shift = "100011" else
            "00000000000" & manprd1(35 downto 0) when shift = "100100" else
            "0000000000" & manprd1(36 downto 0) when shift = "100101" else
            "000000000" & manprd1(37 downto 0) when shift = "100110" else
            "00000000" & manprd1(38 downto 0) when shift = "100111" else
            "0000000" & manprd1(39 downto 0) when shift = "101000" else
            "000000" & manprd1(40 downto 0) when shift = "101001" else
            "00000" & manprd1(41 downto 0) when shift = "101010" else
            "0000" & manprd1(42 downto 0) when shift = "101011" else
            "000" & manprd1(43 downto 0) when shift = "101100" else
            "00" & manprd1(44 downto 0) when shift = "101101" else
            "0" & manprd1(45 downto 0) when shift = "101110" else
                 manprd1(46 downto 0);
  exman_out00 <= x"01" & zero23 when mansub1 = "111" & x"fffff" else
                 x"00" & (mansub1 + 1);
  exman_out0 <= exman_out00 when (mansub0(0) = '1' and (mancut > 0 or carrysign = '1' or mansub1(0) = '1')) else
                x"00" & mansub1;
  
  
  ex20 <= ex1 - 127;
  ex2 <= ex20(7 downto 0);
  exman_out10 <= (ex2 + 1) & zero23 when manprd1(45 downto 23) = x"ffffff" else
                 ex2 & (manprd1(45 downto 23) + 1);
  exman_out1 <= exman_out10 when (manprd1(22) = '1' and (manprd1(21 downto 0) > 0 or carrysign = '1' or manprd1(23) = '1')) else
                ex2 & manprd1(45 downto 23);
  
  
  fmul_out <= out0 when ex_bg = x"ff" else
              sgn_out & fmul_exman_out;
  
  fmul_exman_out <= (others => '0') when ex_sm & man_sm = 0 or ex1 < 104 else
                    exman_out0 when ex1 < 128 else
                    exman_out1 when ex1 < 382 else
                    x"ff" & zero23;
end fmulchan;
