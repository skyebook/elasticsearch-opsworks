elasticsearch-opsworks Cookbook
===============================
This cookbook installs and configures Elasticsearch, on AWS OpsWorks.

Requirements
------------
* Java is required by ES; This cookbook will install OpenJDK 7.
* Instances must belong to a single OpsWorks layer in order for configuration to work correctly.

Attributes
----------

#### elasticsearch-opsworks::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
    <th>Required?</th>
  </tr>
  <tr>
    <td><tt>['elasticsearch']['version']</tt></td>
    <td>string</td>
    <td>The version of Elasticsearch to install</td>
    <td><tt>1.3.4</tt></td>
    <td>No</td>
  </tr>
  <tr>
    <td><tt>['elasticsearch']['auth']['username']</tt></td>
    <td>string</td>
    <td>Username for Nginx HTTP Basic Authorization</td>
    <td><tt>elasticsearch_user</tt></td>
    <td>No, but recommended</td>
  </tr>
  <tr>
    <td><tt>['elasticsearch']['auth']['password']</tt></td>
    <td>string</td>
    <td>Password for Nginx HTTP Basic Authorization. (Use the plain text password)</td>
    <td><tt>elasticsearch_password</tt></td>
    <td>No, but recommended</td>
  </tr>
  <tr>
    <td><tt>['elasticsearch']['ssl']['cert']</tt></td>
    <td>string</td>
    <td>The contents of Nginx's ssl_certificate file</td>
    <td><tt>nil</tt></td>
    <td>No, but recommended</td>
  </tr>
  <tr>
    <td><tt>['elasticsearch']['ssl']['key']</tt></td>
    <td>string</td>
    <td>The The contents of Nginx's ssl_certificate_key file</td>
    <td><tt>nil</tt></td>
    <td>No, but recommended</td>
  </tr>
  <tr>
    <td><tt>['elasticsearch']['path']['logs']</tt></td>
    <td>string</td>
    <td>The file path to store the logs</td>
    <td><tt>/var/log/elasticsearch</tt></td>
	<td>No, but recommended</td>
  </tr>
  <tr>
    <td><tt>['elasticsearch']['path']['data']</tt></td>
    <td>string</td>
    <td>Where ES stores its data (hint: you'll likely want this on an EBS)</td>
    <td><tt>/var/data/elasticsearch</tt></td>
    <td>No</td>
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
