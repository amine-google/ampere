include: "/01_views/sources/tracker.view.lkml"

view: +tracker {

  # =========================================================================
  # 1. KEYS
  # =========================================================================

  dimension: req_tracker_id {
    primary_key: yes
    label: "Tracker ID"
    description: "Unique tracking system identifier."
  }

  # =========================================================================
  # 2. DIMENSIONS
  # =========================================================================

  dimension: req_tracker {
    label: "Tracker System Name"
    description: "Name of the requirements tracking system (e.g. Polarion, Jira, Doors NG)."
  }

  # =========================================================================
  # 3. MEASURES
  # =========================================================================

  measure: tracker_count {
    type: count
    label: "Total Tracker Records"
    description: "Total count of tracker instances."
    drill_fields: [tracker_detail*]
  }

  measure: distinct_tracker_count {
    type: count_distinct
    sql: ${req_tracker} ;;
    label: "Distinct Tracker Systems"
    description: "Number of unique tracking platforms in use."
    drill_fields: [tracker_detail*]
  }

  # =========================================================================
  # 4. SETS
  # =========================================================================

  set: tracker_detail {
    fields: [
      req_tracker_id,
      req_tracker
    ]
  }
}
