Content-Type: multipart/mixed; boundary="===============6714871411646326289=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 7/7] selftests: mptcp: add the
 net device name testcase
Date: Wed, 17 Mar 2021 15:36:22 +0800
Message-ID: <d6a07d9de1aa43d936db39b31a2d704852432bd7.1615966219.git.geliangtang@gmail.com>
In-Reply-To: a88ce5ec915018139620a53cfbda4693c39ed5ff.1615966219.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8186

--===============6714871411646326289==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new testcase for setting the net device name. In it,
pass the net device name to pm_nl_ctl to set the ifindex field of struct
mptcp_pm_addr_entry.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index abeb24b7f8ec..fd99485cf2a4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -777,6 +777,14 @@ subflows_tests()
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple subflows, limited by server" 2 2 1
+
+	# single subflow, dev
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow dev ns2eth3
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "single subflow, dev" 1 1 1
 }
 =

 signal_address_tests()
-- =

2.30.2

--===============6714871411646326289==--
