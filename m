Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93794161302
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588523; cv=none; b=Llqsh7zr4Hfsxq2qQQ/uq5g2Dz1DxL80ZviN70dim870boJQQ2+4LeFaVhbPcXLTUCE0HGt625jULIvsqWH9l6DFK5gXWZhL/kpyobOA/2UFuFGyAVUPeMs2+JvocFJbsHCIJLog9CuLmdYDsBAEP4pbNHSp3A9YIP6TTImN7ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588523; c=relaxed/simple;
	bh=dFGLHThz06rExs/fAbr2mk0TOgdtxj038k4ZTNTricM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbdDHJ0yGW/dXxR9cAGSaSUnitGH9TeOFYOkD2uLYbbteDgWAKQv9KAHBF9j3vXdNEj69o52C7pExvXWCUEFrz+Kkv3xsRgHPsfihOulO2qQiwCAXmPfbu//tqoOpjx7AdqXYgJ5f4kBlwmO9qbSHXzK50IzSFy2lrFm2FINN48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G495QJsI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G495QJsI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC5CC4CEE4;
	Tue, 22 Oct 2024 09:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588523;
	bh=dFGLHThz06rExs/fAbr2mk0TOgdtxj038k4ZTNTricM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G495QJsIISk9vqkWl0STDHG8LSXjTcNElVO4bNN6tofX9s3sluDH2tCPKohGT2lKA
	 QAvywfpG4qY42xJ93k9r7/uF6LL1rheONgzRebRFCM+BwzXm0tfoudPpwEpb5tFYy4
	 WyjBaX8+ZJcrf18UZGSWZa/LJGXnvhM+RtSD+vlGj0uLkAv41g60gUh6IpQcmOlzpH
	 p/4qZz0gyfYXOC1o/3B5QcIVzpIanFFv3byj6Uz9/C81/vCgGnFeMYBDu/p3BI5/Fp
	 uJH2dD/wm5MVo+xmkFeAV8hhqpEGUfQwbW6tEoGUz+5cxk++2Vwbj9IRgM6aT1bZDa
	 mSBzoXgbkBuvw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 19/36] mptcp: drop skb parameter of set_flags
Date: Tue, 22 Oct 2024 17:14:27 +0800
Message-ID: <8dc8cdb2401e8ebd5b0bd0fa5e8fe34752ca15ea.1729588019.git.tanggeliang@kylinos.cn>
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
index c6476cb464b0..5fb1d5d8bf57 100644
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
index 833ad44c6e65..29e39a790409 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1040,7 +1040,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
-int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
+int mptcp_userspace_pm_set_flags(struct genl_info *info);
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
-- 
2.45.2

