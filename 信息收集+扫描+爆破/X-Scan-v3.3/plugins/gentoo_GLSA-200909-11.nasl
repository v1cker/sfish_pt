# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200909-11.xml
# It is released under the Nessus Script Licence.
# The messages are release under the Creative Commons - Attribution /
# Share Alike license. See http://creativecommons.org/licenses/by-sa/2.0/
#
# Avisory is copyright 2001-2006 Gentoo Foundation, Inc.
# GLSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description)
{
 script_id(40919);
 script_version("$Revision: 1.1 $");
 script_xref(name: "GLSA", value: "200909-11");
 script_cve_id("CVE-2008-4957");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200909-11 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200909-11
(GCC-XML: Insecure temporary file usage)


    Dmitry E. Oboukhov reported that find_flags in GCC-XML does not handle
    "/tmp/*.cxx" temporary files securely.
  
Impact

    A local attacker could perform symlink attacks to overwrite arbitrary
    files with the privileges of the user running the application.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All GCC-XML users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose =dev-cpp/gccxml-0.9.0_pre20090516
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:L/AC:M/Au:N/C:C/I:C/A:C');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2008-4957');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200909-11.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200909-11] GCC-XML: Insecure temporary file usage');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'GCC-XML: Insecure temporary file usage');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "dev-cpp/gccxml", unaffected: make_list("ge 0.9.0_pre20090516"), vulnerable: make_list("lt 0.9.0_pre20090516")
)) { security_warning(0); exit(0); }
exit(0, "Host is not affected");
