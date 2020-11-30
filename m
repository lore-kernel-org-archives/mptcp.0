Content-Type: multipart/mixed; boundary="===============5306672820861594925=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 2/2] selftests: mptcp: add the
 flush addrs testcase
Date: Mon, 30 Nov 2020 15:11:26 +0800
Message-ID: <02739eafbaeb1d87c069cec7db5c7a803e534a49.1606719598.git.geliangtang@gmail.com>
In-Reply-To: a826061f6342d5618337b0bc1914cd5ab967c487.1606719598.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6984

--===============5306672820861594925==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the flush addrs testcase. In do_transfer, if the number
of removing addresses is less than 8, use the del addr command to remove
the addresses one by one. If the number is more than 8, use the flush addrs
command to remove the addresses.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 50 +++++++++++++------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 38d756f5e366..00a3ed10bb85 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -264,27 +264,37 @@ do_transfer()
 	cpid=3D$!
 =

 	if [ $rm_nr_ns1 -gt 0 ]; then
-		counter=3D1
-		sleep 1
+		if [ $rm_nr_ns1 -lt 8 ]; then
+			counter=3D1
+			sleep 1
 =

-		while [ $counter -le $rm_nr_ns1 ]
-		do
-			ip netns exec ${listener_ns} ./pm_nl_ctl del $counter
+			while [ $counter -le $rm_nr_ns1 ]
+			do
+				ip netns exec ${listener_ns} ./pm_nl_ctl del $counter
+				sleep 1
+				let counter+=3D1
+			done
+		else
 			sleep 1
-			let counter+=3D1
-		done
+			ip netns exec ${listener_ns} ./pm_nl_ctl flush
+		fi
 	fi
 =

 	if [ $rm_nr_ns2 -gt 0 ]; then
-		counter=3D1
-		sleep 1
+		if [ $rm_nr_ns2 -lt 8 ]; then
+			counter=3D1
+			sleep 1
 =

-		while [ $counter -le $rm_nr_ns2 ]
-		do
-			ip netns exec ${connector_ns} ./pm_nl_ctl del $counter
+			while [ $counter -le $rm_nr_ns2 ]
+			do
+				ip netns exec ${connector_ns} ./pm_nl_ctl del $counter
+				sleep 1
+				let counter+=3D1
+			done
+		else
 			sleep 1
-			let counter+=3D1
-		done
+			ip netns exec ${connector_ns} ./pm_nl_ctl flush
+		fi
 	fi
 =

 	wait $cpid
@@ -749,6 +759,18 @@ chk_join_nr "remove subflows and signal" 3 3 3
 chk_add_nr 1 1
 chk_rm_nr 2 2
 =

+# subflows and signal, flush
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 3
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+run_tests $ns1 $ns2 10.0.1.1 0 8 8 slow
+chk_join_nr "flush subflows and signal" 3 3 3
+chk_add_nr 1 1
+chk_rm_nr 2 2
+
 # subflow IPv6
 reset
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-- =

2.26.2

--===============5306672820861594925==--
