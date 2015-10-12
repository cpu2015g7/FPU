library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity f2i is
  port (
    f2i_in : in std_logic_vector (31 downto 0);
    f2i_out : out std_logic_vector (31 downto 0));
end f2i;

architecture f2ichan of f2i is
  signal ex : std_logic_vector (7 downto 0);
  signal man : std_logic_vector (22 downto 0);
  signal pos, neg, which : std_logic_vector (30 downto 0);
begin
  ex <= f2i_in(30 downto 23);
  man <= f2i_in(22 downto 0);
  f2i_out <= x"00000000" when ex <= x"7e" else
             x"80000000" when ex >= x"9e" else
             f2i_in(31) & which;
  which <= pos when f2i_in(31) = '0' else
           neg;
  
  pos <= "0000000000000000000000000000001" when ex = x"7f" else
         "000000000000000000000000000001" & man(22 downto 22) when ex = x"80" else
         "00000000000000000000000000001" & man(22 downto 21) when ex = x"81" else
         "0000000000000000000000000001" & man(22 downto 20) when ex = x"82" else
         "000000000000000000000000001" & man(22 downto 19) when ex = x"83" else
         "00000000000000000000000001" & man(22 downto 18) when ex = x"84" else
         "0000000000000000000000001" & man(22 downto 17) when ex = x"85" else
         "000000000000000000000001" & man(22 downto 16) when ex = x"86" else
         "00000000000000000000001" & man(22 downto 15) when ex = x"87" else
         "0000000000000000000001" & man(22 downto 14) when ex = x"88" else
         "000000000000000000001" & man(22 downto 13) when ex = x"89" else
         "00000000000000000001" & man(22 downto 12) when ex = x"8a" else
         "0000000000000000001" & man(22 downto 11) when ex = x"8b" else
         "000000000000000001" & man(22 downto 10) when ex = x"8c" else
         "00000000000000001" & man(22 downto 9) when ex = x"8d" else
         "0000000000000001" & man(22 downto 8) when ex = x"8e" else
         "000000000000001" & man(22 downto 7) when ex = x"8f" else
         "00000000000001" & man(22 downto 6) when ex = x"90" else
         "0000000000001" & man(22 downto 5) when ex = x"91" else
         "000000000001" & man(22 downto 4) when ex = x"92" else
         "00000000001" & man(22 downto 3) when ex = x"93" else
         "0000000001" & man(22 downto 2) when ex = x"94" else
         "000000001" & man(22 downto 1) when ex = x"95" else
         "00000001" & man when ex = x"96" else
         "0000001" & man & "0" when ex = x"97" else
         "000001" & man & "00" when ex = x"98" else
         "00001" & man & "000" when ex = x"99" else
         "0001" & man & "0000" when ex = x"9a" else
         "001" & man & "00000" when ex = x"9b" else
         "01" & man & "000000" when ex = x"9c" else
         "1" & man & "0000000";
  
  neg <= not pos + 1;
  
end f2ichan;
