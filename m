Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D33B205E00
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070014; cv=none; b=kqXgpAf6eC6raOGAVe9zRsO/hMv+kJ/UU5535kBIxcCaqbkEK6d2H2pKqtLsjzPw/uAXPdMEGPAJ9Op32Su9tktK4riwBZD3/Ii8cKwo2KJJZ+H0n3NMYz65/86fz3Ttp1ZvJd+UX+1Zo1DV9BPk7rtzmlSUXJSS2hSMhmIWmYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070014; c=relaxed/simple;
	bh=AVWBP72aKbyfSXSlrmm7V5GSquEAqs5+weXMdIvfEDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HC+R+AO0VA6JNZq3jkfLX4XiTT5b2u0983hxWw6yPTy0Jx+43AIMEerEup5UaFiMG10Pb0Fqmp+LoSZN5nDeRXLJjGu0fW1gCNuVP3Yun1pRi7mlxGlS7qqZSdesMsuYg78fk+2Yx9Wbr8ZG5Nih7lmFsDsT0/xHTdjDKh2HBtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1qwauWH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1qwauWH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58B0C4CEC5;
	Wed, 16 Oct 2024 09:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729070014;
	bh=AVWBP72aKbyfSXSlrmm7V5GSquEAqs5+weXMdIvfEDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f1qwauWHPysbJdJbTHaeQxFEStqZYQ39lt89M5nBh1+sBlsi5/MaagHsWmKEccY40
	 YRrclAr7J4loOq+I/NjFaGiEhPkD9kOb0l2ESnp1xMHvkYh+ikoL/Ej5uB5DWeRyAb
	 kL5xLYzSUPM/csxiIcsAjuc99pVdqAqWjIPa3oTLq6ZyZZzlNsCNs9bYqnTUii952L
	 IkeFCUdIGcqKw4i69YYhmCcIqREkkM+Nj/okGkcxIaMPWIvVOnaYhI/7xWqkTC/rEB
	 GElmoFeusq2hK58MyveU/2PW460IXYiDjWtu39RDWGy4gS6jCVJGVSbLEypq+HIsay
	 vVJLSQIANzVJQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 27/33] mptcp: rename mptcp_pm_remove_addrs
Date: Wed, 16 Oct 2024 17:12:31 +0800
Message-ID: <ff802d2c9d8861c556e37ae935179a57ea3f8bc1.1729069854.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729069853.git.tanggeliang@kylinos.cn>
References: <cover.1729069853.git.tanggeliang@kylinos.cn>
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
index 016ea8aba625..bb65f8614134 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1615,26 +1615,22 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
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
index 3ad10d8062d9..21b2a3b02cfe 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -322,7 +322,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	list_move(&match->list, &free_list);
 	spin_unlock_bh(&msk->pm.lock);
 
-	mptcp_pm_remove_addrs(msk, &free_list);
+	mptcp_pm_remove_addr_entry(msk, match);
 
 	release_sock(sk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2423079662d8..b1669c36a3a8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1049,7 +1049,8 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
-void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
+void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
+				struct mptcp_pm_addr_entry *entry);
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 
-- 
2.43.0

