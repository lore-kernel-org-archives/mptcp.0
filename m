Content-Type: multipart/mixed; boundary="===============6677221634489567891=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 2/2] selftests: mptcp: add
 IPv4-mapped IPv6 testcases
Date: Fri, 18 Dec 2020 19:17:35 +0800
Message-ID: <909b2965d0411b28e52cce29a227854016a4db17.1608289899.git.geliangtang@gmail.com>
In-Reply-To: 37a81f89faa38ee33531bc7b795e4fc19377fd85.1608289899.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7215

--===============6677221634489567891==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the IPv4-mapped IPv6 testcases, and the IPv4 address
converting with the IPv4-mapped IPv6 address testcases.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index f74cd993b168..a9baed7ce837 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -790,6 +790,57 @@ chk_join_nr "remove subflow and signal IPv6" 2 2 2
 chk_add_nr 1 1
 chk_rm_nr 1 1
 =

+# signal subflow IPv4-mapped
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl add "::ffff:10.0.3.2" flags subflow
+run_tests $ns1 $ns2 "::ffff:10.0.1.1"
+chk_join_nr "single subflow IPv4-mapped" 1 1 1
+
+# signal address IPv4-mapped
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+ip netns exec $ns1 ./pm_nl_ctl add "::ffff:10.0.2.1" flags signal
+run_tests $ns1 $ns2 "::ffff:10.0.1.1"
+chk_join_nr "signal address IPv4-mapped" 1 1 1
+chk_add_nr 1 1
+
+# signal subflow v4-map-v6
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+run_tests $ns1 $ns2 "::ffff:10.0.1.1"
+chk_join_nr "single subflow v4-map-v6" 1 1 1
+
+# signal address v4-map-v6
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+run_tests $ns1 $ns2 "::ffff:10.0.1.1"
+chk_join_nr "signal address v4-map-v6" 1 1 1
+chk_add_nr 1 1
+
+# signal subflow v6-map-v4
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl add "::ffff:10.0.3.2" flags subflow
+run_tests $ns1 $ns2 10.0.1.1
+chk_join_nr "single subflow v6-map-v4" 1 1 1
+
+# signal address v6-map-v4
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+ip netns exec $ns1 ./pm_nl_ctl add "::ffff:10.0.2.1" flags signal
+run_tests $ns1 $ns2 10.0.1.1
+chk_join_nr "signal address v6-map-v4" 1 1 1
+chk_add_nr 1 1
+
 # single subflow, backup
 reset
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-- =

2.29.2

--===============6677221634489567891==--
