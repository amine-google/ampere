view: dim_fix_version {
  sql_table_name: @{DATASET_NAME}.dim_fix_version ;;

  # --------------------------------------------------------------------------
  # Raw Dimensions (1:1 Table Columns Mapping - 1 row per Fix Version)
  # --------------------------------------------------------------------------

  dimension: fix_version_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.Fix_Version_Id ;;
    description: "Unique identifier of the software Fix Version / Release configuration."
  }

  dimension: ts_id {
    type: string
    sql: CAST(${TABLE}.TS_Id AS STRING) ;;
    description: "Foreign key linking the Fix Version to its Test Set (TS_ID)."
  }

  dimension: issue_fix_version {
    type: string
    sql: ${TABLE}.Issue_Fix_Version ;;
    description: "Target fix version string recorded on issues and test sets."
  }

  dimension: ts_pcu_releases {
    type: string
    sql: ${TABLE}.TS_PCU_Releases ;;
    description: "PCU release version included in this Fix Version configuration."
  }

  dimension: ts_piu_releases {
    type: string
    sql: ${TABLE}.TS_PIU_Releases ;;
    description: "PIU release version included in this Fix Version configuration."
  }

  dimension: ts_ivc_releases {
    type: string
    sql: ${TABLE}.TS_IVC_Releases ;;
    description: "IVC release version included in this Fix Version configuration."
  }

  dimension: ts_cdc_releases {
    type: string
    sql: ${TABLE}.TS_CDC_Releases ;;
    description: "CDC release version included in this Fix Version configuration."
  }

  dimension: ts_other_releases {
    type: string
    sql: ${TABLE}.TS_Other_Releases ;;
    description: "Additional ECU software releases in this Fix Version configuration."
  }
}
