Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795422002;
	b=5Po9JCSYbN1RjWLXLvfgPhcHvlxAoUuOQy5EwxNevyOSdCCdASr45Nkzi6Iu1I/OEI9M
	 dqmhpHTEpZq1MhYcrkmhnSF1dWNOC25XzfGOmKa1KzUkWUkCRXZPwzZZvQv8sjF+wEIgD
	 Wnbrm7FMGw8ALcRCfD2xN8Zd79DOgArExoua2XQixy18xuJAO8hrGWpPCzZ5M6kjmvPAp
	 MYzABKG5d2Wa90gUCplVxe4KEOSjPYgCwSWXkncQPDyEqGdif/JSmXlpyXI3aPBY33xS2
	 yckEwxPhu7/o+qDcTGofGPx9ypG2bfype0eZEVC3erh1E5zXSzANev7xNDVC3ZVcXHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795422002;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AJOC8HDpDQ3zmv9Gg7uAADTnxQj7lJqhc3/GGe+/wsk=;
	b=oXIrIzuVffQWxwot1fDkNKhbEcUnHXIu0LUSz9+6fm39PK4SqeUgPSkP9iNesR4jsopK
	 feOewTy4iV9O5hq0eQp/JXq3MYm3YTfbZCU4tMZBvrNTlpq++3D7lOvxwa1AnrA7vUANi
	 R7HW3DvQvsFOcjGQtVKtyhVqllmh9rcXbLBY1tJXfRKyGFZG1ko3ryWP30fMLhWH0xKCY
	 RWrJJVu4aJ7M09bEFQTnZaTxvXEx4i1onIShwkDX4GYyu+dZkimizctOqnRtW0XmfYDF5
	 pkavzLZvDIUG4XsJYKsc+sYB0g5sx3tWLkslYOwsEbnrwYqhoIsXz/7EGeGe/Zy+ekg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AOfOWmBe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A900E606A32A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 08:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AOfOWmBe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8101F000CF
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 08:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795422002;
	bh=AJOC8HDpDQ3zmv9Gg7uAADTnxQj7lJqhc3/GGe+/wsk=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=AOfOWmBezl4qMW81NHGYAVikEHNFH0HEFM9qmNIh6kpTg9fsynolhl2oRcXpcedcd
	 0DmkTm2THFdNpKX2RjcJI7dGoqDxfCKbh+DM52I1/k+hvqm7zm4QpUZf0lc7DQ5RZQ
	 k3b8qdapzpHmvOcyeS+QdP2szmTt+raDAR5j9FjAcvRpwc5zcUqRBuqRTG0iRlw3G7
	 2w+uwawLq70lrtKWjQ2fB8JFv1iZvKp07nYawibtz4pfS4KoncM7ez6wUh33V2ByEJ
	 9wjn5oAQt7JCO0seSP79BDWAz12/BcILx+owzGWI93/kvHAyHJQZgpIWsaUpyFm9Vq
	 MelQg11SdMC/w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v8 4/7] mptcp: add MSG_ZEROCOPY support
Date: Mon, 23 Nov 2026 16:19:47 +0800
Message-ID: <3f30ee2209176e73f716ad379bb6385145b05fa8.1795421388.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795421388.git.tanggeliang@kylinos.cn>
References: <cover.1795421388.git.tanggeliang@kylinos.cn>
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
in a newly allocated mptcp_data_frag. The dfrag takes one reference
on the ubuf_info and one on the page. Subflow skbs take additional
page references via get_page() and are marked with skb_zcopy_set()
and SKBFL_PURE_ZEROCOPY, mirroring TCP's behavior and bypassing
kernel memory accounting for those pages.

The feature is silently downgraded to regular copy when MSG_FASTOPEN
is set or the application has not opted in via setsockopt(SO_ZEROCOPY).
If msg_zerocopy_realloc() fails (e.g. RLIMIT_MEMLOCK pressure),
sendmsg(2) aborts with -ENOBUFS.

