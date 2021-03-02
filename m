Content-Type: multipart/mixed; boundary="===============4584888474123093738=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 3/3] DO-NOT-MERGE: mptcp: remove
 id 0 test
Date: Tue, 02 Mar 2021 16:12:49 +0800
Message-ID: <1bc758f4e1e632789db28e688de2e07af82fb26c.1614672171.git.geliangtang@gmail.com>
In-Reply-To: e496b266e0b5c7e559cced0802c7112583e53b29.1614672171.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7978

--===============4584888474123093738==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Just for test.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c                          |  4 ++--
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 439c9ee57566..bc0ccc325f4b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1100,7 +1100,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_so=
ck *msk,
 	struct mptcp_rm_list list =3D { .nr =3D 0 };
 	bool ret;
 =

-	list.ids[list.nr++] =3D addr->id;
+	list.ids[list.nr++] =3D 0;
 =

 	ret =3D remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
@@ -1120,7 +1120,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(st=
ruct net *net,
 =

 	pr_debug("remove_id=3D%d", addr->id);
 =

-	list.ids[list.nr++] =3D addr->id;
+	list.ids[list.nr++] =3D 0;
 =

 	while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=3D NULL) {
 		struct sock *sk =3D (struct sock *)msk;
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 96379ede5925..38603236dfa3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -911,7 +911,7 @@ remove_tests()
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -2 slow
 	chk_join_nr "remove multiple subflows" 2 2 2
-	chk_rm_nr 2 2
+	chk_rm_nr 1 1
 =

 	# single address, remove
 	reset
@@ -932,7 +932,7 @@ remove_tests()
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
 	chk_join_nr "remove subflow and signal" 2 2 2
 	chk_add_nr 1 1
-	chk_rm_nr 1 1
+	chk_rm_nr 0 0
 =

 	# subflows and signal, remove
 	reset
@@ -944,7 +944,7 @@ remove_tests()
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 slow
 	chk_join_nr "remove subflows and signal" 3 3 3
 	chk_add_nr 1 1
-	chk_rm_nr 2 2
+	chk_rm_nr 0 0
 =

 	# addresses remove
 	reset
@@ -956,7 +956,7 @@ remove_tests()
 	run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
 	chk_join_nr "remove addresses" 3 3 3
 	chk_add_nr 3 3
-	chk_rm_nr 3 3 invert
+	chk_rm_nr 1 1 invert
 =

 	# invalid addresses remove
 	reset
@@ -968,7 +968,7 @@ remove_tests()
 	run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
 	chk_join_nr "remove invalid addresses" 1 1 1
 	chk_add_nr 3 3
-	chk_rm_nr 3 1 invert
+	chk_rm_nr 1 0 invert
 =

 	# subflows and signal, flush
 	reset
-- =

2.29.2

--===============4584888474123093738==--
