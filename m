Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972063FB067
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 11:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785151788; cv=none; b=JG5U91cnZUVX3ZTb8anfZ+4PKIHOoUlXZ1lWB3ujuNWWdedmp63XDTH+BUEv6KPWMshN21Z2rHDQiRPrkvwK0EtvxbdvK0H29IYHlN3Acbwt1mgTt3CLibLG+Z4LozzEqvi5YEYOYF4dOrbmFnES4V2OpYie4eXufE9z3bIvVBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785151788; c=relaxed/simple;
	bh=IiuCd/XadySPOkV69d9lrEmUQ0CtR/jUUFl6UKTKPOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyqjJ6FKPZWVY3/bg1zU6MJ0EUtgwlcL5KpDWgYYklo4VwEF4ksm5NADEwM8GLaQQH2N2AhCjJXHlWXrkHNpD6LpNfX1G6IIHif1pqhlqFtiYkBKYEDx8dQE9r82dJipGNE1t58LsZjn4R7zy+4gZ7YGK+qcO7gsqGleigpORZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=im3c9RVB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="im3c9RVB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DDD1F00A3E;
	Mon, 27 Jul 2026 11:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785151787;
	bh=jpXm/hJOvBXqROpamkMRhqcfbQbabC7Wd2Hxenf60Vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=im3c9RVB2Csi13kyh+RW+izfVwpVrR+GWbf5YUwHTjBfpQkX8b/AYY1GQIQdFGOxB
	 GawVC5AJIgbzjm8JNF/atNLd4HnpoQOUYR2r6VbuMJOtG8x8PNfWChfHzCheL1j7sk
	 O2lHZReGx5i/9ryK6RDY0mEHGVV0df51p3ka06kFYMPpRcgnzQ3f/CqtolP9IA3lFX
	 yVw3Z0HeQfojNwb3JhfGFNuP90y2rYqNEzgfdIm82R+W7z4MpP8der4wTGivaPBb8k
	 MfDHIVfHjmcelnLBYUP0m6SpMvs9qs/jQFcO0vwmFwPe4XhROPHcUiCUCUI/sgr42Q
	 wB4J3qo/CWNkA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 5/6] mptcp: trim the duplicated skb head at receive enqueue
Date: Mon, 27 Jul 2026 19:29:20 +0800
Message-ID: <81bd1e2fa9c959927bf0d1cae718a9da72164b5b.1785150300.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785150300.git.tanggeliang@kylinos.cn>
References: <cover.1785150300.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

After the CB offset field removal, the msk receive queue tracks the
consumed position with the msk-level copied_seq and each skb map_seq
points at its first byte (skb->data[0]). When the same DSN range is
delivered more than once - a partially-acked segment, or duplicate
data arriving on a second subflow - the skb is queued whole: its
map_seq sits below msk->ack_seq and the duplicated bytes stay
physically at the front of the skb.

The linear readers (recvmsg, read_sock, read_done) cope with that by
computing a per-skb offset = copied_seq - map_seq and skipping it. But
consumers that treat the receive queue as a single contiguous byte
stream cannot: the TLS strparser builds an anchor whose frag_list is
the receive-queue skbs and reads it with a plain skb_copy_bits(), which
has no per-skb offset knowledge. A record spanning such an skb boundary
then reads the duplicated prefix and gets corrupted.

Physically drop the duplicated leading bytes at enqueue time instead,
so the receive queue is always contiguous. Add mptcp_trim_dup_head(),
modelled on tcp_trim_head()/__pskb_trim_head() but tolerating a
non-empty linear area: it pulls the linear head first, then eats the
remaining bytes from the paged frags, and the caller bumps map_seq
accordingly. The skb truesize is left unchanged on purpose - dropping
only skb->len/data_len keeps the memory accounting over-reserved, hence
always safe, at both callers and avoids any rmem/fwd_alloc fixup.

Two callers trim the overlap:
 - __mptcp_move_skb() partial-packet branch (map_seq < ack_seq <
   end_seq). The skb is not owned yet, so on the -ENOMEM unclone
   failure refund the truesize borrowed by mptcp_borrow_fwdmem()
   before dropping it.
 - __mptcp_ofo_queue() uncoalesced branch. The skb is already msk
   owned, so mptcp_drop() refunds it; skip advancing ack_seq on
   failure.

