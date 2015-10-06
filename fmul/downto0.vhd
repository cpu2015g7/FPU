library ieee;
use ieee.std_logic_1164.all;

entity downto0 is
  port (
    shift : in std_logic_vector (5 downto 0);
    manprd1 : in std_logic_vector (46 downto 0);
    mancut : out std_logic_vector (46 downto 0));
end downto0;

architecture downto0chan of downto0 is
begin
--mancat <= (others => '0') & manprd1((shift-1) downto 0)
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
end downto0chan;
