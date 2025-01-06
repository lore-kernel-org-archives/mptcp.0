Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAF71A2631
	for <mptcp@lists.linux.dev>; Mon,  6 Jan 2025 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736151397; cv=none; b=N3ojPE8GhtUCl1u1XK6disKPd5iiMP0omeHC+KgzTP2BAOfllz6AZAHjpfWGi7cTky6WxGAQkTsIgAZRyV7xRBm8ges9g9jPj/nySgklRxhHJXOUL346oXMkmrZzQNGxO/q1GoZm+SrjcsjvdjHBcev9sfYyOUCRkjNEPCDfGGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736151397; c=relaxed/simple;
	bh=xSWOxaHVAXme4rpHtICrHZqLRwzJm5ZBlk3a/NYxIBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgXUXC5g8rvlCl74zwGzSYjQTnyLpWrTMfdXD2OuFUyRJYzuHGL7nDldNl+JbmmHKyv4m5BxXOOwAG430Xj599ZEzzOrOJv6oot4lGUEiVX8GTkqfkdF2lro3FlkP4tnxfBFJiREGik14Kxo5abMTmyUETTCNZtM2nw6c0rCLHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiRKUITW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiRKUITW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B18DC4CEDF;
	Mon,  6 Jan 2025 08:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736151396;
	bh=xSWOxaHVAXme4rpHtICrHZqLRwzJm5ZBlk3a/NYxIBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QiRKUITWej9Sur74ozSvKiMrVFNNqKeVuzkuMf6o3zd9201r2PGa0JJrrRl4C2KLf
	 P184dDXB9UteqPLbc1yGXsBMyMphWkTYKgca1UeqPR35mK0DopVGYK8dpy3PuXl/pq
	 0yVIt0COwka+DLVn8T+b1dWGo7QHhkbhxkUNLQkQQtB/2JabKBJNcp8LGS774RP5GJ
	 /KfevzmCB6y56riO2MsnH7mkrqHPqxr2hujNx9sRp6xrVYDOAfxJ8Aa+Jc21YS+6dR
	 A/ycCuJ7GR9Rd+jCHrkW+WKFyAhzGfkxn5pFZjslkAnbXngJF70ZgxnYzJNWiTENyM
	 /09y0192l54Dg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v7 07/11] mptcp: pm: use NL_SET_ERR_MSG_ATTR when possible
Date: Mon,  6 Jan 2025 16:16:12 +0800
Message-ID: <4ab3a73300cdc4e2f222127e53ca66a696d3e6e6.1736150983.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736150983.git.tanggeliang@kylinos.cn>
References: <cover.1736150983.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

Instead of only returning a text message with GENL_SET_ERR_MSG(),
NL_SET_ERR_MSG_ATTR() can help the userspace developers by also
reporting which attribute is faulty.

When the error is specific to an attribute, NL_SET_ERR_MSG_ATTR() is now
used. The error messages have not been modified in this commit.

mptcp_userspace_pm_remove_id_zero_address() has been modified to set the
missing attribute.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c   | 16 ++++++++++------
 net/mptcp/pm_userspace.c | 13 ++++++++-----
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7f5a72525bca..46a97a3bf319 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1403,18 +1403,21 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 		return ret;
 
 	if (addr.addr.port && !address_use_port(&addr)) {
-		GENL_SET_ERR_MSG(info, "flags must have signal and not subflow when using port");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr,
+				    "flags must have signal and not subflow when using port");
 		return -EINVAL;
 	}
 
 	if (addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL &&
 	    addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) {
-		GENL_SET_ERR_MSG(info, "flags mustn't have both signal and fullmesh");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr,
+				    "flags mustn't have both signal and fullmesh");
 		return -EINVAL;
 	}
 
 	if (addr.flags & MPTCP_PM_ADDR_FLAG_IMPLICIT) {
-		GENL_SET_ERR_MSG(info, "can't create IMPLICIT endpoint");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr,
+				    "can't create IMPLICIT endpoint");
 		return -EINVAL;
 	}
 
@@ -1608,7 +1611,7 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&pernet->lock);
 	entry = __lookup_addr_by_id(pernet, addr.addr.id);
 	if (!entry) {
-		GENL_SET_ERR_MSG(info, "address not found");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
 		spin_unlock_bh(&pernet->lock);
 		return -EINVAL;
 	}
@@ -1790,7 +1793,7 @@ int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 	rcu_read_lock();
 	entry = __lookup_addr_by_id(pernet, addr.addr.id);
 	if (!entry) {
-		GENL_SET_ERR_MSG(info, "address not found");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
 		ret = -EINVAL;
 		goto unlock_fail;
 	}
@@ -1875,7 +1878,8 @@ static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
 
 	*limit = nla_get_u32(attr);
 	if (*limit > MPTCP_PM_ADDR_MAX) {
-		GENL_SET_ERR_MSG(info, "limit greater than maximum");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr,
+				    "limit greater than maximum");
 		return -EINVAL;
 	}
 	return 0;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index a6580942e628..066fd89b1691 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -190,7 +190,8 @@ static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *in
 	}
 
 	if (!mptcp_pm_is_userspace(msk)) {
-		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
+		NL_SET_ERR_MSG_ATTR(info->extack, token,
+				    "invalid request; userspace PM not selected");
 		sock_put((struct sock *)msk);
 		return NULL;
 	}
@@ -237,7 +238,8 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 
 	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val, false);
 	if (err < 0) {
-		GENL_SET_ERR_MSG(info, "did not match address and id");
+		NL_SET_ERR_MSG_ATTR(info->extack, addr,
+				    "did not match address and id");
 		goto announce_err;
 	}
 
@@ -396,7 +398,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (entry.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
-		GENL_SET_ERR_MSG(info, "invalid addr flags");
+		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "invalid addr flags");
 		err = -EINVAL;
 		goto create_err;
 	}
@@ -416,7 +418,8 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	err = mptcp_userspace_pm_append_new_local_addr(msk, &entry, false);
 	if (err < 0) {
-		GENL_SET_ERR_MSG(info, "did not match address and id");
+		NL_SET_ERR_MSG_ATTR(info->extack, laddr,
+				    "did not match address and id");
 		goto create_err;
 	}
 
@@ -704,7 +707,7 @@ int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, addr.addr.id);
 	if (!entry) {
-		GENL_SET_ERR_MSG(info, "address not found");
+		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
 		ret = -EINVAL;
 		goto unlock_fail;
 	}
-- 
2.45.2

