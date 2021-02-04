Content-Type: multipart/mixed; boundary="===============7121029645322878705=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 2/2] selftests: mptcp: signal
 addresses testcases
Date: Thu, 04 Feb 2021 17:04:57 +0800
Message-ID: <4f8408f0823719ac0f075ee50c8aec4422c5708b.1612429260.git.geliangtang@gmail.com>
In-Reply-To: 3ab97f4eff5d8c642c1883f8280a7f336ba6170e.1612429260.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7620

--===============7121029645322878705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added testcases for signalling multi valid and invalid addresses
for both signal_address_tests and remove_tests.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 964db9ed544f..9f693a643313 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -767,6 +767,28 @@ signal_address_tests()
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple subflows and signal" 3 3 3
 	chk_add_nr 1 1
+
+	# signal addresses
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "signal addresses" 3 3 3
+	chk_add_nr 3 3
+
+	# signal invalid addresses
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.13.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "signal invalid addresses" 0 0 0
+	chk_add_nr 3 3
 }
 =

 link_failure_tests()
@@ -858,6 +880,30 @@ remove_tests()
 	chk_add_nr 1 1
 	chk_rm_nr 2 2
 =

+	# addresses remove
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal id 250
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
+	chk_join_nr "remove addresses" 3 3 3
+	chk_add_nr 3 3
+	chk_rm_nr 0 0
+
+	# invalid addresses remove
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.13.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
+	chk_join_nr "remove invalid addresses" 0 0 0
+	chk_add_nr 3 3
+	chk_rm_nr 0 0
+
 	# subflows and signal, flush
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
-- =

2.29.2

--===============7121029645322878705==--
