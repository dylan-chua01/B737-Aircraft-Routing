/*********************************************
 * OPL 22.1.1.0 Model
 * Author: dylanchua
 * Creation Date: Oct 10, 2024 at 5:07:16 PM
 *********************************************/

 //Variables
 int f=...; //f = 36
 range F=1..f; //a range of flights from 1 to 36
 int n=...; //total number of nodes in our network
 range N=1..n; //the range of nodes we can loop through
 range S = 27..33; //initial node range
 int A=...; //the fleet size of 12
 
 int c[N][N] = ...; //cost matrix
 int M[N][N] =...; //connection matrix
 
 //Decision Variables
 dvar boolean x[N][N]; //connection x_ij
 dvar int+ y[S]; //the initial station flow variables
 
 //Objective Function
 minimize 
 	sum(i in N,j in N) c[i][j] * x[i][j]; //costs	
 
 //Constraints
 subject to {
   //fleet size limit constraint
   ctFleetSize:
   		sum(s in S) y[s]==A; //s=10..13, A=3
   		
	//flight coverage constraint
	ctFlightCoverage:
		forall(i in F)
		  sum(j in N) M[i][j] *x[i][j] ==1; //flight coverage
		  
    //flow balance for all flight nodes
    ctFlowBalance:
    	forall(j in F)
    	  sum(i in N) M[i][j]*x[i][j] - 
    	  	sum(i in N) M[j][i]*x[j][i] == 0; //flow balance
   
   //source node to first flights for each station, s
   forall (s in S)
     y[s] - sum(i in F) M[s][i]*x[s][i] == 0; //initial station flow balance
     
   //overnight aircraft flow conservation for each station
   sum(i in F) M[27][i]*x[27][i] - sum(i in F) M[i][34]*x[i][34] == 0; 
   sum(i in F) M[28][i]*x[28][i] - sum(i in F) M[i][35]*x[i][35] == 0; 
   sum(i in F) M[29][i]*x[29][i] - sum(i in F) M[i][36]*x[i][36] == 0;  
   sum(i in F) M[30][i]*x[30][i] - sum(i in F) M[i][37]*x[i][37] == 0; 
   sum(i in F) M[31][i]*x[31][i] - sum(i in F) M[i][38]*x[i][38] == 0;
   sum(i in F) M[32][i]*x[32][i] - sum(i in F) M[i][39]*x[i][39] == 0;
   sum(i in F) M[33][i]*x[33][i] - sum(i in F) M[i][40]*x[i][40] == 0; 
   }
   
//output and display my results
execute Display_result {
  writeln("Routing model results are shown below:");
  
  for (var i in N)
  	for (var j in N)
  		if(x[i][j] == 1){
  		  writeln ("Flight ", i, " is connected with flight ", j);
  		  }
  }
   