# --------------------------------------------------------------------------
# Quick Start Queries for Explore B — Execution
# --------------------------------------------------------------------------

explore: +execution {
  query: weekly_execution_trend {
    label: "1. Weekly Test Run Execution & Pass/Fail Trend"
    description: "Tracks weekly Test Run executions broken down by Passed, Failed, and Blocked results."
    dimensions: [dim_test_run.tr_run_week, dim_test_run.tr_result]
    pivots: [dim_test_run.tr_result]
    measures: [dim_test_run.executed_tr_count]
    sorts: [dim_test_run.tr_run_week: asc]
  }

  query: first_runs_by_week {
    label: "2. First Runs Execution by Week"
    description: "Analyzes first-time Test Case executions (isFirstRun = True) by ISO week."
    dimensions: [dim_test_run.tr_run_week, dim_test_run.tr_result]
    pivots: [dim_test_run.tr_result]
    measures: [dim_test_run.first_runs_count]
    filters: [dim_test_run.is_first_run: "yes"]
    sorts: [dim_test_run.tr_run_week: asc]
  }
}
