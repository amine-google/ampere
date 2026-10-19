view: dim_issue {
  sql_table_name: @{DATASET_NAME}.dim_issue ;;

  # --------------------------------------------------------------------------
  # Raw Dimensions (1:1 Table Columns Mapping - 1 row per Issue)
  # --------------------------------------------------------------------------

  dimension: issue_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.Issue_Id ;;
    description: "Unique identifier of the defect/issue linked to failed or blocked Test Runs."
  }

  dimension: issue_cb_id {
    type: string
    sql: CAST(${TABLE}.Issue_CBId AS STRING) ;;
    description: "Codebeamer internal numerical ID of the issue."
  }

  dimension: issue_summary {
    type: string
    sql: ${TABLE}.Issue_Summary ;;
    description: "Title or summary description of the defect/issue."
  }

  dimension: issue_status {
    type: string
    sql: ${TABLE}.Issue_Status ;;
    description: "Current resolution lifecycle status of the issue (e.g. Open, In Progress, Closed, Verified, Integrated, Invalid, Derogated)."
  }

  dimension: issue_criticity {
    type: string
    sql: ${TABLE}.Issue_Criticity ;;
    description: "Severity or criticality level of the defect (e.g. Blocker, Critical, Major, Minor)."
  }

  dimension: issue_resolution {
    type: string
    sql: ${TABLE}.Issue_Resolution ;;
    description: "Resolution outcome code of the issue (e.g. Fixed, Won't Fix, Duplicate, Derogated)."
  }

  dimension: issue_fix_version {
    type: string
    sql: ${TABLE}.Issue_Fix_Version ;;
    description: "Target software fix version resolving the defect."
  }

  dimension: issue_url {
    type: string
    sql: ${TABLE}.issue_url ;;
    description: "Direct URL link to the issue ticket in the ALM/Codebeamer tracker."
  }
}
