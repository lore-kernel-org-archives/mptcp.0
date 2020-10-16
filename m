Content-Type: multipart/mixed; boundary="===============6043521326492483298=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 1/2] tcp: factor out tcp_build_frag()
Date: Fri, 16 Oct 2020 12:51:07 +0200
Message-ID: <4076957880b05a4e476467b126f46a21812913df.1602840570.git.pabeni@redhat.com>
In-Reply-To: cover.1602840570.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6329

--===============6043521326492483298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Will be needed by the next patch, as MPTCP needs to handle
directly the error/memory-allocation-needed path.

No functional changes intended.

Additionally let MPTCP code access the tcp_remove_empty_skb()
helper.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 include/net/tcp.h |   3 ++
 net/ipv4/tcp.c    | 119 ++++++++++++++++++++++++++--------------------
 2 files changed, 70 insertions(+), 52 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index d4ef5bf94168..e41569e55d97 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -322,6 +322,7 @@ void tcp_shutdown(struct sock *sk, int how);
 int tcp_v4_early_demux(struct sk_buff *skb);
 int tcp_v4_rcv(struct sk_buff *skb);
 =

+void tcp_remove_empty_skb(struct sock *sk, struct sk_buff *skb);
 int tcp_v4_tw_remember_stamp(struct inet_timewait_sock *tw);
 int tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
 int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size);
@@ -329,6 +330,8 @@ int tcp_sendpage(struct sock *sk, struct page *page, in=
t offset, size_t size,
 		 int flags);
 int tcp_sendpage_locked(struct sock *sk, struct page *page, int offset,
 			size_t size, int flags);
+struct sk_buff *tcp_build_frag(struct sock *sk, int size_goal, int flags,
+			       struct page *page, int offset, size_t *size);
 ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
 		 size_t size, int flags);
 int tcp_send_mss(struct sock *sk, int *size_goal, int flags);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index bae4284bf542..259dca2bd3dd 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -952,7 +952,7 @@ int tcp_send_mss(struct sock *sk, int *size_goal, int f=
lags)
  * importantly be able to generate EPOLLOUT for Edge Trigger epoll()
  * users.
  */
-static void tcp_remove_empty_skb(struct sock *sk, struct sk_buff *skb)
+void tcp_remove_empty_skb(struct sock *sk, struct sk_buff *skb)
 {
 	if (skb && !skb->len) {
 		tcp_unlink_write_queue(skb, sk);
@@ -962,6 +962,68 @@ static void tcp_remove_empty_skb(struct sock *sk, stru=
ct sk_buff *skb)
 	}
 }
 =

