{% macro test_nested_accepted_values(model, column_name, values, path) -%}
	WITH validation AS
		{{ dbt_test.test_helper_build_query_unnested_path(path|default(column_name),model) }},

	validation_errors AS (
		SELECT *
		FROM validation
		WHERE source NOT IN({{ values|map('tojson')|join(',') }})
	)

	SELECT *
	FROM validation_errors
{% endmacro %}
