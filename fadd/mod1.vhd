library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mod1 is -- controls the inf_or_NaN part
  port (
    mod1_a, mod1_b, mod1_bg, mod1_sm : in std_logic_vector (31 downto 0); -- a, b, big, small
    mod1_sb, mod1_ss : in std_logic_vector  (0 downto 0); -- sgnbig, sgnsmall
             mod1_es : in std_logic_vector  (7 downto 0); --          exsmall
    mod1_fb, mod1_fs : in std_logic_vector (22 downto 0); -- frcbig, frcsmall
    mod1_out : out std_logic_vector (31 downto 0));
end mod1;

architecture mod1chan of mod1 is
  signal sig0, sig1 : std_logic_vector (31 downto 0);

begin
  sig0 <= mod1_b or x"00400000" when ((mod1_es = x"ff") and (mod1_fs > 0)) else
          mod1_bg or x"00400000";

  sig1 <= mod1_sm when (mod1_fs > 0) else
          mod1_a when (mod1_sb = mod1_ss) else
          x"ffc00000";

  mod1_out <= sig0 when (mod1_fb > 0) else
              sig1 when (mod1_es = x"ff") else
              mod1_bg;
end mod1chan;
