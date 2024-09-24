Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BF93F9D5
	for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 12:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727180854; cv=none; b=uXwQPgCTVRR5H0CtEgEQhG0iiuGdNWBOdlcwqV1WceqMCKhGCxJXnYmTIdTMh+GMl2Zk3yGR8KlCcU/Evw028YlR3GS3lEtTd5szD28DnY/ZSkIZHFlyHeaGu6hebXsPLB9QLllqEBRTw9uEToMq9T58S3k7mMlMskz64hiZoM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727180854; c=relaxed/simple;
	bh=Oi0rQIj+GQhZRLvZBEhGdLxDTlssXekAKlkSIpot/eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpfZu/thRscLdDnwWVRvq/ZGlx8C/QvU1vmFXaXYOetQUAW6EM9p75zxASBVEBc1FY8Kn+aiXto6S3GTKVkw/wPt7JaSlLEc4Wd4hQDIh8pi/ZO5+DXMGz1IcKhhsUlkDNop8KiTuFMVVyUYcBpC50mDIlEqrkGXQ0xQ1Y71x44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YphEljs7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YphEljs7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AA4C4CEC7;
	Tue, 24 Sep 2024 12:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727180853;
	bh=Oi0rQIj+GQhZRLvZBEhGdLxDTlssXekAKlkSIpot/eU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YphEljs7FrR7OBmYV2DAualgkgKFk06G6lGlmFOQ9cYchUogRTCi1XdpZiRE9UCgP
	 oEG2gMoBdIzFVBp1DxTr1q/GUTkLhBwB9m8GP57J7tQcVu2o7V70VAGEo2fQZhlJ33
	 mKzF0yN7WURpx693cHQCsJQKlHIzjTpSbQ4D5XCDqV596GbsBOOx+mpmU0g0XXi63S
	 TaBAN+Ubg3Bwr3dmMUsHvxHBOOwJd8/Rjo8TFPzPbJgerlFEg6t1yLEUK6v6xL+nEM
	 9zzzIYU3TxIi3OBlCWl37ElO4O/xFICmh2xQb/KEeCklNkMD2ASxofzG2BngDNfF5B
	 6vv/ndrEPojbw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/2] mptcp: drop skb parameters in set_flags interfaces
Date: Tue, 24 Sep 2024 20:27:25 +0800
Message-ID: <2d05ad2de44965015a89fa04217d9cf7df6816d5.1727180731.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727180731.git.tanggeliang@kylinos.cn>
References: <cover.1727180731.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The first parameter "skb" in mptcp_pm_nl_set_flags() or
mptcp_userspace_pm_set_flags() is only used to obtained the network
namespace, which can also be obtained through the second parameter
"info" by using genl_info_net() helper. This patch drop this useless
parameter in all three set_flags() interfaces:

	mptcp_pm_set_flags()
	mptcp_pm_nl_set_flags()
	mptcp_userspace_pm_set_flags().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           | 6 +++---
 net/mptcp/pm_netlink.c   | 6 +++---
 net/mptcp/pm_userspace.c | 4 ++--
 net/mptcp/protocol.h     | 6 +++---
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 58181e846cec..4b9f7077db64 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -456,11 +456,11 @@ int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
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
index ed236522a30e..9e2a866db1ad 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -2015,13 +2015,13 @@ static int mptcp_nl_set_flags(struct net *net,
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
@@ -2071,7 +2071,7 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 
 int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return mptcp_pm_set_flags(skb, info);
+	return mptcp_pm_set_flags(info);
 }
 
 static void mptcp_nl_mcast_send(struct net *net, struct sk_buff *nlskb, gfp_t gfp)
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index a68df40a62d3..0afbca4f7362 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -551,14 +551,14 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	return err;
 }
 
-int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
+int mptcp_userspace_pm_set_flags(struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
 	struct mptcp_pm_addr_entry rem = { .addr = { .family = AF_UNSPEC }, };
 	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
-	struct net *net = sock_net(skb->sk);
+	struct net *net = genl_info_net(info);
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ef66cc8c4d9a..d54ca66d1029 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1029,9 +1029,9 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
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
2.43.0

