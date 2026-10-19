view: dim_test_case {
  sql_table_name: @{DATASET_NAME}.dim_test_case ;;

  # --------------------------------------------------------------------------
  # Raw Dimensions (1:1 Table Columns Mapping - 1 row per Test Case)
  # --------------------------------------------------------------------------

  dimension: tc_id {
    primary_key: yes
    type: string
    sql: CAST(${TABLE}.TC_Id AS STRING) ;;
    description: "Unique identifier of the Test Case (1 row per Test Case)."
  }

  dimension: tc_uid {
    type: string
    sql: ${TABLE}.TC_UID ;;
    description: "Universal unique code of the Test Case across Codebeamer/ALM trackers."
  }

  dimension: tc_name {
    type: string
    sql: ${TABLE}.TC_Name ;;
    description: "Title or short descriptive name of the Test Case."
  }

  dimension: tc_status {
    type: string
    sql: ${TABLE}.TC_Status ;;
    description: "Authoring lifecycle status of the Test Case (e.g. Accepted, Approved, Rework, Draft)."
  }

  dimension: tc_type {
    type: string
    sql: ${TABLE}.TC_Type ;;
    description: "Classification of the Test Case (e.g. Functional, Integration, Regression, Safety)."
  }

  dimension: tc_domain {
    type: string
    sql: ${TABLE}.TC_Domain ;;
    description: "Engineering domain responsible for the Test Case."
  }

  dimension: tc_bench_type {
    type: string
    sql: ${TABLE}.TC_Bench_Type ;;
    description: "Target test bench environment (e.g. HIL, SIL, VIL, Vehicle, Labcar)."
  }

  dimension: tc_execution_organization {
    type: string
    sql: ${TABLE}.TC_Execution_Organization ;;
    description: "Organization or team responsible for executing the Test Case (e.g. Internal, Supplier, Backlog, Descoped)."
  }

  dimension: tc_feature {
    type: string
    sql: ${TABLE}.TC_Feature ;;
    description: "Vehicle or software feature validated by the Test Case."
  }

  dimension: tc_dut {
    type: string
    sql: ${TABLE}.TC_DUT ;;
    description: "Device Under Test (DUT) or ECU targeted by the Test Case."
  }

  dimension: tc_cb_project_name {
    type: string
    sql: ${TABLE}.TC_CBProjectName ;;
    description: "Codebeamer project space hosting the Test Case."
  }

  dimension: tc_vehicle_project {
    type: string
    sql: ${TABLE}.TC_Vehicle_Project ;;
    description: "Target vehicle project associated with the Test Case."
  }

  dimension: tc_estimated_duration {
    type: number
    sql: ${TABLE}.TC_Estimated_Duration ;;
    description: "Estimated execution duration of the Test Case in minutes."
  }

  dimension: tc_domain_leader {
    type: string
    sql: ${TABLE}.TC_Domain_Leader ;;
    description: "Engineering domain leader accountable for the Test Case."
  }

  dimension: tc_validation_leader {
    type: string
    sql: ${TABLE}.TC_Validation_Leader ;;
    description: "Validation leader accountable for the Test Case execution campaign."
  }

  dimension: tc_validation_team {
    type: string
    sql: ${TABLE}.TC_Validation_Team ;;
    description: "Validation team assigned to author and execute the Test Case."
  }

  dimension: tc_system_owner {
    type: string
    sql: ${TABLE}.TC_System_Owner ;;
    description: "System owner responsible for the function tested by this Test Case."
  }

  dimension: tc_engineering_level {
    type: string
    sql: ${TABLE}.TC_Engineering_Level ;;
    description: "V-cycle engineering level of the Test Case (e.g. System, SW Architecture, SW Unit)."
  }

  dimension: tc_security_level {
    type: string
    sql: ${TABLE}.TC_Security_level ;;
    description: "Confidentiality and cybersecurity classification level of the Test Case."
  }

  dimension: tc_created_week {
    type: string
    sql: ${TABLE}.TC_CreatedWeek ;;
    description: "ISO year-week when the Test Case was created."
  }

  dimension: tc_last_update {
    type: string
    sql: ${TABLE}.TC_LastUpdate ;;
    description: "Timestamp string of the most recent modification to the Test Case."
  }

  dimension: tc_brand {
    type: string
    sql: ${TABLE}.TC_Brand ;;
    description: "Vehicle brand applicability for the Test Case."
  }

  dimension: tc_capitalization {
    type: number
    sql: ${TABLE}.TC_Capitalization ;;
    description: "Capitalization metric or reuse score of the Test Case."
  }

  dimension: tc_additional_information {
    type: string
    sql: ${TABLE}.TC_Additional_Information ;;
    description: "Supplemental notes and metadata attached to the Test Case."
  }

  # --------------------------------------------------------------------------
  # Automation Request Attributes
  # --------------------------------------------------------------------------

  dimension: automation_id {
    type: string
    sql: CAST(${TABLE}.Automation_Id AS STRING) ;;
    description: "Unique identifier of the associated test automation request."
  }

  dimension: automation_name {
    type: string
    sql: ${TABLE}.Automation_Name ;;
    description: "Title of the automated test script or automation request."
  }

  dimension: automation_status {
    type: string
    sql: ${TABLE}.Automation_Status ;;
    description: "Lifecycle status of the test automation development (e.g. Automated, In Progress, Candidate)."
  }

  dimension: automation_bench_type {
    type: string
    sql: ${TABLE}.Automation_Bench_Type ;;
    description: "Bench type targeted by the automated test script."
  }

  dimension: automation_framework {
    type: string
    sql: ${TABLE}.Automation_Framework ;;
    description: "Test automation execution framework (e.g. RobotFramework, PyTest, CAPL)."
  }

  dimension: automation_reference_ticket {
    type: string
    sql: ${TABLE}.Automation_Reference_Ticket ;;
    description: "Reference ticket ID for the automation development task."
  }

  dimension: automation_validation_team {
    type: string
    sql: ${TABLE}.Automation_Validation_Team ;;
    description: "Team responsible for validating the automated test script."
  }

  dimension: update_date_data_raw {
    type: string
    sql: CAST(${TABLE}.UpdateDateData AS STRING) ;;
    description: "Raw ETL extraction timestamp for the Test Case record."
  }
}
