view: dim_baseline {
  sql_table_name: @{DATASET_NAME}.dim_baseline ;;

  # --------------------------------------------------------------------------
  # Raw Dimensions (1:1 Table Columns Mapping - 1 row per Baseline)
  # --------------------------------------------------------------------------

  dimension: baseline_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.Baseline_Id ;;
    description: "Unique identifier of the engineering Baseline."
  }

  dimension: req_baseline {
    type: string
    sql: ${TABLE}.Req_Baseline ;;
    description: "Requirement baseline version code."
  }

  dimension: ts_baseline {
    type: string
    sql: ${TABLE}.TS_Baseline ;;
    description: "Test Set campaign baseline version code."
  }

  dimension: valid_baseline {
    type: string
    sql: ${TABLE}.Valid_Baseline ;;
    description: "Validated baseline indicator matching requirement and test baselines."
  }

  dimension: milestone {
    type: string
    sql: ${TABLE}.Milestone ;;
    description: "Project development milestone associated with the baseline."
  }

  dimension: sweet_level {
    type: string
    sql: ${TABLE}.SWEET ;;
    description: "Renault/Ampere SWEET electrical/electronic architecture maturity milestone."
  }
}
