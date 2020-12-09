Content-Type: multipart/mixed; boundary="===============5876711019744178375=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 11/11] mptcp: use the variable sk instead of
 open-coding
Date: Wed, 09 Dec 2020 15:51:28 -0800
Message-ID: <20201209235128.175473-12-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20201209235128.175473-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7117

--===============5876711019744178375==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

Since the local variable sk has been defined, use it instead of
open-coding.

Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/pm_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 46da9f8c9cba..5151cfcd6962 100644
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
@@ -399,7 +399,7 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock *m=
sk)
 	local.family =3D remote.family;
 =

 	spin_unlock_bh(&msk->pm.lock);
-	__mptcp_subflow_connect((struct sock *)msk, &local, &remote);
+	__mptcp_subflow_connect(sk, &local, &remote);
 	spin_lock_bh(&msk->pm.lock);
 =

 	mptcp_pm_announce_addr(msk, &remote, true, use_port);
-- =

2.29.2

--===============5876711019744178375==--
