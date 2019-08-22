Content-Type: multipart/mixed; boundary="===============0896516647344206489=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v2 2/8] mptcp: update per subflow unacked sequence
 on pkt reception
Date: Thu, 22 Aug 2019 15:47:39 +0200
Message-ID: <c0f17ae559af2f38f61401479e5f6715fd96a279.1566481012.git.pabeni@redhat.com>
In-Reply-To: cover.1566481012.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1668

--===============0896516647344206489==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

So that we keep per subflow unacked sequence number consistent;
since we update only per socket data, no additional locking is
required.

Subflow and msk unacked seq are updated at different stages
to keep the locking schema simple.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
rfc v1 -> rfc v2:
 - initialize subflow snd_una on subflow connect()/accept()
---
 net/mptcp/options.c  | 31 +++++++++++++++++++++++++------
 net/mptcp/protocol.c |  2 ++
 net/mptcp/protocol.h |  1 +
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0e7abcea5bae..e0895834ff82 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -524,6 +524,21 @@ bool mptcp_synack_options(const struct request_sock *r=
eq, unsigned int *size,
 	return false;
 }
 =

+static u64 expand_ack(u64 old_ack, u64 cur_ack, bool use_64bit)
+{
+	u32 old_ack32, cur_ack32;
+
+	if (use_64bit)
+		return cur_ack;
+
+	old_ack32 =3D (u32)old_ack;
+	cur_ack32 =3D (u32)cur_ack;
+	cur_ack =3D (old_ack & GENMASK_ULL(63, 32)) + cur_ack32;
+	if (unlikely(before(cur_ack32, old_ack32)))
+		return cur_ack + (1LL<<32);
+	return cur_ack;
+}
+
 void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb,
 			    struct tcp_options_received *opt_rx)
 {
@@ -537,6 +552,16 @@ void mptcp_incoming_options(struct sock *sk, struct sk=
_buff *skb,
 	if (!mp_opt->dss)
 		return;
 =

+	/* we can't wait for recvmsg() to update the ack_seq, otherwise
+	 * monodirectional flows will stuck
+	 */
+	if (mp_opt->use_ack) {
+		struct subflow_context *subflow =3D subflow_ctx(sk);
+
+		subflow->snd_una =3D expand_ack(subflow->snd_una,
+					      mp_opt->data_ack, mp_opt->ack64);
+	}
+
 	mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
 	if (!mpext)
 		return;
@@ -553,12 +578,6 @@ void mptcp_incoming_options(struct sock *sk, struct sk=
_buff *skb,
 		mpext->use_checksum =3D mp_opt->use_checksum;
 	}
 =

-	if (mp_opt->use_ack) {
-		mpext->data_ack =3D mp_opt->data_ack;
-		mpext->use_ack =3D 1;
-		mpext->ack64 =3D mp_opt->ack64;
-	}
-
 	mpext->data_fin =3D mp_opt->data_fin;
 =

 	if (msk)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5b7ddbe64e4b..65f7cc4712ef 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -674,6 +674,7 @@ static struct sock *mptcp_accept(struct sock *sk, int f=
lags, int *err,
 		subflow->map_subflow_seq =3D 1;
 		subflow->rel_write_seq =3D 1;
 		subflow->tcp_sock =3D new_sock;
+		subflow->snd_una =3D msk->write_seq;
 		newsk =3D new_mptcp_sock;
 		subflow->conn =3D new_mptcp_sock;
 		list_add(&subflow->node, &msk->conn_list);
@@ -809,6 +810,7 @@ void mptcp_finish_connect(struct sock *sk, int mp_capab=
le)
 		subflow->map_seq =3D ack_seq;
 		subflow->map_subflow_seq =3D 1;
 		subflow->rel_write_seq =3D 1;
+		subflow->snd_una =3D msk->write_seq;
 =

 		list_add(&subflow->node, &msk->conn_list);
 		msk->subflow =3D NULL;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9f261ee31917..e37fd4bcd904 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -165,6 +165,7 @@ struct subflow_context {
 	u32	token;
 	u32     rel_write_seq;
 	u64     idsn;
+	u64	snd_una;
 	u64	map_seq;
 	u32	map_subflow_seq;
 	u32	ssn_offset;
-- =

2.21.0


--===============0896516647344206489==--
