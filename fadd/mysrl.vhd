library ieee;
use ieee.std_logic_1164.all;

entity mysrl is
  port (
    srlin  : in  std_logic_vector (23 downto 0);
    srlamt : in  std_logic_vector (4 downto 0);
    srlout : out std_logic_vector (23 downto 0));
end mysrl;

architecture srlchan of mysrl is
begin
  srlout <=      srlin                when (srlamt = "00000") else
            "0" & srlin (23 downto  1) when (srlamt = "00001") else
            "00" & srlin (23 downto  2) when (srlamt = "00010") else
            "000" & srlin (23 downto  3) when (srlamt = "00011") else
            "0000" & srlin (23 downto  4) when (srlamt = "00100") else
            "00000" & srlin (23 downto  5) when (srlamt = "00101") else
            "000000" & srlin (23 downto  6) when (srlamt = "00110") else
            "0000000" & srlin (23 downto  7) when (srlamt = "00111") else
            "00000000" & srlin (23 downto  8) when (srlamt = "01000") else
            "000000000" & srlin (23 downto  9) when (srlamt = "01001") else
            "0000000000" & srlin (23 downto 10) when (srlamt = "01010") else
            "00000000000" & srlin (23 downto 11) when (srlamt = "01011") else
            "000000000000" & srlin (23 downto 12) when (srlamt = "01100") else
            "0000000000000" & srlin (23 downto 13) when (srlamt = "01101") else
            "00000000000000" & srlin (23 downto 14) when (srlamt = "01110") else
            "000000000000000" & srlin (23 downto 15) when (srlamt = "01111") else
            "0000000000000000" & srlin (23 downto 16) when (srlamt = "10000") else
            "00000000000000000" & srlin (23 downto 17) when (srlamt = "10001") else
            "000000000000000000" & srlin (23 downto 18) when (srlamt = "10010") else
            "0000000000000000000" & srlin (23 downto 19) when (srlamt = "10011") else
            "00000000000000000000" & srlin (23 downto 20) when (srlamt = "10100") else
            "000000000000000000000" & srlin (23 downto 21) when (srlamt = "10101") else
            "0000000000000000000000" & srlin (23 downto 22) when (srlamt = "10110") else
            "00000000000000000000000" & srlin (23 downto 23) when (srlamt = "10111") else
            "000000000000000000000000";
end srlchan;

