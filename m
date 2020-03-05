Content-Type: multipart/mixed; boundary="===============5220928044715119604=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 12/12] Squash-to: "selftests: add test-cases for
 MPTCP MP_JOIN"
Date: Thu, 05 Mar 2020 15:46:49 +0100
Message-ID: <f86be420f43900e716f358bfa34c59d5d267260a.1583418574.git.pabeni@redhat.com>
In-Reply-To: cover.1583418571.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3885

--===============5220928044715119604==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add tests for subflows limit enforcing.

re-enable multiple subflows tests.

cleanup data gathering via appropriate nstat command line options

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 100 ++++++++++++++----
 1 file changed, 79 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 799914cd973a..a724f9e1fa50 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -17,7 +17,6 @@ init()
 	capout=3D$(mktemp)
 =

 	rndh=3D$(printf %x $sec)-$(mktemp -u XXXXXX)
-	nstat=3D"/tmp/.nstat.$rndh"
 =

 	ns1=3D"ns1-$rndh"
 	ns2=3D"ns2-$rndh"
@@ -53,7 +52,6 @@ init()
 cleanup_partial()
 {
 	rm -f "$capout"
-	rm -f "$nstat"
 =

 	for netns in "$ns1" "$ns2"; do
 		ip netns del $netns
@@ -222,20 +220,50 @@ run_tests()
 chk_join_nr()
 {
 	local msg=3D"$1"
-	local ns=3D$2
-	local nr=3D$3
+	local syn_nr=3D$2
+	local syn_ack_nr=3D$3
+	local ack_nr=3D$4
 	local count
+	local dump_stats
 =

-	count=3D`NSTAT_HISTORY=3D$nstat ip netns exec $ns nstat |grep MPTcpExtMPJ=
oinSynRx | awk '{print $2}'`
+	printf "%-36s %s" "$msg" "syn"
+	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinSynRx | awk '{=
print $2}'`
 	[ -z "$count" ] && count=3D0
-	printf "%-50s %s" "$msg"
-	if [ "$count" !=3D "$nr" ]; then
-		echo "[fail] got $count JOIN[s] expected $nr"
+	if [ "$count" !=3D "$syn_nr" ]; then
+		echo "[fail] got $count JOIN[s] syn expected $syn_nr"
 		ret=3D1
+		dump_stats=3D1
 	else
-		echo "[ ok ]"
+		echo -n "[ ok ]"
 	fi
 =

+	echo -n " - synack"
+	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinSynAckRx | awk=
 '{print $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$syn_ack_nr" ]; then
+		echo "[fail] got $count JOIN[s] synack expected $syn_ack_nr"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - ack"
+	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinAckRx | awk '{=
print $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$ack_nr" ]; then
+		echo "[fail] got $count JOIN[s] ack expected $ack_nr"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo "[ ok ]"
+	fi
+	if [ "${dump_stats}" =3D 1 ]; then
+		echo Server ns stats
+		ip netns exec $ns1 nstat -as | grep MPTcp
+		echo Client ns stats
+		ip netns exec $ns2 nstat -as | grep MPTcp
+	fi
 }
 =

 sin=3D$(mktemp)
@@ -248,49 +276,79 @@ make_file "$sin" "server"
 trap cleanup EXIT
 =

 run_tests $ns1 $ns2 10.0.1.1
-chk_join_nr "no JOIN" $ns1 "0"
+chk_join_nr "no JOIN" "0" "0" "0"
+
+# subflow limted by client
+reset
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+run_tests $ns1 $ns2 10.0.1.1
+chk_join_nr "single subflow, limited by client" 0 0 0
+
+# subflow limted by server
+reset
+ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+run_tests $ns1 $ns2 10.0.1.1
+chk_join_nr "single subflow, limited by server" 1 1 0
 =

 # subflow
 reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 0 1
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 run_tests $ns1 $ns2 10.0.1.1
-chk_join_nr "single subflow" $ns1 1
+chk_join_nr "single subflow" 1 1 1
 =

 # multiple subflows
 reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+ip netns exec $ns2 ./pm_nl_ctl limits 0 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
 run_tests $ns1 $ns2 10.0.1.1
-chk_join_nr "multiple subflows" $ns1 2
+chk_join_nr "multiple subflows" 2 2 2
+
+
+# multiple subflows limited by serverf
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+run_tests $ns1 $ns2 10.0.1.1
+chk_join_nr "multiple subflows, limited by server" 2 2 1
 =

 # add_address, unused
 reset
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 run_tests $ns1 $ns2 10.0.1.1
-chk_join_nr "unused signal address" $ns1 0
+chk_join_nr "unused signal address" 0 0 0
 =

 # accept and use add_addr
 reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-ip netns exec $ns2 ./pm_nl_ctl accept 1
 run_tests $ns1 $ns2 10.0.1.1
-chk_join_nr "signal address" $ns1 1
+chk_join_nr "signal address" 1 1 1
 =

 # accept and use add_addr with an additional subflow
 reset
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-ip netns exec $ns2 ./pm_nl_ctl accept 1
+ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+ip netns exec $ns2 ./pm_nl_ctl limits 1 2
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 run_tests $ns1 $ns2 10.0.1.1
-chk_join_nr "subflow and signal" $ns1 2
+chk_join_nr "subflow and signal" 2 2 2
 =

 # accept and use add_addr with an additional subflows
 reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 3
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-ip netns exec $ns2 ./pm_nl_ctl accept 1
+ip netns exec $ns2 ./pm_nl_ctl limits 1 3
 ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.2 flags signal
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 run_tests $ns1 $ns2 10.0.1.1
-chk_join_nr "multiple subflows and signal" $ns1 3
+chk_join_nr "multiple subflows and signal" 3 3 3
 =

-exit $ret
\ No newline at end of file
+exit $ret
-- =

2.21.1

--===============5220928044715119604==--
