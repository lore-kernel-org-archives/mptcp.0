Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB4518C922
	for <mptcp@lists.linux.dev>; Tue,  8 Oct 2024 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381529; cv=none; b=JoaXOeoF/qg2dJF6vUZLmAZVQPOmoiwx5YzxiD3u3qserNLGTM30WgaHvgX6H8aJUr9k5hdryW+SPTgA0zIKmq81H00c5LCiNEFbAIYFoOgChjEOczQmq+UHzX/hXuNy8yMzaDV14R4JtW5zibr1V/IfZXorKQ0DvAOQFBDOUNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381529; c=relaxed/simple;
	bh=zRrDYSrsKOnxGUDLUv6SHHsyzHqehx5WeHxuztEZX9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDlv8FKULU97wiOSYWyEYbe6DBC0RH02YUCRfGSMZS+Ji2RK5Wvq9zd7l5//ZbSiLJh5WNkREVhHhhoJFlL7an0tKAtiAxP4AL8khi3QM3o6c/4tUuPFg0R+apcGOs5aPR3JVppc6ur9leUyEeZX5wPHZCd6R4ju/sxN8/ZmLRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q94nAM2H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q94nAM2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5753C4CECC;
	Tue,  8 Oct 2024 09:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728381528;
	bh=zRrDYSrsKOnxGUDLUv6SHHsyzHqehx5WeHxuztEZX9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q94nAM2H403vjQ/k6wj/Js4Df3zroTUzU5kgg9ScB7pis/7v6vPA+yjWX7Fm4qh32
	 gxSxFb8Liov1y1jQX0ikWtEaetwvzbQXV8GVae+cX/5boUbfDeTxrWQSb7lpT0h0cZ
	 HnevGf0eA0y/mKjHj33eZtGgb0nGa8nPIe+o/Y26dZuQa/xpXakKEPlpHNXIFvF6N0
	 Yh6oBxi/sd2KKAtKKkfYu/6iGLj21dtK6lMrAx2FAHTyOgl5bBpjl/yFUfGGOShVGb
	 1vqephuXyw0IJj+jLhVu9xc+syJNOTVBZkePKWsmE7pZMvHh6pMK6amD+4jt0SHZb4
	 LtpgHMKLR3SZA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 13/13] mptcp: drop free_list for deleting entries
Date: Tue,  8 Oct 2024 17:58:17 +0800
Message-ID: <a8e4b6f5daf87537cfe4d077b66c10c0fa220f61.1728381245.git.tanggeliang@kylinos.cn>
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

With the help of mptcp_pm_remove_addr_entry(), it's no longer necessary to
move the entry to be deleted to free_list and then traverse the list to
delete the entry, which is not allowed in BPF. The entry can be directly
deleted through list_del_rcu() and sock_kfree_s() now.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 9477c36d3284..4b2c3d0f685e 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -283,9 +283,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
 	struct mptcp_pm_addr_entry *match;
-	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
-	LIST_HEAD(free_list);
 	int err = -EINVAL;
 	struct sock *sk;
 	u8 id_val;
@@ -312,23 +310,21 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	spin_lock_bh(&msk->pm.lock);
 	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
+	spin_unlock_bh(&msk->pm.lock);
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
-		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
 		goto out;
 	}
 
-	list_move(&match->list, &free_list);
-	spin_unlock_bh(&msk->pm.lock);
-
 	mptcp_pm_remove_addr_entry(msk, match);
 
 	release_sock(sk);
 
-	list_for_each_entry_safe(match, entry, &free_list, list) {
-		sock_kfree_s(sk, match, sizeof(*match));
-	}
+	spin_lock_bh(&msk->pm.lock);
+	list_del_rcu(&match->list);
+	sock_kfree_s(sk, match, sizeof(*match));
+	spin_unlock_bh(&msk->pm.lock);
 
 	err = 0;
 out:
-- 
2.43.0

