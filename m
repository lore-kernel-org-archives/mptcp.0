Content-Type: multipart/mixed; boundary="===============0624577349936533345=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 2/4] selftests: mptcp: add invert
 argument for chk_rm_nr
Date: Tue, 09 Feb 2021 22:55:02 +0800
Message-ID: <a61310ffcf001700a2c5446ad53212c0f7577c61.1612882099.git.geliangtang@gmail.com>
In-Reply-To: 727f616706d0c2e06c020a39096ef958ababa73c.1612882099.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7711

--===============0624577349936533345==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some of the removing testcases used two zeros as arguments for chk_rm_nr
like this: chk_rm_nr 0 0. This dosen't mean that no RM_ADDR has been sent.
It only means that RM_ADDR had been sent in the opposite direction that
chk_rm_nr is checking.

This patch added a new argument invert for chk_rm_nr to allow it can
check the RM_ADDR from the opposite direction.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 21 ++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 964db9ed544f..15b71ddee615 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -610,11 +610,22 @@ chk_rm_nr()
 {
 	local rm_addr_nr=3D$1
 	local rm_subflow_nr=3D$2
+	local invert=3D${3:-""}
 	local count
 	local dump_stats
+	local addr_ns
+	local subflow_ns
+
+	if [ -z $invert ]; then
+		addr_ns=3D$ns1
+		subflow_ns=3D$ns2
+	elif [ $invert =3D "invert" ]; then
+		addr_ns=3D$ns2
+		subflow_ns=3D$ns1
+	fi
 =

 	printf "%-39s %s" " " "rm "
-	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtRmAddr | awk '{print=
 $2}'`
+	count=3D`ip netns exec $addr_ns nstat -as | grep MPTcpExtRmAddr | awk '{p=
rint $2}'`
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D "$rm_addr_nr" ]; then
 		echo "[fail] got $count RM_ADDR[s] expected $rm_addr_nr"
@@ -625,7 +636,7 @@ chk_rm_nr()
 	fi
 =

 	echo -n " - sf    "
-	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtRmSubflow | awk '{pr=
int $2}'`
+	count=3D`ip netns exec $subflow_ns nstat -as | grep MPTcpExtRmSubflow | a=
wk '{print $2}'`
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D "$rm_subflow_nr" ]; then
 		echo "[fail] got $count RM_SUBFLOW[s] expected $rm_subflow_nr"
@@ -833,7 +844,7 @@ remove_tests()
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
 	chk_join_nr "remove single address" 1 1 1
 	chk_add_nr 1 1
-	chk_rm_nr 0 0
+	chk_rm_nr 1 1 invert
 =

 	# subflow and signal, remove
 	reset
@@ -945,7 +956,7 @@ ipv6_tests()
 	run_tests $ns1 $ns2 dead:beef:1::1 0 -1 0 slow
 	chk_join_nr "remove single address IPv6" 1 1 1
 	chk_add_nr 1 1
-	chk_rm_nr 0 0
+	chk_rm_nr 1 1 invert
 =

 	# subflow and signal IPv6, remove
 	reset
@@ -1088,7 +1099,7 @@ add_addr_ports_tests()
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
 	chk_join_nr "remove single address with port" 1 1 1
 	chk_add_nr 1 1 1
-	chk_rm_nr 0 0
+	chk_rm_nr 1 1 invert
 =

 	# subflow and signal with port, remove
 	reset
-- =

2.29.2

--===============0624577349936533345==--
