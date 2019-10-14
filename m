Content-Type: multipart/mixed; boundary="===============8017252899326797274=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 1/6] selftests: mptcp: make tc delays random
Date: Tue, 15 Oct 2019 01:04:06 +0200
Message-ID: <20191014230411.1630-2-fw@strlen.de>
In-Reply-To: 20191014230411.1630-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2116

--===============8017252899326797274==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

test with less predictable setups:
tc qdisc delay is now random, same for reordering and loss.
Main motivation is to cover more scenarious without a large
increase in test-time.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 28 +++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index f0528df9ac31..21f884800ca8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -302,8 +302,32 @@ for sender in 1 2 3 4;do
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
+delay=3D$((RANDOM%1200))
+reorder1=3D$((RANDOM%99))
+reorder2=3D$((RANDOM%50))
+gap=3D$((RANDOM%5))
+if [ $gap -gt 0 ]; then
+	gap=3D"gap $gap"
+else
+	gap=3D""
+fi
+
+if [ $reorder1 -gt 0 ] && [ $reorder2 -gt 0 ]; then
+  tc -net ns3 qdisc add dev ns3eth4 root netem delay ${delay}ms reorder ${=
reorder1}% ${reorder2}% $gap
+fi
+echo "INFO: Using loss of $loss, delay $delay ms, reorder: $reorder1, $reo=
rder2 $gap on ns3eth4"
 =

 for sender in 1 2 3 4;do
 	run_tests ns1 ns$sender 10.0.1.1
-- =

2.21.0

--===============8017252899326797274==--
