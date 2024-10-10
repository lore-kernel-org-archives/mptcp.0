Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEEF178372
	for <mptcp@lists.linux.dev>; Thu, 10 Oct 2024 05:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728539289; cv=none; b=s+m3Ojpr9HWWXlbQrnX9YkOQ7xBv7kdg3UoLooxM9H0HxBBxzkmsnJUUiFqaoDhHR8JSd4RNkZCWbvkgEcaNPwOZSEaiI3wTfaXsiNOwgd+hBtyjOwq/k9HVJoMdCKjFsMUQxPLqso/WGBkZ9b9rKx0J0NFMiSWR+egaiJVqPSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728539289; c=relaxed/simple;
	bh=w4IB7Gi+aZvqzY2tZoxPCRIf+b19vmSlgzt8LJO8QnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pETObz7+xWEw1tTQbiUANpBwDJUweXUoh4S4rM95pQm63YGcMwf7jo8SYY7d3+Q+R+s8Jfoym+FMoZXeAuM6v/MwiF3Fcqxn1Rc5RasIjWhikAHBjNUIj/yvUz4yvDw8gPAz1+JaCaHerW5Z/++ZR5JEkoCmTiofhiCtD3c/7m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2JcBhTg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2JcBhTg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9D9C4CEC6;
	Thu, 10 Oct 2024 05:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728539288;
	bh=w4IB7Gi+aZvqzY2tZoxPCRIf+b19vmSlgzt8LJO8QnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D2JcBhTgcyZugfHVdnVRJVlEd1JJ8ai/qVww55pN5Bn4P5FCGDDYgRDbKUR7yrilv
	 GRp90lgST8HOnulPlX96IPYYMZtmxXAptk2bBeFOa7IDY/f9VwJ3KNb7IkS/S66h2j
	 0QkNCNK2ORMkWBXiHWJc528hnWc9Qsli2lVHRNvJ4IdnMAyzsrG5C5bRhGxmeMjYbf
	 /Cd8odjEZD6XUQipV423UvuEU9xs6aCylfBS3aRUpVcM2++VKBT508DcSR8FQ2bWHo
	 Gmy1uXRCi/zpwwAdSNPE7NotClrx0SzHG9RhH+8eySKoeXhyF+9RdyNEsnU3tB+hPs
	 IZwGLG+zdt+sg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 01/15] mptcp: add id parameter for get_addr
Date: Thu, 10 Oct 2024 13:47:46 +0800
Message-ID: <9bba98fce51429225615e95b28456642e7ef93c9.1728538975.git.tanggeliang@kylinos.cn>
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
index 78f8d78f0392..c65d0ac4acc2 100644
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
index cc5a38684c3a..73ef3087555c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1125,7 +1125,7 @@ bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
-int mptcp_userspace_pm_get_addr(struct genl_info *info);
+int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {
-- 
2.43.0

