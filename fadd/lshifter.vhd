library ieee;
use ieee.std_logic_1164.all;

entity lshifter is
  port (
    lshifter_ea : in std_logic_vector (7 downto 0);
    lshifterin  : in  std_logic_vector (23 downto 0);
    lshifterout : out std_logic_vector (23 downto 0);
    lshiftamt   : out std_logic_vector (4 downto 0));
end lshifter;

architecture lshifterchan of lshifter is
  signal sig : std_logic_vector (28 downto 0);
begin
  lshifterout <= sig(28 downto 5);
  lshiftamt   <= sig(4 downto 0);
  sig <= lshifterin                     & "00000" when (lshifterin(23) = '1' or lshifter_ea = x"00") else
        (lshifterin (22 downto 0) & "0") & "00001" when (lshifterin(22) = '1' or lshifter_ea = x"01") else
        (lshifterin (21 downto 0) & "00") & "00010" when (lshifterin(21) = '1' or lshifter_ea = x"02") else
        (lshifterin (20 downto 0) & "000") & "00011" when (lshifterin(20) = '1' or lshifter_ea = x"03") else
        (lshifterin (19 downto 0) & "0000") & "00100" when (lshifterin(19) = '1' or lshifter_ea = x"04") else
        (lshifterin (18 downto 0) & "00000") & "00101" when (lshifterin(18) = '1' or lshifter_ea = x"05") else
        (lshifterin (17 downto 0) & "000000") & "00110" when (lshifterin(17) = '1' or lshifter_ea = x"06") else
        (lshifterin (16 downto 0) & "0000000") & "00111" when (lshifterin(16) = '1' or lshifter_ea = x"07") else
        (lshifterin (15 downto 0) & "00000000") & "01000" when (lshifterin(15) = '1' or lshifter_ea = x"08") else
        (lshifterin (14 downto 0) & "000000000") & "01001" when (lshifterin(14) = '1' or lshifter_ea = x"09") else
        (lshifterin (13 downto 0) & "0000000000") & "01010" when (lshifterin(13) = '1' or lshifter_ea = x"0a") else
        (lshifterin (12 downto 0) & "00000000000") & "01011" when (lshifterin(12) = '1' or lshifter_ea = x"0b") else
        (lshifterin (11 downto 0) & "000000000000") & "01100" when (lshifterin(11) = '1' or lshifter_ea = x"0c") else
        (lshifterin (10 downto 0) & "0000000000000") & "01101" when (lshifterin(10) = '1' or lshifter_ea = x"0d") else
        (lshifterin ( 9 downto 0) & "00000000000000") & "01110" when (lshifterin( 9) = '1' or lshifter_ea = x"0e") else
        (lshifterin ( 8 downto 0) & "000000000000000") & "01111" when (lshifterin( 8) = '1' or lshifter_ea = x"0f") else
        (lshifterin ( 7 downto 0) & "0000000000000000") & "10000" when (lshifterin( 7) = '1' or lshifter_ea = x"10") else
        (lshifterin ( 6 downto 0) & "00000000000000000") & "10001" when (lshifterin( 6) = '1' or lshifter_ea = x"11") else
        (lshifterin ( 5 downto 0) & "000000000000000000") & "10010" when (lshifterin( 5) = '1' or lshifter_ea = x"12") else
        (lshifterin ( 4 downto 0) & "0000000000000000000") & "10011" when (lshifterin( 4) = '1' or lshifter_ea = x"13") else
        (lshifterin ( 3 downto 0) & "00000000000000000000") & "10100" when (lshifterin( 3) = '1' or lshifter_ea = x"14") else
        (lshifterin ( 2 downto 0) & "000000000000000000000") & "10101" when (lshifterin( 2) = '1' or lshifter_ea = x"15") else
        (lshifterin ( 1 downto 0) & "0000000000000000000000") & "10110" when (lshifterin( 1) = '1' or lshifter_ea = x"16") else
                                   "100000000000000000000000"  & "10111";
end lshifterchan;
