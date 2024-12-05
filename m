Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65822391AB
	for <mptcp@lists.linux.dev>; Thu,  5 Dec 2024 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733382919; cv=none; b=UnMjCUn0kmk1Nf+eB55c5iZeOAwJl3/CHFJYRrvmVTyviXVpxf3ilgnRow13dB/plwyMezscpt5Dx6Cf7HK1bZihkfmFoBE7OTbSnfcaqWz72NH+pn+n6pXGQkdZ9MPQx/ngy0dFr/sJwf1F9GX2eN0l9/IJEJXNANciwI5HBw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733382919; c=relaxed/simple;
	bh=0Jj9HWHIbFCVbtSh6CXl3ItsNo9oF4CUzr15UbTWLCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csFUQS9rJvCqrSUiaGlzSYrimIneVYu1m6gQkp44Jx/WqRwZDji9HUCrbn8rpMMXSetOnNlkYF2BEyBS0D5uXkdrkqg+nUzyu+OWEGmrngmnbrwP0CzO/MuUHmvIxrQKGi3LbN2y2wEuIcUYHhSRpH3TdLeOyFQplcqZ+ASNqcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTOlfy/5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTOlfy/5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B907EC4CED1;
	Thu,  5 Dec 2024 07:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733382916;
	bh=0Jj9HWHIbFCVbtSh6CXl3ItsNo9oF4CUzr15UbTWLCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CTOlfy/5uth5dUuP+0zlnXrEHqXDzgd2MkXTXNfUrSofp00DIEiMqQsX4WgtwzFzK
	 r89r2ZUPGF+MZH+A8j3FhNYJry/sfH36XpdvZ+Z9dk8NykLEnCECSLjG8rTON+tbbM
	 6X2wNy4brlMTwJEjHGjZ+38NcTZwMVDPBADSs2oDGJpTri/Ejcbpl/7AyPTC2sLNPV
	 gXawQXkLKjMC9luc6sjPAxGYBMvrXfjNyo8SfrV7WZNM6kUIjyM8FVdC14G68rdX/x
	 nzie33pxc7sGztbGEFFg4900d2RPP9p6lrun0pkEH21ThEyI+iZB4BZIN3wVldgbUz
	 RZ484dV89gXFg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 4/7] mptcp: move mptcp_pm_remove_addrs into pm_userspace
Date: Thu,  5 Dec 2024 15:14:56 +0800
Message-ID: <0ace5dfd29f804ee8496632dcf4d41702ed41a9f.1733382223.git.tanggeliang@kylinos.cn>
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

Since mptcp_pm_remove_addrs() is only called from the userspace PM, this
patch moves it into pm_userspace.c.

For this, lookup_subflow_by_saddr() and remove_anno_list_by_saddr()
helpers need to be exported in protocol.h. Also add "mptcp_" prefix for
these helpers.

Here, mptcp_pm_remove_addrs() is not changed to a static function because
it will be used in BPF Path Manager.

This patch doesn't change the behaviour of the code, just refactoring.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 46 +++++++---------------------------------
 net/mptcp/pm_userspace.c | 28 ++++++++++++++++++++++++
 net/mptcp/protocol.h     |  4 ++++
 3 files changed, 40 insertions(+), 38 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7a0f7998376a..98ac73938bd8 100644
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
@@ -1447,8 +1447,8 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
-				      const struct mptcp_addr_info *addr)
+bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
+				     const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *entry;
 
@@ -1476,7 +1476,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 
 	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
 
-	ret = remove_anno_list_by_saddr(msk, addr);
+	ret = mptcp_remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
 		if (ret) {
@@ -1520,7 +1520,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		}
 
 		lock_sock(sk);
-		remove_subflow = lookup_subflow_by_saddr(&msk->conn_list, addr);
+		remove_subflow = mptcp_lookup_subflow_by_saddr(&msk->conn_list, addr);
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
 
@@ -1633,36 +1633,6 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
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
-/* Called from the in-kernel PM only */
 static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
 					      struct list_head *rm_list)
 {
@@ -1671,11 +1641,11 @@ static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
 
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

