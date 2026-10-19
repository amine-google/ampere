# Ampere LookML Analytics Project (Renault Standard — Traceability & Execution)

Enterprise-grade LookML project modeling the Ampere SDV Traceability & Test Execution architecture (`inputs/customer_opinion/looker_data_model_recommendation.md`), fully compliant with the **Renault LookML Project Structure Standard** (`renault_lookml_projects_structure_template.png`).

---

## 1. Renault Project Structure Standard

```text
ampere_lookml/
├── manifest.lkml                                 # Central constants (Connection, Dataset, Drill Visualizations)
├── README.md                                     # Project documentation
│
├── 00_adm/                                       # Administration & Governance
│   ├── access_grants/                            # Role-based & object security definitions
│   │   └── access_grants.lkml
│   └── datagroup/                                # Caching policies & ETL trigger definitions
│       └── datagroups.lkml
│
├── 01_views/                                     # Semantic View Layer
│   ├── sources/                                  # 1:1 Physical schema mappings with mandatory Primary Keys
│   │   ├── requirement.view.lkml                 # 1 row per Req_ID
│   │   ├── dim_test_case.view.lkml               # 1 row per TC_ID
│   │   ├── dim_test_set.view.lkml                # 1 row per TS_ID
│   │   ├── dim_test_run.view.lkml                # 1 row per TR_ID (execution result)
│   │   ├── dim_issue.view.lkml                   # 1 row per Issue_ID
│   │   ├── dim_isp.view.lkml                     # 1 row per ISP_ID
│   │   ├── dim_baseline.view.lkml                # 1 row per Baseline_ID
│   │   ├── dim_fix_version.view.lkml             # 1 row per Fix_Version_ID
│   │   ├── bridge_requirement_test_case.view.lkml # 1 row per Req_ID + TC_ID
│   │   ├── bridge_test_case_test_set.view.lkml   # 1 row per TC_ID + TS_ID + TR_ID
│   │   ├── fact_tc_latest_run.view.lkml          # 1 row per TC_ID (latest relevant execution)
│   │   ├── tracker.view.lkml
│   │   ├── ownership.view.lkml
│   │   ├── safety.view.lkml
│   │   ├── feature.view.lkml
│   │   ├── project.view.lkml
│   │   ├── hierarchy.view.lkml
│   │   └── components.view.lkml
│   ├── refinements/                              # Refined views layering business logic, measures & drills
│   │   ├── requirement_rfn.view.lkml
│   │   ├── dim_test_case_rfn.view.lkml
│   │   ├── dim_test_set_rfn.view.lkml
│   │   ├── dim_test_run_rfn.view.lkml
│   │   ├── dim_issue_rfn.view.lkml
│   │   ├── dim_isp_rfn.view.lkml
│   │   ├── dim_baseline_rfn.view.lkml
│   │   ├── dim_fix_version_rfn.view.lkml
│   │   ├── bridge_requirement_test_case_rfn.view.lkml
│   │   ├── bridge_test_case_test_set_rfn.view.lkml
│   │   ├── fact_tc_latest_run_rfn.view.lkml
│   │   ├── tracker_rfn.view.lkml
│   │   ├── ownership_rfn.view.lkml
│   │   ├── safety_rfn.view.lkml
│   │   ├── feature_rfn.view.lkml
│   │   ├── project_rfn.view.lkml
│   │   ├── hierarchy_rfn.view.lkml
│   │   └── components_rfn.view.lkml
│   ├── derived_tables/                           # Pre-aggregated rollups & Native Derived Tables (NDTs)
│   │   └── requirement_domain_summary.view.lkml
│   └── extensions/                               # Reusable abstract base views
│       └── base_audit.view.lkml
│
├── 02_data_tests/                                # Automated LookML Data Tests
│   └── requirement.test.lkml
│
├── 03_explores/                                  # Three Focused Explores + Legacy Requirement Explore
│   ├── traceability.explore.lkml                 # Explore A — Traceability
│   ├── execution.explore.lkml                    # Explore B — Execution
│   ├── tc_last_run.explore.lkml                  # Explore C — TC Last Run
│   ├── requirement.explore.lkml
│   └── quick_start_queries/                      # Curated 1-click starter queries for Explores
│       ├── traceability_quick_start.lkml
│       ├── execution_quick_start.lkml
│       ├── tc_last_run_quick_start.lkml
│       └── requirement_quick_start.lkml
│
├── 04_models/                                    # Model Configuration
│   └── ampere_analytics.model.lkml
│
├── 05_dashboards/                                # LookML 26.4+ Native Tabbed Dashboards
│   ├── sdv_tc_runs_foundation.dashboard.lookml   # Migrated from Spotfire SDV_TC_Runs__Foundation.dxp
│   └── requirements_overview.dashboard.lookml
│
└── 06_translations/                              # Localization & Multi-Language Strings
    ├── en.strings.json
    └── fr_FR.strings.json
```

