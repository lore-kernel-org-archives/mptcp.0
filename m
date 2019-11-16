Content-Type: multipart/mixed; boundary="===============0954079076863634625=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 09/10] selftests:mptcp: force MPTCP_IPV6 config
Date: Sat, 16 Nov 2019 13:59:35 +0100
Message-ID: <20191116125936.3563275-10-matthieu.baerts@tessares.net>
In-Reply-To: 20191116125936.3563275-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2570

--===============0954079076863634625==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We want our stack to be tested with v6, better to force the kconfig
accordingly then.

Also if we are sure we have IPv6 support, we can simplify the script to
always setup the IPv6 config but not launch IPv6 tests. We can then now
have result in ~15/20 seconds with the "-4" option.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: add basic kselftest for mptcp"

 tools/testing/selftests/net/mptcp/config      |   1 +
 .../selftests/net/mptcp/mptcp_connect.sh      | 118 +++++++++---------
 2 files changed, 62 insertions(+), 57 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selft=
ests/net/mptcp/config
index 3bfe60494af8..463f0514577d 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -1 +1,2 @@
 CONFIG_MPTCP=3Dy
+CONFIG_MPTCP_IPV6=3Dy
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 1e2a24946e36..a03760d12eff 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -124,47 +124,41 @@ ip link add ns2eth3 netns "$ns2" type veth peer name =
ns3eth2 netns "$ns3"
 ip link add ns3eth4 netns "$ns3" type veth peer name ns4eth3 netns "$ns4"
 =

 ip -net "$ns1" addr add 10.0.1.1/24 dev ns1eth2
-if $ipv6 ; then
-	ip -net "$ns1" addr add dead:beef:1::1/64 dev ns1eth2
-	if [ $? -ne 0 ] ;then
-		echo "SKIP: Can't add ipv6 address, skip ipv6 tests" 1>&2
-		ipv6=3Dfalse
-	fi
-fi
+ip -net "$ns1" addr add dead:beef:1::1/64 dev ns1eth2
 =

 ip -net "$ns1" link set ns1eth2 up
 ip -net "$ns1" route add default via 10.0.1.2
-$ipv6 && ip -net "$ns1" route add default via dead:beef:1::2
+ip -net "$ns1" route add default via dead:beef:1::2
 =

 ip -net "$ns2" addr add 10.0.1.2/24 dev ns2eth1
-$ipv6 && ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1
+ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1
 ip -net "$ns2" link set ns2eth1 up
 =

 ip -net "$ns2" addr add 10.0.2.1/24 dev ns2eth3
-$ipv6 && ip -net "$ns2" addr add dead:beef:2::1/64 dev ns2eth3
+ip -net "$ns2" addr add dead:beef:2::1/64 dev ns2eth3
 ip -net "$ns2" link set ns2eth3 up
 ip -net "$ns2" route add default via 10.0.2.2
-$ipv6 && ip -net "$ns2" route add default via dead:beef:2::2
+ip -net "$ns2" route add default via dead:beef:2::2
 ip netns exec "$ns2" sysctl -q net.ipv4.ip_forward=3D1
-$ipv6 && ip netns exec "$ns2" sysctl -q net.ipv6.conf.all.forwarding=3D1
+ip netns exec "$ns2" sysctl -q net.ipv6.conf.all.forwarding=3D1
 =

 ip -net "$ns3" addr add 10.0.2.2/24 dev ns3eth2
-$ipv6 && ip -net "$ns3" addr add dead:beef:2::2/64 dev ns3eth2
+ip -net "$ns3" addr add dead:beef:2::2/64 dev ns3eth2
 ip -net "$ns3" link set ns3eth2 up
 =

 ip -net "$ns3" addr add 10.0.3.2/24 dev ns3eth4
