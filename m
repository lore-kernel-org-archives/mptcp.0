Content-Type: multipart/mixed; boundary="===============5356661318473176192=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 9/9] selftests: mptcp: add
 testcases for removing addrs
Date: Fri, 05 Feb 2021 22:24:33 +0800
Message-ID: <6d48a2fc27de54fd374a9928b640a64c8e377d5c.1612534634.git.geliangtang@gmail.com>
In-Reply-To: c18136a41258e36ac96e66d7946f38535a427c94.1612534634.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7646

--===============5356661318473176192==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the testcases for removing a list of addresses. Used
the netlink to flush the addresses in the testcases.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 9f693a643313..05f26662e872 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -915,6 +915,29 @@ remove_tests()
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
+	chk_rm_nr 0 0
 }
 =

 add_tests()
-- =

2.29.2

--===============5356661318473176192==--
