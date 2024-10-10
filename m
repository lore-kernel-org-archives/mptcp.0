Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01BD178372
	for <mptcp@lists.linux.dev>; Thu, 10 Oct 2024 05:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728539308; cv=none; b=HG2m1iS3u8F5wlpozWwvptGu2tbx1JuQua/8IgAuef0ny4RzGVhTksXIitRQv5ckDc8/j5qd8MPZnZnKOZ7gEIoFTU5zj00e7DztWLjoQ3G4HjwDXHjvwmagSVKy+i9acB4+3BzLWXCnVS6yM8zJaOovaXHzhAJMEp5UbnlTSoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728539308; c=relaxed/simple;
	bh=E5CvVASfaVU1hIk2R50aKjxHTmAtX6JmVYKO9gtaUAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oq4PJzzcLR7RKIJwAaUqKgvgLtUM7Z71AoWBH3+/kqRZIJBq0ZQ5iSdMvdsw3+o0H/vFeg+k1DYDEuszCzcQ/iAGeM3Zn20QSY0kYIg/eNDEvMOWuT8FRw2C2q0zp79ljlHys3blgCeSIH88sKvPJrMV0IJxlEJIhMBFE122W1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgFS464R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgFS464R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7830CC4CEC6;
	Thu, 10 Oct 2024 05:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728539308;
	bh=E5CvVASfaVU1hIk2R50aKjxHTmAtX6JmVYKO9gtaUAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kgFS464RiXWR38yiBlQknU7WmndCMgDpvkVruhVKyvgyShkdDOBNek4bNUMhkUlaW
	 m3DrZS63ObZ3UmX/k5UVzo0cs/Y07r4P0OOfHroUe7ueJhFea40tCdVWsiEPhWgooo
	 kz353/9GYbY/CL6ksMCuCo2sBcia9VKlyHZ4zTzW9pY9c+4o7bC7QQKpS7NaNcM/Fz
	 y6lBnWro/oftRyICjsovmNuFijTUDYCWMGNSi4eXUeAXakY0yFEpsxB7//X2mdXI2G
	 GJNjgAs3+Mc1nstWfPSjGRpKX0zUm5FM9UpiQweFvWo+6jNfD+kSCLZDyRZi+Wsb26
	 FWZ8sG8uX0OHQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 12/15] mptcp: rename mptcp_pm_remove_addrs
Date: Thu, 10 Oct 2024 13:47:57 +0800
Message-ID: <90414a91e0248adb5a7e4ab46ef12f9a1ab475a9.1728538976.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728538975.git.tanggeliang@kylinos.cn>
References: <cover.1728538975.git.tanggeliang@kylinos.cn>
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

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 24 ++++++++++--------------
 net/mptcp/pm_userspace.c |  2 +-
 net/mptcp/protocol.h     |  3 ++-
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 38168eb6d4a0..47dda03e4ee2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1629,26 +1629,22 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 }
 
 /* Called from the userspace PM only */
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
-		if (remove_anno_list_by_saddr(msk, &entry->addr))
-			anno_nr++;
-		else if (!lookup_subflow_by_saddr(&msk->conn_list,
-						  &entry->addr))
-			continue;
+	/* only delete if either announced or matching a subflow */
+	if (remove_anno_list_by_saddr(msk, &entry->addr))
+		anno_nr++;
+	else if (!lookup_subflow_by_saddr(&msk->conn_list,
+					  &entry->addr))
+		goto out;
 
-		alist.ids[alist.nr++] = entry->addr.id;
-	}
+	alist.ids[alist.nr++] = entry->addr.id;
 
+out:
 	if (alist.nr) {
 		spin_lock_bh(&msk->pm.lock);
 		msk->pm.add_addr_signaled -= anno_nr;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 05ad0d17ea81..9477c36d3284 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -322,7 +322,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	list_move(&match->list, &free_list);
 	spin_unlock_bh(&msk->pm.lock);
 
-	mptcp_pm_remove_addrs(msk, &free_list);
+	mptcp_pm_remove_addr_entry(msk, match);
 
 	release_sock(sk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 20ed572472aa..168f144b86a4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1040,7 +1040,8 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
-void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
+void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
+				struct mptcp_pm_addr_entry *entry);
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 
-- 
2.43.0

