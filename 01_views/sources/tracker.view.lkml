view:tracker {
  sql_table_name: @{DATASET_NAME}.tracker ;;

  # --------------------------------------------------------------------------
  # Raw Dimensions (1:1 Table Columns Mapping)
  # --------------------------------------------------------------------------

  dimension: req_tracker_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.Req_Tracker_Id ;;
    description: "Primary key identifier for the tracking system entry or project board."
  }

  dimension: req_tracker {
    type: string
    sql: ${TABLE}.Req_Tracker ;;
    description: "Tracker system name, type, or URL (e.g. Polarion, Jira, Doors NG)."
  }
}
