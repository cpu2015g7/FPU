library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity finv is
  port (
    finv_in : in std_logic_vector (31 downto 0);
    finv_out : out std_logic_vector (31 downto 0));
end finv;

architecture finvchan of finv is
  signal exman, exman_out : std_logic_vector (30 downto 0);
  signal ex, ex_out : std_logic_vector (7 downto 0);
  signal man, man_udf : std_logic_vector (22 downto 0);
  signal man_geta : std_logic_vector (24 downto 0);
  signal cat : std_logic_vector (53 downto 0); -- exman_out & man_geta(22 downto 0);
  
  signal cat0 : std_logic_vector (22 downto 0);
  signal cat1, cat2, cat3, cat4, cat5, cat6, cat7, cat8, cat9, cat10, cat11, cat12, cat13, cat14, cat15, cat16, cat17, cat18, cat19, cat20, cat21, cat22, cat23 : std_logic_vector (25 downto 0);
  signal man0, man1, man2, man3, man4, man5, man6, man7, man8, man9, man10, man11, man12, man13, man14, man15, man16, man17, man18, man19, man20, man21, man22, man23 : std_logic_vector (24 downto 0);
  signal maninv21 : std_logic_vector (20 downto 0);
  signal maninv22 : std_logic_vector (21 downto 0);
  signal maninv23 : std_logic_vector (22 downto 0);
  signal maninv_sub0, maninv_sub1, maninv_norm : std_logic_vector (22 downto 0);
  constant zero23 : std_logic_vector (22 downto 0) := (others => '0');
  constant pow22 : std_logic_vector (22 downto 0) := (22 => '1', others => '0');

