Content-Type: multipart/mixed; boundary="===============5597262047134474215=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 09/11] selftests: mptcp: add invert argument
 for chk_rm_nr
Date: Fri, 12 Mar 2021 17:16:19 -0800
Message-ID: <20210313011621.211661-10-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210313011621.211661-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8139

--===============5597262047134474215==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

Some of the removing testcases used two zeros as arguments for chk_rm_nr
like this: chk_rm_nr 0 0. This doesn't mean that no RM_ADDR has been sent.
It only means that RM_ADDR had been sent in the opposite direction that
chk_rm_nr is checking.

This patch added a new argument invert for chk_rm_nr to allow it can
check the RM_ADDR from the opposite direction.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
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

2.30.2

--===============5597262047134474215==--
