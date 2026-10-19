- dashboard: requirements_overview
  title: "Ampere Requirements Engineering Overview"
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  description: "Executive and engineering overview of vehicle requirements, lifecycle status, safety integrity (ASIL), and domain allocations."

  tabs:
    - name: tab_requirements_overview
      label: "1. Requirements & Safety Overview"

  elements:
    - title: "Total Requirements"
      name: total_requirements
      tab_name: tab_requirements_overview
      model: ampere_analytics
      explore: traceability
      type: single_value
      fields: [requirement.requirement_count]
      limit: 500
      row: 0
      col: 0
      width: 6
      height: 4

    - title: "Approval Rate"
      name: approval_rate
      tab_name: tab_requirements_overview
      model: ampere_analytics
      explore: traceability
      type: single_value
      fields: [requirement.approval_rate]
      limit: 500
      row: 0
      col: 6
      width: 6
      height: 4

    - title: "Requirement Coverage Rate (%)"
      name: requirement_coverage_rate
      tab_name: tab_requirements_overview
      model: ampere_analytics
      explore: traceability
      type: single_value
      fields: [requirement.requirement_coverage_rate]
      limit: 500
      row: 0
      col: 12
      width: 6
      height: 4

    - title: "ASIL D Safety Critical Requirements"
      name: asil_d_requirements
      tab_name: tab_requirements_overview
      model: ampere_analytics
      explore: traceability
      type: single_value
      fields: [safety.asil_d_count]
      limit: 500
      row: 0
      col: 18
      width: 6
      height: 4

    - title: "Requirements by Lifecycle Status"
      name: status_distribution
      tab_name: tab_requirements_overview
      model: ampere_analytics
      explore: traceability
      type: looker_pie
      fields: [requirement.req_status, requirement.requirement_count]
      sorts: [requirement.requirement_count desc]
      limit: 500
      row: 4
      col: 0
      width: 12
      height: 8

    - title: "Requirements & Coverage by Engineering Domain"
      name: domain_breakdown
      tab_name: tab_requirements_overview
      model: ampere_analytics
      explore: traceability
      type: looker_column
      fields:
        - ownership.req_domain
        - requirement.requirement_count
        - requirement.covered_requirements_count
      sorts: [requirement.requirement_count desc]
      limit: 20
      row: 4
      col: 12
      width: 12
      height: 8

    - title: "Functional Safety ASIL Distribution"
      name: asil_distribution
      tab_name: tab_requirements_overview
      model: ampere_analytics
      explore: traceability
      type: looker_bar
      fields: [safety.req_asil, safety.safety_record_count]
      sorts: [safety.safety_record_count desc]
      limit: 10
      row: 12
      col: 0
      width: 12
      height: 8

    - title: "Requirements Traceability Matrix (Details-on-Demand)"
      name: traceability_matrix
      tab_name: tab_requirements_overview
      model: ampere_analytics
      explore: traceability
      type: looker_grid
      fields: [
        requirement.req_id,
        requirement.req_name,
        requirement.req_type,
        requirement.req_status,
        requirement.covered_status,
        bridge_requirement_test_case.distinct_covering_tcs,
        safety.req_asil,
        ownership.req_domain,
        project.req_mysf,
        project.req_vehicle_project
      ]
      sorts: [requirement.req_id asc]
      limit: 100
      row: 12
      col: 12
      width: 12
      height: 8
