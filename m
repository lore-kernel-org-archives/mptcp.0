Content-Type: multipart/mixed; boundary="===============5513615489461548422=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next v3 06/12] mptcp: Use MPTCP-level flag for
 sending DATA_FIN
Date: Thu, 23 Jul 2020 10:43:10 -0700
Message-ID: <20200723174316.131049-7-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200723174316.131049-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5263

--===============5513615489461548422==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since DATA_FIN information is the same for every subflow, store it only
in the mptcp_sock.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/options.c  | 15 +++++++++------
 net/mptcp/protocol.c | 21 +++++----------------
 net/mptcp/protocol.h |  3 +--
 3 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c1f806f03021..bac38ea12b73 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -451,6 +451,8 @@ static bool mptcp_established_options_mp(struct sock *s=
k, struct sk_buff *skb,
 static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
 				 struct sk_buff *skb, struct mptcp_ext *ext)
 {
+	u64 data_fin_tx_seq =3D READ_ONCE(mptcp_sk(subflow->conn)->write_seq);
+
 	if (!ext->use_map || !skb->len) {
 		/* RFC6824 requires a DSS mapping with specific values
 		 * if DATA_FIN is set but no data payload is mapped
@@ -458,10 +460,10 @@ static void mptcp_write_data_fin(struct mptcp_subflow=
_context *subflow,
 		ext->data_fin =3D 1;
 		ext->use_map =3D 1;
 		ext->dsn64 =3D 1;
-		ext->data_seq =3D subflow->data_fin_tx_seq;
+		ext->data_seq =3D data_fin_tx_seq;
 		ext->subflow_seq =3D 0;
 		ext->data_len =3D 1;
-	} else if (ext->data_seq + ext->data_len =3D=3D subflow->data_fin_tx_seq)=
 {
+	} else if (ext->data_seq + ext->data_len =3D=3D data_fin_tx_seq) {
 		/* If there's an existing DSS mapping and it is the
 		 * final mapping, DATA_FIN consumes 1 additional byte of
 		 * mapping space.
@@ -477,15 +479,17 @@ static bool mptcp_established_options_dss(struct sock=
 *sk, struct sk_buff *skb,
 					  struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
 	unsigned int dss_size =3D 0;
+	u64 snd_data_fin_enable;
 	struct mptcp_ext *mpext;
-	struct mptcp_sock *msk;
 	unsigned int ack_size;
 	bool ret =3D false;
 =

 	mpext =3D skb ? mptcp_get_ext(skb) : NULL;
+	snd_data_fin_enable =3D READ_ONCE(msk->snd_data_fin_enable);
 =

-	if (!skb || (mpext && mpext->use_map) || subflow->data_fin_tx_enable) {
+	if (!skb || (mpext && mpext->use_map) || snd_data_fin_enable) {
 		unsigned int map_size;
 =

 		map_size =3D TCPOLEN_MPTCP_DSS_BASE + TCPOLEN_MPTCP_DSS_MAP64;
@@ -495,7 +499,7 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 		if (mpext)
 			opts->ext_copy =3D *mpext;
 =

-		if (skb && subflow->data_fin_tx_enable)
+		if (skb && snd_data_fin_enable)
 			mptcp_write_data_fin(subflow, skb, &opts->ext_copy);
 		ret =3D true;
 	}
@@ -504,7 +508,6 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 	 * if the first subflow may have the already the remote key handy
 	 */
 	opts->ext_copy.use_ack =3D 0;
-	msk =3D mptcp_sk(subflow->conn);
 	if (!READ_ONCE(msk->can_ack)) {
 		*size =3D ALIGN(dss_size, 4);
 		return ret;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 16ed4355fc89..a5f5c8a7f765 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1480,8 +1480,7 @@ static void mptcp_cancel_work(struct sock *sk)
 		sock_put(sk);
 }
 =

-static void mptcp_subflow_shutdown(struct sock *ssk, int how,
-				   bool data_fin_tx_enable, u64 data_fin_tx_seq)
+static void mptcp_subflow_shutdown(struct sock *ssk, int how)
 {
 	lock_sock(ssk);
 =

@@ -1494,14 +1493,6 @@ static void mptcp_subflow_shutdown(struct sock *ssk,=
 int how,
 		tcp_disconnect(ssk, O_NONBLOCK);
 		break;
 	default:
-		if (data_fin_tx_enable) {
-			struct mptcp_subflow_context *subflow;
-
-			subflow =3D mptcp_subflow_ctx(ssk);
-			subflow->data_fin_tx_seq =3D data_fin_tx_seq;
-			subflow->data_fin_tx_enable =3D 1;
-		}
-
 		ssk->sk_shutdown |=3D how;
 		tcp_shutdown(ssk, how);
 		break;
@@ -1542,7 +1533,6 @@ static void mptcp_close(struct sock *sk, long timeout)
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	LIST_HEAD(conn_list);
-	u64 data_fin_tx_seq;
 =

 	lock_sock(sk);
 =

@@ -1556,7 +1546,7 @@ static void mptcp_close(struct sock *sk, long timeout)
 	spin_unlock_bh(&msk->join_list_lock);
 	list_splice_init(&msk->conn_list, &conn_list);
 =

-	data_fin_tx_seq =3D msk->write_seq;
+	msk->snd_data_fin_enable =3D 1;
 =

 	__mptcp_clear_xmit(sk);
 =

@@ -1564,9 +1554,6 @@ static void mptcp_close(struct sock *sk, long timeout)
 =

 	list_for_each_entry_safe(subflow, tmp, &conn_list, node) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
-
-		subflow->data_fin_tx_seq =3D data_fin_tx_seq;
-		subflow->data_fin_tx_enable =3D 1;
 		__mptcp_close_ssk(sk, ssk, subflow, timeout);
 	}
 =

@@ -2264,10 +2251,12 @@ static int mptcp_shutdown(struct socket *sock, int =
how)
 	}
 =

 	__mptcp_flush_join_list(msk);
+	msk->snd_data_fin_enable =3D 1;
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
 =

-		mptcp_subflow_shutdown(tcp_sk, how, 1, msk->write_seq);
+		mptcp_subflow_shutdown(tcp_sk, how);
 	}
 =

 	/* Wake up anyone sleeping in poll. */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2cbcbfc79871..beb34b8a5363 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -201,6 +201,7 @@ struct mptcp_sock {
 	bool		can_ack;
 	bool		fully_established;
 	bool		rcv_data_fin;
+	bool		snd_data_fin_enable;
 	spinlock_t	join_list_lock;
 	struct work_struct work;
 	struct list_head conn_list;
@@ -293,10 +294,8 @@ struct mptcp_subflow_context {
 		backup : 1,
 		data_avail : 1,
 		rx_eof : 1,
-		data_fin_tx_enable : 1,
 		use_64bit_ack : 1, /* Set when we received a 64-bit DSN */
 		can_ack : 1;	    /* only after processing the remote a key */
-	u64	data_fin_tx_seq;
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
-- =

2.27.0

--===============5513615489461548422==--
