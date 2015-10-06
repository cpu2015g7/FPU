library ieee;
use ieee.std_logic_1164.all;

entity mysrl is
  port (
    shift : in std_logic_vector (5 downto 0);
    manprd1 : in std_logic_vector (46 downto 0);
    mansub0 : out std_logic_vector (23 downto 0));
end mysrl;

architecture mysrlchan of mysrl is
begin
--mansub0 <= (others => '0') & manprd1(46 downto (shift-1))
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
end mysrlchan;
