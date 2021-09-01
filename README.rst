DBT Test Macros
===============

Usage
^^^^^

1. Add to ``packages.yml``, example::

     packages:
        - local: ../../../../conradlib/dbt_test

2. Update dbt dependencies::

     dbt deps

3. Use it in schema yamls like so::

     [...]

      - name: _source.artistsDetails.artistName
        description: Artist name
        tests:
          - dbt_test.nested_not_null:
              path: _source.artistsDetails[].artistName
