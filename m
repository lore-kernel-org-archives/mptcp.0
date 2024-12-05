Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4D3653
	for <mptcp@lists.linux.dev>; Thu,  5 Dec 2024 07:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733382918; cv=none; b=Q+bNxYEc4xxx3Esc3MG9t/bqTrsGlEy2mvvz5fHbKGVl2DvrMQPfjspXJ0m/Qiqz7iOWU3YVxGXdAuxbNbC6xIjER3sdaUXB1pjBugFITp4h28s23a6eF2v38BI87emxtisWjZWcc4lhl95eMtl9Y4YA8EU5X4HR42DNOP+cRr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733382918; c=relaxed/simple;
	bh=KxYiRCb97eu/xRjf4MYxvVjWC47YXYzFgHv6uIQM26c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCD68gI7Gp+NEjyNP0IOn1oHAce+Q5bh47j3cF/mvF2vBRH2eCe/pEpQQ+dVwtUG2GDYYZz89YrdJr9pZQe+IoHjSvedB4bF/DSMNmvbchcNfYk1KaI7+S2y+T8mAgqUMvY2IofNYMUvkS/OngYx5LdwylBLXTHaNz18G3K2+vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnnxuAhu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnnxuAhu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A43C4CED6;
	Thu,  5 Dec 2024 07:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733382918;
	bh=KxYiRCb97eu/xRjf4MYxvVjWC47YXYzFgHv6uIQM26c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DnnxuAhulgBNv4mY0U5h0dJ7iFsfoBUivz+4GFwldH4FWisoNJqv/kwiJJHeFvWuP
	 t2u/rQMnYI5fJbj0j/FQjbyvCetC7th68eXKWhAwXLYdakT83dHZklg+k2BYppnYlV
	 GUX+WqVsq4JEv3Fx3uB0FG5BPqIHWQ75GXiRuViile/i0vykCo6OcPzKa+DVAa/ogp
	 /gRqf1/PYYqw2yHh9R1qpr8S+1oolE6gyMW8EtjjrfXlEomtRn5g7timAeUFnTSjuJ
	 0Ubr8ocKtM1ZoI1jFgVDHnvjtktYzuNpmKhfmxVq7SRZUaIzt85BLaxluovK7PurMk
	 S8fNhDuFkLPJg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 5/7] mptcp: drop free_list for deleting entries
Date: Thu,  5 Dec 2024 15:14:57 +0800
Message-ID: <727da6c2412b1d27c079f4cf01d88021e8d478f7.1733382223.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733382222.git.tanggeliang@kylinos.cn>
References: <cover.1733382222.git.tanggeliang@kylinos.cn>
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
 net/mptcp/pm_userspace.c | 42 ++++++++++++++--------------------------
 net/mptcp/protocol.h     |  3 ++-
 2 files changed, 17 insertions(+), 28 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 737a07f5defe..ca302465fecc 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -286,41 +286,31 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
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
+		return;
 
-		alist.ids[alist.nr++] = entry->addr.id;
-	}
+	alist.ids[alist.nr++] = entry->addr.id;
 
-	if (alist.nr) {
-		spin_lock_bh(&msk->pm.lock);
-		msk->pm.add_addr_signaled -= anno_nr;
-		mptcp_pm_remove_addr(msk, &alist);
-		spin_unlock_bh(&msk->pm.lock);
-	}
+	spin_lock_bh(&msk->pm.lock);
+	msk->pm.add_addr_signaled -= anno_nr;
+	mptcp_pm_remove_addr(msk, &alist);
+	spin_unlock_bh(&msk->pm.lock);
 }
 
 int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
 	struct mptcp_pm_addr_entry *match;
-	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
-	LIST_HEAD(free_list);
 	int err = -EINVAL;
 	struct sock *sk;
 	u8 id_val;
@@ -354,16 +344,14 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
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

