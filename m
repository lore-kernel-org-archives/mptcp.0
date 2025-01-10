Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02C4C2C6
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 07:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494592; cv=none; b=hkTL52AwGUTJwbRpAtNMPf32lw48ipmWSpSE3r1Zln+uZRBxnD3o9S66cVra9W8UcMMTZCHF7fwWA7EghozgJxEJf+KSwyxZbio8xncpGJIGyVoVvNF2pX9cMAPSxQirD/EK6AiZWLlmYqCuEnXsYI+B2Vmqai/R0GEq8bhm2wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494592; c=relaxed/simple;
	bh=51I48zxkgtse6wr3y8RXfaZUsCj/k0MOKSd1Gkd823Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcwTmceHfG/cxebT80GfLjmZHTwP3ZMUFSXriaWfaA0bmAs/qicbc3K58WLYyq2q6ytfsFeqP5QKPnGIXRbESa2n0YPczBpShvkYfDv2bBa49pYs5vzVlpb6zVMELL/5NKDHfzBK6xfoAqjTHOhWJOPY27x0wi7zqaPgMwxzleg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vya8WETP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vya8WETP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D69C4CEDF;
	Fri, 10 Jan 2025 07:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736494591;
	bh=51I48zxkgtse6wr3y8RXfaZUsCj/k0MOKSd1Gkd823Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vya8WETPW2ErUKIQzddmJ1IiEdHjYkophbYFpcxbjbxlIyDTWoFOacY+DbJvr1GLo
	 4jU8dP+wboNHRRELXDyTyn3C7oAVeSR44x7D5AeEuR6ZqDtVyDbvRjbrvYnCP96iI+
	 ZtpG6UYWW9B+yBDridGhrQTMIoMEVCOnY/1zdzKdLNJUo6B1WC2uPtA0I7Ar51Ewth
	 Qg9mMmL12bp2YcaZOaovN6ScZzLx9YwUoWnqPPbHEWfBZsZOQxP0/8xjGdtLKl26pX
	 XWPH7+lNTRFWFWWOMX9gPSaNM4Y3hFqCgyoeUuZXRf9mgWRT7QZhWA6nIu3akpln3a
	 RjOLnQ6P8HHRA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 3/7] mptcp: add id parameter for get_addr
Date: Fri, 10 Jan 2025 15:36:16 +0800
Message-ID: <11c9a8e381a1a667d76f9cca863efe15714a38b5.1736494320.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736494320.git.tanggeliang@kylinos.cn>
References: <cover.1736494320.git.tanggeliang@kylinos.cn>
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
So this patch adds a new parameter 'id' for all get_addr() interfaces.
The address id is only parsed in mptcp_pm_nl_get_addr_doit(), then pass
it to both mptcp_pm_nl_get_addr() and mptcp_userspace_pm_get_addr().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           | 20 ++++++++++++++++----
 net/mptcp/pm_netlink.c   | 14 +++-----------
 net/mptcp/pm_userspace.c | 14 +++-----------
 net/mptcp/protocol.h     |  4 ++--
 4 files changed, 24 insertions(+), 28 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 526e5bca1fa1..caf5bfc3cd1d 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -434,16 +434,28 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_is_backup(msk, &skc_local);
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
+	struct mptcp_pm_addr_entry addr;
+	struct nlattr *attr;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
+		return -EINVAL;
+
+	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
+	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
+	if (ret < 0)
+		return ret;
+
+	return mptcp_pm_get_addr(addr.addr.id, info);
 }
 
 static int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 18f4d8176fc4..ab948a9fcfe8 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1773,23 +1773,15 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-int mptcp_pm_nl_get_addr(struct genl_info *info)
+int mptcp_pm_nl_get_addr(u8 id, struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
-	struct mptcp_pm_addr_entry addr, *entry;
+	struct mptcp_pm_addr_entry *entry;
 	struct sk_buff *msg;
 	struct nlattr *attr;
 	void *reply;
 	int ret;
 
-	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
-		return -EINVAL;
-
-	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
-	if (ret < 0)
-		return ret;
-
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
@@ -1803,7 +1795,7 @@ int mptcp_pm_nl_get_addr(struct genl_info *info)
 	}
 
 	rcu_read_lock();
-	entry = __lookup_addr_by_id(pernet, addr.addr.id);
+	entry = __lookup_addr_by_id(pernet, id);
 	if (!entry) {
 		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
 		ret = -EINVAL;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index ce627e1dd5a7..9a974fe0d992 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -683,9 +683,9 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	return ret;
 }
 
-int mptcp_userspace_pm_get_addr(struct genl_info *info)
+int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info)
 {
-	struct mptcp_pm_addr_entry addr, *entry;
+	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	struct sk_buff *msg;
 	struct nlattr *attr;
@@ -693,20 +693,12 @@ int mptcp_userspace_pm_get_addr(struct genl_info *info)
 	struct sock *sk;
 	void *reply;
 
-	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
-		return ret;
-
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
 		return ret;
 
 	sk = (struct sock *)msk;
 
-	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
-	if (ret < 0)
-		goto out;
-
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg) {
 		ret = -ENOMEM;
@@ -723,7 +715,7 @@ int mptcp_userspace_pm_get_addr(struct genl_info *info)
 
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, addr.addr.id);
+	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
 	if (!entry) {
 		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
 		ret = -EINVAL;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 36e5fbf84b2b..14d6b6be0483 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1124,8 +1124,8 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
-int mptcp_pm_nl_get_addr(struct genl_info *info);
-int mptcp_userspace_pm_get_addr(struct genl_info *info);
+int mptcp_pm_nl_get_addr(u8 id, struct genl_info *info);
+int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {
-- 
2.45.2

