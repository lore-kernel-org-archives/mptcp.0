Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B0020514C
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070000; cv=none; b=ehWfxNyBLYwQ2xARyvHuRUDX01BwTvCVHf/aEFjxPg/s0LigEr/BUMHi3HymSIdr5uxYuDTr+NRpGHn63mnxlLYZ8j5EZP8KCSE0450n7Ppys1+A1C+rELbbH4yuP5yfkbCHQVGtVPn3p+2Xouhrz/vmOV0WJQI2jdQ+DVxc+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070000; c=relaxed/simple;
	bh=kfUD30z+wuwB3UVmoWg+8iIHWv3vLqopR3g5/nbKku8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOxbuLDHqpJWbtL6W1oRrWhvqzLfz581ZbVROOy09lhMKpW5dvXAmIL4bO+SVh08enRz+ouGG3l7CfBwIASpdAwiWR0n7CgvD8QSqRwvSGvtD7xT8+gB9xZYTPSPYQaBrNGJio6fjBGETq+zDWO1nX3Oa3EPBhHVuHFX3X2Yye4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSuuMw5q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSuuMw5q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6CCC4CECE;
	Wed, 16 Oct 2024 09:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729069999;
	bh=kfUD30z+wuwB3UVmoWg+8iIHWv3vLqopR3g5/nbKku8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jSuuMw5qFol+QYlS2qnMYAHRStpr4YGJsfNxSlf9XkYq95NP0WjTUU+wg6JRDFP+L
	 pAdxMs2FOZe1sNRTR79YSys51Aux5hpDcfJv/+TsrINwEEHFG29CmV0GGq4jWLHGZE
	 goLtyemXz27zE6PK5uKbxLpQvK7QUG+N1BLOPCzUPhNB9rIrwnelAy8TkzQFF3D18g
	 HAIqHGFqkDk84Zqg1RVX3XolsUbc2KCyiaV6dDN8r+HgH2TAvOLaSw/nKxP/EBrCRb
	 hEOOMZgnV8+CZv9ggkw4+z9BH9LzHmKTuxXIPlVbVzHnF00gnBk4z7t2htazHBLH1e
	 bVx46InD9U7sw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 19/33] mptcp: drop skb parameter of set_flags
Date: Wed, 16 Oct 2024 17:12:23 +0800
Message-ID: <7785a9908fe2d2c2172f7ab0a6c695d8ad43c61a.1729069854.git.tanggeliang@kylinos.cn>
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
index 558a7da8d995..0309f7dbd23b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -2045,13 +2045,13 @@ static int mptcp_nl_set_flags(struct net *net,
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
@@ -2099,16 +2099,16 @@ static int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
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
index b83f4af632b5..4db39bf26cf4 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -537,7 +537,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	return err;
 }
 
-int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
+int mptcp_userspace_pm_set_flags(struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
 	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9ac39781a681..7fd5a7644a8d 100644
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

