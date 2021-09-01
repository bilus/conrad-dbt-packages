{% macro test_at_least(model, column_name, path, count) %}{{ test_nested_at_least(model, column_name, path, count) }}{% endmacro %}
