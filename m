Content-Type: multipart/mixed; boundary="===============2273640079810079707=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v5 mptcp-next 3/3] selftests: mptcp: add
 ADD_ADDR IPv6 test cases
Date: Wed, 21 Oct 2020 15:19:53 +0800
Message-ID: <6d3c6b9540a5a38e1741a25579ca11a444d2a34f.1603264085.git.geliangtang@gmail.com>
In-Reply-To: 9f53954454bd112cceb589a8e67016bd3c899405.1603264085.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6384

--===============2273640079810079707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added IPv6 support for do_transfer, and the test cases for
ADD_ADDR IPv6.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 70 ++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 8b28c6cc038d..398fe2bd642d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -195,6 +195,12 @@ link_failure()
 	ip -net "$ns" link set "$veth" down
 }
 =

+# $1: IP address
+is_v6()
+{
+	[ -z "${1##*:*}" ]
+}
+
 do_transfer()
 {
 	listener_ns=3D"$1"
@@ -236,7 +242,15 @@ do_transfer()
 		mptcp_connect=3D"./mptcp_connect -r"
 	fi
 =

-	ip netns exec ${listener_ns} $mptcp_connect -t $timeout -l -p $port -s ${=
srv_proto} 0.0.0.0 < "$sin" > "$sout" &
+	local local_addr
+	if is_v6 "${connect_addr}"; then
+		local_addr=3D"::"
+	else
+		local_addr=3D"0.0.0.0"
+	fi
+
+	ip netns exec ${listener_ns} $mptcp_connect -t $timeout -l -p $port \
+		-s ${srv_proto} ${local_addr} < "$sin" > "$sout" &
 	spid=3D$!
 =

 	sleep 1
@@ -649,6 +663,60 @@ chk_join_nr "remove subflows and signal" 3 3 3
 chk_add_nr 1 1
 chk_rm_nr 2 2
 =

+# subflow IPv6
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
+run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+chk_join_nr "single subflow IPv6" 1 1 1
+
+# add_address, unused IPv6
+reset
+ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
+run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+chk_join_nr "unused signal address IPv6" 0 0 0
+chk_add_nr 1 1
+
+# signal address IPv6
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
+ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+chk_join_nr "single address IPv6" 1 1 1
+chk_add_nr 1 1
+
+# add_addr timeout IPv6
+reset_with_add_addr_timeout 6
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
+run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+chk_join_nr "signal address, ADD_ADDR6 timeout" 1 1 1
+chk_add_nr 4 0
+
+# single address IPv6, remove
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
+ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+run_tests $ns1 $ns2 dead:beef:1::1 0 1 0 slow
+chk_join_nr "remove single address IPv6" 1 1 1
+chk_add_nr 1 1
+chk_rm_nr 0 0
+
+# subflow and signal IPv6, remove
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
+ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
+run_tests $ns1 $ns2 dead:beef:1::1 0 1 1 slow
+chk_join_nr "remove subflow and signal IPv6" 2 2 2
+chk_add_nr 1 1
+chk_rm_nr 1 1
+
 # single subflow, syncookies
 reset_with_cookies
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-- =

2.26.2

--===============2273640079810079707==--
