Content-Type: multipart/mixed; boundary="===============0294864989414746047=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/3] selftests: fixup for IPv6 tests
Date: Thu, 21 Nov 2019 16:41:50 +0100
Message-ID: <aaa6155d951d2423f6a22076970df3441b14a53d.1574350681.git.pabeni@redhat.com>
In-Reply-To: cover.1574350681.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2652

--===============0294864989414746047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add '-6' to ping argument to deal with older ping version.
Additionally, setting 'noadad' on ipv6 addresses will avoid
explicit waits later

v1 -> v2:
 - ping6 -> ping -6 (Matt)
 - drop show_all_ipv6, too (Matt)

Squash-to: "mptcp: add basic kselftest for mptcp"
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 34 ++++++-------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index a03760d12eff..21d481467e91 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -124,18 +124,18 @@ ip link add ns2eth3 netns "$ns2" type veth peer name =
ns3eth2 netns "$ns3"
 ip link add ns3eth4 netns "$ns3" type veth peer name ns4eth3 netns "$ns4"
 =

 ip -net "$ns1" addr add 10.0.1.1/24 dev ns1eth2
-ip -net "$ns1" addr add dead:beef:1::1/64 dev ns1eth2
+ip -net "$ns1" addr add dead:beef:1::1/64 dev ns1eth2 nodad
 =

 ip -net "$ns1" link set ns1eth2 up
 ip -net "$ns1" route add default via 10.0.1.2
 ip -net "$ns1" route add default via dead:beef:1::2
 =

 ip -net "$ns2" addr add 10.0.1.2/24 dev ns2eth1
-ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1
+ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1 nodad
 ip -net "$ns2" link set ns2eth1 up
 =

 ip -net "$ns2" addr add 10.0.2.1/24 dev ns2eth3
-ip -net "$ns2" addr add dead:beef:2::1/64 dev ns2eth3
+ip -net "$ns2" addr add dead:beef:2::1/64 dev ns2eth3 nodad
 ip -net "$ns2" link set ns2eth3 up
 ip -net "$ns2" route add default via 10.0.2.2
 ip -net "$ns2" route add default via dead:beef:2::2
@@ -143,11 +143,11 @@ ip netns exec "$ns2" sysctl -q net.ipv4.ip_forward=3D1
 ip netns exec "$ns2" sysctl -q net.ipv6.conf.all.forwarding=3D1
 =

 ip -net "$ns3" addr add 10.0.2.2/24 dev ns3eth2
-ip -net "$ns3" addr add dead:beef:2::2/64 dev ns3eth2
+ip -net "$ns3" addr add dead:beef:2::2/64 dev ns3eth2 nodad
 ip -net "$ns3" link set ns3eth2 up
 =

 ip -net "$ns3" addr add 10.0.3.2/24 dev ns3eth4
-ip -net "$ns3" addr add dead:beef:3::2/64 dev ns3eth4
+ip -net "$ns3" addr add dead:beef:3::2/64 dev ns3eth4 nodad
 ip -net "$ns3" link set ns3eth4 up
 ip -net "$ns3" route add default via 10.0.2.1
 ip -net "$ns3" route add default via dead:beef:2::1
@@ -155,7 +155,7 @@ ip netns exec "$ns3" sysctl -q net.ipv4.ip_forward=3D1
 ip netns exec "$ns3" sysctl -q net.ipv6.conf.all.forwarding=3D1
 =

 ip -net "$ns4" addr add 10.0.3.1/24 dev ns4eth3
-ip -net "$ns4" addr add dead:beef:3::1/64 dev ns4eth3
+ip -net "$ns4" addr add dead:beef:3::1/64 dev ns4eth3 nodad
 ip -net "$ns4" link set ns4eth3 up
 ip -net "$ns4" route add default via 10.0.3.2
 ip -net "$ns4" route add default via dead:beef:3::2
@@ -277,12 +277,14 @@ do_ping()
 	local listener_ns=3D"$1"
 	local connector_ns=3D"$2"
 	local connect_addr=3D"$3"
+	local ping_args=3D"-q -c 1"
 =

-	if ! $ipv6 && is_v6 "${connect_addr}"; then
-		return 0
+	if is_v6 "${connect_addr}"; then
+		$ipv6 || return 0
+		ping_args=3D"${ping_args} -6"
 	fi
 =

-	ip netns exec ${connector_ns} ping -q -c 1 $connect_addr >/dev/null
+	ip netns exec ${connector_ns} ping ${ping_args} $connect_addr >/dev/null
 	if [ $? -ne 0 ] ; then
 		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]" 1>&2
 		ret=3D1
@@ -485,20 +487,6 @@ check_mptcp_disabled
 =

 check_mptcp_ulp_setsockopt
 =

-show_all_ipv6()
-{
-	local ns
-	for ns in "$ns1" "$ns2" "$ns3" "$ns4"; do
-		ip -net "${ns}" -6 addr show scope global
-	done
-}
-
-# Allow DAD to finish
-for dad in $(seq 20); do
-	show_all_ipv6 | grep -q -e tentative -e temporary || break
-	sleep 0.1
-done
-
 echo "INFO: validating network environment with pings"
 for sender in "$ns1" "$ns2" "$ns3" "$ns4";do
 	do_ping "$ns1" $sender 10.0.1.1
-- =

2.21.0

--===============0294864989414746047==--
