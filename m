Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591395;
	b=DzpCQwBCP9Dj7xYSXKaPuMpv420UXxAyG6+V42If+ugIdYMVFjbutmwYjggXwfjSm0Nu
	 G35yC8bzyXGhLDE4Qs9odbmQWO25yURFyay64OWKEutSFNRVOYE+xWh+8uIWkiDRfpozq
	 o2pF8+/jBf5NXvpBQVBiYpVY/CO4sN3Sl703bdTvXvO23rAVEqKv9sQBtPaAj14/E/mUV
	 A0u0jgCl6/FaPyKRTwjzAKOo2H26JZLeNSYvxKVCgt+QeD6tSzhidB2uHfNtuWLzyYYYC
	 B6DS5YXRQI91Q1+guD/eU/saEhqowE54Pdv16alYF14ifW+EHPyct18L8HIEXPCfNjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591395;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sFI11hqVuKjTE+ckTYlN+2vCGnRzonXe63us22rTOuk=;
	b=R/qHo/MdR8jkWlgfFbopGO7WNqnb7X5hZBePrA8umbTEIwhKgshIaQn/PLZtdC6LkmB7
	 MeUGxqNPB393FZoyBNFZra5yRWWb0q/7+1P3h0ZY9/RglbhPOrqjt863Ymz0RmoxxNDFi
	 uvubBGna95cAe0vRtA8paXvdpcYSY4fDmwlTtGTcEQkmZRgvQhEOPhA9pCx1Tj3MLZq0M
	 +qzb7MaOr2+i9Xrm+FnZZMo0JLsMCGlWHe6xNItVlgufRs15h136TVVh54dRlz/gXiFcS
	 SUbNgEa0vIxC7UB0XJvlO/+wgjiGK/3GhHYBq2px/CP9Pth8b14SV/9UCroIQj9DLwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="N18/atdq";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A89B606A31E
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N18/atdq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44EC1F000D3
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 07:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795591394;
	bh=sFI11hqVuKjTE+ckTYlN+2vCGnRzonXe63us22rTOuk=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=N18/atdqp0ZTPzmFLwlqkeeeow1+BmlreQjOMb80+1aUXu49k4BQCQrgslW/N8ocb
	 iYryEpg0TtSdGnGCSthFDnY4mUXtv7aNHceo4P40hzJgAQZW2d9rnykMgCoPUB2dHz
	 c9FhslqCzCdKma5IUU0uqUyBR+sKv400G0512uTbc1FwNNrjXAaDmoU8Eux9sGQZan
	 Ig0XMtmrOSx2cRQbKz6PhS4yjDdemq0+JzHxRjhrsiJqmT968UlXpmXKDHYjGGGl7h
	 ueTxE6K+i39pgWACw+ikK3SVSlj52s6uPGkoRrXQ152hcUn/Huo4Jyyb8pqOWecw4e
	 IMipGH/07E34A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v9 3/7] mptcp: add MSG_ZEROCOPY support
Date: Wed, 25 Nov 2026 15:23:01 +0800
Message-ID: <fef46d879cfe64c34ee1d792a5fd5713981f9ea4.1795591278.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795591278.git.tanggeliang@kylinos.cn>
References: <cover.1795591278.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch enables MSG_ZEROCOPY support for MPTCP sockets, allowing
user-space to transmit data without intermediate kernel copies.

The implementation follows the same lifecycle model as TCP:

A single ubuf_info_msgzc is allocated per sendmsg via
msg_zerocopy_realloc(). Its reference count consists of three parts:
one 'caller' reference held until sendmsg returns, one reference per
MPTCP dfrag in the retransmission queue (released when the dfrag is
acked and cleared), and one reference per subflow skb that consumes
dfrag bytes (released by TCP's skb_zcopy_clear() when the skb is
acked). Completion is reported only after all bytes are acknowledged
at both MPTCP and subflow levels.

User pages are pinned via iov_iter_get_pages2() and stored directly
in a newly allocated mptcp_data_frag. Subflow skbs take additional
page references via get_page() and are marked with skb_zcopy_set()
and SKBFL_PURE_ZEROCOPY.

The feature silently downgrades to regular copy when MSG_FASTOPEN is
set or the application has not opted in via setsockopt(SO_ZEROCOPY).

To prevent premature completion notifications, dfrags with different
ubuf instances cannot be coalesced into the same subflow skb. The new
mptcp_sendmsg_zerocopy_iter() helper handles page pinning and ensures
offsets stay within u16 limits.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 160 ++++++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h |   1 +
 2 files changed, 150 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 504d0b196d84..6bd10a4e1e93 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1186,18 +1186,27 @@ static bool mptcp_frag_can_collapse_to(const struct mptcp_sock *msk,
 		df->data_seq + df->data_len == msk->write_seq;
 }
 
