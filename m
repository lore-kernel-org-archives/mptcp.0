Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2882D978A
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 05:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779169890; cv=none; b=FKakjY/qKRdKvv5t8VXTC/bt8ywy3+58xuzjeJlK2zd6tSXNftU1mI+5MkB5N8Crt0FXETY8sNcS0OdnyR2u4a4vc6UP+z2AnSoPyvZ4pm8YKJrf5LpU2Zoh10qt3+hh+CfcXv1QXFLbcoP6aswgxtzZoYtHXYqrj0gQcSigrtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779169890; c=relaxed/simple;
	bh=BUBJFOKKtYpmgaTwRUJRumpM/v3hBDO/QE/kL8Qf7j8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ANkNVGL0P3I7Nn0GYU1pQ9meN7bFd2mZC34k7+MMag91S+Lnc1AfgQamLPiYwKe+HvQZ64UcUNsYlDxwtxaZi+PkQ9MVmWHT9qrR01vg41VjOWFGdrp+H0XHkPO+Zk1/mO1qG15eWukztfsE7ZBWsfA3L2zqh8gdAZhCUZECU/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TymwlkDf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TymwlkDf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDC2C2BCC6;
	Tue, 19 May 2026 05:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779169889;
	bh=BUBJFOKKtYpmgaTwRUJRumpM/v3hBDO/QE/kL8Qf7j8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TymwlkDfSxj6UMYK9WtSbGmJtrP3H1tv+Uds+Ub6pMrhvpqwG33kZVNw67R3r3B87
	 tuKIQwDmGq8oz5x5xPtg/q72FUY+g0cKFW8iUi0CKYpky2y2C3paM+mn78+3hztCKK
	 Zp9Qw2NyBKg4I67pmXzD9YJhd6xm32yzUCod8Xe566GR7+o6CtUWjy/jWjy79AfNgf
	 TSHm2p3xTpuLuVFZUPD2N/L3frD9upO+YgV2Qj9n8z1S2WhI5rTvm+5Uq9bmoh8wWq
	 k7o+ZqdWJlpoEoXuTjNz/niGirktF9x0GMyAjNJzOos6SrrUcsqHpNBag4sn8LVgSG
	 9G+fb3dddCgAA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 19 May 2026 15:51:21 +1000
Subject: [PATCH mptcp-next v2 12/15] mptcp: pm: remove add_ prefix from
 timer
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mptcp-add-addr6-port-ts-v2-12-3b36a51e6a86@kernel.org>
References: <20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org>
In-Reply-To: <20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2718; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=BUBJFOKKtYpmgaTwRUJRumpM/v3hBDO/QE/kL8Qf7j8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqC/pSJsGhJBEc9/oMzAu5wej3yahcbndw60GmP
 bg8uIq6N02JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagv6UgAKCRD2t4JPQmmg
 czW0EAC8iZGP7wgOu9dehMJdNiF5b45Gp0IrcNS8/f1h5x+E8RLGuTMtB7ncQyfZ81sqJArZHMm
 gW91I6pt2jBauXLx7yI5wWXoMFB+uoHcpVNR2DpfeN5YPvzBQa7RU/I1suQfy0Iw7jsHZJGQrVg
 bTAynEF9ZmJkT8FYi8ApwMcyQb+HHW3TCciY9e+Tc5WIl9EJ+hQRKvws9LPvKVal0NNxbHRm1my
 n/mNoszLA9/ckzSC+C94O8hr2YdfLzIlKCN5N4oEbtcpIcYcYtN7u3IDgPuVY6Oc5MuGtNzc3ZQ
 w692nYNUFg73rMpd0xURu7Z1DJZkyGBrLB4fC/lZ2ZvMwv0Twyggj6hXlLs9jHiUuMwkbir1n/M
 874RCOrEKamU+wTopGVwZPvoISByMv/A685Qv1deKCVaWIVTdnTrV8Snc1Sq1xCKT+IXMg2RNzo
 XxM1jjDd/QdDGNEJqnktCmeXlAjBPlvFoJ1xgoxMdKAFHyQL0V5lNV0oE/j4BdJKYbiEvzINFn5
 L8Ofo613GqiSxLGPBqVwGhiCAyVU1NyjMfyfoh8d6wqBhJjsvPA6Ddjo9YCYsWWwl3C0Ev8sEd1
 YmyBriM+fEePyFkrCnRZ1wkz29nLlDnw08M0JPYIuudUALFH6w6e1ZTh1ZWcbC7LYWjE9v0VX8w
 0Ky01XAAH6WL7ww==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Similar to the two previous commits, using the 'add' prefix is
confusing, also confirmed by [1].

Now that the structure has been renamed to include 'add_addr' in its
name, easier to know the timer is linked to the ADD_ADDR, no need to
add the confusing prefix, or an unneeded longer one.

While at it, also update the ADD_ADDR timer helper to clearly specify it
is linked to ADD_ADDR, and it is not there to add a new timer.

Link: https://lore.kernel.org/20251117100745.1913963-1-edumazet@google.com [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 580cf953cf92..ee510071b4b4 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -17,7 +17,7 @@ struct mptcp_pm_add_addr {
 	struct mptcp_addr_info	addr;
 	u8			retrans_times;
 	bool			timer_done;
-	struct timer_list	add_timer;
+	struct timer_list	timer;
 	struct mptcp_sock	*sock;
 	struct rcu_head		rcu;
 };
@@ -338,10 +338,10 @@ static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
 	return rto;
 }
 
-static void mptcp_pm_add_timer(struct timer_list *timer)
+static void mptcp_pm_add_addr_timer(struct timer_list *timer)
 {
 	struct mptcp_pm_add_addr *entry = timer_container_of(entry, timer,
-							     add_timer);
+							     timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 	unsigned int timeout = 0;
@@ -411,7 +411,7 @@ mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
 	entry = mptcp_pm_announced_lookup(msk, addr);
 	if (entry && (!check_id || entry->addr.id == addr->id)) {
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
-		timer = &entry->add_timer;
+		timer = &entry->timer;
 	}
 	if (!check_id && entry)
 		list_del(&entry->list);
@@ -459,12 +459,12 @@ bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
 	add_entry->sock = msk;
 	add_entry->retrans_times = 0;
 
-	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
+	timer_setup(&add_entry->timer, mptcp_pm_add_addr_timer, 0);
 reset_timer:
 	add_entry->timer_done = false;
 	timeout = mptcp_adjust_add_addr_timeout(msk);
 	if (timeout)
-		sk_reset_timer(sk, &add_entry->add_timer, jiffies + timeout);
+		sk_reset_timer(sk, &add_entry->timer, jiffies + timeout);
 
 	return true;
 }
@@ -483,7 +483,7 @@ static void mptcp_pm_free_announced_list(struct mptcp_sock *msk)
 
 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
 		if (!entry->timer_done)
-			sk_stop_timer_sync(sk, &entry->add_timer);
+			sk_stop_timer_sync(sk, &entry->timer);
 		kfree_rcu(entry, rcu);
 	}
 }

-- 
2.53.0

