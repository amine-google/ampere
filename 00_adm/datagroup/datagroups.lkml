# --------------------------------------------------------------------------
# Datagroups: Caching & ETL Pipeline Synchronization
# --------------------------------------------------------------------------

datagroup: ampere_etl_datagroup {
  sql_trigger: SELECT MAX(Req_Update) FROM @{DATASET_NAME}.requirement ;;
  max_cache_age: "12 hours"
  description: "Triggers cache refresh when requirements are updated in data warehouse."
}
