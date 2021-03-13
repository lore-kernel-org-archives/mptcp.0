Content-Type: multipart/mixed; boundary="===============2001470060749554730=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] selftests: mptcp: Restore packet capture option
 in join tests
Date: Fri, 12 Mar 2021 16:43:52 -0800
Message-ID: <20210313004352.209906-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 8130

--===============2001470060749554730==
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
Acked-and-tested-by: Geliang Tang <geliangtang(a)gmail.com>
Co-developed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 30 ++++++++++++-------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 964db9ed544f..ad32240fbfda 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -11,6 +11,7 @@ ksft_skip=3D4
 timeout=3D30
 mptcp_connect=3D""
 capture=3D0
+do_all_tests=3D1
 =

 TEST_COUNT=3D0
 =

@@ -121,12 +122,6 @@ reset_with_add_addr_timeout()
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
@@ -1221,7 +1216,8 @@ usage()
 	echo "  -4 v4mapped_tests"
 	echo "  -b backup_tests"
 	echo "  -p add_addr_ports_tests"
-	echo "  -c syncookies_tests"
+	echo "  -k syncookies_tests"
+	echo "  -c capture pcap files"
 	echo "  -h help"
 }
 =

@@ -1235,12 +1231,24 @@ make_file "$cin" "client" 1
 make_file "$sin" "server" 1
 trap cleanup EXIT
 =

-if [ -z $1 ]; then
+for arg in "$@"; do
+	# check for "capture" arg before launching tests
+	if [[ "${arg}" =3D~ ^"-"[0-9a-zA-Z]*"c"[0-9a-zA-Z]*$ ]]; then
+		capture=3D1
+	fi
+
+	# exception for the capture option, the rest means: a part of the tests
+	if [ "${arg}" !=3D "-c" ]; then
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
@@ -1272,9 +1280,11 @@ while getopts 'fsltra64bpch' opt; do
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

base-commit: 080bfa1e6d928a5d1f185cc44e5f3c251df06df5
-- =

2.30.2

--===============2001470060749554730==--
