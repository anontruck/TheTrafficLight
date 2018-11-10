module traffic_light(
	input wire north_ped_in, west_ped_in,
    output wire R1out,Y1out,G1out,
    output wire R2out,Y2out,G2out);
    
	reg [3:0]state = 0;
	reg [7:0] timer = 0;
	reg north_ped, west_ped = 'b00;
	reg R1,Y1,G1,R2,Y2,G2 = 'b100100;
	
	
	assign {R1out,Y1out,G1out}={R1,Y1,G1};
	assign {R2out,Y2out,G2out}={R2,Y2,G2};
	
	
	always #1 begin
		timer = timer+1;
		case (state)
			0: 
			begin
				{R1,Y1,G1}='b001;
				{R2,Y2,G2}='b100;
				if (north_ped & (timer <= 10))
				begin
					timer = timer + 10;
					north_ped = 0;
				end
				if (timer >=20)
					state = 1;
			end
			1: 
			begin
				{R1,Y1,G1}='b010;
				{R2,Y2,G2}='b100;
				if (timer >=23)
					state = 2;
			end
			2: 
			begin
				{R1,Y1,G1}='b100;
				{R2,Y2,G2}='b100;
				if (timer >=25)
					state = 3;
			end
			3: 
			begin
				{R1,Y1,G1}='b100;
				{R2,Y2,G2}='b001;
				if (west_ped & (timer <= 35))
				begin
					timer = timer + 10;
					west_ped = 0;
				end
				if (timer >=45)
					state = 4;
			end
			4: 
			begin
				{R1,Y1,G1}='b100;
				{R2,Y2,G2}='b010;
				if (timer >=48)
					state = 5;
			end
			5: 
			begin
				{R1,Y1,G1}='b100;
				{R2,Y2,G2}='b100;
				if (timer >=50)
					begin
					state = 0;
					timer = 0;
					end
			end
		endcase
	end
	
	always @ (west_ped_in) begin
		west_ped = 1;
	end
	
	always @ (north_ped_in) begin
		north_ped = 1;
	end
	
	initial begin
		$dumpfile("Traffic_light.vcd");
		$dumpvars;
		$monitor("time=%t RYG1=%b%b%b RYG2=%b%b%b", $time, R1,Y1,G1,R2,Y2,G2);
		#5 north_ped = 1;
		#134 west_ped = 1;
		#71 $finish;
	end




endmodule