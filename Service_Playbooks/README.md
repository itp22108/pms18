<h2>Services Implementation</h2>

<p>All it needs is to run the main.yml playbook AFTER the following changes are implemented:
<ul>
  <li>Mind the "hosts" variable on every playbook (where available)</li>
  <li>Edit the filepaths in all playbooks according to your system's file structure.</li>
  <li>On owncloud_setup.sh, line 33, replace the [SERVER_IP] variable with the IP address of the target VM.</li>
  <li>All bash scripts setup the services with predetermined passwords. It is advised you modify these passwords.</li>
</ul></p>

<p>Aftet that you can setup a Grafana dashboard according to the project report (unavailable here).</p>
