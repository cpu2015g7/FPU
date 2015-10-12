library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity fsqrt is
  port (
    fsqrt_in : in std_logic_vector (31 downto 0);
    fsqrt_out : out std_logic_vector (31 downto 0));
end fsqrt;

architecture fsqrtchan of fsqrt is
  signal sgn : std_logic;
  signal ex : std_logic_vector (7 downto 0);
  signal man : std_logic_vector (22 downto 0);
  signal cat, cat_sub, cat_norm : std_logic_vector (32 downto 0); -- ex_out & man_geta
  
  constant adj1 : std_logic_vector (1 downto 0) := "01";
  signal man0 : std_logic_vector (1 downto 0);
  signal adj2 : std_logic_vector (2 downto 0);
  signal adj3, man1, mns1 : std_logic_vector (3 downto 0);
  signal adj4, man2, mns2 : std_logic_vector (4 downto 0);
  signal adj5, man3, mns3 : std_logic_vector (5 downto 0);
  signal adj6, man4, mns4 : std_logic_vector (6 downto 0);
  signal adj7, man5, mns5 : std_logic_vector (7 downto 0);
  signal adj8, man6, mns6 : std_logic_vector (8 downto 0);
  signal adj9, man7, mns7 : std_logic_vector (9 downto 0);
  signal adj10, man8, mns8 : std_logic_vector (10 downto 0);
  signal adj11, man9, mns9 : std_logic_vector (11 downto 0);
  signal adj12, man10, mns10 : std_logic_vector (12 downto 0);
  signal adj13, man11, mns11 : std_logic_vector (13 downto 0);
  signal adj14, man12, mns12 : std_logic_vector (14 downto 0);
  signal adj15, man13, mns13 : std_logic_vector (15 downto 0);
  signal adj16, man14, mns14 : std_logic_vector (16 downto 0);
  signal adj17, man15, mns15 : std_logic_vector (17 downto 0);
  signal adj18, man16, mns16 : std_logic_vector (18 downto 0);
  signal adj19, man17, mns17 : std_logic_vector (19 downto 0);
  signal adj20, man18, mns18 : std_logic_vector (20 downto 0);
  signal adj21, man19, mns19 : std_logic_vector (21 downto 0);
  signal adj22, man20, mns20 : std_logic_vector (22 downto 0);
  signal adj23, man21, mns21 : std_logic_vector (23 downto 0);
  signal adj24, man22, mns22 : std_logic_vector (24 downto 0);
  signal man23, mns23 : std_logic_vector (25 downto 0);
  signal man24 : std_logic_vector (26 downto 0);
  signal man_out : std_logic_vector (22 downto 0);
