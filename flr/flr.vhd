library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity flr is
  port (
    flr_in : in std_logic_vector (31 downto 0);
    flr_out : out std_logic_vector (31 downto 0));
end flr;

architecture flrchan of flr is
  signal cut23, cut22, cut21, cut20, cut19, cut18, cut17, cut16, cut15, cut14, cut13, cut12, cut11, cut10, cut9, cut8, cut7, cut6, cut5, cut4, cut3, cut2, cut1 : std_logic;
begin
    cut23 <= flr_in(31) and (flr_in(22) or flr_in(21) or flr_in(20) or flr_in(19) or flr_in(18) or flr_in(17) or flr_in(16) or flr_in(15) or flr_in(14) or flr_in(13) or flr_in(12) or flr_in(11) or flr_in(10) or flr_in(9) or flr_in(8) or flr_in(7) or flr_in(6) or flr_in(5) or flr_in(4) or flr_in(3) or flr_in(2) or flr_in(1) or flr_in(0));
  cut22 <= flr_in(31) and (flr_in(21) or flr_in(20) or flr_in(19) or flr_in(18) or flr_in(17) or flr_in(16) or flr_in(15) or flr_in(14) or flr_in(13) or flr_in(12) or flr_in(11) or flr_in(10) or flr_in(9) or flr_in(8) or flr_in(7) or flr_in(6) or flr_in(5) or flr_in(4) or flr_in(3) or flr_in(2) or flr_in(1) or flr_in(0));
  cut21 <= flr_in(31) and (flr_in(20) or flr_in(19) or flr_in(18) or flr_in(17) or flr_in(16) or flr_in(15) or flr_in(14) or flr_in(13) or flr_in(12) or flr_in(11) or flr_in(10) or flr_in(9) or flr_in(8) or flr_in(7) or flr_in(6) or flr_in(5) or flr_in(4) or flr_in(3) or flr_in(2) or flr_in(1) or flr_in(0));
  cut20 <= flr_in(31) and (flr_in(19) or flr_in(18) or flr_in(17) or flr_in(16) or flr_in(15) or flr_in(14) or flr_in(13) or flr_in(12) or flr_in(11) or flr_in(10) or flr_in(9) or flr_in(8) or flr_in(7) or flr_in(6) or flr_in(5) or flr_in(4) or flr_in(3) or flr_in(2) or flr_in(1) or flr_in(0));
  cut19 <= flr_in(31) and (flr_in(18) or flr_in(17) or flr_in(16) or flr_in(15) or flr_in(14) or flr_in(13) or flr_in(12) or flr_in(11) or flr_in(10) or flr_in(9) or flr_in(8) or flr_in(7) or flr_in(6) or flr_in(5) or flr_in(4) or flr_in(3) or flr_in(2) or flr_in(1) or flr_in(0));
  cut18 <= flr_in(31) and (flr_in(17) or flr_in(16) or flr_in(15) or flr_in(14) or flr_in(13) or flr_in(12) or flr_in(11) or flr_in(10) or flr_in(9) or flr_in(8) or flr_in(7) or flr_in(6) or flr_in(5) or flr_in(4) or flr_in(3) or flr_in(2) or flr_in(1) or flr_in(0));
  cut17 <= flr_in(31) and (flr_in(16) or flr_in(15) or flr_in(14) or flr_in(13) or flr_in(12) or flr_in(11) or flr_in(10) or flr_in(9) or flr_in(8) or flr_in(7) or flr_in(6) or flr_in(5) or flr_in(4) or flr_in(3) or flr_in(2) or flr_in(1) or flr_in(0));
  cut16 <= flr_in(31) and (flr_in(15) or flr_in(14) or flr_in(13) or flr_in(12) or flr_in(11) or flr_in(10) or flr_in(9) or flr_in(8) or flr_in(7) or flr_in(6) or flr_in(5) or flr_in(4) or flr_in(3) or flr_in(2) or flr_in(1) or flr_in(0));
  cut15 <= flr_in(31) and (flr_in(14) or flr_in(13) or flr_in(12) or flr_in(11) or flr_in(10) or flr_in(9) or flr_in(8) or flr_in(7) or flr_in(6) or flr_in(5) or flr_in(4) or flr_in(3) or flr_in(2) or flr_in(1) or flr_in(0));
  cut14 <= flr_in(31) and (flr_in(13) or flr_in(12) or flr_in(11) or flr_in(10) or flr_in(9) or flr_in(8) or flr_in(7) or flr_in(6) or flr_in(5) or flr_in(4) or flr_in(3) or flr_in(2) or flr_in(1) or flr_in(0));
  cut13 <= flr_in(31) and (flr_in(12) or flr_in(11) or flr_in(10) or flr_in(9) or flr_in(8) or flr_in(7) or flr_in(6) or flr_in(5) or flr_in(4) or flr_in(3) or flr_in(2) or flr_in(1) or flr_in(0));
  cut12 <= flr_in(31) and (flr_in(11) or flr_in(10) or flr_in(9) or flr_in(8) or flr_in(7) or flr_in(6) or flr_in(5) or flr_in(4) or flr_in(3) or flr_in(2) or flr_in(1) or flr_in(0));
  cut11 <= flr_in(31) and (flr_in(10) or flr_in(9) or flr_in(8) or flr_in(7) or flr_in(6) or flr_in(5) or flr_in(4) or flr_in(3) or flr_in(2) or flr_in(1) or flr_in(0));
  cut10 <= flr_in(31) and (flr_in(9) or flr_in(8) or flr_in(7) or flr_in(6) or flr_in(5) or flr_in(4) or flr_in(3) or flr_in(2) or flr_in(1) or flr_in(0));
  cut9 <= flr_in(31) and (flr_in(8) or flr_in(7) or flr_in(6) or flr_in(5) or flr_in(4) or flr_in(3) or flr_in(2) or flr_in(1) or flr_in(0));
  cut8 <= flr_in(31) and (flr_in(7) or flr_in(6) or flr_in(5) or flr_in(4) or flr_in(3) or flr_in(2) or flr_in(1) or flr_in(0));
  cut7 <= flr_in(31) and (flr_in(6) or flr_in(5) or flr_in(4) or flr_in(3) or flr_in(2) or flr_in(1) or flr_in(0));
  cut6 <= flr_in(31) and (flr_in(5) or flr_in(4) or flr_in(3) or flr_in(2) or flr_in(1) or flr_in(0));
  cut5 <= flr_in(31) and (flr_in(4) or flr_in(3) or flr_in(2) or flr_in(1) or flr_in(0));
  cut4 <= flr_in(31) and (flr_in(3) or flr_in(2) or flr_in(1) or flr_in(0));
  cut3 <= flr_in(31) and (flr_in(2) or flr_in(1) or flr_in(0));
  cut2 <= flr_in(31) and (flr_in(1) or flr_in(0));
  cut1 <= flr_in(31) and (flr_in(0));
  
  flr_out(31) <= flr_in(31);
  flr_out(30 downto 0) <= flr_in(30 downto 23) & (flr_in(22) or (flr_in(30) and flr_in(29) and flr_in(28) and flr_in(27) and flr_in(26) and flr_in(25) and flr_in(24) and flr_in(23) and (flr_in(21) or flr_in(20) or flr_in(19) or flr_in(18) or flr_in(17) or flr_in(16) or flr_in(15) or flr_in(14) or flr_in(13) or flr_in(12) or flr_in(11) or flr_in(10) or flr_in(9) or flr_in(8) or flr_in(7) or flr_in(6) or flr_in(5) or flr_in(4) or flr_in(3) or flr_in(2) or flr_in(1) or flr_in(0)))) & flr_in(21 downto 0) when flr_in(30 downto 23) >= x"96" else
                          "000" & x"0000000" when flr_in = x"80000000" else
                          '0' & flr_in(31) & flr_in(31) & flr_in(31) & flr_in(31) & flr_in(31) & flr_in(31) & flr_in(31) & "000" & x"00000" when flr_in(30 downto 23) < x"7f" else
                          (flr_in(30 downto 23) xor (cut23 & cut23 & cut23 & cut23 & cut23 & cut23 & cut23 & cut23)) & "000" & x"00000" when flr_in(27 downto 23) = "11111" else
                          flr_in(30 downto 24) & (("0" & flr_in(22 downto 22)) + ("0" & cut22))  & "00" & x"00000" when flr_in(27 downto 23) = "00000" else
                          flr_in(30 downto 25) & (("01" & flr_in(22 downto 21)) + ("000" & cut21)) & "0" & x"00000" when flr_in(27 downto 24) = "0000" else
                          flr_in(30 downto 24) & (("0" & flr_in(22 downto 20)) + ("000" & cut20)) & x"00000" when flr_in(27 downto 23) = "00010" else
                          flr_in(30 downto 26) & (("011" & flr_in(22 downto 19)) + ("00" & x"0" & cut19)) & "000" & x"0000" when flr_in(27 downto 24) = "0001" else
                          flr_in(30 downto 24) & (("0" & flr_in(22 downto 18)) + ("0" & x"0" & cut18)) & "00" & x"0000" when flr_in(27 downto 23) = "00100" else
                          flr_in(30 downto 25) & (("01" & flr_in(22 downto 17)) + ("000" & x"0" & cut17)) & "0" & x"0000" when flr_in(27 downto 24) = "0010" else
                          flr_in(30 downto 24) & (("0" & flr_in(22 downto 16)) + ("000" & x"0" & cut16)) & x"0000" when flr_in(26 downto 23) = "0110" else
                          flr_in(30 downto 27) & (("0111" & flr_in(22 downto 15)) + ("000" & x"00" & cut15)) & "000" & x"000" when flr_in(26 downto 24) = "011" else
                          flr_in(30 downto 24) & (("0" & flr_in(22 downto 14)) + ("0" & x"00" & cut14)) & "00" & x"000" when flr_in(26 downto 23) = "1000" else
                          flr_in(30 downto 25) & (("01" & flr_in(22 downto 13)) + ("000" & x"00" & cut13)) & "0" & x"000" when flr_in(26 downto 24) = "100" else
                          flr_in(30 downto 24) & (("0" & flr_in(22 downto 12)) + ("000" & x"00" & cut12)) & x"000" when flr_in(26 downto 23) = "1010" else
                          flr_in(30 downto 26) & (("011" & flr_in(22 downto 11)) + ("00" & x"000" & cut11)) & "000" & x"00" when flr_in(26 downto 24) = "101" else
                          flr_in(30 downto 24) & (("0" & flr_in(22 downto 10)) + ("0" & x"000" & cut10)) & "00" & x"00" when flr_in(26 downto 23) = "1100" else
                          flr_in(30 downto 25) & (("01" & flr_in(22 downto 9)) + ("000" & x"000" & cut9)) & "0" & x"00" when flr_in(26 downto 24) = "110" else
                          flr_in(30 downto 24) & (("0" & flr_in(22 downto 8)) + ("000" & x"000" & cut8)) & x"00" when flr_in(26 downto 23) = "1110" else
                          flr_in(30 downto 28) & (("01111" & flr_in(22 downto 7)) + (x"00000" & cut7)) & "000" & x"0" when flr_in(27 downto 27) = "0" else
                          flr_in(30 downto 24) & (("0" & flr_in(22 downto 6)) + ("0" & x"0000" & cut6)) & "00" & x"0" when flr_in(25 downto 23) = "000" else
                          flr_in(30 downto 25) & (("01" & flr_in(22 downto 5)) + ("000" & x"0000" & cut5)) & "0" & x"0" when flr_in(25 downto 24) = "00" else
                          flr_in(30 downto 24) & (("0" & flr_in(22 downto 4)) + ("000" & x"0000" & cut4)) & x"0" when flr_in(24 downto 23) = "10" else
                          flr_in(30 downto 26) & (("011" & flr_in(22 downto 3)) + ("00" & x"00000" & cut3)) & "000" when flr_in(24 downto 24) = "1" else
                          flr_in(30 downto 24) & (("0" & flr_in(22 downto 2)) + ("0" & x"00000" & cut2)) & "00" when flr_in(23 downto 23) = "0" else
                          flr_in(30 downto 25) & (("01" & flr_in(22 downto 1)) + ("000" & x"00000" & cut1)) & "0";
                          -- don't care "10110" ~ "11110"
end flrchan;
