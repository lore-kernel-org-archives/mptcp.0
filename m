Content-Type: multipart/mixed; boundary="===============7407276766882960916=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v4 1/9] selftests: mptcp: make tc delays random
Date: Fri, 25 Oct 2019 14:16:43 +0200
Message-ID: <20191025121651.25946-2-fw@strlen.de>
In-Reply-To: 20191025121651.25946-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2311

--===============7407276766882960916==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

test with less predictable setups:
tc qdisc delay is now random, same for reordering and loss.
Motivation is to cover more scenarious without a increase in test-time.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index f0528df9ac31..d31fe01824ec 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -302,8 +302,30 @@ for sender in 1 2 3 4;do
 	do_ping ns4 ns$sender 10.0.3.1
 done
 =

-tc -net ns2 qdisc add dev ns2eth3 root netem loss random 1
-tc -net ns3 qdisc add dev ns3eth4 root netem delay 10ms reorder 25% 50% ga=
p 5
+loss=3D$((RANDOM%101))
+if [ $loss -eq 100 ] ;then
+	loss=3D1%
+	tc -net ns2 qdisc add dev ns2eth3 root netem loss random $loss
+elif [ $loss -ge 10 ]; then
+	loss=3D0.$loss%
+	tc -net ns2 qdisc add dev ns2eth3 root netem loss random $loss
+elif [ $loss -ge 1 ]; then
+	loss=3D0.0$loss%
+	tc -net ns2 qdisc add dev ns2eth3 root netem loss random $loss
+fi
+
+delay=3D$((RANDOM%400))
+reorder1=3D$((RANDOM%10))
+reorder1=3D$((100 - reorder1))
+reorder2=3D$((RANDOM%100))
+
+if [ $reorder1 -lt 100 ] && [ $reorder2 -gt 0 ]; then
+  tc -net ns3 qdisc add dev ns3eth4 root netem delay ${delay}ms reorder ${=
reorder1}% ${reorder2}%
+  echo "INFO: Using loss of $loss, delay $delay ms, reorder: $reorder1, $r=
eorder2 on ns3eth4"
+elif [ $delay -gt 0 ]; then
+  tc -net ns3 qdisc add dev ns3eth4 root netem delay ${delay}ms
+  echo "INFO: Using loss of $loss, delay $delay ms on ns3eth4"
+fi
 =

 for sender in 1 2 3 4;do
 	run_tests ns1 ns$sender 10.0.1.1
-- =

2.23.0

--===============7407276766882960916==--
