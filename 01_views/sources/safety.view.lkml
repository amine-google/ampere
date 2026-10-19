view:safety {
  sql_table_name: @{DATASET_NAME}.safety ;;

  # --------------------------------------------------------------------------
  # Raw Dimensions (1:1 Table Columns Mapping)
  # --------------------------------------------------------------------------

  dimension: req_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.Req_ID ;;
    description: "Requirement identifier linking to the parent requirement."
  }

  dimension: req_asil {
    type: string
    sql: ${TABLE}.Req_ASIL ;;
    description: "Automotive Safety Integrity Level classification under ISO 26262 (QM, ASIL A, ASIL B, ASIL C, ASIL D)."
  }

  dimension: req_safety_related {
    type: string
    sql: ${TABLE}.Req_Safety_Related ;;
    description: "Flag indicating whether requirement has functional safety impact (Yes/No or True/False)."
  }

  dimension: req_cyber {
    type: string
    sql: ${TABLE}.Req_Cyber ;;
    description: "Flag indicating whether requirement pertains to vehicle cybersecurity (ISO/SAE 21434)."
  }

  dimension: req_regulation {
    type: string
    sql: ${TABLE}.Req_Regulation ;;
    description: "Regulatory standard or legal homologation mandate (e.g. UN ECE R155/R156, FMVSS)."
  }

  dimension: req_security_level {
    type: string
    sql: ${TABLE}.Req_Security_Level ;;
    description: "Cybersecurity Assurance Level or Security Target rating (CAL 1 through CAL 4)."
  }
}