---

## 2. Canonical Business Grain & Entity Mapping

| Object | Recommended Grain | Primary Key | Source View | Refinement View |
| :--- | :--- | :--- | :--- | :--- |
| **Requirement** | 1 row per Requirement | `req_id` | `01_views/sources/requirement.view.lkml` | `01_views/refinements/requirement_rfn.view.lkml` |
| **Test Case** | 1 row per Test Case | `tc_id` | `01_views/sources/dim_test_case.view.lkml` | `01_views/refinements/dim_test_case_rfn.view.lkml` |
| **Test Set** | 1 row per Test Set | `ts_id` | `01_views/sources/dim_test_set.view.lkml` | `01_views/refinements/dim_test_set_rfn.view.lkml` |
| **Test Run** | 1 row per execution result | `tr_id` | `01_views/sources/dim_test_run.view.lkml` | `01_views/refinements/dim_test_run_rfn.view.lkml` |
| **REQ-TC Bridge** | 1 row per `Req_ID` + `TC_ID` | `bridge_req_tc_pk` | `01_views/sources/bridge_requirement_test_case.view.lkml` | `01_views/refinements/bridge_requirement_test_case_rfn.view.lkml` |
| **TC-TS-TR Bridge** | 1 row per `TC_ID` + `TS_ID` + `TR_ID` | `bridge_tc_ts_tr_pk` | `01_views/sources/bridge_test_case_test_set.view.lkml` | `01_views/refinements/bridge_test_case_test_set_rfn.view.lkml` |
| **TC Execution Status** | 1 row per `TC_ID` | `tc_id` | `01_views/sources/fact_tc_latest_run.view.lkml` | `01_views/refinements/fact_tc_latest_run_rfn.view.lkml` |
| **Issue** | 1 row per `Issue_ID` | `issue_id` | `01_views/sources/dim_issue.view.lkml` | `01_views/refinements/dim_issue_rfn.view.lkml` |
| **ISP** | 1 row per `ISP_ID` | `isp_id` | `01_views/sources/dim_isp.view.lkml` | `01_views/refinements/dim_isp_rfn.view.lkml` |
| **Baseline** | 1 row per `Baseline_ID` | `baseline_id` | `01_views/sources/dim_baseline.view.lkml` | `01_views/refinements/dim_baseline_rfn.view.lkml` |
| **Fix Version** | 1 row per `Fix_Version_ID` | `fix_version_id` | `01_views/sources/dim_fix_version.view.lkml` | `01_views/refinements/dim_fix_version_rfn.view.lkml` |

---

## 3. Three Focused Explores (`03_explores/`)

1. **Explore A — Traceability (`traceability.explore.lkml`)**:
   - Starting view: `requirement` $\rightarrow$ `bridge_requirement_test_case` $\rightarrow$ `dim_test_case` $\rightarrow$ `project` (`MySWF`) / `safety` (`ASIL` / `Regulation`) $\rightarrow$ `dim_isp` / `dim_baseline`.
2. **Explore B — Execution (`execution.explore.lkml`)**:
   - Starting view: `dim_test_run` $\rightarrow$ `dim_test_case` $\rightarrow$ `dim_test_set` $\rightarrow$ `dim_issue`.
3. **Explore C — TC Last Run (`tc_last_run.explore.lkml`)**:
   - Starting view: `fact_tc_latest_run` (`1 row per TC_ID`) $\rightarrow$ `dim_test_case`, `bridge_requirement_test_case` $\rightarrow$ `requirement` (`MySWF`), `bridge_test_case_test_set` $\rightarrow$ `dim_test_set`, and `dim_issue`.