-static void dfrag_uncharge(struct sock *sk, int len)
+static void dfrag_uncharge(struct sock *sk, int len,
+			   struct mptcp_data_frag *dfrag)
 {
-	sk_mem_uncharge(sk, len);
+	if (!dfrag->ubuf)
+		sk_mem_uncharge(sk, len);
 	sk_wmem_queued_add(sk, -len);
 }
 
 static void dfrag_clear(struct sock *sk, struct mptcp_data_frag *dfrag)
 {
-	int len = dfrag->data_len + dfrag->overhead;
+	int len = dfrag->ubuf ? PAGE_SIZE + dfrag->overhead :
+				dfrag->data_len + dfrag->overhead;
 
 	list_del(&dfrag->list);
-	dfrag_uncharge(sk, len);
+	dfrag_uncharge(sk, len, dfrag);
+	if (dfrag->ubuf) {
+		net_zcopy_put(dfrag->ubuf);
+		put_page(dfrag->page);
+		kfree(dfrag);
+		return;
+	}
 	put_page(dfrag->page);
 }
 
@@ -1242,7 +1251,8 @@ static void __mptcp_clean_una(struct sock *sk)
 		dfrag->data_len -= delta;
 		dfrag->already_sent -= delta;
 
-		dfrag_uncharge(sk, delta);
+		if (!dfrag->ubuf)
+			dfrag_uncharge(sk, delta, dfrag);
 	}
 
 	/* all retransmitted data acked, recovery completed */
@@ -1316,6 +1326,7 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag)
 	dfrag->already_sent = 0;
 	dfrag->page = pfrag->page;
 	dfrag->eor = 0;
+	dfrag->ubuf = NULL;
 
 	return dfrag;
 }
@@ -1488,6 +1499,16 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			goto alloc_skb;
 		}
 
+		if (skb_zcopy_pure(skb) != !!dfrag->ubuf) {
+			tcp_mark_push(tp, skb);
+			goto alloc_skb;
+		}
+		if (dfrag->ubuf && skb_zcopy(skb) &&
+		    skb_zcopy(skb) != dfrag->ubuf) {
+			tcp_mark_push(tp, skb);
+			goto alloc_skb;
+		}
+
 		i = skb_shinfo(skb)->nr_frags;
 		can_coalesce = skb_can_coalesce(skb, i, dfrag->page, offset);
 		if (!can_coalesce && i >= READ_ONCE(net_hotdata.sysctl_max_skb_frags)) {
@@ -1531,7 +1552,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 
 	/* like TCP, allow some progress up to tcp_wmem[0] */
 	avail = tcp_wmem_schedule(ssk, copy);
-	if (avail <= 0) {
+	if (!dfrag->ubuf && avail <= 0) {
 		tcp_remove_empty_skb(ssk);
 		return -ENOMEM;
 	}
@@ -1542,13 +1563,19 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	} else {
 		get_page(dfrag->page);
 		skb_fill_page_desc(skb, i, dfrag->page, offset, copy);
+
+		if (dfrag->ubuf && !skb_zcopy(skb)) {
+			skb_zcopy_set(skb, dfrag->ubuf, NULL);
+			skb_shinfo(skb)->flags |= SKBFL_PURE_ZEROCOPY;
+		}
 	}
 
 	skb->len += copy;
 	skb->data_len += copy;
 	skb->truesize += copy;
 	sk_wmem_queued_add(ssk, copy);
-	sk_mem_charge(ssk, copy);
+	if (!skb_zcopy_pure(skb))
+		sk_mem_charge(ssk, copy);
 	WRITE_ONCE(tp->write_seq, tp->write_seq + copy);
 	TCP_SKB_CB(skb)->end_seq += copy;
 	tcp_skb_pcount_set(skb, 0);
@@ -1940,7 +1967,8 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 static int mptcp_disconnect(struct sock *sk, int flags);
 
 static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
-				  size_t len, int *copied_syn)
+				  size_t len, int *copied_syn,
+				  struct ubuf_info *ubuf)
 {
 	unsigned int saved_flags = msg->msg_flags;
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -1966,7 +1994,7 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
 	lock_sock(ssk);
 	msg->msg_flags |= MSG_DONTWAIT;
 	msk->fastopening = 1;
-	ret = tcp_sendmsg_fastopen(ssk, msg, copied_syn, len, NULL);
+	ret = tcp_sendmsg_fastopen(ssk, msg, copied_syn, len, ubuf);
 	msk->fastopening = 0;
 	msg->msg_flags = saved_flags;
 	release_sock(ssk);
@@ -2048,27 +2076,113 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
+static ssize_t mptcp_sendmsg_zerocopy_iter(struct sock *sk, struct msghdr *msg,
+					   struct ubuf_info *ubuf,
+					   u32 copy_limit)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_data_frag *dfrag;
+	struct page *pages[1] = {};
+	size_t pg_off = 0;
+	ssize_t pg_len;
+
+	pg_len = iov_iter_get_pages2(&msg->msg_iter, pages,
+				     copy_limit, 1, &pg_off);
+	if (pg_len < 0)
+		return pg_len;
+	if (pg_len == 0) {
+		if (pages[0])
+			put_page(pages[0]);
+		return -EFAULT;
+	}
+
+	if (pg_len > U16_MAX) {
+		iov_iter_revert(&msg->msg_iter, pg_len - U16_MAX);
+		pg_len = U16_MAX;
+	}
+
+	if (pg_off > U16_MAX) {
+		iov_iter_revert(&msg->msg_iter, pg_len);
+		put_page(pages[0]);
+		return -EFAULT;
+	}
+
+	if (pg_off + pg_len > U16_MAX + 1) {
+		size_t len = U16_MAX + 1 - pg_off;
+
+		iov_iter_revert(&msg->msg_iter, pg_len - len);
+		pg_len = len;
+	}
+
+	dfrag = kzalloc_obj(*dfrag, GFP_KERNEL_ACCOUNT);
+	if (!dfrag) {
+		iov_iter_revert(&msg->msg_iter, pg_len);
+		put_page(pages[0]);
+		return -ENOMEM;
+	}
+
+	if (!ubuf && !sk_wmem_schedule(sk, pg_len + sizeof(*dfrag))) {
+		kfree(dfrag);
+		iov_iter_revert(&msg->msg_iter, pg_len);
+		put_page(pages[0]);
+		return -EAGAIN;
+	}
+
+	dfrag->data_len = pg_len;
+	dfrag->data_seq = msk->write_seq;
+	dfrag->offset = pg_off;
+	dfrag->page = pages[0];
+	dfrag->ubuf = ubuf;
+	dfrag->overhead = sizeof(struct mptcp_data_frag);
+
+	/* one ref for the dfrag; released in dfrag_clear */
+	net_zcopy_get(ubuf);
+
+	WRITE_ONCE(msk->write_seq, msk->write_seq + pg_len);
+	sk_wmem_queued_add(sk, PAGE_SIZE + dfrag->overhead);
+
+	list_add_tail(&dfrag->list, &msk->rtx_queue);
+	if (!msk->first_pending)
+		msk->first_pending = dfrag;
+
+	return pg_len;
+}
+
 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct ubuf_info *ubuf = NULL;
 	struct page_frag *pfrag;
 	size_t copied = 0;
