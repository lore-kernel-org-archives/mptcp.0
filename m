Content-Type: multipart/mixed; boundary="===============2048640404676600510=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 13/13] mptcp: cache subflow write status in subflow ctx
Date: Wed, 05 Aug 2020 19:57:12 +0200
Message-ID: <23661a66410908b4720f6fd8980f8eeaa56212c9.1596649926.git.pabeni@redhat.com>
In-Reply-To: cover.1596649926.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5491

--===============2048640404676600510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

we currently call sk_stream_memory_free() on subflows
without helding the socket lock, and I obseve several
races.

Caching the status in a ctx-level variable allow
placing the proper barriers (_ONCE) and races are gone

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
this should likely be squashed in an earlier commit
---
 net/mptcp/protocol.c | 13 +++++++++----
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  |  7 ++++++-
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 932e54d6fc90..870a5fee3858 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -770,7 +770,7 @@ static bool mptcp_is_writeable(struct mptcp_sock *msk)
 		return false;
 =

 	mptcp_for_each_subflow(msk, subflow) {
-		if (sk_stream_memory_free(mptcp_subflow_tcp_sock(subflow)))
+		if (READ_ONCE(subflow->writable))
 			return true;
 	}
 	return false;
@@ -1099,7 +1099,7 @@ static struct sock *mptcp_subflow_get_send(struct mpt=
cp_sock *msk,
 		if (next_backup || next_ssk)
 			continue;
 =

-		free =3D sk_stream_memory_free(ssk);
+		free =3D READ_ONCE(subflow->writable);
 		if (!free)
 			continue;
 =

@@ -1114,7 +1114,7 @@ static struct sock *mptcp_subflow_get_send(struct mpt=
cp_sock *msk,
 =

 	if (msk->last_snd) {
 		*sndbuf =3D max(tcp_sk(msk->last_snd)->snd_wnd, *sndbuf);
-		free =3D sk_stream_memory_free(msk->last_snd);
+		free =3D READ_ONCE(mptcp_subflow_ctx(msk->last_snd)->writable);
 	} else {
 		free =3D false;
 	}
@@ -1216,6 +1216,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 	lock_sock(ssk);
 	tx_ok =3D msg_data_left(msg);
 	while (tx_ok) {
+		struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
+
 		ret =3D mptcp_sendmsg_frag(sk, ssk, msg, NULL, &timeo, &mss_now,
 					 &size_goal);
 		if (ret < 0) {
@@ -1233,11 +1235,14 @@ static int mptcp_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
 		msk->snd_burst -=3D ret;
 		copied +=3D ret;
 =

+		if (!sk_stream_memory_free(ssk))
+			WRITE_ONCE(subflow->writable, false);
+
 		tx_ok =3D msg_data_left(msg);
 		if (!tx_ok)
 			break;
 =

-		if (!sk_stream_memory_free(ssk) ||
+		if (!subflow->writable ||
 		    !mptcp_page_frag_refill(ssk, pfrag) ||
 		    !mptcp_ext_cache_refill(msk)) {
 			tcp_push(ssk, msg->msg_flags, mss_now,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 493bd2c13bc6..1d766cba97db 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -308,6 +308,7 @@ struct mptcp_subflow_context {
 		use_64bit_ack : 1, /* Set when we received a 64-bit DSN */
 		can_ack : 1;	    /* only after processing the remote a key */
 	enum mptcp_data_avail data_avail;
+	bool	writable;
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 587e3b653930..95eae8b63d69 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -984,7 +984,11 @@ static void subflow_write_space(struct sock *sk)
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct sock *parent =3D subflow->conn;
 =

-	if (sk_stream_memory_free(sk) && sk_stream_is_writeable(parent)) {
+	if (!sk_stream_memory_free(sk))
+		return;
+
+	WRITE_ONCE(subflow->writable, true);
+	if (sk_stream_is_writeable(parent)) {
 		set_bit(MPTCP_SEND_SPACE, &mptcp_sk(parent)->flags);
 		smp_mb__after_atomic();
 		/* set SEND_SPACE before sk_stream_write_space clears NOSPACE */
@@ -1178,6 +1182,7 @@ static struct mptcp_subflow_context *subflow_create_c=
tx(struct sock *sk,
 =

 	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
 	INIT_LIST_HEAD(&ctx->node);
+	WRITE_ONCE(ctx->writable, true);
 =

 	pr_debug("subflow=3D%p", ctx);
 =

-- =

2.26.2

--===============2048640404676600510==--
