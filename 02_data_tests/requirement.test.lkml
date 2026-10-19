# --------------------------------------------------------------------------
# Automated LookML Data Tests for the 3 Canonical Explores:
# 1. Explore A: traceability (Requirement PK uniqueness & coverage bounds)
# 2. Explore B: execution (Test Run PK uniqueness)
# 3. Explore C: tc_last_run (1 row per TC_ID PK uniqueness & pass rate bounds)
# --------------------------------------------------------------------------

test: requirement_pk_is_unique {
  explore_source: traceability {
    column: req_id { field: requirement.req_id }
    column: count { field: requirement.requirement_count }
    sorts: [requirement.requirement_count: desc]
    limit: 1
  }
  assert: req_id_unique {
    expression: ${requirement.requirement_count} = 1 ;;
  }
}

test: traceability_coverage_rate_within_bounds {
  explore_source: traceability {
    column: coverage_rate { field: requirement.requirement_coverage_rate }
  }
  assert: valid_coverage_percentage {
    expression: ${requirement.requirement_coverage_rate} >= 0 AND ${requirement.requirement_coverage_rate} <= 1 ;;
  }
}

test: test_run_pk_is_unique {
  explore_source: execution {
    column: tr_id { field: dim_test_run.tr_id }
    column: run_count { field: dim_test_run.unique_tr_count }
    sorts: [dim_test_run.unique_tr_count: desc]
    limit: 1
  }
  assert: tr_id_unique {
    expression: ${dim_test_run.unique_tr_count} = 1 ;;
  }
}

test: fact_tc_latest_run_one_row_per_tc_id {
  explore_source: tc_last_run {
    column: tc_id { field: fact_tc_latest_run.tc_id }
    column: tc_count { field: fact_tc_latest_run.last_run_total_tc_count }
    sorts: [fact_tc_latest_run.last_run_total_tc_count: desc]
    limit: 1
  }
  assert: strictly_one_latest_run_per_tc {
    expression: ${fact_tc_latest_run.last_run_total_tc_count} = 1 ;;
  }
}
