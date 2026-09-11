Received: from sender6-of-o52.zoho.com (sender6-of-o52.zoho.com [165.173.180.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9CF3AEF51
	for <mptcp@lists.linux.dev>; Fri, 11 Sep 2026 09:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120705; cv=pass; b=s1R2MFH+uOsDdTXZUX62q5Cthpctoj8Wnd4trte8U58ssgasuvXWpdi9hM3+mHcAwUqyasa+iRXipamKqA5lMyniIcabKv20e3y4VYpnRNV2i85wIyEUx2fenxO7H0SRzDIleljTOK5Hfp831w/X0n71ey5HXgdkWiLDQ469iM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120705; c=relaxed/simple;
	bh=0dfsUC5gSaxXM6gADQHRcF4eB/0FyPmNAqUm0+CJsiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CrRRS9F4nHIXpf2h0Ff7cO47y/csz5EnejeGLSfATQcPl/Y+rQdVy8WyyBjEs0wmUbaQfKB/pbi0lwko0qf9qe/bTOGbkyIHmSjJbtpuyMCvwXVHIXtwUaCJWwg+NgFg3oD9DoEbdZKCTjlG9EkqB+444JPzbg/bbfT1MQBaK3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=fEfSVmuW reason="key not found in DNS"; arc=pass smtp.client-ip=165.173.180.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="fEfSVmuW"
ARC-Seal: i=1; a=rsa-sha256; t=1789120684; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iO9ZrtVRY1dgDQrmkdssXoqviOgEFGbChnzmCZUwg1utnqF8s+NIlOCW1/sc+opnEXz/OvmLVu4O+eW00ld9yn+0xWoGs4a9WovgBVVttyjUErcw03roBL5x3XHSqGepv7GHrlXnqnSbX8UwsTehiRq+rYpsDB4ccHy4OmEhfhs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789120684; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=C5L7rW8GyfHzw+j6WS/3A3UlQfBV8N4PPBg+exF+n6w=; 
	b=gIqagtyoZAiaAqtzviuFaM02RhGiUjpZSB7Wwwb4jCopROsijJiQDaUW/yfiYAXA59pUiC+UtEWoSnOpebl9M9tX4iD7FSrhkU3uHUU/fRB0V2ZDEm4f1HIK4jzS430mAJH718kNZm9gIsrimuKFHQVBmC2sdLszG9h6UI0mrTY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789120684;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=C5L7rW8GyfHzw+j6WS/3A3UlQfBV8N4PPBg+exF+n6w=;
	b=fEfSVmuW9cfqAvfP+XIUkIxvx//cDbJlpO+roWh61VrWrDPIFAgGq2ciWiXcZvLx
	934W/g0hCCcJ+xDRhOMwH0DLKa7r+/Ha1hH9yGtPsRfiYFJXElwr4GSzk8IhVwviGW2
	6k1vPc4/PoXPMgiQQZ7mc2Hl6HDvvkd1bD4ipiis=
Received: by smtp.zohomail.com with SMTPS id 1789120682434540.6945165920732;
	Fri, 11 Sep 2026 02:58:02 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Fri, 11 Sep 2026 15:27:46 +0530
Subject: [PATCH mptcp-next v4 3/4] mptcp: sched: do not penalise when
 receive-window-limited
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-mptcp_penalise_send_v2-v4-3-820f2be4a8fe@mpiricsoftware.com>
References: <20260911-mptcp_penalise_send_v2-v4-0-820f2be4a8fe@mpiricsoftware.com>
In-Reply-To: <20260911-mptcp_penalise_send_v2-v4-0-820f2be4a8fe@mpiricsoftware.com>
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
cwnd just sheds its throughput.

Gate on the application's queued data fitting within the send window:
penalise only while write_seq <= wnd_end. If the application has queued
past the window edge the receive window is the binding constraint, so skip
the penalty. Neither write_seq (application demand) nor wnd_end (peer
window) is derived from cwnd, so the test is not made circular by the
window itself suppressing cwnd.

Assisted-by: LLM
Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 net/mptcp/protocol.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0417bfb3db7f..24e1d6bd8577 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1637,6 +1637,14 @@ static bool mptcp_penalise_throttle_ok(struct mptcp_subflow_context *subflow)
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
@@ -1745,7 +1753,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	burst = min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
 	wmem = READ_ONCE(ssk->sk_wmem_queued);
 	/* the conditions on this subflow are re-checked on apply, under its lock */
-	subflow->penalise = burst && fast_limited;
+	subflow->penalise = burst && fast_limited && mptcp_snd_wnd_test(msk);
 	if (!burst)
 		return ssk;
 

-- 
2.34.1

