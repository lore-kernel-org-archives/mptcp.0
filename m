Content-Type: multipart/mixed; boundary="===============5115951939748260056=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH net-next] mptcp: use the variable sk instead of
 open-coding
Date: Mon, 23 Nov 2020 11:37:15 +0800
Message-ID: <324b7fd5919dc934355ce13da4c71dc26e0aba8a.1606102511.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6891

--===============5115951939748260056==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since the local variable sk has been defined, use it instead of
open-coding.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 03f2c28f11f5..69c66e252588 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -313,7 +313,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(stru=
ct mptcp_sock *msk)
 	struct mptcp_pm_addr_entry *local;
 	struct pm_nl_pernet *pernet;
 =

-	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
+	pernet =3D net_generic(sock_net(sk), pm_nl_pernet_id);
 =

 	pr_debug("local %d:%d signal %d:%d subflows %d:%d\n",
 		 msk->pm.local_addr_used, msk->pm.local_addr_max,
@@ -396,7 +396,7 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock *m=
sk)
 	local.family =3D remote.family;
 =

 	spin_unlock_bh(&msk->pm.lock);
-	__mptcp_subflow_connect((struct sock *)msk, &local, &remote);
+	__mptcp_subflow_connect(sk, &local, &remote);
 	spin_lock_bh(&msk->pm.lock);
 =

 	mptcp_pm_announce_addr(msk, &remote, true);
-- =

2.26.2

--===============5115951939748260056==--
