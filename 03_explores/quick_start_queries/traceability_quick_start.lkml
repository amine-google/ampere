# --------------------------------------------------------------------------
# Quick Start Queries for Explore A — Traceability
# --------------------------------------------------------------------------

explore: +traceability {
  query: coverage_by_myswf {
    label: "1. Requirement Coverage Rate by MySWF"
    description: "Shows distinct requirements, covered requirements, uncovered requirements, and coverage % by MySWF."
    dimensions: [project.req_mysf]
    measures: [
      requirement.requirement_count,
      requirement.covered_requirements_count,
      requirement.uncovered_requirements_count,
      requirement.requirement_coverage_rate,
      bridge_requirement_test_case.distinct_covering_tcs
    ]
    sorts: [requirement.requirement_count: desc]
  }

  query: coverage_by_asil_and_regulation {
    label: "2. Coverage by Safety Goal (ASIL) & Regulation"
    description: "Breaks down horizontal requirement coverage by ISO 26262 ASIL level and Regulation."
    dimensions: [safety.req_asil, safety.req_regulation]
    measures: [
      requirement.requirement_count,
      requirement.covered_requirements_count,
      requirement.requirement_coverage_rate
    ]
    sorts: [requirement.requirement_count: desc]
  }
}
