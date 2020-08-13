Content-Type: multipart/mixed; boundary="===============4656550490945972342=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v7 mptcp-next 4/5] selftests: mptcp: add remove
 addr and subflow test case
Date: Thu, 13 Aug 2020 18:37:18 +0800
Message-ID: <6bf665265430e4705acaea06b9cb3c961dd9e43d.1597314634.git.geliangtang@gmail.com>
In-Reply-To: cover.1597314634.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5548

--===============4656550490945972342==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new argument in do_transfer, a callback function. We
passed do_remove_addr to do_transfer to remove the addr and subflow in
the transfer process.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index f39c1129ce5f..3c26f98f3cac 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -164,6 +164,11 @@ do_transfer()
 	ip netns exec ${connector_ns} ./mptcp_connect -j -t $timeout -p $port -s =
${cl_proto} $connect_addr < "$cin" > "$cout" &
 	cpid=3D$!
 =

+	# call a function if it has been passed as a parameter
+	if [ $# -eq 6 ]; then
+		($6)
+	fi
+
 	wait $cpid
 	retc=3D$?
 	wait $spid
@@ -363,6 +368,30 @@ ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subf=
low
 run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "multiple subflows and signal" 3 3 3
 =

+# remove subflow and signal
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 2 2
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags subflow
+ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags signal
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+
+do_remove_addr()
+{
+	sleep 1
+	ip netns exec $ns1 ./pm_nl_ctl del 1
+	ip netns exec $ns2 ./pm_nl_ctl del 1
+
+	sleep 1
+	ip netns exec $ns1 ./pm_nl_ctl del 2
+	ip netns exec $ns2 ./pm_nl_ctl del 2
+
+	sleep 2
+}
+do_transfer $ns1 $ns2 MPTCP MPTCP 10.0.1.1 do_remove_addr
+chk_join_nr "remove subflow and signal" 2 2 1
+
 # single subflow, syncookies
 reset_with_cookies
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-- =

2.17.1

--===============4656550490945972342==--
