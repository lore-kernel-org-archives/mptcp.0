Content-Type: multipart/mixed; boundary="===============3466383981056299440=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 7/7] selftests: mptcp: add
 testcases for removing addrs
Date: Mon, 01 Feb 2021 15:11:16 +0800
Message-ID: <03a2f3b1945cc6b82fbd1ec0c51e0ba417f4447f.1612163150.git.geliangtang@gmail.com>
In-Reply-To: e65be2869397014423e51884e0ebd4cc96f9f9af.1612163150.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7550

--===============3466383981056299440==
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
index 964db9ed544f..45e1aff7a31c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -869,6 +869,29 @@ remove_tests()
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

--===============3466383981056299440==--
