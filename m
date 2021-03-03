Content-Type: multipart/mixed; boundary="===============4219158503092003802=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net] selftests: mptcp: Restore packet capture
 option in join tests
Date: Wed, 03 Mar 2021 14:43:00 -0800
Message-ID: <20210303224300.95599-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 8008

--===============4219158503092003802==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The join self tests previously used the '-c' command line option to
enable creation of pcap files for the tests that run, but the change to
allow running a subset of the join tests made overlapping use of that
option.

Restore the capture functionality with '-c' and move the syncookie test
option to '-k'.

Fixes: 1002b89f23ea ("selftests: mptcp: add command line arguments for mptc=
p_join.sh")
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 26 ++++++++++++-------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 96379ede5925..4d7dab0bce7a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -12,6 +12,7 @@ timeout_poll=3D30
 timeout_test=3D$((timeout_poll * 2 + 1))
 mptcp_connect=3D""
 capture=3D0
+do_all_tests=3D1
 =

 TEST_COUNT=3D0
 =

@@ -123,12 +124,6 @@ reset_with_add_addr_timeout()
 		-j DROP
 }
 =

-for arg in "$@"; do
-	if [ "$arg" =3D "-c" ]; then
-		capture=3D1
-	fi
-done
-
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
@@ -1368,7 +1363,8 @@ usage()
 	echo "  -4 v4mapped_tests"
 	echo "  -b backup_tests"
 	echo "  -p add_addr_ports_tests"
-	echo "  -c syncookies_tests"
+	echo "  -k syncookies_tests"
+	echo "  -c capture pcap files"
 	echo "  -h help"
 }
 =

@@ -1382,12 +1378,20 @@ make_file "$cin" "client" 1
 make_file "$sin" "server" 1
 trap cleanup EXIT
 =

-if [ -z $1 ]; then
+for arg in "$@"; do
+	if [ "$arg" =3D "-c" ]; then
+		capture=3D1
+	else
+		do_all_tests=3D0
+	fi
+done
+
+if [ $do_all_tests -eq 1 ]; then
 	all_tests
 	exit $ret
 fi
 =

-while getopts 'fsltra64bpch' opt; do
+while getopts 'fsltra64bpkch' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -1419,9 +1423,11 @@ while getopts 'fsltra64bpch' opt; do
 		p)
 			add_addr_ports_tests
 			;;
-		c)
+		k)
 			syncookies_tests
 			;;
+		c)
+			;;
 		h | *)
 			usage
 			;;
-- =

2.30.1

--===============4219158503092003802==--
