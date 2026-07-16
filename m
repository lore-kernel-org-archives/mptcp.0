Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D14B37E5E9
	for <mptcp@lists.linux.dev>; Thu, 16 Jul 2026 07:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188296; cv=none; b=pCueY9+lwJYFh5NcCG8uTTuyvwzS1z6Le+TVEshSoYfrr5GDi852GkRSJWFYDLoo1l6zpUDPjmyZzyxF8KtxMlUmObIsiCv3bkbX6EoUCInhgEP9GQOxTeWzvC8JIHDo7jxafh0sitT021KOiW7UcBdQekHra0UO2fL6aTE54RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188296; c=relaxed/simple;
	bh=rQS5DMDkDbhNw+9xnhwVGPKgOZnj19ljRvfGpV14O/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I22oasZbVbiFRYW03o+qLh4Fuvgs16ZPakXK6iiKZy7sQ6AKg11emkNny7vou5B6KSa1iV3vPKHCMPUkRgAJy6B4w20BhHghLbquZjgf0mhUoHTVavyTDiJt41LNK3Sd1/CPtGbVlF0931e7++dV8loAtdab/OjMDy4d1ebvgw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIs23Cbr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIs23Cbr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4DB1F000E9;
	Thu, 16 Jul 2026 07:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784188293;
	bh=FLEMHYXPlFidL7CwAfPUWWiB8daapXlFpiOz0Ru+r3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aIs23CbrkYfJta/WSSb076vA6PW1gJ/1Hvswx0nOstT/fOalrshClMZRocdqrev4i
	 g0xW2TiKzafF8uGYwL8JnCeFDqoxs4O9IKOzVCrOr+k0/i21c59LRM/Q9/KSZkwqj8
	 y7B5DSlTgKM1QDVfridfnEbGCEF6UmEs+F6qFkn1iSuDigH5YTWQ5LhurwFseRGiin
	 ieZbv1EaPWah90YDl8s6gtrYQOV1UV+zFr6mtCUgQDxQ6P3D0Z9InmDZ1XdRTvIQtO
	 7XPMqqaopZHaE2ue3l8JwF4iKEAtlxSTyz3ORQapZuullYn3XDizzoJ4YyDfB6exoI
	 F2UPKDCunPYyA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 06/10] mptcp: add MSG_ZEROCOPY support
Date: Thu, 16 Jul 2026 15:50:45 +0800
Message-ID: <ee2524c491e51dfeedda99dad9962bab67af2dec.1784188064.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784188064.git.tanggeliang@kylinos.cn>
References: <cover.1784188064.git.tanggeliang@kylinos.cn>
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
notifications. The data_len field is widened from u16 to u32 to prevent
truncation on 64KB-page kernels (ARM64, PPC64). The dfrag metadata
overhead is accounted for in sk_wmem_queued_add() to prevent bypassing
socket memory limits. When iov_iter_get_pages2() returns 0, the function
returns -EFAULT to properly signal iterator exhaustion.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 117 +++++++++++++++++++++++++++++++++++++++----
 net/mptcp/protocol.h |   5 +-
 2 files changed, 111 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 85bbcb16c87e..9cb32bcfa58b 100644
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
@@ -1257,7 +1266,7 @@ struct mptcp_sendmsg_info {
 	int mss_now;
 	int size_goal;
 	u16 limit;
-	u16 sent;
+	u32 sent;		/* matches dfrag->already_sent width */
 	unsigned int flags;
 	bool data_lock_held;
 };
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
@@ -1969,22 +1994,81 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
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
+		return -EFAULT;
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
+	dfrag->overhead = sizeof(struct mptcp_data_frag);
+
+	/* one ref for the dfrag; released in dfrag_clear */
+	net_zcopy_get(ubuf);
+
+	*copied += pg_len;
+	WRITE_ONCE(msk->write_seq, msk->write_seq + pg_len);
+	sk_wmem_queued_add(sk, pg_len + dfrag->overhead);
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
@@ -2023,6 +2107,15 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
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
@@ -2098,6 +2191,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 out:
+	if (zc)
+		net_zcopy_put(ubuf);
 	release_sock(sk);
 	return copied;
 
@@ -2106,6 +2201,10 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		goto out;
 
 	copied = sk_stream_error(sk, msg->msg_flags, ret);
+	if (zc) {
+		net_zcopy_put_abort(ubuf, true);
+		zc = false;
+	}
 	goto out;
 }
 
@@ -2960,7 +3059,7 @@ static void __mptcp_retrans(struct sock *sk)
 
 		retrans_seq += len;
 		msk->bytes_retrans += len;
-		dfrag->already_sent = max_t(u16, dfrag->already_sent,
+		dfrag->already_sent = max_t(u32, dfrag->already_sent,
 					    retrans_seq - dfrag->data_seq);
 
 		/* With csum enabled retransmission can send new data. */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7d624cb0fa7d..830733327e66 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -262,12 +262,13 @@ struct mptcp_pm_addr_entry {
 struct mptcp_data_frag {
 	struct list_head list;
 	u64 data_seq;
-	u16 data_len;
+	u32 data_len;		/* u16 truncates on 64KB-page kernels */
 	u32 offset;		/* u16 wraps on 256KB-page kernels */
 	u8 overhead;
 	u8 eor;			/* currently using 1 bit */
-	u16 already_sent;
+	u32 already_sent;	/* u16 overflows when data_len > 65535 */
 	struct page *page;
+	struct ubuf_info *ubuf;
 };
 
 /* Arbitrary compromise between as low as possible to react timely to subflow
-- 
2.53.0

