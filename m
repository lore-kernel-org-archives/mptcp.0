Content-Type: multipart/mixed; boundary="===============2685057340516958085=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 3/9] selftests: mptcp: add the flush addrs
 testcase
Date: Thu, 10 Dec 2020 14:25:00 -0800
Message-ID: <20201210222506.222251-4-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20201210222506.222251-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7130

--===============2685057340516958085==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

This patch added the flush addrs testcase. In do_transfer, if the number
of removing addresses is less than 8, use the del addr command to remove
the addresses one by one. If the number is more than 8, use the flush addrs
command to remove the addresses.

Acked-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 50 +++++++++++++------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 0eae628d1ffd..9aa9624cff97 100755
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
@@ -663,6 +673,18 @@ chk_join_nr "remove subflows and signal" 3 3 3
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

2.29.2

--===============2685057340516958085==--
