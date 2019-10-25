Content-Type: multipart/mixed; boundary="===============6135817246538437582=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] selftests: mptcp: Restore capture option
Date: Fri, 25 Oct 2019 16:19:57 -0700
Message-ID: <20191025231957.7937-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20191025121651.25946-10-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2327

--===============6135817246538437582==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The addition of other command line parameter handling made "-c" show the
usage message rather than allow packet capture with tcpdump. Integrate
"-c" with getops handling and make sure the usage message covers all
options.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 2cd62b041e70..b207ec12612e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -1,14 +1,14 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 =

-optstring=3D"d:e:l:r:h6"
+optstring=3D"d:e:l:r:h6c"
 ret=3D0
 sin=3D""
 sout=3D""
 cin=3D""
 cout=3D""
 ksft_skip=3D4
-capture=3D0
+capture=3Dfalse
 timeout=3D30
 ipv6=3Dfalse
 ethtool_random_on=3Dtrue
@@ -32,6 +32,8 @@ usage() {
 	echo -e "\t-l: tc/netem loss percentage, e.g. \"-l 0.02\" (default random=
)"
 	echo -e "\t-r: tc/netem reorder mode, e.g. \"-r 25% 50% gap 5\", use "-r =
0" to disable reordering (default random)"
 	echo -e "\t-e: ethtool features to disable, e.g.: \"-e tso -e gso\" (defa=
ult: randomly disable any of tso/gso/gro)"
+	echo -e "\t-6: enable IPv6 tests (default: only test IPv4)"
+	echo -e "\t-c: capture packets for each test using tcpdump (default: no c=
apture)"
 }
 =

 while getopts "$optstring" option;do
@@ -61,6 +63,9 @@ while getopts "$optstring" option;do
 	"6")
 		ipv6=3Dtrue
 		;;
+	"c")
+		capture=3Dtrue
+		;;
 	"?")
 		usage $0
 		exit 1
@@ -88,12 +93,6 @@ cleanup()
 	done
 }
 =

-for arg in "$@"; do
-    if [ "$arg" =3D "-c" ]; then
-	capture=3D1
-    fi
-done
-
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
@@ -303,7 +302,7 @@ do_transfer()
 =

 	printf "%-4s %-5s -> %-4s (%s:%d) %-5s\t" ${connector_ns} ${cl_proto} ${l=
istener_ns} ${connect_addr} ${port} ${srv_proto}
 =

-	if [ $capture -eq 1 ]; then
+	if $capture; then
 	    if [ -z $SUDO_USER ] ; then
 		capuser=3D""
 	    else
@@ -334,7 +333,7 @@ do_transfer()
 =

 	stop=3D$(date +%s)
 =

-	if [ $capture -eq 1 ]; then
+	if $capture; then
 	    sleep 1
 	    kill $cappid
 	fi
-- =

2.23.0

--===============6135817246538437582==--
