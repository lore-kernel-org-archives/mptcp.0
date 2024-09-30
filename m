Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1A6D530
	for <mptcp@lists.linux.dev>; Mon, 30 Sep 2024 02:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727662492; cv=none; b=XeoHXicuTJyFZpYQRzQ0LPeJ56EtQuYkDW2bfq9RetOVnJAE1WpYNcRWC3tkdeCnp4zFgQIXTk9FDIxoSdMJPjRNKlsvADpAaIxsP9UadLumrnt1HzqLf8tT35tp5kErRsWHYu9erW33CPLW1yI6feoCgpaYf7LDOofF1RNZIN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727662492; c=relaxed/simple;
	bh=WGRaLJwwO0W+1flFc/Bo81vNeemcfv4dBknhtzx2qZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EU5gjn258J7euvxXG3cM1ZxryxsZ8KEi6fcFjqXBAgSXHbLf5wNoVqH/Bsw1aKKCSi/b0X77n7KoRNIQX4fX7wPjDv9pY8h9d3/FCicFtH+N7iiedewegspeJGlgbRY7bqyTtawkWJVSxfryhRbEZDp6roUKcxz58d2M0Mtin7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0/yhZH7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0/yhZH7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F46BC4CECE;
	Mon, 30 Sep 2024 02:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727662492;
	bh=WGRaLJwwO0W+1flFc/Bo81vNeemcfv4dBknhtzx2qZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F0/yhZH7LHgDcqMYMb24o60Tp5KDqUcffvWbZ98r45niplLhBFeOisS3/LThudBSs
	 AZ53GPU7jtUP9ksxbuz8mCWsbZkkyrBeDZHOdmKFg/KgHxsCvGGK/n2r8VjbfBts+i
	 FxqlwUh7GBbaiEMpSHM9xAZ64/pwgoBH5r0i1f4iv0VOAqMawpxH5TMNB2NhpTLGKa
	 5LpOsunB2CK7i1uOdKP5o3o9RRmYGKo/XVExVqT0HRlDPXycqWjAA8K3QhkXm8uOkK
	 X1fgkIMcmkK4ULgSLVCglHCEUy/sZijsST+CLjCLKeKfdtmVsGNTmQuIJawyv58F6G
	 B5PpRt/9//rmw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 7/8] mptcp: drop skb parameter of get_addr
Date: Mon, 30 Sep 2024 10:14:32 +0800
Message-ID: <87b0071b3072da6925b2bb080e36dfec1847d5d6.1727662123.git.tanggeliang@kylinos.cn>
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

The first parameter "skb" in mptcp_userspace_pm_get_addr() is only used
to obtained the network namespace, which can also be obtained through the
second parameter "info" by using genl_info_net() helper. This patch drop
these useless parameters "skb" in all three get_addr() interfaces.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 10 +++++-----
 net/mptcp/pm_userspace.c |  5 ++---
 net/mptcp/protocol.h     |  3 +--
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d7a4199b142e..f02378e9a9c8 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1790,7 +1790,7 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-static int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_nl_get_addr(struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
@@ -1840,16 +1840,16 @@ static int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
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
index ff82ae39d5cf..afff0ab3d5e9 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -668,13 +668,12 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	return ret;
 }
 
-int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
-				struct genl_info *info)
+int mptcp_userspace_pm_get_addr(struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct mptcp_pm_addr_entry addr, *entry;
-	struct net *net = sock_net(skb->sk);
+	struct net *net = genl_info_net(info);
 	struct mptcp_sock *msk;
 	struct sk_buff *msg;
 	int ret = -EINVAL;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 95533d5b82c4..238fb2ddb68a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1127,8 +1127,7 @@ bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
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

