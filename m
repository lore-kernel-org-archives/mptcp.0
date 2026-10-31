Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793486692;
	b=c7KYf6DeulLh4F+WoHzLj/7khOjjHFIf3gnL9fZNXMaAreOP5yJLfcWNmu8TNeQIA7hi
	 ioOerbbdH0nxlEEaNoUT340GZC2x5XCbST0AooGhmqWZy0FG5205i6RGDNbVSJZm3A/qp
	 9NnnWPz/gEqdGwT32e1kkUaXArnVpSeDq2tj+k9qA8/q8CsjFGh6DYV214+1eiam3NdDh
	 g2S8fvAA8tiOcVEDvZYkbXMNkxWiegz+35MGFbdkN8zSIY/Zx3FQlVKI3fXj5EQtoUrAH
	 RaVU/vuPf0Ioqj4Gmd1oUQP+eChHLFPJKQrKHGQzpZp42rPC2zihThq2DgDRDN2PGtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793486692;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Cu1+g4Vv0tl6byy+uUameFJYvdXNgHhqgSuGvv3DksU=;
	b=4tNrKaD+HVIuULnBaqg5OLaPs0c9WGC0ApW9uvXAVI9CQ4wFog7L3+dZ7DJHHoDL+Lda
	 lI8/7wFpqCnrmOYayZsGaI8Syy/eXvZSPrqh8EVQfaLpiNrCG4rPv0hWWWHpXeZOmM145
	 FT793p8P4kOg19iSmfpKM78rmLcZv7kAZyNHGJRMWV280bwdlUkYQILiuMwxBin2Wuttv
	 6AlOS2PT90qGSwi8byiLq1GK7IXStuZBPy/nTuqoRej98PD76bDS9VRZOtnk9B6Dm0rrY
	 ZHWLkMu4Yh6XNLHL1MO5uSUNyl+/LNXtcnWwor11KRNUPUcyAhJumbVEKiJexjVcPng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=greBMJ8b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61555606A31A
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 22:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=greBMJ8b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829481F00919;
	Sat, 31 Oct 2026 22:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793486692;
	bh=Cu1+g4Vv0tl6byy+uUameFJYvdXNgHhqgSuGvv3DksU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=greBMJ8b+JP0IVfAZrw2C9uAHU8h+cySo8o0P+qHO3q1TU0xLybAyo2NlZUt1kB1j
	 M7LsofTe3cAjCs5D5N1dlv/qJWcpvMQr8cB8eBfclvqxx50515brIw+urMw5rUp5+8
	 U2jHLgvuJFgw1iwI/F7RN51Ggs/H599mCTmB+k5CF+H/MmHWdjp12Uw2NMciXaECcy
	 +fWYAF0W3YsSnqeSJ0nCnGa4pkcoQnBx1Wl3HqjWuBzG3LB4KDDKqjE+w1Nb5lHQEE
	 pbm7d281z2xLBm1gsUVB161s2fScnrvDkO2OxawcVmd8e/BXgR+9+Cut8QhaVKueMe
	 CIBL1qULJv8XA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 31 Oct 2026 23:44:34 +0100
Subject: [PATCH mptcp-next v2 2/8] mptcp: sched: let get_send limit what
 one decision sends
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
Message-Id: <20261031-mptcp-sched-opp-retrans-v2-2-e9c4a30f6841@kernel.org>
References: <20261031-mptcp-sched-opp-retrans-v2-0-e9c4a30f6841@kernel.org>
In-Reply-To: <20261031-mptcp-sched-opp-retrans-v2-0-e9c4a30f6841@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Abdul Wasey <w453y.me@gmail.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gregory Detal <gregory.detal@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4776; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=xRwb9fex/kT1ZTdKpzmIDilnCWsXA1mgxwtCsflOCSM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLKe5cd8iVdxeK9+eU5y0BKvJMWrOoe1ojxjwyZZ5BrOe
 puw/JJkRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwETMpzD8d3jF0KLh/SWFJ+i3
 puqHFb8djt4PfnT+in37A/YwhsiwWYwMkxUf7Hp/2lRLcOa0U2VTLk5RieuZaavN/H2ZDyN7nGQ
 kPwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Gregory Detal <gregory.detal@gmail.com>

