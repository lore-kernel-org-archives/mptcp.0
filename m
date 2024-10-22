Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3D72209B
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588537; cv=none; b=jXTTq7SHqcvgYpeEu0mWZ0EXhY1QWN4mJkkC/EKYNUlF4uRw2w+CIXk66bAF6Z35a4Fm+W8WZsQViyhQ5yhYDuW36jssxUzvVnpfm0Z05G3sCwC42UjwUBlkwH6yLBxNPemZWzSn5ja80AdSIMUsnPQeHCNYKbpY1qUzkx5NtN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588537; c=relaxed/simple;
	bh=iZ+g+gL+A6ChUKfR9cvmHPAnT2lgxuRg9KZLbbMz2bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bhw8hbSOBS3KJ8ORhBU3+H7EezBWavvhQ5zzya+5Fjf1uMqXgEZYhCcEQXMr4dtHRcjwBHSGc53Kc973HaY0WV8IyX4qXU6GPIkOjOxr1xKuv9243hXwjCQstGEih7NyYtR47CFMAdP4nZov6Lhie5ytPHHw+KwaJW/eGz4Mp5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5Rfs7t7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5Rfs7t7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12747C4CEE4;
	Tue, 22 Oct 2024 09:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588537;
	bh=iZ+g+gL+A6ChUKfR9cvmHPAnT2lgxuRg9KZLbbMz2bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b5Rfs7t7MYHA7ip2V21LXzWB7PHZYNXKxXyC/zuxnSQUFXJ543+9aFBx7ntMTnX2i
	 tU5Q5Lm9U+XIU40+9PhoePYcbKbvjEmEc/zDz7bCxJ1hHAoMC+WGvyEAAFvIkGzCA9
	 qycmIF8kpK3iiUdHxhorKnCxOXr1AdO3ZnROR5PDZ0r2ts79tJP8qNfb2U2o/33Yoa
	 pQYywhLBKyInaD/pUWHVjZwaWFOlqvdCBNBeV0M4i9fJPbqnB2/hBTTtuk8DUSBBHN
	 DWtTy1adaBFHKgqISu6E+k2bdIXQS9OSpVTWQyO0coLH2vtvD3UZZCAU+nOqH9fO3Y
	 mZb6oedrzGsdQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 27/36] mptcp: rename mptcp_pm_remove_addrs
Date: Tue, 22 Oct 2024 17:14:35 +0800
Message-ID: <39ecde504cf3652ce36d526a78c920ba94cd550b.1729588019.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729588019.git.tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
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
index 06f0c7df575e..852706e43f13 100644
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
index 9dc01140af23..13cd97f9e0f7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1051,7 +1051,8 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
-void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
+void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
+				struct mptcp_pm_addr_entry *entry);
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 
-- 
2.45.2

