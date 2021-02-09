Content-Type: multipart/mixed; boundary="===============2652715984731633861=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 4/4] selftests: mptcp: signal
 addresses testcases
Date: Tue, 09 Feb 2021 22:55:04 +0800
Message-ID: <068d50b8e17fb8d8889be7e7d8a7b7496ec5bac7.1612882099.git.geliangtang@gmail.com>
In-Reply-To: 66417cc815ca140958142581d5b9c3c97b8ab703.1612882099.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7713

--===============2652715984731633861==
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
index 6782a891b3e7..b0af4f8c3b02 100755
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
-- =

2.29.2

--===============2652715984731633861==--
