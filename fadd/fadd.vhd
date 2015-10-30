library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity fadd is
  port (
    fadd_in0, fadd_in1 : in std_logic_vector (31 downto 0);
    fadd_out : out std_logic_vector (31 downto 0));
end fadd;

architecture faddchan of fadd is
  signal cat : std_logic_vector (62 downto 0);
  signal ex_bg, ex_sm : std_logic_vector (7 downto 0);
  signal man_bg, man_sm : std_logic_vector (22 downto 0);
  signal mode : std_logic;
  signal excp0 : std_logic_vector (22 downto 0);
  signal excp_out : std_logic_vector (23 downto 0);
  signal man_subsub : std_logic_vector (23 downto 0);
  signal man_geta_bg, man_geta_sm : std_logic_vector (23 downto 0);
  signal ex_diff : std_logic_vector (7 downto 0);
  signal man_sm_tmp4, man_sm_tmp3, man_sm_tmp2, man_sm_tmp1, man_smchan : std_logic_vector (26 downto 0);
  signal man_sum : std_logic_vector (24 downto 0);
  signal down : std_logic;
  signal man_sum_nmlz_n_carry : std_logic_vector (24 downto 0);
  signal carry : std_logic;
  signal ex_out0 : std_logic_vector (7 downto 0);
  signal man_out0 : std_logic_vector (22 downto 0);
  signal man_diffchan : std_logic_vector (24 downto 0);
  signal man_diff_tmp4, man_diff_tmp3, man_diff_tmp2, man_diff_tmp1, man_diff_tmp0 : std_logic_vector (25 downto 0);
  signal shift : std_logic_vector (4 downto 0);
  signal ex_out1 : std_logic_vector (7 downto 0);
  signal man_out1 : std_logic_vector (22 downto 0);
  signal exman_out : std_logic_vector (30 downto 0);
  constant zero7 : std_logic_vector (6 downto 0) := (others => '0');
  constant zero23 : std_logic_vector (22 downto 0) := (others => '0');
