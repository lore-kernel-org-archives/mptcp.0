Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B84A363089
	for <mptcp@lists.linux.dev>; Tue, 14 Jul 2026 01:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783993284; cv=none; b=HV7N2vxCAIxVtYr6/DXVfRfFaCkU6m45HENTzpkNBVqMMp+6Mek2U+POITsFXECkBzRXlNsDaqa5cnGaKuEh7ICdYc5lLwtt5n6FvR5V9R3Amb6zU6mXdXx8JYfWW+5Fg+WOJTlI/OEZX91wSPq1uxI3UXv9lr9O1pGcTG2ATKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783993284; c=relaxed/simple;
	bh=H5Cm6cOKjRQ12zdvqcBfQ7flApDys2+Xoh65xEYrebg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuFeC9v0UzPbj/2OERA3yGh2eWTDPA/49Ctqu9hyKxPwxIkdjxiudhGLXAHTfuTMMhRsDU39zXSOApCJPsOwJyPKzdNGi8fPl/RDpWPtE7db9e2Ls59TSL5uNPuzdqI8ykLdLwimofS59cb9uZzpFWG0LePPZ7BBZ7geyvdxqOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omrhoo1B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omrhoo1B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071DA1F00A3A;
	Tue, 14 Jul 2026 01:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783993283;
	bh=LKBCAr8P8RPbgEXOZ6wTLjT24L/DmR9qQDfKSvOV2Dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=omrhoo1BH+MDYLWCYJ06qlP+52K4GuvBhs1OVtS5hR2GaKXmLQfw1SpYuas3O4MtH
	 dugidtjziGmf2ysgyZrgBzrpaFeSNvFZWWD/AUHJe2K61gDPKnKoOPNhHSCKZckcCS
	 1RonYkex9cXd6IfFckKju6cnjdNsTO9YjrYTa6ej+isesB2bBg6S6lFEXEL6bJua8N
	 vCPpZCe1C3rGhf/Q59NZND3v+IKkPhm39zfiN2tXts9EhPRn8LFpjtGQLYIR+osux2
	 m2WzwRECFsULK3WqnBiz+3BSKuFMv1E9Qe/SQ7ctzBOfZTDnbzjc4ZlQ+yldYUZZjh
	 t8NRt1DtTDsRg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 3/7] mptcp: add MSG_ZEROCOPY support
Date: Tue, 14 Jul 2026 09:40:58 +0800
Message-ID: <bf12f30fe4266faf10ccef40d0eef61473c88f5d.1783992745.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783992745.git.tanggeliang@kylinos.cn>
References: <cover.1783992745.git.tanggeliang@kylinos.cn>
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

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 107 ++++++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h |   1 +
 2 files changed, 101 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 111da68d5875..d40fc5a89309 100644
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
@@ -1248,6 +1256,7 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag)
 	dfrag->already_sent = 0;
 	dfrag->page = pfrag->page;
 	dfrag->eor = 0;
+	dfrag->ubuf = NULL;
 
 	return dfrag;
 }
@@ -1417,6 +1426,11 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 
 		i = skb_shinfo(skb)->nr_frags;
 		can_coalesce = skb_can_coalesce(skb, i, dfrag->page, offset);
+		if (skb_zcopy_pure(skb) != !!dfrag->ubuf) {
+			can_coalesce = false;
+			tcp_mark_push(tp, skb);
+			goto alloc_skb;
+		}
 		if (!can_coalesce && i >= READ_ONCE(net_hotdata.sysctl_max_skb_frags)) {
 			tcp_mark_push(tp, skb);
 			goto alloc_skb;
@@ -1455,7 +1469,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	}
 
 	copy = min_t(size_t, copy, info->limit - info->sent);
-	if (!sk_wmem_schedule(ssk, copy)) {
+	if (!dfrag->ubuf && !sk_wmem_schedule(ssk, copy)) {
 		tcp_remove_empty_skb(ssk);
 		return -ENOMEM;
 	}
@@ -1465,13 +1479,19 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
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
@@ -1968,22 +1988,80 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
+static int mptcp_sendmsg_zerocopy_iter(struct sock *sk, struct msghdr *msg,
+				       struct ubuf_info *ubuf, u32 copy_limit,
+				       ssize_t *copied, long *timeo)
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
+		return -EAGAIN;
+
+	dfrag = kzalloc_obj(*dfrag, GFP_KERNEL_ACCOUNT);
+	if (!dfrag) {
+		iov_iter_revert(&msg->msg_iter, pg_len);
+		put_page(pages[0]);
+		return -ENOMEM;
+	}
+	dfrag->data_len = pg_len;
+	dfrag->data_seq = msk->write_seq;
+	dfrag->offset = pg_off;
+	dfrag->page = pages[0];
+	dfrag->ubuf = ubuf;
+
+	/* one ref for the dfrag; released in dfrag_clear */
+	net_zcopy_get(ubuf);
+
+	*copied += pg_len;
+	WRITE_ONCE(msk->write_seq, msk->write_seq + pg_len);
+	sk_wmem_queued_add(sk, pg_len);
+
+	list_add_tail(&dfrag->list, &msk->rtx_queue);
+	if (!msk->first_pending)
+		msk->first_pending = dfrag;
+
+	return 0;
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
@@ -2022,6 +2100,15 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		if (!copy_limit)
 			goto wait_for_memory;
 
+		if (zc) {
+			ret = mptcp_sendmsg_zerocopy_iter(sk, msg,
+							  ubuf, copy_limit,
+							  &copied, &timeo);
+			if (ret)
+				goto do_error;
+			continue;
+		}
+
 		/* reuse tail pfrag, if possible, or carve a new one from the
 		 * page allocator
 		 */
@@ -2097,6 +2184,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 out:
+	if (zc)
+		net_zcopy_put(ubuf);
 	release_sock(sk);
 	return copied;
 
@@ -2105,6 +2194,10 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
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

