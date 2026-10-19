# --------------------------------------------------------------------------
# Explore A - Traceability (Horizontal & Vertical Requirement Coverage)
# Per Customer Recommendation Section 4:
# Starting view: Requirement -> bridge_requirement_test_case -> Test Case
# -> MySWF / Safety Goal / Regulation -> ISP / Baseline
# --------------------------------------------------------------------------

include: "/01_views/refinements/requirement_rfn.view.lkml"
include: "/01_views/refinements/bridge_requirement_test_case_rfn.view.lkml"
include: "/01_views/refinements/dim_test_case_rfn.view.lkml"
include: "/01_views/refinements/tracker_rfn.view.lkml"
include: "/01_views/refinements/ownership_rfn.view.lkml"
include: "/01_views/refinements/safety_rfn.view.lkml"
include: "/01_views/refinements/feature_rfn.view.lkml"
include: "/01_views/refinements/project_rfn.view.lkml"
include: "/01_views/refinements/hierarchy_rfn.view.lkml"
include: "/01_views/refinements/components_rfn.view.lkml"
include: "/01_views/refinements/dim_isp_rfn.view.lkml"
include: "/01_views/refinements/dim_baseline_rfn.view.lkml"
include: "/03_explores/quick_start_queries/traceability_quick_start.lkml"

explore: traceability {
  label: "Explore A — Traceability (Requirement to Test Case Coverage)"
  description: "Answers coverage and navigation questions from MySWF, Safety Goal (ASIL), and Regulation down to Test Cases using explicit REQ-TC bridge joins."
  from: requirement
  view_name: requirement

  join: bridge_requirement_test_case {
    type: left_outer
    relationship: one_to_many
    sql_on: ${requirement.req_id} = ${bridge_requirement_test_case.req_id} ;;
    view_label: "REQ-TC Coverage Bridge"
  }

  join: dim_test_case {
    type: left_outer
    relationship: many_to_one
    sql_on: ${bridge_requirement_test_case.tc_id} = ${dim_test_case.tc_id} ;;
    view_label: "Test Case (Covering)"
  }

  join: project {
    type: left_outer
    relationship: many_to_one
    sql_on: ${requirement.req_vehicle_project_id} = ${project.req_vehicle_project_id} ;;
    view_label: "MySWF & Vehicle Project"
  }

  join: safety {
    type: left_outer
    relationship: one_to_one
    sql_on: ${requirement.req_id} = ${safety.req_id} ;;
    view_label: "Safety Goal (ASIL) & Regulation"
  }

  join: ownership {
    type: left_outer
    relationship: one_to_one
    sql_on: ${requirement.req_id} = ${ownership.req_id} ;;
    view_label: "Engineering Ownership"
  }

  join: feature {
    type: left_outer
    relationship: many_to_one
    sql_on: ${requirement.req_feature_id} = ${feature.req_feature_id} ;;
    view_label: "Vehicle Feature"
  }

  join: hierarchy {
    type: left_outer
    relationship: one_to_many
    sql_on: ${requirement.req_id} = ${hierarchy.req_id} ;;
    view_label: "Parent/Child Requirement Hierarchy"
  }

  join: components {
    type: left_outer
    relationship: one_to_many
    sql_on: ${requirement.req_id} = ${components.req_id} ;;
    view_label: "Software Components Allocation"
  }

  join: tracker {
    type: left_outer
    relationship: many_to_one
    sql_on: ${requirement.req_tracker_id} = ${tracker.req_tracker_id} ;;
    view_label: "Tracker Information"
  }

  join: dim_isp {
    type: left_outer
    relationship: many_to_one
    sql_on: ${requirement.req_isp_id} = ${dim_isp.isp_id} ;;
    view_label: "ISP (Integrated Software Plan)"
  }

  join: dim_baseline {
    type: left_outer
    relationship: many_to_one
    sql_on: ${requirement.req_baseline} = ${dim_baseline.req_baseline} ;;
    view_label: "Baseline & Milestone"
  }
}
