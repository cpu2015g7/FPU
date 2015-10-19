library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity fadd is
  port (
    fadd_in0, fadd_in1 : in std_logic_vector (31 downto 0);
    fadd_out : out std_logic_vector (31 downto 0));
end fadd;

architecture faddchan of fadd is
  signal big, small : std_logic_vector (31 downto 0);
  signal sgnbig, sgnsmall, sgnans : std_logic_vector (0 downto 0);
  signal  exbig,  exsmall,  exans,  exans3,  exans4 : std_logic_vector (7 downto 0);
  signal frcbig, frcsmall, frcans, frcans3, frcans4 : std_logic_vector (22 downto 0);
  signal sig_mod1, sig_mod2 : std_logic_vector (31 downto 0);

  signal exdif     : std_logic_vector (7 downto 0);
  signal frcsmchan : std_logic_vector (23 downto 0);
  signal frcbgchan : std_logic_vector (23 downto 0);
  signal ans0      : std_logic_vector (31 downto 0);

  component comp
  port (
    a, b : in  std_logic_vector (31 downto 0);
    bigger, smaller : out std_logic_vector (31 downto 0));
  end component;

  component mod1 -- controls the inf_or_NaN part
  port (
    mod1_a, mod1_b, mod1_bg, mod1_sm : in std_logic_vector (31 downto 0); -- a, b, big, small
    mod1_sb, mod1_ss : in std_logic_vector  (0 downto 0); -- sgnbig, sgnsmall
             mod1_es : in std_logic_vector  (7 downto 0); --          exsmall
    mod1_fb, mod1_fs : in std_logic_vector (22 downto 0); -- frcbig, frcsmall
    mod1_out : out std_logic_vector (31 downto 0));
  end component;

  component mod2 -- controls the Sub + Sub part
  port (
    mod2_sb, mod2_ss : in std_logic_vector  (0 downto 0); -- sgnbig, sgnsnall
    mod2_fb, mod2_fs : in std_logic_vector (22 downto 0); -- frcbig, frcsmall
    mod2_out : out std_logic_vector (31 downto 0));
  end component;

  component mod3 -- controls the addition part
  port (
    mod3_eb : in std_logic_vector (7 downto 0); -- exbig
    mod3_ed : in std_logic_vector (7 downto 0); -- exdif
    mod3_fbc, mod3_fsc : in std_logic_vector (23 downto 0); -- frcbgchan, frcsmchan
    mod3_ea : out std_logic_vector (7 downto 0);   -- exans
    mod3_fa : out std_logic_vector (22 downto 0)); -- frcans
  end component;

  component mod41 -- controls (the first half of) the subtraction part
  port (
    mod41_eb : in std_logic_vector (7 downto 0); -- exbig
    mod41_ed : in std_logic_vector (7 downto 0); -- exdif
    mod41_fbc, mod41_fsc : in std_logic_vector (23 downto 0); -- frcbgchan, frcsmchan
    mod41_ea : out std_logic_vector (7 downto 0);   -- exans
    mod41_fsum : out std_logic_vector (23 downto 0)); -- frcsum... not frcans (passed to mod42)
  end component;
  component mod42 -- controls (the second half of) the subtraction part
  port (
    mod42_eb : in std_logic_vector (7 downto 0); -- exbig
    mod42_ed : in std_logic_vector (7 downto 0); -- exdif
    mod42_fs : in std_logic_vector (22 downto 0); -- frcsmall
    mod42_fbc, mod42_fsc : in std_logic_vector (23 downto 0); -- frcbgchan, frcsmchan
    mod42_ea : out std_logic_vector (7 downto 0);   -- exans
    mod42_fa : out std_logic_vector (22 downto 0)); -- frcans
  end component;

begin
  sgnbig   <=   big(31 downto 31);
  exbig    <=   big(30 downto 23);
  frcbig   <=   big(22 downto 0);
  sgnsmall <= small(31 downto 31);
  exsmall  <= small(30 downto 23);
  frcsmall <= small(22 downto 0);

  ans0     <= (sgnans & exans & frcans);

  c : comp port map (
    a => fadd_in0,
    b => fadd_in1,
    bigger => big,
    smaller => small);

  m1 : mod1 port map (
    mod1_a => fadd_in0,
    mod1_b => fadd_in1,
    mod1_bg => big,
    mod1_sm => small,
    mod1_sb => sgnbig,
    mod1_ss => sgnsmall,
    mod1_es => exsmall,
    mod1_fb => frcbig,
    mod1_fs => frcsmall,
    mod1_out => sig_mod1);

  m2 : mod2 port map (
    mod2_sb => sgnbig,
    mod2_ss => sgnsmall,
    mod2_fb => frcbig,
    mod2_fs => frcsmall,
    mod2_out => sig_mod2);

  m3 : mod3 port map (
    mod3_eb  => exbig,
    mod3_ed  => exdif,
    mod3_fbc => frcbgchan,
    mod3_fsc => frcsmchan,
    mod3_ea  => exans3,
    mod3_fa  => frcans3);

  m42 : mod42 port map (
    mod42_eb  => exbig,
    mod42_ed  => exdif,
    mod42_fs  => frcsmall,
    mod42_fbc => frcbgchan,
    mod42_fsc => frcsmchan,
    mod42_ea  => exans4,
    mod42_fa  => frcans4);

  sgnans    <= sgnbig;
  exdif     <= exbig - exsmall when (exbig > 0 and exsmall > 0) else
               exbig - exsmall - 1;
  frcbgchan <= "1"&frcbig;
  frcsmchan <= "0"&frcsmall when (exsmall = 0) else
               "1"&frcsmall;

  exans  <= exans3 when (sgnbig = sgnsmall) else
            exans4;
  frcans <= frcans3 when (sgnbig = sgnsmall) else
            frcans4;

  fadd_out <= sig_mod1 when (exbig = x"ff") else
              big when (small(30 downto 0) = 0) else
              sig_mod2 when (exbig = 0 and exsmall = 0) else
              ans0;

end faddchan;
