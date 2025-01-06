Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AC41D6DBF
	for <mptcp@lists.linux.dev>; Mon,  6 Jan 2025 08:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736151390; cv=none; b=rkVdETRZKO2HaJaKFO9fi2SQfSquTPy+xJKqqxetBkNmBeuAuvYBHy15Fuaqn6+6jdq09XsqWgffV6d7sTS6rsaTCUHe0tw287BZE5o+o9ivlfz1eTyMVhbv6LvFSiiz1UsW+cg1QVSWmncLoAof+M/SyjSL5m3BNsMTIt3eGlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736151390; c=relaxed/simple;
	bh=wI6ofz3nZfUTpSPw/5n7zNyWaeSuaj6fkcS2nCy+Pm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/ifBVR9wZN3inmy8AeIJbPm41iCWEjdJVh6YfK/VefbYh9r9L1n2d5BjcX99alNLNzZvz8ZQ/h90fwxe7thEGC1Jqf0pgjCd83D/XVFB8W10p8tP9WKTBaXgDIHErNJobQbU2Zz2HggDjq6L5CqxxWUFnLfczkYez+n7yptnrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KooS8Mk/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KooS8Mk/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2691EC4CEE0;
	Mon,  6 Jan 2025 08:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736151389;
	bh=wI6ofz3nZfUTpSPw/5n7zNyWaeSuaj6fkcS2nCy+Pm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KooS8Mk/aUi+Q6QXnUYsDMKh6H9R0wg4D6t8lWWvg/5wz2H7Wg/wu6GJliE04tUWU
	 /dovYaT0/GSAXoeej2iOncmKag+DEooJIhrTXmSOLuzEARLoyDboefHOGS1UeK1UVH
	 XqLheB7ig8vc2VAawehHpzy4QJ+2Znxe/XkIAt/PfhCO/8KtpG75oANWR5XNZ8Trl5
	 3ORNpBWiopN/ZWdlxslIDgZH0mn5dqG0xvovluxbDOHyZMpn4q3FL8vGOt5oyNr7ew
	 g8XsX+/ivv42/TY3LkGkVs8Vd9sss2my8wULQvAMmeKjvXmcPSDS7JiN2AIibHWDTT
	 eMnIVUVakyY1g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 03/11] mptcp: drop skb parameter of set_flags
Date: Mon,  6 Jan 2025 16:16:08 +0800
Message-ID: <e6ce3e7b886a93b83f402dd79db216255d9b1fda.1736150983.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736150983.git.tanggeliang@kylinos.cn>
References: <cover.1736150983.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The first parameter 'skb' in mptcp_pm_nl_set_flags() is only used to
obtained the network namespace, which can also be obtained through the
second parameters 'info' by using genl_info_net() helper. This patch
drops these useless parameters 'skb' in all three set_flags() interfaces.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           | 6 +++---
 net/mptcp/pm_netlink.c   | 6 +++---
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.h     | 6 +++---
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 16c336c51940..6cd69ea9a69b 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -449,11 +449,11 @@ int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
 	return mptcp_pm_nl_dump_addr(msg, cb);
 }
 
-int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_set_flags(struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_set_flags(skb, info);
-	return mptcp_pm_nl_set_flags(skb, info);
+		return mptcp_userspace_pm_set_flags(info);
+	return mptcp_pm_nl_set_flags(info);
 }
 
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 98ac73938bd8..e9747bc948b9 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1981,13 +1981,13 @@ static int mptcp_nl_set_flags(struct net *net,
 	return ret;
 }
 
-int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_set_flags(struct genl_info *info)
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
@@ -2037,7 +2037,7 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 
 int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return mptcp_pm_set_flags(skb, info);
+	return mptcp_pm_set_flags(info);
 }
 
 static void mptcp_nl_mcast_send(struct net *net, struct sk_buff *nlskb, gfp_t gfp)
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 60db72060e6e..51fd84c49474 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -569,7 +569,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	return err;
 }
 
-int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
+int mptcp_userspace_pm_set_flags(struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
 	struct mptcp_pm_addr_entry rem = { .addr = { .family = AF_UNSPEC }, };
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 891ffcfd1088..df5619ae8a14 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1028,9 +1028,9 @@ bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
 				   const struct mptcp_addr_info *saddr);
 bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				     const struct mptcp_addr_info *addr);
-int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
-int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info);
-int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_set_flags(struct genl_info *info);
+int mptcp_pm_nl_set_flags(struct genl_info *info);
+int mptcp_userspace_pm_set_flags(struct genl_info *info);
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
-- 
2.45.2

