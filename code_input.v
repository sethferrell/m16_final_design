module code_input #(parameter WIDTH = 4, SIZE = 6)  (
  input rst,
  input clk,
  output correct,
  input [8:0] btns,
  input [31:0] pass,
  output reg [3:0] debug
);
  //wire [WIDTH - 1:0] pass [0:SIZE - 1];
  reg [WIDTH - 1:0] usr_code [0:SIZE - 1];
  reg [WIDTH - 1:0] i;
 
  assign debug = pass[0];

  assign correct = (usr_code[0] == pass / 100000 % 10) &&
                   (usr_code[1] == pass / 10000  % 10) &&
                   (usr_code[2] == pass / 1000   % 10) &&
                   (usr_code[3] == pass / 100    % 10) &&
                   (usr_code[4] == pass / 10     % 10) &&
                   (usr_code[5] == pass          % 10);

  always @ (posedge clk or posedge rst) begin
    if (rst) begin
      i <= 0;
      usr_code[0] <= 4'hf;
      usr_code[1] <= 4'hf;
      usr_code[2] <= 4'hf;
      usr_code[3] <= 4'hf;
      usr_code[4] <= 4'hf;
      usr_code[5] <= 4'hf;
    end else begin
      if (btns[0]) begin
        usr_code[i] <= 4'd1;
        i <= i + 1;
      end else if (btns[1]) begin
        usr_code[i] <= 4'd2;
        i <= i + 1;
      end else if (btns[2]) begin
        usr_code[i] <= 4'd3;
        i <= i + 1;
      end else if (btns[3]) begin
        usr_code[i] <= 4'd4;
        i <= i + 1;
      end else if (btns[4]) begin
        usr_code[i] <= 4'd5;
        i <= i + 1;
      end else if (btns[5]) begin
        usr_code[i] <= 4'd6;
        i <= i + 1;
      end
    end
  end
endmodule
