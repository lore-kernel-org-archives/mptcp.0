Content-Type: multipart/mixed; boundary="===============5465028025044787476=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 3/3] DO-NOT-MERGE: mptcp: remove
 id 0 test
Date: Tue, 23 Feb 2021 16:26:14 +0800
Message-ID: <b44aa27fb1af5f1808d0970cb8d7c21fc67098a8.1614068181.git.geliangtang@gmail.com>
In-Reply-To: 25ac6aa2d37f0a06f0c6df69419bfe707bf90fc5.1614068181.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7918

--===============5465028025044787476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Just for test.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c                          | 2 ++
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b5cee3c66e5c..72c16e807bf6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1228,6 +1228,8 @@ static void mptcp_pm_remove_addrs_and_subflows(struct=
 mptcp_sock *msk,
 		}
 	}
 =

+	alist.ids[alist.nr++] =3D 0;
+
 	if (alist.nr) {
 		spin_lock_bh(&msk->pm.lock);
 		mptcp_pm_remove_addr(msk, alist);
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 62f4fb046645..5f7793b0e252 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -957,7 +957,7 @@ remove_tests()
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush subflows and signal" 3 3 3
 	chk_add_nr 1 1
-	chk_rm_nr 2 2
+	chk_rm_nr 3 2
 =

 	# subflows flush
 	reset
@@ -968,7 +968,7 @@ remove_tests()
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush subflows" 3 3 3
-	chk_rm_nr 3 3
+	chk_rm_nr 4 3
 =

 	# addresses flush
 	reset
@@ -980,7 +980,7 @@ remove_tests()
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush addresses" 3 3 3
 	chk_add_nr 3 3
-	chk_rm_nr 3 3 invert
+	chk_rm_nr 4 3 invert
 =

 	# invalid addresses flush
 	reset
@@ -992,7 +992,7 @@ remove_tests()
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 0 slow
 	chk_join_nr "flush invalid addresses" 1 1 1
 	chk_add_nr 3 3
-	chk_rm_nr 3 1 invert
+	chk_rm_nr 4 1 invert
 }
 =

 add_tests()
-- =

2.29.2

--===============5465028025044787476==--
