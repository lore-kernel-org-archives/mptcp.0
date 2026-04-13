Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825F53D75C3
	for <mptcp@lists.linux.dev>; Mon, 13 Apr 2026 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089536; cv=none; b=EO6DkNv+sQLQvJ2MTBSmXYlRxY52ZwtC15jIKilDkyZsQyvOJWLpX884OzcL+mk/M8vgQHuSy7wTl+sNavp4SsNdQa5sjBaYr4OwEODxBzPfx730vxpJUmJb2lEsz/jI4DtlWZUoVbgkRD/x2eulm18i5B+vICMq27B7x2GKWtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089536; c=relaxed/simple;
	bh=V+qTh1H+zvXazMYLs/1iysESXTfvfHvnFRBnUfIXOtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AIytJP4wa8yOAsW0obF7zq22sJWV+ak9hUn/qhwP6gXgl2tUBMHm2X3hxEgGrKIQIqq4F0yVJ9rY4DMtdH32GhFSj8D//25co7HJLEzs643oyWhhLQTYb99U3gSlTrCqROwbWO5vRnjxWdvlKDaZSfVHMVzd2OQj4EXdRhkMNEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCesNe5+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCesNe5+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07252C4AF0C;
	Mon, 13 Apr 2026 14:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776089536;
	bh=V+qTh1H+zvXazMYLs/1iysESXTfvfHvnFRBnUfIXOtY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oCesNe5+G3z7qLkcEEX63SirAh7JnsF1YroRU8wQAiHt94kfMx3qiebLAsuOzqntk
	 dZMbkikFDn25cxJubu9PfrcpjpeK+qCpca7+jgcWbu4n4Xoj36ycCBgolCT5qbgGaR
	 0VQ0veoCOXpYDpgH4lL8B/lxNuB2Cx1aJoD0UWpZZ1dy5bawvMkYSy0koZ9uLNK0j3
	 LYVcVk/PjHCHNR+uUeKkWM5VoIEZzBy+SD1t3o+HQmOyXmBDG/VsdEszwZA9qhFgoh
	 KHFKd5lj2rEbpWv5O950UTiWEfJX0irNTdAD+zjI8u4etI3bTdKv2mC5Vdl4mlkI/5
	 vVtVGLNubSPgA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 13 Apr 2026 16:11:59 +0200
Subject: [PATCH mptcp-net v3 13/19] mptcp: pm: kernel: allow flushing more
 than 8 endpoints
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-mptcp-inc-limits-v3-13-dd36c9360432@kernel.org>
References: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
In-Reply-To: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3202; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=V+qTh1H+zvXazMYLs/1iysESXTfvfHvnFRBnUfIXOtY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLv/NyYGBCddcIgY/Fq5cUcMxVURAUj0jP6viUbX1vbp
 KZ3+fHSjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImsv8jwP8nb9+tygWAeZr7S
 vCqtF14xkW+N1+6tmXnIKnHrya4L3Az/sw86bVlxZZ3YugOzLe7dPa33Wk6ZacKdhgSn8xdPPvL
 NYgUA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The mptcp_rm_list structure contains an array of IDs of 8 entries: to be
able to send a RM_ADDR with 8 IDs. This limitation was OK so far because
there could maximum 8 endpoints.

But this is going to change in the next commit. To cope with that, if
one of the arrays is full, the iteration stops, the lists are processed,
then the iteration continues where it previously stopped.

Note that if there are many endpoints to remove, and multiple RM_ADDR to
send, it might be more likely that some of these RM_ADDRs are dropped or
lost. This is a known limitation: RM_ADDR are not retransmitted in
MPTCPv1.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index f163d40e7375..1480bb7473b4 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1224,19 +1224,30 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 }
 
 static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
-					      struct list_head *rm_list)
+					      struct list_head *rm_list,
+					      struct mptcp_pm_addr_entry *entry)
 {
-	struct mptcp_rm_list alist = { .nr = 0 }, slist = { .nr = 0 };
-	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_rm_list alist, slist;
+	bool more;
 
-	list_for_each_entry(entry, rm_list, list) {
-		if (slist.nr < MPTCP_RM_IDS_MAX &&
-		    mptcp_lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
+again:
+	alist.nr = 0;
+	slist.nr = 0;
+	more = false;
+
+	entry = list_prepare_entry(entry, rm_list, list);
+	list_for_each_entry_continue(entry, rm_list, list) {
+		if (mptcp_lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
 			slist.ids[slist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
 
-		if (alist.nr < MPTCP_RM_IDS_MAX &&
-		    mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
+		if (mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
 			alist.ids[alist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
+
+		if (slist.nr == MPTCP_RM_IDS_MAX ||
+		    alist.nr == MPTCP_RM_IDS_MAX) {
+			more = !list_is_last(&entry->list, rm_list);
+			break;
+		}
 	}
 
 	spin_lock_bh(&msk->pm.lock);
@@ -1247,9 +1258,14 @@ static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
 	if (slist.nr)
 		mptcp_pm_rm_subflow(msk, &slist);
 	/* Reset counters: maybe some subflows have been removed before */
-	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
-	msk->pm.local_addr_used = 0;
+	if (!more) {
+		bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+		msk->pm.local_addr_used = 0;
+	}
 	spin_unlock_bh(&msk->pm.lock);
+
+	if (more)
+		goto again;
 }
 
 static void mptcp_nl_flush_addrs_list(struct net *net,
@@ -1266,7 +1282,7 @@ static void mptcp_nl_flush_addrs_list(struct net *net,
 
 		if (!mptcp_pm_is_userspace(msk)) {
 			lock_sock(sk);
-			mptcp_pm_flush_addrs_and_subflows(msk, rm_list);
+			mptcp_pm_flush_addrs_and_subflows(msk, rm_list, NULL);
 			release_sock(sk);
 		}
 

-- 
2.53.0