The implementation prevents coalescing of dfrags with different ubuf
instances into the same subflow skb to avoid premature completion
notifications: a coalescing break is taken when the skb's pure-zerocopy
state differs from the incoming dfrag, and another when both dfrags
have ubuf instances but they differ. The new mptcp_sendmsg_zerocopy_iter()
helper caps pg_len to U16_MAX (reverting the excess from the iov_iter
when iov_iter_get_pages2() returns more than that) and returns -EFAULT
when pg_off exceeds U16_MAX (which can happen on 256KB-page kernels like
PowerPC and Hexagon), so the u16 dfrag->data_len and dfrag->offset fields
cannot wrap. The caller accumulates the per-iteration byte count via
the ssize_t return value. The non-zerocopy path is left untouched.

When iov_iter_get_pages2() returns 0, the function returns -EFAULT
to properly signal iterator exhaustion.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 152 +++++++++++++++++++++++++++++++++++++++++--
 net/mptcp/protocol.h |   1 +
 2 files changed, 146 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 84848cb0a5e9..9cd3e12d5546 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1186,9 +1186,11 @@ static bool mptcp_frag_can_collapse_to(const struct mptcp_sock *msk,
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
 
@@ -1197,7 +1199,13 @@ static void dfrag_clear(struct sock *sk, struct mptcp_data_frag *dfrag)
 	int len = dfrag->data_len + dfrag->overhead;
 
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
 
@@ -1242,7 +1250,7 @@ static void __mptcp_clean_una(struct sock *sk)
 		dfrag->data_len -= delta;
 		dfrag->already_sent -= delta;
 
-		dfrag_uncharge(sk, delta);
+		dfrag_uncharge(sk, delta, dfrag);
 	}
 
 	/* all retransmitted data acked, recovery completed */
@@ -1316,6 +1324,7 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag)
 	dfrag->already_sent = 0;
 	dfrag->page = pfrag->page;
 	dfrag->eor = 0;
+	dfrag->ubuf = NULL;
 
 	return dfrag;
 }
@@ -1483,6 +1492,16 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
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
@@ -1523,7 +1542,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	}
 
 	copy = min_t(size_t, copy, info->limit - info->sent);
-	if (!sk_wmem_schedule(ssk, copy)) {
+	if (!dfrag->ubuf && !sk_wmem_schedule(ssk, copy)) {
 		tcp_remove_empty_skb(ssk);
 		return -ENOMEM;
 	}
@@ -1533,13 +1552,19 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
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
@@ -2040,22 +2065,110 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
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
+	/* pg_len == 0 means the iterator is exhausted */
+	if (pg_len == 0)
+		return -EFAULT;
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
+	if (pg_off + pg_len > U16_MAX) {
+		size_t len = U16_MAX - pg_off;
+
+		iov_iter_revert(&msg->msg_iter, pg_len - len);
+		pg_len = len;
+		if (WARN_ON_ONCE(!pg_len)) {
+			put_page(pages[0]);
+			return -EFAULT;
+		}
+	}
+
+	dfrag = kzalloc_obj(*dfrag, GFP_KERNEL_ACCOUNT);
+	if (!dfrag) {
+		iov_iter_revert(&msg->msg_iter, pg_len);
+		put_page(pages[0]);
+		return -ENOMEM;
+	}
+
+	if (!sk_wmem_schedule(sk, pg_len + sizeof(*dfrag))) {
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
+	sk_wmem_queued_add(sk, pg_len + dfrag->overhead);
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
 
+	if (msg->msg_flags & MSG_FASTOPEN || !sock_flag(sk, SOCK_ZEROCOPY))
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
@@ -2094,6 +2207,25 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
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
+				net_zcopy_put_abort(ubuf, true);
+				zc = false;
+				ubuf = NULL;
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
@@ -2169,6 +2301,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 out:
+	if (zc)
+		net_zcopy_put(ubuf);
 	release_sock(sk);
 	return copied;
 
@@ -2179,6 +2313,10 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 	copied = sk_stream_error(sk, msg->msg_flags, ret);
+	if (zc) {
+		net_zcopy_put_abort(ubuf, true);
+		zc = false;
+	}
 	goto out;
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9febcaf84762..ed99c19ecaaf 100644
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