+struct sk_buff *tcp_build_frag(struct sock *sk, int size_goal, int flags,
+			       struct page *page, int offset, size_t *size)
+{
+	struct sk_buff *skb =3D tcp_write_queue_tail(sk);
+	struct tcp_sock *tp =3D tcp_sk(sk);
+	bool can_coalesce;
+	int copy, i;
+
+	if (!skb || (copy =3D size_goal - skb->len) <=3D 0 ||
+	    !tcp_skb_can_collapse_to(skb)) {
+new_segment:
+		if (!sk_stream_memory_free(sk))
+			return NULL;
+
+		skb =3D sk_stream_alloc_skb(sk, 0, sk->sk_allocation,
+				tcp_rtx_and_write_queues_empty(sk));
+		if (!skb)
+			return NULL;
+
+#ifdef CONFIG_TLS_DEVICE
+		skb->decrypted =3D !!(flags & MSG_SENDPAGE_DECRYPTED);
+#endif
+		skb_entail(sk, skb);
+		copy =3D size_goal;
+	}
+
+	if (copy > *size)
+		copy =3D *size;
+
+	i =3D skb_shinfo(skb)->nr_frags;
+	can_coalesce =3D skb_can_coalesce(skb, i, page, offset);
+	if (!can_coalesce && i >=3D sysctl_max_skb_frags) {
+		tcp_mark_push(tp, skb);
+		goto new_segment;
+	}
+	if (!sk_wmem_schedule(sk, copy))
+		return NULL;
+
+	if (can_coalesce) {
+		skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], copy);
+	} else {
+		get_page(page);
+		skb_fill_page_desc(skb, i, page, offset, copy);
+	}
+
+	if (!(flags & MSG_NO_SHARED_FRAGS))
+		skb_shinfo(skb)->tx_flags |=3D SKBTX_SHARED_FRAG;
+
+	skb->len +=3D copy;
+	skb->data_len +=3D copy;
+	skb->truesize +=3D copy;
+	sk_wmem_queued_add(sk, copy);
+	sk_mem_charge(sk, copy);
+	skb->ip_summed =3D CHECKSUM_PARTIAL;
+	WRITE_ONCE(tp->write_seq, tp->write_seq + copy);
+	TCP_SKB_CB(skb)->end_seq +=3D copy;
+	tcp_skb_pcount_set(skb, 0);
+
+	*size =3D copy;
+	return skb;
+}
+
 ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
 			 size_t size, int flags)
 {
@@ -997,60 +1059,13 @@ ssize_t do_tcp_sendpages(struct sock *sk, struct pag=
e *page, int offset,
 		goto out_err;
 =

 	while (size > 0) {
-		struct sk_buff *skb =3D tcp_write_queue_tail(sk);
-		int copy, i;
-		bool can_coalesce;
-
-		if (!skb || (copy =3D size_goal - skb->len) <=3D 0 ||
-		    !tcp_skb_can_collapse_to(skb)) {
-new_segment:
-			if (!sk_stream_memory_free(sk))
-				goto wait_for_space;
-
-			skb =3D sk_stream_alloc_skb(sk, 0, sk->sk_allocation,
-					tcp_rtx_and_write_queues_empty(sk));
-			if (!skb)
-				goto wait_for_space;
-
-#ifdef CONFIG_TLS_DEVICE
-			skb->decrypted =3D !!(flags & MSG_SENDPAGE_DECRYPTED);
-#endif
-			skb_entail(sk, skb);
-			copy =3D size_goal;
-		}
+		struct sk_buff *skb;
+		size_t copy =3D size;
 =

-		if (copy > size)
-			copy =3D size;
-
-		i =3D skb_shinfo(skb)->nr_frags;
-		can_coalesce =3D skb_can_coalesce(skb, i, page, offset);
-		if (!can_coalesce && i >=3D sysctl_max_skb_frags) {
-			tcp_mark_push(tp, skb);
-			goto new_segment;
-		}
-		if (!sk_wmem_schedule(sk, copy))
+		skb =3D tcp_build_frag(sk, size_goal, flags, page, offset, &copy);
+		if (!skb)
 			goto wait_for_space;
 =

-		if (can_coalesce) {
-			skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], copy);
-		} else {
-			get_page(page);
-			skb_fill_page_desc(skb, i, page, offset, copy);
-		}
-
-		if (!(flags & MSG_NO_SHARED_FRAGS))
-			skb_shinfo(skb)->tx_flags |=3D SKBTX_SHARED_FRAG;
-
-		skb->len +=3D copy;
-		skb->data_len +=3D copy;
-		skb->truesize +=3D copy;
-		sk_wmem_queued_add(sk, copy);
-		sk_mem_charge(sk, copy);
-		skb->ip_summed =3D CHECKSUM_PARTIAL;
-		WRITE_ONCE(tp->write_seq, tp->write_seq + copy);
-		TCP_SKB_CB(skb)->end_seq +=3D copy;
-		tcp_skb_pcount_set(skb, 0);
-
 		if (!copied)
 			TCP_SKB_CB(skb)->tcp_flags &=3D ~TCPHDR_PSH;
 =

-- =

2.26.2

--===============6043521326492483298==--
