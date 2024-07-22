Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC6E1C695
	for <mptcp@lists.linux.dev>; Mon, 22 Jul 2024 19:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676966; cv=none; b=acpPe1vjseOHLg1rb53gCHANd+jUdTkE+61DCpBJeZSIBQXSbf0p4nKtGlIujB30ZZ/bykR1jsSI0K1WOejV93ypMRO7bkGYis+SPDPyrw9cDjNCkKO+yvC4AFGBYMlrk6ePCx68hvWQ67oJe7+JD0079XP4VEfMrP14KfSRIj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676966; c=relaxed/simple;
	bh=GEkkHViB56dUWH56K7rwfK01aIrJJch4t8GMykQ7od8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SVEsRJEPxHhjfScZ9KGS4Kqffqp3lsdAFRqjBSPtMmz5o2o44wUVJL/fYgf0MISFJvoLSIOET+vVxhBkOXjAY5DAimS8VCXzTgWUsnpTK7jXGTji52j6fcWdKctBIN4K8W0aaSo5cQIV9M60H4h+5IhM8CgrLuVEzfwk6Cna7xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTQyC2js; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTQyC2js"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E962C32782;
	Mon, 22 Jul 2024 19:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721676966;
	bh=GEkkHViB56dUWH56K7rwfK01aIrJJch4t8GMykQ7od8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KTQyC2jspeaK4/v4XXBQeEDD+I1vp0KphSZrdwmQbk2QNB6eWIMaZ6Q4yVY3HiwxM
	 OZX/BIc7gqjC3hSObODIi5Djr54IMGSXUWVRq07RyRBZjM6M7c/e8mhwUoMusKS77R
	 embBXEruliTlWd4+C5iABrL9aVhCD9ZEZ09dl8oEIfKh3psQ8NkVx5o9zRRwCDwkuG
	 oqWjMu0jfUVdeBjKK3NgsxBKc2kMK+oKrKHXHz1b/RTLUxEogiX2NJl5q63CBB/FiJ
	 yZ4bTfdu5vXu6NNhmUPkIH0YBvZCcDPbD6ftW+rgzsIRGyQwd4SVjgjlzN655sAwCC
	 tR5Q+pp8F4XSg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 22 Jul 2024 21:35:50 +0200
Subject: [PATCH mptcp-net v4 12/23] mptcp: pm: re-using ID of unused
 flushed subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-mptcp-pm-avail-v4-12-15bfd73de384@kernel.org>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
In-Reply-To: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2788; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=GEkkHViB56dUWH56K7rwfK01aIrJJch4t8GMykQ7od8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmnrSWI2L51CQ+rgyZo4h2fGOnsHJbzNOMu/Kst
 OHlBb083aSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp60lgAKCRD2t4JPQmmg
 c3/DEACAVFoOb8Nclv6tMCyrJ/55guB6M1AQyvL55YGM+MYS7MacC4R79HHsBR/SkczmwuDn982
 rwD8PFDF/S3drEUK9IJ9/DJ9XPIWWch0qL3h6Aj5UOmnZeU6qM8jvJO4ZdL6zMD7ekm08v7WG3B
 qXlXn0BVsjfBbPieqmL3OoNBwCbmDWwI+NYu0+3IwLRI+WN08JMHDw8EpORW+QBsToz7dNpRrYP
 AKD4YLa53AU15ZYOR/PPm1/ajvB70uFxcF5Qxr0aobV9SquaoFTf4+lCVzKMSAvsGCtTG12KCMK
 Da1sO3JSYo5S+YwSCCvK4nFK9XV8Rdv0Vfqwf5G6M8QhkAgwM7W1BZmZAm32AgEF2OyY3PVDM6z
 A3s59X93BUy90uevdgvlNsiq5Dy+AxEsL3iLNVbbKcVc8VmF1MmUb1+uFz4hXKMvyny/ot0BL/C
 aeHLl5+UTuoNUpQGUJ5kEqrMjs6SgBMzLV5GCvte3aeW+VUS+9QvywJ+Mp5yW4VoULPJSJPDGzR
 gs49k65ZVDkWZUMlkrObjsBgLeWLOr0+VkNzNyaRMKLKxxQNAtBpYWMe8y2Lx8fI2hHny9LXkCR
 1SHehE6iOyK5bQ8J7/HoZMv5ZabxDFleL+lU2aP2c6a4BX6DTqY3QQ5q2SCtL81dBZobaiZheX5
 djk21/Dc1vsW1sg==
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

