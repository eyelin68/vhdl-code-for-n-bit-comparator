library IEEE;
use IEEE.std_logic_1164.all;


entity comparator_VHDL is
    generic (n: positive := 4);
    port (
        A, B: in std_logic_vector(n-1 downto 0);
        A_less_B, A_equal_B, A_greater_B: out std_logic
    );
end comparator_VHDL;

architecture comparator_structural of comparator_VHDL is
    signal less, equal, greater: std_logic := '0';
begin
    process(A, B)
    begin
        less <= '0';
        equal <= '0';
        greater <= '0';

        for i in A'RANGE loop
		if (not(not (A(i) nand B(i)))) = '1' then
		less<='1';
		equal<='0';
		greater<='0';
		else 
		less<='0';
            --less <= less or ((not A(i)) and B(i)) ;
		end if;
		if ( A(i) xnor B(i)) = '1' then
		equal <= '1';
		greater<='0';
		less<='0';
		else 
		equal<='0';
		end if;
            --equal <= equal and   ( A(i) xnor B(i)) ;
		if (A(i) and not B(i)) = '1' then 
		greater<='1';
		equal<='0';
		less<='0';
		else 
		greater<='0';
		end if;
            --greater <= greater or (A(i) and not B(i));
        end loop;
    end process;

        A_less_B <=less;
        A_equal_B <=equal;
        A_greater_B <= greater;
	
end comparator_structural;