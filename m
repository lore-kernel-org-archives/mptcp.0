Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D06317D378
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070021; cv=none; b=a+vWX4WGqaC1Vf8OBSOd9T8lnmLcOYRfK3LuXiELrJHMEgiOD/3/QtzA6sm7cXbkz8A/3p4ikR+RvIx9daiG+VhrGphBgGhlH94kNyO83fcsYFwEH1b38QkPAeoEgE9NMC6HlxZJianYm60oK3XypPwsfvVydFZtsnv+Il6KqDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070021; c=relaxed/simple;
	bh=vC0jTeebxJMuV02V9VMvlyexLr75w489vELa1ZH8oX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCvQz8UnbrfU1WDVvZ1pQ2mM3YGMarG+hHsDmiub6abigCQPIaA1XcDf6Dp7tYNZkTBMGyQB9fhgDZahenKivDERIUcjv539UwIvlILXMnh2ideUWc0ZmDV38sUbuIqC2yDjmsLFcby5rkGcW70r1p/I/I7OUSA8TOv7WDvC+xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bshi+Fz1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bshi+Fz1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AF7C4CECE;
	Wed, 16 Oct 2024 09:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729070021;
	bh=vC0jTeebxJMuV02V9VMvlyexLr75w489vELa1ZH8oX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bshi+Fz10i0MarG5XIjbcpcjMYhtEe4oe2msl8TELnSVfc9w1cZqTNER3Ey5RfVsT
	 2UBcjxiy+/3UFaLXdkiL2RUKjCCLraA8/WdV6AeY0gZVBnzKbg6/wvxhGM+fqDCO+O
	 CJ9vPVYIEtLzzjhEW3KiNnsgr+84mHY2j5EBfeyIWdOuPuvjFPoVE0AJcFPIBpQ4Ms
	 5ZP/+KzVL3Xs351L4BXmztkJovvq0tWzBsK2NcaVhy0kB2YwjwY/HbaOb9p8RhA57K
	 wEp5JFCo1NYwL8KiGuFa8JWg6dGJKVFqITBudj9Uoja9KwAnrHDNKiyo4YoQYa+yRz
	 dtTWBbtsfXPgA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 31/33] mptcp: implement userspace pm subflow interfaces
Date: Wed, 16 Oct 2024 17:12:35 +0800
Message-ID: <d10f56151c5b7ed374726296a0aaef15268d1f89.1729069854.git.tanggeliang@kylinos.cn>
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

This patch implements subflow_create() and subflow_destroy() interfaces
of the userspace PM.

Extract subflow_create() interface from the handler of netlink commond
MPTCP_PM_CMD_SUBFLOW_CREATE mptcp_pm_nl_subflow_create_doit(), only leave
the code for obtaining msk through "info", parsing local address entry
and parsing remote address info in the handler.

Extract subflow_destroy() interface from the handler of netlink commond
MPTCP_PM_CMD_SUBFLOW_DESTROY mptcp_pm_nl_subflow_destroy_doit(), only leave
the code for obtaining msk through "info", parsing local address entry and
parsing remote address info in the handler.

Both interfaces are invoked under holding the msk socket lock.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 138 +++++++++++++++++++++------------------
 1 file changed, 75 insertions(+), 63 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 68eec0672743..0ab37f31eee9 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -341,6 +341,35 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+static int userspace_pm_subflow_create(struct mptcp_sock *msk,
+				       struct mptcp_pm_addr_entry *local,
+				       struct mptcp_addr_info *remote)
+{
+	struct sock *sk = (struct sock *)msk;
+	int err;
+
+	if (local->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)
+		return -EINVAL;
+	local->flags |= MPTCP_PM_ADDR_FLAG_SUBFLOW;
+
+	if (!mptcp_pm_addr_families_match(sk, &local->addr, remote))
+		return -EINVAL;
+
+	err = mptcp_userspace_pm_append_new_local_addr(msk, local, false);
+	if (err < 0)
+		return err;
+
+	err = __mptcp_subflow_connect(sk, local, remote);
+	spin_lock_bh(&msk->pm.lock);
+	if (err)
+		mptcp_userspace_pm_delete_local_addr(msk, local);
+	else
+		msk->pm.subflows++;
+	spin_unlock_bh(&msk->pm.lock);
+
+	return err;
+}
+
 int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
@@ -368,41 +397,17 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	if (entry.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
-		GENL_SET_ERR_MSG(info, "invalid addr flags");
-		err = -EINVAL;
-		goto create_err;
-	}
-	entry.flags |= MPTCP_PM_ADDR_FLAG_SUBFLOW;
-
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
 		goto create_err;
 	}
 
