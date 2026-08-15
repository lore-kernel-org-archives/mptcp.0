Received: from sender6-of-o52.zoho.com (sender6-of-o52.zoho.com [165.173.180.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F261423EB7
	for <mptcp@lists.linux.dev>; Sat, 15 Aug 2026 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786805298; cv=pass; b=TzwAFh1fDKahZyRIHOuxZqTJhzflZQG1HYENmM6l7QVZ1MgJVji7oihMS6s5CAUdECHIdqKL/N/6KikF8ceJttrYakk/5BftNexApGOZpiXqxlXagLWPqaLBbZVip/qXrRBwSq8yu/utn/B272iRRtoTL/9YGwzuFJ1rbTKXkxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786805298; c=relaxed/simple;
	bh=t4JpLva6E6l2BnwRPzP2IlLO5OtEFujlYYzI0JPwZAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UYHMTutBtDyvUs7o3yPJHTIGk5G0i1V5fIV8kz8bL94EZW9oI8Cab2khWsi8Y8y6H+hHG4X+bcmpZNj4fpxT42G7GWnmi73RxdbWSqrF9mRRe2nW98NIeUyshwsUoITuxF5r+HBkr459rGih3zWLsQpkiZMoLbfuio8qLViBzXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=Ko2A2C8N reason="key not found in DNS"; arc=pass smtp.client-ip=165.173.180.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="Ko2A2C8N"
ARC-Seal: i=1; a=rsa-sha256; t=1786805243; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HqO6cCkgTK8igH7hWyOJ+bmEdLBhaMmF1a4JQp0UAgO8IIuwjEufaTu5fRqD3ZslktrB0kFeh18EinQDF39j0bwrkDP/1UB+/wb7DhnkHnyISf4aJicUNuKjeEmo/vRwzBgmx1azRS437fNPszBAYkkn6+dmCrcnwdTvugakdf4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786805243; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qWdhoWKR7tU5pg6MP7NlJrmFtlYl5a3eVxPTsQcJsUY=; 
	b=S5xG6uB8IMV3IP7LlOqSLP1SS0A/YtS4om2UiQ4Bs8tZjcNdiFOHMPWfcFErGhpskmG08/kTcSilRUKKpnoAs6J0gekG+kGtMZR4AOQGK9i5dP712xV9bbLXgIB1P9KoVWwWZzhnvvY3+Bzm3cdMoI0dB0/a2lW9PoFTRA/CkzY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786805243;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=qWdhoWKR7tU5pg6MP7NlJrmFtlYl5a3eVxPTsQcJsUY=;
	b=Ko2A2C8NhIoCYe9Wrzj0wH4Rv236KA4aq3Ny+CrhWX0F7ffk/cqknjtNrvy1o2gU
	jo0jzTtd4FO+uciNf5m60USdCqNACNZy/Bb64LqbehTDD6e+kOrUUhHM8dVV5cL4XsW
	w/kkg4b5CliFU8CjfMiL2l5qj1K9LMDnXSKpFb1s=
Received: by mx.zohomail.com with SMTPS id 1786805241454889.9099580751931;
	Sat, 15 Aug 2026 07:47:21 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Sat, 15 Aug 2026 20:10:16 +0530
Subject: [PATCH RFC mptcp-next v2 3/4] mptcp: sched: do not penalise when
 receive-window-limited
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-mptcp_penalise_send_v2-v2-3-3e5049a73681@mpiricsoftware.com>
References: <20260815-mptcp_penalise_send_v2-v2-0-3e5049a73681@mpiricsoftware.com>
In-Reply-To: <20260815-mptcp_penalise_send_v2-v2-0-3e5049a73681@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Janak Patel <janak@mpiric.us>, Kalpan Jani <kalpan.jani@mpiricsoftware.com>, 
 Shardul Bankar <shardulsb08@gmail.com>, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>
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
the penalty. Neither write_seq (application demand) nor wnd_end (peer
window) is derived from cwnd, so the test is not made circular by the
window itself suppressing cwnd.

Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 net/mptcp/protocol.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 075d468d0e14..e6c10816df8d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1635,6 +1635,14 @@ static bool mptcp_penalise_throttle_ok(struct mptcp_subflow_context *subflow)
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
 /* Halve cwnd (and ssthresh if past it) under the subflow socket lock. */
 static void mptcp_penalise_cwnd(struct sock *ssk)
 {
@@ -1735,6 +1743,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 			    tcp_snd_cwnd(tcp_sk(ssk)) > MPTCP_PENALISE_MIN_CWND &&
 			    inet_csk(ssk)->icsk_ca_state == TCP_CA_Open &&
 			    tcp_is_cwnd_limited(fastest) &&
+			    mptcp_snd_wnd_test(msk) &&
 			    mptcp_penalise_throttle_ok(subflow);
 
 	burst = min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);

-- 
2.34.1

