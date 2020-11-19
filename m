Content-Type: multipart/mixed; boundary="===============1893738150248804905=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v5 mptcp-next 10/10] selftests: mptcp: add
 testcases for ADD_ADDR with port
Date: Thu, 19 Nov 2020 18:19:50 +0800
Message-ID: <2789067438289a7a12f0cbdd261b5558fb4c733f.1605780306.git.geliangtang@gmail.com>
In-Reply-To: 90b437848f259eeb0d40383623ce1e523a8219bc.1605780306.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6821

--===============1893738150248804905==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added five new testcases for ADD_ADDR with port:

In the first four testcases, the new port is listened in the kernel side.
The connections in these testcases are accepted.

The last testcase's new port is listened in the userspace, so this
connection will fail. For this testcase, we added a new argument for
run_tests and do_transfer, if the with_port argument is set, we need to
establish a new connection to listen for the new port in the userspace.

It also added the ADD_ADDR port related MIB counters checks in chk_add_nr.

The output looks like this:

 24 signal address with port           syn[ ok ] - synack[ ok ] - ack[ ok ]
                                       add[ ok ] - echo  [ ok ] - pt [ ok ]
                                       syn[ ok ] - synack[ ok ] - ack[ ok ]
 25 subflow and signal with port       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                       add[ ok ] - echo  [ ok ] - pt [ ok ]
                                       syn[ ok ] - synack[ ok ] - ack[ ok ]
 26 remove single address with port    syn[ ok ] - synack[ ok ] - ack[ ok ]
                                       add[ ok ] - echo  [ ok ] - pt [ ok ]
                                       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                       rm [ ok ] - sf    [ ok ]

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 118 +++++++++++++++++-
 1 file changed, 116 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 0eae628d1ffd..dd094e3e7f14 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -212,6 +212,7 @@ do_transfer()
 	rm_nr_ns1=3D"$7"
 	rm_nr_ns2=3D"$8"
 	speed=3D"$9"
+	with_port=3D"${10}"
 =

 	port=3D$((10000+$TEST_COUNT))
 	TEST_COUNT=3D$((TEST_COUNT+1))
@@ -253,6 +254,12 @@ do_transfer()
 		-s ${srv_proto} ${local_addr} < "$sin" > "$sout" &
 	spid=3D$!
 =

+	if [ "$with_port" -gt 0 ];then
+		ip netns exec ${listener_ns} $mptcp_connect -t $timeout -l -p $with_port=
 \
+			-s ${srv_proto} ${local_addr} < "$sin" > "$sout" &
+		spid_with_port=3D$!
+	fi
+
 	sleep 1
 =

 	if [ "$test_link_fail" -eq 0 ];then
@@ -292,6 +299,11 @@ do_transfer()
 	wait $spid
 	rets=3D$?
 =

+	if [ "$with_port" -gt 0 ];then
+		sleep 1
+		kill $spid_with_port
+	fi
+
 	if [ $capture -eq 1 ]; then
 	    sleep 1
 	    kill $cappid
@@ -348,6 +360,7 @@ run_tests()
 	rm_nr_ns1=3D"${5:-0}"
 	rm_nr_ns2=3D"${6:-0}"
 	speed=3D"${7:-fast}"
+	with_port=3D"${8:-0}"
 	lret=3D0
 	oldin=3D""
 =

@@ -362,7 +375,7 @@ run_tests()
 	fi
 =

 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
-		${test_linkfail} ${rm_nr_ns1} ${rm_nr_ns2} ${speed}
+		${test_linkfail} ${rm_nr_ns1} ${rm_nr_ns2} ${speed} ${with_port}
 	lret=3D$?
 =

 	if [ "$test_linkfail" -eq 1 ];then
@@ -429,6 +442,10 @@ chk_add_nr()
 {
 	local add_nr=3D$1
 	local echo_nr=3D$2
+	local port_nr=3D${3:-0}
+	local syn_nr=3D${4:-$port_nr}
+	local syn_ack_nr=3D${5:-$port_nr}
+	local ack_nr=3D${6:-$port_nr}
 	local count
 	local dump_stats
 =

@@ -451,7 +468,55 @@ chk_add_nr()
 		ret=3D1
 		dump_stats=3D1
 	else
-		echo "[ ok ]"
+		echo -n "[ ok ]"
+	fi
+
+	if [ $port_nr -gt 0 ]; then
+		echo -n " - pt "
+		count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtPortAdd | awk '{pri=
nt $2}'`
+		[ -z "$count" ] && count=3D0
+		if [ "$count" !=3D "$port_nr" ]; then
+			echo "[fail] got $count ADD_ADDR[s] with port expected $port_nr"
+			ret=3D1
+			dump_stats=3D1
+		else
+			echo "[ ok ]"
+		fi
+
+		printf "%-39s %s" " " "syn"
+		count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtPortSynRx | awk '{p=
rint $2}'`
+		[ -z "$count" ] && count=3D0
+		if [ "$count" !=3D "$syn_nr" ]; then
+			echo "[fail] got $count JOIN[s] syn with port expected $syn_nr"
+			ret=3D1
+			dump_stats=3D1
+		else
+			echo -n "[ ok ]"
+		fi
+
+		echo -n " - synack"
+		count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtPortSynAckRx | awk =
'{print $2}'`
+		[ -z "$count" ] && count=3D0
+		if [ "$count" !=3D "$syn_ack_nr" ]; then
+			echo "[fail] got $count JOIN[s] synack with port expected $syn_ack_nr"
+			ret=3D1
+			dump_stats=3D1
+		else
+			echo -n "[ ok ]"
+		fi
+
+		echo -n " - ack"
+		count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtPortAckRx | awk '{p=
rint $2}'`
+		[ -z "$count" ] && count=3D0
+		if [ "$count" !=3D "$ack_nr" ]; then
+			echo "[fail] got $count JOIN[s] ack with port expected $ack_nr"
+			ret=3D1
+			dump_stats=3D1
+		else
+			echo "[ ok ]"
+		fi
+	else
+		echo ""
 	fi
 =

 	if [ "${dump_stats}" =3D 1 ]; then
@@ -717,6 +782,55 @@ chk_join_nr "remove subflow and signal IPv6" 2 2 2
 chk_add_nr 1 1
 chk_rm_nr 1 1
 =

+# signal address with port
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
+run_tests $ns1 $ns2 10.0.1.1
+chk_join_nr "signal address with port" 1 1 1
+chk_add_nr 1 1 1
+
+# subflow and signal with port
+reset
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
+ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+run_tests $ns1 $ns2 10.0.1.1
+chk_join_nr "subflow and signal with port" 2 2 2
+chk_add_nr 1 1 1
+
+# single address with port, remove
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
+ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
+chk_join_nr "remove single address with port" 1 1 1
+chk_add_nr 1 1 1
+chk_rm_nr 0 0
+
+# subflow and signal with port, remove
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
+ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+run_tests $ns1 $ns2 10.0.1.1 0 1 1 slow
+chk_join_nr "remove subflow and signal with port" 2 2 2
+chk_add_nr 1 1 1
+chk_rm_nr 1 1
+
+# signal address with port, userspace
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
+run_tests $ns1 $ns2 10.0.1.1 0 0 0 fast 10100
+chk_join_nr "signal address with port, userspace" 1 0 0
+chk_add_nr 1 1 1 0 0 0
+
 # single subflow, syncookies
 reset_with_cookies
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-- =

2.26.2

--===============1893738150248804905==--