-$ipv6 && ip -net "$ns3" addr add dead:beef:3::2/64 dev ns3eth4
+ip -net "$ns3" addr add dead:beef:3::2/64 dev ns3eth4
 ip -net "$ns3" link set ns3eth4 up
 ip -net "$ns3" route add default via 10.0.2.1
-$ipv6 && ip -net "$ns3" route add default via dead:beef:2::1
+ip -net "$ns3" route add default via dead:beef:2::1
 ip netns exec "$ns3" sysctl -q net.ipv4.ip_forward=3D1
-$ipv6 && ip netns exec "$ns3" sysctl -q net.ipv6.conf.all.forwarding=3D1
+ip netns exec "$ns3" sysctl -q net.ipv6.conf.all.forwarding=3D1
 =

 ip -net "$ns4" addr add 10.0.3.1/24 dev ns4eth3
-$ipv6 && ip -net "$ns4" addr add dead:beef:3::1/64 dev ns4eth3
+ip -net "$ns4" addr add dead:beef:3::1/64 dev ns4eth3
 ip -net "$ns4" link set ns4eth3 up
 ip -net "$ns4" route add default via 10.0.3.2
-$ipv6 && ip -net "$ns4" route add default via dead:beef:3::2
+ip -net "$ns4" route add default via dead:beef:3::2
 =

 set_ethtool_flags() {
 	local ns=3D"$1"
@@ -272,12 +266,22 @@ check_mptcp_ulp_setsockopt()
 	return $retval
 }
 =

+# $1: IP address
+is_v6()
+{
+	[ -z "${1##*:*}" ]
+}
+
 do_ping()
 {
 	local listener_ns=3D"$1"
 	local connector_ns=3D"$2"
 	local connect_addr=3D"$3"
 =

+	if ! $ipv6 && is_v6 "${connect_addr}"; then
+		return 0
+	fi
+
 	ip netns exec ${connector_ns} ping -q -c 1 $connect_addr >/dev/null
 	if [ $? -ne 0 ] ; then
 		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]" 1>&2
@@ -420,8 +424,7 @@ run_tests_lo()
 	local listener_ns=3D"$1"
 	local connector_ns=3D"$2"
 	local connect_addr=3D"$3"
-	local local_addr=3D"$4"
-	local loopback=3D"$5"
+	local loopback=3D"$4"
 	local lret=3D0
 =

 	# skip if test programs are running inside same netns for subsequent runs.
@@ -429,6 +432,18 @@ run_tests_lo()
 		return 0
 	fi
 =

+	# skip if we don't want v6
+	if ! $ipv6 && is_v6 "${connect_addr}"; then
+		return 0
+	fi
+
+	local local_addr
+	if is_v6 "${connect_addr}"; then
+		local_addr=3D"::"
+	else
+		local_addr=3D"0.0.0.0"
+	fi
+
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} ${=
local_addr}
 	lret=3D$?
 	if [ $lret -ne 0 ]; then
@@ -460,7 +475,7 @@ run_tests_lo()
 =

 run_tests()
 {
-	run_tests_lo $1 $2 $3 $4 0
+	run_tests_lo $1 $2 $3 0
 }
 =

 make_file "$cin" "client"
@@ -479,36 +494,28 @@ show_all_ipv6()
 }
 =

 # Allow DAD to finish
-if $ipv6; then
-	for dad in $(seq 20); do
-		show_all_ipv6 | grep -q -e tentative -e temporary || break
-		sleep 0.1
-	done
-fi
+for dad in $(seq 20); do
+	show_all_ipv6 | grep -q -e tentative -e temporary || break
+	sleep 0.1
+done
 =

 echo "INFO: validating network environment with pings"
 for sender in "$ns1" "$ns2" "$ns3" "$ns4";do
 	do_ping "$ns1" $sender 10.0.1.1
-	if $ipv6;then
-		do_ping "$ns1" $sender dead:beef:1::1
-		if [ $? -ne 0 ]; then
-			echo "SKIP: IPv6 tests" 2>&1
-			ipv6=3Dfalse
-		fi
-	fi
+	do_ping "$ns1" $sender dead:beef:1::1
 =

 	do_ping "$ns2" $sender 10.0.1.2
