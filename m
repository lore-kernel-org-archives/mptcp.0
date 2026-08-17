Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926884457BD
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980304; cv=pass; b=W1vf9Kf+Vn9KSl5I0akrT9XLPxHi1fJOQ6fvVvx+KdJdpbpNz/BOWBdlHyZW5ZD0/NnGKPEG5kgATteBYfFwVVItoWwouhE4cPLYZSuggw5EQC6LtfdzNhK2AEfffgCjFbITWzFUd3Br4/HmRDQWvR+Sn72JrPFZSac/R+bb+ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980304; c=relaxed/simple;
	bh=cmz+LFXRimnYZcBvePEmJn3lepx4hKH9TYoEq/anJuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oztyGKOguwF4Po3Gb312Hg0dBc+T9Y5zbAWzSMhj+eDjXfOU7utkSv6oJ7CwsSYztvFrVpVEW5Jdwxzl+hMJvzTDJ0T+DfU/uGpjdpd6sgR6oGMougzPm0sVzLL93UT8ZckJeKzWcxrGHICdRXEaaLaz+rpSOWuz32gH7bQLMPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=NSD4Tre8 reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="NSD4Tre8"
ARC-Seal: i=1; a=rsa-sha256; t=1786980280; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SJ/d6xJc32yhy+CSa0C30t849UAr7DrAzBCMRKCxP7gnFa0Al3247M6B/hSSXImmenz8w0hknASZeSjdMsJo3fwa1x/s146KrAV7XJCMeCj1/KnRvqNf7xYfsA1x5A3S7oIjrrmybclQabRduRtQtQG10mTmCpScTQHa13NSWRY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786980280; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IT1RGbSMj2olkziZrqSlVR4n7m42XP3jJUmSRWhoJIM=; 
	b=DZhsKhcdbgy3mXpD2IEkRdfnE/cSAA/yO5kPDMkxZuuxc1DMPcVaqDjAoc5jT1fuuExjWTdbna3XcsHSiFncvngUIAfz+x8bBSjyHrMI7ySrS3pNeVPUX431DAvc0DeaBSQI2qHOzjmdf0L9y+VtbkZ65LuZCsrer1HUv5+Plj8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786980280;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=IT1RGbSMj2olkziZrqSlVR4n7m42XP3jJUmSRWhoJIM=;
	b=NSD4Tre8BagSXu7Yt7YN14bNLfWbwMeJvLvFPB4gey/ufmSGZhJdkVNOEog0l52y
	3NNTYv57G3tGVNX3GdQ9vmsQ90Y/iLsGQcN9kOG0ZZH9Wc8Qfxsf9QdF7QxQxRNrhzW
	Up/6jgiK7AzGCGvEhZ6TmoXeD9+4tCGA8M1eiuak=
Received: by mx.zohomail.com with SMTPS id 1786980278812793.2591084765892;
	Mon, 17 Aug 2026 08:24:38 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Mon, 17 Aug 2026 20:54:16 +0530
Subject: [PATCH mptcp-next v3 3/4] mptcp: sched: do not penalise when
 receive-window-limited
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-mptcp_penalise_send_v2-v3-3-e6a2ad2f1b82@mpiricsoftware.com>
References: <20260817-mptcp_penalise_send_v2-v3-0-e6a2ad2f1b82@mpiricsoftware.com>
In-Reply-To: <20260817-mptcp_penalise_send_v2-v3-0-e6a2ad2f1b82@mpiricsoftware.com>
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
index 63cc6cb33044..e4d26c2dce1e 100644
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

