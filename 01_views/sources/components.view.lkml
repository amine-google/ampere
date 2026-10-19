view:components {
  sql_table_name: @{DATASET_NAME}.components ;;

  # --------------------------------------------------------------------------
  # Raw Dimensions (1:1 Table Columns Mapping)
  # --------------------------------------------------------------------------

  dimension: component_pk {
    primary_key: yes
    type: string
    sql: CONCAT(COALESCE(${TABLE}.Req_ID, 'REQ'), '_', COALESCE(${TABLE}.Req_SW_Components, 'SWC')) ;;
    description: "Compound primary key uniquely identifying the requirement to software component mapping."
  }

  dimension: req_id {
    type: string
    sql: ${TABLE}.Req_ID ;;
    description: "Requirement identifier linking to the parent requirement."
  }

  dimension: req_mysf_name {
    type: string
    sql: ${TABLE}.Req_MySF_Name ;;
    description: "MySF (My Software Factory) component pipeline build or repository package name."
  }

  dimension: req_sw_components {
    type: string
    sql: ${TABLE}.Req_SW_Components ;;
    description: "Software component identifier or code symbol (e.g. SWC_BMS_SensorInterface)."
  }

  dimension: req_sw_components_name {
    type: string
    sql: ${TABLE}.Req_SW_Components_Name ;;
    description: "Human-readable descriptive name of the software component."
  }
}
