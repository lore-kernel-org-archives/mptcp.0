Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DFD38384
	for <mptcp@lists.linux.dev>; Sat, 12 Oct 2024 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728742813; cv=none; b=EX4fpstkA4fDDcI/JQeik1Ov3gddMBTNkq75kCulECmiwMczXzeC6q53a2DpJ6yt5qUHhEPQYRe+5/YCO5O/frwfhxn6YF6x5F3W1HY1G9de3erUq0fmFNPA+e77sq1NzcodQUrWtGqjOoe5DcA9oW9KBcVJTQPK7fIhkogFfr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728742813; c=relaxed/simple;
	bh=GTEfHQ+GOpTEN0crPUauUKK7A+Fw96byp1dEzQF8zaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NlM/jp6F6f3JrTaRcECFe6wVz886kTcwEM/0dpUyn/5jpyxlXEXiHdXrnkSfVLRJufzWmMVsKd3/kPY0mZo1ac8lTO2pR+n9tF6wgbHCmvOKbpGNjICrKQBk5dIviZgJbhARYdm+7bvXXUHVEm9korZ82P0Lz3GOkkLgOp1/EZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvycuoVw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvycuoVw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6D5C4CEC6;
	Sat, 12 Oct 2024 14:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728742813;
	bh=GTEfHQ+GOpTEN0crPUauUKK7A+Fw96byp1dEzQF8zaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EvycuoVwrYV2gJaG5I4IR4qoFtfFt362yc3FP2NVuLBUHciwPfVH45/qTxNxwU8vj
	 QxYqUUu861jSMLljXrb3tGUmw2i6LXJHyQ+ituRWMwEwm/ACVcy/+ZXL6IOvvChbO3
	 EQ2GuU9ZYeTBAyvpyD77ACsqE7GTKmJaLa4wyeMjTjHkOX+96euwpA6AH1Zn4+Qwz9
	 4MUMjZZNBROhHuMnF74eBlfb2keMg+XtBJZmmlkTvvjj7IlalIZnbIXlLTzWEu+0Z4
	 wAM7jLm8l7OdWpKfAoKs5URalOYEjt+kJ9Pce+YFH5aEI2z5xsSmlQo9/wkMYeaTDE
	 deq4j5J92vchg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 10/11] mptcp: drop skb parameter of get_addr
Date: Sat, 12 Oct 2024 22:19:50 +0800
Message-ID: <4ab1979d352cc735128f607897a7053937c1ca47.1728742592.git.tanggeliang@kylinos.cn>
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

The first parameters "skb" of all three get_addr() interfaces are now
useless since mptcp_userspace_pm_get_sock() helper is used. This patch
drops these useless parameters of them.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 10 +++++-----
 net/mptcp/pm_userspace.c |  3 +--
 net/mptcp/protocol.h     |  3 +--
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5a731282618e..c7db0823702a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1792,7 +1792,7 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-static int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_nl_get_addr(struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
@@ -1842,16 +1842,16 @@ static int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_get_addr(struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_get_addr(skb, info);
-	return mptcp_pm_nl_get_addr(skb, info);
+		return mptcp_userspace_pm_get_addr(info);
+	return mptcp_pm_nl_get_addr(info);
 }
 
 int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return mptcp_pm_get_addr(skb, info);
+	return mptcp_pm_get_addr(info);
 }
 
 static int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index f8a045e4f0cb..a89c91f030db 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -629,8 +629,7 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	return ret;
 }
 
-int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
-				struct genl_info *info)
+int mptcp_userspace_pm_get_addr(struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct mptcp_pm_addr_entry addr, *entry;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f8a08d2ccf1a..f4bf6f843fe6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1130,8 +1130,7 @@ bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
-int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
-				struct genl_info *info);
+int mptcp_userspace_pm_get_addr(struct genl_info *info);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {
-- 
2.43.0

