Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80631D0493
	for <mptcp@lists.linux.dev>; Wed,  2 Oct 2024 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881337; cv=none; b=tWle9M4PSR9+OCRXxdleXJwcXwC4NPXfqp9uilJZkDTygFww+ga+yt6jqo6I78ITJxp/qAdvBy1rzQChMLUJrggA3mVadDQvxRQHd+2wYam+12RQqpGunZNRT7lZnNLfI/NqxsKhZ7q+JvU/8/O9Z0ZLyPrGu7MeavpDi1YjTfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881337; c=relaxed/simple;
	bh=XpojAtqqO9J2VcQRB1KZlG+XmYpULxs8EOGboWAXy5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGTiE4/JIs34cI6MoU7kenUnQaFatHe62kZOyHdsKWJO3feajYvmckVEYTZ2bVwyhBqSVQN6VraLzRrJrhc82nOUdR3R+t1tjc5u+I0qq1SpBcZXTJuYNXrlcL/Nx3wss7qbaP+DgDb9If6OcZvAV8+pzy/Uq/dRuP/n2UjkHy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjmUDlMR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjmUDlMR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09D4C4CEC2;
	Wed,  2 Oct 2024 15:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727881337;
	bh=XpojAtqqO9J2VcQRB1KZlG+XmYpULxs8EOGboWAXy5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QjmUDlMReW56jq3jSNc+pnDwrcIhY9VFbvnUD3CtcHiNh0XTenrqP7ucSh8fajP5k
	 t4RVsZWYMmECYc68GTLRFLqIJWUYb9u1kXdg7JsVjWGioY9dewC/A2LD/RcFZkAFGw
	 X84G1U/gEk2Xt16lPDaGRPGdckmiz2j7sRwlnTIEdx0F2+29EzNSSwGmcbsB7i8Wqa
	 U/A9GEDfXwyaX4f/Gt/jC5KhnYnq/4XU6OEOdIVnTgZLPaHdz/ypw3qw7NCO1Or4RO
	 pSX2JxMlERhybPqlArk8Q7qnV9a43aWheL6Tzsf+X3wJqVYhqHoB4yvlQ6RWrOwU49
	 Yi+pWDHbPZObQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 9/9] mptcp: drop skb parameter of set_flags
Date: Wed,  2 Oct 2024 23:01:59 +0800
Message-ID: <f6b8787c916435ad91522ae31e1afc7a30e4409e.1727881073.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727881073.git.tanggeliang@kylinos.cn>
References: <cover.1727881073.git.tanggeliang@kylinos.cn>
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
index 6711c1e1dac7..79531c949cc5 100644
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

