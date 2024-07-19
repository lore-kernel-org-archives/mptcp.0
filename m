Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5423A83CA1
	for <mptcp@lists.linux.dev>; Fri, 19 Jul 2024 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391890; cv=none; b=ihj/iNImq3+NQv+WOsY3TVh6Y2nQSxykVMjBY1VEyDIeZTA7IW+q9EmCf0rK9A3/KRYbXpzoNnYYkVIxqZ6pv83lzmLHfVi9ejvfSGtsQOO6akentVFTWdmITyqNLnMxiB3F3/xJspeoSoPemrHWjf3BIYhG3BZ52nyuZVAjfOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391890; c=relaxed/simple;
	bh=DPCMP4eWODT9nHLLzAjsnvSTdaXqPhdwWCvENtknObE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c5l7fV93J+xhGt863C9RxAgvkWA/3kT2JO1dESvI7aPvhczY74bcOK5XRQ/w+4cSHyOaKx2pxpnvMoxH93+xnAd62YFoJoDeeS1tl11JSdBlUOe7aHskWhU0L4ZCm5Osvi33ik0sfEdHoayr6ctCYMZyZ/xnAbsZOGQkedoW/Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVHxhs/V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVHxhs/V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789C9C4AF09;
	Fri, 19 Jul 2024 12:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721391890;
	bh=DPCMP4eWODT9nHLLzAjsnvSTdaXqPhdwWCvENtknObE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RVHxhs/VSWFCfsS+DJxB/9FnagM5tkqKbS8amCBf3qHHMGxBd9X21vM9WkhecCIX0
	 6vLF8RswzZmiVpidOZ1kQtZ7GOldTyy+8wH3AeIEwe2UZe8Tp14a8qYmELS6+Xyw0h
	 DLBLwE+qor3vmS7NoGDMwDGnz3bdnj0pz+bOChQipmpFiAWCb8E8BsAYOaiS0So1+E
	 M18hT9Bna9ckUolV7lXrqigOG2klmc7A2WR5y5a7GwUrzgn6n+d1k9+mEpRAL2ph0T
	 EoKjnVkBX4Kd5rM3Q3htSyC8ho4nkdgMurMjCoYrxg0WFpT8zlhReRU18m20n6aNI+
	 Xu9Ny+DzJVi3Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Jul 2024 14:24:25 +0200
Subject: [PATCH mptcp-net v3 14/20] mptcp: pm: remove
 mptcp_pm_remove_subflow()
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-mptcp-pm-avail-v3-14-e96b5591ced3@kernel.org>
References: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
In-Reply-To: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4828; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DPCMP4eWODT9nHLLzAjsnvSTdaXqPhdwWCvENtknObE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmlsAyoqM4dmUPOe1pqH6oWFZjxcqq8bKpioBN
 /duwXK23JGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZppbAAAKCRD2t4JPQmmg
 c/nCD/9XlX7zc6uLT9JCo8gVE+Qrib0+kSWUA5l0guywL2JJerGx1jFwpeLASxUJMZGEvPVgP6S
 Y1i+uSPjXDlLttZiF2AXEZ341cBBeq7j6u1cDTctNZZbVOKJyqJmq1IocYiJoh4MScVCOcArBAI
 4AyNI7UA/3AvbC27SbSiQfXjGCyg2r5Ccm2jIElWBQ4M1rFOYHJDhjwQka8Lz7Rq3joemqYxYlG
 06Vo6awlztxJuYoyG60ukevhwm7ZLUDSTmSrsnYh2loGuvZ/zITUOsPMvYxjQug4Nr1X7tLTZA5
 LdWUFo+9n5/SUzZgCSQ/6bX5HtdvcfV5/RCsqCZlQmO/Yvcl/uW5nBk9rSrXg7d6MKUO2yWuU/7
 o4K7ODy3scgwJ9/1f5quapraG3XLg5D7gp75fUce0QOKGb6dcX+pHVic9OuOu5enscQVG5y8IK+
 W+OuyoDyvhbHEUqtLdU9dCYJ/poanNFmZMPOlMmNb0j/Xxjxfn0DsVFIdqHsjGoe7UQHuyNkaPd
 p5Ex8WDO0Pwy6oaiaTdGzw9v9YHPBdYI/soUtVktIBtopVBpbXOOaGCkRaBNLswTy1yHoZgEvVj
 lhOB2f24E+GBbINYgwNbUkuXmPCp/Bme3pkuUSBaZq+HYn/4YYg4Dq6hdTUbRw9lqkemMIgkugh
 uKE/CB0CUw+D3Vw==
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
index 4045e5cc6298..a653ecc9e9ad 100644
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
@@ -1456,7 +1456,9 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
 
 		if (remove_subflow) {
-			mptcp_pm_remove_subflow(msk, &list);
+			spin_lock_bh(&msk->pm.lock);
+			mptcp_pm_nl_rm_subflow_received(msk, &list);
+			spin_unlock_bh(&msk->pm.lock);
 		} else if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
 			/* If the subflow has been used, but now closed */
 			spin_lock_bh(&msk->pm.lock);
@@ -1602,18 +1604,14 @@ static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
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

