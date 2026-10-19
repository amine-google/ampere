view: dim_isp {
  sql_table_name: @{DATASET_NAME}.dim_isp ;;

  # --------------------------------------------------------------------------
  # Raw Dimensions (1:1 Table Columns Mapping - 1 row per ISP item)
  # --------------------------------------------------------------------------

  dimension: isp_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.Req_ISP_Id ;;
    description: "Unique identifier of the Integrated Software Plan (ISP) item."
  }

  dimension: isp_cb_id {
    type: string
    sql: CAST(${TABLE}.Req_ISP_CBId AS STRING) ;;
    description: "Codebeamer internal ID of the ISP item."
  }

  dimension: isp_summary {
    type: string
    sql: ${TABLE}.Req_ISP_Summary ;;
    description: "Summary title of the ISP planning item."
  }

  dimension: isp_status {
    type: string
    sql: ${TABLE}.Req_ISP_Status ;;
    description: "Lifecycle status of the ISP item."
  }

  dimension: isp_resolution {
    type: string
    sql: ${TABLE}.Req_ISP_Resolution ;;
    description: "Resolution state of the ISP item."
  }

  dimension: isp_fix_version {
    type: string
    sql: ${TABLE}.Req_ISP_Fix_Version ;;
    description: "Target software fix version linked to the ISP item."
  }

  dimension: isp_committed_sprint {
    type: string
    sql: ${TABLE}.Req_ISP_Committed_Sprint ;;
    description: "Agile sprint committed to delivering the ISP item."
  }

  dimension: isp_requested_planning {
    type: string
    sql: ${TABLE}.Req_ISP_Requested_Planning ;;
    description: "Requested target milestone or planning window for the ISP item."
  }

  dimension: isp_validation_team {
    type: string
    sql: ${TABLE}.Req_ISP_Validation_Team ;;
    description: "Validation team assigned to the ISP item."
  }

  dimension: isp_train_in_charge {
    type: string
    sql: ${TABLE}.Req_ISP_Train_In_Charge ;;
    description: "Agile Release Train (ART) in charge of the ISP item."
  }

  dimension: isp_domain_in_charge {
    type: string
    sql: ${TABLE}.Req_ISP_Domain_In_Charge ;;
    description: "Engineering domain in charge of delivering the ISP item."
  }

  dimension: isp_impacted_train {
    type: string
    sql: ${TABLE}.Req_ISP_Impacted_Train ;;
    description: "Downstream Agile Release Train impacted by the ISP item."
  }

  dimension: isp_brand {
    type: string
    sql: ${TABLE}.Req_ISP_Brand ;;
    description: "Vehicle brand associated with the ISP item."
  }

  dimension: baseline_id {
    type: string
    sql: ${TABLE}.Req_Baseline ;;
    description: "Foreign key linking the ISP item to its target Baseline."
  }
}
