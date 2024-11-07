Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8CC82C60
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 06:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730961958; cv=none; b=uRZboMt0pmw4D5xQ6Sv8Yos2rZdWgqMqmkVjyUXHC5pcUNWfIabrvT9/y8fRvoHydsUNobj7zwu02IDjdrWU+OAW05VRLwFYM4Qw1oNzTfEFU+/JB9T5qcGSBuu2NyYB9fk2YccP8boUipjuGzkSFbU77ylftwxdwkqE2Spdtz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730961958; c=relaxed/simple;
	bh=/KghofNRJms4fZ0yD9aRixEb8IH1t2Ryl12v+7XBDHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzefRuJXjhHGLta6h4wRn/YFo54GYIDDapO2WKuhzF48Tle4liqvCKByaMYtKwVZrDE2hZP/JUJPi0FzFwQgMTja1G5s/c7vnMBTspV16bFqF8EsyoPA7YGcpXyRUtVVsCzfOoGkCJM5iu4mNHYkqjkzem2eyx22HkXg3EfLU4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/mHTFS1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/mHTFS1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA02EC4CECC;
	Thu,  7 Nov 2024 06:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730961958;
	bh=/KghofNRJms4fZ0yD9aRixEb8IH1t2Ryl12v+7XBDHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C/mHTFS1nkjzA+Smk7BwY+Wn/sfUGBCxZZSon27iNkoRqJHxQxP4okxQtr0BfOGwO
	 28yLQUTgzI354ZwcGDJb3ps7+sr44QLcS2MnkguWM9Rz2gxZ6vJmhK4rXL388Gv6Rq
	 99JZeI3EhOYDEyga7K19ZQaMvsMH/ppipunKEouPexRfZI5EscVOOD2okT43kMIcJ4
	 OtxmRKiAOiOaXztOPj9J5ypTwnzZ6/WxCItlOGzzigibw4sQK8u4bCg9dQJoe5eMmt
	 adshUN9XFc3uSqy6OCtEUiJJ/8nF+ijh8SeHLYzyJVZVSeCqsQajgMUt1Br5+mIHkw
	 RLnbgmcUbrwLQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 4/9] mptcp: move mptcp_pm_remove_addrs into pm_userspace
Date: Thu,  7 Nov 2024 14:45:38 +0800
Message-ID: <92ab4cbf71a2be676481b20c662b2f602aa346e2.1730961809.git.tanggeliang@kylinos.cn>
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

Since mptcp_pm_remove_addrs is only called from the userspace PM, this
patch moves it into pm_userspace.c.

For this, lookup_subflow_by_saddr() and remove_anno_list_by_saddr()
helpers need to be exported in protocol.h. Also add "mptcp_" prefix for
these helpers.

This patch doesn't change the behaviour of the code, just refactoring.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 45 +++++++---------------------------------
 net/mptcp/pm_userspace.c | 28 +++++++++++++++++++++++++
 net/mptcp/protocol.h     |  4 ++++
 3 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 618289aac0ab..8aba7670345d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -107,8 +107,8 @@ static void remote_address(const struct sock_common *skc,
 #endif
 }
 
-static bool lookup_subflow_by_saddr(const struct list_head *list,
-				    const struct mptcp_addr_info *saddr)
+bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
+				   const struct mptcp_addr_info *saddr)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_addr_info cur;
@@ -1453,8 +1453,8 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
-				      const struct mptcp_addr_info *addr)
+bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
+				     const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *entry;
 
@@ -1482,7 +1482,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 
 	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
 
-	ret = remove_anno_list_by_saddr(msk, addr);
+	ret = mptcp_remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
 		if (ret) {
@@ -1526,7 +1526,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		}
 
 		lock_sock(sk);
-		remove_subflow = lookup_subflow_by_saddr(&msk->conn_list, addr);
+		remove_subflow = mptcp_lookup_subflow_by_saddr(&msk->conn_list, addr);
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
 
@@ -1639,35 +1639,6 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-/* Called from the userspace PM only */
-void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
-{
-	struct mptcp_rm_list alist = { .nr = 0 };
-	struct mptcp_pm_addr_entry *entry;
-	int anno_nr = 0;
-
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
-
-		alist.ids[alist.nr++] = entry->addr.id;
-	}
-
-	if (alist.nr) {
-		spin_lock_bh(&msk->pm.lock);
-		msk->pm.add_addr_signaled -= anno_nr;
-		mptcp_pm_remove_addr(msk, &alist);
-		spin_unlock_bh(&msk->pm.lock);
-	}
-}
-
 /* Called from the in-kernel PM only */
 static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
 					      struct list_head *rm_list)
@@ -1677,11 +1648,11 @@ static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
 
 	list_for_each_entry(entry, rm_list, list) {
 		if (slist.nr < MPTCP_RM_IDS_MAX &&
-		    lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
+		    mptcp_lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
 			slist.ids[slist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
 
 		if (alist.nr < MPTCP_RM_IDS_MAX &&
-		    remove_anno_list_by_saddr(msk, &entry->addr))
+		    mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
 			alist.ids[alist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
 	}
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index a6de837d8958..737a07f5defe 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -286,6 +286,34 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
 	return err;
 }
 
+void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
+{
+	struct mptcp_rm_list alist = { .nr = 0 };
+	struct mptcp_pm_addr_entry *entry;
+	int anno_nr = 0;
+
+	list_for_each_entry(entry, rm_list, list) {
+		if (alist.nr >= MPTCP_RM_IDS_MAX)
+			break;
+
+		/* only delete if either announced or matching a subflow */
+		if (mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
+			anno_nr++;
+		else if (!mptcp_lookup_subflow_by_saddr(&msk->conn_list,
+							&entry->addr))
+			continue;
+
+		alist.ids[alist.nr++] = entry->addr.id;
+	}
+
+	if (alist.nr) {
+		spin_lock_bh(&msk->pm.lock);
+		msk->pm.add_addr_signaled -= anno_nr;
+		mptcp_pm_remove_addr(msk, &alist);
+		spin_unlock_bh(&msk->pm.lock);
+	}
+}
+
 int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b4c72a73594f..80d355c1dfb4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1031,6 +1031,10 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
+bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
+				   const struct mptcp_addr_info *saddr);
+bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
+				     const struct mptcp_addr_info *addr);
 int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
 int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info);
 int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
-- 
2.45.2

