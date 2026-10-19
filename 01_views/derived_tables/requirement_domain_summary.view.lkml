view:requirement_domain_summary {
  description: "Native Derived Table (NDT) providing pre-aggregated domain-level requirements KPIs."

  derived_table: {
    explore_source: requirement {
      column: req_domain { field: ownership.req_domain }
      column: total_requirements { field: requirement.requirement_count }
      column: approved_requirements { field: requirement.approved_count }
      column: approval_rate { field: requirement.approval_rate }
    }
    datagroup_trigger: ampere_etl_datagroup
  }

  # --------------------------------------------------------------------------
  # Dimensions
  # --------------------------------------------------------------------------

  dimension: req_domain {
    primary_key: yes
    label: "Engineering Domain"
    type: string
    description: "High-level vehicle engineering domain."
  }

  dimension: total_requirements {
    type: number
    label: "Total Requirements"
    description: "Rollup count of requirements allocated to this domain."
  }

  dimension: approved_requirements {
    type: number
    label: "Approved Requirements"
    description: "Rollup count of approved requirements."
  }

  dimension: approval_rate {
    type: number
    value_format_name: percent_1
    label: "Domain Approval Rate"
    description: "Approval percentage for this engineering domain."
  }

  # --------------------------------------------------------------------------
  # Measures
  # --------------------------------------------------------------------------

  measure: domain_count {
    type: count
    label: "Active Domains Count"
    description: "Total active engineering domains with requirements."
  }
}
