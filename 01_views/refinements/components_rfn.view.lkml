include: "/01_views/sources/components.view.lkml"

view: +components {

  # =========================================================================
  # 1. KEYS
  # =========================================================================

  dimension: component_pk {
    primary_key: yes
    label: "Component Mapping ID"
    description: "Unique identifier for requirement to software component allocation."
  }

  dimension: req_id {
    label: "Requirement ID"
    description: "Foreign key linking software component allocation to the base requirement."
  }

  # =========================================================================
  # 2. DIMENSIONS
  # =========================================================================

  dimension: req_sw_components {
    label: "Software Component Key"
    group_label: "Software Component Details"
    description: "Symbolic software component identifier (e.g. SWC_InverterControl, SWC_BMS_Thermal)."
  }

  dimension: req_sw_components_name {
    label: "Software Component Name"
    group_label: "Software Component Details"
    description: "Descriptive title of the software engineering component."
  }

  dimension: req_mysf_name {
    label: "MySF Package Name"
    group_label: "Software Component Details"
    description: "My Software Factory CI build package or repository module name."
  }

  # =========================================================================
  # 3. MEASURES
  # =========================================================================

  measure: component_count {
    type: count
    label: "Total Component Allocations"
    description: "Total count of software component allocations to requirements."
    drill_fields: [component_detail*]
  }

  measure: distinct_component_count {
    type: count_distinct
    sql: ${req_sw_components} ;;
    label: "Distinct Software Components"
    description: "Number of unique software components linked to requirements."
    drill_fields: [component_detail*]
  }

  # =========================================================================
  # 4. SETS
  # =========================================================================

  set: component_detail {
    fields: [
      req_id,
      req_sw_components,
      req_sw_components_name,
      req_mysf_name
    ]
  }
}
