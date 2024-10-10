Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55762178372
	for <mptcp@lists.linux.dev>; Thu, 10 Oct 2024 05:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728539302; cv=none; b=Omg5WlNxC1mOMYGXBBaucoPZQ5xL6q58gzu00qvBIEfDL1kEhvW1BtwDfulKvlIsMCb3EIc+gSjtGGZhmE/0q9IuupFopKyV+xZVWQ+QdmDvgrC69kREbk169WuzA3z2a3ICWPu/TelVqf4fsiUDrESsKAPwqqbf/+I9TFc5VOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728539302; c=relaxed/simple;
	bh=u33sk5osIycHjfP9lOjfe8RW0Fp0teGMDc5JzCiKyoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IslBRNO1xH0LuTn93bLaIx3ch3D8FZzO9oSsNGziKaCxSRbLY4YpyqIGgimOSGRPtX1bollyjyK8k4aJyQTq37V/7xh/RRoagwjvoVrF7sI+VRu1zW65lmBgkoYGpwLp6AhfKFC9MdYYdCroW0ZB4qrmSspTgbbC2pGgWMizgXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKF0Wipm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKF0Wipm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5933C4CEC5;
	Thu, 10 Oct 2024 05:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728539301;
	bh=u33sk5osIycHjfP9lOjfe8RW0Fp0teGMDc5JzCiKyoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TKF0Wipm+/zzlkWkTdCX326gIaXUv1ILCzgcf1F56kV80YsyXEFGCGH5CMdtSsU1H
	 L3vBhi6oPekxbUsco6cOdIRKcbASS1tDNIqUeeGOvVT1zvrcT0Qp1WuxTXM5C2wfqm
	 /6jbbEtYYJwJrjFcJegE7EgmWJazePQkm+ksYK2HGofYv3UCFCIfZa0f+/unlo4+4c
	 1R40D2L9IvsqmI4ESJG9tdzotrzlReSzcsadfdjbJ9zRkYIuNHDnYGLtupf/OojieA
	 /vLufffzavodSPKS8dlqIMqcA0OtLx/UjqveZxCXMINlnH/baaDAJ4+H7ZTMDkohev
	 MHt3XQKgx9THA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 08/15] mptcp: add loc and rem for set_flags
Date: Thu, 10 Oct 2024 13:47:53 +0800
Message-ID: <9c827661f3ea58adf238c4bd2912cbe7212f579c.1728538976.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728538975.git.tanggeliang@kylinos.cn>
References: <cover.1728538975.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch updates the interfaces set_flags to reduce repetitive code,
adds two more parameters "loc" and "rem" for them. These addresses are
parsed in public helper mptcp_pm_nl_set_flags_doit(), then pass them
to mptcp_pm_nl_set_flags() and mptcp_userspace_pm_set_flags().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 38 ++++++++++++++++++++++++++------------
 net/mptcp/pm_userspace.c | 26 +++++++-------------------
 net/mptcp/protocol.h     |  4 +++-
 3 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0309f7dbd23b..96d7ccb355ae 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -2045,25 +2045,21 @@ static int mptcp_nl_set_flags(struct net *net,
 	return ret;
 }
 
-static int mptcp_pm_nl_set_flags(struct genl_info *info)
+static int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *loc,
+				 struct mptcp_addr_info *rem,
+				 struct genl_info *info)
 {
-	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, };
-	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
 			   MPTCP_PM_ADDR_FLAG_FULLMESH;
+	struct mptcp_pm_addr_entry addr = *loc;
 	struct net *net = genl_info_net(info);
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
 	u8 lookup_by_id = 0;
 	u8 bkup = 0;
-	int ret;
 
 	pernet = pm_nl_get_pernet(net);
 
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
-	if (ret < 0)
-		return ret;
-
 	if (addr.addr.family == AF_UNSPEC) {
 		lookup_by_id = 1;
 		if (!addr.addr.id) {
@@ -2099,16 +2095,34 @@ static int mptcp_pm_nl_set_flags(struct genl_info *info)
 	return 0;
 }
 
-static int mptcp_pm_set_flags(struct genl_info *info)
+static int mptcp_pm_set_flags(struct mptcp_pm_addr_entry *loc,
+			      struct mptcp_addr_info *rem,
+			      struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_set_flags(info);
-	return mptcp_pm_nl_set_flags(info);
+		return mptcp_userspace_pm_set_flags(loc, rem, info);
+	return mptcp_pm_nl_set_flags(loc, rem, info);
 }
 
 int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return mptcp_pm_set_flags(info);
+	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
+	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
+	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
+	int ret;
+
+	ret = mptcp_pm_parse_entry(attr, info, false, &loc);
+	if (ret < 0)
+		return ret;
+
+	if (attr_rem) {
+		ret = mptcp_pm_parse_addr(attr_rem, info, &rem);
+		if (ret < 0)
+			return ret;
+	}
+
+	return mptcp_pm_set_flags(&loc, &rem, info);
 }
 
 static void mptcp_nl_mcast_send(struct net *net, struct sk_buff *nlskb, gfp_t gfp)
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8858877d82b0..5175c30bcd64 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -536,12 +536,10 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	return err;
 }
 
-int mptcp_userspace_pm_set_flags(struct genl_info *info)
+int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *loc,
+				 struct mptcp_addr_info *rem,
+				 struct genl_info *info)
 {
-	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
-	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
-	struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
@@ -553,28 +551,18 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
-	ret = mptcp_pm_parse_entry(attr, info, false, &loc);
-	if (ret < 0)
-		goto set_flags_err;
-
-	if (attr_rem) {
-		ret = mptcp_pm_parse_addr(attr_rem, info, &rem);
-		if (ret < 0)
-			goto set_flags_err;
-	}
-
-	if (loc.addr.family == AF_UNSPEC ||
-	    rem.family == AF_UNSPEC) {
+	if (loc->addr.family == AF_UNSPEC ||
+	    rem->family == AF_UNSPEC) {
 		GENL_SET_ERR_MSG(info, "invalid address families");
 		ret = -EINVAL;
 		goto set_flags_err;
 	}
 
-	if (loc.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
+	if (loc->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
 
 	lock_sock(sk);
-	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem, bkup);
+	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc->addr, rem, bkup);
 	release_sock(sk);
 
 set_flags_err:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d8870ba24d02..742a35d41cdd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1033,7 +1033,9 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
-int mptcp_userspace_pm_set_flags(struct genl_info *info);
+int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *loc,
+				 struct mptcp_addr_info *rem,
+				 struct genl_info *info);
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
-- 
2.43.0