A scheduler picks the subflows for the pending data in get_send, then
__subflow_push_pending() sends on each of them until msk->snd_burst is
used up, the subflow has no room, or it is not active. snd_burst is only
checked once a whole dfrag is sent, and one dfrag can hold up to a page
fragment, 32 KB, so a scheduler cannot ask for less than that. Sending
one MSS per subflow in turn, for example, is not possible.

Add send_limit to the subflow context, which a scheduler can set in
get_send: at most that many bytes are sent on the subflow for this
decision, then the scheduler is asked again. 0, the default, keeps the
current behaviour. The limit applies to this decision only:
__subflow_push_pending() reads and clears it, and mptcp_sched_get_send()
clears the limits before asking a scheduler: a retransmission can leave
one behind, as it calls get_send when the scheduler has no get_retrans,
without using the limit. Nothing sets it yet: a later patch lets a BPF
scheduler write it.

When the limit is reached inside a dfrag, the dfrag stays the send head,
partly sent, as it already does when the subflow runs out of space in
the middle of it. first_pending then moves on only once the dfrag is
fully sent, as before.

This is based on Gregory Detal's RFC called "mptcp: update scheduler
API" [1] but applying Mat Martineau's suggestion.

Link: https://lore.kernel.org/mptcp/20240527-sched_per_packet-v1-0-09a41d405f7c@gmail.com/ [1]
Signed-off-by: Gregory Detal <gregory.detal@gmail.com>
Co-developed-by: Abdul Wasey <w453y.me@gmail.com>
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 22 ++++++++++++++++++++--
 net/mptcp/protocol.h |  4 ++++
 net/mptcp/sched.c    |  4 ++++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8f3c6ebd49ee..d960ab9c76b3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1823,17 +1823,25 @@ void mptcp_check_and_set_pending(struct sock *sk)
 static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 				  struct mptcp_sendmsg_info *info)
 {
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_data_frag *dfrag;
 	int len, copied = 0, err = 0;
+	u32 limit;
 
-	if (mptcp_subflow_ctx(ssk)->penalise)
+	if (subflow->penalise)
 		mptcp_penalise_cwnd(ssk);
 
+	/* the scheduler's limit for this decision only */
+	limit = subflow->send_limit;
+	subflow->send_limit = 0;
+
 	while ((dfrag = mptcp_send_head(sk))) {
 		info->sent = dfrag->already_sent;
 		info->limit = dfrag->data_len;
-		len = dfrag->data_len - dfrag->already_sent;
+		if (limit && dfrag->data_len - info->sent > limit - copied)
+			info->limit = info->sent + limit - copied;
+		len = info->limit - info->sent;
 		while (len > 0) {
 			int ret = 0;
 
@@ -1849,6 +1857,16 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
+
+		/* Stopped inside the dfrag: it stays the send head, as when the
+		 * subflow runs out of space, and the scheduler is asked again.
+		 */
+		if (limit && copied >= limit) {
+			if (dfrag->already_sent == dfrag->data_len)
+				msk->first_pending = mptcp_send_next(sk);
+			err = copied;
+			goto out;
+		}
 		msk->first_pending = mptcp_send_next(sk);
 
 		if (msk->snd_burst <= 0 ||
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1d41ab1da2e0..4e8920747682 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -606,6 +606,10 @@ struct mptcp_subflow_context {
 	bool	data_avail;
 	bool	scheduled;
 	bool	penalise;	    /* scheduler flagged this subflow for cwnd halving */
+	u32	send_limit;	    /* set by the scheduler in get_send: at
+				     * most this many bytes before it is
+				     * asked again; 0 for no limit
+				     */
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
 	bool	fully_established;  /* path validated */
 	bool	close_event_done;   /* has done the post-closed part,
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 1e59072d478c..c8d193cb0e4c 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -189,6 +189,10 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
 		return mptcp_sched_default_get_send(msk);
+
+	/* limits are per decision: a retransmission can leave some behind */
+	mptcp_for_each_subflow(msk, subflow)
+		subflow->send_limit = 0;
 	return msk->sched->get_send(msk);
 }
 

-- 
2.55.0

