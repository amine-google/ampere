view:feature {
  sql_table_name: @{DATASET_NAME}.feature ;;

  # --------------------------------------------------------------------------
  # Raw Dimensions (1:1 Table Columns Mapping)
  # --------------------------------------------------------------------------

  dimension: req_feature_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.Req_Feature_Id ;;
    description: "Unique identifier for the vehicle product feature."
  }

  dimension: req_feature_cbid {
    type: string
    sql: ${TABLE}.Req_Feature_CBId ;;
    description: "Common baseline / codebase identifier for the feature."
  }

  dimension: req_feature {
    type: string
    sql: ${TABLE}.Req_Feature ;;
    description: "Descriptive name or summary of the vehicle feature."
  }
}