begin
  finv_out(31) <= finv_in(31);
  exman <= finv_in(30 downto 0);
  ex <= finv_in(30 downto 23);
  man <= finv_in(22 downto 0);
  
  man_geta(24) <= '0';
  man_geta(23) <= '1';
  man_geta(22 downto 0) <= cat(22 downto 0);

  cat0 <= 0 - man_geta(22 downto 0);
  man0 <= '0' & cat0 & '0';
  cat1 <= (man0 - man_geta) & '1' when man0 >= man_geta else
          man0 & '0';
  man1 <= cat1(24 downto 1) & '0';
  cat2 <= (man1 - man_geta) & '1' when man1 >= man_geta else
          man1 & '0';
  man2 <= cat2(24 downto 1) & '0';
  cat3 <= (man2 - man_geta) & '1' when man2 >= man_geta else
          man2 & '0';
  man3 <= cat3(24 downto 1) & '0';
  cat4 <= (man3 - man_geta) & '1' when man3 >= man_geta else
          man3 & '0';
  man4 <= cat4(24 downto 1) & '0';
  cat5 <= (man4 - man_geta) & '1' when man4 >= man_geta else
          man4 & '0';
  man5 <= cat5(24 downto 1) & '0';
  cat6 <= (man5 - man_geta) & '1' when man5 >= man_geta else
          man5 & '0';
  man6 <= cat6(24 downto 1) & '0';
  cat7 <= (man6 - man_geta) & '1' when man6 >= man_geta else
          man6 & '0';
  man7 <= cat7(24 downto 1) & '0';
  cat8 <= (man7 - man_geta) & '1' when man7 >= man_geta else
          man7 & '0';
  man8 <= cat8(24 downto 1) & '0';
  cat9 <= (man8 - man_geta) & '1' when man8 >= man_geta else
          man8 & '0';
  man9 <= cat9(24 downto 1) & '0';
  cat10 <= (man9 - man_geta) & '1' when man9 >= man_geta else
           man9 & '0';
  man10 <= cat10(24 downto 1) & '0';
  cat11 <= (man10 - man_geta) & '1' when man10 >= man_geta else
           man10 & '0';
  man11 <= cat11(24 downto 1) & '0';
  cat12 <= (man11 - man_geta) & '1' when man11 >= man_geta else
           man11 & '0';
  man12 <= cat12(24 downto 1) & '0';
  cat13 <= (man12 - man_geta) & '1' when man12 >= man_geta else
           man12 & '0';
  man13 <= cat13(24 downto 1) & '0';
  cat14 <= (man13 - man_geta) & '1' when man13 >= man_geta else
           man13 & '0';
  man14 <= cat14(24 downto 1) & '0';
  cat15 <= (man14 - man_geta) & '1' when man14 >= man_geta else
           man14 & '0';
  man15 <= cat15(24 downto 1) & '0';
  cat16 <= (man15 - man_geta) & '1' when man15 >= man_geta else
           man15 & '0';
  man16 <= cat16(24 downto 1) & '0';
  cat17 <= (man16 - man_geta) & '1' when man16 >= man_geta else
           man16 & '0';
  man17 <= cat17(24 downto 1) & '0';
  cat18 <= (man17 - man_geta) & '1' when man17 >= man_geta else
           man17 & '0';
  man18 <= cat18(24 downto 1) & '0';
  cat19 <= (man18 - man_geta) & '1' when man18 >= man_geta else
           man18 & '0';
  man19 <= cat19(24 downto 1) & '0';
  cat20 <= (man19 - man_geta) & '1' when man19 >= man_geta else
           man19 & '0';
  man20 <= cat20(24 downto 1) & '0';
  cat21 <= (man20 - man_geta) & '1' when man20 >= man_geta else
           man20 & '0';
  man21 <= cat21(24 downto 1) & '0';
  cat22 <= (man21 - man_geta) & '1' when man21 >= man_geta else
           man21 & '0';
  man22 <= cat22(24 downto 1) & '0';
  cat23 <= (man22 - man_geta) & '1' when man22 >= man_geta else
           man22 & '0';
  man23 <= cat23(24 downto 1) & '0';
  
  maninv21(20) <= cat1(0);
  maninv21(19) <= cat2(0);
  maninv21(18) <= cat3(0);
  maninv21(17) <= cat4(0);
  maninv21(16) <= cat5(0);
  maninv21(15) <= cat6(0);
  maninv21(14) <= cat7(0);
  maninv21(13) <= cat8(0);
  maninv21(12) <= cat9(0);
  maninv21(11) <= cat10(0);
  maninv21(10) <= cat11(0);
  maninv21(9) <= cat12(0);
  maninv21(8) <= cat13(0);
  maninv21(7) <= cat14(0);
  maninv21(6) <= cat15(0);
  maninv21(5) <= cat16(0);
  maninv21(4) <= cat17(0);
  maninv21(3) <= cat18(0);
  maninv21(2) <= cat19(0);
  maninv21(1) <= cat20(0);
  maninv21(0) <= cat21(0);
  maninv22 <= maninv21 & cat22(0);
  maninv23 <= maninv22 & cat23(0);
  
  maninv_sub0(22) <= '0';
  maninv_sub0(21) <= '1';
  maninv_sub0(20 downto 0) <= maninv21 + 1 when maninv22(0) = '1' and (maninv21(0) = '1' or man21 > man_geta) else
                              maninv21;
  maninv_sub1(22) <= '1';
  maninv_sub1(21 downto 0) <= maninv22 + 1 when maninv23(0) = '1' and (maninv22(0) = '1' or man22 > man_geta) else
                              maninv22;
  maninv_norm <= maninv23 + 1 when (maninv23(0) = '1' and man23 = man_geta) or man23 > man_geta else
                 maninv23;
  
  ex_out <= x"fd" - ex;
  exman_out <= (ex_out+1) & zero23 when man = zero23 else
               ex_out & maninv_norm;
  man_udf <= maninv_sub1 when exman < (x"fe" & zero23) else
             pow22 when exman = (x"fe" & zero23) else
             maninv_sub0;
  
  cat <= x"ff" & zero23 & zero23 when exman <= (x"00" & "010" & x"00000") else
         x"fe" & maninv_norm & man(20 downto 0) & "00" when exman < (x"00" & pow22) else
         x"fe" & zero23 & zero23 when exman = (x"00" & pow22) else
         x"fd" & maninv_norm & man(21 downto 0) & "0" when exman < (x"01" & zero23) else
         exman_out & man when exman <= (x"fd" & zero23) else
         x"00" & man_udf & man when exman < (x"ff" & zero23) else
         x"00" & zero23 & zero23 when man = zero23 else
         x"ff" & '1' & man(21 downto 0) & zero23;
  finv_out(30 downto 0) <= cat(53 downto 23);
end finvchan;