-	if (!mptcp_pm_addr_families_match(sk, &entry.addr, &addr_r)) {
-		GENL_SET_ERR_MSG(info, "families mismatch");
-		err = -EINVAL;
-		goto create_err;
-	}
-
-	err = mptcp_userspace_pm_append_new_local_addr(msk, &entry, false);
-	if (err < 0) {
-		GENL_SET_ERR_MSG(info, "did not match address and id");
-		goto create_err;
-	}
-
 	lock_sock(sk);
-	err = __mptcp_subflow_connect(sk, &entry, &addr_r);
+	err = userspace_pm_subflow_create(msk, &entry, &addr_r);
 	release_sock(sk);
-
-	spin_lock_bh(&msk->pm.lock);
 	if (err)
-		mptcp_userspace_pm_delete_local_addr(msk, &entry);
-	else
-		msk->pm.subflows++;
-	spin_unlock_bh(&msk->pm.lock);
+		GENL_SET_ERR_MSG(info, "subflow_create failed");
 
  create_err:
 	sock_put(sk);
@@ -457,6 +462,46 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
 	return NULL;
 }
 
+static int userspace_pm_subflow_destroy(struct mptcp_sock *msk,
+					struct mptcp_pm_addr_entry *local,
+					struct mptcp_addr_info *remote)
+{
+	struct sock *sk = (struct sock *)msk;
+	struct sock *ssk;
+	int err = -ESRCH;
+
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	if (local->addr.family == AF_INET && ipv6_addr_v4mapped(&remote->addr6)) {
+		ipv6_addr_set_v4mapped(local->addr.addr.s_addr, &remote->addr6);
+		local->addr.family = AF_INET6;
+	}
+	if (remote->family == AF_INET && ipv6_addr_v4mapped(&local->addr.addr6)) {
+		ipv6_addr_set_v4mapped(remote->addr.s_addr, &local->addr.addr6);
+		remote->family = AF_INET6;
+	}
+#endif
+	if (local->addr.family != remote->family)
+		return -EINVAL;
+
+	if (!local->addr.port || !remote->port)
+		return -EINVAL;
+
+	ssk = mptcp_nl_find_ssk(msk, &local->addr, remote);
+	if (ssk) {
+		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+
+		spin_lock_bh(&msk->pm.lock);
+		mptcp_userspace_pm_delete_local_addr(msk, local);
+		spin_unlock_bh(&msk->pm.lock);
+		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
+		mptcp_close_ssk(sk, ssk, subflow);
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
+		err = 0;
+	}
+
+	return err;
+}
+
 int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
@@ -464,8 +509,8 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	struct mptcp_pm_addr_entry local;
 	struct mptcp_addr_info addr_r;
 	struct mptcp_sock *msk;
-	struct sock *sk, *ssk;
 	int err = -EINVAL;
+	struct sock *sk;
 
 	if (!laddr || !raddr) {
 		GENL_SET_ERR_MSG(info, "missing required inputs");
@@ -490,44 +535,11 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 		goto destroy_err;
 	}
 
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	if (local.addr.family == AF_INET && ipv6_addr_v4mapped(&addr_r.addr6)) {
-		ipv6_addr_set_v4mapped(local.addr.addr.s_addr, &local.addr.addr6);
-		local.addr.family = AF_INET6;
-	}
-	if (addr_r.family == AF_INET && ipv6_addr_v4mapped(&local.addr.addr6)) {
-		ipv6_addr_set_v4mapped(addr_r.addr.s_addr, &local.addr.addr6);
-		addr_r.family = AF_INET6;
-	}
-#endif
-	if (local.addr.family != addr_r.family) {
-		GENL_SET_ERR_MSG(info, "address families do not match");
-		err = -EINVAL;
-		goto destroy_err;
-	}
-
-	if (!local.addr.port || !addr_r.port) {
-		GENL_SET_ERR_MSG(info, "missing local or remote port");
-		err = -EINVAL;
-		goto destroy_err;
-	}
-
 	lock_sock(sk);
-	ssk = mptcp_nl_find_ssk(msk, &local.addr, &addr_r);
-	if (ssk) {
-		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-
-		spin_lock_bh(&msk->pm.lock);
-		mptcp_userspace_pm_delete_local_addr(msk, &local);
-		spin_unlock_bh(&msk->pm.lock);
-		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
-		mptcp_close_ssk(sk, ssk, subflow);
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
-		err = 0;
-	} else {
-		err = -ESRCH;
-	}
+	err = userspace_pm_subflow_destroy(msk, &local, &addr_r);
 	release_sock(sk);
+	if (err)
+		GENL_SET_ERR_MSG(info, "subflow_destroy failed");
 
 destroy_err:
 	sock_put(sk);
-- 
2.43.0

