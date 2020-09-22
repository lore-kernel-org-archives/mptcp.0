Content-Type: multipart/mixed; boundary="===============3291740401452313780=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 3/3] selftests: mptcp: add ADD_ADDR
 timeout test case
Date: Tue, 22 Sep 2020 16:12:53 +0800
Message-ID: <4ea3b478ddb556e9eb3aff0cbeb786325833e768.1600762109.git.geliangtang@gmail.com>
In-Reply-To: cover.1600762109.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5982

--===============3291740401452313780==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the test case for retransmitting ADD_ADDR when timeout.
It set NS1's add_addr_timeout to 1 second, and disable NS2's add_addr_echo.

And we need to slow down the transfer process of all data to let the
ADD_ADDR suboptions can be retransmitted three times.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 39 +++++++++++++++++--
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 08f53d86dedc..fa0011f2422e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -82,6 +82,14 @@ reset_with_cookies()
 	done
 }
 =

+reset_with_timeout()
+{
+	reset
+
+	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=3D1
+	ip netns exec $ns2 sysctl -q net.mptcp.add_addr_echo=3D0
+}
+
 for arg in "$@"; do
 	if [ "$arg" =3D "-c" ]; then
 		capture=3D1
@@ -135,6 +143,7 @@ do_transfer()
 	connect_addr=3D"$5"
 	rm_nr_ns1=3D"$6"
 	rm_nr_ns2=3D"$7"
+	slow=3D"$8"
 =

 	port=3D$((10000+$TEST_COUNT))
 	TEST_COUNT=3D$((TEST_COUNT+1))
@@ -159,7 +168,7 @@ do_transfer()
 		sleep 1
 	fi
 =

-	if [[ $rm_nr_ns1 -eq 0 && $rm_nr_ns2 -eq 0 ]]; then
+	if [ $slow -eq 0 ]; then
 		mptcp_connect=3D"./mptcp_connect -j"
 	else
 		mptcp_connect=3D"./mptcp_connect -r"
@@ -252,7 +261,7 @@ run_tests()
 	connect_addr=3D"$3"
 	lret=3D0
 =

-	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} 0 0
+	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} 0 =
0 0
 	lret=3D$?
 	if [ $lret -ne 0 ]; then
 		ret=3D$lret
@@ -269,7 +278,22 @@ run_remove_tests()
 	rm_nr_ns2=3D"$5"
 	lret=3D0
 =

-	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} ${=
rm_nr_ns1} ${rm_nr_ns2}
+	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} ${=
rm_nr_ns1} ${rm_nr_ns2} 1
+	lret=3D$?
+	if [ $lret -ne 0 ]; then
+		ret=3D$lret
+		return
+	fi
+}
+
+run_timeout_tests()
+{
+	listener_ns=3D"$1"
+	connector_ns=3D"$2"
+	connect_addr=3D"$3"
+	lret=3D0
+
+	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} 0 =
0 1
 	lret=3D$?
 	if [ $lret -ne 0 ]; then
 		ret=3D$lret
@@ -491,6 +515,15 @@ run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "multiple subflows and signal" 3 3 3
 chk_add_nr 1 1
 =

+# add_addr timeout
+reset_with_timeout
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+run_timeout_tests $ns1 $ns2 10.0.1.1
+chk_join_nr "signal address, timeout" 1 1 1
+chk_add_nr 4 0
+
 # single subflow, remove
 reset
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-- =

2.17.1

--===============3291740401452313780==--
