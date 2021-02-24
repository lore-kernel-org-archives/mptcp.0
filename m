Content-Type: multipart/mixed; boundary="===============2016538048305303072=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 1/3] selftests: mptcp: launch mptcp_connect
 with timeout
Date: Wed, 24 Feb 2021 17:49:26 +0100
Message-ID: <20210224164928.2409821-2-matthieu.baerts@tessares.net>
In-Reply-To: 20210224164928.2409821-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7942

--===============2016538048305303072==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

'mptcp_connect' already has a timeout for poll() but in some cases, it
is not enough.

With "timeout" tool, we will force the command to fail if it doesn't
finish on time. Thanks to that, the script will continue and display
details about the current state before marking the test as failed.
Displaying this state is very important to be able to understand the
issue. Best to have our CI reporting the issue than just "the test
hanged".

Note that in mptcp_connect.sh, we were using a long timeout to validate
the fact we cannot create a socket if a sysctl is set. We don't need
this timeout.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/160
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 tools/testing/selftests/net/mptcp/diag.sh     | 38 ++++++++++++++++---
 .../selftests/net/mptcp/mptcp_connect.sh      | 15 ++++++--
 .../testing/selftests/net/mptcp/mptcp_join.sh | 22 ++++++++---
 .../selftests/net/mptcp/simult_flows.sh       | 13 +++++--
 4 files changed, 69 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/self=
tests/net/mptcp/diag.sh
index 39edce4f541c..35846f89cdad 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -5,6 +5,8 @@ rndh=3D$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns=3D"ns1-$rndh"
 ksft_skip=3D4
 test_cnt=3D1
+timeout_poll=3D100
+timeout_test=3D$((timeout_poll * 2 + 1))
 ret=3D0
 pids=3D()
 =

@@ -79,12 +81,20 @@ trap cleanup EXIT
 ip netns add $ns
 ip -n $ns link set dev lo up
 =

-echo "a" | ip netns exec $ns ./mptcp_connect -p 10000 -l 0.0.0.0 -t 100 >/=
dev/null &
+echo "a" | \
+	timeout ${timeout_test} \
+		ip netns exec $ns \
+			./mptcp_connect -p 10000 -l -t ${timeout_poll} \
+				0.0.0.0 >/dev/null &
 sleep 0.1
 pids[0]=3D$!
 chk_msk_nr 0 "no msk on netns creation"
 =

-echo "b" | ip netns exec $ns ./mptcp_connect -p 10000 127.0.0.1 -j -t 100 =
>/dev/null &
+echo "b" | \
+	timeout ${timeout_test} \
+		ip netns exec $ns \
+			./mptcp_connect -p 10000 -j -t ${timeout_poll} \
+				127.0.0.1 >/dev/null &
 sleep 0.1
 pids[1]=3D$!
 chk_msk_nr 2 "after MPC handshake "
@@ -93,10 +103,18 @@ chk_msk_fallback_nr 0 "....chk no fallback"
 flush_pids
 =

 =

-echo "a" | ip netns exec $ns ./mptcp_connect -p 10001 -s TCP -l 0.0.0.0 -t=
 100 >/dev/null &
+echo "a" | \
+	timeout ${timeout_test} \
+		ip netns exec $ns \
+			./mptcp_connect -p 10001 -l -s TCP -t ${timeout_poll} \
+				0.0.0.0 >/dev/null &
 pids[0]=3D$!
 sleep 0.1
-echo "b" | ip netns exec $ns ./mptcp_connect -p 10001 127.0.0.1 -j -t 100 =
>/dev/null &
+echo "b" | \
+	timeout ${timeout_test} \
+		ip netns exec $ns \
+			./mptcp_connect -p 10001 -j -t ${timeout_poll} \
+				127.0.0.1 >/dev/null &
 pids[1]=3D$!
 sleep 0.1
 chk_msk_fallback_nr 1 "check fallback"
@@ -104,13 +122,21 @@ flush_pids
 =

 NR_CLIENTS=3D100
 for I in `seq 1 $NR_CLIENTS`; do
-	echo "a" | ip netns exec $ns ./mptcp_connect -p $((I+10001)) -l 0.0.0.0 -=
t 100 -w 10 >/dev/null  &
+	echo "a" | \
+		timeout ${timeout_test} \
+			ip netns exec $ns \
+				./mptcp_connect -p $((I+10001)) -l -w 10 \
+					-t ${timeout_poll} 0.0.0.0 >/dev/null &
 	pids[$((I*2))]=3D$!
 done
 sleep 0.1
 =

 for I in `seq 1 $NR_CLIENTS`; do
-	echo "b" | ip netns exec $ns ./mptcp_connect -p $((I+10001)) 127.0.0.1 -t=
 100 -w 10 >/dev/null &
+	echo "b" | \
+		timeout ${timeout_test} \
+			ip netns exec $ns \
+				./mptcp_connect -p $((I+10001)) -w 10 \
+					-t ${timeout_poll} 127.0.0.1 >/dev/null &
 	pids[$((I*2 + 1))]=3D$!
 done
 sleep 1.5
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 10a030b53b23..9b437d9f3cce 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -11,7 +11,8 @@ cin=3D""
 cout=3D""
 ksft_skip=3D4
 capture=3Dfalse
-timeout=3D30
+timeout_poll=3D30
+timeout_test=3D$((timeout_poll * 2 + 1))
 ipv6=3Dtrue
 ethtool_random_on=3Dtrue
 tc_delay=3D"$((RANDOM%50))"
