view: bridge_requirement_test_case {
  sql_table_name: @{DATASET_NAME}.bridge_requirement_test_case ;;

  # --------------------------------------------------------------------------
  # Raw Dimensions (1 row per Req_ID + TC_ID - Horizontal Traceability Bridge)
  # --------------------------------------------------------------------------

  dimension: bridge_req_tc_pk {
    primary_key: yes
    type: string
    sql: CONCAT(CAST(${TABLE}.Req_Id AS STRING), '-', CAST(${TABLE}.TC_Id AS STRING)) ;;
    description: "Composite primary key for the Requirement-to-Test-Case bridge (1 row per Req_ID + TC_ID)."
  }

  dimension: req_id {
    type: string
    sql: CAST(${TABLE}.Req_Id AS STRING) ;;
    description: "Foreign key referencing the Requirement (Req_ID)."
  }

  dimension: tc_id {
    type: string
    sql: CAST(${TABLE}.TC_Id AS STRING) ;;
    description: "Foreign key referencing the covering Test Case (TC_ID)."
  }

  dimension: req_baseline {
    type: string
    sql: ${TABLE}.Req_Baseline ;;
    description: "Requirement baseline version under which the REQ-TC coverage link applies."
  }

  dimension: valid_baseline {
    type: string
    sql: ${TABLE}.Valid_Baseline ;;
    description: "Indicates whether the Requirement-to-Test-Case link belongs to a validated baseline."
  }
}
