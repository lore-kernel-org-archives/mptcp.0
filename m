Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706053D7D89
	for <mptcp@lists.linux.dev>; Mon, 13 Apr 2026 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089531; cv=none; b=LXjTXpBYuEAXbsxrELyQhSpzfAoXmNwU/ZGSZShYwHfcshd3SmcjKgrCEornaP2cYluMVgrOgZYA1sntrRN4bjAPVP8BSDVSA3AhVNKj+813N0BZ5UChzo6QqVkmhQ2Qh20rqr4m7FmYYgbRGQtsVPT3t2rAcUwiCG2T3NwQm/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089531; c=relaxed/simple;
	bh=pz9+YSGv1Ha7Iy1hBwA7cLzkefbaGrM1oOz9ozAJ2BU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fcGsvK9Lw1LG/Jg7lByNJMf3HP7ysqWzjkWM0ikOWioOW+kV4aQr9Q1izLWXOFTursdVfC1ZTB0B7k4DWSC8OwNTSuKYNWSuGQcWZETUMiQ/rDddzRPwPTrV9/nOenOYi1s+3XBTA8X+GPIjHakA879/nI968yt5tRlX10heS+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOZ2HBjb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOZ2HBjb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F45C2BCB4;
	Mon, 13 Apr 2026 14:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776089531;
	bh=pz9+YSGv1Ha7Iy1hBwA7cLzkefbaGrM1oOz9ozAJ2BU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cOZ2HBjb1ZZ19PGEj7ACf7J+qzq7xw9HfqF2jIZDd5f7BcacwGNTIuo+2DX1pfKKm
	 GsltFxpxILLK0RU5vndPeym4Z772GN8pAvyFHAW1GTq0B+6bkoCuO1KlXUK5zrigPZ
	 lFdjPJOGWcRS1BkBcJgFSLk1s0Fs+6839moEiffeORlcJ2wVIgCDVHS5LZLm76gdLQ
	 +mGmMHQGKjFJ+MVakaEIAeD3dUMtmUVpayhFWVN31ulkSafK767DrHhBQsoLCO7Sit
	 3naHjUUEBFRJTdMfVHhXIm0zVFvdYju2ZoExiCxLfjcVu01V0E7Hkknx/QS8KERJ7t
	 PE3PmwrpxD5Dw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 13 Apr 2026 16:11:52 +0200
Subject: [PATCH mptcp-net v3 06/19] mptcp: pm: ADD_ADDR rtx: resched
 blocked ADD_ADDR quicker
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-mptcp-inc-limits-v3-6-dd36c9360432@kernel.org>
References: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
In-Reply-To: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1553; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=pz9+YSGv1Ha7Iy1hBwA7cLzkefbaGrM1oOz9ozAJ2BU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLv/Fwzpc9N5+VOBeVfh5ffm1X4iOf3YTHJ9sD3PnldZ
 byLRV/+7yhlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjIFXWG/wHcLzf68v33neRo
 WRt9Qm7fGo2Ub1LsB5YH9Ka75lmstmH4pz5pyV6W7j5lFbk+j9miO6Trcvguc/74NjNwyq/e9Pe
 XuQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When an ADD_ADDR needs to be retransmitted and another one has already
been prepared -- e.g. multiple ADD_ADDRs have been sent in a row and
need to be retransmitted later -- this additional retransmission will
need to wait.

In this case, the timer was reset to TCP_RTO_MAX / 8, which is ~15
seconds. This delay is unnecessary long: it should just be rescheduled
at the next opportunity, e.g. after the retransmission timeout.

Without this modification, some issues can be seen from time to time in
the selftests when multiple ADD_ADDRs are sent, and the host takes time
to process them, e.g. the "signal addresses, ADD_ADDR timeout" MPTCP
Join selftest, especially with a debug kernel config.

Note that on older kernels, 'timeout' is not available. It should be
enough to replace it by one second (HZ).

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index adbebf46dcce..0830a4d2029e 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -342,13 +342,8 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		goto out;
 	}
 
-	if (mptcp_pm_should_add_signal_addr(msk)) {
-		timeout = TCP_RTO_MAX / 8;
-		goto out;
-	}
-
 	timeout = mptcp_adjust_add_addr_timeout(msk);
-	if (!timeout)
+	if (!timeout || mptcp_pm_should_add_signal_addr(msk))
 		goto out;
 
 	spin_lock_bh(&msk->pm.lock);

-- 
2.53.0

