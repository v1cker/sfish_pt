
#
# (C) Tenable Network Security
#
# The text of this plugin is (C) Red Hat Inc.
#

include("compat.inc");
if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(18309);
 script_version ("$Revision: 1.6 $");
 script_name(english: "RHSA-2005-074: rsh");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory RHSA-2005-074");
 script_set_attribute(attribute: "description", value: '
  Updated rsh packages that fix various bugs and a theoretical security issue
  are now available.

  This update has been rated as having low security impact by the Red Hat
  Security Response Team

  The rsh package contains a set of programs that allow users to run
  commands on remote machines, login to other machines, and copy files
  between machines, using the rsh, rlogin, and rcp commands. All three of
  these commands use rhosts-style authentication.

  The rcp protocol allows a server to instruct a client to write to arbitrary
  files outside of the current directory. This could potentially cause a
  security issue if a user uses rcp to copy files from a malicious server.
  The Common Vulnerabilities and Exposures project (cve.mitre.org) has
  assigned the name CAN-2004-0175 to this issue.

  These updated packages also address the following bugs:

  The rexec command failed with "Invalid Argument", because the code
  used sigaction() as an unsupported signal.

  The rlogind server reported "SIGCHLD set to SIG_IGN but calls wait()"
  message to the system log because the original BSD code was ported
  incorrectly to linux.

  The rexecd server did not function on systems where client hostnames were
  not in the DNS service, because server code called gethostbyaddr() for each
  new connection.

  The rcp command incorrectly used the "errno" variable and produced
  erroneous error messages.

  The rexecd command ignored settings in the /etc/security/limits file,
  because the PAM session was incorrectly initialized.

  The rexec command prompted for username and password regardless of the
  ~/.netrc configuration file contents. This updated package contains a patch
  that no longer skips the ~/.netrc file.

  All users of rsh should upgrade to these updated packages, which resolve
  these issues.


');
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:N/I:P/A:N");
script_set_attribute(attribute: "see_also", value: "http://rhn.redhat.com/errata/RHSA-2005-074.html");
script_set_attribute(attribute: "solution", value: "Get the newest RedHat Updates.");
script_end_attributes();

script_cve_id("CVE-2004-0175");
script_summary(english: "Check for the version of the rsh packages");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Red Hat Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/RedHat/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"rsh-0.17-17.6", release:'RHEL3') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"rsh-server-0.17-17.6", release:'RHEL3') )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host if not affected");
