title "Two-Way ANOVA for with MapReduce Schema Data as Repeated Measure Design";
FILENAME REFFILE './results.csv';
PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=df;
	GETNAMES=YES;
RUN;
proc print data=df(obs=10);
run;
proc glm data = df plots=all;
  class schema block_size;
  model time = schema|block_size;
  repeated block_size 3/printe;
run;
