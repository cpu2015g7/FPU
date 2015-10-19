library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mod2 is -- controls the Sub + Sub part
  port (
    mod2_sb, mod2_ss : in std_logic_vector  (0 downto 0); -- sgnbig, sgnsnall
    mod2_fb, mod2_fs : in std_logic_vector (22 downto 0); -- frcbig, frcsmall
    mod2_out : out std_logic_vector (31 downto 0));
end mod2;

architecture mod2chan of mod2 is
begin
  mod2_out <= mod2_sb & "0000000" & (("0"&mod2_fb) + ("0"&mod2_fs)) when (mod2_sb = mod2_ss) else
              mod2_sb & "00000000" & (mod2_fb - mod2_fs);
end mod2chan;
