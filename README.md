elasticsearch-opsworks Cookbook
===============================
This cookbook installs and configures Elasticsearch.

Requirements
------------
* Java is required by ES; This cookbook will install OpenJDK 7.
* Instances must belong to a single OpsWorks layer in order for configuration to work correctly.

Attributes
----------
TODO: List your cookbook attributes here.

e.g.
#### elasticsearch-opsworks::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['elasticsearch-opsworks']['version']</tt></td>
    <td>string</td>
    <td>The version of Elasticsearch to install</td>
    <td><tt>1.3.4</tt></td>
  </tr>
</table>

Usage
-----
#### elasticsearch-opsworks::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `elasticsearch-opsworks` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[elasticsearch-opsworks]"
  ]
}
```

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: TODO: List authors
