Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBB7347BD4
	for <mptcp@lists.linux.dev>; Fri, 17 Jul 2026 04:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784263834; cv=none; b=V8icol9ZZSccvvbKTk/F4p6zMYfp/YYHVrTT6CSGSZoiE7nhTKgoKSf3Hsc1euNPM/K5LsG/EzHKjtjWhX21dCD0Y7f+Wvful4FcjCaZZQ4MZovaYWXai0w2e9w+F3VzqJszZKh6VjYNGaMGkCKOk1N6dy8e5Pn7s9dLL+dXBus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784263834; c=relaxed/simple;
	bh=GOmNuNbm9K1iFPshyvOqSGan7qzBqcYux5IAtDKJFBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adn9ADEygz17BQg38NU4zZQj1djQFC03N1gGgBBo2JGjyzsLOHWxtMmJjyR8Mqg0SeTKVRBLotACy2GQaWRgkUtpnh9/A5vGZnHyCPtviZaDFUS/R/+yn8kC0TR+ZFg4dY2PQV49TCCUTuv3pvkqHMpwssjqWIDi4Y6HiL0EtOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDNTG2/G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDNTG2/G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F391F00A3A;
	Fri, 17 Jul 2026 04:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784263832;
	bh=dC4wnq62TLEzYS9XGKlPKRska9aL+BuKGqITsmdoXD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gDNTG2/GQrSsNIAfOZ00NzE1JNGL1d3JUej7NRzNBj8/qvNVcHOO4G0c++7oHkg7V
	 YIGkNVCw606RBIgmVPkar/Q2A1pm8DD8dsXl1oFBcupmHSUIjav1+xb+ta7a2uYiZC
	 N2eOtST+2XGJCSy0lJ1bmJVQpZVInrCKXRi/HHOJ6BzmsM8s9me0Z37e7Me9xk2eMl
	 Ro0ya8wxoul2CGdcl4fR2Wr3R8Mn4a9CgvGvBZYVPXfC2tjF1qFY2kXufUMCod/iDK
	 bj4IWsKHmp0HkQGC3VG6fwykYNgtfUuziY9UZBKUU3/5JpopmGC/05XNzGAyDgLVdk
	 TFdn//iCoSDtw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 5/9] mptcp: add MSG_ZEROCOPY support
Date: Fri, 17 Jul 2026 12:50:14 +0800
Message-ID: <2a7c1b1838b75a83700c060da3068244681f1943.1784260668.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784260668.git.tanggeliang@kylinos.cn>
References: <cover.1784260668.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
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
 net/mptcp/protocol.c | 132 ++++++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h |   1 +
 2 files changed, 126 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6a9daa187dad..8b58309566b8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1118,9 +1118,11 @@ static bool mptcp_frag_can_collapse_to(const struct mptcp_sock *msk,
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
 
@@ -1129,7 +1131,13 @@ static void dfrag_clear(struct sock *sk, struct mptcp_data_frag *dfrag)
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
 
@@ -1174,7 +1182,7 @@ static void __mptcp_clean_una(struct sock *sk)
 		dfrag->data_len -= delta;
 		dfrag->already_sent -= delta;
 
-		dfrag_uncharge(sk, delta);
+		dfrag_uncharge(sk, delta, dfrag);
 	}
 
 	/* all retransmitted data acked, recovery completed */
@@ -1249,6 +1257,7 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag)
 	dfrag->already_sent = 0;
 	dfrag->page = pfrag->page;
 	dfrag->eor = 0;
+	dfrag->ubuf = NULL;
 
 	return dfrag;
 }
@@ -1416,6 +1425,16 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
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
@@ -1456,7 +1475,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	}
 
 	copy = min_t(size_t, copy, info->limit - info->sent);
-	if (!sk_wmem_schedule(ssk, copy)) {
+	if (!dfrag->ubuf && !sk_wmem_schedule(ssk, copy)) {
 		tcp_remove_empty_skb(ssk);
 		return -ENOMEM;
 	}
@@ -1466,13 +1485,19 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
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
@@ -1969,22 +1994,99 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
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
+	if (!sk_wmem_schedule(sk, pg_len + sizeof(*dfrag))) {
+		iov_iter_revert(&msg->msg_iter, pg_len);
+		put_page(pages[0]);
+		return -EAGAIN;
+	}
+
+	dfrag = kzalloc_obj(*dfrag, GFP_KERNEL_ACCOUNT);
+	if (!dfrag) {
+		iov_iter_revert(&msg->msg_iter, pg_len);
+		put_page(pages[0]);
+		sk_forward_alloc_add(sk, -(pg_len + sizeof(*dfrag)));
+		return -ENOMEM;
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
@@ -2023,6 +2125,16 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		if (!copy_limit)
 			goto wait_for_memory;
 
+		if (zc) {
+			ret = mptcp_sendmsg_zerocopy_iter(sk, msg, ubuf,
+							  copy_limit);
+			if (ret < 0)
+				goto do_error;
+
+			copied += ret;
+			continue;
+		}
+
 		/* reuse tail pfrag, if possible, or carve a new one from the
 		 * page allocator
 		 */
@@ -2098,6 +2210,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 out:
+	if (zc)
+		net_zcopy_put(ubuf);
 	release_sock(sk);
 	return copied;
 
@@ -2106,6 +2220,10 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		goto out;
 
 	copied = sk_stream_error(sk, msg->msg_flags, ret);
+	if (zc) {
+		net_zcopy_put_abort(ubuf, true);
+		zc = false;
+	}
 	goto out;
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index da40c6f3705f..f4e69ea51a94 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -268,6 +268,7 @@ struct mptcp_data_frag {
 	u8 eor;			/* currently using 1 bit */
 	u16 already_sent;
 	struct page *page;
+	struct ubuf_info *ubuf;
 };
 
 /* Arbitrary compromise between as low as possible to react timely to subflow
-- 
2.53.0

