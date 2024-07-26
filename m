Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266FFEEB2
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004130; cv=none; b=qVp4eMSeDOWjNL0CeTTFKCnWewMVn4PZ/BfA3ZVqDXNu0jXsrRttHGnb1dZOGf8AYEKMKWUIjm+VKWeeVOpyQtfHOPxEEqnXXQupvrM2zaBmCIRTayelTlJuteyTbUQgyjZFIe9X+JBQMJ7eLqf568FPW6xtabTghR5yVZU7M9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004130; c=relaxed/simple;
	bh=sPiZ4PtHi6ZHR1jkDYs/2XAKG+CEANH5UapQtJm1yuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vDCZTJGH5GGGXuaFOMev5VZLrSh7jVHI8Zxmdt6dQqPM/H7u+f3COvLwGoqDwg6AEeq9r9et62IN92pTaIpIvFFa2ddpL62MY+8gpCN0EbnIE+wRiFEPTcnlxkssNv+eMRKaV+N9cAugw30r6U+BSLkNpRsnKDYp/2Jflp0O38Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBTgbonB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBTgbonB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A49C32786;
	Fri, 26 Jul 2024 14:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722004130;
	bh=sPiZ4PtHi6ZHR1jkDYs/2XAKG+CEANH5UapQtJm1yuI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aBTgbonBMrTxceoGKBmZVtRRIUz5GfqEv0veeUlNLncRQE+KTsf8nsDo3SkXEXgeM
	 CgpkEdRasb5MHyqqVTXehuxcuWlDLjwubvTsKYAQT5XUbpJ0PEUTBsN+4jAykJVx8q
	 u4/9DY939Sv2uVmeJy1kVneRnFa8cUmGtraQj039V+K77BNjl85u/XIiwVBPjegmn1
	 BgoSMYU49em4PZOpSmGGxCrKMq0h06yILaxaGktMbnTG8icABuvsBqGiPOmD9EBJdx
	 Ba8eqgq6gbjFX87wKtUG/11Hotl+VkWVMd89Rq38wD3PQTKgbI/kIVp8gALyLLtmwc
	 k0FDNkZ5lsJJw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Jul 2024 16:28:29 +0200
Subject: [PATCH mptcp-net v5 03/13] mptcp: pm: remove
 mptcp_pm_remove_subflow()
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-mptcp-pm-avail-v5-3-fb1117ddeef6@kernel.org>
References: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
In-Reply-To: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4829; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=sPiZ4PtHi6ZHR1jkDYs/2XAKG+CEANH5UapQtJm1yuI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmo7Kcsyw7drjoZHwZel80XSZ6J0LdAUF6FUEuT
 DMI5JnfgZWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqOynAAKCRD2t4JPQmmg
 c7jLD/4n6k1p7LqrGoWNstOdmYtyjly/BACT3cRM+5Zky3P2KrKQgQ5E0GK7l93X4TcHt1qyPpD
 BMf1NVRacuppBQ0T27x7DVYxwssZrKQG6aIjxyQE/b1Q+8Nn+e1SN9voAiKpvxQIxacWDO2ef1y
 UOQn+ZJXpQE5Y9VhFZg+ISm1oLjH+Gc4FzylZE0DtIE14i8dkUoFyQ6pz861/fJEVk/8SfLaMct
 ctHpkQsgGTPrl4Rw+WfdMGbhXPwv8dEG62NzHZ8CurjGCJSj+livRT9/HN7FgeUpl1FskF4KVyx
 U98UULBKvW+Y1wHV0XY/wWTtYRNQeCWwJ2zKATfw432CrXnxjFmGSxL83z/B3TbtP8OO3v4zmWz
 k5CdZk5TUyblU+odytYxVmYagaLwYFcblhFKCwWeL5fwLZz2l+ApOPUhGVGOx4Vwg2pTHldkeYK
 dp4cMuOMDRpmc2zmvfkTNlJfzZRwLRP3Qa9rBlmL0H4QiI9nzKbDCjsg9gQgqur0oHJfqwuui/n
 a+mPsEz4pv6+QF00XKS4ev91oWOfXlj21cr3A920a3cSJTgNoarG+CrSCzq9fsF7qOfntTYAMAJ
 ooKvzn62CEGfSGarsRqivpnon9WBiSx/KJJ5YfCZqd/FsQa/ilsbiBVgyliYZhKj1gC9FMN+NHi
 fCezhcOfsQS/7EQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This helper is confusing. It is in pm.c, but it is specific to the
