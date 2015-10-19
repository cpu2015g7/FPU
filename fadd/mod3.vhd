library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mod3 is -- controls the addition part
  port (
    mod3_eb : in std_logic_vector (7 downto 0); -- exbig
    mod3_ed : in std_logic_vector (7 downto 0); -- exdif
    mod3_fbc, mod3_fsc : in std_logic_vector (23 downto 0); -- frcbgchan, frcsmchan
    mod3_ea : out std_logic_vector (7 downto 0);   -- exans
    mod3_fa : out std_logic_vector (22 downto 0)); -- frcans
end mod3;

architecture mod3chan of mod3 is
  signal frcsum : std_logic_vector (24 downto 0);
  signal frcsum1, frcsum3 : std_logic_vector (23 downto 0);
  signal frcsum2 : std_logic_vector (24 downto 0);
  signal flagv : std_logic_vector (0 downto 0);
  signal rsign : std_logic_vector (24 downto 0);
  signal amt, amt1 : std_logic_vector (4 downto 0);
  signal sig0, sig1, sig2, sig3, sig4 : std_logic_vector (23 downto 0);
  signal sig_ea : std_logic_vector (7 downto 0);

  component mysll port (
    sllin  : in  std_logic_vector (23 downto 0);
    sllamt : in  std_logic_vector (4 downto 0);
    sllout : out std_logic_vector (23 downto 0));
  end component;

  component mysrl
  port (
    srlin  : in  std_logic_vector (23 downto 0);
    srlamt : in  std_logic_vector (4 downto 0);
    srlout : out std_logic_vector (23 downto 0));
  end component;

begin
  u0 : mysrl port map (
    srlin  => mod3_fsc,
    srlamt => amt,
    srlout => sig0);

  u1 : mysll port map (
    sllin  => sig0,
    sllamt => amt,
    sllout => sig1);

  u2 : mysll port map (
    sllin  => sig2,
    sllamt => amt,
    sllout => sig3);

  u3 : mysll port map (
    sllin  => x"000001",
    sllamt => amt1,
    sllout => sig4);

  amt <= mod3_ed(4 downto 0) when (mod3_ed < 24) else "11000";

  frcsum  <= ("0"&mod3_fbc) + ("0"&sig0);
  flagv   <= frcsum(24 downto 24);
  sig_ea  <= mod3_eb + flagv;

  sig2    <= "000" & x"00000" & (frcsum(0 downto 0) and flagv);
  amt1    <= amt + ("0000"&flagv) - 1;

  rsign   <= "1"&x"000000" + mod3_fsc - sig1 + sig3 - sig4;
  frcsum1 <= frcsum(23 downto 0) when (flagv = "0") else
             frcsum(24 downto 1);
  frcsum2 <= "0"&frcsum1 + 1 when (rsign > "1"&x"000000" or (rsign = "1"&x"000000" and frcsum1(0 downto 0) = 1)) else
             "0"&frcsum1;

  frcsum3 <= frcsum2(23 downto 0) when ((mod3_ed > 0 or flagv > 0) and mod3_ed < 25) else
             frcsum1;

  mod3_ea <= sig_ea+1 when ((mod3_ed > 0 or flagv > 0) and mod3_ed < 25 and frcsum2(24 downto 24) = 1) else
             sig_ea;

  mod3_fa <= "000" & x"00000" when (sig_ea = x"ff") else
             frcsum3(22 downto 0);
end mod3chan;
