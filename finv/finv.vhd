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
  signal cat1, cat2, cat3, cat4, cat5, cat6, cat7, cat8, cat9, cat10, cat11, cat12, cat13, cat14, cat15, cat16, cat17, cat18, cat19, cat20, cat21, cat22, cat23 : std_logic_vector (24 downto 0); -- not cat but man...
  signal man0, man1, man2, man3, man4, man5, man6, man7, man8, man9, man10, man11, man12, man13, man14, man15, man16, man17, man18, man19, man20, man21, man22, man23 : std_logic_vector (24 downto 0);
  signal mns0, mns1, mns2, mns3, mns4, mns5, mns6, mns7, mns8, mns9, mns10, mns11, mns12, mns13, mns14, mns15, mns16, mns17, mns18, mns19, mns20, mns21, mns22 : std_logic_vector (24 downto 0);
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

  cat0 <= not man_geta(22 downto 0) + 1;
  man0 <= '0' & cat0 & '0';
  mns0 <= man0 - man_geta;
  cat1 <= mns0 when mns0(24) = '0' else
          man0;
  man1 <= cat1(23 downto 0) & '0';
  mns1 <= man1 - man_geta;
  cat2 <= mns1 when mns1(24) = '0' else
          man1;
  man2 <= cat2(23 downto 0) & '0';
  mns2 <= man2 - man_geta;
  cat3 <= mns2 when mns2(24) = '0' else
          man2;
  man3 <= cat3(23 downto 0) & '0';
  mns3 <= man3 - man_geta;
  cat4 <= mns3 when mns3(24) = '0' else
          man3;
  man4 <= cat4(23 downto 0) & '0';
  mns4 <= man4 - man_geta;
  cat5 <= mns4 when mns4(24) = '0' else
          man4;
  man5 <= cat5(23 downto 0) & '0';
  mns5 <= man5 - man_geta;
  cat6 <= mns5 when mns5(24) = '0' else
          man5;
  man6 <= cat6(23 downto 0) & '0';
  mns6 <= man6 - man_geta;
  cat7 <= mns6 when mns6(24) = '0' else
          man6;
  man7 <= cat7(23 downto 0) & '0';
  mns7 <= man7 - man_geta;
  cat8 <= mns7 when mns7(24) = '0' else
          man7;
  man8 <= cat8(23 downto 0) & '0';
  mns8 <= man8 - man_geta;
  cat9 <= mns8 when mns8(24) = '0' else
          man8;
  man9 <= cat9(23 downto 0) & '0';
  mns9 <= man9 - man_geta;
  cat10 <= mns9 when mns9(24) = '0' else
           man9;
  man10 <= cat10(23 downto 0) & '0';
  mns10 <= man10 - man_geta;
  cat11 <= mns10 when mns10(24) = '0' else
           man10;
  man11 <= cat11(23 downto 0) & '0';
  mns11 <= man11 - man_geta;
  cat12 <= mns11 when mns11(24) = '0' else
           man11;
  man12 <= cat12(23 downto 0) & '0';
  mns12 <= man12 - man_geta;
  cat13 <= mns12 when mns12(24) = '0' else
           man12;
  man13 <= cat13(23 downto 0) & '0';
  mns13 <= man13 - man_geta;
  cat14 <= mns13 when mns13(24) = '0' else
           man13;
  man14 <= cat14(23 downto 0) & '0';
  mns14 <= man14 - man_geta;
  cat15 <= mns14 when mns14(24) = '0' else
           man14;
  man15 <= cat15(23 downto 0) & '0';
  mns15 <= man15 - man_geta;
  cat16 <= mns15 when mns15(24) = '0' else
           man15;
  man16 <= cat16(23 downto 0) & '0';
  mns16 <= man16 - man_geta;
  cat17 <= mns16 when mns16(24) = '0' else
           man16;
  man17 <= cat17(23 downto 0) & '0';
  mns17 <= man17 - man_geta;
  cat18 <= mns17 when mns17(24) = '0' else
           man17;
  man18 <= cat18(23 downto 0) & '0';
  mns18 <= man18 - man_geta;
  cat19 <= mns18 when mns18(24) = '0' else
           man18;
  man19 <= cat19(23 downto 0) & '0';
  mns19 <= man19 - man_geta;
  cat20 <= mns19 when mns19(24) = '0' else
           man19;
  man20 <= cat20(23 downto 0) & '0';
  mns20 <= man20 - man_geta;
  cat21 <= mns20 when mns20(24) = '0' else
           man20;
  man21 <= cat21(23 downto 0) & '0';
  mns21 <= man21 - man_geta;
  cat22 <= mns21 when mns21(24) = '0' else
           man21;
  man22 <= cat22(23 downto 0) & '0';
  mns22 <= man22 - man_geta;
  cat23 <= mns22 when mns22(24) = '0' else
           man22;
  man23 <= cat23(23 downto 0) & '0';
  
  maninv21(20) <= not mns0(24);
  maninv21(19) <= not mns1(24);
  maninv21(18) <= not mns2(24);
  maninv21(17) <= not mns3(24);
  maninv21(16) <= not mns4(24);
  maninv21(15) <= not mns5(24);
  maninv21(14) <= not mns6(24);
  maninv21(13) <= not mns7(24);
  maninv21(12) <= not mns8(24);
  maninv21(11) <= not mns9(24);
  maninv21(10) <= not mns10(24);
  maninv21(9) <= not mns11(24);
  maninv21(8) <= not mns12(24);
  maninv21(7) <= not mns13(24);
  maninv21(6) <= not mns14(24);
  maninv21(5) <= not mns15(24);
  maninv21(4) <= not mns16(24);
  maninv21(3) <= not mns17(24);
  maninv21(2) <= not mns18(24);
  maninv21(1) <= not mns19(24);
  maninv21(0) <= not mns20(24);
  maninv22 <= maninv21 & (not mns21(24));
  maninv23 <= maninv22 & (not mns22(24));
  
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
