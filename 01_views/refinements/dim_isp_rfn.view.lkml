include: "/01_views/sources/dim_isp.view.lkml"

view: +dim_isp {

  # =========================================================================
  # 1. KEYS
  # =========================================================================

  dimension: isp_id {
    primary_key: yes
    label: "ISP ID"
    description: "Unique identifier of the Integrated Software Plan (ISP) item."
  }

  dimension: baseline_id {
    label: "ISP Baseline ID"
    description: "Target baseline linked to the ISP item."
  }

  # =========================================================================
  # 2. DIMENSIONS
  # =========================================================================

  dimension: isp_summary {
    label: "ISP Summary"
    description: "Title of the ISP planning item."
  }

  dimension: isp_status {
    label: "ISP Status"
    description: "Current status of the ISP item."
  }

  dimension: isp_resolution {
    label: "ISP Resolution"
    description: "Resolution outcome of the ISP item."
  }

  dimension: isp_fix_version {
    label: "ISP Fix Version"
    description: "Fix version targeted by the ISP item."
  }

  dimension: isp_committed_sprint {
    label: "Committed Sprint"
    description: "Agile sprint committed for ISP delivery."
  }

  dimension: isp_requested_planning {
    label: "Requested Planning"
    description: "Requested target milestone for the ISP item."
  }

  dimension: isp_validation_team {
    label: "ISP Validation Team"
    description: "Validation team assigned to the ISP item."
  }

  dimension: isp_train_in_charge {
    label: "Train in Charge"
    description: "Agile Release Train responsible for the ISP item."
  }

  dimension: isp_domain_in_charge {
    label: "Domain in Charge"
    description: "Engineering domain responsible for the ISP item."
  }

  dimension: isp_impacted_train {
    label: "Impacted Train"
    description: "Downstream train impacted by the ISP item."
  }

  dimension: isp_brand {
    label: "ISP Brand"
    description: "Vehicle brand associated with the ISP item."
  }

  # =========================================================================
  # 3. MEASURES
  # =========================================================================

  measure: unique_isp_count {
    type: count_distinct
    label: "Total ISP Items (Distinct)"
    description: "Count of distinct Integrated Software Plan (ISP) items."
    sql: ${isp_id} ;;
    drill_fields: [isp_id, isp_summary, isp_status, isp_train_in_charge, isp_committed_sprint]
  }
}
