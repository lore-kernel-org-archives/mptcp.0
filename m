Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A02E1AAD7
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910867; cv=none; b=SLf+l1fpaJBXlCsldm0TFNMFF4E92WMvji5CG6i90tKrns+fJJfE9BR7pzzfZgRLPqFTvp+M8zNlP1099vjYHQWPZS4vjLWKMrzNrjneaQp9H6dsdNCgeqS7+7FTt01YiGG8MmKNvBLp9TxZBBrlTP4MkAqy2njtbzm95myNOXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910867; c=relaxed/simple;
	bh=3Dzyj8Auqc8MAQNrbY8jIm2roj4GjGiibpUK1X4uztM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yyf4oSsVnAgBVWLGmwlZPHw6wwPio0EYt46QNgoxzSV8LWdTVCXrzPY1CZnCS2Bw5e+/cJvMrX/rgJR4WlVkZykjb4qCYtXhvbUpW5HWT+kQQcLr7MW+eYv0/7tQ4w7ZwRs+1VkNnqYlDxCqodCKcKiJ2Vy9B9eionKqhYTADsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrTdIjch; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrTdIjch"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8722C43390;
	Wed, 14 Feb 2024 11:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707910866;
	bh=3Dzyj8Auqc8MAQNrbY8jIm2roj4GjGiibpUK1X4uztM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PrTdIjchfC05NdNrLaHbEbCM7kYcrbs7YypyDhTjUhHOvNSJg8BgrfHtvgwAzDtPt
	 jzkqmXgx3jYMMXaPawISpHXOLOkrkNWCQ95uAQtn0PMEXUa+8aO74r2KC/NOFb2gIY
	 +25JVipfaeEZ7L1/WdcUagkIMRAX1+OpCKKFgMPILhAiJyq7gaTSli4HbHBJyDf+kp
	 TN/D0bEo+JZSP9Fy3N4TmzaerTvJ5DNA+vfKX8vVzxS+QHF3cyobfLBMu856Zm2C3c
	 xnQTXpMGVukr4Et7al3RUJtn4m2rr8zh6XOohHTat78Ocvn+3zn6Gq9q4r6orpcrOj
	 kr6xIizAT5I1A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 11/15] mptcp: add userspace_pm_lookup_addr_by_id helper
Date: Wed, 14 Feb 2024 19:40:02 +0800
Message-Id: <90df4afa0e7ba71cf04c67f8eff2ed231cea0e12.1707910454.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707910454.git.tanggeliang@kylinos.cn>
References: <cover.1707910454.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Corresponding __lookup_addr_by_id() helper in the in-kernel netlink PM,
this patch adds a new helper mptcp_userspace_pm_lookup_addr_by_id() to
lookup the address entry with the given id on the userspace pm local
address list.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 73ad286247f1..a9328f41f74c 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -106,19 +106,26 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 	return -EINVAL;
 }
 
+static struct mptcp_pm_addr_entry *
+mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (entry->addr.id == id)
+			return entry;
+	}
+	return NULL;
+}
+
 int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 						   unsigned int id,
 						   u8 *flags, int *ifindex)
 {
-	struct mptcp_pm_addr_entry *entry, *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (id == entry->addr.id) {
-			match = entry;
-			break;
-		}
-	}
+	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
 	spin_unlock_bh(&msk->pm.lock);
 	if (match) {
 		*flags = match->flags;
@@ -261,7 +268,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
-	struct mptcp_pm_addr_entry *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	LIST_HEAD(free_list);
@@ -298,13 +305,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	lock_sock(sk);
 
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (entry->addr.id == id_val) {
-			match = entry;
-			break;
-		}
-	}
-
+	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
 		release_sock(sk);
-- 
2.40.1

