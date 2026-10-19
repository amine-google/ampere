# --------------------------------------------------------------------------
# Access Grants: Role-Based & Object-Level Security
# --------------------------------------------------------------------------

access_grant: can_view_safety_critical {
  user_attribute: ampere_role
  allowed_values: ["safety_officer", "cybersecurity_lead", "system_architect", "admin"]
}
