Content-Type: multipart/mixed; boundary="===============0541166966151942941=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH selftests 4/5] selftests: mptcp: add ipv6 connectivity
Date: Fri, 13 Sep 2019 11:45:27 +0200
Message-ID: <20190913094528.3163-5-fw@strlen.de>
In-Reply-To: 20190913094528.3163-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1841

--===============0541166966151942941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

prepare for ipv6 mptcp tests.
Once someone starts to implement mptcp v6 support, just set ipv6=3Dtrue in
the script and the selftest will attempt to connect via ipv6.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 77 ++++++++++++++++---
 1 file changed, 66 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index fb9bf9f4fc8b..615691434a34 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -9,6 +9,7 @@ cout=3D""
 ksft_skip=3D4
 capture=3D0
 timeout=3D30
+ipv6=3Dfalse
 =

 TEST_COUNT=3D0
 =

@@ -58,29 +59,48 @@ ip link add ns2eth3 netns ns2 type veth peer name ns3et=
h2 netns ns3
 ip link add ns3eth4 netns ns3 type veth peer name ns4eth3 netns ns4
 =

 ip -net ns1 addr add 10.0.1.1/24 dev ns1eth2
+if $ipv6 ; then
+	ip -net ns1 addr add dead:beef:1::1/64 dev ns1eth2
+	if [ $? -ne 0 ] ;then
+		echo "SKIP: Can't add ipv6 address, skip ipv6 tests" 1>&2
+		ipv6=3Dfalse
+	fi
+fi
+
 ip -net ns1 link set ns1eth2 up
 ip -net ns1 route add default via 10.0.1.2
+$ipv6 && ip -net ns1 route add default via dead:beef:1::2
 =

 ip -net ns2 addr add 10.0.1.2/24 dev ns2eth1
+$ipv6 && ip -net ns2 addr add dead:beef:1::2/64 dev ns2eth1
 ip -net ns2 link set ns2eth1 up
 =

 ip -net ns2 addr add 10.0.2.1/24 dev ns2eth3
+$ipv6 && ip -net ns2 addr add dead:beef:2::1/64 dev ns2eth3
 ip -net ns2 link set ns2eth3 up
 ip -net ns2 route add default via 10.0.2.2
+$ipv6 && ip -net ns2 route add default via dead:beef:2::2
 ip netns exec ns2 sysctl -q net.ipv4.ip_forward=3D1
+$ipv6 && ip netns exec ns2 sysctl -q net.ipv6.conf.all.forwarding=3D1
 =

 ip -net ns3 addr add 10.0.2.2/24 dev ns3eth2
+$ipv6 && ip -net ns3 addr add dead:beef:2::2/64 dev ns3eth2
 ip -net ns3 link set ns3eth2 up
 =

 ip -net ns3 addr add 10.0.3.2/24 dev ns3eth4
+$ipv6 && ip -net ns3 addr add dead:beef:3::2/64 dev ns3eth4
 ip -net ns3 link set ns3eth4 up
 ip -net ns3 route add default via 10.0.2.1
+$ipv6 && ip -net ns3 route add default via dead:beef:2::1
 ip netns exec ns3 ethtool -K ns3eth2 tso off 2>/dev/null
 ip netns exec ns3 sysctl -q net.ipv4.ip_forward=3D1
+$ipv6 && ip netns exec ns3 sysctl -q net.ipv6.conf.all.forwarding=3D1
 =

 ip -net ns4 addr add 10.0.3.1/24 dev ns4eth3
+$ipv6 && ip -net ns4 addr add dead:beef:3::1/64 dev ns4eth3
 ip -net ns4 link set ns4eth3 up
 ip -net ns4 route add default via 10.0.3.2
+$ipv6 && ip -net ns4 route add default via dead:beef:3::2
 =

 print_file_err()
 {
@@ -138,7 +158,11 @@ do_ping()
 	if [ $? -ne 0 ] ; then
 		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]" 1>&2
 		ret=3D1
+
+		return 1
 	fi
+
+	return 0
 }
 =

 do_transfer()
@@ -148,6 +172,7 @@ do_transfer()
 	cl_proto=3D"$3"
 	srv_proto=3D"$4"
 	connect_addr=3D"$5"
+	local_addr=3D"$6"
 =

 	port=3D$((10000+$TEST_COUNT))
 	TEST_COUNT=3D$((TEST_COUNT+1))
@@ -173,7 +198,7 @@ do_transfer()
 	    sleep 1
 	fi
 =

