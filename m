Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC8A18C922
	for <mptcp@lists.linux.dev>; Tue,  8 Oct 2024 09:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381527; cv=none; b=Nl+AuPD+vh7A+XJd3q98Dbkdkl28mYr+VwdqTvGO4qfWFJqAkpQKGxuA9KuMJIKlXlxzaxP3yXZFXbR+Oj8dENZICxQn4PFxn+lNleCe3GmTW8PuwT8eowRJ7lWVHg7E3LQN4oEORcgiMaUXebdJsnT32RcLRtTxdmieLtyjemY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381527; c=relaxed/simple;
	bh=3TEaDCpeIFOzPpIRF2HS5WqzoIr5eq6TGeiwz9Ynfvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEd/WxArPaVipvwWZ5ajK33vhzk5T179AsfO2Mzxw+NQSvXwol5mVDbtGwFyqfFDjyriIbIu6nBEc1wkyLnLud0nX2FIn8oTpsgkpzom7BKv7zXQoz+yqRXX2IDdkEv0xzggJgDjBvL7ffhHJwZiYDna1FrkcczbZ1bVMjzV/XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4MgN9Ba; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4MgN9Ba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5679C4CECC;
	Tue,  8 Oct 2024 09:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728381527;
	bh=3TEaDCpeIFOzPpIRF2HS5WqzoIr5eq6TGeiwz9Ynfvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J4MgN9BaefY2N2AtZybHFazU8yCSA/L/hBPj5BfSaiMhFRGYzJ458R2oJ4Les69I/
	 EsWOaRoy0p0g04qAv3uIPfYDfYoSR19PjeFFCuOipssBJXRf5hbrpI95BmJOyLX+c2
	 Mo5q37wWtirF+7QGahcHGzYgxv9/1bRG7/uVzeyybaT3mQ5jBXXYynZ5zFMYSAb/gM
	 ZdmPEJd6EMd+9HbTvfJfq2zC9FayUfumBPr/DMCTj+uQLgZzmGEkJSK6YyzzQJwnWk
	 9c3XFaQEwjxX8n/Dg2dIOKh+TGWHCoFUD+ZO7gN47eAsi+yG1nbWVPxq1Ktm3xJmRK
	 3cPY3sZF6w0xw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 12/13] mptcp: rename mptcp_pm_remove_addrs
Date: Tue,  8 Oct 2024 17:58:16 +0800
Message-ID: <0f3f63d984ac169f1587c0dc13b8c2fd66ed72d1.1728381245.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728381245.git.tanggeliang@kylinos.cn>
References: <cover.1728381245.git.tanggeliang@kylinos.cn>
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
index 4de3e0060af1..b7effacb5043 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1628,26 +1628,22 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
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
index 16a51eb4c585..9bbc105771e1 100644
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
2.43.0

