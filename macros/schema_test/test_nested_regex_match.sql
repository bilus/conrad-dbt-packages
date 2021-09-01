{% macro test_nested_regex_match(model, column_name, regex, path) -%}
	WITH validation AS
		{{ dbt_test.test_helper_build_query_unnested_path(path|default(column_name),model) }},

	validation_errors AS (
		SELECT *
		FROM validation
		WHERE NOT REGEXP_CONTAINS(source, r"{{ regex }}")
	)

	SELECT *
	FROM validation_errors
{% endmacro %}

