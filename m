Content-Type: multipart/mixed; boundary="===============2179689268938937883=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] mptcp_connect.sh typo
Date: Mon, 27 May 2019 00:28:37 +0200
Message-ID: <20190526222837.cile7pt4xzcjcbwe@breakpoint.cc>
X-Status: 
X-Keywords:                  
X-UID: 1246

--===============2179689268938937883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For some reason ethtool is spelt "ethtook".

Could someone squash/fix this?
Thanks!

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -74,7 +74,7 @@ ip -net ns3 addr add 10.0.3.2/24 dev ns3eth4
 ip -net ns3 link set ns3eth4 up
 ip -net ns3 route add default via 10.0.2.1
 tc -net ns3 qdisc add dev ns3eth4 root netem delay 10ms reorder 25% 50% ga=
p 5
-ip netns exec ns3 ethtook -K ns3eth2 tso off
+ip netns exec ns3 ethtool -K ns3eth2 tso off
 ip netns exec ns3 sysctl -q net.ipv4.ip_forward=3D1
 =

 ip -net ns4 addr add 10.0.3.1/24 dev ns4eth3

--===============2179689268938937883==--
