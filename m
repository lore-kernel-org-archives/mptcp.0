Content-Type: multipart/mixed; boundary="===============4534864619052969404=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: selftests: exercise GSO,
 retransmission and reorder code path
Date: Tue, 21 May 2019 10:41:20 +0200
Message-ID: <cca394470989de199d076c6ea5667871f5e07b0d.1558427525.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1199

--===============4534864619052969404==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This introduces a few artifacts on the virtual network topology
via the netem scheduler and disabling features on some veth, so
that we exercise the MTCP stack more.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
notes:
 - to my surprise, self-tests are still succesfull here, even if
   some of them take considerably longer
 - this can be squashed into commit 40e8869bdd0f ("mptcp: selftests:
 switch to netns+veth based tests")
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index ee478e94d8a2..1ce5c85577fb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -45,8 +45,10 @@ for i in 1 2 3 4;do
 	ip -net ns$i link set lo up
 done
 =

-#  ns1            ns2                 ns3             ns4
-# ns1eth2    ns2eth1 ns2eth3  ns3eth2   ns3eth4   ns4eth3
+#  ns1              ns2                    ns3                     ns4
+# ns1eth2    ns2eth1   ns2eth3      ns3eth2   ns3eth4       ns4eth3
+#                           - drop 1% ->            reorder 25%
+#                           <- TSO off -
 =

 ip link add ns1eth2 netns ns1 type veth peer name ns2eth1 netns ns2
 ip link add ns2eth3 netns ns2 type veth peer name ns3eth2 netns ns3
@@ -62,6 +64,7 @@ ip -net ns2 link set ns2eth1 up
 ip -net ns2 addr add 10.0.2.1/24 dev ns2eth3
 ip -net ns2 link set ns2eth3 up
 ip -net ns2 route add default via 10.0.2.2
+tc -net ns2 qdisc add dev ns2eth3 root netem loss random 1
 ip netns exec ns2 sysctl -q net.ipv4.ip_forward=3D1
 =

 ip -net ns3 addr add 10.0.2.2/24 dev ns3eth2
@@ -70,6 +73,8 @@ ip -net ns3 link set ns3eth2 up
 ip -net ns3 addr add 10.0.3.2/24 dev ns3eth4
 ip -net ns3 link set ns3eth4 up
 ip -net ns3 route add default via 10.0.2.1
+tc -net ns3 qdisc add dev ns3eth4 root netem delay 10ms reorder 25% 50% ga=
p 5
+ip netns exec ns3 ethtook -K ns3eth2 tso off
 ip netns exec ns3 sysctl -q net.ipv4.ip_forward=3D1
 =

 ip -net ns4 addr add 10.0.3.1/24 dev ns4eth3
-- =

2.20.1


--===============4534864619052969404==--
