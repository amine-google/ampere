- dashboard: sdv_tc_runs_foundation
  title: "SDV TC Runs — Foundation (Traceability, Execution & Quality)"
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  description: "Migrated from Spotfire SDV_TC_Runs__Foundation.dxp using the canonical 3-Explore Looker Data Model (Explore C: tc_last_run & Explore B: execution). Consolidates the 7 Spotfire pages into 5 native Looker 26.4+ tabs."

  # --------------------------------------------------------------------------
  # Looker 26.4+ Native Built-In Dashboard Tabs (<= 5 Tabs Validator Rule)
  # --------------------------------------------------------------------------
  tabs:
    - name: tab_1_tc_last_runs_results
      label: "1. TC LAST RUNS Results"
    - name: tab_2_tc_all_runs
      label: "2. TC ALL Runs"
    - name: tab_3_tc_first_runs
      label: "3. TC First Runs"
    - name: tab_4_automation_runs
      label: "4. Automation & Runs"
    - name: tab_5_quality_overview
      label: "5. QUALITY (1/3, 2/3 & 3/3)"

  # --------------------------------------------------------------------------
  # Global & Dynamic Spotfire Document Property Filters
  # --------------------------------------------------------------------------
  filters:
    - name: tc_domain_filter
      title: "TC Domain"
      type: field_filter
      model: ampere_analytics
      explore: tc_last_run
      field: dim_test_case.tc_domain
      ui_config:
        type: tag_list
        display: popover

    - name: tc_status_filter
      title: "TC Status"
      type: field_filter
      default_value: "Accepted,Approved,Rework"
      model: ampere_analytics
      explore: tc_last_run
      field: dim_test_case.tc_status
      ui_config:
        type: tag_list
        display: popover

    - name: tc_bench_type_filter
      title: "TC Bench Type"
      type: field_filter
      model: ampere_analytics
      explore: tc_last_run
      field: dim_test_case.tc_bench_type
      ui_config:
        type: tag_list
        display: popover

    - name: tc_validation_team_filter
      title: "TC Validation Team"
      type: field_filter
      model: ampere_analytics
      explore: tc_last_run
      field: dim_test_case.tc_validation_team
      listens_to_filters: [tc_domain_filter]
      ui_config:
        type: tag_list
        display: popover

    - name: req_mysf_filter
      title: "Requirement MySWF"
      type: field_filter
      model: ampere_analytics
      explore: tc_last_run
      field: project.req_mysf
      ui_config:
        type: tag_list
        display: popover

    - name: ts_vehicle_project_filter
      title: "TS Vehicle Project"
      type: field_filter
      model: ampere_analytics
      explore: tc_last_run
      field: dim_test_set.ts_vehicle_project
      ui_config:
        type: tag_list
        display: popover

    - name: dynamic_tc_axis_selector
      title: "Group By Axis (tc.feature / RowsAxis)"
      type: field_filter
      default_value: "TC_Domain"
      model: ampere_analytics
      explore: tc_last_run
      field: dim_test_case.tc_axis_selector
      ui_config:
        type: dropdown_menu
        display: inline

    - name: dynamic_column_axis_selector
      title: "Cross-Table Column Axis (ColumnAxis)"
      type: field_filter
      default_value: "TC_Domain"
      model: ampere_analytics
      explore: tc_last_run
      field: dim_test_case.column_axis_selector
      ui_config:
        type: dropdown_menu
        display: inline

    - name: dynamic_items_count_selector
      title: "Cross-Table Metric (ItemsCount)"
      type: field_filter
      default_value: "TC_Id"
      model: ampere_analytics
      explore: tc_last_run
      field: fact_tc_latest_run.items_count_selector
      ui_config:
        type: dropdown_menu
        display: inline

  elements:
    # ========================================================================
    # TAB 1: TC LAST RUNS Results (Explore C: tc_last_run)
    # ========================================================================
    - name: kpi_last_run_total_tc
      title: "Total Test Cases (Last Run Scope)"
      tab_name: tab_1_tc_last_runs_results
      model: ampere_analytics
      explore: tc_last_run
      type: single_value
      fields: [fact_tc_latest_run.last_run_total_tc_count]
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        req_mysf_filter: project.req_mysf
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 0
      col: 0
      width: 4
      height: 4

    - name: kpi_last_run_passed_tc
      title: "Passed TCs (Last Run)"
      tab_name: tab_1_tc_last_runs_results
      model: ampere_analytics
      explore: tc_last_run
      type: single_value
      fields: [fact_tc_latest_run.last_run_passed_tc_count]
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        req_mysf_filter: project.req_mysf
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 0
      col: 4
      width: 4
      height: 4

    - name: kpi_last_run_failed_tc
      title: "Failed TCs (Last Run)"
      tab_name: tab_1_tc_last_runs_results
      model: ampere_analytics
      explore: tc_last_run
      type: single_value
      fields: [fact_tc_latest_run.last_run_failed_tc_count]
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        req_mysf_filter: project.req_mysf
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 0
      col: 8
      width: 4
      height: 4

    - name: kpi_last_run_blocked_tc
      title: "Blocked TCs (Last Run)"
      tab_name: tab_1_tc_last_runs_results
      model: ampere_analytics
      explore: tc_last_run
      type: single_value
      fields: [fact_tc_latest_run.last_run_blocked_tc_count]
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        req_mysf_filter: project.req_mysf
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 0
      col: 12
      width: 4
      height: 4

    - name: kpi_last_run_not_executed_tc
      title: "Not Executed TCs (Last Run)"
      tab_name: tab_1_tc_last_runs_results
      model: ampere_analytics
      explore: tc_last_run
      type: single_value
      fields: [fact_tc_latest_run.last_run_not_executed_tc_count]
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        req_mysf_filter: project.req_mysf
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 0
      col: 16
      width: 4
      height: 4

    - name: kpi_last_run_pass_rate
      title: "Last Run Pass Rate (%)"
      tab_name: tab_1_tc_last_runs_results
      model: ampere_analytics
      explore: tc_last_run
      type: single_value
      fields: [fact_tc_latest_run.last_run_pass_rate]
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        req_mysf_filter: project.req_mysf
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 0
      col: 20
      width: 4
      height: 4

    - name: chart_last_runs_results_bar
      title: "LAST Runs Results (by Dynamic Axis)"
      tab_name: tab_1_tc_last_runs_results
      model: ampere_analytics
      explore: tc_last_run
      type: looker_column
      fields:
        - dim_test_case.dynamic_tc_axis
        - fact_tc_latest_run.tr_result
        - fact_tc_latest_run.last_run_total_tc_count
      pivots: [fact_tc_latest_run.tr_result]
      stacking: normal
      sorts: [fact_tc_latest_run.last_run_total_tc_count desc 0]
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        req_mysf_filter: project.req_mysf
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
        dynamic_tc_axis_selector: dim_test_case.tc_axis_selector
      row: 4
      col: 0
      width: 10
      height: 8

    - name: chart_last_runs_results_pie
      title: "LAST Runs Results Distribution"
      tab_name: tab_1_tc_last_runs_results
      model: ampere_analytics
      explore: tc_last_run
      type: looker_pie
      fields:
        - fact_tc_latest_run.tr_result
        - fact_tc_latest_run.last_run_total_tc_count
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        req_mysf_filter: project.req_mysf
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 4
      col: 10
      width: 6
      height: 8

    - name: chart_last_run_week_bar
      title: "Last run week"
      tab_name: tab_1_tc_last_runs_results
      model: ampere_analytics
      explore: tc_last_run
      type: looker_column
      fields:
        - fact_tc_latest_run.tr_run_week
        - fact_tc_latest_run.tr_result
        - fact_tc_latest_run.last_run_total_tc_count
      pivots: [fact_tc_latest_run.tr_result]
      stacking: normal
      sorts: [fact_tc_latest_run.tr_run_week asc]
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        req_mysf_filter: project.req_mysf
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 4
      col: 16
      width: 8
      height: 8

    - name: table_last_runs_detailed_view
      title: "LAST Runs Results - Detailed View (Click Any Chart Bar/Slice Above to Cross-Filter)"
      tab_name: tab_1_tc_last_runs_results
      model: ampere_analytics
      explore: tc_last_run
      type: looker_grid
      fields:
        - dim_test_case.tc_id
        - dim_test_case.tc_name
        - dim_test_case.tc_domain
        - dim_test_case.tc_status
        - dim_test_case.tc_bench_type
        - dim_test_case.tc_feature
        - dim_test_case.tc_validation_team
        - fact_tc_latest_run.tr_result
        - fact_tc_latest_run.tr_run_week
        - fact_tc_latest_run.tr_last_run_date
        - dim_test_set.ts_id
        - dim_test_set.ts_name
        - dim_issue.failed_last_run_issues_list
      sorts: [dim_test_case.tc_id asc]
      limit: 500
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        req_mysf_filter: project.req_mysf
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 12
      col: 0
      width: 24
      height: 8

    # ========================================================================
    # TAB 2: TC ALL Runs (Explore B: execution)
    # ========================================================================
    - name: kpi_all_runs_total_tr
      title: "Total Executed Test Runs (All Runs)"
      tab_name: tab_2_tc_all_runs
      model: ampere_analytics
      explore: execution
      type: single_value
      fields: [dim_test_run.executed_tr_count]
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 0
      col: 0
      width: 8
      height: 4

    - name: kpi_all_runs_distinct_tc
      title: "Distinct Executed Test Cases"
      tab_name: tab_2_tc_all_runs
      model: ampere_analytics
      explore: execution
      type: single_value
      fields: [dim_test_run.distinct_executed_tc_count]
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 0
      col: 8
      width: 8
      height: 4

    - name: kpi_all_runs_pass_rate
      title: "Historical Run Pass Rate (%)"
      tab_name: tab_2_tc_all_runs
      model: ampere_analytics
      explore: execution
      type: single_value
      fields: [dim_test_run.tr_pass_rate]
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 0
      col: 16
      width: 8
      height: 4

    - name: chart_all_runs_week
      title: "All runs week (Historical Execution Trend)"
      tab_name: tab_2_tc_all_runs
      model: ampere_analytics
      explore: execution
      type: looker_column
      fields:
        - dim_test_run.tr_run_week
        - dim_test_run.tr_result
        - dim_test_run.executed_tr_count
      pivots: [dim_test_run.tr_result]
      stacking: normal
      sorts: [dim_test_run.tr_run_week asc]
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 4
      col: 0
      width: 24
      height: 8

    - name: table_all_runs_detailed_view
      title: "ALL Runs Results - Detailed View"
      tab_name: tab_2_tc_all_runs
      model: ampere_analytics
      explore: execution
      type: looker_grid
      fields:
        - dim_test_run.tr_id
        - dim_test_case.tc_id
        - dim_test_case.tc_name
        - dim_test_case.tc_domain
        - dim_test_case.tc_status
        - dim_test_set.ts_id
        - dim_test_set.ts_name
        - dim_test_run.tr_run_week
        - dim_test_run.tr_run_date
        - dim_test_run.tr_result
        - dim_issue.issue_id
        - dim_issue.issue_criticity
        - dim_issue.issue_status
      sorts: [dim_test_run.tr_run_week desc]
      limit: 500
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 12
      col: 0
      width: 24
      height: 8

    # ========================================================================
    # TAB 3: TC First Runs (Explore B: execution, filtered to is_first_run)
    # ========================================================================
    - name: kpi_first_runs_total
      title: "Total First Runs Executed"
      tab_name: tab_3_tc_first_runs
      model: ampere_analytics
      explore: execution
      type: single_value
      fields: [dim_test_run.first_runs_count]
      filters:
        dim_test_run.is_first_run: "yes"
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 0
      col: 0
      width: 8
      height: 4

    - name: chart_first_runs_pie
      title: "First runs (Verdict Breakdown)"
      tab_name: tab_3_tc_first_runs
      model: ampere_analytics
      explore: execution
      type: looker_pie
      fields:
        - dim_test_run.tr_result
        - dim_test_run.first_runs_count
      filters:
        dim_test_run.is_first_run: "yes"
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 0
      col: 8
      width: 16
      height: 6

    - name: chart_first_runs_week
      title: "First runs week"
      tab_name: tab_3_tc_first_runs
      model: ampere_analytics
      explore: execution
      type: looker_column
      fields:
        - dim_test_run.tr_run_week
        - dim_test_run.tr_result
        - dim_test_run.first_runs_count
      pivots: [dim_test_run.tr_result]
      stacking: normal
      filters:
        dim_test_run.is_first_run: "yes"
      sorts: [dim_test_run.tr_run_week asc]
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 6
      col: 0
      width: 24
      height: 7

    - name: table_first_runs_detailed_view
      title: "First runs Results - Detailed View"
      tab_name: tab_3_tc_first_runs
      model: ampere_analytics
      explore: execution
      type: looker_grid
      fields:
        - dim_test_run.tr_id
        - dim_test_case.tc_id
        - dim_test_case.tc_name
        - dim_test_case.tc_domain
        - dim_test_case.tc_status
        - dim_test_set.ts_id
        - dim_test_run.tr_run_week
        - dim_test_run.tr_run_date
        - dim_test_run.tr_result
        - dim_issue.issue_id
      filters:
        dim_test_run.is_first_run: "yes"
      sorts: [dim_test_run.tr_run_week desc]
      limit: 500
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 13
      col: 0
      width: 24
      height: 8

    # ========================================================================
    # TAB 4: Automation & Runs (Explore C: tc_last_run & Explore B: execution)
    # ========================================================================
    - name: kpi_automation_tc_count
      title: "TCs with Automation Request"
      tab_name: tab_4_automation_runs
      model: ampere_analytics
      explore: tc_last_run
      type: single_value
      fields: [dim_test_case.automated_tc_count]
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 0
      col: 0
      width: 12
      height: 4

    - name: kpi_automation_rate
      title: "Automation Request Coverage (%)"
      tab_name: tab_4_automation_runs
      model: ampere_analytics
      explore: tc_last_run
      type: single_value
      fields: [dim_test_case.automation_coverage_rate]
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 0
      col: 12
      width: 12
      height: 4

    - name: chart_auto_tc_in_ts_or_not
      title: "TC with an Auto Request in a TS or not"
      tab_name: tab_4_automation_runs
      model: ampere_analytics
      explore: tc_last_run
      type: looker_column
      fields:
        - dim_test_case.tc_domain
        - fact_tc_latest_run.auto_ts_runs
        - dim_test_case.automated_tc_count
      pivots: [fact_tc_latest_run.auto_ts_runs]
      stacking: normal
      filters:
        dim_test_case.has_automation_request: "yes"
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 4
      col: 0
      width: 8
      height: 8

    - name: chart_auto_last_runs_results
      title: "LAST Runs Results for TC with an Auto Request"
      tab_name: tab_4_automation_runs
      model: ampere_analytics
      explore: tc_last_run
      type: looker_column
      fields:
        - dim_test_case.tc_domain
        - fact_tc_latest_run.tr_result
        - fact_tc_latest_run.last_run_total_tc_count
      pivots: [fact_tc_latest_run.tr_result]
      stacking: normal
      filters:
        dim_test_case.has_automation_request: "yes"
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 4
      col: 8
      width: 8
      height: 8

    - name: chart_manual_vs_auto_runs_per_week
      title: "Nb of Manual / Automatics runs per week"
      tab_name: tab_4_automation_runs
      model: ampere_analytics
      explore: execution
      type: looker_column
      fields:
        - dim_test_run.tr_run_week
        - dim_test_case.has_automation_request
        - dim_test_run.executed_tr_count
      pivots: [dim_test_case.has_automation_request]
      stacking: normal
      sorts: [dim_test_run.tr_run_week asc]
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 4
      col: 16
      width: 8
      height: 8

    - name: table_automation_requests_detailed_view
      title: "Automation Requests - Detailed View"
      tab_name: tab_4_automation_runs
      model: ampere_analytics
      explore: tc_last_run
      type: looker_grid
      fields:
        - dim_test_case.tc_id
        - dim_test_case.tc_name
        - dim_test_case.tc_domain
        - dim_test_case.tc_status
        - dim_test_case.automation_id
        - dim_test_case.automation_name
        - dim_test_case.automation_status
        - dim_test_case.automation_framework
        - fact_tc_latest_run.auto_ts_runs
        - fact_tc_latest_run.tr_result
      filters:
        dim_test_case.has_automation_request: "yes"
      limit: 500
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 12
      col: 0
      width: 24
      height: 8

    # ========================================================================
    # TAB 5: QUALITY (Consolidating Spotfire QUALITY 1/3, 2/3 & 3/3)
    # ========================================================================
    - name: chart_quality_1_failed_without_issue
      title: "Quality 1/3 — Failed / blocked not linked to an issue"
      tab_name: tab_5_quality_overview
      model: ampere_analytics
      explore: tc_last_run
      type: looker_column
      fields:
        - dim_test_case.tc_domain
        - fact_tc_latest_run.failed_blocked_without_issue_tc_count
      sorts: [fact_tc_latest_run.failed_blocked_without_issue_tc_count desc]
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 0
      col: 0
      width: 8
      height: 7

    - name: chart_quality_1_failed_closed_issue
      title: "Quality 1/3 — Failed / blocked linked to Closed issue"
      tab_name: tab_5_quality_overview
      model: ampere_analytics
      explore: tc_last_run
      type: looker_column
      fields:
        - dim_test_case.tc_domain
        - fact_tc_latest_run.failed_blocked_closed_issue_tc_count
      sorts: [fact_tc_latest_run.failed_blocked_closed_issue_tc_count desc]
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 0
      col: 8
      width: 8
      height: 7

    - name: chart_quality_1_failed_derogated_issue
      title: "Quality 1/3 — Failed / blocked linked to Derogated issue"
      tab_name: tab_5_quality_overview
      model: ampere_analytics
      explore: tc_last_run
      type: looker_column
      fields:
        - dim_test_case.tc_domain
        - fact_tc_latest_run.failed_blocked_derogated_issue_tc_count
      sorts: [fact_tc_latest_run.failed_blocked_derogated_issue_tc_count desc]
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 0
      col: 16
      width: 8
      height: 7

    - name: chart_quality_2_tc_not_in_ts
      title: "Quality 2/3 — TC not in a TS (QUA_TC_in_TS)"
      tab_name: tab_5_quality_overview
      model: ampere_analytics
      explore: tc_last_run
      type: looker_column
      fields:
        - dim_test_case.tc_domain
        - fact_tc_latest_run.qua_tc_in_ts
        - fact_tc_latest_run.last_run_total_tc_count
      pivots: [fact_tc_latest_run.qua_tc_in_ts]
      stacking: normal
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 7
      col: 0
      width: 12
      height: 7

    - name: chart_quality_2_tc_not_ready_in_ts
      title: "Quality 2/3 — TC not ready in a TS (QUA_TC_NotReady)"
      tab_name: tab_5_quality_overview
      model: ampere_analytics
      explore: tc_last_run
      type: looker_column
      fields:
        - dim_test_case.tc_domain
        - fact_tc_latest_run.qua_tc_not_ready
        - fact_tc_latest_run.last_run_total_tc_count
      pivots: [fact_tc_latest_run.qua_tc_not_ready]
      stacking: normal
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 7
      col: 12
      width: 12
      height: 7

    - name: crosstable_quality_3_dynamic
      title: "Quality 3/3 — Dynamic Cross-Table (RowsAxis x ColumnAxis x ItemsCount)"
      tab_name: tab_5_quality_overview
      model: ampere_analytics
      explore: tc_last_run
      type: looker_grid
      fields:
        - dim_test_case.dynamic_tc_axis
        - dim_test_case.dynamic_column_axis
        - fact_tc_latest_run.dynamic_items_unique_count
      pivots: [dim_test_case.dynamic_column_axis]
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
        dynamic_tc_axis_selector: dim_test_case.tc_axis_selector
        dynamic_column_axis_selector: dim_test_case.column_axis_selector
        dynamic_items_count_selector: fact_tc_latest_run.items_count_selector
      row: 14
      col: 0
      width: 24
      height: 7

    - name: table_quality_all_data_detailed_view
      title: "Quality 1/3, 2/3 & 3/3 — All Data Detailed View (Details-on-Demand)"
      tab_name: tab_5_quality_overview
      model: ampere_analytics
      explore: tc_last_run
      type: looker_grid
      fields:
        - dim_test_case.tc_id
        - dim_test_case.tc_name
        - dim_test_case.tc_domain
        - dim_test_case.tc_status
        - fact_tc_latest_run.tr_id
        - fact_tc_latest_run.tr_result
        - fact_tc_latest_run.qua_tr_without_issues
        - fact_tc_latest_run.qua_tc_in_ts
        - fact_tc_latest_run.qua_tc_not_ready
        - dim_issue.issue_id
        - dim_issue.issue_status
        - dim_issue.issue_criticity
        - dim_test_set.ts_id
        - dim_test_set.ts_name
      limit: 500
      listen:
        tc_domain_filter: dim_test_case.tc_domain
        tc_status_filter: dim_test_case.tc_status
        tc_bench_type_filter: dim_test_case.tc_bench_type
        tc_validation_team_filter: dim_test_case.tc_validation_team
        ts_vehicle_project_filter: dim_test_set.ts_vehicle_project
      row: 21
      col: 0
      width: 24
      height: 8
