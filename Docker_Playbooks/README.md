<h2>Docker Implementation</h2>

<p>All it needs is to run the main.yml playbook AFTER the following changes are implemented:
<ul>
  <li>Edit the filepaths in all playbooks according to your system's file structure.</li>
  <li>All bash scripts setup the services with predetermined passwords. It is advised you modify these passwords.</li>
  <li>Do as the above step for owncloud-compose.yml</li>
  <li>Excecute "sudo usermod -aG docker _telegraf" or else Telegraf can't fetch data from the containers and will return errors.</li>
</ul></p>

<p>Aftet that you can setup a Grafana dashboard according to the project report (unavailable here).</p>
