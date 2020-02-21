Content-Type: multipart/mixed; boundary="===============8079820119920815141=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 6/9] Squash-to: subflow: place further subflows on
 new 'join_list'
Date: Fri, 21 Feb 2020 17:17:27 +0100
Message-ID: <8288dc89a99773f49796a32049337cbdcea34795.1582297150.git.pabeni@redhat.com>
In-Reply-To: cover.1582297149.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3723

--===============8079820119920815141==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mptcp_finish_join() may race with __mptcp_subflow_connect().
If mptcp_finish_join() completes before we reach the
list_add_tail() call in __mptcp_subflow_connect() we get
a data corruption due to double list add.

We need add to join_list only passive sockets, so fix the
above avoiding the add for client socks.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f753cd1884fe..59f76d97237a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1400,16 +1400,14 @@ bool mptcp_finish_join(struct sock *sk)
 		return false;
 =

 	parent_sock =3D READ_ONCE(parent->sk_socket);
-	if (parent_sock) {
-		if (!sk->sk_socket)
-			mptcp_sock_graft(sk, parent_sock);
+	if (parent_sock && !sk->sk_socket) {
+		mptcp_sock_graft(sk, parent_sock);
 =

 		/* active connections are already on conn_list */
-		if (list_empty(&subflow->node)) {
-			spin_lock_bh(&msk->join_list_lock);
+		spin_lock_bh(&msk->join_list_lock);
+		if (!WARN_ON_ONCE(!list_empty(&subflow->node)))
 			list_add_tail(&subflow->node, &msk->join_list);
-			spin_unlock_bh(&msk->join_list_lock);
-		}
+		spin_unlock_bh(&msk->join_list_lock);
 	}
 	return true;
 }
-- =

2.21.1

--===============8079820119920815141==--
