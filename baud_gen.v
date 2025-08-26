
module baud_gen(
    input clk,
    input reset,
    output reg bclk
);

    parameter baud_rate   = 921600;
    parameter over_sample = 16;
    parameter clk_freq    = 100_000_000;

    // Calculate divisor: clk_freq / (baud_rate * over_sample)
    localparam integer divisor = clk_freq / (baud_rate * over_sample);

    reg [15:0] counter;

    always @(posedge clk) begin
        if (reset) begin
            counter <= 0;
            bclk <= 0;
        end else if (counter == divisor - 1) begin
            bclk <= 1;
            counter <= 0;
        end else begin
            bclk <= 0;
            counter <= counter + 1;
        end
    end
endmodule








/////////////////////////////////////////////////////

/*module baud_gen(clk,reset,blck);

parameter baud_rate=921600;
parameter over_sample=16;
parameter clk_freq=100*(10**6);
parameter final_value=((clk_frq)/(baud_rate*oversample))+0.5;

input clk,reset;
output reg bclk;

wire [15:0]divisor;
wire [15:0]counter;

assign divisor=final_value;

always@(posedge clk)
begin
        if(reset)
        begin
            bclk<=0;
            counter<=0;
        end
        else if (counter==(divisor-1))
        begin
               bclk<=1;
               counter<=0;
       end
       else
       begin
                bclk<=0;
                counter<=counter+1;
       end
end
endmodule*/
