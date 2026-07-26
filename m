Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B2D339872
	for <mptcp@lists.linux.dev>; Sun, 26 Jul 2026 05:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785045362; cv=pass; b=c7CVh9U+9+aH+G0xfu0ifxE66W07DJgY5IE8VANmXnK64xqV7ZfOvqny8pNARTCxEW6B2aObmnPwN6Y2wYs+ZMn2bCoCj7beJbSsXjRV5TrXCd87ewzJeJ+PUmKdjRnd6yw6w2GIs1+91nYoh86HCY4dLNdATdxierUpTHM774M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785045362; c=relaxed/simple;
	bh=IrngOTyv/xvkQAyj1Sj54FBujjTULFNZDjyxERE2b3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZZdsRqmndlaPQ+i/mpZEMoNvW9NNFxAlzlqJGmZzdnsnVpqpLbytCBXom1xDpdzVPmfpWwsTJJ/7ceiQu7xJKK5cluLczW5R2cBV0X0CL7jEluMUw+CRzTdJiYflBEqpwbHqH+Brcu6vkiT2DH9uDXii2t+Tj3YXYVTDPiwMbow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=JSroui9U reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="JSroui9U"
ARC-Seal: i=1; a=rsa-sha256; t=1785045351; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hTe08R8AJw5AB3R0L2hbcX57HirTdcVCCnN6/GIsXqrAfKCPaBiRt69LN1IUd50Zx8z660hk2qObN0T1uDJGfgkJqmDU4jQL0dkFKGZLINBIRMs/9xxcOHaTx//+jMnKSmMZI+ksPeE3LotAMJoAZAXibxEby5RCRCQgySj0th0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785045351; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=raXRfOMEUBNatKu/dd12OUtxcNp1/GlVlHMcItvi4tw=; 
	b=a7RKw+OggX6ix+gfhx6mfQRvnXCYK+tszwMycjD4G2E3AGXOFZbx+HFvAv1BmsvhE80Hrt8s/Yr7y6/BAAc5WB7uCq1D9c70ARWZecURVUf79kVkO4c32c6DyKRxTYSf1/XFm/H1m0pzc4jPE6oJkbEKhTfPvagxF8TzrnsAZ/M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785045351;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=raXRfOMEUBNatKu/dd12OUtxcNp1/GlVlHMcItvi4tw=;
	b=JSroui9U2N2Ye8rEbh4BIlnDJJqQ/7hw0sOoxzDEK7/aaNxTZigk6aKDgtVn6tHP
	ZfPyhNguZ/pgfeGHS9F2fQg+xPXgcrd1BBitJIKf4lQ236fKlAk3eJclGJp4I0vsnQ2
	0UZMiLGsIgaRUNmlHluSgOEDmYIl52+6vy3N1jvw=
Received: by mx.zohomail.com with SMTPS id 17850453493021008.3102665354129;
	Sat, 25 Jul 2026 22:55:49 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Sun, 26 Jul 2026 11:25:40 +0530
Subject: [PATCH mptcp-next 2/3] mptcp: sched: do not penalise when
 receive-window-limited
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260726-mptcp_penalise_send-v1-2-84485e0e995b@mpiricsoftware.com>
References: <20260726-mptcp_penalise_send-v1-0-84485e0e995b@mpiricsoftware.com>
In-Reply-To: <20260726-mptcp_penalise_send-v1-0-84485e0e995b@mpiricsoftware.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 MPTCP Linux <mptcp@lists.linux.dev>
Cc: shardulsb08@gmail.com, Shardul Bankar <shardul.b@mpiricsoftware.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

The penalty in the previous patch shifts load off a slow subflow onto the
fastest one, which only helps if the fastest path can absorb it. When the
connection is receive-window-limited (the receiver's advertised window,
not our congestion window, is the bottleneck), the fastest path is capped
by that shared window too and cannot send more, so halving the slow path's
cwnd just sheds its throughput. In a receive-window-limited transfer this
was measured roughly 2x slower than baseline.

Gate on the application's queued data fitting within the send window:
penalise only while write_seq <= wnd_end. If the application has queued
past the window edge the receive window is the binding constraint, so skip
the penalty. Both write_seq (application demand) and wnd_end (peer window)
are standing values and neither is derived from cwnd, so the test is not
biased by the scheduler sampling just after an ACK opened the window, nor
made circular by the window itself suppressing cwnd.

Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 net/mptcp/protocol.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d31bcb9ad894..7cbc5aa17e22 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1575,6 +1575,23 @@ static bool mptcp_penalise_throttle_ok(struct mptcp_subflow_context *subflow)
 	return tcp_jiffies32 - subflow->last_penalise >= max_t(u32, rtt, 1);
 }
 
+/* Only penalise when the connection is not receive-window-limited: all the
+ * data the application has queued fits within the current send window
+ * (write_seq <= wnd_end). If it has queued past the window edge, the peer's
+ * receive window (not our congestion window) is the bottleneck: the fast
+ * path is capped by that shared window too and cannot use capacity freed from
+ * the slow path, so penalising would only shed the slow path's throughput.
+ *
+ * write_seq (application demand) and wnd_end (peer-advertised window) are both
+ * standing values and neither is derived from cwnd, so unlike the instantaneous
+ * window headroom this is not biased by the scheduler sampling just after an
+ * ACK opened the window, nor circular when the window is what suppresses cwnd.
+ */
+static bool mptcp_penalise_send_window_ok(const struct mptcp_sock *msk)
+{
+	return msk->write_seq <= mptcp_wnd_end(msk);
+}
+
 /* Halve the congestion window (and ssthresh, if cwnd is past it) of a subflow
  * the scheduler flagged. Runs in the push path under the subflow socket lock,
  * which protects snd_cwnd. The congestion control grows the window back,
@@ -1681,6 +1698,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 			    (u64)subflow->avg_pacing_rate * MPTCP_PENALISE_RATE_RATIO < max_pace &&
 			    inet_csk(ssk)->icsk_ca_state == TCP_CA_Open &&
 			    tcp_is_cwnd_limited(fastest) &&
+			    mptcp_penalise_send_window_ok(msk) &&
 			    mptcp_penalise_throttle_ok(subflow);
 
 	burst = min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);

-- 
2.34.1

