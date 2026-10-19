view:base_audit {
  extension: required

  dimension_group: record_created {
    type: time
    timeframes: [raw, time, date, week, month]
    sql: CAST(${TABLE}.created_at AS TIMESTAMP) ;;
    description: "Generic record creation audit timestamp."
  }

  dimension_group: record_updated {
    type: time
    timeframes: [raw, time, date, week, month]
    sql: CAST(${TABLE}.updated_at AS TIMESTAMP) ;;
    description: "Generic record last modification audit timestamp."
  }
}
