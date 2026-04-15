Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AF833E34C
	for <mptcp@lists.linux.dev>; Wed, 15 Apr 2026 09:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247092; cv=none; b=S6UoZrVp/LrAtiWULRIqrvynVfJ/fwI7XQ7H8lyPInE3do1ya9HxFVIQlcVeLVKJJqzOCP6MUJ0UhWG34jxpd4lk4iq09we8pPkoWv8I4FqLIhy7ZLgLEHYtAAIJDdTM6zNGIvG/MfX7IDZ8dwrVKcQGsdVLVnyXhfgRtasNz7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247092; c=relaxed/simple;
	bh=xqQ0XziJocJK+T47pPjFZrFCFv0UNP98JJxxWrafiv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TbpaYCHqz931UdhAlYc+JYL6oJXax+CzIWjCtfPtUn1r3JsVZbLPJDEqMF5pcuCyzx4FV0PfvwO2ztdqV/jEO5gu2xsUcT4Nz5LC7Z8pA8pV9oBI0qr7GGeDdJmER18MJ0gJXtlnIi8ELlDEYztxqUmeb7IkIC/cLiXLtyTh3D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZbB2LFD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZbB2LFD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6873C19424;
	Wed, 15 Apr 2026 09:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776247092;
	bh=xqQ0XziJocJK+T47pPjFZrFCFv0UNP98JJxxWrafiv4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iZbB2LFDwenNnnxtLIDEphLz61SzEB96tV7nvw4B544Vm7TAzUyMJ8HJzMQEXg2rX
	 gEm8DkgMQ5iYxVmw8oSv85z35+bI0ZDmW7AWMwRoY6haACNGOrHgHckExNx+vcZMav
	 z2tUvUO7KK3tWen6mTGAvLAoU7+5GDXi7gmg5jCMDvRzCMQnAtWrlbsyVKye7/9bKe
	 UmzYSdU7cKKpPD5lBzDcUE6scvpMM3BgfLFfydBpC7J5iP+BkX6djCdOsV0zfvth5A
	 Z3GkCpavBuryHStDDbdQ2KSycu3/ZFgVv05c+4vfZt91BfSl6Oi8R7OE5kWfR6wEJI
	 fd/rhbRvw5pmA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 15 Apr 2026 11:56:50 +0200
Subject: [PATCH mptcp-net v5 02/20] mptcp: pm: ADD_ADDR rtx: fix potential
 data-race
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-mptcp-inc-limits-v5-2-e54c3bf80e4e@kernel.org>
References: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
In-Reply-To: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1180; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=xqQ0XziJocJK+T47pPjFZrFCFv0UNP98JJxxWrafiv4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvJ6q8q7zKN/NBKPv9S9PVPnw/Wv9rzueblWpuc8Wa7
 +6dyrwyv6OUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAiN34y/GaPtjY7nHx966wn
 TwPYwh+oChY/CF8ns2TCd121svdcez4xMjzdnLO8t97evFPhu0NzpFfmo/kCaqWy8YsMOi68Ujv
 IwQUA
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

