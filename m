Content-Type: multipart/mixed; boundary="===============0208952274866205582=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][RFC PATCH mptcp-next 6/6] selftests: mptcp: add
 MP_PRIO check in chk_rm_nr
Date: Thu, 05 Nov 2020 18:50:23 +0800
Message-ID: <bf5acd2f111417112ab970bb7d8e11b43cf117aa.1604572610.git.geliangtang@gmail.com>
In-Reply-To: 97272e9a7c59c402dceec4a86ee96a1c6bac9b8c.1604572610.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6563

--===============0208952274866205582==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the MPTCP_MIB_MPPRIO counter check in chk_rm_nr, since
before sending the RM_ADDR suboption, we also send the MP_PRIO suboption
to change the related subflow's priority as backup.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 34 +++++++++++++------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index f224379ba254..18d488b9c87b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -484,7 +484,8 @@ chk_add_nr()
 chk_rm_nr()
 {
 	local rm_addr_nr=3D$1
-	local rm_subflow_nr=3D$2
+	local mp_prio_nr=3D$2
+	local rm_subflow_nr=3D$3
 	local count
 	local dump_stats
 =

@@ -499,7 +500,18 @@ chk_rm_nr()
 		echo -n "[ ok ]"
 	fi
 =

-	echo -n " - sf    "
+	echo -n " - prio  "
+	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrio | awk '{print=
 $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$mp_prio_nr" ]; then
+		echo "[fail] got $count MP_PRIO[s] expected $mp_prio_nr"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - sf "
 	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtRmSubflow | awk '{pr=
int $2}'`
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D "$rm_subflow_nr" ]; then
@@ -637,7 +649,7 @@ ip netns exec $ns2 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow
 chk_join_nr "remove single subflow" 1 1 1
-chk_rm_nr 1 1
+chk_rm_nr 1 1 1
 =

 # multiple subflows, remove
 reset
@@ -647,7 +659,7 @@ ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subfl=
ow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 run_tests $ns1 $ns2 10.0.1.1 0 0 2 slow
 chk_join_nr "remove multiple subflows" 2 2 2
-chk_rm_nr 2 2
+chk_rm_nr 2 2 2
 =

 # single address, remove
 reset
@@ -657,7 +669,7 @@ ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
 chk_join_nr "remove single address" 1 1 1
 chk_add_nr 1 1
-chk_rm_nr 0 0
+chk_rm_nr 0 0 0
 =

 # subflow and signal, remove
 reset
@@ -668,7 +680,7 @@ ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subfl=
ow
 run_tests $ns1 $ns2 10.0.1.1 0 1 1 slow
 chk_join_nr "remove subflow and signal" 2 2 2
 chk_add_nr 1 1
-chk_rm_nr 1 1
+chk_rm_nr 1 1 1
 =

 # subflows and signal, remove
 reset
@@ -680,7 +692,7 @@ ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subfl=
ow
 run_tests $ns1 $ns2 10.0.1.1 0 1 2 slow
 chk_join_nr "remove subflows and signal" 3 3 3
 chk_add_nr 1 1
-chk_rm_nr 2 2
+chk_rm_nr 2 2 2
 =

 # subflow IPv6
 reset
@@ -723,7 +735,7 @@ ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 run_tests $ns1 $ns2 dead:beef:1::1 0 1 0 slow
 chk_join_nr "remove single address IPv6" 1 1 1
 chk_add_nr 1 1
-chk_rm_nr 0 0
+chk_rm_nr 0 0 0
 =

 # subflow and signal IPv6, remove
 reset
@@ -734,7 +746,7 @@ ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags=
 subflow
 run_tests $ns1 $ns2 dead:beef:1::1 0 1 1 slow
 chk_join_nr "remove subflow and signal IPv6" 2 2 2
 chk_add_nr 1 1
-chk_rm_nr 1 1
+chk_rm_nr 1 1 1
 =

 # signal address with port
 reset
@@ -763,7 +775,7 @@ ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow 10100
 chk_join_nr "remove single address with port" 1 1 1
 chk_add_nr 1 1 1
-chk_rm_nr 0 0
+chk_rm_nr 0 0 0
 =

 # subflow and signal with port, remove
 reset
@@ -774,7 +786,7 @@ ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subfl=
ow
 run_tests $ns1 $ns2 10.0.1.1 0 1 1 slow 10100
 chk_join_nr "remove subflow and signal with port" 2 2 2
 chk_add_nr 1 1 1
-chk_rm_nr 1 1
+chk_rm_nr 1 1 1
 =

 # single subflow, syncookies
 reset_with_cookies
-- =

2.26.2

--===============0208952274866205582==--
