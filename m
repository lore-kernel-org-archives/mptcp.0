Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE5838384
	for <mptcp@lists.linux.dev>; Sat, 12 Oct 2024 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728742815; cv=none; b=IcJ+4brAEczCllXg5/JRUtYvaRpiMVJSA1XCzUvuKWa1R1PB0J6uDu8WtU13zB/boV/r3hDie2WOKoJMkJs9gnPjz1VaWes4nJFkDpHPDNGFaMiUXTMIgBulUGsXN2Z6nL4Pd5jtjevLqWopkdEKtUCrdpkAVKTHA5dWNusP6tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728742815; c=relaxed/simple;
	bh=AA4jUiBqJ8LRDAXJy4kuxnz9I8RG73PLukeFPXiS37A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRCsFJkLVK6hdBMdBncIPOi24arUWsGqnGB7SeqAr1baHb7iQaiQAeKTcjOilVH3lMKO71uYrqxNSEQ1jHICAqZwUgZk8hUxGYGKKPCERfNb4b6qvF07KIaogLsZN/jmIsIOMGIIbPL4h5IEHyhaD8QKXnqxsIFHFKYBA3pg+Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYIlVeWI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYIlVeWI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23F4C4CEC6;
	Sat, 12 Oct 2024 14:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728742814;
	bh=AA4jUiBqJ8LRDAXJy4kuxnz9I8RG73PLukeFPXiS37A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XYIlVeWI/NJaWi8wMKE12izGOZiZibC+monJJ/tvc+IFhb2iRGmeFMh+y0AD+hnmS
	 xERuK8wS72Ri+fZr5rMNMbR+Bj2Tn/XrtmOwdnjDvpvpn2YVk3dcEv3fiFeDHRCa6+
	 gvOfnKYQlyyU5fpmgKPiALP51oOckYvzue0lJtMrZeNZeY2qHnRO+Xd/oq4qNA+SDT
	 7WPlD/fLjefrdmHWSgq52+4nwypwB8OUU8UCEds5xHmnQK82UAOu7qF7gb64Pt/HBI
	 sw8LF2kt6C68OexsCSlDv/5M2hGIjDGWZlvLsCmNKKtLB3DxrGMvPuuwTkLIz1RUeF
	 D8ZfhqmXMqLvw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 11/11] mptcp: drop skb parameter of set_flags
Date: Sat, 12 Oct 2024 22:19:51 +0800
Message-ID: <2004142685fcd149b98e24ad6b0f2afa203a2573.1728742592.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728742591.git.tanggeliang@kylinos.cn>
References: <cover.1728742591.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The first parameter "skb" in mptcp_pm_nl_set_flags() is only used to
obtained the network namespace, which can also be obtained through the
second parameters "info" by using genl_info_net() helper. This patch
drops these useless parameters "skb" in all three set_flags() interfaces.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 12 ++++++------
 net/mptcp/pm_userspace.c |  2 +-
 net/mptcp/protocol.h     |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c7db0823702a..78f8d78f0392 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -2027,13 +2027,13 @@ static int mptcp_nl_set_flags(struct net *net,
 	return ret;
 }
 
-static int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_nl_set_flags(struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, };
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
 			   MPTCP_PM_ADDR_FLAG_FULLMESH;
-	struct net *net = sock_net(skb->sk);
+	struct net *net = genl_info_net(info);
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
 	u8 lookup_by_id = 0;
@@ -2081,16 +2081,16 @@ static int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
-static int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_set_flags(struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_set_flags(skb, info);
-	return mptcp_pm_nl_set_flags(skb, info);
+		return mptcp_userspace_pm_set_flags(info);
+	return mptcp_pm_nl_set_flags(info);
 }
 
 int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return mptcp_pm_set_flags(skb, info);
+	return mptcp_pm_set_flags(info);
 }
 
 static void mptcp_nl_mcast_send(struct net *net, struct sk_buff *nlskb, gfp_t gfp)
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index a89c91f030db..19626b254b76 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -536,7 +536,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	return err;
 }
 
-int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
+int mptcp_userspace_pm_set_flags(struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
 	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f4bf6f843fe6..5bdddd175799 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1038,7 +1038,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
-int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
+int mptcp_userspace_pm_set_flags(struct genl_info *info);
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
-- 
2.43.0

