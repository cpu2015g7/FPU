library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity fmul is
  port (
    fmul_in0, fmul_in1 : in std_logic_vector (31 downto 0);
    fmul_out : out std_logic_vector (31 downto 0));
end fmul;

architecture fmulchan of fmul is
  signal ex_in0, ex_in1, ex_bg, ex_sm : std_logic_vector (7 downto 0);
  signal man_in0, man_in1, man_bg, man_sm : std_logic_vector (22 downto 0);
  constant zero23 : std_logic_vector (22 downto 0) := (others => '0');
  
  signal cat0 : std_logic_vector (63 downto 0); -- bg & sm
  signal bg, sm : std_logic_vector (31 downto 0);
  signal sgn_out : std_logic;
  
  component lshifter
  port (
    ex_bg : in std_logic_vector (7 downto 0);
    man_bg, man_sm : in std_logic_vector (22 downto 0);
    cat_ls : out std_logic_vector (54 downto 0));
  end component;
  
  signal cat1 : std_logic_vector (56 downto 0); -- ex0 & manprd0
  signal cat_ls : std_logic_vector (54 downto 0);
  signal ex0 : std_logic_vector (8 downto 0);
  signal manprd0 : std_logic_vector (47 downto 0);
  
  signal cat2 : std_logic_vector (56 downto 0); -- carrysign & ex1 & manprd1
  signal carrysign : std_logic := '0';
  signal ex1 : std_logic_vector (8 downto 0);
  signal manprd1 : std_logic_vector (46 downto 0);
  
  component mysrl
  port (
    shift : in std_logic_vector (5 downto 0);
    manprd1 : in std_logic_vector (46 downto 0);
    mansub0 : out std_logic_vector (23 downto 0));
  end component;
  
  component downto0
  port (
    shift : in std_logic_vector (5 downto 0);
    manprd1 : in std_logic_vector (46 downto 0);
    mancut : out std_logic_vector (46 downto 0));
  end component;
  
  signal shift0 : std_logic_vector (6 downto 0);  
  signal shift : std_logic_vector (5 downto 0);
  signal mansub0 : std_logic_vector (23 downto 0);
  signal mansub1 : std_logic_vector (22 downto 0);
  signal mancut : std_logic_vector (46 downto 0);
  
  signal ex20 : std_logic_vector (8 downto 0); 
  signal ex2 : std_logic_vector (7 downto 0);
  
  signal out0, out00, out01 : std_logic_vector (31 downto 0);
  signal fmul_exman_out, exman_out0, exman_out00, exman_out1, exman_out10 : std_logic_vector (30 downto 0);

begin
  cat0 <= fmul_in0 & fmul_in1 when fmul_in0(30 downto 0) > fmul_in1(30 downto 0) else
         fmul_in1 & fmul_in0;
  bg <= cat0(63 downto 32);
  sm <= cat0(31 downto 0);
  
  ex_in0 <= fmul_in0(30 downto 23);
  ex_in1 <= fmul_in1(30 downto 23);
  ex_bg <= bg(30 downto 23);
  ex_sm <= sm(30 downto 23);
  man_in0 <= fmul_in0(22 downto 0);
  man_in1 <= fmul_in1(22 downto 0);
  man_bg <= bg(22 downto 0);
  man_sm <= sm(22 downto 0);
  
  sgn_out <= fmul_in0(31) xor fmul_in1(31);
  
  out00 <= fmul_in1(31 downto 23) & '1' & fmul_in1(21 downto 0) when ex_sm = x"ff" and man_sm > 0 else
           bg(31 downto 23) & '1' & bg(21 downto 0);
  out01 <= sgn_out & x"ff" & zero23 when ex_sm & man_sm > 0 else
           x"ffc00000";
  out0  <= out00 when man_bg > 0 else
           out01;
  
  
  lshifterchan : lshifter port map (
    ex_bg => ex_bg,
    man_bg => man_bg,
    man_sm => man_sm,
    cat_ls => cat_ls);  
  cat1 <= (('0' & ex_in0) + ('0' & ex_in1)) & (('1' & man_in0) * ('1' & man_in1)) when ex_sm > 0 else
          '0' & cat_ls(54 downto 47) & '0' & cat_ls(46 downto 0);
  ex0 <= cat1(56 downto 48);
  manprd0 <= cat1(47 downto 0);
  
  cat2 <= manprd0(0) & (ex0 + 1) & manprd0(47 downto 1) when manprd0(47) = '1' else
          '0' & ex0 & manprd0(46 downto 0);
  carrysign <= cat2(56);
  ex1 <= cat2(55 downto 47);
  manprd1 <= cat2(46 downto 0);
  
  
  shift0 <= 55 - ("00" & ex1(4 downto 0));
  shift <= shift0(5 downto 0);  -- from 24 to 47
  mysrlchan : mysrl port map (
    shift => shift,
    manprd1 => manprd1,
    mansub0 => mansub0);
  mansub1 <= mansub0(23 downto 1);
  downto0chan : downto0 port map (
    shift => shift,
    manprd1 => manprd1,
    mancut => mancut);
  exman_out00 <= x"01" & zero23 when mansub1 = "111" & x"fffff" else
                 x"00" & (mansub1 + 1);
  exman_out0 <= exman_out00 when (mansub0(0) = '1' and (mancut > 0 or carrysign = '1' or mansub1(0) = '1')) else
                x"00" & mansub1;
  
  
  ex20 <= ex1 - 127;
  ex2 <= ex20(7 downto 0);
  exman_out10 <= (ex2 + 1) & zero23 when manprd1(45 downto 23) = x"ffffff" else
                 ex2 & (manprd1(45 downto 23) + 1);
  exman_out1 <= exman_out10 when (manprd1(22) = '1' and (manprd1(21 downto 0) > 0 or carrysign = '1' or manprd1(23) = '1')) else
                ex2 & manprd1(45 downto 23);
  
  
  fmul_out <= out0 when ex_bg = x"ff" else
              sgn_out & fmul_exman_out;
  
  fmul_exman_out <= (others => '0') when ex_sm & man_sm = 0 or ex1 < 104 else
                    exman_out0 when ex1 < 128 else
                    exman_out1 when ex1 < 382 else
                    x"ff" & zero23;
end fmulchan;
