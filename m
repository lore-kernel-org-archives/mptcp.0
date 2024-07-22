Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFAB171640
	for <mptcp@lists.linux.dev>; Mon, 22 Jul 2024 19:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676968; cv=none; b=X2D4f1qW104aKwVRbpsH4guzPWdYWxPhXDufwwEUqaTZMClQD1qIg3fcL2dKN4pnvyQ4ZnW9IBFkk/SR69HHay55ycPC27dh5mZtGH4DC3q+rhIxPf4vBAIetnhJtAelJIlmxSO4bYWupzr51WHSXj2s/CSe9vhNQ9Cn+e+YHKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676968; c=relaxed/simple;
	bh=DPCMP4eWODT9nHLLzAjsnvSTdaXqPhdwWCvENtknObE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fmbhngcq5HRkAvf8kBv9zionDInS1YnAfcNWJWnA4/6MZrijC9d5u4/B2Y6nbL+oa0Rjoe5DgFHUxZpQON+5RP0FU5/HYGNOyXJ8khEaEjokK9Q2ZUW02OqgIQO+lXrsdnj9FOFquIlXmMe46h8q69wB1WeWfVBN8ov/rzah2SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAGh5jTy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAGh5jTy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E888CC4AF0B;
	Mon, 22 Jul 2024 19:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721676968;
	bh=DPCMP4eWODT9nHLLzAjsnvSTdaXqPhdwWCvENtknObE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iAGh5jTyFKMo1Fkus4Ep2zznEkhUwZKYI/pTUQleSvBhgGWVNJir9z2T7Oc+cMChU
	 06ZzyXEtMSFcWEy+6qRIJ7B7guyFWFRkJxPbBRW0Y0IG/r+ap/LETtGF4XJz59NyRF
	 9koqcMO5MSJxEO4pBiNkcmNnH9TzRfSpz8RCHLNvIbsXMUb444TtWmoEfj+ppB8Wwe
	 qyjAvdWVkUn8O9WObO843mLmh4loYeIeRig45TLljj6xBs3LIxZSmHfwVZl537JS2J
	 5ZfMIBYJNipP1dizHtHb9vClaU6Phwpbz3f/lJ/qJ1FZnSmpBFoejXmSZ7FuVBw1Gm
	 HOdRi/rhkelKg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 22 Jul 2024 21:35:52 +0200
Subject: [PATCH mptcp-net v4 14/23] mptcp: pm: remove
 mptcp_pm_remove_subflow()
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-mptcp-pm-avail-v4-14-15bfd73de384@kernel.org>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
In-Reply-To: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4828; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DPCMP4eWODT9nHLLzAjsnvSTdaXqPhdwWCvENtknObE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmnrSWzNzmeNq7rXkvir/07kfgsxcHkYT0Aj/nl
 RJF2EAUmUmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp60lgAKCRD2t4JPQmmg
 cz2jD/4vzl5q0DWZtDv/2UrGlOjGLOISypf+Tzd5deMHA12Np8TQPBKNlptW5QkxY2l3T5e+juU
 BW6bUuWDx2O0e9iJfYX1sRyM0eNTF1cIuqO0Y2TNtt7k0DmXQiIcvZOujhQIyOJXnXnNc1/31wW
 6i46oOhYDZhlAaAzvV1Eu20vSOjueAphSysT+qCoSzq8UmCWi19I06Iy6xfDz9b1jT07rbPK+Tm
 G3RSovc6gWlfDVYuSluFh5RB2KGVMbSFxfVQk+KDsu8EbUVnnAN7xKaglXcRLyBkvTOEW4VU7+W
 Q6TaPcT9GkMXh7mhLb+0gVSG9hQ62vcyoAK38SHsgAXEiMcBEUl7xI/RpOYjK3tJdBaPplBGo+v
 XAhYN+ToG06wKffIg1B8McbUZEXZY8zoSRodvmIavVFxz7kLb3yzlNPEIsGmv0pF+fegh9V/k9I
 qIUQLpJMNGHjA8iU4S7KpS2avoDONmXE69YcMqjUuhGaEfuY73IIJLQpOKffZZY3jf6ArgKDfSm
 7EaGCAgdx+LpmnqAirCU7jZug7ph8QTMwQqIO6obTUDqVJEwV1ufa7eE+DCI73b50g9zq34F162
 b9MicmzMHCKBp0hanbHk4qoHXtHwYKuRb/VInHcAFOynkSaoJ0cOIXZUaRZGV803LKl2Yc4+3Yw
 ai1hZDme7Q7R8YQ==
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

