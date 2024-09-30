Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90FBCA62
	for <mptcp@lists.linux.dev>; Mon, 30 Sep 2024 02:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727662494; cv=none; b=qCy2lXJxfsGYHjhTzbxEQDDgFN5hsdzAuf9u59gXFwUv9/xvNWCQVHQfbDH2NZYS7wShfDKLaCu3Pod6T9+bwWIg4+qnthcWDpJ6FEWg5b9jKViJkjvPm/n6ZREfgjm8SfWjRQeu4BN4NqxhJGlOui5D5UjIEgLCRCbGwbxrYio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727662494; c=relaxed/simple;
	bh=7XuCh0d4Ovn6nuBKIffBt5tRovofIBMcflO6SWJwz9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTpGM56hXy1fFPktoEumXjHt4+uUmdlUt0gECVsrwdqL4yQ60XLfsqxd/8negFoMbzQ4P++wKm0bC3E7vsNhCSueFbQo1/UQM88A7bLh45por870VU4bo0CjAWyHs9SRECMF1tOlZJeHRbzf7YucLLGAqQnUNPnxsZuf0aP1qyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUpwOfqP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUpwOfqP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37AEDC4CEC5;
	Mon, 30 Sep 2024 02:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727662494;
	bh=7XuCh0d4Ovn6nuBKIffBt5tRovofIBMcflO6SWJwz9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SUpwOfqPskxQ/Cs5PtfKfelG+GUzum4UI+85y2d1pBg9NEjMukgjHpcQtpQn6OOx8
	 YQnM/5qL95JjYsEeo388g21YSsVoc1LftqLtcq0K2ArceGjj5IX/hvbzPBjFOE0/1u
	 bQwyMhKD0yOeZawaVIWWSKM+z5AprxSOMbAyMBENqUllWMuxKBpl5O1kW22c+V52WI
	 yOp49lcEMZ2B5KJhNDCqhzBj53cNLK1t764Me7O43Fun+QhITUt4YW6JkU20bJEo3W
	 cYSuQRRwCD6lVrIgYH/W4+PH5UUCUwRHGzsT9KCPedLtix9nDLmkfR6kduusLF2I8D
	 1XysQNl8SHbRQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 8/8] mptcp: drop skb parameter of set_flags
Date: Mon, 30 Sep 2024 10:14:33 +0800
Message-ID: <a8d07920627c740b174fd76ccd334cd961704255.1727662123.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727662123.git.tanggeliang@kylinos.cn>
References: <cover.1727662123.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The first parameters "skb" in set_flags() interfaces are only used to
obtained the network namespace, which can also be obtained through the
second parameters "info" by using genl_info_net() helper. This patch
drop these useless parameters in all three set_flags() interfaces.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 12 ++++++------
 net/mptcp/pm_userspace.c |  4 ++--
 net/mptcp/protocol.h     |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f02378e9a9c8..0f2fe64fd568 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -2025,13 +2025,13 @@ static int mptcp_nl_set_flags(struct net *net,
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
@@ -2079,16 +2079,16 @@ static int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
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
index afff0ab3d5e9..703d13ef50ad 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -552,14 +552,14 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	return err;
 }
 
-int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
+int mptcp_userspace_pm_set_flags(struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
 	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
-	struct net *net = sock_net(skb->sk);
+	struct net *net = genl_info_net(info);
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 238fb2ddb68a..41d01a046e27 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1035,7 +1035,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
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

