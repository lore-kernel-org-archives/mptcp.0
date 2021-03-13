Content-Type: multipart/mixed; boundary="===============7370560124048761220=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 11/11] selftests: mptcp: add testcases for
 removing addrs
Date: Fri, 12 Mar 2021 17:16:21 -0800
Message-ID: <20210313011621.211661-12-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210313011621.211661-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8142

--===============7370560124048761220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

This patch added the testcases for removing a list of addresses. Used
the netlink to flush the addresses in the testcases.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 6782a891b3e7..191303b652a6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -890,6 +890,29 @@ remove_tests()
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
 }
 =

 add_tests()
-- =

2.30.2

--===============7370560124048761220==--
