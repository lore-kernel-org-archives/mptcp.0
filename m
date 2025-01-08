Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625E8156653
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 04:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736310093; cv=none; b=ZJlbl9IHBzyn9ZeYcLz8y+zvQcISzT8poPTlTwYwSPQV869URPXcp+Dnk5nRlUntOrMVhQw6hEaUlULEUCwdMyjse59+CLaYpujLrNipiHujV8DwqsMpgcPW2CiIkFORY7Ji9na0uW6MH/l2S8WIh4ZCXjKJuk73d3kGoGlgqJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736310093; c=relaxed/simple;
	bh=/3PDEZoYO59gVYLMjWLTUYXQG+D9nLOsVmRUu0T5UT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFOZ+xlzX5LF1XLkNAN31HVhvWBJP4EhRgP+0SEyG9uZ9LqCwMm+GEMlW8rxFzmi1UXYNsq311eD4YQifRnkrPyZgbwuIi6+i/JeF8sHneJar+zTBwQF+byjaARV/3rdJ58dA0lRemgPgAo7is/ndCFzRCex3YSsWkglFmioblk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIJzlnut; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIJzlnut"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16D3C4CEDD;
	Wed,  8 Jan 2025 04:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736310093;
	bh=/3PDEZoYO59gVYLMjWLTUYXQG+D9nLOsVmRUu0T5UT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VIJzlnutcVKh7QZvo93kqf2yifdEm2WuTQHAZW44m2sQ8PEcoEwxfQ9y2fj3nVS5E
	 TQhsMsbpC0fdp6L2ZZj3TgJQze1zouSrd8DdNyx574N2aYATAI1dhq523WM9RE0/jL
	 NbimpWdPWWeEvRxtT7U9bz1dzIrTPfPWao7JLJGI8KZdP7zJR2oN1ZtZzjvtu009Y1
	 LqAKX3ZaZOeoZuh/USAiCkgXIxnK/Wcl7ONnBOSWRlbbG/5EVpWGoQHZ8gxriWTS4l
	 HoE/zs2NwPmWNpW/MQsZS2WypxmGhx42UGpNKZ5eAIcszqrZ/PZrw1wuXF66o85gVN
	 8aMOdbjMtn9xw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 8/8] mptcp: add local & remote parameters for set_flags
Date: Wed,  8 Jan 2025 12:21:12 +0800
Message-ID: <67e171a8c11a89767e98965805843f7ce8aa0a71.1736308884.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736308884.git.tanggeliang@kylinos.cn>
References: <cover.1736308884.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch updates the interfaces set_flags to reduce repetitive code,
adds two more parameters 'local' and 'remote' for them. These addresses
are parsed in public helper mptcp_pm_nl_set_flags_doit(), then pass them
to mptcp_pm_nl_set_flags() and mptcp_userspace_pm_set_flags().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           | 48 ++++++++++++++++++++++++++++++++++++----
 net/mptcp/pm_netlink.c   | 38 ++++++++++---------------------
 net/mptcp/pm_userspace.c | 41 ++++++++--------------------------
 net/mptcp/protocol.h     |  8 +++++--
 4 files changed, 71 insertions(+), 64 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index c213f06bc702..25659f3f1221 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -504,16 +504,56 @@ int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
 	return mptcp_pm_dump_addr(msg, cb);
 }
 
-static int mptcp_pm_set_flags(struct genl_info *info)
+static int mptcp_pm_set_flags(struct mptcp_pm_addr_entry *local,
+			      struct mptcp_addr_info *remote,
+			      struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_set_flags(info);
-	return mptcp_pm_nl_set_flags(info);
+		return mptcp_userspace_pm_set_flags(local, remote, info);
+	return mptcp_pm_nl_set_flags(local, remote, info);
 }
 
 int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return mptcp_pm_set_flags(info);
+	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
+	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
+	struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
+	struct nlattr *attr_loc, *attr_rem;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR))
+		return -EINVAL;
+
+	attr_loc = info->attrs[MPTCP_PM_ATTR_ADDR];
+	ret = mptcp_pm_parse_entry(attr_loc, info, false, &loc);
+	if (ret < 0)
+		return ret;
+
+	if (loc.addr.family == AF_UNSPEC) {
+		if (!token && !loc.addr.id) {
+			NL_SET_ERR_MSG_ATTR(info->extack, attr_loc,
+					    "missing address ID");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	if (token) {
+		if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR_REMOTE))
+			return -EINVAL;
+
+		attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
+		ret = mptcp_pm_parse_addr(attr_rem, info, &rem);
+		if (ret < 0)
+			return ret;
+
+		if (rem.family == AF_UNSPEC) {
+			NL_SET_ERR_MSG_ATTR(info->extack, attr_rem,
+					    "invalid remote address family");
+			return -EINVAL;
+		}
+	}
+
+	return mptcp_pm_set_flags(&loc, &rem, info);
 }
 
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b18c42419d42..01f50bd25b44 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1951,61 +1951,47 @@ static int mptcp_nl_set_flags(struct net *net,
 	return ret;
 }
 
-int mptcp_pm_nl_set_flags(struct genl_info *info)
+int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
+			  struct mptcp_addr_info *remote,
+			  struct genl_info *info)
 {
-	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, };
 	u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
 			   MPTCP_PM_ADDR_FLAG_FULLMESH;
 	struct net *net = genl_info_net(info);
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
-	struct nlattr *attr;
 	u8 lookup_by_id = 0;
 	u8 bkup = 0;
