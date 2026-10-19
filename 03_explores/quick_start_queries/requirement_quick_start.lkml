# --------------------------------------------------------------------------
# Quick Start Queries: Curated One-Click Starter Queries for Explores
# --------------------------------------------------------------------------

explore: +requirement {
  query: requirements_by_status {
    description: "Breakdown of requirements by lifecycle status and approval rate."
    dimensions: [requirement.req_status]
    measures: [requirement.requirement_count, requirement.approval_rate]
    sorts: [requirement.requirement_count: desc]
  }

  query: safety_critical_summary {
    description: "Overview of safety-critical requirements grouped by ASIL rating."
    dimensions: [safety.req_asil]
    measures: [safety.safety_record_count, safety.safety_critical_count]
    filters: [safety.is_safety_critical: "yes"]
    sorts: [safety.safety_record_count: desc]
  }

  query: domain_breakdown {
    description: "Requirements distribution across engineering domains and system owners."
    dimensions: [ownership.req_domain, ownership.req_system_owner]
    measures: [requirement.requirement_count, requirement.approved_count]
    sorts: [requirement.requirement_count: desc]
  }
}
