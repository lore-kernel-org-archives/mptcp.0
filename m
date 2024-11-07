Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B54B82C60
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 06:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730961960; cv=none; b=T+2n89xwMMg4phZkcwgsE/wmTt2jGYC33fOY1iPGUPBsU61MQ1PVH+FFxjR3kBbRLoiyiMUFN5n63Iyf7Byyc+BC4W/lXKB5erwqGp+1lpEmSTs7y04BKZHFfXyQlJy8H5FJcKQg/v03RWPiAzWEJ6EsI6w0tZmpJXV1z8azNFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730961960; c=relaxed/simple;
	bh=N1xNWmKoQVDk2+59cslVN+pSL5uLlVnEQqBsGqycZJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3HUp4jBxdHanR356YMrW3ml1jZKkbJk3tidyJAKyyBBKyeuwFT1r7UEvUqfZuGpL92sPTsbnh/UJc0nZXkD96VMkBizwe9JJOA6QHO5aXhMFhFA7zNbyIeSaR1rK5nju/NejPudH7rQ570oZuDS/pbEZeGEFqw27H1lw++NC3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0vG9yN+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0vG9yN+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41EBC4CECC;
	Thu,  7 Nov 2024 06:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730961959;
	bh=N1xNWmKoQVDk2+59cslVN+pSL5uLlVnEQqBsGqycZJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l0vG9yN+WNIUjkJNMmQ4vVRk2g9CpvWYumtoZly3/3pdOjyHOR7JhX0vKgpvIvZUE
	 JnA1+yN5KxIciGQaIpD27qsP4YeQ6ku1PB3SUwiPy6hY4ppdddZ73GsWY9TVld6tCP
	 hoO+Fvzt6GhC7yxYfLXKa4k2+8EVgP+AWJGxhoqo2pY0lUgsigz+6RHZMdm2gJxLRu
	 mTSoZTZdf+Xh6CrbPwpaVExaRbSHrRgU/rY+pvJLvnmM9+Omp96mbUOlYI+kTeMMnq
	 kWiAk98cawJu3ObQLryS3t2rOhvGJChSvu7jSkwK0nMHcHO82SMQ8ywaQOw4IA5DEn
	 EpOlMzkG1th8Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 5/9] mptcp: drop free_list for deleting entries
Date: Thu,  7 Nov 2024 14:45:39 +0800
Message-ID: <68e7a3deaea7319b4fb36b9ee8a6073a8bbfa37d.1730961810.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1730961809.git.tanggeliang@kylinos.cn>
References: <cover.1730961809.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

mptcp_pm_remove_addrs() actually only deletes one address, which does
not match its name. This patch renames it to mptcp_pm_remove_addr_entry()
and changes the parameter "rm_list" to "entry".

With the help of mptcp_pm_remove_addr_entry(), it's no longer necessary to
move the entry to be deleted to free_list and then traverse the list to
delete the entry, which is not allowed in BPF. The entry can be directly
deleted through list_del_rcu() and sock_kfree_s() now.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 33 ++++++++++++---------------------
 net/mptcp/protocol.h     |  3 ++-
 2 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 737a07f5defe..a98da9a44bfa 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -286,26 +286,21 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
 	return err;
 }
 
-void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
+void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
+				struct mptcp_pm_addr_entry *entry)
 {
 	struct mptcp_rm_list alist = { .nr = 0 };
-	struct mptcp_pm_addr_entry *entry;
 	int anno_nr = 0;
 
-	list_for_each_entry(entry, rm_list, list) {
-		if (alist.nr >= MPTCP_RM_IDS_MAX)
-			break;
-
-		/* only delete if either announced or matching a subflow */
-		if (mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
-			anno_nr++;
-		else if (!mptcp_lookup_subflow_by_saddr(&msk->conn_list,
-							&entry->addr))
-			continue;
+	/* only delete if either announced or matching a subflow */
+	if (mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
+		anno_nr++;
+	else if (!mptcp_lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
+		goto out;
 
-		alist.ids[alist.nr++] = entry->addr.id;
-	}
+	alist.ids[alist.nr++] = entry->addr.id;
 
+out:
 	if (alist.nr) {
 		spin_lock_bh(&msk->pm.lock);
 		msk->pm.add_addr_signaled -= anno_nr;
@@ -318,9 +313,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
 	struct mptcp_pm_addr_entry *match;
-	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
-	LIST_HEAD(free_list);
 	int err = -EINVAL;
 	struct sock *sk;
 	u8 id_val;
@@ -354,16 +347,14 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
-	list_move(&match->list, &free_list);
+	list_del_rcu(&match->list);
 	spin_unlock_bh(&msk->pm.lock);
 
-	mptcp_pm_remove_addrs(msk, &free_list);
+	mptcp_pm_remove_addr_entry(msk, match);
 
 	release_sock(sk);
 
-	list_for_each_entry_safe(match, entry, &free_list, list) {
-		sock_kfree_s(sk, match, sizeof(*match));
-	}
+	sock_kfree_s(sk, match, sizeof(*match));
 
 	err = 0;
 out:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 80d355c1dfb4..19a811220621 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1042,7 +1042,8 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
-void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
+void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
+				struct mptcp_pm_addr_entry *entry);
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 
-- 
2.45.2

