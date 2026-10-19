include: "/01_views/sources/dim_fix_version.view.lkml"

view: +dim_fix_version {

  # =========================================================================
  # 1. KEYS
  # =========================================================================

  dimension: fix_version_id {
    primary_key: yes
    label: "Fix Version ID"
    description: "Unique identifier of the Fix Version release configuration."
  }

  dimension: ts_id {
    label: "Linked Test Set ID"
    description: "Foreign key referencing the Test Set."
  }

  # =========================================================================
  # 2. DIMENSIONS
  # =========================================================================

  dimension: issue_fix_version {
    label: "Fix Version Name"
    description: "Software fix version name."
  }

  dimension: ts_pcu_releases {
    label: "PCU Release"
    description: "Powertrain Control Unit (PCU) software release."
  }

  dimension: ts_piu_releases {
    label: "PIU Release"
    description: "Power Inverter Unit (PIU) software release."
  }

  dimension: ts_ivc_releases {
    label: "IVC Release"
    description: "In-Vehicle Computer (IVC) software release."
  }

  dimension: ts_cdc_releases {
    label: "CDC Release"
    description: "Cockpit Domain Controller (CDC) software release."
  }

  dimension: ts_other_releases {
    label: "Other ECU Releases"
    description: "Additional ECU software releases."
  }

  # =========================================================================
  # 3. MEASURES
  # =========================================================================

  measure: unique_fix_version_count {
    type: count_distinct
    label: "Total Fix Versions (Distinct)"
    description: "Count of distinct software Fix Version configurations."
    sql: ${fix_version_id} ;;
    drill_fields: [fix_version_id, issue_fix_version, ts_pcu_releases, ts_ivc_releases, ts_cdc_releases]
  }
}
