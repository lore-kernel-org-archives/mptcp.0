Content-Type: multipart/mixed; boundary="===============8767293103630035595=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 5/5] selftests: mptcp: add the
 MP_PRIO testcases
Date: Fri, 20 Nov 2020 15:07:54 +0800
Message-ID: <5ab209d6bf791e0f2ada7a4cad56f88f2d614b38.1605855783.git.geliangtang@gmail.com>
In-Reply-To: 7d895c955dbde5094f6bfc18b17779a75baa5861.1605855783.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6867

--===============8767293103630035595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the MP_PRIO testcases:

Add a new argument bkup for run_tests and do_transfer to mark how many
times we want to execute the 'pm_nl_ctl flags backup' command.

Add a new function chk_prio_nr to check the MP_PRIO related MIB counters.

The output looks like this:

29 single subflow, backup      syn[ ok ] - synack[ ok ] - ack[ ok ]
                               ptx[ ok ] - prx   [ ok ]
30 single address, backup      syn[ ok ] - synack[ ok ] - ack[ ok ]
                               add[ ok ] - echo  [ ok ]
                               ptx[ ok ] - prx   [ ok ]

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 81 ++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index dd094e3e7f14..84cb4dd0a0eb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -213,6 +213,7 @@ do_transfer()
 	rm_nr_ns2=3D"$8"
 	speed=3D"$9"
 	with_port=3D"${10}"
+	bkup=3D"${11}"
 =

 	port=3D$((10000+$TEST_COUNT))
 	TEST_COUNT=3D$((TEST_COUNT+1))
@@ -294,6 +295,27 @@ do_transfer()
 		done
 	fi
 =

+	if [ $bkup -gt 0 ]; then
+		counter=3D1
+
+		while [ $counter -le $bkup ]
+		do
+			sleep 1
+			for netns in "$ns1" "$ns2";do
+				dump=3D(`ip netns exec $netns ./pm_nl_ctl dump`)
+				num=3D${#dump[@]}
+				while [ $num -gt 0 ]
+				do
+					backup=3D"ip netns exec $netns \
+						./pm_nl_ctl add ${dump[$num - 1]} flags backup"
+					$backup
+					num=3D$(($num - 5))
+				done
+			done
+			let counter+=3D1
+		done
+	fi
+
 	wait $cpid
 	retc=3D$?
 	wait $spid
@@ -361,6 +383,7 @@ run_tests()
 	rm_nr_ns2=3D"${6:-0}"
 	speed=3D"${7:-fast}"
 	with_port=3D"${8:-0}"
+	bkup=3D${9:-0}
 	lret=3D0
 	oldin=3D""
 =

@@ -375,7 +398,7 @@ run_tests()
 	fi
 =

 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
-		${test_linkfail} ${rm_nr_ns1} ${rm_nr_ns2} ${speed} ${with_port}
+		${test_linkfail} ${rm_nr_ns1} ${rm_nr_ns2} ${speed} ${with_port} ${bkup}
 	lret=3D$?
 =

 	if [ "$test_linkfail" -eq 1 ];then
@@ -564,6 +587,43 @@ chk_rm_nr()
 	fi
 }
 =

+chk_prio_nr()
+{
+	local mp_prio_nr_tx=3D$1
+	local mp_prio_nr_rx=3D$2
+	local count
+	local dump_stats
+
+	printf "%-39s %s" " " "ptx"
+	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioTx | awk '{pri=
nt $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$mp_prio_nr_tx" ]; then
+		echo "[fail] got $count MP_PRIO[s] TX expected $mp_prio_nr_tx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - prx   "
+	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioRx | awk '{pri=
nt $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$mp_prio_nr_rx" ]; then
+		echo "[fail] got $count MP_PRIO[s] RX expected $mp_prio_nr_rx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo "[ ok ]"
+	fi
+
+	if [ "${dump_stats}" =3D 1 ]; then
+		echo Server ns stats
+		ip netns exec $ns1 nstat -as | grep MPTcp
+		echo Client ns stats
+		ip netns exec $ns2 nstat -as | grep MPTcp
+	fi
+}
+
 sin=3D$(mktemp)
 sout=3D$(mktemp)
 cin=3D$(mktemp)
@@ -831,6 +891,25 @@ run_tests $ns1 $ns2 10.0.1.1 0 0 0 fast 10100
 chk_join_nr "signal address with port, userspace" 1 0 0
 chk_add_nr 1 1 1 0 0 0
 =

+# single subflow, backup
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow 0 1
+chk_join_nr "single subflow, backup" 1 1 1
+chk_prio_nr 0 1
+
+# single address, backup
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow 0 2
+chk_join_nr "single address, backup" 1 1 1
+chk_add_nr 1 1
+chk_prio_nr 2 0
+
 # single subflow, syncookies
 reset_with_cookies
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-- =

2.26.2

--===============8767293103630035595==--
