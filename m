Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED1E337BA5
	for <mptcp@lists.linux.dev>; Thu, 27 Nov 2025 15:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764259122; cv=none; b=WhCBg40qhEcqrvfS+1xw39PojzNomYOdUirgXqvkeFGKxFq8c0Bqm5mHxYFrdqv/5mnL2yyFYR+NnX0TmbX+M3ONZUMQOY+lMMq0bqIHE1UV0nIrwAsPiIxk+EfMpDObyFJvvLAUlU4R1qZ6zKae/QDvBw3WnLDyloZa4jWhooM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764259122; c=relaxed/simple;
	bh=W0Op5WKS/IPZ3TOd1vWrAhwOjwIOzFjiWc1S4TLx6N8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qBdAhI6iuLxRaWn/gT7fWZEyBbo+GuvUEPpva6KHOCrpGYrdXLbt2CryBxNV7T8Q7elnSOY11gvTKRZETYUT9V0XlV50wz5gO9fpoE6insS4wr0Nu8nqbH1Ji9OaSvFvB8eSyZ9w6PsxG6qgbRpUhVqKHO2Awq20Zj7BYAccGhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/uQVtE4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/uQVtE4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6201C4CEF8;
	Thu, 27 Nov 2025 15:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764259122;
	bh=W0Op5WKS/IPZ3TOd1vWrAhwOjwIOzFjiWc1S4TLx6N8=;
	h=From:Date:Subject:To:Cc:From;
	b=R/uQVtE4NBvYPJJspc1IUgdX0pGNKx1PpEU7fUsBBIjA3h7NiD9t3VR9/dV2f0uN8
	 oQaOSVF2b+8Ged+lDN/SP5nxlhobJP3rH+dCvuVuL6qlolJP8knWko+uJmUVaiakZU
	 b+2GHEBklsxSJpZtmij4j9KGUM79FucGku35Q846l4+U7iPQJsxUC9PyKsBEbXo1xd
	 xdUhBCp0i5WNVnwW/3wtoyY1X9Qizk33lZEUteTBuApyUuwXYGYHVo8r4/nvMrGvyC
	 K0HsH/uafkbjRBM8qtmfSLth3Jzwx2kCiGoTc2fQeX6/ZUtOMu1IHGLd6szwlZT3/E
	 ZOI3w3DYh6hQw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 27 Nov 2025 16:58:30 +0100
Subject: [PATCH RFC mptcp-next] mptcp: support net.ipv4.tcp_rcvbuf_low_rtt
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251127-mptcp-tcp_rcvbuf_low_rtt-v1-1-fa080d67f2e5@kernel.org>
X-B4-Tracking: v=1; b=H4sIACV1KGkC/yWMQQqDMBAAvyJ7NuCm2oJfEQmabuyCxrBJVRD/3
 lAPc5jDzAmRhClCW5wgtHHk1WfBsgD7GfxEit/ZQVe6QdQvtYRkg8oYsdv4dWZedyMpKWefNep
 qxOYxQM6DkOPjv+7grjwdCfrr+gGgtvH8dgAAAA==
X-Change-ID: 20251127-mptcp-tcp_rcvbuf_low_rtt-fc64120b153a
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3028; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=W0Op5WKS/IPZ3TOd1vWrAhwOjwIOzFjiWc1S4TLx6N8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI1Sg2eLW72Xrtu35VTa25p9zNPeCTvnxdsJKL6zjfvz
 73yrvrMjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlM6GT477t9Y+hBy1PZN1wc
 Fb8ybypZ/ev2tJjPOlZyb8uyo/delGT4ZyRsfTJ0tdb754dWe4sxfp6eG75ssmT6XsnOTjMrwc4
 vjAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This is a follow up of commit ecfea98b7d0d ("tcp: add
net.ipv4.tcp_rcvbuf_low_rtt"), but adapted to MPTCP.

MPTCP has mptcp_rcvbuf_grow(), which is similar to tcp_rcvbuf_grow, but
adapted for the MPTCP-level socket.

The idea here is similar to what has been done on TCP side: not let
mptcp_rcvbuf_grow() grow sk->sk_rcvbuf too fast for small RTT flows.
Quoting Eric: If sk->sk_rcvbuf is too big, this can force NIC driver to
not recycle pages from their page pool, and also can cause cache
evictions for DDIO enabled cpus/NIC, as receivers are usually slower
than senders.

If RTT if smaller than the new net.ipv4.tcp_rcvbuf_low_rtt sysctl value,
use the RTT / tcp_rcvbuf_low_rtt ratio to control sk_rcvbuf inflation.

Tested: NO :)

This is why it is still a RFC. My perf test env is currently broken. I'm
sharing this patch just in case it is easy for someone to validate this
patch. Ideally such tests should be done on top of "trace: mptcp: add
mptcp_rcvbuf_grow tracepoint" patch from Paolo (and probably on top of
the related series), following similar tests to the ones done by Eric,
making sure the receiver is slower than the sender. Feel free to take
the patch, and send new versions changing the author, etc. if needed.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e484c6391b48..715a9a072c6a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -208,6 +208,7 @@ static bool mptcp_rcvbuf_grow(struct sock *sk, u32 newval)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	const struct net *net = sock_net(sk);
 	u32 rcvwin, rcvbuf, cap, oldval;
+	u32 rtt_threshold, rtt_us;
 	u64 grow;
 
 	oldval = msk->rcvq_space.space;
@@ -219,10 +220,19 @@ static bool mptcp_rcvbuf_grow(struct sock *sk, u32 newval)
 	/* DRS is always one RTT late. */
 	rcvwin = newval << 1;
 
-	/* slow start: allow the sender to double its rate. */
-	grow = (u64)rcvwin * (newval - oldval);
-	do_div(grow, oldval);
-	rcvwin += grow << 1;
+	rtt_us = msk->rcvq_space.rtt_us >> 3;
+	rtt_threshold = READ_ONCE(net->ipv4.sysctl_tcp_rcvbuf_low_rtt);
+	if (rtt_us < rtt_threshold) {
+		/* For small RTT, we set @grow to rcvwin * rtt_us/rtt_threshold.
+		 * It might take few additional ms to reach 'line rate',
+		 * but will avoid sk_rcvbuf inflation and poor cache use.
+		 */
+		grow = div_u64((u64)rcvwin * rtt_us, rtt_threshold);
+	} else {
+		/* slow start: allow the sender to double its rate. */
+		grow = div_u64(((u64)rcvwin << 1) * (newval - oldval), oldval);
+	}
+	rcvwin += grow;
 
 	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
 		rcvwin += MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq - msk->ack_seq;

---
base-commit: 1fea9a6bd10f5c5494b7973141083ec56ecffd74
change-id: 20251127-mptcp-tcp_rcvbuf_low_rtt-fc64120b153a

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

