view:hierarchy {
  sql_table_name: @{DATASET_NAME}.hierarchy ;;

  # --------------------------------------------------------------------------
  # Raw Dimensions (1:1 Table Columns Mapping)
  # --------------------------------------------------------------------------

  dimension: hierarchy_pk {
    primary_key: yes
    type: string
    sql: CONCAT(COALESCE(${TABLE}.Req_Requirement_Parent_Id, 'ROOT'), '_', COALESCE(${TABLE}.Req_Requirement_Child_Id, 'NONE')) ;;
    description: "Compound primary key uniquely identifying the parent-child relationship link."
  }

  dimension: req_id {
    type: string
    sql: ${TABLE}.Req_ID ;;
    description: "Requirement identifier linking to the requirement table."
  }

  dimension: req_child_required {
    type: string
    sql: ${TABLE}.Req_Child_Required ;;
    description: "Indicates whether decomposition into child requirements is mandatory (Yes/No)."
  }

  dimension: req_requirement_parent_id {
    type: string
    sql: ${TABLE}.Req_Requirement_Parent_Id ;;
    description: "Identifier of the parent requirement in the engineering hierarchy."
  }

  dimension: req_requirement_parent {
    type: string
    sql: ${TABLE}.Req_Requirement_Parent ;;
    description: "Name or title of the parent requirement."
  }

  dimension: req_requirement_parent_level {
    type: string
    sql: ${TABLE}.Req_Requirement_Parent_Level ;;
    description: "Architectural hierarchy level of the parent requirement (e.g. L1 System, L2 Subsystem)."
  }

  dimension: req_requirement_child_id {
    type: string
    sql: ${TABLE}.Req_Requirement_Child_Id ;;
    description: "Identifier of the decomposed child requirement."
  }

  dimension: req_requirement_child_name {
    type: string
    sql: ${TABLE}.Req_Requirement_Child_Name ;;
    description: "Name or title of the decomposed child requirement."
  }

  dimension: req_requirement_child_level {
    type: string
    sql: ${TABLE}.Req_Requirement_Child_Level ;;
    description: "Architectural hierarchy level of the child requirement (e.g. L3 Component, L4 Module)."
  }
}
