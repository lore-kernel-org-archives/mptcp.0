Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD35342AB1
	for <mptcp@lists.linux.dev>; Tue,  8 Oct 2024 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381507; cv=none; b=I2QIl3FW33g/PuB+NdX0WpvxoGjhCMbvmYguHbn9zQ1hIRf4iJFRJUvhXC2ZxWk/YYb+xu31ZXV7mG61+SSIHhVFcEXY51WBPWDRGgO+2/pf7MHXllix62bBT7r837Z9Y1GN/G1sKxeZRPu8N5SNF54tMRLpLzlyjYcmU1aw91U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381507; c=relaxed/simple;
	bh=lR8ulhf/WLrokobrcHDyYE80x2jmu30pc2zQ6/o952w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tX/ee8lsNUIbW1R/nkHShWzn6wh9nrrb4IeiN0eKCRHuxFLwvAFZtXFI4zaDDcel7u8AmYSQsWg4lkcVXs/QcpAn64+aOhhoDB3OKBlnqpYl7GjtHwnMP8mCAecDuo0uTDSsnola0DHD3RCLhMmvNIEinmnZ2pzQiBsBQQ10rlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCdOOlZ/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCdOOlZ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91B2C4CECC;
	Tue,  8 Oct 2024 09:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728381507;
	bh=lR8ulhf/WLrokobrcHDyYE80x2jmu30pc2zQ6/o952w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pCdOOlZ//MOyhLCZhtG8Gin1xBFiQ3Jev376p9tY7HSmo/Cdkk4FifsTQDVa36MTG
	 9Qq5yPl6YdsQDacvldUbVmxetSDirlZuPn2WaJ5MhvvTWqsthAz7lONxWlg4enwimQ
	 wKFnGnIRtK+sO9Z1IfSiQXBvcSKZjANMDjcuXii42tWlFEBtgzyhkAdPEV2UlzDxYR
	 Oz4V/e1usqQJL9Hc08nrG6pt0KeDg+QmOm9T3OhEl/UIVW1jxEOUYJDc6HDsFLeKl/
	 LaCziklQK8Gx7xl4ccBgqxiFbsJGsDTQPCYM4P4iPAWogGy35rhg+lnC8J75nKmCMo
	 AYMIhOT0Zrk4g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 01/13] mptcp: add id parameter for get_addr
Date: Tue,  8 Oct 2024 17:58:05 +0800
Message-ID: <f11622ba5b11ec481baa5a9584f82fd12334ed01.1728381245.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728381245.git.tanggeliang@kylinos.cn>
References: <cover.1728381245.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The address id is parsed both in mptcp_pm_nl_get_addr() and
mptcp_userspace_pm_get_addr(), this makes the code somewhat repetitive.
So this patch adds a new parameter "id" for all get_addr() interfaces.
The address id is only parsed in mptcp_pm_nl_get_addr_doit(), then pass
it to both mptcp_pm_nl_get_addr() and mptcp_userspace_pm_get_addr().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 28 ++++++++++++++++------------
 net/mptcp/pm_userspace.c | 11 +++--------
 net/mptcp/protocol.h     |  2 +-
 3 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 778e59bfbd8e..076a11d52057 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1791,19 +1791,14 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-static int mptcp_pm_nl_get_addr(struct genl_info *info)
+static int mptcp_pm_nl_get_addr(u8 id, struct genl_info *info)
 {
-	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
-	struct mptcp_pm_addr_entry addr, *entry;
+	struct mptcp_pm_addr_entry *entry;
 	struct sk_buff *msg;
 	void *reply;
 	int ret;
 
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
-	if (ret < 0)
-		return ret;
-
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
@@ -1817,7 +1812,7 @@ static int mptcp_pm_nl_get_addr(struct genl_info *info)
 	}
 
 	spin_lock_bh(&pernet->lock);
-	entry = __lookup_addr_by_id(pernet, addr.addr.id);
+	entry = __lookup_addr_by_id(pernet, id);
 	if (!entry) {
 		GENL_SET_ERR_MSG(info, "address not found");
 		ret = -EINVAL;
@@ -1841,16 +1836,25 @@ static int mptcp_pm_nl_get_addr(struct genl_info *info)
 	return ret;
 }
 
-static int mptcp_pm_get_addr(struct genl_info *info)
+static int mptcp_pm_get_addr(u8 id, struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_get_addr(info);
-	return mptcp_pm_nl_get_addr(info);
+		return mptcp_userspace_pm_get_addr(id, info);
+	return mptcp_pm_nl_get_addr(id, info);
 }
 
 int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return mptcp_pm_get_addr(info);
+	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
+	struct mptcp_pm_addr_entry addr;
+	int ret;
+
+	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
+	if (ret < 0)
+		return ret;
+
+	ret = mptcp_pm_get_addr(addr.addr.id, info);
+	return ret;
 }
 
 static int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 512260e4afb2..da617d8bcc09 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -629,10 +629,9 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	return ret;
 }
 
-int mptcp_userspace_pm_get_addr(struct genl_info *info)
+int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info)
 {
-	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
-	struct mptcp_pm_addr_entry addr, *entry;
+	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	struct sk_buff *msg;
 	int ret = -EINVAL;
@@ -645,10 +644,6 @@ int mptcp_userspace_pm_get_addr(struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
-	if (ret < 0)
-		goto out;
-
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg) {
 		ret = -ENOMEM;
@@ -665,7 +660,7 @@ int mptcp_userspace_pm_get_addr(struct genl_info *info)
 
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, addr.addr.id);
+	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
 	if (!entry) {
 		GENL_SET_ERR_MSG(info, "address not found");
 		ret = -EINVAL;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 41d01a046e27..07cb80be98cb 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1127,7 +1127,7 @@ bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
-int mptcp_userspace_pm_get_addr(struct genl_info *info);
+int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {
-- 
2.43.0

