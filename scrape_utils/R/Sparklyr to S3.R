library(pacman)
p_load(sparklyr, dplyr)


####################### connect to spark service using sparklyr's spark_connect function
sc <- sparklyr::spark_connect(config = spark_config())"Apache Spark-ic")

sc <- sparklyr::spark_connect(master = "spark://HOST:PORT")

?sparklyr::spark_connect
####################### Get the java Context from spark context to set the S3a credentials needed to connect S3 bucket.
#Get spark context 
ctx <- sparklyr::spark_context(sc)
#Use below to set the java spark context 
jsc <- invoke_static( sc, "org.apache.spark.api.java.JavaSparkContext", "fromSparkContext", ctx )

####################### Now replace below your access key and secret key generated for your AWS account.
#set the s3 configs: 
hconf <- jsc %>% invoke("hadoopConfiguration") hconf %>% 
  invoke("set","fs.s3a.access.key", "<put-your-access-key>") hconf %>% 
  invoke("set","fs.s3a.secret.key", "<put-your-secret-key>")

####################### use spark_read_csv to read from Amazon S3 bucket into spark context in Rstudio
#Lets try to read using sparklyr packages 
# sc = sparkcontext connection, name = name of table to refer within spark, path = path to S3 bucket
usercsv_tbl <- spark_read_csv(sc,name = "usercsvtlb",path = "s3a://charlesbuckets31/FolderA/users.csv")
https://s3.console.aws.amazon.com/s3/buckets/aws-logs-093952938136-us-east-1/elasticmapreduce/j-XN0BA1CYK16P/DataWarehouse/?region=us-east-2&tab=overview
usercsv_tbl <- spark_read_csv(sc,name = "usercsvtlb",path = "s3a://charlesbuckets31/FolderA/users.csv")
####################### Use src_tbls to see if we read the table in spark. Use head to view the check the dataframe.
src_tbls(sc)
head(usercsv_tbl,4)

####################### read parquet:
usercsv_tbl <- spark_read_parquet(sc,name = "usertbl",path="s3n://charlesbuckets31/FolderB/users.parquet") 

usercsv_tbl <- spark_read_parquet(sc,name = "usertbl",path="s3n://aws-logs-093952938136-us-east-1/elasticmapreduce/j-XN0BA1CYK16P/DataWarehouse")
src_tbls(sc)


####################### Write back into Amazon S3: 
sparklyr::spark_write_csv(usercsv_tbl,path = "s3a://charlesbuckets31/FolderA/usersOutput.csv")

####################### First install 'aws.s3' package and load it.
install.packages("aws.s3", repos = c("cloudyr" = "http://cloudyr.github.io/drat"))
library("aws.s3")


####################### 'aws.s3' package need AWS ACCESS KEY and AWS SECRET KEY added to environment.Replace below with yours.
Sys.setenv("AWS_ACCESS_KEY_ID" = "<PUT-ACCESS-KEY>","AWS_SECRET_ACCESS_KEY" = "<PUT-SECRET-KEY>")


####################### read the object into R use 'get_object' and specify your s3 path as shown below.
usercsvobj <-get_object("s3://charlesbuckets31/FolderA/users.csv")


####################### do further processing to convert the raw object to your desire type of object (dataframe) depending on the type of file you are reading.
csvcharobj <- rawToChar(usercsvobj)
con <- textConnection(csvcharobj) data <- read.csv(con) close(con) data
