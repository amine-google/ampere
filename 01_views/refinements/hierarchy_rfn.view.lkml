include: "/01_views/sources/hierarchy.view.lkml"

view: +hierarchy {

  # =========================================================================
  # 1. KEYS
  # =========================================================================

  dimension: hierarchy_pk {
    primary_key: yes
    label: "Hierarchy Link ID"
    description: "Unique identifier for parent-child requirement decomposition link."
  }

  dimension: req_id {
    label: "Requirement ID"
    description: "Foreign key linking hierarchy link to the base requirement."
  }

  # =========================================================================
  # 2. DIMENSIONS
  # =========================================================================

  dimension: req_child_required {
    type: yesno
    sql: LOWER(CAST(${TABLE}.Req_Child_Required AS STRING)) IN ('yes', 'true', '1') ;;
    label: "Is Child Decomposition Required"
    description: "Indicates whether parent requirement requires further functional breakdown."
  }

  dimension: req_requirement_parent_id {
    label: "Parent ID"
    group_label: "Parent Hierarchy"
    description: "Unique identifier of the upstream parent requirement."
  }

  dimension: req_requirement_parent {
    label: "Parent Requirement Name"
    group_label: "Parent Hierarchy"
    description: "Title of the upstream parent requirement."
  }

  dimension: req_requirement_parent_level {
    label: "Parent Architectural Level"
    group_label: "Parent Hierarchy"
    description: "Engineering tier of parent requirement (e.g. L1 System Level)."
  }

  dimension: req_requirement_child_id {
    label: "Child ID"
    group_label: "Child Hierarchy"
    description: "Unique identifier of the downstream child requirement."
  }

  dimension: req_requirement_child_name {
    label: "Child Requirement Name"
    group_label: "Child Hierarchy"
    description: "Title of the decomposed child requirement."
  }

  dimension: req_requirement_child_level {
    label: "Child Architectural Level"
    group_label: "Child Hierarchy"
    description: "Engineering tier of child requirement (e.g. L2 Subsystem Level, L3 Component)."
  }

  # =========================================================================
  # 3. MEASURES
  # =========================================================================

  measure: hierarchy_link_count {
    type: count
    label: "Total Hierarchy Links"
    description: "Total count of parent-child requirement traceability links."
    drill_fields: [hierarchy_detail*]
  }

  measure: distinct_parent_count {
    type: count_distinct
    sql: ${req_requirement_parent_id} ;;
    label: "Distinct Parent Requirements"
    description: "Count of unique parent requirements with downstream children."
    drill_fields: [hierarchy_detail*]
  }

  measure: distinct_child_count {
    type: count_distinct
    sql: ${req_requirement_child_id} ;;
    label: "Distinct Child Requirements"
    description: "Count of unique decomposed child requirements."
    drill_fields: [hierarchy_detail*]
  }

  # =========================================================================
  # 4. SETS
  # =========================================================================

  set: hierarchy_detail {
    fields: [
      req_id,
      req_requirement_parent_id,
      req_requirement_parent,
      req_requirement_parent_level,
      req_requirement_child_id,
      req_requirement_child_name,
      req_requirement_child_level,
      req_child_required
    ]
  }
}
