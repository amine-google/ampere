include: "/01_views/sources/ownership.view.lkml"

view: +ownership {

  # =========================================================================
  # 1. KEYS
  # =========================================================================

  dimension: req_id {
    primary_key: yes
    label: "Requirement ID"
    description: "Foreign key linking ownership details to the requirement."
  }

  # =========================================================================
  # 2. DIMENSIONS
  # =========================================================================

  dimension: req_system_owner {
    label: "System Owner"
    group_label: "Engineering Ownership"
    description: "System engineering lead or architect responsible for the requirement."
  }

  dimension: req_domain {
    label: "Domain"
    group_label: "Engineering Ownership"
    description: "High-level vehicle engineering domain (e.g. Powertrain, ADAS, Infotainment, Chassis)."
  }

  dimension: req_sub_domain {
    label: "Sub Domain"
    group_label: "Engineering Ownership"
    description: "Specialized subsystem domain (e.g. Battery Management, Steering, Autonomous Braking)."
  }

  dimension: req_engineering_level {
    label: "Engineering Level"
    group_label: "Engineering Ownership"
    description: "Architectural tier (e.g. L1 Vehicle Level, L2 System Level, L3 Component Level)."
  }

  dimension: req_allocation {
    label: "Discipline Allocation"
    group_label: "Engineering Ownership"
    description: "Engineering implementation discipline (Software, Hardware, Mechanical, Cloud)."
  }

  # =========================================================================
  # 3. MEASURES
  # =========================================================================

  measure: ownership_count {
    type: count
    label: "Total Ownership Records"
    description: "Total count of ownership allocations."
    drill_fields: [ownership_detail*]
  }

  measure: distinct_owner_count {
    type: count_distinct
    sql: ${req_system_owner} ;;
    label: "Distinct System Owners"
    description: "Number of unique system engineers/owners."
    drill_fields: [ownership_detail*]
  }

  measure: distinct_domain_count {
    type: count_distinct
    sql: ${req_domain} ;;
    label: "Distinct Domains"
    description: "Number of unique engineering domains represented."
    drill_fields: [ownership_detail*]
  }

  # =========================================================================
  # 4. SETS
  # =========================================================================

  set: ownership_detail {
    fields: [
      req_id,
      req_system_owner,
      req_domain,
      req_sub_domain,
      req_engineering_level,
      req_allocation
    ]
  }
}
