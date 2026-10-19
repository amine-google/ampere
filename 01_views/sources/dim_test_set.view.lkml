view: dim_test_set {
  sql_table_name: @{DATASET_NAME}.dim_test_set ;;

  # --------------------------------------------------------------------------
  # Raw Dimensions (1:1 Table Columns Mapping - 1 row per Test Set)
  # --------------------------------------------------------------------------

  dimension: ts_id {
    primary_key: yes
    type: string
    sql: CAST(${TABLE}.TS_Id AS STRING) ;;
    description: "Unique identifier of the Test Set campaign/configuration (1 row per Test Set)."
  }

  dimension: ts_name {
    type: string
    sql: ${TABLE}.TS_Name ;;
    description: "Descriptive title of the Test Set campaign."
  }

  dimension: ts_status {
    type: string
    sql: ${TABLE}.TS_Status ;;
    description: "Lifecycle status of the Test Set (e.g. Active, Ready, Closed, Draft)."
  }

  dimension: ts_type {
    type: string
    sql: ${TABLE}.TS_Type ;;
    description: "Classification type of the Test Set campaign."
  }

  dimension: ts_domain {
    type: string
    sql: ${TABLE}.TS_Domain ;;
    description: "Engineering domain owning the Test Set."
  }

  dimension: ts_bench_id {
    type: string
    sql: CAST(${TABLE}.TS_Bench_Id AS STRING) ;;
    description: "Identifier of the physical or virtual test bench assigned to the Test Set."
  }

  dimension: ts_bench_type {
    type: string
    sql: ${TABLE}.TS_Bench_Type ;;
    description: "Test bench environment category for the Test Set."
  }

  dimension: ts_items_under_test {
    type: string
    sql: ${TABLE}.TS_Items_Under_Test ;;
    description: "Hardware/software items under test in this Test Set."
  }

  dimension: ts_validation_team {
    type: string
    sql: ${TABLE}.TS_Validation_Team ;;
    description: "Validation team responsible for executing the Test Set."
  }

  dimension: ts_vehicle_project {
    type: string
    sql: ${TABLE}.TS_Vehicle_Project ;;
    description: "Vehicle project targeted by the Test Set campaign."
  }

  dimension: ts_baseline {
    type: string
    sql: ${TABLE}.TS_Baseline ;;
    description: "Baseline identifier associated with the Test Set."
  }

  dimension: ts_milestone {
    type: string
    sql: ${TABLE}.TS_Milestone ;;
    description: "Project milestone targeted by the Test Set."
  }

  dimension: ts_mysf {
    type: string
    sql: ${TABLE}.TS_MySF ;;
    description: "MySWF software function release associated with the Test Set."
  }

  dimension: ts_isp_id {
    type: string
    sql: ${TABLE}.TS_ISP_Id ;;
    description: "Foreign key linking the Test Set to its Integrated Software Plan (ISP) record."
  }

  # --------------------------------------------------------------------------
  # Fix Version & ECU Release Attributes
  # --------------------------------------------------------------------------

  dimension: ts_pcu_releases {
    type: string
    sql: ${TABLE}.TS_PCU_Releases ;;
    description: "Powertrain Control Unit (PCU) software release version tested."
  }

  dimension: ts_piu_releases {
    type: string
    sql: ${TABLE}.TS_PIU_Releases ;;
    description: "Power Inverter Unit (PIU) software release version tested."
  }

  dimension: ts_ivc_releases {
    type: string
    sql: ${TABLE}.TS_IVC_Releases ;;
    description: "In-Vehicle Computer (IVC) software release version tested."
  }

  dimension: ts_cdc_releases {
    type: string
    sql: ${TABLE}.TS_CDC_Releases ;;
    description: "Cockpit Domain Controller (CDC) software release version tested."
  }

  dimension: ts_other_releases {
    type: string
    sql: ${TABLE}.TS_Other_Releases ;;
    description: "Other ECU software release versions associated with the Test Set."
  }
}
