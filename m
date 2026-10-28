Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793186164;
	b=4miBWA2QajMmkU4NxFPPAEfGmvy+L1NTfCqIB0EJRlEy4VgrMLZKK+2vVs33Hr83ld8t
	 r1FQSvyPGC5TRNueFgQIVzgy504xeA1Dv0okjfFsr3dr87BIEy2OIHh3SN+J23Vp+YqR2
	 pSC8/eT/PWfRyxju3J2YicxCPOF+kdlQ+/dTKH67grgKXxOTMUwBY+u1aCbQ2S+L+qCXj
	 JId0Fg359AFaCcv4Otf++ZgSMNHbOVCa0jJwrmPjTbJyTfsAKDV4dOX/dDJ3ZfmWqVSZS
	 cTVBp6h79ZyqLjz4eFhS3Kv4TEhv9vYdBjTK0wPISg+jdTni+37/H4AWd3YihS7z3jQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186164;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=7XpYXcj/qNqkUVgiJRTjpAc3WBpmArFHsqKbg+J2F7g=;
	b=1l+aadilhYFo7A1FJHaOxGzuGWbbHPnBjNvtZRawYZRddeioeiKSks4XXoI5jtYDYWzu
	 6mEQ+Ofyn7f8Gx5YGkRxMoI+IVecST+736wCk9nLsfUIlQ78Tvk9w97F3WRvvtP/qB5Ri
	 8Yq/GwaBRqoUQ4CiLdm+z8L4Wejp3bgREsEGdhZDbZdV0Z/p9yz1U4Qhm41V2LW7HwKE4
	 QLsDyQ5OSdA8ebyrVyyTKsUE7opUPhjpxMdfBUM0UQWNL/GFOODVxvH5laAlHKs99jzS0
	 WYpiEkvrPCUS+abuBJP8RwoKY+K7DQz2sTckr9T1M3Z8QIbm98sDjG6XKdBqJ3dySjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.52
Received: from sender6-of-o52.zoho.com (sender6-of-o52.zoho.com [165.173.180.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112E6606A31A
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 11:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 112E6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1793186142; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AwaVFQl0/R6tbpqD1ygBe4CRLVnu8M+3hJ5eUeTnA9dtA1S3ehux1L8Hnkq4Q1g01mUtUew8+/K143aEy+AbJqB4kC9kY5X4AvPaqrr/9EtR3USUi1arUfRu+qJH/H76HNsw2WhSodkgUwMnqd2215i5XioPEEaRP3/AFyxfLOc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793186142; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7XpYXcj/qNqkUVgiJRTjpAc3WBpmArFHsqKbg+J2F7g=; 
	b=bA9tefHlOTN/nhkp/CKdw345f1yP+fhGYVAsL+cM9hYVlXcu19vtz0908uQckCUwiMGYF00LJugQJati2q0LUsQnBDP+bRxrqia69Ngfax5xKDv+slDUXxFvK5Mhd49ykSrmPR/v9xJbU+cIxZKsr28SQfI9iEpNyxbBbh4lMdA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793186142;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=7XpYXcj/qNqkUVgiJRTjpAc3WBpmArFHsqKbg+J2F7g=;
	b=at3sl37QxYVJqXb1l6M3Pm6H+/mZiAjlIkP0+fnu+Ap9spQbS+CbI3xM044PAWh+
	foY9XrocMaWKTOwIp3OpEqw2nVYQsGg8mPadO1o0IgrntY0B+jPAekOF20PCbJOxHzg
	L4qZzJQHxq2DQLf7YryXDiEQzoII1sg5X0Mm6yyk=
Received: by smtp.zohomail.com with SMTPS id 1793186141307682.1539123912338;
	Wed, 28 Oct 2026 04:15:41 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Wed, 28 Oct 2026 16:45:10 +0530
Subject: [PATCH mptcp-next v5 3/4] mptcp: sched: do not penalise when
 receive-window-limited
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
Message-Id: <20261028-mptcp_penalise_send_v2-v5-3-32fb379ce117@mpiricsoftware.com>
References: <20261028-mptcp_penalise_send_v2-v5-0-32fb379ce117@mpiricsoftware.com>
In-Reply-To: <20261028-mptcp_penalise_send_v2-v5-0-32fb379ce117@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Janak Patel <janak@mpiric.us>, Kalpan Jani <kalpan.jani@mpiricsoftware.com>, 
 Shardul Bankar <shardulsb08@gmail.com>, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>, 
 Abdul Wasey <w453y.me@gmail.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

The penalty in the previous patch shifts load off a slow subflow onto the
fastest one, which only helps if the fastest path can absorb it. When the
connection is receive-window-limited (the receiver's advertised window,
not our congestion window, is the bottleneck), the fastest path is capped
by that shared window too and cannot send more, so halving the slow path's
cwnd just sheds its throughput.

Gate on the application's queued data fitting within the send window:
penalise only while write_seq <= wnd_end. If the application has queued
past the window edge the receive window is the binding constraint, so skip
the penalty. Neither write_seq (application demand) nor wnd_end (peer
window) is derived from cwnd, so the test is not made circular by the
window itself suppressing cwnd.

Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
Tested-by: Abdul Wasey <w453y.me@gmail.com>
---
 net/mptcp/protocol.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 395f9582ece8..5eef96fa4f3e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1642,6 +1642,14 @@ static bool mptcp_penalise_throttle_ok(struct mptcp_subflow_context *subflow)
 	return tcp_jiffies32 - subflow->last_penalise >= max_t(u32, rtt, 1);
 }
 
+/* Like tcp_snd_wnd_test() but without an skb: true while queued data still fits
+ * the send window, i.e. not receive-window-limited.
+ */
+static bool mptcp_snd_wnd_test(const struct mptcp_sock *msk)
+{
+	return !after64(msk->write_seq, mptcp_wnd_end(msk));
+}
+
 /* Halve cwnd, and ssthresh when cwnd is at or above it, under the subflow
  * socket lock: the scheduler only marks a candidate, the conditions on this
  * subflow are evaluated here, on current state.
@@ -1750,7 +1758,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	burst = min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
 	wmem = READ_ONCE(ssk->sk_wmem_queued);
 	/* the conditions on this subflow are re-checked on apply, under its lock */
-	subflow->penalise = burst && fast_limited;
+	subflow->penalise = burst && fast_limited && mptcp_snd_wnd_test(msk);
 	if (!burst)
 		return ssk;
 

-- 
2.34.1

