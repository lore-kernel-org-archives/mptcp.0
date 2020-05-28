Content-Type: multipart/mixed; boundary="===============4544580309354158583=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: fix race between MP_JOIN and close
Date: Thu, 28 May 2020 20:15:47 +0200
Message-ID: <5d79dc3444f2ee869849dda8a92ff8e44887739d.1590689729.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4546

--===============4544580309354158583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If a MP_JOIN subflow completes the 3whs while another
CPU is closing the master msk, we can hit the
following race:

CPU1                                    CPU2

close()
 mptcp_close
                                        subflow_syn_recv_sock
                                         mptcp_token_get_sock
                                         mptcp_finish_join
                                          inet_sk_state_load
  mptcp_token_destroy
  inet_sk_state_store(TCP_CLOSE)
  __mptcp_flush_join_list()
                                          mptcp_sock_graft
                                          list_add_tail
  sk_common_release
   sock_orphan()
 <socket free>

The MP_JOIN socket will be leaked. Additionally we can hit
UaF for the msk 'struct socket' referenced via the 'conn'
field.

This change try to address the issue introducing some
synchronization between the MP_JOIN 3whs and mptcp_close
via the join_list spinlock. If we detect the msk is closing
the MP_JOIN socket is closed, too.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0f244c0f422e..0b9368c30311 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1349,8 +1349,12 @@ static void mptcp_close(struct sock *sk, long timeou=
t)
 	mptcp_token_destroy(msk->token);
 	inet_sk_state_store(sk, TCP_CLOSE);
 =

-	__mptcp_flush_join_list(msk);
-
+	/* be sure to always acquire the join list lock, to sync vs
+	 * mptcp_finish_join().
+	 */
+	spin_lock_bh(&msk->join_list_lock);
+	list_splice_tail_init(&msk->join_list, &msk->conn_list);
+	spin_unlock_bh(&msk->join_list_lock);
 	list_splice_init(&msk->conn_list, &conn_list);
 =

 	data_fin_tx_seq =3D msk->write_seq;
@@ -1707,22 +1711,30 @@ bool mptcp_finish_join(struct sock *sk)
 	if (!msk->pm.server_side)
 		return true;
 =

-	/* passive connection, attach to msk socket */
+	if (!mptcp_pm_allow_new_subflow(msk))
+		return false;
+
+	/* active connections are already on conn_list, and we can't acquire
+	 * msk lock here.
+	 * use the join list lock as synchronization point and double-check
+	 * msk status to avoid racing with mptcp_close()
+	 */
+	spin_lock_bh(&msk->join_list_lock);
+	ret =3D inet_sk_state_load(parent) =3D=3D TCP_ESTABLISHED;
+	if (ret && !WARN_ON_ONCE(!list_empty(&subflow->node)))
+		list_add_tail(&subflow->node, &msk->join_list);
+	spin_unlock_bh(&msk->join_list_lock);
+	if (!ret)
+		return false;
+
+	/* attach to msk socket only after we are sure he will deal with us
+	 * at close time
+	 */
 	parent_sock =3D READ_ONCE(parent->sk_socket);
 	if (parent_sock && !sk->sk_socket)
 		mptcp_sock_graft(sk, parent_sock);
-
-	ret =3D mptcp_pm_allow_new_subflow(msk);
-	if (ret) {
-		subflow->map_seq =3D msk->ack_seq;
-
-		/* active connections are already on conn_list */
-		spin_lock_bh(&msk->join_list_lock);
-		if (!WARN_ON_ONCE(!list_empty(&subflow->node)))
-			list_add_tail(&subflow->node, &msk->join_list);
-		spin_unlock_bh(&msk->join_list_lock);
-	}
-	return ret;
+	subflow->map_seq =3D msk->ack_seq;
+	return true;
 }
 =

 static bool mptcp_memory_free(const struct sock *sk, int wake)
-- =

2.21.3

--===============4544580309354158583==--
