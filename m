Content-Type: multipart/mixed; boundary="===============8322188079901648005=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH selftests 5/5] selftests: mptcp: random ethtool
 tweaking
Date: Fri, 13 Sep 2019 11:45:28 +0200
Message-ID: <20190913094528.3163-6-fw@strlen.de>
In-Reply-To: 20190913094528.3163-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1842

--===============8322188079901648005==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of unconditionally disabling TSO in ns3, turn off any of
gso/tso/gro in ns3 and/or ns4.

This gets us various combinations of GRO/GSO/TSO without a large
impact on test time.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 29 ++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 615691434a34..40cce8d1772e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -92,7 +92,6 @@ $ipv6 && ip -net ns3 addr add dead:beef:3::2/64 dev ns3et=
h4
 ip -net ns3 link set ns3eth4 up
 ip -net ns3 route add default via 10.0.2.1
 $ipv6 && ip -net ns3 route add default via dead:beef:2::1
-ip netns exec ns3 ethtool -K ns3eth2 tso off 2>/dev/null
 ip netns exec ns3 sysctl -q net.ipv4.ip_forward=3D1
 $ipv6 && ip netns exec ns3 sysctl -q net.ipv6.conf.all.forwarding=3D1
 =

@@ -102,6 +101,34 @@ ip -net ns4 link set ns4eth3 up
 ip -net ns4 route add default via 10.0.3.2
 $ipv6 && ip -net ns4 route add default via dead:beef:3::2
 =

+set_ethtool_flags() {
+	ns=3D$1
+	dev=3D$2
+
+	r=3D$RANDOM
+
+	pick1=3D$((r & 1))
+	r=3D$((r>>1))
+	pick2=3D$((r & 1))
+	r=3D$((r>>1))
+	pick3=3D$((r & 1))
+
+	comma=3D""
+	flags=3D""
+	[ $pick1 -ne 0 ] && flags=3D"tso"
+	[ $pick1 -ne 0 ] && comma=3D","
+	[ $pick2 -ne 0 ] && flags=3D${flags}${comma}"gso"
+	[ $pick3 -ne 0 ] && flags=3D${flags}${comma}"gro"
+
+	[ -z $flags ] && return
+
+	ip netns exec $ns ethtool -K $dev $flags off 2>/dev/null
+	[ $? -eq 0 ] && echo "INFO: set $ns dev $dev: ethtool -K $flags off"
+}
+
+set_ethtool_flags ns3 ns3eth2
+set_ethtool_flags ns4 ns4eth3
+
 print_file_err()
 {
 	ls -l "$1" 1>&2
-- =

2.21.0


--===============8322188079901648005==--
