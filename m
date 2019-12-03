Content-Type: multipart/mixed; boundary="===============1374250089892456302=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 2/3] mptcp: avoid data stream corruption on
 allocation failure.
Date: Tue, 03 Dec 2019 13:35:29 +0100
Message-ID: <86739a0eaa1063a30d25eb7744daeb86db4a78e1.1575376296.git.pabeni@redhat.com>
In-Reply-To: 72975862a8d9c77313a512a29a91e62165e0c984.1575281341.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2769

--===============1374250089892456302==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently, when if mpext allocation fails, the data stream
is corrupted, as we can add the required DSS nor roll-back
the TCP status.

Allocate a skb_ext before the actually skb_buff creation/TCP
status update: in case of memory allocation failure we can
bail early, avoiding the above condition.

Additionally, if the ext is unused to to skb collapsing,
cache the ext in the msk for the next send.

Squash-to: "mptcp: Write MPTCP DSS headers to outgoing data packets"
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
v1 -> v2:
 - properly convert to bool mptcp_ext_cache_refill() return value

Note: a rebased tree including DATA_FIN, v1 and this patches is
avaliable here:

https://github.com/pabeni/mptcp/tree/mptcp_net-next_FIN_v1_recvmsg
---
 net/mptcp/protocol.c | 39 +++++++++++++++++++++++++--------------
 net/mptcp/protocol.h |  1 +
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3180202e56b4..baa5f84c7278 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -55,6 +55,14 @@ static struct sock *mptcp_subflow_get(const struct mptcp=
_sock *msk)
 	return NULL;
 }
 =

+static bool mptcp_ext_cache_refill(struct mptcp_sock *msk)
+{
+	if (!msk->cached_ext)
+		msk->cached_ext =3D skb_ext_alloc();
+
+	return !!msk->cached_ext;
+}
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct msghdr *msg, long *timeo)
 {
@@ -69,7 +77,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct soc=
k *ssk,
 	 * from one substream to another, but do per subflow memory accounting
 	 */
 	pfrag =3D sk_page_frag(sk);
-	while (!sk_page_frag_refill(ssk, pfrag)) {
+	while (!sk_page_frag_refill(ssk, pfrag) ||
+	       !mptcp_ext_cache_refill(msk)) {
 		ret =3D sk_stream_wait_memory(ssk, timeo);
 		if (ret)
 			return ret;
@@ -103,19 +112,19 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 		iov_iter_revert(&msg->msg_iter, psize - ret);
 =

 	skb =3D tcp_write_queue_tail(ssk);
-	mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
-	if (mpext) {
-		memset(mpext, 0, sizeof(*mpext));
-		mpext->data_seq =3D msk->write_seq;
-		mpext->subflow_seq =3D mptcp_subflow_ctx(ssk)->rel_write_seq;
-		mpext->data_len =3D ret;
-		mpext->use_map =3D 1;
-		mpext->dsn64 =3D 1;
-
-		pr_debug("data_seq=3D%llu subflow_seq=3D%u data_len=3D%u dsn64=3D%d",
-			 mpext->data_seq, mpext->subflow_seq, mpext->data_len,
-			 mpext->dsn64);
-	} /* TODO: else fallback */
+	mpext =3D __skb_ext_add(skb, SKB_EXT_MPTCP, msk->cached_ext);
+	msk->cached_ext =3D NULL;
+
+	memset(mpext, 0, sizeof(*mpext));
+	mpext->data_seq =3D msk->write_seq;
+	mpext->subflow_seq =3D mptcp_subflow_ctx(ssk)->rel_write_seq;
+	mpext->data_len =3D ret;
+	mpext->use_map =3D 1;
+	mpext->dsn64 =3D 1;
+
+	pr_debug("data_seq=3D%llu subflow_seq=3D%u data_len=3D%u dsn64=3D%d",
+		 mpext->data_seq, mpext->subflow_seq, mpext->data_len,
+		 mpext->dsn64);
 =

 	pfrag->offset +=3D ret;
 	msk->write_seq +=3D ret;
@@ -242,6 +251,8 @@ static void mptcp_close(struct sock *sk, long timeout)
 		sock_release(mptcp_subflow_tcp_socket(subflow));
 	}
 =

+	if (msk->cached_ext)
+		__skb_ext_put(msk->cached_ext);
 	release_sock(sk);
 	sk_common_release(sk);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 412718c1ae5c..3b8d1548dda1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -58,6 +58,7 @@ struct mptcp_sock {
 	u64		write_seq;
 	u64		ack_seq;
 	u32		token;
+	struct	skb_ext *cached_ext;	/* for the next sendmsg */
 	struct list_head conn_list;
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
 };
-- =

2.21.0

--===============1374250089892456302==--
