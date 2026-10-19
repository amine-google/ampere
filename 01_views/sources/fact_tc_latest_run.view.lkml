view: fact_tc_latest_run {
  sql_table_name: @{DATASET_NAME}.fact_tc_latest_run ;;

  # --------------------------------------------------------------------------
  # Raw Dimensions (1 row per TC_ID - Current Execution Status Fact Table)
  # Materialized/scheduled in BigQuery per Customer Recommendation Section 3.1
  # --------------------------------------------------------------------------

  dimension: tc_id {
    primary_key: yes
    type: string
    sql: CAST(${TABLE}.TC_Id AS STRING) ;;
    description: "Unique Test Case identifier (1 row per TC_ID representing its latest relevant execution result)."
  }

  dimension: tr_id {
    type: string
    sql: CAST(${TABLE}.TR_Id AS STRING) ;;
    description: "Identifier of the latest relevant Test Run for this Test Case."
  }

  dimension: ts_id {
    type: string
    sql: CAST(${TABLE}.TS_Id AS STRING) ;;
    description: "Identifier of the Test Set campaign in which the latest run was executed."
  }

  dimension: issue_id {
    type: string
    sql: ${TABLE}.Issue_Id ;;
    description: "Identifier of the defect/issue linked to the latest Test Run."
  }

  dimension: issue_cb_id {
    type: string
    sql: CAST(${TABLE}.Issue_CBId AS STRING) ;;
    description: "Codebeamer internal ID of the defect linked to the latest Test Run."
  }

  dimension: tr_run_date_raw {
    type: string
    sql: CAST(${TABLE}.TR_RunDate AS STRING) ;;
    description: "Raw execution timestamp of the latest Test Run."
  }

  dimension: tr_last_run_date {
    type: string
    sql: ${TABLE}.TR_LastRunDate ;;
    description: "Formatted latest run date string."
  }

  dimension: tr_run_week {
    type: string
    sql: ${TABLE}.TR_RunWeek ;;
    description: "ISO year-week (YYYY-WW) of the latest Test Run execution."
  }

  dimension: tr_result {
    type: string
    sql: COALESCE(${TABLE}.TR_Result, 'Not Executed') ;;
    description: "Latest execution status for the Test Case (Passed, Failed, Blocked, Not Executed)."
  }

  dimension: tr_relevant_status {
    type: number
    sql: ${TABLE}.TR_Relevant_Status ;;
    description: "Relevance flag (1 = Relevant, 0 = Non-Relevant) of the latest run."
  }

  dimension: tr_regression {
    type: string
    sql: ${TABLE}.TR_Regression ;;
    description: "Regression status flag on the latest Test Run."
  }

  dimension: admin_rank {
    type: number
    sql: ${TABLE}.Admin_Rank ;;
    description: "Pre-computed Spotfire Admin_Rank (prioritizing TR_Relevant_Status=1 and latest TR_RunDate per TC_ID)."
  }

  dimension: qua_tc_in_ts {
    type: string
    sql: CASE WHEN ${TABLE}.TS_Id IS NULL THEN 'not in a Test Set' ELSE 'In a Test Set' END ;;
    description: "Spotfire Quality 2/3 flag [QUA_TC_in_TS]: indicates whether the Test Case is included in a Test Set."
  }

  dimension: qua_tc_not_ready {
    type: string
    sql: ${TABLE}.QUA_TC_NotReady ;;
    description: "Spotfire Quality 2/3 flag [QUA_TC_NotReady]: 'Ok' when in a Test Set and TC_Status is Accepted/Approved, else 'TC not Ready'."
  }

  dimension: qua_tr_without_issues {
    type: string
    sql:
      CASE
        WHEN ${TABLE}.TR_Result IN ('Failed', 'Blocked') AND ${TABLE}.Issue_CBId IS NULL THEN 'No Issue linked'
        WHEN ${TABLE}.TR_Result IN ('Failed', 'Blocked') AND ${TABLE}.Issue_CBId IS NOT NULL THEN 'Issue linked'
        ELSE NULL
      END ;;
    description: "Spotfire Quality 1/3 flag [QUA_TRWithoutIssues]: checks whether a Failed/Blocked latest run has an Issue linked."
  }

  dimension: auto_ts_runs {
    type: string
    sql: CASE WHEN ${TABLE}.TS_Id IS NOT NULL THEN 'In a TS' ELSE 'Not in a TS' END ;;
    description: "Spotfire Automation & Runs flag [Auto_TS_Runs]: indicates whether an automated TC is assigned to a Test Set."
  }
}