-	int ret;
 
 	pernet = pm_nl_get_pernet(net);
 
-	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR))
-		return -EINVAL;
-
-	attr = info->attrs[MPTCP_PM_ATTR_ADDR];
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
-	if (ret < 0)
-		return ret;
-
-	if (addr.addr.family == AF_UNSPEC) {
+	if (local->addr.family == AF_UNSPEC)
 		lookup_by_id = 1;
-		if (!addr.addr.id) {
-			GENL_SET_ERR_MSG(info, "missing address ID");
-			return -EOPNOTSUPP;
-		}
-	}
 
-	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
+	if (local->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
 
 	spin_lock_bh(&pernet->lock);
-	entry = lookup_by_id ? __lookup_addr_by_id(pernet, addr.addr.id) :
-			       __lookup_addr(pernet, &addr.addr);
+	entry = lookup_by_id ? __lookup_addr_by_id(pernet, local->addr.id) :
+			       __lookup_addr(pernet, &local->addr);
 	if (!entry) {
 		spin_unlock_bh(&pernet->lock);
 		GENL_SET_ERR_MSG(info, "address not found");
 		return -EINVAL;
 	}
-	if ((addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
+	if ((local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
 	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
 		spin_unlock_bh(&pernet->lock);
 		GENL_SET_ERR_MSG(info, "invalid addr flags");
 		return -EINVAL;
 	}
 
-	changed = (addr.flags ^ entry->flags) & mask;
-	entry->flags = (entry->flags & ~mask) | (addr.flags & mask);
-	addr = *entry;
+	changed = (local->flags ^ entry->flags) & mask;
+	entry->flags = (entry->flags & ~mask) | (local->flags & mask);
+	*local = *entry;
 	spin_unlock_bh(&pernet->lock);
 
-	mptcp_nl_set_flags(net, &addr.addr, bkup, changed);
+	mptcp_nl_set_flags(net, &local->addr, bkup, changed);
 	return 0;
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index a95f52142a33..7b5c400f9066 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -564,54 +564,32 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	return err;
 }
 
-int mptcp_userspace_pm_set_flags(struct genl_info *info)
+int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
+				 struct mptcp_addr_info *remote,
+				 struct genl_info *info)
 {
-	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
-	struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
 	struct mptcp_pm_addr_entry *entry;
-	struct nlattr *attr, *attr_rem;
 	struct mptcp_sock *msk;
 	u8 lookup_by_id = 0;
 	int ret = -EINVAL;
 	struct sock *sk;
 	u8 bkup = 0;
 
-	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR) ||
-	    GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR_REMOTE))
-		return ret;
-
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
 		return ret;
 
 	sk = (struct sock *)msk;
 
-	attr = info->attrs[MPTCP_PM_ATTR_ADDR];
-	ret = mptcp_pm_parse_entry(attr, info, false, &loc);
-	if (ret < 0)
-		goto set_flags_err;
-
-	if (loc.addr.family == AF_UNSPEC)
+	if (local->addr.family == AF_UNSPEC)
 		lookup_by_id = 1;
 
-	attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	ret = mptcp_pm_parse_addr(attr_rem, info, &rem);
-	if (ret < 0)
-		goto set_flags_err;
-
-	if (rem.family == AF_UNSPEC) {
-		NL_SET_ERR_MSG_ATTR(info->extack, attr_rem,
-				    "invalid remote address family");
-		ret = -EINVAL;
-		goto set_flags_err;
-	}
-
-	if (loc.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
+	if (local->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = lookup_by_id ? mptcp_userspace_pm_lookup_addr_by_id(msk, loc.addr.id) :
-			       mptcp_userspace_pm_lookup_addr(msk, &loc.addr);
+	entry = lookup_by_id ? mptcp_userspace_pm_lookup_addr_by_id(msk, local->addr.id) :
+			       mptcp_userspace_pm_lookup_addr(msk, &local->addr);
 	if (entry) {
 		if (bkup)
 			entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
@@ -621,15 +599,14 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 	spin_unlock_bh(&msk->pm.lock);
 
 	lock_sock(sk);
-	ret = mptcp_pm_nl_mp_prio_send_ack(msk, entry ? &entry->addr : &loc.addr,
-					   &rem, bkup);
+	ret = mptcp_pm_nl_mp_prio_send_ack(msk, entry ? &entry->addr : &local->addr,
+					   remote, bkup);
 	release_sock(sk);
 
 	/* mptcp_pm_nl_mp_prio_send_ack() only fails in one case */
 	if (ret < 0)
 		GENL_SET_ERR_MSG(info, "subflow not found");
 
-set_flags_err:
 	sock_put(sk);
 	return ret;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index aa014f514af3..d2626b5ac381 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1028,8 +1028,12 @@ bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
 				   const struct mptcp_addr_info *saddr);
 bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				     const struct mptcp_addr_info *addr);
-int mptcp_pm_nl_set_flags(struct genl_info *info);
-int mptcp_userspace_pm_set_flags(struct genl_info *info);
+int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
+			  struct mptcp_addr_info *remote,
+			  struct genl_info *info);
+int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
+				 struct mptcp_addr_info *remote,
+				 struct genl_info *info);
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
-- 
2.45.2

