Content-Type: multipart/mixed; boundary="===============3159002568017688127=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v6 mptcp-next 9/9] selftests: mptcp: add
 testcases for removing addrs
Date: Tue, 09 Feb 2021 23:03:50 +0800
Message-ID: <53c0dd899f2e42a09d9be3ab46758b3824877461.1612882689.git.geliangtang@gmail.com>
In-Reply-To: 2fa4aa29c8c7fa21adcb70da92fb72045752b7ca.1612882689.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7723

--===============3159002568017688127==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the testcases for removing a list of addresses. Used
the netlink to flush the addresses in the testcases.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index b0af4f8c3b02..5d7f940bceac 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -936,6 +936,41 @@ remove_tests()
 	chk_join_nr "flush subflows and signal" 3 3 3
 	chk_add_nr 1 1
 	chk_rm_nr 2 2
+
+	# subflows flush
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
+	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow id 150
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+	chk_join_nr "flush subflows" 3 3 3
+	chk_rm_nr 3 3
+
+	# addresses flush
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 3 3
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal id 250
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+	chk_join_nr "flush addresses" 3 3 3
+	chk_add_nr 3 3
+	chk_rm_nr 3 3 invert
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

--===============3159002568017688127==--
