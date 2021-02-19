Content-Type: multipart/mixed; boundary="===============2220936135674276922=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v5 mptcp-next 3/3] selftests: mptcp: signal
 addresses testcases
Date: Fri, 19 Feb 2021 11:09:37 +0800
Message-ID: <8f37ff2be5a944d101ae48ab713c1464f5b6c08b.1613703548.git.geliangtang@gmail.com>
In-Reply-To: 726b3e1fa90f601526b51d0ec90d69d080c49d12.1613703548.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7859

--===============2220936135674276922==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added testcases for signalling multi valid and invalid addresses
for both signal_address_tests and remove_tests.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 191303b652a6..5d7f940bceac 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -788,6 +788,28 @@ signal_address_tests()
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
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "signal invalid addresses" 1 1 1
+	chk_add_nr 3 3
 }
 =

 link_failure_tests()
@@ -879,6 +901,30 @@ remove_tests()
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
+	chk_rm_nr 3 3 invert
+
+	# invalid addresses remove
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
+	chk_join_nr "remove invalid addresses" 1 1 1
+	chk_add_nr 3 3
+	chk_rm_nr 3 1 invert
+
 	# subflows and signal, flush
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
@@ -913,6 +959,18 @@ remove_tests()
 	chk_join_nr "flush addresses" 3 3 3
 	chk_add_nr 3 3
 	chk_rm_nr 3 3 invert
+
+	# invalid addresses flush
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	run_tests $ns1 $ns2 10.0.1.1 0 -8 0 slow
+	chk_join_nr "flush invalid addresses" 1 1 1
+	chk_add_nr 3 3
+	chk_rm_nr 3 1 invert
 }
 =

 add_tests()
-- =

2.29.2

--===============2220936135674276922==--
