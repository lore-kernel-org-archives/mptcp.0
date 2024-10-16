Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A903204F9A
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069981; cv=none; b=JBfE682kv/UhMWE/AcLi0h2iiy9yey96Kj6UBH8+AgHOjF9q0tvlcgt+Vw/Lcb4nmLLFzd9mYblw4qQzotCto93gqcpDZOlugECD3kOvkVgwBsuysjqTpVnQnDeliHOZFmnz+Ydwqxlo2nh3nF5DpWzKBGw/sigXhoKTftQJQ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069981; c=relaxed/simple;
	bh=/2Ee9VHNFGNC0ZQYPlRj3ngzOQBhYFClmWFOzZnQLWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfBWr59almt04RBoao3l+jXoI/0zSTHExb3GeO8ST1/KoPAD5cQqo9qM90BCsY523qkXspgDCNlADeO0LLeGzV8lOSuVV3ruOAKp00WoJiRDZtrq9GNQWNnlgN1h4E8CmNCrw9aF2XjRN6rWciJ9qIvZYU1Ly79v1VYegCojXYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXHnGrtk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXHnGrtk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24C2C4CEC5;
	Wed, 16 Oct 2024 09:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729069981;
	bh=/2Ee9VHNFGNC0ZQYPlRj3ngzOQBhYFClmWFOzZnQLWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jXHnGrtkl+rLr60UyG6w+2L+NyurnLQyAvdGxD6DFPJojXzdTE2zi9Igm5OL4vahE
	 tY1uBvaCVZjK8QrYRTPaLlZyIuYf5DjKLUXyVEdZJStiPGl5LUh6CXZajQPnT/hydj
	 OahUQW33eIhJHuedcFeEnZm+K58uHwX/4FVioap6MmIeq8U7k8DFhhIR8cTD2wNc9k
	 MVA3hZmD0KwfosfP8quPfCyvGsHSbQjGo195bYvgIa5JppiyvCtE2tHuJc6/7X3w3i
	 msnddJ4P/j2mBiMB7j2NS+sdhZxM+9VBP+xj9wP5LduzyqRL3ixGuPlmZgZvSFs10D
	 AqAIO3BzOSwLw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 09/33] mptcp: add id parameter for get_addr
Date: Wed, 16 Oct 2024 17:12:13 +0800
Message-ID: <6e31cc5a923722e9354229acfd45d18584e4bdef.1729069854.git.tanggeliang@kylinos.cn>
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
index fa320bdf2647..be9d1aa3377f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1792,19 +1792,14 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
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
@@ -1818,7 +1813,7 @@ static int mptcp_pm_nl_get_addr(struct genl_info *info)
 	}
 
 	spin_lock_bh(&pernet->lock);
-	entry = __lookup_addr_by_id(pernet, addr.addr.id);
+	entry = __lookup_addr_by_id(pernet, id);
 	if (!entry) {
 		GENL_SET_ERR_MSG(info, "address not found");
 		ret = -EINVAL;
@@ -1842,16 +1837,25 @@ static int mptcp_pm_nl_get_addr(struct genl_info *info)
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
index e61cc1805cee..079baceb9ca1 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -632,10 +632,9 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
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
@@ -648,10 +647,6 @@ int mptcp_userspace_pm_get_addr(struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
-	if (ret < 0)
-		goto out;
-
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg) {
 		ret = -ENOMEM;
@@ -668,7 +663,7 @@ int mptcp_userspace_pm_get_addr(struct genl_info *info)
 
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, addr.addr.id);
+	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
 	if (!entry) {
 		GENL_SET_ERR_MSG(info, "address not found");
 		ret = -EINVAL;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 93deec8f0557..8ee0617209af 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1126,7 +1126,7 @@ bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
-int mptcp_userspace_pm_get_addr(struct genl_info *info);
+int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {
-- 
2.43.0