begin
  cat <= fadd_in0 & fadd_in1(30 downto 0) when fadd_in0(30 downto 0) > fadd_in1(30 downto 0) or ((fadd_in0(30 downto 0) = fadd_in1(30 downto 0)) and fadd_in0(31) < fadd_in1(31)) else
         fadd_in1 & fadd_in0(30 downto 0);
  ex_bg <= cat(61 downto 54);
  ex_sm <= cat(30 downto 23);
  man_bg <= cat(53 downto 31);
  man_sm <= cat(22 downto 0);
  mode <= fadd_in0(31) xor fadd_in1(31);
  
  excp0 <= fadd_in1(31) & fadd_in1(21 downto 0) when cat(30 downto 0) > (x"ff" & zero23) else
           cat(62) & cat(52 downto 31);
  excp_out <= excp0(22) & '1' & excp0(21 downto 0) when man_bg /= zero23 else
              (fadd_in0(31) or fadd_in1(31)) & mode & zero23(21 downto 0) when ex_sm = x"ff" else
              cat(62) & zero23;
  
  man_subsub <= ('0' & man_bg) + ('0' & man_sm) when mode = '0' else
                '0' & (man_bg - man_sm);
  
  man_geta_bg(23) <= ex_bg(7) or ex_bg(6) or ex_bg(5) or ex_bg(4) or ex_bg(3) or ex_bg(2) or ex_bg(1) or ex_bg(0);
  man_geta_bg(22 downto 0) <= man_bg;
  man_geta_sm(23) <= ex_sm(7) or ex_sm(6) or ex_sm(5) or ex_sm(4) or ex_sm(3) or ex_sm(2) or ex_sm(1) or ex_sm(0);
  man_geta_sm(22 downto 0) <= man_sm;
  ex_diff <= ex_bg - ex_sm - (zero7 & (not man_geta_sm(23)));
  
  man_sm_tmp4 <= x"0000" & man_geta_sm(23 downto 14) & (man_geta_sm(13) or man_geta_sm(12) or man_geta_sm(11) or man_geta_sm(10) or man_geta_sm(9) or man_geta_sm(8) or man_geta_sm(7) or man_geta_sm(6) or man_geta_sm(5) or man_geta_sm(4) or man_geta_sm(3) or man_geta_sm(2) or man_geta_sm(1) or man_geta_sm(0)) when ex_diff(4) = '1' else
                 man_geta_sm & "000";
  man_sm_tmp3 <= x"00" & man_sm_tmp4(26 downto 9) & (man_sm_tmp4(8) or man_sm_tmp4(7) or man_sm_tmp4(6) or man_sm_tmp4(5) or man_sm_tmp4(4) or man_sm_tmp4(3) or man_sm_tmp4(2) or man_sm_tmp4(1) or man_sm_tmp4(0)) when ex_diff(3) = '1' else
                 man_sm_tmp4;
  man_sm_tmp2 <= x"0" & man_sm_tmp3(26 downto 5) & (man_sm_tmp3(4) or man_sm_tmp3(3) or man_sm_tmp3(2) or man_sm_tmp3(1) or man_sm_tmp3(0)) when ex_diff(2) = '1' else
                 man_sm_tmp3;
  man_sm_tmp1 <= "00" & man_sm_tmp2(26 downto 3) & (man_sm_tmp2(2) or man_sm_tmp2(1) or man_sm_tmp2(0)) when ex_diff(1) = '1' else
                 man_sm_tmp2;
  man_smchan <= '0' & zero23 & "000" when ex_diff(7 downto 5) /= "000" else
                "0" & man_sm_tmp1(26 downto 2) & (man_sm_tmp1(1) or man_sm_tmp1(0)) when ex_diff(0) = '1' else
                man_sm_tmp1;
  man_sum <= ('0' & man_geta_bg) + ('0' & man_smchan(26 downto 3)) when mode = '0' else
             '0' & (man_geta_bg - man_smchan(26 downto 3));
  down <= (not man_sum(23)) or ((not (man_sum(22) or man_sum(21) or man_sum(20) or man_sum(19) or man_sum(18) or man_sum(17) or man_sum(16) or man_sum(15) or man_sum(14) or man_sum(13) or man_sum(12) or man_sum(11) or man_sum(10) or man_sum(9) or man_sum(8) or man_sum(7) or man_sum(6) or man_sum(5) or man_sum(4) or man_sum(3) or man_sum(2) or man_sum(1) or man_sum(0))) and man_smchan(1) and man_smchan(0));
  man_sum_nmlz_n_carry <= man_sum(23 downto 1) & (man_sum(0) & (man_smchan(2) or man_smchan(1) or man_smchan(0))) when man_sum(24) = '1' else
                          ((man_sum(21 downto 0) & '0') - (zero23(21 downto 0) & man_smchan(2))) & man_smchan(1 downto 0) when down = '1' else
                          man_sum(22 downto 0) & (man_smchan(2) & (man_smchan(1) or man_smchan(0)));
  carry <= man_sum_nmlz_n_carry(1) and (man_sum_nmlz_n_carry(2) or man_sum_nmlz_n_carry(0));
  ex_out0 <= ex_bg + (zero7 & ((not mode) and (man_sum(24) or (man_sum_nmlz_n_carry(23) and man_sum_nmlz_n_carry(22) and man_sum_nmlz_n_carry(21) and man_sum_nmlz_n_carry(20) and man_sum_nmlz_n_carry(19) and man_sum_nmlz_n_carry(18) and man_sum_nmlz_n_carry(17) and man_sum_nmlz_n_carry(16) and man_sum_nmlz_n_carry(15) and man_sum_nmlz_n_carry(14) and man_sum_nmlz_n_carry(13) and man_sum_nmlz_n_carry(12) and man_sum_nmlz_n_carry(11) and man_sum_nmlz_n_carry(10) and man_sum_nmlz_n_carry(9) and man_sum_nmlz_n_carry(8) and man_sum_nmlz_n_carry(7) and man_sum_nmlz_n_carry(6) and man_sum_nmlz_n_carry(5) and man_sum_nmlz_n_carry(4) and man_sum_nmlz_n_carry(3) and man_sum_nmlz_n_carry(2) and carry)))) - (zero7 & (mode and down));
  man_out0 <= zero23 when ex_out0 = x"ff" else
              man_sum_nmlz_n_carry(24 downto 2) + (zero7 & ((not mode) and carry)) - (zero7 & (mode and carry));

  man_diffchan <= (man_geta_bg - man_geta_sm) & '0' when ex_diff(0) = '0' else
                  (man_geta_bg & '0') - ('0' & man_geta_sm);
  man_diff_tmp4 <= man_diffchan(8 downto 0) & x"0000" & '1' when man_diffchan(24 downto 9) = x"0000" and ex_bg(7 downto 4) > ("000" & '0') else
                   man_diffchan & '0';
  man_diff_tmp3 <= man_diff_tmp4(17 downto 1) & x"00" & '1' when man_diff_tmp4(25 downto 18) = x"00" and ex_bg(7 downto 3) > ("000" & man_diff_tmp4(0) & '0') else
                   man_diff_tmp4(25 downto 1) & '0';
  man_diff_tmp2 <= man_diff_tmp3(21 downto 1) & x"0" & '1' when man_diff_tmp3(25 downto 22) = x"0" and ex_bg(7 downto 2) > ("000" & man_diff_tmp4(0) & man_diff_tmp3(0) & '0') else
                   man_diff_tmp3(25 downto 1) & '0';
  man_diff_tmp1 <= man_diff_tmp2(23 downto 1) & "00" & '1' when man_diff_tmp2(25 downto 24) = "00" and ex_bg(7 downto 1) > ("000" & man_diff_tmp4(0) & man_diff_tmp3(0) & man_diff_tmp2(0) & '0') else
                   man_diff_tmp2(25 downto 1) & '0';
  man_diff_tmp0 <= man_diff_tmp1(24 downto 1) & "0" & '1' when man_diff_tmp1(25 downto 25) = "0" and ex_bg(7 downto 0) > ("000" & man_diff_tmp4(0) & man_diff_tmp3(0) & man_diff_tmp2(0) & man_diff_tmp1(0) & '0') else
                   man_diff_tmp1(25 downto 1) & '0';
  shift(4 downto 3) <= man_diff_tmp4(0) & man_diff_tmp3(0);
  shift(2 downto 0) <= "000" when ((man_diff_tmp4(0) and man_diff_tmp3(0)) and (man_diff_tmp2(0) or man_diff_tmp1(0) or man_diff_tmp0(0))) = '1' else
                       man_diff_tmp2(0) & man_diff_tmp1(0) & man_diff_tmp0(0);
  ex_out1 <= x"00" when man_diff_tmp0(25 downto 1) = '0' & zero23 else 
             ex_bg - ("000" & shift);
  man_out1 <= man_diff_tmp0(25 downto 3) when ex_out1 = 0 else
              man_diff_tmp0(24 downto 2) + (zero23(21 downto 0) & (man_diffchan(24) and man_diffchan(1) and man_diffchan(0)));

  exman_out <= zero7 & man_subsub when (ex_bg & ex_sm) = x"0000" else
               ex_out0 & man_out0 when ex_diff(7 downto 1) /= zero7 or mode = '0' else
               ex_out1 & man_out1;
  fadd_out <= excp_out(23) & x"ff" & excp_out(22 downto 0) when ex_bg = x"ff" else
              cat(62) & exman_out;
end faddchan;
