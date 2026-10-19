include: "/01_views/sources/fact_tc_latest_run.view.lkml"

view: +fact_tc_latest_run {

  # =========================================================================
  # 1. KEYS (Primary & Foreign)
  # =========================================================================

  dimension: tc_id {
    primary_key: yes
    label: "Test Case ID (Latest Run Grain)"
    description: "Unique Test Case ID (1 row per TC_ID representing its latest relevant execution result)."
  }

  dimension: tr_id {
    label: "Latest Test Run ID"
    description: "Identifier of the latest relevant Test Run for this Test Case."
  }

  dimension: ts_id {
    label: "Latest Test Set ID"
    description: "Identifier of the Test Set campaign in which the latest run was executed."
  }

  dimension: issue_id {
    label: "Latest Run Issue ID"
    description: "Identifier of the defect linked to the latest Test Run."
  }

  # =========================================================================
  # 2. DIMENSIONS (Spotfire Calculated Columns & Quality Flags)
  # =========================================================================

  dimension_group: tr_run {
    type: time
    label: "Latest Run Execution"
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: CAST(${TABLE}.TR_RunDate AS TIMESTAMP) ;;
    description: "Timestamp when the latest Test Run was executed."
  }

  dimension: tr_run_week {
    label: "Last Run Week (YYYY-WW)"
    description: "ISO year-week of the latest Test Run execution (Spotfire Last run week)."
  }

  dimension: tr_last_run_date {
    label: "Last Run Date"
    description: "Formatted latest run date string."
  }

  dimension: tr_result {
    label: "Latest Run Result"
    description: "Latest relevant execution verdict for the Test Case (Passed, Failed, Blocked, Not Executed)."
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

  dimension: admin_rank {
    label: "Admin Rank"
    description: "Spotfire [Admin_Rank]: Prioritizes relevant runs (TR_Relevant_Status=1) and ranks latest TR_RunDate per TC_ID."
  }

  dimension: qua_tc_in_ts {
    label: "Quality: TC in Test Set (QUA_TC_in_TS)"
    description: "Spotfire Calculated Column [QUA_TC_in_TS]: 'In a Test Set' vs 'not in a Test Set'."
  }

  dimension: qua_tc_not_ready {
    label: "Quality: TC Readiness in TS (QUA_TC_NotReady)"
    description: "Spotfire Calculated Column [QUA_TC_NotReady]: 'Ok' when in a Test Set and TC_Status in ('Accepted', 'Approved'), else 'TC not Ready'."
  }

  dimension: qua_tr_without_issues {
    label: "Quality: Failed/Blocked Issue Linkage (QUA_TRWithoutIssues)"
    description: "Spotfire Calculated Column [QUA_TRWithoutIssues]: 'No Issue linked' vs 'Issue linked' for Failed/Blocked runs."
  }

  dimension: auto_ts_runs {
    label: "Automation: TC in TS (Auto_TS_Runs)"
    description: "Spotfire Calculated Column [Auto_TS_Runs]: 'In a TS' vs 'Not in a TS' for Test Cases with an automation request."
  }

  dimension: is_failed_or_blocked {
    type: yesno
    label: "Is Failed or Blocked (Latest Run)"
    sql: ${tr_result} IN ('Failed', 'Blocked') ;;
    description: "True when the latest Test Run result is Failed or Blocked."
  }

  dimension: is_without_issue {
    type: yesno
    label: "Is Without Linked Issue"
    sql: ${issue_id} IS NULL ;;
    description: "True when no defect ticket is linked to the latest Test Run."
  }

  # =========================================================================
  # 3. MEASURES (Spotfire TC LAST RUNS, Automation & Quality 1/3, 2/3, 3/3)
  # =========================================================================

  measure: last_run_total_tc_count {
    type: count_distinct
    label: "Total Test Cases (Last Run Scope)"
    description: "Spotfire UniqueCount(case when Rank([Admin_Rank],[TC_Id])=1 then [TC_Id] else null end)."
    sql: ${tc_id} ;;
    drill_fields: [last_run_details_drill_set*]
  }

  measure: last_run_passed_tc_count {
    type: count_distinct
    label: "Passed TCs (Last Run)"
    description: "Spotfire UniqueCount(case when Rank([Admin_Rank],[TC_Id])=1 and [TR_Result]='Passed' then [TC_Id] else null end)."
    sql: ${tc_id} ;;
    filters: [tr_result: "Passed"]
    drill_fields: [last_run_details_drill_set*]
  }

  measure: last_run_failed_tc_count {
    type: count_distinct
    label: "Failed TCs (Last Run)"
    description: "Spotfire UniqueCount(case when Rank([Admin_Rank],[TC_Id])=1 and [TR_Result]='Failed' then [TC_Id] else null end)."
    sql: ${tc_id} ;;
    filters: [tr_result: "Failed"]
    drill_fields: [last_run_details_drill_set*]
  }

  measure: last_run_blocked_tc_count {
    type: count_distinct
    label: "Blocked TCs (Last Run)"
    description: "Spotfire UniqueCount(case when Rank([Admin_Rank],[TC_Id])=1 and [TR_Result]='Blocked' then [TC_Id] else null end)."
    sql: ${tc_id} ;;
    filters: [tr_result: "Blocked"]
    drill_fields: [last_run_details_drill_set*]
  }

  measure: last_run_not_executed_tc_count {
    type: count_distinct
    label: "Not Executed TCs (Last Run)"
    description: "Spotfire UniqueCount(case when Rank([Admin_Rank],[TC_Id])=1 and [TR_Result]='Not Executed' then [TC_Id] else null end)."
    sql: ${tc_id} ;;
    filters: [tr_result: "Not Executed"]
    drill_fields: [last_run_details_drill_set*]
  }

  measure: last_run_executed_tc_count {
    type: count_distinct
    label: "Executed TCs (Last Run)"
    description: "Count of distinct Test Cases whose latest run has been executed (Passed, Failed, or Blocked)."
    sql: CASE WHEN ${tr_result} != 'Not Executed' THEN ${tc_id} END ;;
    drill_fields: [last_run_details_drill_set*]
  }

  measure: last_run_pass_rate {
    type: number
    label: "Last Run Pass Rate (%)"
    description: "Percentage of executed Test Cases that Passed on their latest run."
    sql: SAFE_DIVIDE(${last_run_passed_tc_count}, ${last_run_executed_tc_count}) ;;
    value_format_name: percent_1
    drill_fields: [last_run_details_drill_set*]
  }

  measure: last_run_execution_rate {
    type: number
    label: "Last Run Execution Coverage (%)"
    description: "Percentage of total Test Cases that have been executed at least once."
    sql: SAFE_DIVIDE(${last_run_executed_tc_count}, ${last_run_total_tc_count}) ;;
    value_format_name: percent_1
    drill_fields: [last_run_details_drill_set*]
  }

  # --- Quality 1/3 Measures (Failed/Blocked Issue Hygiene) ---

  measure: failed_blocked_without_issue_tc_count {
    type: count_distinct
    label: "Failed/Blocked TCs Without Issue"
    description: "Spotfire Quality 1/3: UniqueCount of TCs where latest run is Failed/Blocked and Issue_Id is null."
    sql: CASE WHEN ${tr_result} IN ('Failed', 'Blocked') AND ${issue_id} IS NULL THEN ${tc_id} END ;;
    drill_fields: [last_run_details_drill_set*]
  }

  measure: failed_blocked_closed_issue_tc_count {
    type: count_distinct
    label: "Failed/Blocked TCs Linked to Closed Issue"
    description: "Spotfire Quality 1/3: UniqueCount of TCs where latest run is Failed/Blocked but linked Issue_Status is Closed/Verified/Integrated/Invalid."
    sql:
      CASE
        WHEN ${tr_result} IN ('Failed', 'Blocked')
         AND ${dim_issue.issue_status} IN ('Closed', 'Verified', 'Integrated', 'Invalid')
        THEN ${tc_id}
      END ;;
    drill_fields: [last_run_details_drill_set*]
  }

  measure: failed_blocked_derogated_issue_tc_count {
    type: count_distinct
    label: "Failed/Blocked TCs Linked to Derogated Issue"
    description: "Spotfire Quality 1/3: UniqueCount of TCs where latest run is Failed/Blocked and linked Issue_Status is Derogated."
    sql:
      CASE
        WHEN ${tr_result} IN ('Failed', 'Blocked')
         AND ${dim_issue.issue_status} = 'Derogated'
        THEN ${tc_id}
      END ;;
    drill_fields: [last_run_details_drill_set*]
  }

  # --- Quality 2/3 Measures (Test Set Inclusion & Readiness) ---

  measure: tc_not_in_ts_count {
    type: count_distinct
    label: "TCs Not in a Test Set"
    description: "Spotfire Quality 2/3: Count of distinct Test Cases not assigned to any Test Set (TS_Id is null)."
    sql: CASE WHEN ${ts_id} IS NULL THEN ${tc_id} END ;;
    drill_fields: [last_run_details_drill_set*]
  }

  measure: tc_not_ready_in_ts_count {
    type: count_distinct
    label: "TCs Not Ready in a Test Set"
    description: "Spotfire Quality 2/3: Count of distinct Test Cases assigned to a Test Set whose status is not Accepted/Approved."
    sql: CASE WHEN ${ts_id} IS NOT NULL AND ${qua_tc_not_ready} = 'TC not Ready' THEN ${tc_id} END ;;
    drill_fields: [last_run_details_drill_set*]
  }

  # --- Quality 3/3 Dynamic Items Count Measure (UniqueCount($esc(${ItemsCount}))) ---

  measure: dynamic_items_unique_count {
    type: number
    label_from_parameter: items_count_selector
    description: "Spotfire Quality 3/3 CrossTable measure: UniqueCount($esc(${ItemsCount})) switching dynamically between TC_Id, TS_Id, TR_Id, Req_Id, and Issue_Id."
    sql:
      {% if items_count_selector._parameter_value == 'TS_Id' %}
        COUNT(DISTINCT ${ts_id})
      {% elsif items_count_selector._parameter_value == 'TR_Id' %}
        COUNT(DISTINCT ${tr_id})
      {% elsif items_count_selector._parameter_value == 'Issue_Id' %}
        COUNT(DISTINCT ${issue_id})
      {% elsif items_count_selector._parameter_value == 'Req_Id' %}
        COUNT(DISTINCT ${bridge_requirement_test_case.req_id})
      {% else %}
        COUNT(DISTINCT ${tc_id})
      {% endif %} ;;
    drill_fields: [last_run_details_drill_set*]
  }

  # =========================================================================
  # 4. FILTERS & PARAMETERS (Spotfire Preprocessor Macros)
  # =========================================================================

  parameter: items_count_selector {
    type: unquoted
    label: "Cross-Table Metric Entity (ItemsCount)"
    description: "Replaces Spotfire Document Property ${ItemsCount} in UniqueCount($esc(${ItemsCount}))."
    default_value: "TC_Id"
    allowed_value: { label: "Distinct Test Cases (TC_Id)" value: "TC_Id" }
    allowed_value: { label: "Distinct Test Sets (TS_Id)" value: "TS_Id" }
    allowed_value: { label: "Distinct Test Runs (TR_Id)" value: "TR_Id" }
    allowed_value: { label: "Distinct Requirements (Req_Id)" value: "Req_Id" }
    allowed_value: { label: "Distinct Issues (Issue_Id)" value: "Issue_Id" }
  }

  parameter: tc_in_ts_only_param {
    type: yesno
    label: "Only TCs Assigned to a Test Set (TCinTSOnly)"
    description: "Replaces Spotfire Document Property ${TCinTSOnly}."
    default_value: "no"
  }

  # =========================================================================
  # 5. SETS
  # =========================================================================

  set: last_run_details_drill_set {
    fields: [
      tc_id,
      tr_id,
      ts_id,
      tr_result,
      tr_run_week,
      tr_last_run_date,
      issue_id,
      qua_tc_in_ts,
      qua_tc_not_ready,
      qua_tr_without_issues,
      auto_ts_runs
    ]
  }
}
