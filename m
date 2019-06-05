Content-Type: multipart/mixed; boundary="===============8494750918102891075=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: selftests: increase timeout and return error
 on ping failure
Date: Wed, 05 Jun 2019 11:36:58 +0200
Message-ID: <20190605093658.623-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 1287

--===============8494750918102891075==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now that we add a qdisc that does random drop, there is a small chance
for the ping to be dropped, so this triggers:
ns2 -> 10.0.1.2 connectivity [ FAIL ]

To fix this, split the ping test part to its own loop and only
add the qdiscs after the ping tests have completed.

Also, the script would still exit with 0 status in this case, so update
run_tests to check the return value of do_transfer() rather than rely on
that function to set the global exit state in all cases.

Last, increase the timeout: with qdiscs present, 10 seconds is too low:
in some rare cases sender or receiver exited too early.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 66 ++++++++++++++-----
 1 file changed, 49 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 6c1e19a39628..0a832c8e6b4f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -7,6 +7,7 @@ cin=3D""
 cout=3D""
 ksft_skip=3D4
 capture=3D0
+timeout=3D30
 =

 TEST_COUNT=3D0
 =

@@ -64,7 +65,6 @@ ip -net ns2 link set ns2eth1 up
 ip -net ns2 addr add 10.0.2.1/24 dev ns2eth3
 ip -net ns2 link set ns2eth3 up
 ip -net ns2 route add default via 10.0.2.2
-tc -net ns2 qdisc add dev ns2eth3 root netem loss random 1
 ip netns exec ns2 sysctl -q net.ipv4.ip_forward=3D1
 =

 ip -net ns3 addr add 10.0.2.2/24 dev ns3eth2
@@ -73,8 +73,7 @@ ip -net ns3 link set ns3eth2 up
 ip -net ns3 addr add 10.0.3.2/24 dev ns3eth4
 ip -net ns3 link set ns3eth4 up
 ip -net ns3 route add default via 10.0.2.1
-tc -net ns3 qdisc add dev ns3eth4 root netem delay 10ms reorder 25% 50% ga=
p 5
-ip netns exec ns3 ethtool -K ns3eth2 tso off
+ip netns exec ns3 ethtool -K ns3eth2 tso off 2>/dev/null
 ip netns exec ns3 sysctl -q net.ipv4.ip_forward=3D1
 =

 ip -net ns4 addr add 10.0.3.1/24 dev ns4eth3
@@ -106,6 +105,19 @@ check_transfer()
 	return 0
 }
 =

+do_ping()
+{
+	listener_ns=3D"$1"
+	connector_ns=3D"$2"
+	connect_addr=3D"$3"
+
+	ip netns exec ${connector_ns} ping -q -c 1 $connect_addr >/dev/null
+	if [ $? -ne 0 ] ; then
+		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]" 1>&2
+		ret=3D1
+	fi
+}
+
 do_transfer()
 {
 	listener_ns=3D"$1"
@@ -120,11 +132,6 @@ do_transfer()
 	:> "$cout"
 	:> "$sout"
 	:> "$capout"
-	ip netns exec ${connector_ns} ping -q -c 1 $connect_addr >/dev/null
-	if [ $? -ne 0 ] ; then
-		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]" 1>&2
-		return 1
-	fi
 =

 	printf "%-4s %-5s -> %-4s (%s:%d) %-5s\t" ${connector_ns} ${cl_proto} ${l=
istener_ns} ${connect_addr} ${port} ${srv_proto}
 =

@@ -143,12 +150,12 @@ do_transfer()
 	    sleep 1
 	fi
 =

-	ip netns exec ${listener_ns} ./mptcp_connect -t 10 -l -p $port -s ${srv_p=
roto} 0.0.0.0 < "$sin" > "$sout" &
+	ip netns exec ${listener_ns} ./mptcp_connect -t $timeout -l -p $port -s $=
{srv_proto} 0.0.0.0 < "$sin" > "$sout" &
 	spid=3D$!
 =

 	sleep 1
 =

-	ip netns exec ${connector_ns} ./mptcp_connect -t 10 -p $port -s ${cl_prot=
o} $connect_addr < "$cin" > "$cout" &
+	ip netns exec ${connector_ns} ./mptcp_connect -t $timeout -p $port -s ${c=
l_proto} $connect_addr < "$cin" > "$cout" &
 	cpid=3D$!
 =

 	wait $cpid
@@ -169,7 +176,6 @@ do_transfer()
 		ip netns exec ${connector_ns} ss -nita 1>&2 -o "dport =3D :$port"
 =

 		cat "$capout"
-		ret=3D$rets
 		return 1
 	fi
 =

@@ -209,20 +215,46 @@ make_file()
 =

 run_tests()
 {
-        listener_ns=3D"$1"
-        connector_ns=3D"$2"
+	listener_ns=3D"$1"
+	connector_ns=3D"$2"
 	connect_addr=3D"$3"
+	lret=3D0
+
+	for proto in MPTCP TCP;do
+		do_transfer ${listener_ns} ${connector_ns} MPTCP "$proto" ${connect_addr}
+		lret=3D$?
+		if [ $lret -ne 0 ]; then
+			ret=3D$lret
+			return
+		fi
+	done
 =

-	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr}
-	[ $? -ne 0 ] && return
-	do_transfer ${listener_ns} ${connector_ns} MPTCP TCP ${connect_addr}
-	[ $? -ne 0 ] && return
 	do_transfer ${listener_ns} ${connector_ns} TCP MPTCP ${connect_addr}
+	lret=3D$?
+	if [ $lret -ne 0 ]; then
+		ret=3D$lret
+		return
+	fi
 }
 =

 make_file "$cin" "client"
 make_file "$sin" "server"
 =

+for sender in 1 2 3 4;do
+	do_ping ns1 ns$sender 10.0.1.1
+
+	do_ping ns2 ns$sender 10.0.1.2
+	do_ping ns2 ns$sender 10.0.2.1
+
+	do_ping ns3 ns$sender 10.0.2.2
+	do_ping ns3 ns$sender 10.0.3.2
+
+	do_ping ns4 ns$sender 10.0.3.1
+done
+
+tc -net ns2 qdisc add dev ns2eth3 root netem loss random 1
+tc -net ns3 qdisc add dev ns3eth4 root netem delay 10ms reorder 25% 50% ga=
p 5
+
 for sender in 1 2 3 4;do
 	run_tests ns1 ns$sender 10.0.1.1
 =

-- =

2.21.0


--===============8494750918102891075==--
