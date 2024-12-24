;; extends

; inject sql in single line strings
; e.g. db.GetContext(ctx, "SELECT * FROM users WHERE name = 'John'")
; following no longer works after https://github.com/tree-sitter/tree-sitter-go/commit/47e8b1fae7541f6e01cead97201be19321ec362a
; ((call_expression
;   (selector_expression
;     field: (field_identifier) @_field)
;   (argument_list
;     (interpreted_string_literal) @sql))
;   (#any-of? @_field "Exec" "GetContext" "ExecContext" "SelectContext" "In"
; 				            "RebindNamed" "Rebind" "Query" "QueryRow" "QueryRowxContext" "NamedExec" "MustExec" "Get" "Queryx")
;   (#offset! @sql 0 1 0 -1))
;
; ; still buggy for nvim 0.10
; ((call_expression
;   (selector_expression
;     field: (field_identifier) @_field (#any-of? @_field "Exec" "GetContext" "ExecContext" "SelectContext" "In" "RebindNamed" "Rebind" "Query" "QueryRow" "QueryRowxContext" "NamedExec" "MustExec" "Get" "Queryx"))
;   (argument_list
;     (interpreted_string_literal) @injection.content))
;   (#offset! @injection.content 0 1 0 -1)
;   (#set! injection.language "sql"))

; neovim nightly 0.10
; ([
;   (interpreted_string_literal_content)
;   (raw_string_literal_content)
;   ] @injection.content
;  (#match? @injection.content "(SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete).+(FROM|from|INTO|into|VALUES|values|SET|set).*(WHERE|where|GROUP BY|group by)?")
;  (#offset! @injection.content 0 1 0 -1)
; (#set! injection.language "sql"))

; a general query injection
([
   (interpreted_string_literal_content)
   (raw_string_literal_content)
 ] @sql
 (#match? @sql "(SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete).+(FROM|from|INTO|into|VALUES|values|SET|set).*(WHERE|where|GROUP BY|group by)?")
 (#offset! @sql 0 1 0 -1))

; ----------------------------------------------------------------
; fallback keyword and comment based injection

([
  (interpreted_string_literal_content)
  (raw_string_literal_content)
 ] @sql
 (#contains? @sql "-- sql" "--sql" "ADD CONSTRAINT" "ALTER TABLE" "ALTER COLUMN"
                  "DATABASE" "FOREIGN KEY" "GROUP BY" "HAVING" "CREATE INDEX" "INSERT INTO"
                  "NOT NULL" "PRIMARY KEY" "UPDATE SET" "TRUNCATE TABLE" "LEFT JOIN" "add constraint" "alter table" "alter column" "database" "foreign key" "group by" "having" "create index" "insert into"
                  "not null" "primary key" "update set" "truncate table" "left join")
 (#offset! @sql 0 1 0 -1))

; nvim 0.10
([
  (interpreted_string_literal_content)
  (raw_string_literal_content)
 ] @injection.content
 (#contains? @injection.content "-- sql" "--sql" "ADD CONSTRAINT" "ALTER TABLE" "ALTER COLUMN"
                  "DATABASE" "FOREIGN KEY" "GROUP BY" "HAVING" "CREATE INDEX" "INSERT INTO"
                  "NOT NULL" "PRIMARY KEY" "UPDATE SET" "TRUNCATE TABLE" "LEFT JOIN" "add constraint" "alter table" "alter column" "database" "foreign key" "group by" "having" "create index" "insert into"
                  "not null" "primary key" "update set" "truncate table" "left join")
 (#offset! @injection.content 0 1 0 -1)
 (#set! injection.language "sql"))
