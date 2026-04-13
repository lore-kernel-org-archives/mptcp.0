Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4509B3D7D89
	for <mptcp@lists.linux.dev>; Mon, 13 Apr 2026 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089528; cv=none; b=H0Uapbm5nUDJSYKZu1ejYl1Rwg6OoEA9Ro0qcMbjwHly9DI8uEp3BJ+wvq4lrDiymtXf0sQJYyhrJ9RZqqsz/dJLzfJukX94UT8CSt1qrJWy94eJ+/RlGpChFgaLBr/ZxJqDoxYPsumhxBPVfPB0KP/a699vvQFA0RHWzQmjHNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089528; c=relaxed/simple;
	bh=xqQ0XziJocJK+T47pPjFZrFCFv0UNP98JJxxWrafiv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EOkFS8KA0bxrORoS5ownrGlPyL2fn+16SlmTDgGnSieZydgeO/MfYHLgVlEu7UxfYgcRM4m47SuQV0Vdi/BMTrsLNhI1PJfJ3kpZC7dlW58p9GeWxGJ6Oirp31pY3f3hB4vdC/tFvwu5hmsHZH0UTU2q+bWsZWcsn3iCuuSYdHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jr/GvlOQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jr/GvlOQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9347DC2BCAF;
	Mon, 13 Apr 2026 14:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776089528;
	bh=xqQ0XziJocJK+T47pPjFZrFCFv0UNP98JJxxWrafiv4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Jr/GvlOQr+ty3qHKYGI/bb0HtpXX344vBfuG+eaEV9RSF15AkhmQgQxWgsEJZCDq/
	 vJ/HhvpecfSAVlaSWq0dMW18ox1uLSo5YmsIcfqNFTIIZQFs+R7wCjcGWwkkgTLVpe
	 Zh2X+QnD8nZFesYAjEzB8oR6hdRXbYMfxjpoN776w4PX2A1wlLlpbUcd1KVt47d6hK
	 mte+IZzs6ChK6Omi6NW76TUuRTBo7uRoxyseq/k/9q9AXDS4o37M6pm3nFH6hqjwbh
	 nd86y3fj2Qy/EoB78WN1SdWNDJDKBBpG+tbak+3sgjQuRKWKoPj+WvuPc5zm3aOcGg
	 k38ODakQJda1Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 13 Apr 2026 16:11:48 +0200
Subject: [PATCH mptcp-net v3 02/19] mptcp: pm: ADD_ADDR rtx: fix potential
 data-race
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-mptcp-inc-limits-v3-2-dd36c9360432@kernel.org>
References: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
In-Reply-To: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1180; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=xqQ0XziJocJK+T47pPjFZrFCFv0UNP98JJxxWrafiv4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLv/Fz5MHgl/yqLVYXCa3LyX9wq/fAzm9O+nuGPpDvjG
 q8Tu1N+d5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzklzDDPwWBPdv035z5mf03
 2VfUcdVSo48pD8X6mVyUlaRsG/KtHjH8FTDQL1l781Xdv8ppqrMTrtuqrFQxj65fMadHSjPM3zq
 dFwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This mptcp_pm_add_timer() helper is executed as a timer callback in
softirq context. To avoid any data races, the socket lock needs to be
held with bh_lock_sock().

If the socket is in use, retry again soon after, similar to what is done
with the keepalive timer.

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index fdadd0e8f77c..43a11b65235f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -340,6 +340,13 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	if (!entry->addr.id)
 		return;
 
+	bh_lock_sock(sk);
+	if (sock_owned_by_user(sk)) {
+		/* Try again later. */
+		sk_reset_timer(sk, timer, jiffies + HZ / 20);
+		goto out;
+	}
+
 	if (mptcp_pm_should_add_signal_addr(msk)) {
 		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX / 8);
 		goto out;
@@ -368,6 +375,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		mptcp_pm_subflow_established(msk);
 
 out:
+	bh_unlock_sock(sk);
 	__sock_put(sk);
 }
 

-- 
2.53.0

