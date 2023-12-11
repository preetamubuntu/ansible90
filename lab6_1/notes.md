# Info - Lab61

Configure a playbook that works with custom facts and
meets the following requirements:

- Create an inventory file where ansible1 is member of
  the host group named file and ansible2 is member
  of the host group named lamp.
- Create a custom facts file that contains a section
  named packages and set the following variables:

smb_package = samba
ftp_package = vsftpd
db_package = mariadb
web_package = httpd
firewall_package = firewalld

- Create another custom facts file that contains a
  section named services and set the following
  variables:

smb_service = smbd
ftp_service = vsftpd
db_service = mariadb
web_service = httpd
firewall_service = firewalld

- Create a playbook with the name copy_facts.yaml
	that copies these facts to all managed hosts. In this
	playbook define a variable remote_dir to specify the
	directory the fact files should be copied to. Use the
	variable fact_file to copy the fact files to the
	appropriate directories.

-	Run the playbook and verify whether it works.