library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mod41 is -- controls (the first half of) the subtraction part
  port (
    mod41_eb : in std_logic_vector (7 downto 0); -- exbig
    mod41_ed : in std_logic_vector (7 downto 0); -- exdif
    mod41_fbc, mod41_fsc : in std_logic_vector (23 downto 0); -- frcbgchan, frcsmchan
    mod41_ea : out std_logic_vector (7 downto 0);   -- exans
    mod41_fsum : out std_logic_vector (23 downto 0)); -- frcsum... not frcans (passed to mod42)
end mod41;

architecture mod41chan of mod41 is
  signal frcsum, frcsum1, frcsum2, frcsum3 : std_logic_vector (23 downto 0);
  signal flagv : std_logic_vector (0 downto 0);
  signal rsign : std_logic_vector (23 downto 0);
  signal rsign1 : std_logic_vector (24 downto 0);
  signal amt, amt1, amt2 : std_logic_vector (4 downto 0);
  signal sig0, sig1, sig2, sig3, sig4 : std_logic_vector (23 downto 0);

  component mysll
  port (
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
    srlin  => mod41_fsc,
    srlamt => amt,
    srlout => sig0);

  u1 : mysll port map (
    sllin  => sig0,
    sllamt => amt,
    sllout => sig1);

  u2 : mysrl port map (
    srlin  => rsign,
    srlamt => amt1,
    srlout => sig2);

  u3 : mysll port map (
    sllin  => sig2,
    sllamt => amt1,
    sllout => sig3);

  u4 : mysll port map (
    sllin  => x"000001",
    sllamt => amt2,
    sllout => sig4);


  amt     <= mod41_ed(4 downto 0) when (mod41_ed < 24) else "11000";
  frcsum  <= mod41_fbc - sig0;

  flagv   <= not frcsum(23 downto 23);
  rsign   <= mod41_fsc - sig1;
  frcsum1 <= frcsum when (flagv = 0) else
             frcsum(22 downto 0) & "0";
  amt1    <= amt - flagv;
  frcsum2 <= frcsum1 - sig2;
  amt2    <= amt1 - 1;
  rsign1  <= "1"&x"000000" + rsign - sig3 - sig4;
  frcsum3 <= frcsum2 - 1 when (rsign1 > "1"&x"000000" or (rsign1 = "1"&x"000000" and frcsum2(0 downto 0) = 1)) else
             frcsum2;

  mod41_ea   <= x"00" when (frcsum = 0) else
                mod41_eb - flagv when (1 < mod41_ed and mod41_ed < 25) else
                mod41_eb - 1 when (mod41_ed = "11001" and mod41_fsc > x"800000" and mod41_fbc = x"800000") else
                mod41_eb;

  mod41_fsum <= frcsum3 when (1<mod41_ed and mod41_ed<25) else
                x"ffffff" when (mod41_ed = "11001" and mod41_fsc > x"800000" and mod41_fbc = x"800000") else
                frcsum;

end mod41chan;
