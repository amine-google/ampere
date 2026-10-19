# --------------------------------------------------------------------------
# Explore B - Execution (Historical Test Runs & Trends)
# Per Customer Recommendation Section 4:
# Starting view: Test Run -> Test Case -> Test Set -> Issue -> Execution dims
# --------------------------------------------------------------------------

include: "/01_views/refinements/dim_test_run_rfn.view.lkml"
include: "/01_views/refinements/dim_test_case_rfn.view.lkml"
include: "/01_views/refinements/bridge_test_case_test_set_rfn.view.lkml"
include: "/01_views/refinements/dim_test_set_rfn.view.lkml"
include: "/01_views/refinements/dim_issue_rfn.view.lkml"
include: "/01_views/refinements/dim_fix_version_rfn.view.lkml"
include: "/01_views/refinements/dim_baseline_rfn.view.lkml"
include: "/03_explores/quick_start_queries/execution_quick_start.lkml"

explore: execution {
  label: "Explore B — Execution (Historical Test Runs & Trends)"
  description: "Dedicated to detailed execution history, weekly run trends, first-run analysis, and repeated failure tracking. Distinguishes Test Run counts from distinct Test Case counts."
  from: dim_test_run
  view_name: dim_test_run

  join: dim_test_case {
    type: left_outer
    relationship: many_to_one
    sql_on: ${dim_test_run.tc_id} = ${dim_test_case.tc_id} ;;
    view_label: "Test Case"
  }

  join: bridge_test_case_test_set {
    type: left_outer
    relationship: many_to_one
    sql_on: ${dim_test_run.tr_id} = ${bridge_test_case_test_set.tr_id}
        AND ${dim_test_run.tc_id} = ${bridge_test_case_test_set.tc_id} ;;
    view_label: "TC-TS-TR Execution Bridge"
  }

  join: dim_test_set {
    type: left_outer
    relationship: many_to_one
    sql_on: ${dim_test_run.ts_id} = ${dim_test_set.ts_id} ;;
    view_label: "Test Set Campaign"
  }

  join: dim_issue {
    type: left_outer
    relationship: many_to_one
    sql_on: ${dim_test_run.issue_id} = ${dim_issue.issue_id} ;;
    view_label: "Linked Defect / Issue"
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
}
