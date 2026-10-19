view: requirement {
  sql_table_name: @{DATASET_NAME}.dim_requirement ;;

  # --------------------------------------------------------------------------
  # Raw Dimensions (1:1 Table Columns Mapping - 1 row per Requirement)
  # --------------------------------------------------------------------------

  dimension: req_id {
    primary_key: yes
    type: string
    sql: CAST(${TABLE}.Req_ID AS STRING) ;;
    description: "Unique identifier for the requirement (1 row per Requirement)."
  }

  dimension: req_name {
    type: string
    sql: ${TABLE}.Req_Name ;;
    description: "Title or short name of the requirement."
  }

  dimension: req_description {
    type: string
    sql: ${TABLE}.Req_Description ;;
    description: "Full textual description and specification of the requirement."
  }

  dimension: req_type {
    type: string
    sql: ${TABLE}.Req_Type ;;
    description: "Classification of requirement (e.g. Functional, System, Software, Safety)."
  }

  dimension: req_status {
    type: string
    sql: ${TABLE}.Req_Status ;;
    description: "Current lifecycle status (e.g. Draft, In Review, Approved, Implemented)."
  }

  dimension: req_final_status {
    type: string
    sql: ${TABLE}.Req_FinalStatus ;;
    description: "Consolidated final lifecycle status of the requirement."
  }

  dimension: req_creation_raw {
    type: string
    sql: ${TABLE}.Req_Creation ;;
    description: "Raw timestamp/date string when the requirement was created."
  }

  dimension: req_created_week {
    type: string
    sql: ${TABLE}.Req_CreatedWeek ;;
    description: "ISO year-week when the requirement was created."
  }

  dimension: req_update_raw {
    type: string
    sql: ${TABLE}.Req_Update ;;
    description: "Raw timestamp/date string when the requirement was last updated."
  }

  dimension: req_version {
    type: string
    sql: ${TABLE}.Req_Version ;;
    description: "Version or revision code of the requirement document."
  }

  dimension: req_categories {
    type: string
    sql: ${TABLE}.Req_Categories ;;
    description: "Categorical tagging for architecture, engineering, or subsystem domain."
  }

  dimension: req_requirement_category {
    type: string
    sql: ${TABLE}.Req_RequirementCategory ;;
    description: "Requirement functional category from SDV traceability schema."
  }

  dimension: req_validation_methods {
    type: string
    sql: ${TABLE}.Req_ValidationMethods ;;
    description: "Verification and validation methods assigned to the requirement (e.g. Test, Analysis, Inspection)."
  }

  dimension: req_validation_teams {
    type: string
    sql: ${TABLE}.Req_Validation_Teams ;;
    description: "Validation teams responsible for verifying the requirement."
  }

  dimension: req_supplier {
    type: string
    sql: ${TABLE}.Req_Supplier ;;
    description: "External tier-1 or software supplier associated with the requirement."
  }

  dimension: covered_status {
    type: string
    sql: ${TABLE}.Covered_Status ;;
    description: "Traceability coverage flag indicating whether the requirement is linked to at least one Test Case."
  }

  # --------------------------------------------------------------------------
  # Foreign Keys
  # --------------------------------------------------------------------------

  dimension: req_tracker_id {
    type: string
    sql: ${TABLE}.Req_Tracker_Id ;;
    description: "Foreign key referencing the associated tracker."
  }

  dimension: req_feature_id {
    type: string
    sql: ${TABLE}.Req_Feature_Id ;;
    description: "Foreign key referencing the associated product feature."
  }

  dimension: req_vehicle_project_id {
    type: string
    sql: ${TABLE}.Req_Vehicle_Project_Id ;;
    description: "Foreign key referencing the target vehicle engineering project."
  }

  dimension: req_isp_id {
    type: string
    sql: ${TABLE}.Req_ISP_Id ;;
    description: "Foreign key referencing the Integrated Software Plan (ISP) item."
  }

  dimension: req_baseline {
    type: string
    sql: ${TABLE}.Req_Baseline ;;
    description: "Foreign key referencing the requirement baseline."
  }
}