@@ -273,7 +274,7 @@ check_mptcp_disabled()
 	ip netns exec ${disabled_ns} sysctl -q net.mptcp.enabled=3D0
 =

 	local err=3D0
-	LANG=3DC ip netns exec ${disabled_ns} ./mptcp_connect -t $timeout -p 1000=
0 -s MPTCP 127.0.0.1 < "$cin" 2>&1 | \
+	LANG=3DC ip netns exec ${disabled_ns} ./mptcp_connect -p 10000 -s MPTCP 1=
27.0.0.1 < "$cin" 2>&1 | \
 		grep -q "^socket: Protocol not available$" && err=3D1
 	ip netns delete ${disabled_ns}
 =

@@ -430,14 +431,20 @@ do_transfer()
 	local stat_cookietx_last=3D$(get_mib_counter "${listener_ns}" "TcpExtSync=
ookiesSent")
 	local stat_cookierx_last=3D$(get_mib_counter "${listener_ns}" "TcpExtSync=
ookiesRecv")
 =

-	ip netns exec ${listener_ns} ./mptcp_connect -t $timeout -l -p $port -s $=
{srv_proto} $extra_args $local_addr < "$sin" > "$sout" &
+	timeout ${timeout_test} \
+		ip netns exec ${listener_ns} \
+			./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
+				$extra_args $local_addr < "$sin" > "$sout" &
 	local spid=3D$!
 =

 	wait_local_port_listen "${listener_ns}" "${port}"
 =

 	local start
 	start=3D$(date +%s%3N)
-	ip netns exec ${connector_ns} ./mptcp_connect -t $timeout -p $port -s ${c=
l_proto} $extra_args $connect_addr < "$cin" > "$cout" &
+	timeout ${timeout_test} \
+		ip netns exec ${connector_ns} \
+			./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+				$extra_args $connect_addr < "$cin" > "$cout" &
 	local cpid=3D$!
 =

 	wait $cpid
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 5d7f940bceac..6268fbf652cc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -8,7 +8,8 @@ cin=3D""
 cinsent=3D""
 cout=3D""
 ksft_skip=3D4
-timeout=3D30
+timeout_poll=3D30
+timeout_test=3D$((timeout_poll * 2 + 1))
 mptcp_connect=3D""
 capture=3D0
 =

@@ -250,17 +251,26 @@ do_transfer()
 		local_addr=3D"0.0.0.0"
 	fi
 =

-	ip netns exec ${listener_ns} $mptcp_connect -t $timeout -l -p $port \
-		-s ${srv_proto} ${local_addr} < "$sin" > "$sout" &
+	timeout ${timeout_test} \
+		ip netns exec ${listener_ns} \
+			$mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
+				${local_addr} < "$sin" > "$sout" &
 	spid=3D$!
 =

 	sleep 1
 =

 	if [ "$test_link_fail" -eq 0 ];then
-		ip netns exec ${connector_ns} $mptcp_connect -t $timeout -p $port -s ${c=
l_proto} $connect_addr < "$cin" > "$cout" &
+		timeout ${timeout_test} \
+			ip netns exec ${connector_ns} \
+				$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+					$connect_addr < "$cin" > "$cout" &
 	else
-		( cat "$cin" ; sleep 2; link_failure $listener_ns ; cat "$cin" ) | tee "=
$cinsent" | \
-		ip netns exec ${connector_ns} $mptcp_connect -t $timeout -p $port -s ${c=
l_proto} $connect_addr > "$cout" &
+		( cat "$cin" ; sleep 2; link_failure $listener_ns ; cat "$cin" ) | \
+			tee "$cinsent" | \
+			timeout ${timeout_test} \
+				ip netns exec ${connector_ns} \
+					$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+						$connect_addr > "$cout" &
 	fi
 	cpid=3D$!
 =

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/test=
ing/selftests/net/mptcp/simult_flows.sh
index f039ee57eb3c..3aeef3bcb101 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -7,7 +7,8 @@ ns2=3D"ns2-$rndh"
 ns3=3D"ns3-$rndh"
 capture=3Dfalse
 ksft_skip=3D4
-timeout=3D30
+timeout_poll=3D30
+timeout_test=3D$((timeout_poll * 2 + 1))
 test_cnt=3D1
 ret=3D0
 bail=3D0
@@ -157,14 +158,20 @@ do_transfer()
 		sleep 1
 	fi
 =

-	ip netns exec ${ns3} ./mptcp_connect -jt $timeout -l -p $port 0.0.0.0 < "=
$sin" > "$sout" &
+	timeout ${timeout_test} \
+		ip netns exec ${ns3} \
+			./mptcp_connect -jt ${timeout_poll} -l -p $port \
+				0.0.0.0 < "$sin" > "$sout" &
 	local spid=3D$!
 =

 	wait_local_port_listen "${ns3}" "${port}"
 =

 	local start
 	start=3D$(date +%s%3N)
-	ip netns exec ${ns1} ./mptcp_connect -jt $timeout -p $port 10.0.3.3 < "$c=
in" > "$cout" &
+	timeout ${timeout_test} \
+		ip netns exec ${ns1} \
+			./mptcp_connect -jt ${timeout_poll} -p $port \
+				10.0.3.3 < "$cin" > "$cout" &
 	local cpid=3D$!
 =

 	wait $cpid
-- =

2.30.0

--===============2016538048305303072==--
