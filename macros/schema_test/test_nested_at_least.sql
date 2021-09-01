{% macro test_nested_at_least(model, column_name, path, count) -%}
	WITH validation AS
		{{ dbt_test.test_helper_build_query_unnested_path(path|default(column_name),model) }},

	validation_errors AS (
		SELECT *
		FROM validation
		WHERE ARRAY_LENGTH(source) < {{ count }}
	)

	SELECT *
	FROM validation_errors
{% endmacro %}
