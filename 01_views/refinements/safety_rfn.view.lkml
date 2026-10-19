include: "/01_views/sources/safety.view.lkml"

view: +safety {

  # =========================================================================
  # 1. KEYS
  # =========================================================================

  dimension: req_id {
    primary_key: yes
    label: "Requirement ID"
    description: "Foreign key linking safety classification to the requirement."
  }

  # =========================================================================
  # 2. DIMENSIONS
  # =========================================================================

  dimension: req_asil {
    label: "ASIL Rating"
    group_label: "Functional Safety"
    description: "Automotive Safety Integrity Level according to ISO 26262 (QM, ASIL A, ASIL B, ASIL C, ASIL D)."
    html:
      {% if value == 'ASIL D' %}
        <span style="background-color: #d93025; color: white; padding: 2px 6px; border-radius: 4px; font-weight: bold;">{{ value }}</span>
      {% elsif value == 'ASIL C' %}
        <span style="background-color: #ea8600; color: white; padding: 2px 6px; border-radius: 4px; font-weight: bold;">{{ value }}</span>
      {% elsif value == 'ASIL B' %}
        <span style="background-color: #f9ab00; color: #202124; padding: 2px 6px; border-radius: 4px; font-weight: bold;">{{ value }}</span>
      {% elsif value == 'ASIL A' %}
        <span style="background-color: #1a73e8; color: white; padding: 2px 6px; border-radius: 4px; font-weight: bold;">{{ value }}</span>
      {% elsif value == 'QM' %}
        <span style="background-color: #1e8e3e; color: white; padding: 2px 6px; border-radius: 4px; font-weight: bold;">{{ value }}</span>
      {% else %}
        <span>{{ rendered_value }}</span>
      {% endif %} ;;
  }

  dimension: is_safety_critical {
    type: yesno
    group_label: "Functional Safety"
    sql: ${req_asil} IN ('ASIL B', 'ASIL C', 'ASIL D') ;;
    description: "Flag indicating whether requirement has high-severity safety criticality (ASIL B, C, or D)."
  }

  dimension: req_safety_related {
    type: yesno
    sql: LOWER(CAST(${TABLE}.Req_Safety_Related AS STRING)) IN ('yes', 'true', '1') ;;
    group_label: "Functional Safety"
    label: "Is Safety Related"
    description: "Indicates whether the requirement impacts vehicle safety."
  }

  dimension: req_cyber {
    type: yesno
    sql: LOWER(CAST(${TABLE}.Req_Cyber AS STRING)) IN ('yes', 'true', '1') ;;
    group_label: "Cybersecurity & Security"
    label: "Is Cyber Related"
    description: "Indicates whether the requirement involves vehicle cybersecurity (ISO/SAE 21434)."
  }

  dimension: req_regulation {
    label: "Mandatory Regulation"
    group_label: "Homologation & Compliance"
    description: "Applicable legal or homologation regulation standard (e.g. UN ECE R155, R156)."
  }

  dimension: req_security_level {
    label: "Security Assurance Level"
    group_label: "Cybersecurity & Security"
    description: "Cybersecurity target level (CAL 1 through CAL 4). Restricted to authorized safety engineers."
    required_access_grants: [can_view_safety_critical]
  }

  # =========================================================================
  # 3. MEASURES
  # =========================================================================

  measure: safety_record_count {
    type: count
    label: "Total Safety Records"
    description: "Total count of safety assessment entries."
    drill_fields: [safety_detail*]
  }

  measure: asil_d_count {
    type: count
    filters: [req_asil: "ASIL D"]
    label: "ASIL D Requirements Count"
    description: "Count of maximum criticality (ASIL D) requirements requiring rigorous testing."
    drill_fields: [safety_detail*]
    link: {
      label: "🥧 Distribution of ASIL Levels"
      url: "@{DRILL_PIE_VIZ}{{ link }}&fields=safety.req_asil,safety.safety_record_count&sorts=safety.safety_record_count+desc&toggle=vis"
    }
  }

  measure: safety_critical_count {
    type: count
    filters: [is_safety_critical: "yes"]
    label: "Safety Critical Count (ASIL B/C/D)"
    description: "Count of requirements requiring ASIL B, C, or D development rigor."
    drill_fields: [safety_detail*]
  }

  measure: cyber_related_count {
    type: count
    filters: [req_cyber: "yes"]
    label: "Cybersecurity Requirements Count"
    description: "Count of requirements tagged for vehicle cybersecurity audits."
    drill_fields: [safety_detail*]
  }

  # =========================================================================
  # 4. SETS
  # =========================================================================

  set: safety_detail {
    fields: [
      req_id,
      req_asil,
      req_safety_related,
      req_cyber,
      req_regulation,
      req_security_level
    ]
  }
}
