Content-Type: multipart/mixed; boundary="===============1177529384893339087=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v9 mptcp-next 8/8] selftests: mptcp: add remove
 addr and subflow test cases
Date: Wed, 02 Sep 2020 17:38:30 +0800
Message-ID: <c104171cca961d9588265143d1c95eaf5e9191b2.1599038897.git.geliangtang@gmail.com>
In-Reply-To: cover.1599038897.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5693

--===============1177529384893339087==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the remove addr and subflow test cases and two new
functions.

The first function run_remove_tests calls do_transfer with two new
arguments, rm_nr_ns1 and rm_nr_ns2, for the numbers of addresses should be
removed during the transfer process in namespace 1 and namespace 2.

If both these two arguments are 0, we do the join test cases with
"mptcp_connect -j" command. Otherwise, do the remove test cases with
"mptcp_connect -r" command.

The second function chk_rm_nr checks the RM_ADDR related mibs's counters.

The output of the test cases looks like this:

11 remove single subflow           syn[ ok ] - synack[ ok ] - ack[ ok ]
                                   rm [ ok ] - sf    [ ok ]
12 remove multiple subflows        syn[ ok ] - synack[ ok ] - ack[ ok ]
                                   rm [ ok ] - sf    [ ok ]
13 remove single address           syn[ ok ] - synack[ ok ] - ack[ ok ]
                                   add[ ok ] - echo  [ ok ]
                                   rm [ ok ] - sf    [ ok ]
14 remove subflow and signal       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                   add[ ok ] - echo  [ ok ]
                                   rm [ ok ] - sf    [ ok ]
15 remove subflows and signal      syn[ ok ] - synack[ ok ] - ack[ ok ]
                                   add[ ok ] - echo  [ ok ]
                                   rm [ ok ] - sf    [ ok ]

Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 145 +++++++++++++++++-
 1 file changed, 142 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index bf6172138bed..2f257cb6baf3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -8,6 +8,7 @@ cin=3D""
 cout=3D""
 ksft_skip=3D4
 timeout=3D30
+mptcp_connect=3D""
 capture=3D0
 =

 TEST_COUNT=3D0
@@ -132,6 +133,8 @@ do_transfer()
 	cl_proto=3D"$3"
 	srv_proto=3D"$4"
 	connect_addr=3D"$5"
+	rm_nr_ns1=3D"$6"
+	rm_nr_ns2=3D"$7"
 =

 	port=3D$((10000+$TEST_COUNT))
 	TEST_COUNT=3D$((TEST_COUNT+1))
@@ -156,14 +159,44 @@ do_transfer()
 		sleep 1
 	fi
 =

-	ip netns exec ${listener_ns} ./mptcp_connect -j -t $timeout -l -p $port -=
s ${srv_proto} 0.0.0.0 < "$sin" > "$sout" &
+	if [[ $rm_nr_ns1 -eq 0 && $rm_nr_ns2 -eq 0 ]]; then
+		mptcp_connect=3D"./mptcp_connect -j"
+	else
+		mptcp_connect=3D"./mptcp_connect -r"
+	fi
+
+	ip netns exec ${listener_ns} $mptcp_connect -t $timeout -l -p $port -s ${=
srv_proto} 0.0.0.0 < "$sin" > "$sout" &
 	spid=3D$!
 =

 	sleep 1
 =

-	ip netns exec ${connector_ns} ./mptcp_connect -j -t $timeout -p $port -s =
${cl_proto} $connect_addr < "$cin" > "$cout" &
+	ip netns exec ${connector_ns} $mptcp_connect -t $timeout -p $port -s ${cl=
_proto} $connect_addr < "$cin" > "$cout" &
 	cpid=3D$!
 =

+	if [ $rm_nr_ns1 -gt 0 ]; then
+		counter=3D1
+		sleep 1
+
+		while [ $counter -le $rm_nr_ns1 ]
+		do
+			ip netns exec ${listener_ns} ./pm_nl_ctl del $counter
+			sleep 1
+			let counter+=3D1
+		done
+	fi
+
+	if [ $rm_nr_ns2 -gt 0 ]; then
+		counter=3D1
+		sleep 1
+
+		while [ $counter -le $rm_nr_ns2 ]
+		do
+			ip netns exec ${connector_ns} ./pm_nl_ctl del $counter
+			sleep 1
+			let counter+=3D1
+		done
+	fi
+
 	wait $cpid
 	retc=3D$?
 	wait $spid
@@ -219,7 +252,24 @@ run_tests()
 	connect_addr=3D"$3"
 	lret=3D0
 =

-	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr}
+	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} 0 0
+	lret=3D$?
+	if [ $lret -ne 0 ]; then
+		ret=3D$lret
+		return
+	fi
+}
+
+run_remove_tests()
+{
+	listener_ns=3D"$1"
+	connector_ns=3D"$2"
+	connect_addr=3D"$3"
+	rm_nr_ns1=3D"$4"
+	rm_nr_ns2=3D"$5"
+	lret=3D0
+
+	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} ${=
rm_nr_ns1} ${rm_nr_ns2}
 	lret=3D$?
 	if [ $lret -ne 0 ]; then
 		ret=3D$lret
@@ -313,6 +363,43 @@ chk_add_nr()
 	fi
 }
 =

+chk_rm_nr()
+{
+	local rm_addr_nr=3D$1
+	local rm_subflow_nr=3D$2
+	local count
+	local dump_stats
+
+	printf "%-39s %s" " " "rm "
+	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtRmAddr | awk '{print=
 $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$rm_addr_nr" ]; then
+		echo "[fail] got $count RM_ADDR[s] expected $rm_addr_nr"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - sf    "
+	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtRmSubflow | awk '{pr=
int $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$rm_subflow_nr" ]; then
+		echo "[fail] got $count RM_SUBFLOW[s] expected $rm_subflow_nr"
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
@@ -404,6 +491,58 @@ run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "multiple subflows and signal" 3 3 3
 chk_add_nr 1 1
 =

+# single subflow, remove
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+run_remove_tests $ns1 $ns2 10.0.1.1 0 1
+chk_join_nr "remove single subflow" 1 1 1
+chk_rm_nr 1 1
+
+# multiple subflows, remove
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+run_remove_tests $ns1 $ns2 10.0.1.1 0 2
+chk_join_nr "remove multiple subflows" 2 2 2
+chk_rm_nr 2 2
+
+# single address, remove
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+run_remove_tests $ns1 $ns2 10.0.1.1 1 0
+chk_join_nr "remove single address" 1 1 1
+chk_add_nr 1 1
+chk_rm_nr 0 0
+
+# subflow and signal, remove
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+run_remove_tests $ns1 $ns2 10.0.1.1 1 1
+chk_join_nr "remove subflow and signal" 2 2 2
+chk_add_nr 1 1
+chk_rm_nr 1 1
+
+# subflows and signal, remove
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 3
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+run_remove_tests $ns1 $ns2 10.0.1.1 1 2
+chk_join_nr "remove subflows and signal" 3 3 3
+chk_add_nr 1 1
+chk_rm_nr 2 2
+
 # single subflow, syncookies
 reset_with_cookies
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-- =

2.17.1

--===============1177529384893339087==--
