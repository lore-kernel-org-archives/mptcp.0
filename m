Content-Type: multipart/mixed; boundary="===============4636807053440653081=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/3] mptcp: use sk_page_frag() in sendmsg
Date: Mon, 15 Apr 2019 17:30:47 +0200
Message-ID: <f85f47442234764ac8c12139f228d2d452c2a59c.1555342070.git.pabeni@redhat.com>
In-Reply-To: cover.1555342070.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1068

--===============4636807053440653081==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This clean-up a bit the send path, and allows better performances.

RFC -> v1:
 - use sk's page_frag
 - fix error handling on memory pressure

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1e73e307a6d2..1b843c5e2dbc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -52,10 +52,11 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	int mss_now, size_goal, poffset, ret;
 	struct mptcp_ext *mpext =3D NULL;
-	struct page *page =3D NULL;
+	struct page_frag *pfrag;
 	struct sk_buff *skb;
 	struct sock *ssk;
 	size_t psize;
+	long timeo;
 =

 	pr_debug("msk=3D%p", msk);
 	if (msk->subflow) {
@@ -80,33 +81,33 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 		goto put_out;
 	}
 =

-	/* Initial experiment: new page per send.  Real code will
-	 * maintain list of active pages and DSS mappings, append to the
-	 * end and honor zerocopy
+	lock_sock(sk);
+	lock_sock(ssk);
+	timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
+
+	/* use the mptcp page cache so that we can easily move the data
+	 * from one substream to another, but do per subflow memory accounting
 	 */
-	page =3D alloc_page(GFP_KERNEL);
-	if (!page) {
-		ret =3D -ENOMEM;
-		goto put_out;
+	pfrag =3D sk_page_frag(sk);
+	while (!sk_page_frag_refill(ssk, pfrag)) {
+		ret =3D sk_stream_wait_memory(ssk, &timeo);
+		if (ret)
+			goto release_out;
 	}
 =

 	/* Copy to page */
-	poffset =3D 0;
+	poffset =3D pfrag->offset;
 	pr_debug("left=3D%zu", msg_data_left(msg));
-	psize =3D copy_page_from_iter(page, poffset,
+	psize =3D copy_page_from_iter(pfrag->page, poffset,
 				    min_t(size_t, msg_data_left(msg),
-					  PAGE_SIZE),
+					  pfrag->size - poffset),
 				    &msg->msg_iter);
 	pr_debug("left=3D%zu", msg_data_left(msg));
-
 	if (!psize) {
 		ret =3D -EINVAL;
-		goto put_out;
+		goto release_out;
 	}
 =

-	lock_sock(sk);
-	lock_sock(ssk);
-
 	/* Mark the end of the previous write so the beginning of the
 	 * next write (with its own mptcp skb extension data) is not
 	 * collapsed.
@@ -116,8 +117,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 		TCP_SKB_CB(skb)->eor =3D 1;
 =

 	mss_now =3D tcp_send_mss(ssk, &size_goal, msg->msg_flags);
-
-	ret =3D do_tcp_sendpages(ssk, page, poffset, min_t(int, size_goal, psize),
+	psize =3D min_t(int, size_goal, psize);
+	ret =3D do_tcp_sendpages(ssk, pfrag->page, poffset, psize,
 			       msg->msg_flags | MSG_SENDPAGE_NOTLAST);
 	if (ret <=3D 0)
 		goto release_out;
@@ -143,6 +144,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 			 mpext->checksum, mpext->dsn64);
 	} /* TODO: else fallback */
 =

+	pfrag->offset +=3D ret;
 	msk->write_seq +=3D ret;
 	subflow_ctx(ssk)->rel_write_seq +=3D ret;
 =

@@ -153,9 +155,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 	release_sock(sk);
 =

 put_out:
-	if (page)
-		put_page(page);
-
 	sock_put(ssk);
 	return ret;
 }
-- =

2.20.1


--===============4636807053440653081==--
