include: "/01_views/sources/feature.view.lkml"

view: +feature {

  # =========================================================================
  # 1. KEYS
  # =========================================================================

  dimension: req_feature_id {
    primary_key: yes
    label: "Feature ID"
    description: "Unique vehicle feature identifier."
  }

  # =========================================================================
  # 2. DIMENSIONS
  # =========================================================================

  dimension: req_feature_cbid {
    label: "Feature Codebase ID"
    description: "Core baseline repository feature key."
  }

  dimension: req_feature {
    label: "Feature Name"
    description: "Descriptive name and scope of the vehicle feature."
  }

  # =========================================================================
  # 3. MEASURES
  # =========================================================================

  measure: feature_count {
    type: count
    label: "Total Features Count"
    description: "Total count of feature entries."
    drill_fields: [feature_detail*]
  }

  measure: distinct_feature_count {
    type: count_distinct
    sql: ${req_feature_id} ;;
    label: "Distinct Features Count"
    description: "Number of unique vehicle features."
    drill_fields: [feature_detail*]
  }

  # =========================================================================
  # 4. SETS
  # =========================================================================

  set: feature_detail {
    fields: [
      req_feature_id,
      req_feature_cbid,
      req_feature
    ]
  }
}
