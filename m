Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7919322B8B
	for <mptcp@lists.linux.dev>; Wed, 15 Apr 2026 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247101; cv=none; b=Tw5yxEdFd0GBpihciPr5SWEdKC9e8AMqvVC/6DuTA+TDnZFqCeaU/UhqCxu5TrPudKaAw3ObpoAcf4r8vHGzZMUpyw1TNyuyymewfAq+s5B5BP7MZudS7avBasmmhm9RYUtzGhn/atWbElY8fcbfX/IbBxQi1VpS6jz1iTrZeD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247101; c=relaxed/simple;
	bh=V+qTh1H+zvXazMYLs/1iysESXTfvfHvnFRBnUfIXOtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ns74AD7VZYPXCEBe32BeS/PJX124WdxhTJuoySmpVYGqoak0UxJpgmmxWsLv8CEuMoC+1PPNfcpCcNYLuIVDlyVPGre81Aw0Wxeli89rVR5VhnGtTaHsstqp7IT32Jjx5cH30JODV0yDCrgoss3g5LmEoQVbahIxWCAb4EptzlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpJLHb8B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpJLHb8B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015BAC2BCB6;
	Wed, 15 Apr 2026 09:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776247101;
	bh=V+qTh1H+zvXazMYLs/1iysESXTfvfHvnFRBnUfIXOtY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NpJLHb8BbiGt0jsXx7VzX9AV85K1X+plGbfwSrnZR5Z/3pTuwdE4n/RyivQhJRxzU
	 /lYN907TBJQt0fbKi/Vf5VHrMqix3zAgZovVs0BV5ycUCfqtR1XjUJCdRv83DI32Dt
	 U+oECiDRdWEHfP7VFI9RMGPZhK2C3VyFMezDs5ZkModb4mBkMSFbmPP7RUtyfYC/3u
	 DznprCifSBnkISwcs/XqpKQXNGN9dSI2EnvuS3UOkz8e2nL4gacGp0DmG/kdBReJZ3
	 RllMc4LV4emA7fyxXHzko842G8jRmjV/NoG+4jCYZDdmiYHFy4b8Qk40MMPeUjYlLH
	 wr5kNYLbEutEg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 15 Apr 2026 11:57:02 +0200
Subject: [PATCH mptcp-net v5 14/20] mptcp: pm: kernel: allow flushing more
 than 8 endpoints
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-mptcp-inc-limits-v5-14-e54c3bf80e4e@kernel.org>
References: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
In-Reply-To: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3202; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=V+qTh1H+zvXazMYLs/1iysESXTfvfHvnFRBnUfIXOtY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvJ+ou0Vw7oeuamgzXKSXexMKUKZqF/Ac4StnWd4RPO
 8ouW6XZUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMJFZkxn+e9YeOXdr8ZlnlWdu
 HzLZUtfewvokwmnnosXK394fCNv+Vovhn2Jzha9m1dmK7bk9a/uNveZZSvQ2zWhfsjHEbeWVsMv
 x3AA=
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

