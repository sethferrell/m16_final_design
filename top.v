/* module */
module top (hwclk, led1, led2, led3, led4, led5, led6, led7, led8, R1_but, R2_but, R3_but, C1_but_in, C2_but_in, C3_but_in, tp1, tp2, tp3, tp4, tp5, tp6);
    /* I/O */
    input hwclk;
    output R1_but, R2_but, R3_but; 
    input C1_but_in, C2_but_in, C3_but_in;
    
    output led1;
    output led2;
    output led3;
    output led4;
    output led5;
    output led6;
    output led7;
    output led8;

    output wire tp1, tp2, tp3, tp4, tp5, tp6;

    parameter HWCLK = 6_000_000;

    wire [1:0] led_cmd1, led_cmd2, led_cmd3;

    //led_handler LEDHDL1(hwclk, led_cmd1, btns, led1, led2, led3, led4, led5,
    //led6, led7, led8);
    /* Counter register */
    reg [2:0] counter = 2'b0;
    wire [31:0] pass;

    wire R1, R2, R3;
    wire C1, C2, C3;
    wire C1_but, C2_but, C3_but;

    wire [8:0] btns;
    wire change_uc, led1_0, led1_1, led2_0, led2_1, led3_0, led3_1, lock_tog;
    wire correct1, correct2, equal, valid, rst;
    wire [1:0] is_programming;

    fsm FSM1(tp1, tp2, tp3, tp4, tp5, correct1, correct2, equal, btns[6], btns[7], btns[8], valid, scan_clk, is_programming[0], is_programming[1], change_uc, led1_0, led1_1, led2_0, led2_1, led3_0, led3_1, lock_tog, rst);

    wire i, i2;
    code_input CODEINPUT(rst, scan_clk, correct1, btns, pass, i2); 
    pass_input PASSINPUT(rst, scan_clk, is_programming, correct2, valid, equal, pass, i);

    assign tp6 = i;

    assign {led1, led2} = {led1_1, led1_0};
    assign {led3, led4} = {led2_1, led2_0};
    assign {led5, led6} = {led3_1, led3_0};

    SB_IO #(
        .PIN_TYPE(6'b0110_01),
        .PULLUP(1'b1)
    ) keypad_r1_config (
        .PACKAGE_PIN(R1_but),
        .D_OUT_0(R1)
    );

    SB_IO #(
        .PIN_TYPE(6'b0110_01),
        .PULLUP(1'b1)
    ) keypad_r2_config (
        .PACKAGE_PIN(R2_but),
        .D_OUT_0(R2)
    );

    SB_IO #(
        .PIN_TYPE(6'b0110_01),
        .PULLUP(1'b1)
    ) keypad_r3_config (
        .PACKAGE_PIN(R3_but),
        .D_OUT_0(R3)
    );

    SB_IO #(
        .PIN_TYPE(6'b0000_01),
        .PULLUP(1'b1)
    ) keypad_c1_config (
        .PACKAGE_PIN(C1_but_in),
        .D_IN_0(C1_but)
    );

    SB_IO #(
        .PIN_TYPE(6'b0000_01),
        .PULLUP(1'b1)
    ) keypad_c2_config (
        .PACKAGE_PIN(C2_but_in),
        .D_IN_0(C2_but)
    );

    SB_IO #(
        .PIN_TYPE(6'b0000_01),
        .PULLUP(1'b1)
    ) keypad_c3_config (
        .PACKAGE_PIN(C3_but_in),
        .D_IN_0(C3_but)
    ); 
 
    // Assign each button to respective row & col  
    edge_det ED1(R1, C1_but, scan_clk, btns[0]);
    edge_det ED2(R1, C2_but, scan_clk, btns[1]);
    edge_det ED3(R1, C3_but, scan_clk, btns[2]);
    edge_det ED4(R2, C1_but, scan_clk, btns[3]);
    edge_det ED5(R2, C2_but, scan_clk, btns[4]);
    edge_det ED6(R2, C3_but, scan_clk, btns[5]);
    edge_det ED7(R3, C1_but, scan_clk, btns[6]);
    edge_det ED8(R3, C2_but, scan_clk, btns[7]);
    edge_det ED9(R3, C3_but, scan_clk, btns[8]);
          
    wire scan_clk;
    clock_div #(.DIV(100)) CLKDIV2(hwclk, scan_clk);
    always @ (posedge scan_clk) begin
      case (counter)
        0: begin 
          R1 <= 0;
          R2 <= 1;
          R3 <= 1;
        end
        1: begin
          R1 <= 1;
          R2 <= 1;
          R3 <= 1;
        end
        2: begin
          R1 <= 1;
          R2 <= 0;
          R3 <= 1;
        end
        3: begin
          R1 <= 1;
          R2 <= 1;
          R3 <= 1;
        end
        4: begin
          R1 <= 1;
          R2 <= 1;
          R3 <= 0;
        end
        5: begin
          R1 <= 1;
          R2 <= 1;
          R3 <= 1;
        end
      endcase
      counter <= counter <= 5 ? counter + 1 : 0;
    end

endmodule
