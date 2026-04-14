Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE929146D5A
	for <mptcp@lists.linux.dev>; Tue, 14 Apr 2026 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173655; cv=none; b=JeOm2aW4KMVLMEb4U4+fTSQ0ri+UDyg+DMyJDjqWrt9t/8ImQrXhfe/vidFICkA+Z5aU1hsz+2tkjM5IuPoJwMElSghmYwKMVpUrKlLN1oCFO31vBKRhUatrkzPXPPwq2sN3ury8xPEspIOLi7k6VPwAph+YSLDHt/jk8bNQjLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173655; c=relaxed/simple;
	bh=S5iyu6EcSvC9FvRM6ZNlySYLGPjU4l8BWtgnvahmpec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LuMTNX1kwhFC/yOS5k2F2WduCXYsnSsA5v5ZwY1bO7k78ad9k5/9iSXtDRcMfjQmunwrrS+SQ1cYpy7Pjbto51PamhxhoPweZAq5ZEllt3JUQShxEBPvjoMgki8H/LrShiGnsDS5BfClak9G380+Fi8sVVxf6oRIabVm0xPEfUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNdUbIlM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNdUbIlM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D900C2BCB0;
	Tue, 14 Apr 2026 13:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776173654;
	bh=S5iyu6EcSvC9FvRM6ZNlySYLGPjU4l8BWtgnvahmpec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GNdUbIlMhY9nhWiBntpgs6yau41nEKVWYVKudHhAxvWSH4Sxu6sAnxyLHs+BePeBN
	 1H+WPDAaLiSfvhVH0TuSXh3KlUHpDa2uzK3AdJn0Ima4ESujqkITcRBicDfhFaMWk4
	 1PEV9Y1ilTiw3DoKPXPJGPoNgf6r/yjrkPDDb8LM3l0pHjTxbbeDtm+h2fpASA9Cc1
	 jW8AtjENPpad5CHtwQ98iHxU9L8tmwheVjIZqgH0cK7aCff1K99PwX/S0YeE637vow
	 g0LcfwyZAc1CB8oaQWuyaJnPRN+ZEkezjLT1cdnwUWr1RQ0tgZ6Pm1c6SXZAKoci29
	 ali4wGP/Hcijg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 14 Apr 2026 15:33:57 +0200
Subject: [PATCH mptcp-net v4 04/20] mptcp: pm: ADD_ADDR rtx: always
 decrease sk refcount
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-mptcp-inc-limits-v4-4-78274edda5dd@kernel.org>
References: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
In-Reply-To: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1301; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=S5iyu6EcSvC9FvRM6ZNlySYLGPjU4l8BWtgnvahmpec=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvOXntPaS8sf3V07/lKXMe39Viad7VziK6Ztfd7OKDk
 5XnvLob1lHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCR6XMZGY58fvm3eDpL/IEX
 nydI80jckg0KnraM53DQWb5PKrzyLz8y/FOafblaJ2h7KsuMzbsW2s2a6CQ51eb0XMNNZa+1L/1
 6zcAPAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When an ADD_ADDR is retransmitted, the sk is held in sk_reset_timer().
It should then be released in all cases at the end.

Some (unlikely) checks were returning directly instead of calling
sock_put() to decrease the refcount. Jump to the 'out' label to fix this
potential leak.

While at it, drop the '!msk' check which cannot happen because it is
never reset, and explicitly mark the remaining one as "unlikely".

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v3: remove '!msk' check: cannot be true.
---
 net/mptcp/pm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6a75470dcf5e..d3fcf441b208 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -331,11 +331,8 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!msk)
-		return;
-
-	if (inet_sk_state_load(sk) == TCP_CLOSE)
-		return;
+	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
+		goto exit;
 
 	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk)) {
@@ -373,6 +370,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 out:
 	bh_unlock_sock(sk);
+exit:
 	__sock_put(sk);
 }
 

-- 
2.53.0