begin
  sgn <= fsqrt_in(31);
  ex <= fsqrt_in(30 downto 23);
  man <= fsqrt_in(22 downto 0);

  cat <= cat_sub when ex = 0 else
         cat_norm;
  
  cat_sub(32 downto 29) <= "0011";
  cat_sub(28 downto 2) <= x"f" & man(22 downto 0) when man(22) = '1' or man(21) = '1' else
                          x"e" & man(20 downto 0) & "00" when man(20) = '1' or man(19) = '1' else
                          x"d" & man(18 downto 0) & "0000" when man(18) = '1' or man(17) = '1' else
                          x"c" & man(16 downto 0) & "000000" when man(16) = '1' or man(15) = '1' else
                          x"b" & man(14 downto 0) & "00000000" when man(14) = '1' or man(13) = '1' else
                          x"a" & man(12 downto 0) & "0000000000" when man(12) = '1' or man(11) = '1' else
                          x"9" & man(10 downto 0) & "000000000000" when man(10) = '1' or man(9) = '1' else
                          x"8" & man(8 downto 0) & "00000000000000" when man(8) = '1' or man(7) = '1' else
                          x"7" & man(6 downto 0) & "0000000000000000" when man(6) = '1' or man(5) = '1' else
                          x"6" & man(4 downto 0) & "000000000000000000" when man(4) = '1' or man(3) = '1' else
                          x"5" & man(2 downto 0) & "00000000000000000000" when man(2) = '1' or man(1) = '1' else
                          x"4" & '1' & "0000000000000000000000";
  cat_sub(1 downto 0) <= "00";
  
  cat_norm(32 downto 0) <= (('0' & (ex(7 downto 1))) + 63) & '1' & man & '0' when ex(0) = '0' else
                           (('0' & (ex(7 downto 1))) + 64) & '0' & '1' & man;
  
  
  man0 <= cat(24 downto 23);
  man1(3) <= man0(1) and man0(0);
  man1(2) <= not man0(0);
  man1(1 downto 0) <= cat(22 downto 21);
  mns1 <= man1 - (adj1 & "01");
  man2(4 downto 2) <= mns1(2 downto 0) when mns1(3) = '0' else
                      man1(2 downto 0);
  man2(1 downto 0) <= cat(20 downto 19);
  adj2 <= adj1 & (not mns1(3));
  mns2 <= man2 - (adj2 & "01");
  man3(5 downto 2) <= mns2(3 downto 0) when mns2(4) = '0' else
                      man2(3 downto 0);
  man3(1 downto 0) <= cat(18 downto 17);
  adj3 <= adj2 & (not mns2(4));
  mns3 <= man3 - (adj3 & "01");
  man4(6 downto 2) <= mns3(4 downto 0) when mns3(5) = '0' else
                      man3(4 downto 0);
  man4(1 downto 0) <= cat(16 downto 15);
  adj4 <= adj3 & (not mns3(5));
  mns4 <= man4 - (adj4 & "01");
  man5(7 downto 2) <= mns4(5 downto 0) when mns4(6) = '0' else
                      man4(5 downto 0);
  man5(1 downto 0) <= cat(14 downto 13);
  adj5 <= adj4 & (not mns4(6));
  mns5 <= man5 - (adj5 & "01");
  man6(8 downto 2) <= mns5(6 downto 0) when mns5(7) = '0' else
                      man5(6 downto 0);
  man6(1 downto 0) <= cat(12 downto 11);
  adj6 <= adj5 & (not mns5(7));
  mns6 <= man6 - (adj6 & "01");
  man7(9 downto 2) <= mns6(7 downto 0) when mns6(8) = '0' else
                      man6(7 downto 0);
  man7(1 downto 0) <= cat(10 downto 9);
  adj7 <= adj6 & (not mns6(8));
  mns7 <= man7 - (adj7 & "01");
  man8(10 downto 2) <= mns7(8 downto 0) when mns7(9) = '0' else
                       man7(8 downto 0);
  man8(1 downto 0) <= cat(8 downto 7);
  adj8 <= adj7 & (not mns7(9));
  mns8 <= man8 - (adj8 & "01");
  man9(11 downto 2) <= mns8(9 downto 0) when mns8(10) = '0' else
                       man8(9 downto 0);
  man9(1 downto 0) <= cat(6 downto 5);
  adj9 <= adj8 & (not mns8(10));
  mns9 <= man9 - (adj9 & "01");
  man10(12 downto 2) <= mns9(10 downto 0) when mns9(11) = '0' else
                        man9(10 downto 0);
  man10(1 downto 0) <= cat(4 downto 3);
  adj10 <= adj9 & (not mns9(11));
  mns10 <= man10 - (adj10 & "01");
  man11(13 downto 2) <= mns10(11 downto 0) when mns10(12) = '0' else
                        man10(11 downto 0);
  man11(1 downto 0) <= cat(2 downto 1);
  adj11 <= adj10 & (not mns10(12));
  mns11 <= man11 - (adj11 & "01");
  man12(14 downto 2) <= mns11(12 downto 0) when mns11(13) = '0' else
                        man11(12 downto 0);
  man12(1 downto 0) <= cat(0) & '0';
  adj12 <= adj11 & (not mns11(13));
  mns12 <= man12 - (adj12 & "01");
  man13(15 downto 2) <= mns12(13 downto 0) when mns12(14) = '0' else
                        man12(13 downto 0);
  man13(1 downto 0) <= "00";
  adj13 <= adj12 & (not mns12(14));
  mns13 <= man13 - (adj13 & "01");
  man14(16 downto 2) <= mns13(14 downto 0) when mns13(15) = '0' else
                        man13(14 downto 0);
  man14(1 downto 0) <= "00";
  adj14 <= adj13 & (not mns13(15));
  mns14 <= man14 - (adj14 & "01");
  man15(17 downto 2) <= mns14(15 downto 0) when mns14(16) = '0' else
                        man14(15 downto 0);
  man15(1 downto 0) <= "00";
  adj15 <= adj14 & (not mns14(16));
  mns15 <= man15 - (adj15 & "01");
  man16(18 downto 2) <= mns15(16 downto 0) when mns15(17) = '0' else
                        man15(16 downto 0);
  man16(1 downto 0) <= "00";
  adj16 <= adj15 & (not mns15(17));
  mns16 <= man16 - (adj16 & "01");
  man17(19 downto 2) <= mns16(17 downto 0) when mns16(18) = '0' else
                        man16(17 downto 0);
  man17(1 downto 0) <= "00";
  adj17 <= adj16 & (not mns16(18));
  mns17 <= man17 - (adj17 & "01");
  man18(20 downto 2) <= mns17(18 downto 0) when mns17(19) = '0' else
                        man17(18 downto 0);
  man18(1 downto 0) <= "00";
  adj18 <= adj17 & (not mns17(19));
  mns18 <= man18 - (adj18 & "01");
  man19(21 downto 2) <= mns18(19 downto 0) when mns18(20) = '0' else
                        man18(19 downto 0);
  man19(1 downto 0) <= "00";
  adj19 <= adj18 & (not mns18(20));
  mns19 <= man19 - (adj19 & "01");
  man20(22 downto 2) <= mns19(20 downto 0) when mns19(21) = '0' else
                        man19(20 downto 0);
  man20(1 downto 0) <= "00";
  adj20 <= adj19 & (not mns19(21));
  mns20 <= man20 - (adj20 & "01");
  man21(23 downto 2) <= mns20(21 downto 0) when mns20(22) = '0' else
                        man20(21 downto 0);
  man21(1 downto 0) <= "00";
  adj21 <= adj20 & (not mns20(22));
  mns21 <= man21 - (adj21 & "01");
  man22(24 downto 2) <= mns21(22 downto 0) when mns21(23) = '0' else
                        man21(22 downto 0);
  man22(1 downto 0) <= "00";
  adj22 <= adj21 & (not mns21(23));
  mns22 <= man22 - (adj22 & "01");
  man23(25 downto 2) <= mns22(23 downto 0) when mns22(24) = '0' else
                        man22(23 downto 0);
  man23(1 downto 0) <= "00";
  adj23 <= adj22 & (not mns22(24));
  
  mns23 <= man23 - (adj23 & "01");
  man24(26 downto 2) <= mns23(24 downto 0) when mns23(25) = '0' else
                        man23(24 downto 0);
  man24(1 downto 0) <= "00";
  adj24 <= adj23 & (not mns23(25));
  
  man_out <= adj24(22 downto 0) + 1 when (man24 = (adj24 & "01") and adj24(0) = '1') or man24 > (adj24 & "01") else
             adj24(22 downto 0);
  fsqrt_out <= fsqrt_in when (ex = 0 or (sgn = '0' and ex = x"ff")) and man = 0 else
               fsqrt_in(31 downto 23) & '1' & fsqrt_in(21 downto 0) when ex = x"ff" else
               x"ffc00000" when sgn = '1' else
               '0' & cat(32 downto 25) & man_out;
end fsqrtchan;

