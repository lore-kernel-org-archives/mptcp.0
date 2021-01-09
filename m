Content-Type: multipart/mixed; boundary="===============8116792863934588966=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 8/8] selftests: mptcp: add the MP_PRIO
 testcases
Date: Fri, 08 Jan 2021 16:48:02 -0800
Message-ID: <20210109004802.341602-9-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210109004802.341602-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7296

--===============8116792863934588966==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

This patch added the MP_PRIO testcases:

Add a new argument bkup for run_tests and do_transfer, it can be set as
"backup" or "nobackup", the default value is "".

Add a new function chk_prio_nr to check the MP_PRIO related MIB counters.

The output looks like this:

29 single subflow, backup      syn[ ok ] - synack[ ok ] - ack[ ok ]
                               ptx[ ok ] - prx   [ ok ]
30 single address, backup      syn[ ok ] - synack[ ok ] - ack[ ok ]
                               add[ ok ] - echo  [ ok ]
                               ptx[ ok ] - prx   [ ok ]

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 72 ++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 9aa9624cff97..f74cd993b168 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -212,6 +212,7 @@ do_transfer()
 	rm_nr_ns1=3D"$7"
 	rm_nr_ns2=3D"$8"
 	speed=3D"$9"
+	bkup=3D"${10}"
 =

 	port=3D$((10000+$TEST_COUNT))
 	TEST_COUNT=3D$((TEST_COUNT+1))
@@ -297,6 +298,18 @@ do_transfer()
 		fi
 	fi
 =

+	if [ ! -z $bkup ]; then
+		sleep 1
+		for netns in "$ns1" "$ns2"; do
+			dump=3D(`ip netns exec $netns ./pm_nl_ctl dump`)
+			if [ ${#dump[@]} -gt 0 ]; then
+				addr=3D${dump[${#dump[@]} - 1]}
+				backup=3D"ip netns exec $netns ./pm_nl_ctl set $addr flags $bkup"
+				$backup
+			fi
+		done
+	fi
+
 	wait $cpid
 	retc=3D$?
 	wait $spid
@@ -358,6 +371,7 @@ run_tests()
 	rm_nr_ns1=3D"${5:-0}"
 	rm_nr_ns2=3D"${6:-0}"
 	speed=3D"${7:-fast}"
+	bkup=3D"${8:-""}"
 	lret=3D0
 	oldin=3D""
 =

@@ -372,7 +386,7 @@ run_tests()
 	fi
 =

 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
-		${test_linkfail} ${rm_nr_ns1} ${rm_nr_ns2} ${speed}
+		${test_linkfail} ${rm_nr_ns1} ${rm_nr_ns2} ${speed} ${bkup}
 	lret=3D$?
 =

 	if [ "$test_linkfail" -eq 1 ];then
@@ -509,6 +523,43 @@ chk_rm_nr()
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
@@ -739,6 +790,25 @@ chk_join_nr "remove subflow and signal IPv6" 2 2 2
 chk_add_nr 1 1
 chk_rm_nr 1 1
 =

+# single subflow, backup
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,backup
+run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
+chk_join_nr "single subflow, backup" 1 1 1
+chk_prio_nr 0 1
+
+# single address, backup
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+chk_join_nr "single address, backup" 1 1 1
+chk_add_nr 1 1
+chk_prio_nr 1 0
+
 # single subflow, syncookies
 reset_with_cookies
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-- =

2.30.0

--===============8116792863934588966==--
