library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity i2f is
  port (
    i2f_in : in std_logic_vector (31 downto 0);
    i2f_out : out std_logic_vector (31 downto 0));
end i2f;

architecture i2fchan of i2f is
  signal absl, exman_out : std_logic_vector (30 downto 0);
  signal tmp4, tmp3, tmp2, tmp1, tmp0 : std_logic_vector (31 downto 0);
  signal carry : std_logic;
begin
  i2f_out <= x"00000000" when i2f_in = x"00000000" else
             x"cf000000" when i2f_in = x"80000000" else
             i2f_in(31) & exman_out;
  absl <= i2f_in(30 downto 0) when i2f_in(31) = '0' else
          not i2f_in(30 downto 0) + 1;
  
  tmp4 <= absl(14 downto 0) & x"0000" & '0' when absl(30 downto 15) = x"0000" else
          absl & '1';
  tmp3 <= tmp4(23 downto 1) & x"00" & '0' when tmp4(31 downto 24) = x"00" else
          tmp4(31 downto 1) & '1';
  tmp2 <= tmp3(27 downto 1) & x"0" & '0' when tmp3(31 downto 28) = x"0" else
          tmp3(31 downto 1) & '1';
  tmp1 <= tmp2(29 downto 1) & "00" & '0' when tmp2(31 downto 30) = "00" else
          tmp2(31 downto 1) & '1';
  tmp0 <= tmp1(30 downto 1) & "0" & '0' when tmp1(31 downto 31) = "0" else
          tmp1(31 downto 1) & '1';
  
  carry <= tmp0(7) and (tmp0(8) or tmp0(6) or tmp0(5) or tmp0(4) or tmp0(3) or tmp0(2) or tmp0(1));
  exman_out(30 downto 23) <= x"7e" + ("000" & tmp4(0) & tmp3(0) & tmp2(0) & tmp1(0) & tmp0(0)) + (x"0" & "000" & (tmp0(30) and tmp0(29) and tmp0(28) and tmp0(27) and tmp0(26) and tmp0(25) and tmp0(24) and tmp0(23) and tmp0(22) and tmp0(21) and tmp0(20) and tmp0(19) and tmp0(18) and tmp0(17) and tmp0(16) and tmp0(15) and tmp0(14) and tmp0(13) and tmp0(12) and tmp0(11) and tmp0(10) and tmp0(9) and tmp0(8) and carry));
  exman_out(22 downto 0) <= tmp0(30 downto 8) + (x"00000" & "00" & carry);
end i2fchan;
