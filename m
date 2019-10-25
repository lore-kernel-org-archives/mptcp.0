Content-Type: multipart/mixed; boundary="===============1457298448053757433=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v4 4/9] selftests: mptcp: random ethtool tweaking
Date: Fri, 25 Oct 2019 14:16:46 +0200
Message-ID: <20191025121651.25946-5-fw@strlen.de>
In-Reply-To: 20191025121651.25946-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2314

--===============1457298448053757433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of unconditionally disabling TSO in ns3, turn off any of gso/tso/gro
in ns3 and/or ns4.

This gets us various combinations of GRO/GSO/TSO without a large impact on
the average test run time.

The old approach is already not deterministic, and cannot possibly be
made so.  For protocol tests mptcp packetdrill is a better fit.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 26f8a2dadbe2..5daadd248008 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -91,7 +91,6 @@ $ipv6 && ip -net ns3 addr add dead:beef:3::2/64 dev ns3et=
h4
 ip -net ns3 link set ns3eth4 up
 ip -net ns3 route add default via 10.0.2.1
 $ipv6 && ip -net ns3 route add default via dead:beef:2::1
-ip netns exec ns3 ethtool -K ns3eth2 tso off 2>/dev/null
 ip netns exec ns3 sysctl -q net.ipv4.ip_forward=3D1
 $ipv6 && ip netns exec ns3 sysctl -q net.ipv6.conf.all.forwarding=3D1
 =

@@ -101,6 +100,30 @@ ip -net ns4 link set ns4eth3 up
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
+	pick2=3D$((r & 2))
+	pick3=3D$((r & 4))
+
+	flags=3D""
+	[ $pick1 -ne 0 ] && flags=3D"tso off"
+	[ $pick2 -ne 0 ] && flags=3D"$flags gso off"
+	[ $pick3 -ne 0 ] && flags=3D"$flags gro off"
+
+	[ -z "$flags" ] && return
+
+	ip netns exec $ns ethtool -K $dev $flags 2>/dev/null
+	[ $? -eq 0 ] && echo "INFO: set $ns dev $dev: ethtool -K $flags"
+}
+
+set_ethtool_flags ns3 ns3eth2
+set_ethtool_flags ns4 ns4eth3
+
 print_file_err()
 {
 	ls -l "$1" 1>&2
-- =

2.23.0

--===============1457298448053757433==--
