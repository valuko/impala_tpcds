# TPCH benchmark for Impala Systems

This runs the TPC-DS benchmark for Impala system

## Setup
Use the tpcds-gen to generate the source data.

### Step 1: Generate Data

Data generation is done via a MapReduce wrapper around TPC-DS `dsdgen`.  See `tpcds-gen/README.md` for more details on the commands to generate the flat files.

### Step 2: Load Data

Adjust the source/text and target/Parquet schema names and flat file paths in the sql files found in the `scripts/` directory.  See the comments at the top of each.

Create external text file tables:

```
impala-shell -f impala-external.sql
```

Create Parquet tables:

```
impala-shell -f impala-parquet.sql
```

Load Parquet tables and compute stats:

```
impala-shell -f impala-insert.sql
```

## Usage
Run `./run.sh` to run the entire benchmark suite
Run `./run_mod.sh` to run a subset of the benchmark. Modify the queries in it to run the desired queries