Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254148;
	b=bLEbslHNTRPfb5Ycon0a6mC9ereXyWjVyxDjD66MxmqhmIF8PRdRhwtj6Zx7mQUa4zM/
	 BzDAmJ0FNo+G8pgqocP5h2inS1sKPCwn38nhvd8G1dbETkoySHRfT7UN6O/1BqFzieqkD
	 tvkWCrSI7Guhca3cGxbmv/xgypKQ+RGWkfoz2p9lDsegxQ5OvtLdscCbvQ16Y7P95DTJT
	 2bsfaEOkogrv28Mc1BU55iDKnfu38ZsLH8xdBd8fEUrpfv80KwDdBwT4Ykt4C24wGcLMv
	 CNCa4xNCZkvEyeKex05Lwvu0jwkSwmSUqKhNKHAoJqqbtfr+TdMynhHX0cKNnjJlyHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254148;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ZIEEoUlkKmOIecp7xQYBG92fVqFc43X1gCRji74IyJ8=;
	b=tsZF8gfskdV1w+LZjE6wspBPpT9Tw+nMfD/QG34SPrM7cjCsZAx8k/y3pfTxrck5rm9U
	 8wcqLm1aJm3FgHTx0E+nind6QrEfXJex5dk8Tv/1Z93/auN/p0GIFtconRQdZ/2dTFa43
	 2P20BKJFIsIDcXk+JZnnuOnGXD60QfRjC2halGNhwwi/YN9in0kHx46stgS1qu4htljJS
	 pypHdzboJ0MataLPAmQJe1U00mX7wqM64SRH7RuYqVFJWBZDLNnhzO7Rl8cd3WHw8pQQQ
	 vagCANrovakJ82R6/NbWmlX5HEbuwGHkkqsJkai0CUIIkUNdc9ckGIdDoegH7qpIAiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ipt3YkzL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADE5606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ipt3YkzL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354111F000C0;
	Sat, 21 Nov 2026 09:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254147;
	bh=ZIEEoUlkKmOIecp7xQYBG92fVqFc43X1gCRji74IyJ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ipt3YkzLgFmNSuDRpZshz0zMxFOY8Liz7ZU28ujjIXFTPitX1+SAEO/j3UK5CQNux
	 U8/xmU+0dHeaJTNxuDRo1hflH34xl2OucaI9xKn7jLjD0O2mPbxo5CiqK8YQcyShOh
	 F38Xcjsi5pPgjD+cnOBfbCQpRYv9mFFTvGc6eppWiZBpveyrZNc5ekfJEBC+qVxt4O
	 jVCTJX/bCFNfQ/NEyH15Vt4XJbKYKkOe9Z6j5P7KvIERziUNyu0aHg+Vs7o3hJPNDe
	 efjkCcqUrn5fKvKTaGRX5Pi5M72W1k1i5Wr8WPN5unDl1pyyrJ3tQtZYBhndInM2Qw
	 reUadU3SMegsA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:07 +0100
Subject: [PATCH mptcp-net v2 09/62] mptcp: force the charge for the first
 skb of a subflow
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261121-mptcp-cmason-fixes-v2-9-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4367; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=HGPrQWelvsEIVnJtJ3YWyKXWZ1UaVMs81wOcSGQG5FU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ0/3XeifurpG5tdVp2rHM5etZ96UmycnbeM3L8z12u
 que92h3RykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwEQsXBgZrpZOmRB/87LsSl52
 7+P7gvd57Y1a1hsh7aI+c8/L5/7Kyxj+xx29t9h7YZrJ95DmouCYWXvsO5/PdTjf/Wp/lMzzLcs
 4mAE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chris Mason <mason@kernel.org>

After a fallback to TCP, an MPTCP connection can stay stalled once TCP
memory use is back below the hard limit of net.ipv4.tcp_mem, and above
that limit send() on an idle MPTCP socket can leave its data unsent.

