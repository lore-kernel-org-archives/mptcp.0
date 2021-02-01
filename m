Content-Type: multipart/mixed; boundary="===============1197956251527215203=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 06/15] selftests: mptcp: add testcases for
 newly added addresses
Date: Mon, 01 Feb 2021 15:09:11 -0800
Message-ID: <20210201230920.66027-7-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210201230920.66027-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7564

--===============1197956251527215203==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

This patch adds testcases to create subflows or signal addresses for the
newly added IPv4 or IPv6 addresses.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 73 ++++++++++++++++++-
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index e5fb2b01f31c..b5cd2a48831e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -264,7 +264,23 @@ do_transfer()
 	fi
 	cpid=3D$!
 =

-	if [ $addr_nr_ns1 -lt 0 ]; then
+	if [ $addr_nr_ns1 -gt 0 ]; then
+		let add_nr_ns1=3Daddr_nr_ns1
+		counter=3D2
+		sleep 1
+		while [ $add_nr_ns1 -gt 0 ]; do
+			local addr
+			if is_v6 "${connect_addr}"; then
+				addr=3D"dead:beef:$counter::1"
+			else
+				addr=3D"10.0.$counter.1"
+			fi
+			ip netns exec $ns1 ./pm_nl_ctl add $addr flags signal
+			let counter+=3D1
+			let add_nr_ns1-=3D1
+		done
+		sleep 1
+	elif [ $addr_nr_ns1 -lt 0 ]; then
 		let rm_nr_ns1=3D-addr_nr_ns1
 		if [ $rm_nr_ns1 -lt 8 ]; then
 			counter=3D1
@@ -282,7 +298,23 @@ do_transfer()
 		fi
 	fi
 =

-	if [ $addr_nr_ns2 -lt 0 ]; then
+	if [ $addr_nr_ns2 -gt 0 ]; then
+		let add_nr_ns2=3Daddr_nr_ns2
+		counter=3D3
+		sleep 1
+		while [ $add_nr_ns2 -gt 0 ]; do
+			local addr
+			if is_v6 "${connect_addr}"; then
+				addr=3D"dead:beef:$counter::2"
+			else
+				addr=3D"10.0.$counter.2"
+			fi
+			ip netns exec $ns2 ./pm_nl_ctl add $addr flags subflow
+			let counter+=3D1
+			let add_nr_ns2-=3D1
+		done
+		sleep 1
+	elif [ $addr_nr_ns2 -lt 0 ]; then
 		let rm_nr_ns2=3D-addr_nr_ns2
 		if [ $rm_nr_ns2 -lt 8 ]; then
 			counter=3D1
@@ -738,6 +770,43 @@ chk_join_nr "flush subflows and signal" 3 3 3
 chk_add_nr 1 1
 chk_rm_nr 2 2
 =

+# add single subflow
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow
+chk_join_nr "add single subflow" 1 1 1
+
+# add signal address
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
+chk_join_nr "add signal address" 1 1 1
+chk_add_nr 1 1
+
+# add multiple subflows
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+run_tests $ns1 $ns2 10.0.1.1 0 0 2 slow
+chk_join_nr "add multiple subflows" 2 2 2
+
+# add multiple subflows IPv6
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+run_tests $ns1 $ns2 dead:beef:1::1 0 0 2 slow
+chk_join_nr "add multiple subflows IPv6" 2 2 2
+
+# add multiple addresses IPv6
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+run_tests $ns1 $ns2 dead:beef:1::1 0 2 0 slow
+chk_join_nr "add multiple addresses IPv6" 2 2 2
+chk_add_nr 2 2
+
 # subflow IPv6
 reset
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-- =

2.30.0

--===============1197956251527215203==--