-	ip netns exec ${listener_ns} ./mptcp_connect -t $timeout -l -p $port -s $=
{srv_proto} 0.0.0.0 < "$sin" > "$sout" &
+	ip netns exec ${listener_ns} ./mptcp_connect -t $timeout -l -p $port -s $=
{srv_proto} $local_addr < "$sin" > "$sout" &
 	spid=3D$!
 =

 	sleep 1
@@ -241,23 +266,26 @@ run_tests()
 	listener_ns=3D"$1"
 	connector_ns=3D"$2"
 	connect_addr=3D"$3"
+	local_addr=3D"$4"
 	lret=3D0
 =

 	for proto in MPTCP TCP;do
-		do_transfer ${listener_ns} ${connector_ns} MPTCP "$proto" ${connect_addr}
+		do_transfer ${listener_ns} ${connector_ns} MPTCP "$proto" ${connect_addr=
} ${local_addr}
 		lret=3D$?
 		if [ $lret -ne 0 ]; then
 			ret=3D$lret
-			return
+			return 1
 		fi
 	done
 =

-	do_transfer ${listener_ns} ${connector_ns} TCP MPTCP ${connect_addr}
+	do_transfer ${listener_ns} ${connector_ns} TCP MPTCP ${connect_addr} ${lo=
cal_addr}
 	lret=3D$?
 	if [ $lret -ne 0 ]; then
 		ret=3D$lret
-		return
+		return 1
 	fi
+
+	return 0
 }
 =

 make_file "$cin" "client"
@@ -265,16 +293,31 @@ make_file "$sin" "server"
 =

 check_mptcp_disabled
 =

+# Allow DAD to finish
+$ipv6 && sleep 2
+
 for sender in 1 2 3 4;do
 	do_ping ns1 ns$sender 10.0.1.1
+	if $ipv6;then
+		do_ping ns1 ns$sender dead:beef:1::1
+		if [ $? -ne 0 ]; then
+			echo "SKIP: IPv6 tests" 2>&1
+			ipv6=3Dfalse
+		fi
+	fi
 =

 	do_ping ns2 ns$sender 10.0.1.2
+	$ipv6 && do_ping ns2 ns$sender dead:beef:1::2
 	do_ping ns2 ns$sender 10.0.2.1
+	$ipv6 && do_ping ns2 ns$sender dead:beef:2::1
 =

 	do_ping ns3 ns$sender 10.0.2.2
+	$ipv6 && do_ping ns3 ns$sender dead:beef:2::2
 	do_ping ns3 ns$sender 10.0.3.2
+	$ipv6 && do_ping ns3 ns$sender dead:beef:3::2
 =

 	do_ping ns4 ns$sender 10.0.3.1
+	$ipv6 && do_ping ns4 ns$sender dead:beef:3::1
 done
 =

 loss=3D$((RANDOM%101))
@@ -305,15 +348,27 @@ fi
 echo "INFO: Using loss of $loss, delay $delay ms, reorder: $reorder1, $reo=
rder2 $gap on ns3eth4"
 =

 for sender in 1 2 3 4;do
-	run_tests ns1 ns$sender 10.0.1.1
+	run_tests ns1 ns$sender 10.0.1.1 0.0.0.0
+	if $ipv6;then
+		run_tests ns1 ns$sender dead:beef:1::1 ::
+		if [ $? -ne 0 ] ;then
+			echo "SKIP: IPv6 tests" 2>&1
+			ipv6=3Dfalse
+		fi
+	fi
 =

-	run_tests ns2 ns$sender 10.0.1.2
-	run_tests ns2 ns$sender 10.0.2.1
+	run_tests ns2 ns$sender 10.0.1.2 0.0.0.0
+	$ipv6 && run_tests ns2 ns$sender dead:beef:1::2 ::
+	run_tests ns2 ns$sender 10.0.2.1 0.0.0.0
+	$ipv6 && run_tests ns2 ns$sender dead:beef:2::1 ::
 =

-	run_tests ns3 ns$sender 10.0.2.2
-	run_tests ns3 ns$sender 10.0.3.2
+	run_tests ns3 ns$sender 10.0.2.2 0.0.0.0
+	$ipv6 && run_tests ns3 ns$sender dead:beef:2::2 ::
+	run_tests ns3 ns$sender 10.0.3.2 0.0.0.0
+	$ipv6 && run_tests ns3 ns$sender dead:beef:3::2 ::
 =

-	run_tests ns4 ns$sender 10.0.3.1
+	run_tests ns4 ns$sender 10.0.3.1 0.0.0.0
+	$ipv6 && run_tests ns4 ns$sender dead:beef:3::1 ::
 done
 =

 exit $ret
-- =

2.21.0


--===============0541166966151942941==--
