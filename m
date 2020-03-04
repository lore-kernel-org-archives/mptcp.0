Content-Type: multipart/mixed; boundary="===============2704872870188260674=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1 9/0009] Squash-to: "subflow: place further subflows
 on new 'join_list'"
Date: Wed, 04 Mar 2020 16:02:08 +0100
Message-ID: <69586a14bcb482fca957f4be899e0d5412c31258.1583334096.git.pabeni@redhat.com>
In-Reply-To: cover.1583334095.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3858

--===============2704872870188260674==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

do not insert the new subflow on join list, if we are going to drop it

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2db55fb1be6b..b3eb886b9488 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1519,6 +1519,7 @@ bool mptcp_finish_join(struct sock *sk)
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
 	struct sock *parent =3D (void *)msk;
 	struct socket *parent_sock;
+	bool ret;
 =

 	pr_debug("msk=3D%p, subflow=3D%p", msk, subflow);
 =

@@ -1530,12 +1531,15 @@ bool mptcp_finish_join(struct sock *sk)
 	if (parent_sock && !sk->sk_socket) {
 		mptcp_sock_graft(sk, parent_sock);
 =

-		/* active connections are already on conn_list */
-		spin_lock_bh(&msk->join_list_lock);
-		if (!WARN_ON_ONCE(!list_empty(&subflow->node)))
-			list_add_tail(&subflow->node, &msk->join_list);
-		spin_unlock_bh(&msk->join_list_lock);
-		return mptcp_pm_allow_new_subflow(msk);
+		ret =3D mptcp_pm_allow_new_subflow(msk);
+		if (ret) {
+			/* active connections are already on conn_list */
+			spin_lock_bh(&msk->join_list_lock);
+			if (!WARN_ON_ONCE(!list_empty(&subflow->node)))
+				list_add_tail(&subflow->node, &msk->join_list);
+			spin_unlock_bh(&msk->join_list_lock);
+		}
+		return ret;
 	}
 	return true;
 }
-- =

2.21.1

--===============2704872870188260674==--
