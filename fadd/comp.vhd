library ieee;
use ieee.std_logic_1164.all;

entity comp is
  port (
    a, b : in  std_logic_vector (31 downto 0);
    bigger, smaller : out std_logic_vector (31 downto 0));
end comp;

architecture compchan of comp is
  signal sig : std_logic_vector (63 downto 0);
begin
  bigger  <= sig(63 downto 32);
  smaller <= sig(31 downto 0);

  sig <= a&b when (a(30 downto 0) > b(30 downto 0) or (a(30 downto 0) = b(30 downto 0) and a(31 downto 31) < b(31 downto 31))) else b&a;
end compchan;
