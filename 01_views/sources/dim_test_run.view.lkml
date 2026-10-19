view: dim_test_run {
  sql_table_name: @{DATASET_NAME}.dim_test_run ;;

  # --------------------------------------------------------------------------
  # Raw Dimensions (1:1 Table Columns Mapping - 1 row per execution result)
  # --------------------------------------------------------------------------

  dimension: tr_id {
    primary_key: yes
    type: string
    sql: CAST(${TABLE}.TR_Id AS STRING) ;;
    description: "Unique identifier of the Test Run execution result (1 row per execution result)."
  }

  dimension: tc_id {
    type: string
    sql: CAST(${TABLE}.TC_Id AS STRING) ;;
    description: "Foreign key referencing the executed Test Case (TC_ID)."
  }

  dimension: ts_id {
    type: string
    sql: CAST(${TABLE}.TS_Id AS STRING) ;;
    description: "Foreign key referencing the parent Test Set campaign (TS_ID)."
  }

  dimension: issue_id {
    type: string
    sql: ${TABLE}.Issue_Id ;;
    description: "Foreign key referencing the defect/issue logged during this Test Run."
  }

  dimension: issue_cb_id {
    type: string
    sql: CAST(${TABLE}.Issue_CBId AS STRING) ;;
    description: "Codebeamer internal item ID of the linked defect/issue."
  }

  dimension: tr_run_date_raw {
    type: string
    sql: CAST(${TABLE}.TR_RunDate AS STRING) ;;
    description: "Raw execution timestamp of the Test Run."
  }

  dimension: tr_last_run_date {
    type: string
    sql: ${TABLE}.TR_LastRunDate ;;
    description: "Formatted date string of the latest execution for the Test Case."
  }

  dimension: tr_run_week {
    type: string
    sql: ${TABLE}.TR_RunWeek ;;
    description: "ISO year-week string (YYYY-WW) when the Test Run was executed."
  }

  dimension: tr_result {
    type: string
    sql: ${TABLE}.TR_Result ;;
    description: "Execution verdict of the Test Run (Passed, Failed, Blocked, Not Executed)."
  }

  dimension: tr_relevant_status {
    type: number
    sql: ${TABLE}.TR_Relevant_Status ;;
    description: "Flag (1 or 0) indicating whether the Test Run result is relevant for official KPI reporting."
  }

  dimension: tr_first_relevant_status {
    type: number
    sql: ${TABLE}.TR_First_Relevant_Status ;;
    description: "Flag indicating whether this run is the first relevant execution."
  }

  dimension: tr_last_relevant {
    type: string
    sql: ${TABLE}.TR_LastRevelant ;;
    description: "Indicator of the latest relevant run status."
  }

  dimension: tr_relevant_run {
    type: number
    sql: ${TABLE}.TR_Relevant_Run ;;
    description: "Rank/flag of relevant execution run."
  }

  dimension: tr_last_relevant_before {
    type: string
    sql: ${TABLE}.TR_LastRevelantBefore ;;
    description: "Previous relevant execution result prior to the current run."
  }

  dimension: is_last_run {
    type: yesno
    sql: ${TABLE}.isLastRun = TRUE ;;
    description: "Boolean flag indicating if this Test Run is the chronological latest execution for its Test Case."
  }

  dimension: is_first_run {
    type: yesno
    sql: ${TABLE}.isFirstRun = TRUE ;;
    description: "Boolean flag indicating if this Test Run is the very first execution for its Test Case."
  }

  dimension: tr_nb_issues_invalid {
    type: number
    sql: ${TABLE}.TR_nbIssuesInvalid ;;
    description: "Count of linked issues marked as Invalid on this Test Run."
  }

  dimension: tr_nb_issues_closed {
    type: number
    sql: ${TABLE}.TR_nbIssuesClosed ;;
    description: "Count of linked issues marked as Closed/Verified/Integrated on this Test Run."
  }

  dimension: tr_regression {
    type: string
    sql: ${TABLE}.TR_Regression ;;
    description: "Regression indicator when a previously passed Test Case fails in a newer run."
  }

  dimension: update_date_data_raw {
    type: string
    sql: CAST(${TABLE}.UpdateDateData AS STRING) ;;
    description: "Raw ETL synchronization timestamp for the Test Run."
  }
}
