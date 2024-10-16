Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF03205139
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070016; cv=none; b=UPwvIXoBRkOldrThLm7S9PEql9/xeEM5YHBh0VBwmlfQuJX2R1LSCSFtiS+sLEBw544wWbweZ8RSH4nVrKkgPJu6s4MIrc6NkLk9Y70bFyTgWhEp18wJrcYm/H1D6PQT0D6kckCgOUZUAiAfWOu49c/ujK2Tzs3q98aysQxo/ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070016; c=relaxed/simple;
	bh=BBUzVs3auqsq70ZKrGPUiTID457xHbiqoHg+mFLFqyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtVCHqDbtDz0aByTQdvASZ2iOkrjxjVLt6b4GPCnHOE8Z1HkrDe6VFhwzsbUM8nAJxVUVTDr31tnm6JvE+ZwJSlxKMNJWScrw5OWwh/qgXGgw6ztWBXf9zmWo2DM5uXOV1006adFqAlhnoNos4Kzgi/mIA+YYlNqWNH5eJz7O0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQJtk6yM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQJtk6yM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF047C4CECE;
	Wed, 16 Oct 2024 09:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729070015;
	bh=BBUzVs3auqsq70ZKrGPUiTID457xHbiqoHg+mFLFqyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PQJtk6yMVQ+zv0KTm0XVnT+6QIiKTfQMccVgSCN3nzFDrd8KgmNiIxvg3B5BN6qCc
	 KJ1LSvrm3pIbB+Cxm1ZhSAFq/bPiDErl9fJNyw85905SidNx1VaYKX/gLXS9a6tue+
	 EkRTIhrk5cARZQW08rGMkcofehwe55nSGN+LCt8T74A0SzmgEesUS8Gg0Ts8vVaSMZ
	 5qlx7JZieWpEmqyQAnqoyAD09npuqy3luN+X8QP5/TCO0ZCIgE8o9MTpV0M3gR80Nm
	 9qtsfgXify2wiHvzqh8CYoAzDT1OeOyoZasHgaGK99xEZvUWMm1u4De+K3in5WIPcV
	 BCPbK7jIcPzOw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 28/33] mptcp: drop free_list for deleting entries
Date: Wed, 16 Oct 2024 17:12:32 +0800
Message-ID: <1697f988f696e0e2898dbc61c4615f33ff9605bf.1729069854.git.tanggeliang@kylinos.cn>
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

With the help of mptcp_pm_remove_addr_entry(), it's no longer necessary to
move the entry to be deleted to free_list and then traverse the list to
delete the entry, which is not allowed in BPF. The entry can be directly
deleted through list_del_rcu() and sock_kfree_s() now.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 21b2a3b02cfe..e5dfa1a6db31 100644
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

