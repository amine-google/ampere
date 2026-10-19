include: "/01_views/sources/dim_issue.view.lkml"

view: +dim_issue {

  # =========================================================================
  # 1. KEYS
  # =========================================================================

  dimension: issue_id {
    primary_key: yes
    label: "Issue ID"
    description: "Unique identifier of the defect/issue ticket."
  }

  dimension: issue_cb_id {
    label: "Issue Codebeamer ID"
    description: "Internal Codebeamer numerical ID of the issue."
  }

  # =========================================================================
  # 2. DIMENSIONS
  # =========================================================================

  dimension: issue_summary {
    label: "Issue Summary"
    description: "Short title or description of the defect."
  }

  dimension: issue_status {
    label: "Issue Status"
    description: "Lifecycle status of the defect (Open, In Progress, Closed, Verified, Integrated, Invalid, Derogated)."
  }

  dimension: issue_criticity {
    label: "Issue Criticity"
    description: "Severity level of the defect (Blocker, Critical, Major, Minor)."
  }

  dimension: issue_resolution {
    label: "Issue Resolution"
    description: "Resolution outcome of the defect."
  }

  dimension: issue_fix_version {
    label: "Issue Fix Version"
    description: "Software fix version resolving the defect."
  }

  dimension: issue_url {
    label: "Issue Tracker URL"
    description: "Direct link to the issue ticket."
  }

  dimension: formatted_issue_badge {
    type: string
    label: "Issue Badge (ID + Criticity + Status)"
    sql: CONCAT(${issue_id}, ' (', COALESCE(${issue_criticity}, 'N/A'), ', ', COALESCE(${issue_status}, 'N/A'), ')') ;;
    description: "Formatted issue string used by Spotfire Concatenate([Issue_Id],' (',[Issue_Criticity],', ',[Issue_Status],')')."
  }

  # =========================================================================
  # 3. MEASURES
  # =========================================================================

  measure: unique_issue_count {
    type: count_distinct
    label: "Total Issues (Distinct)"
    description: "Count of distinct defect tickets."
    sql: ${issue_id} ;;
    drill_fields: [issue_drill_set*]
  }

  measure: failed_last_run_issues_list {
    type: list
    label: "Linked Issues List (ID, Criticity, Status)"
    list_field: formatted_issue_badge
    description: "Spotfire UniqueConcatenate([Issue_Id] ([Issue_Criticity], [Issue_Status])) across grouped rows."
  }

  # =========================================================================
  # 5. SETS
  # =========================================================================

  set: issue_drill_set {
    fields: [
      issue_id,
      issue_summary,
      issue_criticity,
      issue_status,
      issue_resolution,
      issue_fix_version
    ]
  }
}
