include: "/01_views/sources/bridge_test_case_test_set.view.lkml"

view: +bridge_test_case_test_set {

  # =========================================================================
  # 1. KEYS
  # =========================================================================

  dimension: bridge_tc_ts_tr_pk {
    primary_key: yes
    hidden: yes
    label: "Bridge TC-TS-TR Composite PK"
    description: "Composite primary key (TC_ID + TS_ID + TR_ID) for test execution linkage."
  }

  dimension: tc_id {
    label: "Bridge Test Case ID"
    description: "Test Case ID in the TC-TS-TR bridge."
  }

  dimension: ts_id {
    label: "Bridge Test Set ID"
    description: "Test Set ID in the TC-TS-TR bridge."
  }

  dimension: tr_id {
    label: "Bridge Test Run ID"
    description: "Test Run ID in the TC-TS-TR bridge."
  }

  # =========================================================================
  # 3. MEASURES
  # =========================================================================

  measure: tc_ts_execution_link_count {
    type: count_distinct
    label: "TC-TS-TR Execution Links"
    description: "Count of distinct Test Case / Test Set / Test Run combinations."
    sql: ${bridge_tc_ts_tr_pk} ;;
    drill_fields: [tc_id, ts_id, tr_id]
  }
}
