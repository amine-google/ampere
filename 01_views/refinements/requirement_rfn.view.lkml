include: "/01_views/sources/requirement.view.lkml"

view: +requirement {

  # =========================================================================
  # 1. KEYS (Primary & Foreign)
  # =========================================================================

  dimension: req_id {
    primary_key: yes
    label: "Requirement ID"
    description: "Unique identifier for the requirement (1 row per Requirement)."
  }

  dimension: req_tracker_id {
    label: "Tracker ID"
    description: "Identifier linking this requirement to its management tracker board."
  }

  dimension: req_feature_id {
    label: "Feature ID"
    description: "Identifier linking this requirement to its parent vehicle product feature."
  }

  dimension: req_vehicle_project_id {
    label: "Vehicle Project ID"
    description: "Identifier linking this requirement to its target vehicle development program."
  }

  dimension: req_isp_id {
    label: "ISP ID"
    description: "Identifier linking this requirement to its Integrated Software Plan (ISP) item."
  }

  dimension: req_baseline {
    label: "Requirement Baseline"
    description: "Baseline version identifier assigned to the requirement."
  }

  # =========================================================================
  # 2. DIMENSIONS & DIMENSION GROUPS
  # =========================================================================

  dimension: req_name {
    label: "Requirement Title"
    description: "Short descriptive name or title of the requirement."
  }

  dimension: req_description {
    label: "Description"
    description: "Detailed technical specification and acceptance criteria of the requirement."
  }

  dimension: req_type {
    label: "Type"
    description: "Engineering classification of the requirement (e.g. Functional, System, Software)."
  }

  dimension: req_status {
    label: "Status"
    description: "Current lifecycle state of the requirement."
    html:
      {% if value == 'Approved' or value == 'Verified' or value == 'Accepted' %}
        <span style="color: #0F9D58; font-weight: 600;">● {{ rendered_value }}</span>
      {% elsif value == 'In Review' or value == 'Draft' %}
        <span style="color: #F4B400; font-weight: 600;">◐ {{ rendered_value }}</span>
      {% elsif value == 'Obsolete' or value == 'Rejected' %}
        <span style="color: #DB4437; font-weight: 600;">✖ {{ rendered_value }}</span>
      {% else %}
        <span>{{ rendered_value }}</span>
      {% endif %} ;;
  }

  dimension: req_final_status {
    label: "Final Status"
    description: "Consolidated final lifecycle status of the requirement."
  }

  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: CAST(${TABLE}.Req_Creation AS TIMESTAMP) ;;
    description: "Timestamp when the requirement record was initialized."
  }

  dimension: req_created_week {
    label: "Created Week (ISO)"
    description: "ISO year-week when the requirement was created."
  }

  dimension_group: updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: CAST(${TABLE}.Req_Update AS TIMESTAMP) ;;
    description: "Timestamp when the requirement record was most recently modified."
  }

  dimension: req_version {
    label: "Version"
    description: "Formal document baseline revision code (e.g. v1.2)."
  }

  dimension: req_categories {
    label: "Category"
    description: "Engineering domain taxonomy tags (e.g. Architecture, Battery, Safety)."
  }

  dimension: req_requirement_category {
    label: "Requirement Category (SDV)"
    description: "SDV functional requirement category."
  }

  dimension: req_validation_methods {
    label: "Validation Methods"
    description: "Assigned verification & validation method (e.g. Test, Analysis, Inspection)."
  }

  dimension: req_validation_teams {
    label: "Validation Teams"
    description: "Teams responsible for validating the requirement."
  }

  dimension: req_supplier {
    label: "Supplier"
    description: "External supplier linked to the requirement."
  }

  dimension: covered_status {
    label: "Coverage Status"
    description: "Indicates whether the requirement is Covered or Uncovered by Test Cases."
  }

  dimension: is_approved {
    type: yesno
    sql: ${req_status} IN ('Approved', 'Verified', 'Accepted') ;;
    description: "Indicates whether the requirement has passed formal engineering sign-off."
  }

  dimension: is_draft {
    type: yesno
    sql: ${req_status} = 'Draft' ;;
    description: "Indicates whether the requirement is in initial authoring draft state."
  }

  # =========================================================================
  # 3. MEASURES (KPIs & Traceability Coverage)
  # =========================================================================

  measure: requirement_count {
    type: count_distinct
    label: "Total Requirements (Distinct)"
    description: "Total distinct count of unique engineering requirements."
    sql: ${req_id} ;;
    drill_fields: [requirement_drill_set*]
  }

  measure: approved_requirement_count {
    type: count_distinct
    label: "Approved Requirements"
    description: "Total distinct count of requirements that have achieved Approved/Verified status."
    sql: ${req_id} ;;
    filters: [is_approved: "yes"]
    drill_fields: [requirement_drill_set*]
  }

  measure: draft_requirement_count {
    type: count_distinct
    label: "Draft Requirements"
    description: "Total distinct count of requirements still in Draft status."
    sql: ${req_id} ;;
    filters: [is_draft: "yes"]
    drill_fields: [requirement_drill_set*]
  }

  measure: approval_rate {
    type: number
    label: "Approval Rate (%)"
    description: "Percentage of total requirements that are formally approved."
    sql: SAFE_DIVIDE(${approved_requirement_count}, ${requirement_count}) ;;
    value_format_name: percent_1
    drill_fields: [requirement_drill_set*]
  }

  measure: covered_requirements_count {
    type: count_distinct
    label: "Covered Requirements"
    description: "Count of distinct requirements linked to at least one Test Case via the REQ-TC bridge."
    sql: CASE WHEN ${bridge_requirement_test_case.tc_id} IS NOT NULL OR ${covered_status} = 'Covered' THEN ${req_id} END ;;
    drill_fields: [requirement_drill_set*]
  }

  measure: uncovered_requirements_count {
    type: number
    label: "Uncovered Requirements"
    description: "Count of distinct requirements with zero linked Test Cases."
    sql: ${requirement_count} - ${covered_requirements_count} ;;
    drill_fields: [requirement_drill_set*]
  }

  measure: requirement_coverage_rate {
    type: number
    label: "Requirement Coverage Rate (%)"
    description: "Percentage of distinct requirements covered by at least one Test Case."
    sql: SAFE_DIVIDE(${covered_requirements_count}, ${requirement_count}) ;;
    value_format_name: percent_1
    drill_fields: [requirement_drill_set*]
  }

  # =========================================================================
  # 4. FILTERS & PARAMETERS
  # =========================================================================

  parameter: status_filter_param {
    type: string
    label: "Target Status Parameter"
    description: "Dynamic parameter to filter or highlight a specific requirement status."
    allowed_value: { label: "Approved" value: "Approved" }
    allowed_value: { label: "In Review" value: "In Review" }
    allowed_value: { label: "Draft" value: "Draft" }
    default_value: "Approved"
  }

  # =========================================================================
  # 5. SETS
  # =========================================================================

  set: requirement_drill_set {
    fields: [
      req_id,
      req_name,
      req_type,
      req_status,
      req_version,
      req_categories,
      req_validation_teams,
      created_date,
      updated_date
    ]
  }
}
