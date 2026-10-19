# --------------------------------------------------------------------------
# Includes - Views & Quick Start Queries
# --------------------------------------------------------------------------
include: "/01_views/refinements/requirement_rfn.view.lkml"
include: "/01_views/refinements/tracker_rfn.view.lkml"
include: "/01_views/refinements/ownership_rfn.view.lkml"
include: "/01_views/refinements/safety_rfn.view.lkml"
include: "/01_views/refinements/feature_rfn.view.lkml"
include: "/01_views/refinements/project_rfn.view.lkml"
include: "/01_views/refinements/hierarchy_rfn.view.lkml"
include: "/01_views/refinements/components_rfn.view.lkml"
include: "/01_views/derived_tables/requirement_domain_summary.view.lkml"
include: "/03_explores/quick_start_queries/requirement_quick_start.lkml"

# --------------------------------------------------------------------------
# Explore Definition: Requirement Traceability & Engineering
# --------------------------------------------------------------------------
explore: requirement {
  label: "Requirements Traceability & Engineering"
  description: "Core analytical explore for Ampere vehicle engineering requirements, enabling 360-degree traceability across systems engineering ownership, functional safety (ISO 26262 ASIL), vehicle project schedules, product features, software components, and parent-child decomposition hierarchies."
  view_name: requirement

  # ------------------------------------------------------------------------
  # Joins
  # ------------------------------------------------------------------------

  join: tracker {
    type: left_outer
    relationship: many_to_one
    sql_on: ${requirement.req_tracker_id} = ${tracker.req_tracker_id} ;;
    view_label: "Tracker Information"
  }

  join: ownership {
    type: left_outer
    relationship: one_to_one
    sql_on: ${requirement.req_id} = ${ownership.req_id} ;;
    view_label: "Engineering Ownership"
  }

  join: safety {
    type: left_outer
    relationship: one_to_one
    sql_on: ${requirement.req_id} = ${safety.req_id} ;;
    view_label: "Functional Safety & Cybersecurity"
  }

  join: feature {
    type: left_outer
    relationship: many_to_one
    sql_on: ${requirement.req_feature_id} = ${feature.req_feature_id} ;;
    view_label: "Vehicle Feature"
  }

  join: project {
    type: left_outer
    relationship: many_to_one
    sql_on: ${requirement.req_vehicle_project_id} = ${project.req_vehicle_project_id} ;;
    view_label: "Vehicle Project & Baseline"
  }

  join: hierarchy {
    type: left_outer
    relationship: one_to_many
    sql_on: ${requirement.req_id} = ${hierarchy.req_id} ;;
    view_label: "Traceability Hierarchy"
  }

  join: components {
    type: left_outer
    relationship: one_to_many
    sql_on: ${requirement.req_id} = ${components.req_id} ;;
    view_label: "Software Components Allocation"
  }

  join: requirement_domain_summary {
    type: left_outer
    relationship: many_to_one
    sql_on: ${ownership.req_domain} = ${requirement_domain_summary.req_domain} ;;
    view_label: "Domain Rollup Summary (NDT)"
  }
}
