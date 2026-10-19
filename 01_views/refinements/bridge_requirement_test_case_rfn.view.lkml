include: "/01_views/sources/bridge_requirement_test_case.view.lkml"

view: +bridge_requirement_test_case {

  # =========================================================================
  # 1. KEYS
  # =========================================================================

  dimension: bridge_req_tc_pk {
    primary_key: yes
    hidden: yes
    label: "Bridge REQ-TC Composite PK"
    description: "Composite primary key (Req_ID + TC_ID) for horizontal traceability coverage."
  }

  dimension: req_id {
    label: "Linked Requirement ID"
    description: "Requirement ID in the horizontal coverage link."
  }

  dimension: tc_id {
    label: "Covering Test Case ID"
    description: "Test Case ID covering the Requirement."
  }

  # =========================================================================
  # 2. DIMENSIONS
  # =========================================================================

  dimension: req_baseline {
    label: "Coverage Baseline"
    description: "Baseline under which the Requirement-to-Test-Case link is defined."
  }

  dimension: valid_baseline {
    label: "Valid Coverage Baseline"
    description: "Indicates if the coverage link belongs to a valid baseline."
  }

  # =========================================================================
  # 3. MEASURES
  # =========================================================================

  measure: req_tc_coverage_link_count {
    type: count_distinct
    label: "REQ-TC Coverage Links"
    description: "Count of distinct Requirement-to-Test-Case traceability pairs (1 row per Req_ID + TC_ID)."
    sql: ${bridge_req_tc_pk} ;;
    drill_fields: [req_id, tc_id, req_baseline, valid_baseline]
  }

  measure: distinct_covering_tcs {
    type: count_distinct
    label: "Distinct Covering Test Cases"
    description: "Number of distinct Test Cases covering the selected Requirements."
    sql: ${tc_id} ;;
    drill_fields: [req_id, tc_id, req_baseline]
  }
}
