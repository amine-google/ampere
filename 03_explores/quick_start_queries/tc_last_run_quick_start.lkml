# --------------------------------------------------------------------------
# Quick Start Queries for Explore C — TC Last Run
# --------------------------------------------------------------------------

explore: +tc_last_run {
  query: latest_run_status_by_domain {
    label: "1. Latest Run Results by TC Domain"
    description: "Current execution status (Passed, Failed, Blocked, Not Executed) of distinct Test Cases by Engineering Domain."
    dimensions: [dim_test_case.tc_domain]
    measures: [
      fact_tc_latest_run.last_run_total_tc_count,
      fact_tc_latest_run.last_run_passed_tc_count,
      fact_tc_latest_run.last_run_failed_tc_count,
      fact_tc_latest_run.last_run_blocked_tc_count,
      fact_tc_latest_run.last_run_not_executed_tc_count,
      fact_tc_latest_run.last_run_pass_rate
    ]
    sorts: [fact_tc_latest_run.last_run_total_tc_count: desc]
  }

  query: quality_failed_without_issue {
    label: "2. Quality 1/3 — Failed/Blocked TCs Without Issue or With Closed/Derogated Issue"
    description: "Identifies Test Cases failing/blocked on their latest run without an open defect ticket."
    dimensions: [dim_test_case.tc_domain]
    measures: [
      fact_tc_latest_run.failed_blocked_without_issue_tc_count,
      fact_tc_latest_run.failed_blocked_closed_issue_tc_count,
      fact_tc_latest_run.failed_blocked_derogated_issue_tc_count
    ]
    sorts: [fact_tc_latest_run.failed_blocked_without_issue_tc_count: desc]
  }
}