-	$ipv6 && do_ping "$ns2" $sender dead:beef:1::2
+	do_ping "$ns2" $sender dead:beef:1::2
 	do_ping "$ns2" $sender 10.0.2.1
-	$ipv6 && do_ping "$ns2" $sender dead:beef:2::1
+	do_ping "$ns2" $sender dead:beef:2::1
 =

 	do_ping "$ns3" $sender 10.0.2.2
-	$ipv6 && do_ping "$ns3" $sender dead:beef:2::2
+	do_ping "$ns3" $sender dead:beef:2::2
 	do_ping "$ns3" $sender 10.0.3.2
-	$ipv6 && do_ping "$ns3" $sender dead:beef:3::2
+	do_ping "$ns3" $sender dead:beef:3::2
 =

 	do_ping "$ns4" $sender 10.0.3.1
-	$ipv6 && do_ping "$ns4" $sender dead:beef:3::1
+	do_ping "$ns4" $sender dead:beef:3::1
 done
 =

 [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss =
random $tc_loss
@@ -537,32 +544,29 @@ echo "on ns3eth4"
 tc -net "$ns3" qdisc add dev ns3eth4 root netem delay ${tc_delay}ms $tc_re=
order
 =

 for sender in $ns1 $ns2 $ns3 $ns4;do
-	run_tests_lo "$ns1" "$sender" 10.0.1.1 0.0.0.0 1
+	run_tests_lo "$ns1" "$sender" 10.0.1.1 1
 	if [ $ret -ne 0 ] ;then
 		echo "FAIL: Could not even run loopback test" 1>&2
 		exit $ret
 	fi
-	if $ipv6;then
-		run_tests_lo "$ns1" $sender dead:beef:1::1 :: 1
-		if [ $? -ne 0 ] ;then
-			echo "SKIP: IPv6 tests" 2>&1
-			ret=3D0
-			ipv6=3Dfalse
-		fi
+	run_tests_lo "$ns1" $sender dead:beef:1::1 1
+	if [ $ret -ne 0 ] ;then
+		echo "FAIL: Could not even run loopback v6 test" 2>&1
+		exit $ret
 	fi
 =

-	run_tests "$ns2" $sender 10.0.1.2 0.0.0.0
-	$ipv6 && run_tests "$ns2" $sender dead:beef:1::2 ::
-	run_tests "$ns2" $sender 10.0.2.1 0.0.0.0
-	$ipv6 && run_tests "$ns2" $sender dead:beef:2::1 ::
+	run_tests "$ns2" $sender 10.0.1.2
+	run_tests "$ns2" $sender dead:beef:1::2
+	run_tests "$ns2" $sender 10.0.2.1
+	run_tests "$ns2" $sender dead:beef:2::1
 =

-	run_tests "$ns3" $sender 10.0.2.2 0.0.0.0
-	$ipv6 && run_tests "$ns3" $sender dead:beef:2::2 ::
-	run_tests "$ns3" $sender 10.0.3.2 0.0.0.0
-	$ipv6 && run_tests "$ns3" $sender dead:beef:3::2 ::
+	run_tests "$ns3" $sender 10.0.2.2
+	run_tests "$ns3" $sender dead:beef:2::2
+	run_tests "$ns3" $sender 10.0.3.2
+	run_tests "$ns3" $sender dead:beef:3::2
 =

-	run_tests "$ns4" $sender 10.0.3.1 0.0.0.0
-	$ipv6 && run_tests "$ns4" $sender dead:beef:3::1 ::
+	run_tests "$ns4" $sender 10.0.3.1
+	run_tests "$ns4" $sender dead:beef:3::1
 done
 =

 time_end=3D$(date +%s)
-- =

2.24.0

--===============0954079076863634625==--
