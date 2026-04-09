Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B061933D6DD
	for <mptcp@lists.linux.dev>; Thu,  9 Apr 2026 20:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775767935; cv=none; b=pUPhKnRRc20h0Jx5UAOoo8Sk+WR6WsimyZVrSz7VXDfxMeua5s2HLSFSia8OZHBZnYjy/06Xu7xw98JFVGRmi4+Y10KBxquxczjprTYwhcvpqaA4wHUbam+3VcMb5LKb66RJ1COpPfGPr7WaU/CUn7X4OYuB87g3z4ir+bb8MQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775767935; c=relaxed/simple;
	bh=1zMUF3jK59gjLBrb4ucKA1VdIV3Kwl+kiDZANk3uCjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bWvD7wRdZPX5qT59K9dN9X4bQTivAaJMmwaJgzOIs/JCeFl0t/jid5WiGxh4g8w4zHNdjr3/rv4wtR65Udiu3DNO8jOuGg5+OYJfasypXFYuwIFve4IPuOpA8TuzSkRJVJQzDMuiygmxfYFGcHqJ20G8/lt5pUBXsAt/Zu/5ZzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppWRY2Eu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppWRY2Eu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BAFCC4AF09;
	Thu,  9 Apr 2026 20:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775767935;
	bh=1zMUF3jK59gjLBrb4ucKA1VdIV3Kwl+kiDZANk3uCjE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ppWRY2EuH5uwc3CnAYJw2N1b/+PqLdjmzTWIPqtgn2bTJG020XCAfBfDegZzqL4eF
	 HR6O4pcrUguI7Gaqal6On+gbjuTafN+D+3yXk6DIW/KP8UjqaNlHFB7XZcDe+xkm0g
	 GM8CS+3s1o5NH3w2NzBMK6rI550WcGmMWOBMVs08vsOOg4/+tSZ22suwi/6nVb4krK
	 peVAJ34Mx3KbTggYtIRW6uiyXaJcsxbBz6csW3TdQfD7/W1X9/PmhsE5pbXXSnPxab
	 3pyrJpoqSIb25LXD9HsPgEdFrGKnJSg5WrZGWUMzcJ+baX9qSifnDmY3sLNxWX1KnE
	 IIgZVJw5Rqrqw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 09 Apr 2026 22:51:44 +0200
Subject: [PATCH mptcp-next 04/16] mptcp: pm: retrans ADD_ADDR: always
 decrease sk refcount
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-mptcp-inc-limits-v1-4-0e45fa30d914@kernel.org>
References: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
In-Reply-To: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1069; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1zMUF3jK59gjLBrb4ucKA1VdIV3Kwl+kiDZANk3uCjE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJvCBYK3TLhDYz8spDLcXW1RrSHfswGjikem863Mv9d+
 Drt2+zsjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIn0T2X4K5ieH3js6tpW/iiR
 2cf+rMrLK3gknHnxlLSxgeWUmXKyxYwMu73/T/5SwXCC327blxkN54pm83dumH/zvXDsqxafd9v
 ruAE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When an ADD_ADDR is retransmitted, the sk is held in sk_reset_timer().
It should then be released in all cases at the end.

Some (unlikely) checks were returning directly instead of calling
sock_put() to decrease the refcount. Jump to the 'out' label to fix this
potential leak.

While at it, regroup the conditions, and explicitly mark them as
"unlikely".

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 2cefc9b6c1b8..78a2ad71700b 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -331,11 +331,8 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!msk)
-		return;
-
-	if (inet_sk_state_load(sk) == TCP_CLOSE)
-		return;
+	if (unlikely(!msk || inet_sk_state_load(sk) == TCP_CLOSE))
+		goto out;
 
 	timeout = mptcp_adjust_add_addr_timeout(msk);
 	if (!timeout)

-- 
2.53.0

