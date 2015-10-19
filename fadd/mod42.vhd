library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mod42 is -- controls (the second half of) the subtraction part
  port (
    mod42_eb : in std_logic_vector (7 downto 0); -- exbig
    mod42_ed : in std_logic_vector (7 downto 0); -- exdif
    mod42_fs : in std_logic_vector (22 downto 0); -- frcsmall
    mod42_fbc, mod42_fsc : in std_logic_vector (23 downto 0); -- frcbgchan, frcsmchan
    mod42_ea : out std_logic_vector (7 downto 0);   -- exans
    mod42_fa : out std_logic_vector (22 downto 0)); -- frcans
end mod42;

architecture mod42chan of mod42 is
  signal frcsum, frcsum1, frcsum2, frcsum3, frcsum4 : std_logic_vector (23 downto 0);
  signal flagv : std_logic_vector (0 downto 0);
  signal rsign, rsign1 : std_logic_vector (23 downto 0);
  signal shiftamt: std_logic_vector (4 downto 0); -- i;
  signal amt0 : std_logic_vector (4 downto 0);
  signal sig0, sig1, sig2, sig3, sig4 : std_logic_vector (23 downto 0);
  signal sig_ea, sig_ea1 : std_logic_vector (7 downto 0);

  component mysll
  port (
    sllin  : in  std_logic_vector (23 downto 0);
    sllamt : in  std_logic_vector (4 downto 0);
    sllout : out std_logic_vector (23 downto 0));
  end component;

  component lshifter
  port (
    lshifter_ea : in std_logic_vector (7 downto 0);
    lshifterin  : in  std_logic_vector (23 downto 0);
    lshifterout : out std_logic_vector (23 downto 0);
    lshiftamt   : out std_logic_vector (4 downto 0));
  end component;

  component mod41 -- controls (the first half of) the subtraction part
  port (
    mod41_eb : in std_logic_vector (7 downto 0); -- exbig
    mod41_ed : in std_logic_vector (7 downto 0); -- exdif
    mod41_fbc, mod41_fsc : in std_logic_vector (23 downto 0); -- frcbgchan, frcsmchan
    mod41_ea : out std_logic_vector (7 downto 0);   -- exans
    mod41_fsum : out std_logic_vector (23 downto 0)); -- frcsum... not frcans (passed to mod42)
  end component;

begin
  m41 : mod41 port map (
    mod41_eb   => mod42_eb,
    mod41_ed   => mod42_ed,
    mod41_fbc  => mod42_fbc,
    mod41_fsc  => mod42_fsc,
    mod41_ea   => sig_ea,
    mod41_fsum => frcsum);

  u0 : lshifter port map (
    lshifter_ea => sig_ea,
    lshifterin  => frcsum,
    lshifterout => frcsum1,
    lshiftamt   => shiftamt);

  u1 : mysll port map (
    sllin  => x"000001",
    sllamt => amt0,
    sllout => sig0);

  sig_ea1 <= sig_ea - ("000"&shiftamt);

  frcsum2 <= "1"&frcsum1(23 downto 1) when (sig_ea1 = 0) else
             frcsum1;

  amt0    <= shiftamt-1 when (sig_ea1 > 0) else
             shiftamt-2;
  frcsum3 <= frcsum2 - sig0;
  frcsum4 <= frcsum3(22 downto 0)&"0" when (sig_ea1 > 1 and frcsum3(23 downto 23) = 0) else
             "1"&frcsum3(22 downto 0) when (sig_ea1 = 1 and frcsum3(23 downto 23) = 0) else
             frcsum3;

  mod42_ea <= sig_ea1-1 when (shiftamt > 0 and mod42_ed = 1 and mod42_fs(0 downto 0) = 1 and sig_ea1 > 0 and frcsum3(23 downto 23) = 0) else
              sig_ea1;

  mod42_fa <= frcsum4(22 downto 0) when (shiftamt > 0 and mod42_ed = 1 and mod42_fs(0 downto 0) = 1) else
              frcsum2(22 downto 0) - 1 when (shiftamt = 0 and mod42_ed = 1 and frcsum2(0 downto 0) = 1 and mod42_fs(0 downto 0) = 1) else
              frcsum2(22 downto 0);
end mod42chan;
