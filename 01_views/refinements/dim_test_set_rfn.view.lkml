include: "/01_views/sources/dim_test_set.view.lkml"

view: +dim_test_set {

  # =========================================================================
  # 1. KEYS (Primary & Foreign)
  # =========================================================================

  dimension: ts_id {
    primary_key: yes
    label: "Test Set ID"
    description: "Unique identifier of the Test Set campaign (1 row per TS_ID)."
  }

  dimension: ts_isp_id {
    label: "TS ISP ID"
    description: "Identifier of the Integrated Software Plan (ISP) linked to the Test Set."
  }

  # =========================================================================
  # 2. DIMENSIONS
  # =========================================================================

  dimension: ts_name {
    label: "Test Set Name"
    description: "Name of the Test Set campaign."
  }

  dimension: ts_status {
    label: "TS Status"
    description: "Lifecycle status of the Test Set."
  }

  dimension: ts_type {
    label: "TS Type"
    description: "Campaign classification of the Test Set."
  }

  dimension: ts_domain {
    label: "TS Domain"
    description: "Engineering domain of the Test Set."
  }

  dimension: ts_bench_id {
    label: "TS Bench ID"
    description: "Test bench identifier for the Test Set."
  }

  dimension: ts_bench_type {
    label: "TS Bench Type"
    description: "Bench environment category for the Test Set."
  }

  dimension: ts_items_under_test {
    label: "Items Under Test"
    description: "Components or subsystems under test."
  }

  dimension: ts_validation_team {
    label: "TS Validation Team"
    description: "Validation team assigned to the Test Set."
  }

  dimension: ts_vehicle_project {
    label: "TS Vehicle Project"
    description: "Target vehicle project for the Test Set campaign."
  }

  dimension: ts_baseline {
    label: "TS Baseline"
    description: "Baseline version of the Test Set."
  }

  dimension: ts_milestone {
    label: "TS Milestone"
    description: "Project milestone targeted by the Test Set."
  }

  dimension: ts_mysf {
    label: "TS MySWF"
    description: "MySWF release linked to the Test Set."
  }

  dimension: ts_pcu_releases {
    label: "PCU Releases"
    description: "PCU software release versions."
  }

  dimension: ts_piu_releases {
    label: "PIU Releases"
    description: "PIU software release versions."
  }

  dimension: ts_ivc_releases {
    label: "IVC Releases"
    description: "IVC software release versions."
  }

  dimension: ts_cdc_releases {
    label: "CDC Releases"
    description: "CDC software release versions."
  }

  dimension: ts_other_releases {
    label: "Other Releases"
    description: "Other ECU software release versions."
  }

  # =========================================================================
  # 3. MEASURES
  # =========================================================================

  measure: unique_ts_count {
    type: count_distinct
    label: "Total Test Sets (Distinct TS)"
    description: "Controlled distinct count of Test Sets (1 row per TS_ID)."
    sql: ${ts_id} ;;
    drill_fields: [ts_drill_set*]
  }

  # =========================================================================
  # 5. SETS
  # =========================================================================

  set: ts_drill_set {
    fields: [
      ts_id,
      ts_name,
      ts_status,
      ts_domain,
      ts_bench_type,
      ts_vehicle_project,
      ts_baseline,
      ts_milestone,
      ts_validation_team
    ]
  }
}
