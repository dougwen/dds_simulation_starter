library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is 
end tb;

architecture test of tb is 

COMPONENT fakeadc_dds
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axis_phase_tvalid : IN STD_LOGIC;
    s_axis_phase_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    m_axis_data_tvalid : OUT STD_LOGIC;
    m_axis_data_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) 
  );
END COMPONENT;

signal aclk : std_Logic;
signal aresetn : std_logic := '0';
signal dds_out_valid : std_logic;
signal dds_out_data : std_Logic_Vector(15 downto 0);

begin

your_instance_name : fakeadc_dds
  PORT MAP (
    aclk => aclk,
    aresetn => aresetn,
    s_axis_phase_tvalid => '1',
    s_axis_phase_tdata => x"0100" ,  -- put your phase increment that you want to simulate with here
    m_axis_data_tvalid => dds_out_valid,
    m_axis_data_tdata => dds_out_data
  );
  
clkmaker : process
begin
   aclk <= '0';
   wait for 4 ns;
   aclk <= '1';
   wait for 4 ns;
end process clkmaker;
  
  
stim : process
begin
   wait for 1 us;
   aresetn <= '1';
   wait;
end process stim;  
  
end test;