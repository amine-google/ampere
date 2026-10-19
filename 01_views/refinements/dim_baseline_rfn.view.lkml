include: "/01_views/sources/dim_baseline.view.lkml"

view: +dim_baseline {

  # =========================================================================
  # 1. KEYS
  # =========================================================================

  dimension: baseline_id {
    primary_key: yes
    label: "Baseline ID"
    description: "Unique identifier of the engineering Baseline."
  }

  # =========================================================================
  # 2. DIMENSIONS
  # =========================================================================

  dimension: req_baseline {
    label: "Requirement Baseline"
    description: "Baseline version code on Requirements."
  }

  dimension: ts_baseline {
    label: "Test Set Baseline"
    description: "Baseline version code on Test Sets."
  }

  dimension: valid_baseline {
    label: "Valid Baseline Flag"
    description: "Indicates whether the baseline is validated across Requirement and Test Set."
  }

  dimension: milestone {
    label: "Milestone"
    description: "Project milestone associated with the baseline."
  }

  dimension: sweet_level {
    label: "SWEET Maturity Level"
    description: "SWEET electrical/electronic architecture maturity milestone."
  }

  # =========================================================================
  # 3. MEASURES
  # =========================================================================

  measure: unique_baseline_count {
    type: count_distinct
    label: "Total Baselines (Distinct)"
    description: "Count of distinct baselines."
    sql: ${baseline_id} ;;
    drill_fields: [baseline_id, req_baseline, ts_baseline, valid_baseline, milestone]
  }
}
