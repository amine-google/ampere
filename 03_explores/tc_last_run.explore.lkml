# --------------------------------------------------------------------------
# Explore C - TC Last Run (Current Execution Status per Test Case)
# Per Customer Recommendation Section 4:
# Starting view: fact_tc_latest_run (1 row per TC_ID)
# -> Test Case
# -> REQ-TC bridge -> Requirement -> MySWF
# -> TC-TS bridge -> Test Set -> MySWF: fix version
# -> Issue / ownership dimensions
# --------------------------------------------------------------------------

include: "/01_views/refinements/fact_tc_latest_run_rfn.view.lkml"
include: "/01_views/refinements/dim_test_case_rfn.view.lkml"
include: "/01_views/refinements/bridge_requirement_test_case_rfn.view.lkml"
include: "/01_views/refinements/requirement_rfn.view.lkml"
include: "/01_views/refinements/project_rfn.view.lkml"
include: "/01_views/refinements/safety_rfn.view.lkml"
include: "/01_views/refinements/ownership_rfn.view.lkml"
include: "/01_views/refinements/bridge_test_case_test_set_rfn.view.lkml"
include: "/01_views/refinements/dim_test_set_rfn.view.lkml"
include: "/01_views/refinements/dim_fix_version_rfn.view.lkml"
include: "/01_views/refinements/dim_baseline_rfn.view.lkml"
include: "/01_views/refinements/dim_issue_rfn.view.lkml"
include: "/03_explores/quick_start_queries/tc_last_run_quick_start.lkml"

explore: tc_last_run {
  label: "Explore C — TC Last Run (Current Status & SDV TC Runs)"
  description: "Optimized Explore for the Spotfire SDV TC Runs use case and all dashboards needing one current execution status per Test Case, including cross-world MySWF/Requirement filtering."
  from: fact_tc_latest_run
  view_name: fact_tc_latest_run

  join: dim_test_case {
    type: left_outer
    relationship: one_to_one
    sql_on: ${fact_tc_latest_run.tc_id} = ${dim_test_case.tc_id} ;;
    view_label: "Test Case"
  }

  join: bridge_requirement_test_case {
    type: left_outer
    relationship: one_to_many
    sql_on: ${fact_tc_latest_run.tc_id} = ${bridge_requirement_test_case.tc_id} ;;
    view_label: "REQ-TC Traceability Bridge"
  }

  join: requirement {
    type: left_outer
    relationship: many_to_one
    sql_on: ${bridge_requirement_test_case.req_id} = ${requirement.req_id} ;;
    view_label: "Requirement (Covered)"
  }

  join: project {
    type: left_outer
    relationship: many_to_one
    sql_on: ${requirement.req_vehicle_project_id} = ${project.req_vehicle_project_id} ;;
    view_label: "MySWF & Vehicle Project"
  }

  join: safety {
    type: left_outer
    relationship: one_to_one
    sql_on: ${requirement.req_id} = ${safety.req_id} ;;
    view_label: "Safety Goal (ASIL) & Regulation"
  }

  join: ownership {
    type: left_outer
    relationship: one_to_one
    sql_on: ${requirement.req_id} = ${ownership.req_id} ;;
    view_label: "Requirement Ownership"
  }

  join: bridge_test_case_test_set {
    type: left_outer
    relationship: one_to_many
    sql_on: ${fact_tc_latest_run.tc_id} = ${bridge_test_case_test_set.tc_id} ;;
    view_label: "TC-TS Execution Bridge"
  }

  join: dim_test_set {
    type: left_outer
    relationship: many_to_one
    sql_on: ${fact_tc_latest_run.ts_id} = ${dim_test_set.ts_id} ;;
    view_label: "Test Set Campaign"
  }

  join: dim_fix_version {
    type: left_outer
    relationship: many_to_one
    sql_on: ${dim_test_set.ts_id} = ${dim_fix_version.ts_id} ;;
    view_label: "Fix Version & ECU Releases"
  }

  join: dim_baseline {
    type: left_outer
    relationship: many_to_one
    sql_on: ${dim_test_set.ts_baseline} = ${dim_baseline.ts_baseline} ;;
    view_label: "Baseline & Milestone"
  }

  join: dim_issue {
    type: left_outer
    relationship: many_to_one
    sql_on: ${fact_tc_latest_run.issue_id} = ${dim_issue.issue_id} ;;
    view_label: "Linked Defect / Issue"
  }
}
