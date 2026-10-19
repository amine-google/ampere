# --------------------------------------------------------------------------
# Connection Constant (Parameterized from manifest.lkml)
# --------------------------------------------------------------------------
connection: "@{CONNECTION_NAME}"

label: "Ampere Vehicle Analytics"

# --------------------------------------------------------------------------
# Includes (Following Renault Project Structure Standard)
# --------------------------------------------------------------------------

# 00_adm: Access Grants & Datagroups
include: "/00_adm/access_grants/*.lkml"
include: "/00_adm/datagroup/*.lkml"

# 01_views: Sources, Refinements, Derived Tables, Extensions
include: "/01_views/sources/*.view.lkml"
include: "/01_views/refinements/*.view.lkml"
include: "/01_views/derived_tables/*.view.lkml"
include: "/01_views/extensions/*.view.lkml"

# 02_data_tests: Automated Integrity Test Suites
include: "/02_data_tests/*.test.lkml"

# 03_explores: Explores and Quick Start Queries
include: "/03_explores/*.explore.lkml"

# 05_dashboards: LookML Dashboards
include: "/05_dashboards/*.dashboard.lookml"

# --------------------------------------------------------------------------
# Centralized Caching
# --------------------------------------------------------------------------
persist_with: ampere_etl_datagroup
