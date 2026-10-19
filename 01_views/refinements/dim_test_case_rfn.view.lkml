include: "/01_views/sources/dim_test_case.view.lkml"

view: +dim_test_case {

  # =========================================================================
  # 1. KEYS (Primary & Foreign)
  # =========================================================================

  dimension: tc_id {
    primary_key: yes
    label: "Test Case ID"
    description: "Unique identifier of the Test Case (1 row per TC_ID)."
  }

  dimension: automation_id {
    label: "Automation ID"
    description: "Identifier of the linked test automation request."
  }

  # =========================================================================
  # 2. DIMENSIONS & SPOTFIRE DYNAMIC AXES
  # =========================================================================

  dimension: tc_uid {
    label: "TC UID"
    description: "Universal unique code of the Test Case."
  }

  dimension: tc_name {
    label: "Test Case Name"
    description: "Descriptive title of the Test Case."
  }

  dimension: tc_status {
    label: "TC Status"
    description: "Authoring lifecycle status of the Test Case (Accepted, Approved, Rework, Draft)."
    html:
      {% if value == 'Accepted' or value == 'Approved' %}
        <span style="color: #0F9D58; font-weight: 600;">● {{ rendered_value }}</span>
      {% elsif value == 'Rework' or value == 'In Review' %}
        <span style="color: #F4B400; font-weight: 600;">◐ {{ rendered_value }}</span>
      {% else %}
        <span>{{ rendered_value }}</span>
      {% endif %} ;;
  }

  dimension: tc_type {
    label: "TC Type"
    description: "Test Case classification (e.g. Functional, Integration, Safety)."
  }

  dimension: tc_domain {
    label: "TC Domain"
    description: "Engineering domain responsible for the Test Case."
  }

  dimension: tc_bench_type {
    label: "TC Bench Type"
    description: "Target test bench environment (HIL, SIL, VIL, Vehicle)."
  }

  dimension: tc_execution_organization {
    label: "Execution Organization"
    description: "Organization executing the Test Case (e.g. Internal, Supplier, Backlog, Descoped)."
  }

  dimension: tc_feature {
    label: "TC Feature"
    description: "Vehicle or software feature verified by the Test Case."
  }

  dimension: tc_dut {
    label: "Device Under Test (DUT)"
    description: "ECU or subsystem under test."
  }

  dimension: tc_cb_project_name {
    label: "Codebeamer Project"
    description: "Codebeamer project name hosting the Test Case."
  }

  dimension: tc_vehicle_project {
    label: "TC Vehicle Project"
    description: "Target vehicle project for the Test Case."
  }

  dimension: tc_estimated_duration {
    label: "Estimated Duration (min)"
    description: "Estimated execution time in minutes."
  }

  dimension: tc_domain_leader {
    label: "TC Domain Leader"
    description: "Domain leader accountable for the Test Case."
  }

  dimension: tc_validation_leader {
    label: "TC Validation Leader"
    description: "Validation leader accountable for the Test Case."
  }

  dimension: tc_validation_team {
    label: "TC Validation Team"
    description: "Validation team assigned to the Test Case."
  }

  dimension: tc_system_owner {
    label: "TC System Owner"
    description: "System owner responsible for the function under test."
  }

  dimension: tc_engineering_level {
    label: "TC Engineering Level"
    description: "V-cycle engineering level of the Test Case."
  }

  dimension: tc_security_level {
    label: "TC Security Level"
    description: "Confidentiality classification level."
  }

  dimension: tc_created_week {
    label: "TC Created Week"
    description: "ISO year-week when the Test Case was authored."
  }

  dimension: tc_brand {
    label: "TC Brand"
    description: "Applicable vehicle brand."
  }

  dimension: automation_name {
    label: "Automation Name"
    description: "Name of the automated test script."
  }

  dimension: automation_status {
    label: "Automation Status"
    description: "Status of the test automation request."
  }

  dimension: automation_bench_type {
    label: "Automation Bench Type"
    description: "Bench type targeted for test automation."
  }

  dimension: automation_framework {
    label: "Automation Framework"
    description: "Framework used to automate the Test Case."
  }

  dimension: is_accepted_or_approved {
    type: yesno
    label: "Is Accepted / Approved"
    sql: ${tc_status} IN ('Accepted', 'Approved') ;;
    description: "True when TC_Status is Accepted or Approved."
  }

  dimension: is_accepted_approved_rework {
    type: yesno
    label: "Is Accepted / Approved / Rework"
    sql: ${tc_status} IN ('Accepted', 'Approved', 'Rework') ;;
    description: "True when TC_Status is in the active Spotfire scope (Accepted, Approved, Rework)."
  }

  dimension: is_not_backlog_descoped {
    type: yesno
    label: "Exclude Backlog & Descoped"
    sql: COALESCE(${tc_execution_organization}, '') NOT IN ('Backlog', 'Descoped') ;;
    description: "True when TC_Execution_Organization is neither Backlog nor Descoped (Spotfire ${isBacklogDescoped} scope)."
  }

  dimension: has_automation_request {
    type: yesno
    label: "Has Automation Request"
    sql: ${automation_id} IS NOT NULL ;;
    description: "True when the Test Case has a linked Automation_Id (Spotfire Automation & Runs scope)."
  }

  # Spotfire Dynamic Breakdown Dimension (<$esc(${tc.feature})> / <$esc(${RowsAxis})>)
  dimension: dynamic_tc_axis {
    type: string
    label_from_parameter: tc_axis_selector
    description: "Dynamic grouping dimension replacing Spotfire <$esc(${tc.feature})> and <$esc(${RowsAxis})> properties."
    sql:
      {% if tc_axis_selector._parameter_value == 'TC_Domain' %}
        ${tc_domain}
      {% elsif tc_axis_selector._parameter_value == 'TC_Bench_Type' %}
        ${tc_bench_type}
      {% elsif tc_axis_selector._parameter_value == 'TC_Validation_Team' %}
        ${tc_validation_team}
      {% elsif tc_axis_selector._parameter_value == 'TC_Status' %}
        ${tc_status}
      {% elsif tc_axis_selector._parameter_value == 'TC_Engineering_Level' %}
        ${tc_engineering_level}
      {% elsif tc_axis_selector._parameter_value == 'TC_Execution_Organization' %}
        ${tc_execution_organization}
      {% else %}
        ${tc_feature}
      {% endif %} ;;
  }

  # Spotfire Dynamic Column Axis (<$esc(${ColumnAxis})>)
  dimension: dynamic_column_axis {
    type: string
    label_from_parameter: column_axis_selector
    description: "Dynamic pivot/column axis replacing Spotfire <$esc(${ColumnAxis})> on Quality 3/3 cross-tables."
    sql:
      {% if column_axis_selector._parameter_value == 'TC_Status' %}
        ${tc_status}
      {% elsif column_axis_selector._parameter_value == 'TC_Bench_Type' %}
        ${tc_bench_type}
      {% elsif column_axis_selector._parameter_value == 'TC_Execution_Organization' %}
        ${tc_execution_organization}
      {% else %}
        ${tc_domain}
      {% endif %} ;;
  }

  # =========================================================================
  # 3. MEASURES (Controlled Grain - Distinct TC Counts Only)
  # =========================================================================

  measure: unique_tc_count {
    type: count_distinct
    label: "Total Test Cases (Distinct TC)"
    description: "Spotfire UniqueCount([TC_Id]): Controlled distinct count of Test Cases (never a raw row count)."
    sql: ${tc_id} ;;
    drill_fields: [tc_details_drill_set*]
  }

  measure: accepted_approved_tc_count {
    type: count_distinct
    label: "Accepted / Approved Test Cases"
    description: "Count of distinct Test Cases in Accepted or Approved status."
    sql: ${tc_id} ;;
    filters: [is_accepted_or_approved: "yes"]
    drill_fields: [tc_details_drill_set*]
  }

  measure: automated_tc_count {
    type: count_distinct
    label: "Test Cases with Automation Request"
    description: "Count of distinct Test Cases having a non-null Automation_Id (Spotfire Automation & Runs)."
    sql: ${tc_id} ;;
    filters: [has_automation_request: "yes"]
    drill_fields: [tc_details_drill_set*]
  }

  measure: automation_coverage_rate {
    type: number
    label: "Automation Request Rate (%)"
    description: "Percentage of distinct Test Cases linked to an automation request."
    sql: SAFE_DIVIDE(${automated_tc_count}, ${unique_tc_count}) ;;
    value_format_name: percent_1
    drill_fields: [tc_details_drill_set*]
  }

  # =========================================================================
  # 4. FILTERS & PARAMETERS (Spotfire Document Properties)
  # =========================================================================

  parameter: tc_axis_selector {
    type: unquoted
    label: "Dynamic X/Row Axis (tc.feature / RowsAxis)"
    description: "Replaces Spotfire Document Properties ${tc.feature} and ${RowsAxis} for dynamic chart grouping."
    default_value: "TC_Domain"
    allowed_value: { label: "TC Domain" value: "TC_Domain" }
    allowed_value: { label: "TC Feature" value: "TC_Feature" }
    allowed_value: { label: "TC Bench Type" value: "TC_Bench_Type" }
    allowed_value: { label: "TC Validation Team" value: "TC_Validation_Team" }
    allowed_value: { label: "TC Status" value: "TC_Status" }
    allowed_value: { label: "TC Engineering Level" value: "TC_Engineering_Level" }
    allowed_value: { label: "Execution Organization" value: "TC_Execution_Organization" }
  }

  parameter: column_axis_selector {
    type: unquoted
    label: "Dynamic Column Axis (ColumnAxis)"
    description: "Replaces Spotfire Document Property ${ColumnAxis} on Quality 3/3 cross-table."
    default_value: "TC_Domain"
    allowed_value: { label: "TC Domain" value: "TC_Domain" }
    allowed_value: { label: "TC Status" value: "TC_Status" }
    allowed_value: { label: "TC Bench Type" value: "TC_Bench_Type" }
    allowed_value: { label: "Execution Organization" value: "TC_Execution_Organization" }
  }

  parameter: accepted_only_param {
    type: yesno
    label: "Accepted / Approved / Rework Scope Only"
    description: "Replaces Spotfire ${AcceptedOnly} scope toggle."
    default_value: "yes"
  }

  parameter: backlog_descoped_param {
    type: yesno
    label: "Exclude Backlog & Descoped TCs"
    description: "Replaces Spotfire ${isBacklogDescoped} scope toggle."
    default_value: "yes"
  }

  # =========================================================================
  # 5. SETS (Details-on-Demand Drill Path)
  # =========================================================================

  set: tc_details_drill_set {
    fields: [
      tc_id,
      tc_name,
      tc_status,
      tc_domain,
      tc_bench_type,
      tc_feature,
      tc_validation_team,
      tc_execution_organization,
      automation_id,
      automation_status
    ]
  }
}
