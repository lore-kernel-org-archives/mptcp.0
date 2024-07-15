Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A270187323
	for <mptcp@lists.linux.dev>; Mon, 15 Jul 2024 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038220; cv=none; b=BYtHIaVb6AhHySlwExpbb7PH5HLab40BlD7gjsOPjC12o2k/xYAOdYBcpq72ZzrD/WCgCRNvSDqHNY/sqJRQr/IBc3xX8C4sstg4foznDvTz+JqDGg2KxIRqcSNKe94tV/oznqNgXVlrjCXSXSBpkMuQJo/+yyggIPpJy5REdPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038220; c=relaxed/simple;
	bh=NeGnvGZJJrFKiJ4bDW0BRf/DH1jtpcLxEeaQhKnLGbU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p39IS3vKpLpYXz5YLCQKjmWy8kpvXp9cST8thU6nxjoinUhpA0QtLSgiIsWJHd857Gj8YMKJXma6SnjSJmL8S/qxCdg/Qdle8yKmyaqsV11YzTcJXzDgpGevpBrTtF8YQIXNxFA0suK48K9Hez7eiMuJbamgcfoTVU4GVeQ3XyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+hNEUsP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+hNEUsP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DACC4AF0A;
	Mon, 15 Jul 2024 10:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721038220;
	bh=NeGnvGZJJrFKiJ4bDW0BRf/DH1jtpcLxEeaQhKnLGbU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o+hNEUsPNxRf9PUS0AT1U7gvDjLbdvk0drsVEYHDAzk8TQXqUdyk+cjjqLxGh5HSf
	 Zw2K7pIi/NjnzqWJfTlU7qsctOHq2/WvRMy25xFOS1cuT7wp5u7eUCURZu+sJ56rLo
	 cw0SF6VLGTX47uWf45wkJzHURNloW2GpGJJ9HnrtUZgA5WKgTs6GsS8LPltE2zOdtK
	 W3c5T++gEbrL0SEoJR+AmqeiDcdEw51gsw1eQ0x1sTgJO/Xs9M3Ke6SM9sBBQ+ooSe
	 e5hQlN926M9rAIyIzFaTG5C/sFEPivotDXCAXX/IZoiqwTinnIxw523d3Hn1XeWfTI
	 JO0c070G9XMUQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 15 Jul 2024 12:09:52 +0200
Subject: [PATCH mptcp-net v2 14/17] mptcp: pm: remove
 mptcp_pm_remove_subflow()
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-mptcp-pm-avail-v2-14-fc5153bd1f6e@kernel.org>
References: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
In-Reply-To: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4468; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NeGnvGZJJrFKiJ4bDW0BRf/DH1jtpcLxEeaQhKnLGbU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmlPV3ZWbmm9FqzPnukLZtJ0qOhleMv4AhugAEy
 0nStEJNGAuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpT1dwAKCRD2t4JPQmmg
 c5t2EACv9Iraw/EZ2p0fl7hACxfUjK/0Jb7TMI7pFto9m/NyFJA1683ve5s4JwHnOnFj45t8jAq
 n7b4T9h+cTbzxlCHxAcKbkGaZ0kX4ozcqrS6Nqvk+FL3IHDWpoyoGlcwCulwpjqUtreIuiHrahE
 WqJgQL2cT+SkKgjX89YNZyeY6YAZ6dtXJ1Z1TlaXm/IcJElZHRaInaRDlU1L06biCS5Ezgi3V92
 q00mTuQ/H7gZXPm/OCuqExUoTPlTXejAZ8Y7ihpdhFB/s2EE+PJIloABJ+cvEsXXMo/krQdGAf0
 gb9YkcmeK8RRRiRkQodQEC7YClKEL5HsmsT3sAe0SQAah9IOnavWz+pUDt9tS4Nf21umy1bnBmH
 v4+HjOzrje5ujDnjlDes7NnspDiIyzqgoAqnRa6IFaaS3wU9uzd6K86Rkcm42PrGtjKSzVDEOZL
 iZetyN6z5eRvLm65FV1jG852rUfwcp1veBBUqbozTjC2n3kE744SpDCWXah2pJTgoOHw6dCRgbX
 +gVmVxby4NNNI7vPT3rHTGWDkC1H+I+kIdDNwlJyZJzVG3mCeI9tXs+NDRLWI7UQcGHkhgYQnNa
 /i3CWzxCxXsj0Nz2aIjCi5alpKE0xwDZ4fgH5xUYCec9czqiA6UUdUfrfTyXxliAdfm0m4F8B5F
 buWLDjk2RzVo5Jw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This helper is confusing. It is in pm.c, but it is specific to the
in-kernel PM and it cannot be used by the userspace one. Also, it simply
calls one in-kernel specific function with the PM lock, while the
similar mptcp_pm_remove_addr() helper requires the PM lock.

What's left is the pr_debug(), which is not that useful, because a
similar one is present in the only function called by this helper:

  mptcp_pm_nl_rm_subflow_received()

After these modifications, this helper can now be marked as 'static'.

Note that it is not really a bug, but it will help backporting the
following commits.

Fixes: 0ee4261a3681 ("mptcp: implement mptcp_pm_remove_subflow")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         | 10 ----------
 net/mptcp/pm_netlink.c | 16 +++++++++++-----
 net/mptcp/protocol.h   |  3 ---
 3 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 55406720c607..1f1b2617d0f5 100644
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
index 44092246259c..96336a87973f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -858,8 +858,8 @@ static void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
 	mptcp_pm_nl_rm_addr_or_subflow(msk, &msk->pm.rm_list_rx, MPTCP_MIB_RMADDR);
 }
 
-void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
-				     const struct mptcp_rm_list *rm_list)
+static void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
+					    const struct mptcp_rm_list *rm_list)
 {
 	mptcp_pm_nl_rm_addr_or_subflow(msk, rm_list, MPTCP_MIB_RMSUBFLOW);
 }
@@ -1454,8 +1454,11 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		remove_subflow = lookup_subflow_by_saddr(&msk->conn_list, addr);
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
+
 		if (remove_subflow) {
-			mptcp_pm_remove_subflow(msk, &list);
+			spin_lock_bh(&msk->pm.lock);
+			mptcp_pm_nl_rm_subflow_received(msk, &list);
+			spin_unlock_bh(&msk->pm.lock);
 		} else if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
 			/* If the subflow has been used, but now closed */
 			spin_lock_bh(&msk->pm.lock);
@@ -1608,8 +1611,11 @@ static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
 		spin_unlock_bh(&msk->pm.lock);
 	}
 
-	if (slist.nr)
-		mptcp_pm_remove_subflow(msk, &slist);
+	if (slist.nr) {
+		spin_lock_bh(&msk->pm.lock);
+		mptcp_pm_nl_rm_subflow_received(msk, &slist);
+		spin_unlock_bh(&msk->pm.lock);
+	}
 
 	/* Reset counters: maybe some subflows have been removed before */
 	spin_lock_bh(&msk->pm.lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 19d60b6d5b45..f2eb5273d752 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1030,7 +1030,6 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
-int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
@@ -1134,8 +1133,6 @@ static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflo
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
-void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
-				     const struct mptcp_rm_list *rm_list);
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);

-- 
2.45.2