After trimming, map_seq equals the queue tail end_seq, so the segment
can be coalesced normally.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 79 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b9e44c64c620..09b888ff33c7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -11,6 +11,7 @@
 #include <linux/netdevice.h>
 #include <linux/sched/signal.h>
 #include <linux/atomic.h>
+#include <linux/skbuff_ref.h>
 #include <net/aligned_data.h>
 #include <net/rps.h>
 #include <net/sock.h>
@@ -429,6 +430,62 @@ void __mptcp_sync_rcv_sequence(struct sock *sk)
 	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;
 }
 
+static int mptcp_trim_dup_head(struct sk_buff *skb, int delta)
+{
+	struct skb_shared_info *shinfo;
+	int headlen, eat, i, k;
+
+	if (delta <= 0)
+		return 0;
+
+	/* Received skbs are not expected to carry a frag_list; the frag loop
+	 * below only handles the linear area and the paged frags.
+	 */
+	DEBUG_NET_WARN_ON_ONCE(skb_has_frag_list(skb));
+
+	if (skb_unclone_keeptruesize(skb, GFP_ATOMIC))
+		return -ENOMEM;
+
+	/* Eat the linear head first, then the paged frags. Note the skb
+	 * truesize is left unchanged on purpose: dropping only skb->len /
+	 * skb->data_len keeps the memory accounting over-reserved (hence
+	 * always safe) at both callers.
+	 */
+	headlen = skb_headlen(skb);
+	eat = min(delta, headlen);
+	if (eat) {
+		__skb_pull(skb, eat);
+		delta -= eat;
+	}
+	if (!delta)
+		return 0;
+
+	shinfo = skb_shinfo(skb);
+	eat = delta;
+	k = 0;
+	for (i = 0; i < shinfo->nr_frags; i++) {
+		int size = skb_frag_size(&shinfo->frags[i]);
+
+		if (size <= eat) {
+			skb_frag_unref(skb, i);
+			eat -= size;
+		} else {
+			shinfo->frags[k] = shinfo->frags[i];
+			if (eat) {
+				skb_frag_off_add(&shinfo->frags[k], eat);
+				skb_frag_size_sub(&shinfo->frags[k], eat);
+				eat = 0;
+			}
+			k++;
+		}
+	}
+	shinfo->nr_frags = k;
+
+	skb->data_len -= delta;
+	skb->len -= delta;
+	return 0;
+}
+
 static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 {
 	u32 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
@@ -474,6 +531,16 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 		/* Partial packet: map_seq < ack_seq < end_seq. */
 		int delta = (u32)msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
 
+		if (mptcp_trim_dup_head(skb, delta)) {
+			/* skb is not owned yet: mptcp_borrow_fwdmem() added its
+			 * truesize to sk_forward_alloc and cleared skb->sk, so
+			 * mptcp_drop() won't refund it. Do it here.
+			 */
+			sk_forward_alloc_add(sk, -skb->truesize);
+			mptcp_drop(sk, skb);
+			return false;
+		}
+		MPTCP_SKB_CB(skb)->map_seq += delta;
 		copy_len -= delta;
 		goto add_queue;
 	}
@@ -889,10 +956,20 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 		if (!tail || !mptcp_try_coalesce(sk, tail, skb)) {
 			int delta = ack_seq - MPTCP_SKB_CB(skb)->map_seq;
 
-			/* skip overlapping data, if any */
+			/* Physically trim the overlapping prefix, if any,
+			 * so the receive queue stays contiguous.
+			 */
 			pr_debug("uncoalesced seq=%x ack seq=%x delta=%d\n",
 				 MPTCP_SKB_CB(skb)->map_seq, ack_seq,
 				 delta);
+			if (mptcp_trim_dup_head(skb, delta)) {
+				/* skb is msk-owned here; mptcp_drop() refunds
+				 * it. Skip advancing ack_seq/bytes_received.
+				 */
+				mptcp_drop(sk, skb);
+				continue;
+			}
+			MPTCP_SKB_CB(skb)->map_seq += delta;
 			__skb_queue_tail(&sk->sk_receive_queue, skb);
 		}
 		msk->bytes_received += seq_delta;
-- 
2.53.0