in-kernel PM and it cannot be used by the userspace one. Also, it simply
calls one in-kernel specific function with the PM lock, while the
similar mptcp_pm_remove_addr() helper requires the PM lock.

What's left is the pr_debug(), which is not that useful, because a
similar one is present in the only function called by this helper:

  mptcp_pm_nl_rm_subflow_received()

After these modifications, this helper can be marked as 'static', and
the lock can be taken only once in mptcp_pm_flush_addrs_and_subflows().

Note that it is not a bug fix, but it will help backporting the
following commits.

Fixes: 0ee4261a3681 ("mptcp: implement mptcp_pm_remove_subflow")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - v3:
   - New line before 'if (remove_subflow) {' moved to patch 10 (Geliang)
   - One PM spin lock to remove address and subflows (Geliang)
---
 net/mptcp/pm.c         | 10 ----------
 net/mptcp/pm_netlink.c | 16 +++++++---------
 net/mptcp/protocol.h   |  3 ---
 3 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 23bb89c94e90..925123e99889 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -60,16 +60,6 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 	return 0;
 }
 
-int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list)
-{
-	pr_debug("msk=%p, rm_list_nr=%d", msk, rm_list->nr);
-
-	spin_lock_bh(&msk->pm.lock);
-	mptcp_pm_nl_rm_subflow_received(msk, rm_list);
-	spin_unlock_bh(&msk->pm.lock);
-	return 0;
-}
-
 /* path manager event handlers */
 
 void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int server_side)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 00b3184be45b..8a28fdaf3bb6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -857,8 +857,8 @@ static void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
 	mptcp_pm_nl_rm_addr_or_subflow(msk, &msk->pm.rm_list_rx, MPTCP_MIB_RMADDR);
 }
 
-void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
-				     const struct mptcp_rm_list *rm_list)
+static void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
+					    const struct mptcp_rm_list *rm_list)
 {
 	mptcp_pm_nl_rm_addr_or_subflow(msk, rm_list, MPTCP_MIB_RMSUBFLOW);
 }
@@ -1473,7 +1473,9 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
 
 		if (remove_subflow) {
-			mptcp_pm_remove_subflow(msk, &list);
+			spin_lock_bh(&msk->pm.lock);
+			mptcp_pm_nl_rm_subflow_received(msk, &list);
+			spin_unlock_bh(&msk->pm.lock);
 		} else if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
 			/* If the subflow has been used, but now closed */
 			spin_lock_bh(&msk->pm.lock);
@@ -1619,18 +1621,14 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 			alist.ids[alist.nr++] = entry->addr.id;
 	}
 
+	spin_lock_bh(&msk->pm.lock);
 	if (alist.nr) {
-		spin_lock_bh(&msk->pm.lock);
 		msk->pm.add_addr_signaled -= alist.nr;
 		mptcp_pm_remove_addr(msk, &alist);
-		spin_unlock_bh(&msk->pm.lock);
 	}
-
 	if (slist.nr)
-		mptcp_pm_remove_subflow(msk, &slist);
-
+		mptcp_pm_nl_rm_subflow_received(msk, &slist);
 	/* Reset counters: maybe some subflows have been removed before */
-	spin_lock_bh(&msk->pm.lock);
 	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	msk->pm.local_addr_used = 0;
 	spin_unlock_bh(&msk->pm.lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 23dd0ecd5fbc..fcf6983ca555 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1031,7 +1031,6 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
-int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
@@ -1138,8 +1137,6 @@ static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflo
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
-void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
-				     const struct mptcp_rm_list *rm_list);
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);

-- 
2.45.2

