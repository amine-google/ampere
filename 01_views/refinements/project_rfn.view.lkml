include: "/01_views/sources/project.view.lkml"

view: +project {

  # =========================================================================
  # 1. KEYS
  # =========================================================================

  dimension: req_vehicle_project_id {
    primary_key: yes
    label: "Vehicle Project ID"
    description: "Identifier for the vehicle development program."
  }

  # =========================================================================
  # 2. DIMENSIONS & DIMENSION GROUPS
  # =========================================================================

  dimension: req_vehicle_project {
    label: "Vehicle Project Name"
    group_label: "Vehicle Program"
    description: "Name of the vehicle project (e.g. Ampere Compact, Megane E-Tech, Alpine A290)."
  }

  dimension: req_cbproject_name {
    label: "Codebase Project Name"
    group_label: "Vehicle Program"
    description: "Internal software codebase repository project designation."
  }

  dimension: req_mysf {
    label: "MySF Configuration"
    group_label: "Software Release & CI/CD"
    description: "My Software Factory CI/CD branch or artifact tag."
  }

  dimension: req_baseline {
    label: "Baseline Version"
    group_label: "Software Release & CI/CD"
    description: "Engineering release baseline milestone identifier."
  }

  dimension: req_sweet {
    label: "SWEET Tooling ID"
    group_label: "Software Release & CI/CD"
    description: "Software Execution & Environment Tooling configuration identifier."
  }

  dimension: req_planned_for {
    label: "Planned For Milestone"
    group_label: "Program Schedule"
    description: "Target software delivery milestone or sprint."
    sql: ${TABLE}.Req_PlannedFor ;;
  }

  dimension: req_target_planned_for {
    label: "Target Planned For"
    group_label: "Program Schedule"
    description: "Planned SOP (Start of Production) deployment schedule."
    sql: ${TABLE}.Req_TargetPlannedFor ;;
  }

  dimension: req_obsolete_from {
    label: "Obsolete From Milestone"
    group_label: "Program Schedule"
    description: "Target milestone or phase-out date after which this release baseline is deprecated."
    sql: ${TABLE}.Req_ObsoleteFrom ;;
  }

  # =========================================================================
  # 3. MEASURES
  # =========================================================================

  measure: project_count {
    type: count
    label: "Total Projects Count"
    description: "Total count of vehicle projects recorded."
    drill_fields: [project_detail*]
  }

  measure: distinct_project_count {
    type: count_distinct
    sql: ${req_vehicle_project_id} ;;
    label: "Distinct Vehicle Programs"
    description: "Number of unique vehicle programs in development."
    drill_fields: [project_detail*]
  }

  # =========================================================================
  # 4. SETS
  # =========================================================================

  set: project_detail {
    fields: [
      req_vehicle_project_id,
      req_vehicle_project,
      req_cbproject_name,
      req_baseline,
      req_planned_for,
      req_target_planned_for
    ]
  }
}
