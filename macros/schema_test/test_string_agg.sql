{% macro test_string_agg(model, column_name, path, separator, ignore_nulls) -%}
	WITH
	input_data AS (
		SELECT
			{{column_name}} AS _EXPECTED_VALUE,
			ARRAY(
				{{ dbt_test.test_helper_build_query_unnested_path(path, model="UNNEST([_INPUT_ROW])") }}
				) AS _SOURCE_VALUES
		FROM {{model}} AS _INPUT_ROW
	),
	validation_errors AS (
		SELECT *
		FROM input_data
		WHERE ARRAY_TO_STRING(_SOURCE_VALUES, {{separator|tojson}}) != _EXPECTED_VALUE
		{% if ignore_nulls %} AND ARRAY_TO_STRING(_SOURCE_VALUES, {{separator|tojson}}) IS NOT NULL {% endif %}
	)

	SELECT *
	FROM validation_errors
{% endmacro %}

