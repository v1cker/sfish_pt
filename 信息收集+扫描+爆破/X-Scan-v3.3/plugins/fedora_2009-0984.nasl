
#
# (C) Tenable Network Security, Inc.
#
# This plugin text was extracted from Fedora Security Advisory 2009-0984
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(37560);
 script_version ("$Revision: 1.2 $");
script_name(english: "Fedora 10 2009-0984: asterisk");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory FEDORA-2009-0984 (asterisk)");
 script_set_attribute(attribute: "description", value: "Asterisk is a complete PBX in software. It runs on Linux and provides
all of the features you would expect from a PBX and more. Asterisk
does voice over IP in three protocols, and can interoperate with
almost all standards-based telephony equipment using relatively
inexpensive hardware.

-
Update Information:

Add a patch to fix a problem with the manager interface.    Update to 1.6.0.5 t
o
fix AST-2009-001 / CVE-2009-0041:
[9]http://downloads.digium.com/pub/security/AST-2009-001.html  (Original patch
in
1.6.0.3 introduced a regression.)
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:N/A:N");
script_set_attribute(attribute: "solution", value: "Get the newest Fedora Updates");
script_end_attributes();

 script_cve_id("CVE-2009-0041");
script_summary(english: "Check for the version of the asterisk package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "Fedora Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( rpm_check( reference:"asterisk-1.6.0.5-2.fc10", release:"FC10") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
