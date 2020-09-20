Content-Type: multipart/mixed; boundary="===============8519240173681374065=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 1/2] Squash-to: "mptcp: remove addr
 and subflow in PM netlink" Part 3
Date: Sun, 20 Sep 2020 22:12:09 +0800
Message-ID: <9187bb959f009488d716d545361cea6a68dd79d1.1600610895.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5947

--===============8519240173681374065==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Just fix pr_debug logs.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 8780d618a05a..b33aebd85bd5 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -212,7 +212,7 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_addr_entry *entry, *tmp;
 =

-	pr_debug("msk=3D%p\n", msk);
+	pr_debug("msk=3D%p", msk);
 =

 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry_safe(entry, tmp, &msk->pm.anno_list, list) {
@@ -687,7 +687,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(stru=
ct net *net,
 	struct mptcp_sock *msk;
 	long s_slot =3D 0, s_num =3D 0;
 =

-	pr_debug("remove_id=3D%d\n", addr->id);
+	pr_debug("remove_id=3D%d", addr->id);
 =

 	while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=3D NULL) {
 		struct sock *sk =3D (struct sock *)msk;
-- =

2.26.2

--===============8519240173681374065==--
