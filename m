Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC6984A4C
	for <mptcp@lists.linux.dev>; Fri, 19 Jul 2024 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391888; cv=none; b=Qd8Uu/WAxe9ZNxCIOA0OzHkKyA2sOPgERlknFDWAVGhbHWVwNt7yEs/BbqE/8pCCWb4rkPl8WoAkwUkgNaY34MDMoKQ4ipwOn6qG/HhOFWlKabGUan2TSRd+r2vQOQMx9joHeVZdGvw4up0a5HYIeoAyOAzGr7tV2HR0TSkW9OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391888; c=relaxed/simple;
	bh=GEkkHViB56dUWH56K7rwfK01aIrJJch4t8GMykQ7od8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d9jsFdRIFDnP6/nqb5Ps5DWz/6A4FYVOjUgETowqaXKSxcFmKV8gWyAnaSJMcb8SLHa6FqW+kmVioC7QrbbCClUHbNeG54GCO6pKC5Uij9MuoNYPivQmN78LwgYGJl+sn8pGorOfL1q8a7cetri+fLKNH4GCxzTYZXAh+zifT88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRjFJt1/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRjFJt1/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22258C32782;
	Fri, 19 Jul 2024 12:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721391887;
	bh=GEkkHViB56dUWH56K7rwfK01aIrJJch4t8GMykQ7od8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HRjFJt1//ILJRdcTolJb8CsFbyLK9Ti5KRhCIs1pKoGSwyRRq1kVV/A9ZPy8bL3dV
	 v5Bw0JYYuDqghbvGtPHppkzEbG96k7u04ZlKCzToAlpQBO0PApNUzwHTzCxnrJstC/
	 KKFcjb1hTz7b9XJDJAXesmCn/u5yOr8hkLwGiUVZIf0K9nOd6XgfR4dlTZoumzar+x
	 Yk6qnrAWIxgQqZyHhE+Dv3f6waaynbCBAVNTAWJ+1nmDr1SXwLIghjnM+bA3vy6rL0
	 sieP4OB4RQFwJAdFl+VwyXwhGUnlO42/hEIHUYf0P8GCK7+hCkkmHemryRfSN6tULa
	 x9P60gQdIXC9w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Jul 2024 14:24:23 +0200
Subject: [PATCH mptcp-net v3 12/20] mptcp: pm: re-using ID of unused
 flushed subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-mptcp-pm-avail-v3-12-e96b5591ced3@kernel.org>
References: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
In-Reply-To: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2788; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=GEkkHViB56dUWH56K7rwfK01aIrJJch4t8GMykQ7od8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmlsAOApfGeGnPS1nX5zxJQx5kbjON7HncCdMP
 rb7EbYDC/eJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZppbAAAKCRD2t4JPQmmg
 c3tXEACv3uzCndPXG2SIhYWFE0vZK9TH8+Sz6dhmg868+Uha29skAl3YHxjTkqxlylJQSbdEXtq
 vTe6hxloFZYLTXmVQEBToX9BiIs42X9rAJsPLXjFLQ5S5Yva0nAYNdK0Ch8sgMhLmje7qQ4bMNU
 TdnMuj6/udrh/v7I6tK1EE0l2amz5VA6odwq2IWqz4O0Ij5JJBBiHvZiq4SUsPUpsKdS/BP8kr3
 7btrkP2UQUdm1zELjfCJyEBPVn+QnVb+TIzJkPhBLO1fgJfGHcKj13nxF2lCYjg+A8zg/D0MH7i
 YPsmbFa4ABCa3+ZGUqm5pIffcSxZMpd91tzcJ2QCycTJ+WGwWws96zQmrnE8cOoFJ0UXxAjCLYs
 wfMa0mssWTalPKgAuJTc+/BCFJfUFdn6uge6pNi2DvYDl1jHO+KiRttyRbobkk76N6ByhqU3uXw
 mx7Itl6KG112I1FlsK1wlhUpHvpHIzmo1U2LDh5FbClWthmeonMrZZW/bZUKjz9awF/zKxTvF5c
 3ojf96FtHLM50i+aZJ1kgeMVmWksB31vk1goqY/R6sOgHoW+wzhkPCvRiNEbzUFO1IVYLouGCxa
 ikuM09526kny+dg6YZUhf8k7ccOySf/dcctUmiOXYsNJYATl5faiccfleZAA4h3uAvXDi4HEF3+
 z18i2ed99yTjk1A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If no subflows are attached to the 'subflow' endpoints that are being
flushed, the corresponding addr IDs will not be marked as available
again.

Mark all ID as being available when flushing all the 'subflow'
endpoints, and reset local_addr_used counter to cover these cases.

While at it, renamed the helpers linked to the flushing operations to
make it clear that the intention is to flush all created subflows, and
remove all announced addresses, not just a "random" selection.

Fixes: 06faa2271034 ("mptcp: remove multi addresses and subflows in PM")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index bdbf27fe89e0..4045e5cc6298 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1586,8 +1586,8 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 	}
 }
 
-static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
-					       struct list_head *rm_list)
+static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
+					      struct list_head *rm_list)
 {
 	struct mptcp_rm_list alist = { .nr = 0 }, slist = { .nr = 0 };
 	struct mptcp_pm_addr_entry *entry;
@@ -1608,12 +1608,19 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 		mptcp_pm_remove_addr(msk, &alist);
 		spin_unlock_bh(&msk->pm.lock);
 	}
+
 	if (slist.nr)
 		mptcp_pm_remove_subflow(msk, &slist);
+
+	/* Reset counters: maybe some subflows have been removed before */
+	spin_lock_bh(&msk->pm.lock);
+	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	msk->pm.local_addr_used = 0;
+	spin_unlock_bh(&msk->pm.lock);
 }
 
-static void mptcp_nl_remove_addrs_list(struct net *net,
-				       struct list_head *rm_list)
+static void mptcp_nl_flush_addrs_list(struct net *net,
+				      struct list_head *rm_list)
 {
 	long s_slot = 0, s_num = 0;
 	struct mptcp_sock *msk;
@@ -1626,7 +1633,7 @@ static void mptcp_nl_remove_addrs_list(struct net *net,
 
 		if (!mptcp_pm_is_userspace(msk)) {
 			lock_sock(sk);
-			mptcp_pm_remove_addrs_and_subflows(msk, rm_list);
+			mptcp_pm_flush_addrs_and_subflows(msk, rm_list);
 			release_sock(sk);
 		}
 
@@ -1667,7 +1674,7 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 	pernet->next_id = 1;
 	bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	spin_unlock_bh(&pernet->lock);
-	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
+	mptcp_nl_flush_addrs_list(sock_net(skb->sk), &free_list);
 	synchronize_rcu();
 	__flush_addrs(&free_list);
 	return 0;

-- 
2.45.2

