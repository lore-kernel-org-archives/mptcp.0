Content-Type: multipart/mixed; boundary="===============6481196078058764884=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 1/4] mptcp: use sk_page_frag() in sendmsg
Date: Fri, 05 Apr 2019 16:46:36 +0200
Message-ID: <7ff75507326445d4d6cf1648e6c71d26868e6ffd.1554473233.git.pabeni@redhat.com>
In-Reply-To: cover.1554473233.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1046

--===============6481196078058764884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This clean-up a bit the send path, and allows better performances.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
iv1 -> iv2
 - ret !=3D 0 -> !ret
 - goto put_out -> goto release_out; - when we error out under lock
---
 net/mptcp/protocol.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1e73e307a6d2..7fe8dff9f5f2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -52,7 +52,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *=
msg, size_t len)
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	int mss_now, size_goal, poffset, ret;
 	struct mptcp_ext *mpext =3D NULL;
-	struct page *page =3D NULL;
+	struct page_frag *pfrag;
 	struct sk_buff *skb;
 	struct sock *ssk;
 	size_t psize;
@@ -80,33 +80,32 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 		goto put_out;
 	}
 =

-	/* Initial experiment: new page per send.  Real code will
-	 * maintain list of active pages and DSS mappings, append to the
-	 * end and honor zerocopy
-	 */
-	page =3D alloc_page(GFP_KERNEL);
-	if (!page) {
-		ret =3D -ENOMEM;
-		goto put_out;
+	lock_sock(sk);
+	lock_sock(ssk);
+
+	/* use the subflow page cache so that memory accounting is coherent */
+	pfrag =3D sk_page_frag(ssk);
+	if (!sk_page_frag_refill(ssk, pfrag)) {
+		long timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
+
+		ret =3D sk_stream_wait_memory(sk, &timeo);
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
@@ -116,8 +115,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
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
@@ -143,6 +142,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 			 mpext->checksum, mpext->dsn64);
 	} /* TODO: else fallback */
 =

+	pfrag->offset +=3D ret;
 	msk->write_seq +=3D ret;
 	subflow_ctx(ssk)->rel_write_seq +=3D ret;
 =

@@ -153,9 +153,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
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


--===============6481196078058764884==--
