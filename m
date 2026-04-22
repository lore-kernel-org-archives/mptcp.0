Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5926365A0F
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876044; cv=none; b=gaIBXQkcM2towRqU1YqjNMhBXkDy/cEq3CIRWVPDyxS8T7CtFgtMReAW3N+og8Jqz6Uf5V2cp4wFt6mjbRPIYGrvrVSk83H9Ib0LhR/CBdykSYRcNQai5a8bxB5W+xWK3v56e0UZmytsEhfZjKrPRujcOYAxr2bFsYKzXkC833k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876044; c=relaxed/simple;
	bh=YaUoNwWc4T0lMld1JWK+eGKwdSoPd1hIyBf1vdS9WYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DFhyNSoYhjMq7BAnAC1TYj18zPeY1jaeQMasvc1BdwW72FQpUJ1ZsKSIWR+gSZqEyuA2B0QolNKwqSwOypChmOgAXw52VFJtbjrjRtnuHhzpqzUMbsMr1IkW5VsDqtrH9LyaNfCB6bYwtrq75I4QKEcQTXKYG762OvxcEtY23rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aihwJI8m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aihwJI8m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B47AC2BCAF;
	Wed, 22 Apr 2026 16:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776876044;
	bh=YaUoNwWc4T0lMld1JWK+eGKwdSoPd1hIyBf1vdS9WYM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aihwJI8mx3iZzqGB9bnNzWUOKbv4TNmMcz2DI8w/1z4m02btq29uitqPEpGh8U3S2
	 xUJUWN8V1BSNQbUcXDERTLcrrbo9Sy2vnuI/ik0FYEPOiqOxw2chwtUxU30HXz70N3
	 jMabG1uHr5R9OSFXUAmlBt8WK5cM6yIVhYC14IS4DKoLBT4Wo09RuJKylUBddlrgbM
	 2SIcgIgiYOZONNZzyoYzJJUZhH2JBZS4kKW+jRPCjJCizs1upWnJ5PfGJ38KsQTDCZ
	 BJe1o2S0lzENqtmAkufpQt43H9G1xB6bz0W2o6xNbGBMk4vpJsR3J83A3DVsAVtsAM
	 EYQH/2mVpMGfA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 Apr 2026 18:40:18 +0200
Subject: [PATCH mptcp-net v6 04/19] mptcp: pm: ADD_ADDR rtx: always
 decrease sk refcount
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-mptcp-inc-limits-v6-4-903181771530@kernel.org>
References: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
In-Reply-To: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1376; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=YaUoNwWc4T0lMld1JWK+eGKwdSoPd1hIyBf1vdS9WYM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJf/Pxzv+C96eFN/AuXG/2sZLLay65lqPJ2A5vPpo8JE
 //cPfzsY0cpC4MYF4OsmCKLdFtk/sznVbwlXn4WMHNYmUCGMHBxCsBEWtYwMtw923flm+mOiS4v
 voiJn1+Ydjkg/XrwhG3nM4+UrJNSXc7G8D88YGHq7wObT3obGXW23Si+dvlgxYpjbs7JXauZmWU
 TTbgB
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When an ADD_ADDR is retransmitted, the sk is held in sk_reset_timer().
It should then be released in all cases at the end.

Some (unlikely) checks were returning directly instead of calling
sock_put() to decrease the refcount. Jump to a new 'exit' label to call
__sock_put() (which will become sock_put() in the next commit) to fix
this potential leak.

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

