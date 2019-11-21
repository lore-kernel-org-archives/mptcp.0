Content-Type: multipart/mixed; boundary="===============5909759627212401540=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 2/3] mptcp: avoid data stream corruption on
 allocation failure.
Date: Thu, 21 Nov 2019 11:31:33 +0100
Message-ID: <379cb7e6d48b763a8d09b57dc0d42a94599bf085.1574331014.git.pabeni@redhat.com>
In-Reply-To: cover.1574331014.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2638

--===============5909759627212401540==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently, when if mpext allocation fails, the data stream
is corrupted, as we can add the required DSS nor roll-back
the TCP status.

Allocate a skb_ext before the actuall skb_buff creation/TCP
status update: in case of memory allocation failure we can
bail early, avoiding the above condition.

Additionally, if the ext is unused to to skb collapsing,
cache the ext in the msk for the next send.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 64 +++++++++++++++++++++++++-------------------
 net/mptcp/protocol.h |  1 +
 2 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1a432abfb176..38259a8a5df3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -190,6 +190,14 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, st=
ruct page_frag *pfrag,
 	return dfrag;
 }
 =

+static bool mptcp_ext_cache_refill(struct mptcp_sock *msk)
+{
+	if (!msk->cached_ext)
+		msk->cached_ext =3D skb_ext_alloc();
+
+	return msk->cached_ext;
+}
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct msghdr *msg, struct mptcp_data_frag *dfrag,
 			      long *timeo, int *pmss_now,
@@ -208,21 +216,22 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 =

 	/* use the mptcp page cache so that we can easily move the data
 	 * from one substream to another, but do per subflow memory accounting
-	 * Note: pfrag is used only !retransmission, but the compiler if
+	 * Note: pfrag is used only !retransmission, but the compiler is
 	 * fooled into a warning if we don't init here
 	 */
 	pfrag =3D sk_page_frag(sk);
+	while (!(retransmission || mptcp_page_frag_refill(ssk, pfrag)) ||
+	       !mptcp_ext_cache_refill(msk)) {
+		ret =3D sk_stream_wait_memory(ssk, timeo);
+		if (ret)
+			return ret;
+
+		/* if sk_stream_wait_memory() sleeps snd_una can change
+		 * significantly, refresh the rtx queue
+		 */
+		mptcp_clean_una(sk);
+	}
 	if (!retransmission) {
-		while (!mptcp_page_frag_refill(ssk, pfrag)) {
-			ret =3D sk_stream_wait_memory(ssk, timeo);
-			if (ret)
-				return ret;
-
-			/* id sk_stream_wait_memory() sleeps snd_una can change
-			 * significantly, refresh the rtx queue
-			 */
-			mptcp_clean_una(sk);
-		}
 		write_seq =3D &msk->write_seq;
 		page =3D pfrag->page;
 	} else {
@@ -321,22 +330,19 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
 	}
 =

 	skb =3D tcp_write_queue_tail(ssk);
-	mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
-	if (mpext) {
-		memset(mpext, 0, sizeof(*mpext));
-		mpext->data_seq =3D *write_seq;
-		mpext->subflow_seq =3D mptcp_subflow_ctx(ssk)->rel_write_seq;
-		mpext->data_len =3D ret;
-		mpext->use_map =3D 1;
-		mpext->dsn64 =3D 1;
-
-		pr_debug("data_seq=3D%llu subflow_seq=3D%u data_len=3D%u dsn64=3D%d",
-			 mpext->data_seq, mpext->subflow_seq, mpext->data_len,
-			 mpext->dsn64);
-	}
-	/* TODO: else fallback; allocation can fail, but we can't easily retire
-	 * skbs from the write_queue, as we need to roll-back TCP status
-	 */
+	mpext =3D __skb_ext_add(skb, SKB_EXT_MPTCP, msk->cached_ext);
+	msk->cached_ext =3D NULL;
+
+	memset(mpext, 0, sizeof(*mpext));
+	mpext->data_seq =3D *write_seq;
+	mpext->subflow_seq =3D mptcp_subflow_ctx(ssk)->rel_write_seq;
+	mpext->data_len =3D ret;
+	mpext->use_map =3D 1;
+	mpext->dsn64 =3D 1;
+
+	pr_debug("data_seq=3D%llu subflow_seq=3D%u data_len=3D%u dsn64=3D%d",
+		 mpext->data_seq, mpext->subflow_seq, mpext->data_len,
+		 mpext->dsn64);
 =

 out:
 	if (!retransmission)
@@ -686,6 +692,7 @@ static int __mptcp_init_sock(struct sock *sk)
 =

 	INIT_LIST_HEAD(&msk->conn_list);
 	INIT_LIST_HEAD(&msk->rtx_queue);
+	msk->cached_ext =3D NULL;
 =

 	INIT_WORK(&msk->rtx_work, mptcp_retransmit);
 =

@@ -760,6 +767,9 @@ static void mptcp_close(struct sock *sk, long timeout)
 		sock_release(mptcp_subflow_tcp_socket(subflow));
 	}
 =

+	if (msk->cached_ext)
+		__skb_ext_put(msk->cached_ext);
+
 	__mptcp_clear_xmit(sk);
 	release_sock(sk);
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 63ff8bd8a098..b95ea66b2f0e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -133,6 +133,7 @@ struct mptcp_sock {
 	u32		token;
 	unsigned long	flags;
 	u16		dport;
+	struct	skb_ext *cached_ext;	/* for the next sendmsg */
 	struct work_struct rtx_work;
 	struct list_head conn_list;
 	struct list_head rtx_queue;
-- =

2.21.0

--===============5909759627212401540==--
