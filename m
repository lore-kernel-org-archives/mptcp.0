Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD0933F8A4
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876052; cv=none; b=k19ZPJBW90RrAHJdO9vvnrbISN6AupVnurRZoutmfq1Y5BQcgif4enko3/H+ZzPD0zgxHRa0j9Vy41UU7I6qd9jmNXe0hyRglHNjf84gl+RxXuk/VsMn50rMwQ/Wf8incB9fUQYVGfByJgo87t0cepYSoYfEYhGtGemDzpFR9eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876052; c=relaxed/simple;
	bh=V+qTh1H+zvXazMYLs/1iysESXTfvfHvnFRBnUfIXOtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k+3I/qOWim6njQtLf11t2EenH6v7p3/Up8Q3tpp01bxSbq0WoM1ygZfZm4rPctKpakryySxwzEAyRDHdlisp4fwGRHnm4pOtKa//vEz40vCFf3ms6NFna3w30MpcEY1kZZigLSFmmoiES6JNXo4wroh8utCEbAhgSSwokVb7Xuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayziDSqh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayziDSqh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11790C2BCAF;
	Wed, 22 Apr 2026 16:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776876052;
	bh=V+qTh1H+zvXazMYLs/1iysESXTfvfHvnFRBnUfIXOtY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ayziDSqhpET9p+92zuoTUsoKAgMByNmuh342phStqcYHERdGSn+UkVLxExpkghUZ3
	 XJSql1jInu7Xn+QaUQgIgeMVedJ1jwNNVXGYoWXCvQ0TOILEvWRBO4EezyjA3eCvfY
	 7Pby61xB5Q2MG4KmQ1Ca5Off7J8BtMmeGZyyVehX4HPAW2eIpNM+4bEC1yNukp67JC
	 iaxF+nMctIIHJyTN9hgE35yr4FuweauQN27x4PUmURXyu0jjFxTixCsQD+3J69BLOg
	 83t9owu8z24VxiZvqGVJSTsYNGlhF7fuuPRQtF6JA+CWQ9d51up0/IF9/bYDT6ynDE
	 r1vv5hLEfcKtg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 Apr 2026 18:40:28 +0200
Subject: [PATCH mptcp-net v6 14/19] mptcp: pm: kernel: allow flushing more
 than 8 endpoints
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-mptcp-inc-limits-v6-14-903181771530@kernel.org>
References: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
In-Reply-To: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3202; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=V+qTh1H+zvXazMYLs/1iysESXTfvfHvnFRBnUfIXOtY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJf/GLZXfnk7r7m/ccn6r8UfDTj29zrK21ebzhgpjx1x
 h1n9n17dTpKWRjEuBhkxRRZpNsi82c+r+It8fKzgJnDygQyhIGLUwAm0mHGyLDVX21B3XUP0bh9
 oRv0lglPLXIvW9ax9d/+e8wi50MvfpvKyPD5RH//zQ/3vXXF++Mjig4+dhRJ7znoW+Pu+brX+vr
 lSjYA
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

