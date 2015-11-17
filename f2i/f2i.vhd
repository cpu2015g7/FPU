library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity f2i is
  port (
    f2i_in : in std_logic_vector (31 downto 0);
    f2i_out : out std_logic_vector (31 downto 0));
end f2i;

architecture f2ichan of f2i is
  signal shift : std_logic_vector (3 downto 0);
  signal tmp4, tmp3, tmp2, tmp1, tmp : std_logic_vector (31 downto 0);
  signal which : std_logic_vector (30 downto 0);
begin
  f2i_out <= x"00000000" when f2i_in(30 downto 23) < x"7e" else
             x"80000000" when f2i_in(30 downto 23) >= x"9e" else
             f2i_in(31) & which;
  which <= tmp(31 downto 1) + (x"0000000" & "00" & tmp(0)) when f2i_in(31) = '0' else
           not tmp(31 downto 1) + (x"0000000" & "00" & (not tmp(0)));
  
  shift <= f2i_in(27 downto 24) + x"1";
  
  tmp4 <= x"0000" & '1' & f2i_in(22 downto 8) when shift(3) = '0' else
          '1' & f2i_in(22 downto 0) & x"00";
  tmp3 <= x"00" & tmp4(31 downto 8) when shift(2) = '0' else
          tmp4;
  tmp2 <= x"0" & tmp3(31 downto 4) when shift(1) = '0' else
          tmp3;
  tmp1 <= "00" & tmp2(31 downto 2) when shift(0) = '0' else
          tmp2;
  tmp <= "0" & tmp1(31 downto 1) when f2i_in(23) = '0' else
          tmp1;
end f2ichan;
