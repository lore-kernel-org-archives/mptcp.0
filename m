Content-Type: multipart/mixed; boundary="===============7944609912222164952=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 5/6] selftests: allow parallel execution
Date: Tue, 15 Oct 2019 01:04:10 +0200
Message-ID: <20191014230411.1630-6-fw@strlen.de>
In-Reply-To: 20191014230411.1630-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2120

--===============7944609912222164952==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows to run multiple instances of the test script in
parallel on the same host.

Should it make easier to spot e.g. resource leaks or race conditions.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 163 +++++++++---------
 1 file changed, 85 insertions(+), 78 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 10655c6d0f62..3a1ddbdbbaf0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -11,6 +11,13 @@ capture=3D0
 timeout=3D30
 ipv6=3Dfalse
 =

+sec=3D$(date +%s)
+rndh=3D$(printf %x $sec)-$(mktemp -u XXXXXX)
+ns1=3D"ns1-$rndh"
+ns2=3D"ns2-$rndh"
+ns3=3D"ns3-$rndh"
+ns4=3D"ns4-$rndh"
+
 TEST_COUNT=3D0
 =

 cleanup()
@@ -19,8 +26,8 @@ cleanup()
 	rm -f "$sin" "$sout"
 	rm -f "$capout"
 =

-	for i in 1 2 3 4; do
-		ip netns del ns$i
+	for netns in "$ns1" "$ns2" "$ns3" "$ns4";do
+		ip netns del $netns
 	done
 }
 =

@@ -43,62 +50,62 @@ cout=3D$(mktemp)
 capout=3D$(mktemp)
 trap cleanup EXIT
 =

-for i in 1 2 3 4;do
-	ip netns add ns$i || exit $ksft_skip
-	ip -net ns$i link set lo up
+for i in "$ns1" "$ns2" "$ns3" "$ns4";do
+	ip netns add $i || exit $ksft_skip
+	ip -net $i link set lo up
 done
 =

-#  ns1              ns2                    ns3                     ns4
+#  "$ns1"              ns2                    ns3                     ns4
 # ns1eth2    ns2eth1   ns2eth3      ns3eth2   ns3eth4       ns4eth3
 #                           - drop 1% ->            reorder 25%
 #                           <- TSO off -
 =

-ip link add ns1eth2 netns ns1 type veth peer name ns2eth1 netns ns2
-ip link add ns2eth3 netns ns2 type veth peer name ns3eth2 netns ns3
-ip link add ns3eth4 netns ns3 type veth peer name ns4eth3 netns ns4
+ip link add ns1eth2 netns "$ns1" type veth peer name ns2eth1 netns "$ns2"
+ip link add ns2eth3 netns "$ns2" type veth peer name ns3eth2 netns "$ns3"
+ip link add ns3eth4 netns "$ns3" type veth peer name ns4eth3 netns "$ns4"
 =

-ip -net ns1 addr add 10.0.1.1/24 dev ns1eth2
+ip -net "$ns1" addr add 10.0.1.1/24 dev ns1eth2
 if $ipv6 ; then
-	ip -net ns1 addr add dead:beef:1::1/64 dev ns1eth2
+	ip -net "$ns1" addr add dead:beef:1::1/64 dev ns1eth2
 	if [ $? -ne 0 ] ;then
 		echo "SKIP: Can't add ipv6 address, skip ipv6 tests" 1>&2
 		ipv6=3Dfalse
 	fi
 fi
 =

