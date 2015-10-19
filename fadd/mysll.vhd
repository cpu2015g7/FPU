library ieee;
use ieee.std_logic_1164.all;

entity mysll is
  port (
    sllin  : in  std_logic_vector (23 downto 0);
    sllamt : in  std_logic_vector (4 downto 0);
    sllout : out std_logic_vector (23 downto 0));
end mysll;

architecture sllchan of mysll is
begin
  sllout <= sllin                    when (sllamt = "00000") else
            sllin (22 downto 0) & "0" when (sllamt = "00001") else
            sllin (21 downto 0) & "00" when (sllamt = "00010") else
            sllin (20 downto 0) & "000" when (sllamt = "00011") else
            sllin (19 downto 0) & "0000" when (sllamt = "00100") else
            sllin (18 downto 0) & "00000" when (sllamt = "00101") else
            sllin (17 downto 0) & "000000" when (sllamt = "00110") else
            sllin (16 downto 0) & "0000000" when (sllamt = "00111") else
            sllin (15 downto 0) & "00000000" when (sllamt = "01000") else
            sllin (14 downto 0) & "000000000" when (sllamt = "01001") else
            sllin (13 downto 0) & "0000000000" when (sllamt = "01010") else
            sllin (12 downto 0) & "00000000000" when (sllamt = "01011") else
            sllin (11 downto 0) & "000000000000" when (sllamt = "01100") else
            sllin (10 downto 0) & "0000000000000" when (sllamt = "01101") else
            sllin ( 9 downto 0) & "00000000000000" when (sllamt = "01110") else
            sllin ( 8 downto 0) & "000000000000000" when (sllamt = "01111") else
            sllin ( 7 downto 0) & "0000000000000000" when (sllamt = "10000") else
            sllin ( 6 downto 0) & "00000000000000000" when (sllamt = "10001") else
            sllin ( 5 downto 0) & "000000000000000000" when (sllamt = "10010") else
            sllin ( 4 downto 0) & "0000000000000000000" when (sllamt = "10011") else
            sllin ( 3 downto 0) & "00000000000000000000" when (sllamt = "10100") else
            sllin ( 2 downto 0) & "000000000000000000000" when (sllamt = "10101") else
            sllin ( 1 downto 0) & "0000000000000000000000" when (sllamt = "10110") else
            sllin ( 0 downto 0) & "00000000000000000000000" when (sllamt = "10111") else
                                  "000000000000000000000000";
end sllchan;

