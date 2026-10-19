include: "/01_views/sources/dim_test_run.view.lkml"

view: +dim_test_run {

  # =========================================================================
  # 1. KEYS (Primary & Foreign)
  # =========================================================================

  dimension: tr_id {
    primary_key: yes
    label: "Test Run ID"
    description: "Unique identifier of the Test Run execution result (1 row per TR_ID)."
  }

  dimension: tc_id {
    label: "Executed Test Case ID"
    description: "Foreign key referencing the executed Test Case."
  }

  dimension: ts_id {
    label: "Executed Test Set ID"
    description: "Foreign key referencing the Test Set campaign."
  }

  dimension: issue_id {
    label: "Linked Issue ID"
    description: "Foreign key referencing the defect logged during this Test Run."
  }

  # =========================================================================
  # 2. DIMENSIONS & DIMENSION GROUPS
  # =========================================================================

  dimension_group: tr_run {
    type: time
    label: "Test Run Execution"
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: CAST(${TABLE}.TR_RunDate AS TIMESTAMP) ;;
    description: "Timestamp when the Test Run was executed."
  }

  dimension: tr_run_week {
    label: "Run Week (YYYY-WW)"
    description: "ISO year-week string when the Test Run was executed (Spotfire All runs week / First runs week)."
  }

  dimension: tr_last_run_date {
    label: "Last Run Date"
    description: "Formatted date of the most recent execution."
  }

  dimension: tr_result {
    label: "Test Run Result"
    description: "Execution verdict (Passed, Failed, Blocked, Not Executed)."
    html:
      {% if value == 'Passed' %}
        <span style="color: #0F9D58; font-weight: 600;">✔ {{ rendered_value }}</span>
      {% elsif value == 'Failed' %}
        <span style="color: #DB4437; font-weight: 600;">✖ {{ rendered_value }}</span>
      {% elsif value == 'Blocked' %}
        <span style="color: #F4B400; font-weight: 600;">■ {{ rendered_value }}</span>
      {% else %}
        <span style="color: #757575;">○ {{ rendered_value }}</span>
      {% endif %} ;;
  }

  dimension: tr_relevant_status {
    label: "Relevant Status Flag"
    description: "1 if the Test Run is relevant for official reporting, 0 otherwise."
  }

  dimension: is_last_run {
    label: "Is Chronological Last Run"
    description: "Indicates if this run is the latest chronological execution for the Test Case."
  }

  dimension: is_first_run {
    label: "Is First Run"
    description: "Indicates if this run is the first execution for the Test Case (Spotfire TC First Runs tab)."
  }

  dimension: is_executed_run {
    type: yesno
    label: "Is Executed Run"
    sql: ${tr_result} IS NOT NULL AND ${tr_result} != 'Not Executed' ;;
    description: "True when TR_Result != 'Not Executed' (Spotfire filter_executed_accepted_runs)."
  }

  dimension: tr_regression {
    label: "Regression Flag"
    description: "Indicates whether this run represents a regression."
  }

  # Spotfire Dynamic Horizontal Axis (<$esc(${tr.horizontalAxis})>)
  dimension: dynamic_tr_horizontal_axis {
    type: string
    label_from_parameter: tr_horizontal_axis_selector
    description: "Dynamic X-axis replacing Spotfire <$esc(${tr.horizontalAxis})> on TC ALL Runs and TC First Runs tabs."
    sql:
      {% if tr_horizontal_axis_selector._parameter_value == 'TR_RunWeek' %}
        ${tr_run_week}
      {% elsif tr_horizontal_axis_selector._parameter_value == 'TR_Result' %}
        ${tr_result}
      {% else %}
        ${tr_run_week}
      {% endif %} ;;
  }

  # =========================================================================
  # 3. MEASURES (Distinguishing Test Run Counts from Distinct TC Counts)
  # =========================================================================

  measure: unique_tr_count {
    type: count_distinct
    label: "Total Test Runs (Distinct TR)"
    description: "Spotfire UniqueCount([TR_Id]): Total number of historical Test Run executions."
    sql: ${tr_id} ;;
    drill_fields: [tr_execution_drill_set*]
  }

  measure: executed_tr_count {
    type: count_distinct
    label: "Executed Test Runs"
    description: "Count of distinct Test Runs where TR_Result != 'Not Executed'."
    sql: ${tr_id} ;;
    filters: [is_executed_run: "yes"]
    drill_fields: [tr_execution_drill_set*]
  }

  measure: passed_tr_count {
    type: count_distinct
    label: "Passed Test Runs"
    description: "Count of distinct Test Runs with TR_Result = 'Passed'."
    sql: ${tr_id} ;;
    filters: [tr_result: "Passed"]
    drill_fields: [tr_execution_drill_set*]
  }

  measure: failed_tr_count {
    type: count_distinct
    label: "Failed Test Runs"
    description: "Count of distinct Test Runs with TR_Result = 'Failed'."
    sql: ${tr_id} ;;
    filters: [tr_result: "Failed"]
    drill_fields: [tr_execution_drill_set*]
  }

  measure: blocked_tr_count {
    type: count_distinct
    label: "Blocked Test Runs"
    description: "Count of distinct Test Runs with TR_Result = 'Blocked'."
    sql: ${tr_id} ;;
    filters: [tr_result: "Blocked"]
    drill_fields: [tr_execution_drill_set*]
  }

  measure: tr_pass_rate {
    type: number
    label: "Test Run Pass Rate (%)"
    description: "Percentage of executed Test Runs that Passed."
    sql: SAFE_DIVIDE(${passed_tr_count}, ${executed_tr_count}) ;;
    value_format_name: percent_1
    drill_fields: [tr_execution_drill_set*]
  }

  measure: first_runs_count {
    type: count_distinct
    label: "First Runs (Distinct TR)"
    description: "Count of distinct Test Runs where isFirstRun = True (Spotfire TC First Runs tab)."
    sql: ${tr_id} ;;
    filters: [is_first_run: "yes", is_executed_run: "yes"]
    drill_fields: [tr_execution_drill_set*]
  }

  measure: distinct_executed_tc_count {
    type: count_distinct
    label: "Distinct Executed Test Cases"
    description: "Count of distinct Test Cases (TC_ID) that have at least one executed Test Run."
    sql: CASE WHEN ${is_executed_run} THEN ${tc_id} END ;;
    drill_fields: [tr_execution_drill_set*]
  }

  # =========================================================================
  # 4. FILTERS & PARAMETERS
  # =========================================================================

  parameter: tr_horizontal_axis_selector {
    type: unquoted
    label: "Execution X-Axis (tr.horizontalAxis)"
    description: "Replaces Spotfire Document Property ${tr.horizontalAxis}."
    default_value: "TR_RunWeek"
    allowed_value: { label: "Execution Week (TR_RunWeek)" value: "TR_RunWeek" }
    allowed_value: { label: "Execution Result (TR_Result)" value: "TR_Result" }
  }

  # =========================================================================
  # 5. SETS
  # =========================================================================

  set: tr_execution_drill_set {
    fields: [
      tr_id,
      tc_id,
      ts_id,
      tr_run_week,
      tr_run_date,
      tr_result,
      is_first_run,
      is_last_run,
      issue_id
    ]
  }
}