-ip -net ns1 link set ns1eth2 up
-ip -net ns1 route add default via 10.0.1.2
-$ipv6 && ip -net ns1 route add default via dead:beef:1::2
-
-ip -net ns2 addr add 10.0.1.2/24 dev ns2eth1
-$ipv6 && ip -net ns2 addr add dead:beef:1::2/64 dev ns2eth1
-ip -net ns2 link set ns2eth1 up
-
-ip -net ns2 addr add 10.0.2.1/24 dev ns2eth3
-$ipv6 && ip -net ns2 addr add dead:beef:2::1/64 dev ns2eth3
-ip -net ns2 link set ns2eth3 up
-ip -net ns2 route add default via 10.0.2.2
-$ipv6 && ip -net ns2 route add default via dead:beef:2::2
-ip netns exec ns2 sysctl -q net.ipv4.ip_forward=3D1
-$ipv6 && ip netns exec ns2 sysctl -q net.ipv6.conf.all.forwarding=3D1
-
-ip -net ns3 addr add 10.0.2.2/24 dev ns3eth2
-$ipv6 && ip -net ns3 addr add dead:beef:2::2/64 dev ns3eth2
-ip -net ns3 link set ns3eth2 up
-
-ip -net ns3 addr add 10.0.3.2/24 dev ns3eth4
-$ipv6 && ip -net ns3 addr add dead:beef:3::2/64 dev ns3eth4
-ip -net ns3 link set ns3eth4 up
-ip -net ns3 route add default via 10.0.2.1
-$ipv6 && ip -net ns3 route add default via dead:beef:2::1
-ip netns exec ns3 sysctl -q net.ipv4.ip_forward=3D1
-$ipv6 && ip netns exec ns3 sysctl -q net.ipv6.conf.all.forwarding=3D1
-
-ip -net ns4 addr add 10.0.3.1/24 dev ns4eth3
-$ipv6 && ip -net ns4 addr add dead:beef:3::1/64 dev ns4eth3
-ip -net ns4 link set ns4eth3 up
-ip -net ns4 route add default via 10.0.3.2
-$ipv6 && ip -net ns4 route add default via dead:beef:3::2
+ip -net "$ns1" link set ns1eth2 up
+ip -net "$ns1" route add default via 10.0.1.2
+$ipv6 && ip -net "$ns1" route add default via dead:beef:1::2
+
+ip -net "$ns2" addr add 10.0.1.2/24 dev ns2eth1
+$ipv6 && ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1
+ip -net "$ns2" link set ns2eth1 up
+
+ip -net "$ns2" addr add 10.0.2.1/24 dev ns2eth3
+$ipv6 && ip -net "$ns2" addr add dead:beef:2::1/64 dev ns2eth3
+ip -net "$ns2" link set ns2eth3 up
+ip -net "$ns2" route add default via 10.0.2.2
+$ipv6 && ip -net "$ns2" route add default via dead:beef:2::2
+ip netns exec "$ns2" sysctl -q net.ipv4.ip_forward=3D1
+$ipv6 && ip netns exec "$ns2" sysctl -q net.ipv6.conf.all.forwarding=3D1
+
+ip -net "$ns3" addr add 10.0.2.2/24 dev ns3eth2
+$ipv6 && ip -net "$ns3" addr add dead:beef:2::2/64 dev ns3eth2
+ip -net "$ns3" link set ns3eth2 up
+
+ip -net "$ns3" addr add 10.0.3.2/24 dev ns3eth4
+$ipv6 && ip -net "$ns3" addr add dead:beef:3::2/64 dev ns3eth4
+ip -net "$ns3" link set ns3eth4 up
+ip -net "$ns3" route add default via 10.0.2.1
+$ipv6 && ip -net "$ns3" route add default via dead:beef:2::1
+ip netns exec "$ns3" sysctl -q net.ipv4.ip_forward=3D1
+$ipv6 && ip netns exec "$ns3" sysctl -q net.ipv6.conf.all.forwarding=3D1
+
+ip -net "$ns4" addr add 10.0.3.1/24 dev ns4eth3
+$ipv6 && ip -net "$ns4" addr add dead:beef:3::1/64 dev ns4eth3
+ip -net "$ns4" link set ns4eth3 up
+ip -net "$ns4" route add default via 10.0.3.2
+$ipv6 && ip -net "$ns4" route add default via dead:beef:3::2
 =

 set_ethtool_flags() {
 	ns=3D$1
@@ -125,8 +132,8 @@ set_ethtool_flags() {
 	[ $? -eq 0 ] && echo "INFO: set $ns dev $dev: ethtool -K $flags off"
 }
 =

-set_ethtool_flags ns3 ns3eth2
-set_ethtool_flags ns4 ns4eth3
+set_ethtool_flags "$ns3" ns3eth2
+set_ethtool_flags "$ns4" ns4eth3
 =

 print_file_err()
 {
@@ -155,7 +162,7 @@ check_transfer()
 =

 check_mptcp_disabled()
 {
-	disabled_ns=3D"ns_disabled"
+	disabled_ns=3D"ns_disabled-$sech-$(mktemp -u XXXXXX)"
 	ip netns add ${disabled_ns} || exit $ksft_skip
 =

 	# net.mptcp.enabled should be enabled by default
@@ -183,7 +190,7 @@ check_mptcp_disabled()
 =

 check_mptcp_ulp_setsockopt()
 {
-	local t=3D"ns_ulp" retval=3D
+	local t=3D"ns_ulp-$sech-$(mktemp -u XXXXXX)" retval=3D
 =

 	ip netns add ${t} || exit $ksft_skip
 	if ! ip netns exec ${t} ./mptcp_connect -u -p 10000 -s TCP 127.0.0.1 2>&1=
; then
@@ -348,40 +355,40 @@ check_mptcp_ulp_setsockopt
 # Allow DAD to finish
 $ipv6 && sleep 2
 =

-for sender in 1 2 3 4;do
-	do_ping ns1 ns$sender 10.0.1.1
+for sender in "$ns1" "$ns2" "$ns3" "$ns4";do
+	do_ping "$ns1" $sender 10.0.1.1
 	if $ipv6;then
-		do_ping ns1 ns$sender dead:beef:1::1
+		do_ping "$ns1" $sender dead:beef:1::1
 		if [ $? -ne 0 ]; then
 			echo "SKIP: IPv6 tests" 2>&1
 			ipv6=3Dfalse
 		fi
 	fi
 =

-	do_ping ns2 ns$sender 10.0.1.2
-	$ipv6 && do_ping ns2 ns$sender dead:beef:1::2
-	do_ping ns2 ns$sender 10.0.2.1
-	$ipv6 && do_ping ns2 ns$sender dead:beef:2::1
+	do_ping "$ns2" $sender 10.0.1.2
+	$ipv6 && do_ping "$ns2" $sender dead:beef:1::2
+	do_ping "$ns2" $sender 10.0.2.1
+	$ipv6 && do_ping "$ns2" $sender dead:beef:2::1
 =

-	do_ping ns3 ns$sender 10.0.2.2
-	$ipv6 && do_ping ns3 ns$sender dead:beef:2::2
-	do_ping ns3 ns$sender 10.0.3.2
-	$ipv6 && do_ping ns3 ns$sender dead:beef:3::2
+	do_ping "$ns3" $sender 10.0.2.2
+	$ipv6 && do_ping "$ns3" $sender dead:beef:2::2
+	do_ping "$ns3" $sender 10.0.3.2
+	$ipv6 && do_ping "$ns3" $sender dead:beef:3::2
 =

-	do_ping ns4 ns$sender 10.0.3.1
-	$ipv6 && do_ping ns4 ns$sender dead:beef:3::1
+	do_ping ns4 $sender 10.0.3.1
+	$ipv6 && do_ping "$ns4" $sender dead:beef:3::1
 done
 =

 loss=3D$((RANDOM%101))
 if [ $loss -eq 100 ] ;then
 	loss=3D1%
-	tc -net ns2 qdisc add dev ns2eth3 root netem loss random $loss
+	tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $loss
 elif [ $loss -ge 10 ]; then
 	loss=3D0.$loss%
-	tc -net ns2 qdisc add dev ns2eth3 root netem loss random $loss
+	tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $loss
 elif [ $loss -ge 1 ]; then
 	loss=3D0.0$loss%
-	tc -net ns2 qdisc add dev ns2eth3 root netem loss random $loss
+	tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $loss
 fi
 =

 delay=3D$((RANDOM%1200))
@@ -395,32 +402,32 @@ else
 fi
 =

 if [ $reorder1 -gt 0 ] && [ $reorder2 -gt 0 ]; then
-  tc -net ns3 qdisc add dev ns3eth4 root netem delay ${delay}ms reorder ${=
reorder1}% ${reorder2}% $gap
+  tc -net "$ns3" qdisc add dev ns3eth4 root netem delay ${delay}ms reorder=
 ${reorder1}% ${reorder2}% $gap
 fi
 echo "INFO: Using loss of $loss, delay $delay ms, reorder: $reorder1, $reo=
rder2 $gap on ns3eth4"
 =

-for sender in 1 2 3 4;do
-	run_tests ns1 ns$sender 10.0.1.1 0.0.0.0
+for sender in $ns1 $ns2 $ns3 $ns4;do
+	run_tests "$ns1" $sender 10.0.1.1 0.0.0.0
 	if $ipv6;then
-		run_tests ns1 ns$sender dead:beef:1::1 ::
+		run_tests "$ns1" $sender dead:beef:1::1 ::
 		if [ $? -ne 0 ] ;then
 			echo "SKIP: IPv6 tests" 2>&1
 			ipv6=3Dfalse
 		fi
 	fi
 =

-	run_tests ns2 ns$sender 10.0.1.2 0.0.0.0
-	$ipv6 && run_tests ns2 ns$sender dead:beef:1::2 ::
-	run_tests ns2 ns$sender 10.0.2.1 0.0.0.0
-	$ipv6 && run_tests ns2 ns$sender dead:beef:2::1 ::
+	run_tests "$ns2" $sender 10.0.1.2 0.0.0.0
+	$ipv6 && run_tests "$ns2" $sender dead:beef:1::2 ::
+	run_tests "$ns2" $sender 10.0.2.1 0.0.0.0
+	$ipv6 && run_tests "$ns2" $sender dead:beef:2::1 ::
 =

-	run_tests ns3 ns$sender 10.0.2.2 0.0.0.0
-	$ipv6 && run_tests ns3 ns$sender dead:beef:2::2 ::
-	run_tests ns3 ns$sender 10.0.3.2 0.0.0.0
-	$ipv6 && run_tests ns3 ns$sender dead:beef:3::2 ::
+	run_tests "$ns3" $sender 10.0.2.2 0.0.0.0
+	$ipv6 && run_tests "$ns3" $sender dead:beef:2::2 ::
+	run_tests "$ns3" $sender 10.0.3.2 0.0.0.0
+	$ipv6 && run_tests "$ns3" $sender dead:beef:3::2 ::
 =

-	run_tests ns4 ns$sender 10.0.3.1 0.0.0.0
-	$ipv6 && run_tests ns4 ns$sender dead:beef:3::1 ::
+	run_tests "$ns4" $sender 10.0.3.1 0.0.0.0
+	$ipv6 && run_tests "$ns4" $sender dead:beef:3::1 ::
 done
 =

 exit $ret
-- =

2.21.0

--===============7944609912222164952==--
