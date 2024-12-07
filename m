Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F73722C6DC
	for <mptcp@lists.linux.dev>; Sat,  7 Dec 2024 01:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733533695; cv=none; b=aFS2kBs/g77F2F5nO+CN0tsCkzqi9zUL1PPbflBpym88K4ucxvRxAHqYhS+dIWcyv+HJ6/JTzzkYemNj/FSiKkiVsqQDrxVGEhFb5UMrZDNZ4JaDtr2qHaAxG38MxjIJQwOMrYEQiJKKsv/dT287t4Eiol3jaJe4jxMrqa6X6RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733533695; c=relaxed/simple;
	bh=6wFV6SujP9LXSCo+prbGEDjJKAk8kNqth8UTWHaVhz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKoYALc+OQfrm1MfZcXRcwWqdsoL1ua6OE9AeYfrP7jdw5C0gdpqqHeRvyB6Lk/MHoh5GgWObMLJZOtVObUkdhOWV/+UOyeiQDKR0v6s6pNHsyMvnfVFrimdnAyJ2e3yfxWYQ8+5LOIDH09k6GIGg+kzjom4gohM/pRdSbkvfoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q32IsdAC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q32IsdAC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89FAC4CED1;
	Sat,  7 Dec 2024 01:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733533694;
	bh=6wFV6SujP9LXSCo+prbGEDjJKAk8kNqth8UTWHaVhz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q32IsdACzFaSieIvhxK+jebU4TEFQKL0TTmOAypUvKPidzWT4xHSziHVvKXOjR4xI
	 +66ivPHA61jdntbmd5/PfDywnmggrPIy0ATuVwpVfy+2Fl6DqES73Jhg1/DvJLl9ea
	 JCEo9GcD2xeSWtePNwFDCnYr7ARZh2KAV9e+0sUjDEI3DZYDigoiAIa/wJkyOVLWeR
	 9WxU0UlPB5mpG/YFvYArldQs8ly1D4jXlPbEqR8uvngMNKo8hF+GJt975EdGhFXC7a
	 1U7pDb7TneRxEq/UYB+phToqVtU7TYFFGL2vtNvQiOAUAMJRVKgNVIYfbVC1CtRYg3
	 tfA17Xj2S8jgg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/7] mptcp: add id parameter for get_addr
Date: Sat,  7 Dec 2024 09:07:23 +0800
Message-ID: <bfacfd8f3cd243118a186d2fa41f1f435b0c66c3.1733533215.git.geliang@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733533215.git.geliang@kernel.org>
References: <cover.1733533215.git.geliang@kernel.org>
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
 net/mptcp/pm.c           | 16 ++++++++++++----
 net/mptcp/pm_netlink.c   | 11 +++--------
 net/mptcp/pm_userspace.c | 11 +++--------
 net/mptcp/protocol.h     |  4 ++--
 4 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 526e5bca1fa1..c7d323c7c7aa 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -434,16 +434,24 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
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
+	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
+	struct mptcp_pm_addr_entry addr;
+	int ret;
+
+	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
+	if (ret < 0)
+		return ret;
+
+	return mptcp_pm_get_addr(addr.addr.id, info);
 }
 
 static int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 92b4dcc310d3..de6a8e7a4a1a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1762,19 +1762,14 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-int mptcp_pm_nl_get_addr(struct genl_info *info)
+int mptcp_pm_nl_get_addr(u8 id, struct genl_info *info)
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
@@ -1788,7 +1783,7 @@ int mptcp_pm_nl_get_addr(struct genl_info *info)
 	}
 
 	rcu_read_lock();
-	entry = __lookup_addr_by_id(pernet, addr.addr.id);
+	entry = __lookup_addr_by_id(pernet, id);
 	if (!entry) {
 		GENL_SET_ERR_MSG(info, "address not found");
 		ret = -EINVAL;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index ab92efec6618..40a018be243e 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -663,10 +663,9 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
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
@@ -679,10 +678,6 @@ int mptcp_userspace_pm_get_addr(struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
-	if (ret < 0)
-		goto out;
-
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg) {
 		ret = -ENOMEM;
@@ -699,7 +694,7 @@ int mptcp_userspace_pm_get_addr(struct genl_info *info)
 
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, addr.addr.id);
+	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
 	if (!entry) {
 		GENL_SET_ERR_MSG(info, "address not found");
 		ret = -EINVAL;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index dd673b41f0ce..76a0cfe54723 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1131,8 +1131,8 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
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

