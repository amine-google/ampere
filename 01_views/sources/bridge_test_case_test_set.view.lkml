view: bridge_test_case_test_set {
  sql_table_name: @{DATASET_NAME}.bridge_test_case_test_set ;;

  # --------------------------------------------------------------------------
  # Raw Dimensions (1 row per TC_ID + TS_ID + TR_ID - Test Execution Bridge)
  # --------------------------------------------------------------------------

  dimension: bridge_tc_ts_tr_pk {
    primary_key: yes
    type: string
    sql: CONCAT(COALESCE(CAST(${TABLE}.TC_Id AS STRING), 'NULL'), '-', COALESCE(CAST(${TABLE}.TS_Id AS STRING), 'NULL'), '-', COALESCE(CAST(${TABLE}.TR_Id AS STRING), 'NULL')) ;;
    description: "Composite primary key for the TC-TS-TR execution bridge (1 row per TC_ID + TS_ID + TR_ID)."
  }

  dimension: tc_id {
    type: string
    sql: CAST(${TABLE}.TC_Id AS STRING) ;;
    description: "Foreign key referencing the Test Case (TC_ID)."
  }

  dimension: ts_id {
    type: string
    sql: CAST(${TABLE}.TS_Id AS STRING) ;;
    description: "Foreign key referencing the Test Set campaign (TS_ID)."
  }

  dimension: tr_id {
    type: string
    sql: CAST(${TABLE}.TR_Id AS STRING) ;;
    description: "Foreign key referencing the Test Run execution (TR_ID)."
  }
}
