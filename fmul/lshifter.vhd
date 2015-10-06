library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity lshifter is
  port (
    ex_bg : in std_logic_vector (7 downto 0);
    man_bg, man_sm : in std_logic_vector (22 downto 0);
    cat_ls : out std_logic_vector (54 downto 0));
end lshifter;

architecture lshifterchan of lshifter is
  signal manprd0 : std_logic_vector (46 downto 0);
begin
  manprd0 <= ('1' & man_bg) * man_sm;
  
  cat_ls <= (ex_bg+ 1) & manprd0                    when manprd0(46) = '1'                  else
             ex_bg     & manprd0 (45 downto 0) & "0" when manprd0(45) = '1' or ex_bg = x"00" else
            (ex_bg- 1) & manprd0 (44 downto 0) & "00" when manprd0(44) = '1' or ex_bg = x"01" else
            (ex_bg- 2) & manprd0 (43 downto 0) & "000" when manprd0(43) = '1' or ex_bg = x"02" else
            (ex_bg- 3) & manprd0 (42 downto 0) & "0000" when manprd0(42) = '1' or ex_bg = x"03" else
            (ex_bg- 4) & manprd0 (41 downto 0) & "00000" when manprd0(41) = '1' or ex_bg = x"04" else
            (ex_bg- 5) & manprd0 (40 downto 0) & "000000" when manprd0(40) = '1' or ex_bg = x"05" else
            (ex_bg- 6) & manprd0 (39 downto 0) & "0000000" when manprd0(39) = '1' or ex_bg = x"06" else
            (ex_bg- 7) & manprd0 (38 downto 0) & "00000000" when manprd0(38) = '1' or ex_bg = x"07" else
            (ex_bg- 8) & manprd0 (37 downto 0) & "000000000" when manprd0(37) = '1' or ex_bg = x"08" else
            (ex_bg- 9) & manprd0 (36 downto 0) & "0000000000" when manprd0(36) = '1' or ex_bg = x"09" else
            (ex_bg-10) & manprd0 (35 downto 0) & "00000000000" when manprd0(35) = '1' or ex_bg = x"0a" else
            (ex_bg-11) & manprd0 (34 downto 0) & "000000000000" when manprd0(34) = '1' or ex_bg = x"0b" else
            (ex_bg-12) & manprd0 (33 downto 0) & "0000000000000" when manprd0(33) = '1' or ex_bg = x"0c" else
            (ex_bg-13) & manprd0 (32 downto 0) & "00000000000000" when manprd0(32) = '1' or ex_bg = x"0d" else
            (ex_bg-14) & manprd0 (31 downto 0) & "000000000000000" when manprd0(31) = '1' or ex_bg = x"0e" else
            (ex_bg-15) & manprd0 (30 downto 0) & "0000000000000000" when manprd0(30) = '1' or ex_bg = x"0f" else
            (ex_bg-16) & manprd0 (29 downto 0) & "00000000000000000" when manprd0(29) = '1' or ex_bg = x"10" else
            (ex_bg-17) & manprd0 (28 downto 0) & "000000000000000000" when manprd0(28) = '1' or ex_bg = x"11" else
            (ex_bg-18) & manprd0 (27 downto 0) & "0000000000000000000" when manprd0(27) = '1' or ex_bg = x"12" else
            (ex_bg-19) & manprd0 (26 downto 0) & "00000000000000000000" when manprd0(26) = '1' or ex_bg = x"13" else
            (ex_bg-20) & manprd0 (25 downto 0) & "000000000000000000000" when manprd0(25) = '1' or ex_bg = x"14" else
            (ex_bg-21) & manprd0 (24 downto 0) & "0000000000000000000000" when manprd0(24) = '1' or ex_bg = x"15" else
            (ex_bg-22) & manprd0 (23 downto 0) & "00000000000000000000000";
end lshifterchan;
