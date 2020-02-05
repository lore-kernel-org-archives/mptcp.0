Content-Type: multipart/mixed; boundary="===============8173928114892799271=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 2/3] mptcp: Use per-subflow storage for DATA_FIN
 sequence number
Date: Tue, 04 Feb 2020 18:06:47 -0800
Message-ID: <20200205020648.72997-3-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200205020648.72997-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3589

--===============8173928114892799271==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of reading the MPTCP-level sequence number when sending DATA_FIN,
store the data in the subflow so it can be safely accessed when the
subflow TCP headers are written to the packet without the MPTCP-level
lock held. This also allows the MPTCP-level socket to close individual
subflows without closing the MPTCP connection.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/options.c  |  5 ++---
 net/mptcp/protocol.c | 20 +++++++++++++++++---
 net/mptcp/protocol.h |  2 ++
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 97d2328fbb52..476959dc6253 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -411,7 +411,7 @@ static void mptcp_write_data_fin(struct mptcp_subflow_c=
ontext *subflow,
 		 */
 		ext->use_map =3D 1;
 		ext->dsn64 =3D 1;
-		ext->data_seq =3D mptcp_sk(subflow->conn)->write_seq;
+		ext->data_seq =3D subflow->data_fin_tx_seq;
 		ext->subflow_seq =3D 0;
 		ext->data_len =3D 1;
 	} else {
@@ -453,8 +453,7 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 		if (mpext)
 			opts->ext_copy =3D *mpext;
 =

-		if (skb && tcp_fin &&
-		    subflow->conn->sk_state !=3D TCP_ESTABLISHED)
+		if (skb && tcp_fin && subflow->data_fin_tx_enable)
 			mptcp_write_data_fin(subflow, &opts->ext_copy);
 		ret =3D true;
 	}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e856bde01ebf..c6b5c82aee97 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1086,7 +1086,8 @@ static void mptcp_cancel_work(struct sock *sk)
 		sock_put(sk);
 }
 =

-static void mptcp_subflow_shutdown(struct sock *ssk, int how)
+static void mptcp_subflow_shutdown(struct sock *ssk, int how,
+				   bool data_fin_tx_enable, u64 data_fin_tx_seq)
 {
 	lock_sock(ssk);
 =

@@ -1099,6 +1100,14 @@ static void mptcp_subflow_shutdown(struct sock *ssk,=
 int how)
 		tcp_disconnect(ssk, O_NONBLOCK);
 		break;
 	default:
+		if (data_fin_tx_enable) {
+			struct mptcp_subflow_context *subflow;
+
+			subflow =3D mptcp_subflow_ctx(ssk);
+			subflow->data_fin_tx_seq =3D data_fin_tx_seq;
+			subflow->data_fin_tx_enable =3D 1;
+		}
+
 		ssk->sk_shutdown |=3D how;
 		tcp_shutdown(ssk, how);
 		break;
@@ -1115,6 +1124,7 @@ static void __mptcp_close(struct sock *sk, long timeo=
ut)
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	LIST_HEAD(conn_list);
+	u64 data_fin_tx_seq;
 =

 	mptcp_token_destroy(msk->token);
 	inet_sk_state_store(sk, TCP_CLOSE);
@@ -1125,11 +1135,15 @@ static void __mptcp_close(struct sock *sk, long tim=
eout)
 =

 	__mptcp_clear_xmit(sk);
 =

+	data_fin_tx_seq =3D msk->write_seq;
+
 	release_sock(sk);
 =

 	list_for_each_entry_safe(subflow, tmp, &conn_list, node) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 =

+		subflow->data_fin_tx_seq =3D data_fin_tx_seq;
+		subflow->data_fin_tx_enable =3D 1;
 		__mptcp_close_ssk(sk, ssk, subflow, timeout);
 	}
 =

@@ -1211,7 +1225,7 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
 			*err =3D -ENOBUFS;
 			local_bh_enable();
 			release_sock(sk);
-			mptcp_subflow_shutdown(newsk, SHUT_RDWR + 1);
+			mptcp_subflow_shutdown(newsk, SHUT_RDWR + 1, 0, 0);
 			tcp_close(newsk, 0);
 			return NULL;
 		}
@@ -1730,7 +1744,7 @@ static int mptcp_shutdown(struct socket *sock, int ho=
w)
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
 =

-		mptcp_subflow_shutdown(tcp_sk, how);
+		mptcp_subflow_shutdown(tcp_sk, how, 1, msk->write_seq);
 	}
 =

 out_unlock:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3fbb33deb764..94fb8f586a95 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -228,9 +228,11 @@ struct mptcp_subflow_context {
 		backup : 1,
 		data_avail : 1,
 		rx_eof : 1,
+		data_fin_tx_enable : 1,
 		can_ack : 1;	    /* only after processing the remote a key */
 	u32	remote_nonce;
 	u64	thmac;
+	u64	data_fin_tx_seq;
 	u32	local_nonce;
 	u32	remote_token;
 	u8	hmac[MPTCPOPT_HMAC_LEN];
-- =

2.25.0

--===============8173928114892799271==--
