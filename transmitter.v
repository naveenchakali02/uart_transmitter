module transmitter(bclk,reset,tx_start,tx_din,tx,tx_done_tk);

parameter over_sample=16;
parameter data_width=8;
parameter data_bits=$clog2(data_width);
parameter idel=0;
parameter start=1;
parameter data=2;
parameter stop=3;

input bclk,reset,tx_start;
input [data_width-1:0]tx_din;
output reg tx,tx_done_tk;
reg [1:0]current_state,next_state;
reg [data_width-1:0]shift_reg,shift_reg_value;
reg [3:0]tk_counter;
reg tk_counter_reset;
reg [data_bits-1:0]data_bits_counter,data_bits_counter_value;

always@(posedge bclk or posedge reset)
begin
    if(reset)
    begin
        current_state<=idel;
        tk_counter<=0;
        shift_reg<=0;
        data_bits_counter<=0;
        tx_done_tk <= 0; 
        end
        else
        begin
            current_state<=next_state;
            shift_reg<=shift_reg_value;
            data_bits_counter<=data_bits_counter+data_bits_counter_value;
        end
        if(tk_counter_reset)
            tk_counter<=0;
        else
               tk_counter<=tk_counter+1;
     end
     always@(*)
     begin
     case(current_state)
     idel:begin
            if(tx_start==1)
            begin
                    tx_done_tk=1;
                    next_state=start;
           end
           else
           begin
                next_state=idel;
                tx_done_tk=0;
          end
          tk_counter_reset=1;
          shift_reg_value=0;
          data_bits_counter_value=0;
          tx=1'b1;
     end
     start:begin
            
     endcase
end
endmodule
