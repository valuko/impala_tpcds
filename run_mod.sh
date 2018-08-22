#!/bin/bash

BASE_DIR=`pwd`

TIME_CMD="time"  

NUM_OF_TRIALS=5

LOG_FILE="benchmark_retries.log"

LOG_DIR="$BASE_DIR/logs/retries"

QUERIES_DIR="$BASE_DIR/mod_queries"

# Impala command
IMPALA_CMD="impala-shell -d tpcds_300_parquet"

TPCDS_QUERIES_ALL=( \
	"query5a" \
	"query10a" \
	"query14a" \
	"query18a" \
	"query22a" \
	"query24a" \
	"query27a" \
	"query35a" \
	"query36a" \
	"query46a" \
	"query51a" \
	"query66a" \
	"query67a" \
	"query68a" \
	"query70a" \
	"query77a" \
	"query80a" \
	"query85a" \
	"query86a" \
)

echo ""
echo "***********************************************"
echo "*          TPC-DS benchmark on Impala         *"
echo "***********************************************"
echo "                                               " 
echo "Running Benchmark from $BASE_DIR"
echo "See $LOG_FILE for more details of query errors."
echo ""

trial=1
while [ $trial -lt $NUM_OF_TRIALS ]; do
	trial=`expr $trial + 1`
	run_dir="run${trial}"
	echo "Executing Trial #$trial of $NUM_OF_TRIALS trial(s)..."

	for query in ${TPCDS_QUERIES_ALL[@]}; do
	    query_file="${query}.sql"
            result_file="${LOG_DIR}/${run_dir}/${query}_result.log"
            stats_file="${LOG_DIR}/${run_dir}/${query}_stats.log"
	    echo ""
	    echo "Running TPCDS query: $query"
            $TIME_CMD $IMPALA_CMD -f $QUERIES_DIR/$query_file -o $result_file > $stats_file 2>&1
            echo "done!!"
	done

done # TRIAL
echo "***********************************************"
echo ""
