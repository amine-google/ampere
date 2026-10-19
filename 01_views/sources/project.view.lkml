view:project {
  sql_table_name: @{DATASET_NAME}.project ;;

  # --------------------------------------------------------------------------
  # Raw Dimensions (1:1 Table Columns Mapping)
  # --------------------------------------------------------------------------

  dimension: req_vehicle_project_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.Req_Vehicle_Project_Id ;;
    description: "Unique program code or identifier for the vehicle development project."
  }

  dimension: req_vehicle_project {
    type: string
    sql: ${TABLE}.Req_Vehicle_Project ;;
    description: "Commercial or internal vehicle project name (e.g. Ampere Small, Alpine GT)."
  }

  dimension: req_cbproject_name {
    type: string
    sql: ${TABLE}.Req_CBProjectName ;;
    description: "Codebase project repository name."
  }

  dimension: req_planned_for_raw {
    type: string
    sql: ${TABLE}.Req_PlannedFor ;;
    description: "Milestone or release cycle planned for initial delivery."
  }

  dimension: req_mysf {
    type: string
    sql: ${TABLE}.Req_MySF ;;
    description: "My Software Factory (MySF) release branch or configuration tag."
  }

  dimension: req_baseline {
    type: string
    sql: ${TABLE}.Req_Baseline ;;
    description: "Official vehicle engineering baseline version (e.g. BL_2026_Q2)."
  }

  dimension: req_sweet {
    type: string
    sql: ${TABLE}.Req_SWEET ;;
    description: "Software Execution & Environment Tooling configuration identifier."
  }

  dimension: req_target_planned_for_raw {
    type: string
    sql: ${TABLE}.Req_TargetPlannedFor ;;
    description: "Target milestone or SOP (Start of Production) deployment schedule."
  }

  dimension: req_obsolete_from_raw {
    type: string
    sql: ${TABLE}.Req_ObsoleteFrom ;;
    description: "Milestone or phase-out date from which this project configuration is obsolete."
  }
}
