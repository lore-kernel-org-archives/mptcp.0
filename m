Content-Type: multipart/mixed; boundary="===============8498899137776921699=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 2/2] selftests: mptcp: add
 IPv4-mapped IPv6 testcases
Date: Wed, 16 Dec 2020 15:14:25 +0800
Message-ID: <d98efb18c7d118ec33b255aebdb57147878e2277.1608102361.git.geliangtang@gmail.com>
In-Reply-To: 5df4ef900cea6618e5df0756474ecd5bbae3c9f8.1608102360.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7183

--===============8498899137776921699==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the IPv4-mapped IPv6 testcases, and the IPv4 convert to
IPv4-mapped IPv6 testcases.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index a5956d272d6e..333f917a7f98 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -876,6 +876,40 @@ chk_join_nr "remove subflow and signal IPv6" 2 2 2
 chk_add_nr 1 1
 chk_rm_nr 1 1
 =

+# signal subflow IPv4-mapped
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl add "::ffff:10.0.3.2" flags subflow
+run_tests $ns1 $ns2 "::ffff:10.0.1.1" 0 0 0 slow
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
+# signal subflow convert IPv4-mapped
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+run_tests $ns1 $ns2 "::ffff:10.0.1.1" 0 0 0 slow
+chk_join_nr "single subflow convert IPv4-mapped" 1 1 1
+
+# signal address convert IPv4-mapped
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+run_tests $ns1 $ns2 "::ffff:10.0.1.1"
+chk_join_nr "signal address convert IPv4-mapped" 1 1 1
+chk_add_nr 1 1
+
 # single subflow, backup
 reset
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-- =

2.29.2

--===============8498899137776921699==--