+	bool zc = false;
 	int ret = 0;
 	long timeo;
 
 	/* silently ignore everything else */
 	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
-			  MSG_FASTOPEN | MSG_EOR;
+			  MSG_FASTOPEN | MSG_EOR | MSG_ZEROCOPY;
 
 	lock_sock(sk);
 
 	mptcp_rps_record_subflows(msk);
 
+	if (!sock_flag(sk, SOCK_ZEROCOPY))
+		msg->msg_flags &= ~MSG_ZEROCOPY;
+
+	if ((msg->msg_flags & MSG_ZEROCOPY) && len) {
+		ubuf = msg_zerocopy_realloc(sk, len, NULL, false);
+		if (!ubuf) {
+			ret = -ENOBUFS;
+			goto do_error;
+		}
+		zc = true;
+	}
+
 	if (unlikely(inet_test_bit(DEFER_CONNECT, sk) ||
 		     msg->msg_flags & MSG_FASTOPEN)) {
 		int copied_syn = 0;
 
-		ret = mptcp_sendmsg_fastopen(sk, msg, len, &copied_syn);
+		ret = mptcp_sendmsg_fastopen(sk, msg, len, &copied_syn, ubuf);
 		copied += copied_syn;
 		if (ret == -EINPROGRESS && copied_syn > 0)
 			goto out;
@@ -2102,6 +2216,24 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		if (!copy_limit)
 			goto wait_for_memory;
 
+		if (zc) {
+			ret = mptcp_sendmsg_zerocopy_iter(sk, msg, ubuf,
+							  copy_limit);
+			if (ret == -EAGAIN || ret == -ENOMEM)
+				goto wait_for_memory;
+			if (ret == -EFAULT) {
+				if (copied)
+					goto do_error;
+				uarg_to_msgzc(ubuf)->zerocopy = 0;
+				zc = false;
+			} else if (ret < 0) {
+				goto do_error;
+			} else {
+				copied += ret;
+				continue;
+			}
+		}
+
 		/* reuse tail pfrag, if possible, or carve a new one from the
 		 * page allocator
 		 */
@@ -2177,6 +2309,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 out:
+	if (ubuf)
+		net_zcopy_put(ubuf);
 	release_sock(sk);
 	return copied;
 
@@ -2187,6 +2321,10 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 	copied = sk_stream_error(sk, msg->msg_flags, ret);
+	if (ubuf) {
+		net_zcopy_put_abort(ubuf, true);
+		ubuf = NULL;
+	}
 	goto out;
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2c9a442dacd6..5378321ae58a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -285,6 +285,7 @@ struct mptcp_data_frag {
 	u8 eor;			/* currently using 1 bit */
 	u16 already_sent;
 	struct page *page;
+	struct ubuf_info *ubuf;
 };
 
 /* Arbitrary compromise between as low as possible to react timely to subflow
-- 
2.55.0

