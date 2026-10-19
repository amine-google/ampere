view:ownership {
  sql_table_name: @{DATASET_NAME}.ownership ;;

  # --------------------------------------------------------------------------
  # Raw Dimensions (1:1 Table Columns Mapping)
  # --------------------------------------------------------------------------

  dimension: req_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.Req_ID ;;
    description: "Requirement identifier linking to the parent requirement."
  }

  dimension: req_system_owner {
    type: string
    sql: ${TABLE}.Req_System_Owner ;;
    description: "System architect or lead engineer responsible for the requirement."
  }

  dimension: req_domain {
    type: string
    sql: ${TABLE}.Req_Domain ;;
    description: "High-level vehicle engineering domain (e.g. Powertrain, ADAS, Infotainment, Chassis)."
  }

  dimension: req_sub_domain {
    type: string
    sql: ${TABLE}.Req_Sub_Domain ;;
    description: "Sub-domain specialization (e.g. Battery Management, Autonomous Braking, Telematics)."
  }

  dimension: req_engineering_level {
    type: string
    sql: ${TABLE}.Req_Engineering_Level ;;
    description: "Engineering hierarchy tier (e.g. L1 Vehicle, L2 System, L3 Subsystem, L4 Component)."
  }

  dimension: req_allocation {
    type: string
    sql: ${TABLE}.Req_Allocation ;;
    description: "Implementation discipline allocation (e.g. Software, Hardware, Mechanical, Cloud)."
  }
}
