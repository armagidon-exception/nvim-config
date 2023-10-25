; extends

(assignment_expression left:(_) @assignment.lhs right:(_) @assignment.rhs @assignment.inner) @assignment.outer

(variable_declaration type:(_) (variable_declarator name:(_) @assignment.lhs (equals_value_clause _ @assignment.rhs)) @assignment.inner) @assignment.outer