A push moves data from the write queue of the MPTCP socket to a subflow,
and charges the subflow twice: for a new skb in __mptcp_alloc_tx_skb()
and for the payload in mptcp_sendmsg_frag(). On an idle socket, with
nothing queued, TCP forces both charges past the limit, in
tcp_stream_alloc_skb() and tcp_wmem_schedule(), since no ACK would ever
restart such a socket. But a push forces neither, so above the hard
limit both can be refused, and the push then moves no data.

The earlier commit "mptcp: arm the rtx timer if a push leaves data
behind" repeats such a push from the MPTCP retransmission (rtx) timer.
But each attempt fails while memory use stays above the limit. After a
fallback that timer is disabled, so the data stays unsent until another
event, such as the next send(), repeats the push.

The fix used here is to:
- force the charge for the skb if the subflow has nothing queued
- charge the payload with tcp_wmem_schedule()
- send only the bytes that tcp_wmem_schedule() grants

The first skb of an MPTCP-level reinjection is then forced too, as it is
sent on a subflow with nothing queued. This is bounded the same way.

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer shared with the original version of this patch:
a TCP memory shortage, for 30 seconds, during which each of ten idle
MPTCP clients calls send() once. Without this patch, only 5 of them had
their answer during the shortage, versus 8 with it: the 2 others are
blocked in send() during the shortage, which is not fixed here. Some
answers only came after the next send(), 300 seconds later, because of
the issue fixed by the previous commit:

  IDLE label=behind-the-second-send t=338.9 conn=0 [...] answer_at=336.4
  IDLE label=behind-the-second-send t=338.9 conn=1 [...] answer_at=4.2

Fixes: 724cfd2ee8aa ("mptcp: allocate TX skbs in msk context")
Signed-off-by: Chris Mason <mason@kernel.org>
[ Shorter comments. Commit message: the first skb of a reinjection is
  forced too + how the issue was found, and its symptoms. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Note (Sashiko on v1): info.mss_now and size_goal cannot be stale in net:
the in-kernel scheduler only picks a subflow that can send, which can
then only move to TCP_CLOSE, where tcp_push() does nothing.
---
 net/mptcp/protocol.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fa3d0522a696..90fbfb258b79 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1387,13 +1387,17 @@ static struct sk_buff *__mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk, g
 	if (!skb)
 		return NULL;
 
-	if (likely(sk_wmem_schedule(ssk, skb->truesize))) {
-		tcp_skb_entail(ssk, skb);
-		return skb;
+	/* like TCP, force the charge if nothing is queued */
+	if (tcp_rtx_and_write_queues_empty(ssk)) {
+		sk_forced_mem_schedule(ssk, skb->truesize);
+	} else if (unlikely(!sk_wmem_schedule(ssk, skb->truesize))) {
+		tcp_skb_tsorted_anchor_cleanup(skb);
+		kfree_skb(skb);
+		return NULL;
 	}
-	tcp_skb_tsorted_anchor_cleanup(skb);
-	kfree_skb(skb);
-	return NULL;
+
+	tcp_skb_entail(ssk, skb);
+	return skb;
 }
 
 static struct sk_buff *mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk, bool data_lock_held)
@@ -1449,6 +1453,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	bool reuse_skb = true;
 	struct sk_buff *skb;
 	size_t copy;
+	int avail;
 	int i;
 
 	pr_debug("msk=%p ssk=%p sending dfrag at seq=%llu len=%u already sent=%u\n",
@@ -1522,10 +1527,14 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	}
 
 	copy = min_t(size_t, copy, info->limit - info->sent);
-	if (!sk_wmem_schedule(ssk, copy)) {
+
+	/* like TCP, allow some progress up to tcp_wmem[0] */
+	avail = tcp_wmem_schedule(ssk, copy);
+	if (avail <= 0) {
 		tcp_remove_empty_skb(ssk);
 		return -ENOMEM;
 	}
+	copy = avail;
 
 	if (can_coalesce) {
 		skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], copy);

-- 
2.55.0

