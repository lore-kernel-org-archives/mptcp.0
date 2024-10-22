Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98E92209B
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588541; cv=none; b=Vx8xZkBE1dp3rnDiScQkqIK8ARcsFL4iUNU7sn3Q1sPlm2d0D0daw/pX9MzVy3kQZrgGsXKGvyd2lxR/daCaGlIw+iIJ8IJAYjXUpa/JUtx83XdWA0OO/ClOcRi/HerUW7X6CdBhiBEo0BrN7QXsr2/4MnObuAA8yrR2qyDTCRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588541; c=relaxed/simple;
	bh=xS0ubkFihSeEk27XTYovs4edybU4hVCKaGE7sZlaekw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbCXKU7l6FIvPnJNSu2d1AokF4s+uvwjwtreuChZsZUWoANB6yzoSkSgSF4islD41QpJpnJde+7xh9C2dskIIUao9LZ+OuRPA6IFy+8uRaSbyFDAbm6zLRlKLubhB00AP9ZAAmeOvQV+MXw6DzKPCiXYped/ueYiodRpZs+I450=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPkSe4Nl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPkSe4Nl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9141C4CEE3;
	Tue, 22 Oct 2024 09:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588541;
	bh=xS0ubkFihSeEk27XTYovs4edybU4hVCKaGE7sZlaekw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LPkSe4Nl+lzI0KUmSoJpesEyYvI6uej3duzR9N1QnRfTPW5RpNwN16abH7NXa8w1T
	 9xtN5ijK5YXMDJtGuYVNuVYWFzWxX32pdA2ftq3QC7jiXPyhwgagSlMfRxG9a+rgzK
	 v+5hTJ23GzajmA3Hvfr2WktjjdIDy3MWQ5vTwMna5V2MGWUjNFfVyfl9FOXk0Hj/zu
	 x2CK7Lw5R4/oamdBmdGVoWl+bEY21oe8fYfxCVFfeecng6Md7yGuvdaD1bx8WYRYEw
	 ebLsIG1PaKoNQC+WjoDf7wVltg0XZLv3PmptWfTFbCfczdhHuCeay5WtxQ2x+7zKaS
	 DzHBonoKa1xZg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 30/36] mptcp: implement userspace pm interfaces
Date: Tue, 22 Oct 2024 17:14:38 +0800
Message-ID: <e1e9203781350f7ec5d155572f4839f9cb85597d.1729588019.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729588019.git.tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

1. implements address_announce() and address_remove() interfaces of the
userspace PM.

Extract address_announce() interface from the handler of netlink commond
MPTCP_PM_CMD_ANNOUNCE mptcp_pm_nl_announce_doit(), only leave the code for
obtaining msk through "info" and parsing address entry in the handler.

Extract address_remove() interface from the handler of netlink commond
MPTCP_PM_CMD_REMOVE mptcp_pm_nl_remove_doit(), only leave the code for
parsing address id and obtaining msk through "info" in the handler.

Both interfaces are invoked under holding the msk socket lock.

2. implements subflow_create() and subflow_destroy() interfaces of the
userspace PM.

Extract subflow_create() interface from the handler of netlink commond
MPTCP_PM_CMD_SUBFLOW_CREATE mptcp_pm_nl_subflow_create_doit(), only leave
the code for obtaining msk through "info", parsing local address entry
and parsing remote address info in the handler.

Extract subflow_destroy() interface from the handler of netlink commond
MPTCP_PM_CMD_SUBFLOW_DESTROY mptcp_pm_nl_subflow_destroy_doit(), only leave
the code for obtaining msk through "info", parsing local address entry and
parsing remote address info in the handler.

Both interfaces are invoked under holding the msk socket lock.

3. implements get_local_id(), get_flags(), get_addr(), dump_addr() and
set_flags() interfaces of the userspace PM.

get_local_id() interface is the same as mptcp_userspace_pm_get_local_id(),
which now can be defined as a wrapper of the interface. While get_flags()
interface is the same as mptcp_userspace_pm_get_flags() too, which now can
be defined as a wrapper of get_flags() interface.

get_addr() interface is a wrapper of mptcp_userspace_pm_lookup_addr_by_id()
helper. While dump_addr() is a wrapper of mptcp_userspace_pm_set_bitmap()
helper. These two interfaces are invoked under holding both the msk socket
lock and the msk pm lock.

Extract set_flags() interface from function mptcp_userspace_pm_set_flags(),
only leave the code for obtaining msk through "info" in this function. This
interface is invoked under holding the msk socket lock.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 326 ++++++++++++++++++++++-----------------
 1 file changed, 187 insertions(+), 139 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 459532617663..54c97d3d05ef 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -135,8 +135,8 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 	return NULL;
 }
 
-int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
-				    struct mptcp_pm_addr_entry *local)
+static int userspace_pm_get_local_id(struct mptcp_sock *msk,
+				     struct mptcp_pm_addr_entry *local)
 {
 	struct mptcp_pm_addr_entry *entry = NULL;
 	__be16 msk_sport =  ((struct inet_sock *)
@@ -154,8 +154,14 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	return mptcp_userspace_pm_append_new_local_addr(msk, local, true);
 }
 
-u8 mptcp_userspace_pm_get_flags(struct mptcp_sock *msk,
-				struct mptcp_addr_info *skc)
+int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
+				    struct mptcp_pm_addr_entry *local)
+{
+	return userspace_pm_get_local_id(msk, local);
+}
+
+static u8 userspace_pm_get_flags(struct mptcp_sock *msk,
+				 struct mptcp_addr_info *skc)
 {
 	struct mptcp_pm_addr_entry *entry;
 	u8 flags = 0;
@@ -169,6 +175,12 @@ u8 mptcp_userspace_pm_get_flags(struct mptcp_sock *msk,
 	return flags;
 }
 
+u8 mptcp_userspace_pm_get_flags(struct mptcp_sock *msk,
+				struct mptcp_addr_info *skc)
+{
+	return userspace_pm_get_flags(msk, skc);
+}
+
 static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
@@ -195,6 +207,31 @@ static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *in
 	return msk;
 }
 
+static int userspace_pm_address_announce(struct mptcp_sock *msk,
+					 struct mptcp_pm_addr_entry *local)
+{
+	int err;
+
+	if (local->addr.id == 0 || !(local->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
+		return -EINVAL;
+
+	err = mptcp_userspace_pm_append_new_local_addr(msk, local, false);
+	if (err < 0)
+		return err;
+
+	spin_lock_bh(&msk->pm.lock);
+
+	if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
+		msk->pm.add_addr_signaled++;
+		mptcp_pm_announce_addr(msk, &local->addr, false);
+		mptcp_pm_nl_addr_send_ack(msk);
+	}
+
+	spin_unlock_bh(&msk->pm.lock);
+
+	return 0;
+}
+
 int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *addr = info->attrs[MPTCP_PM_ATTR_ADDR];
@@ -220,46 +257,24 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 		goto announce_err;
 	}
 
-	if (addr_val.addr.id == 0 || !(addr_val.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
-		GENL_SET_ERR_MSG(info, "invalid addr id or flags");
-		err = -EINVAL;
-		goto announce_err;
-	}
-
-	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val, false);
-	if (err < 0) {
-		GENL_SET_ERR_MSG(info, "did not match address and id");
-		goto announce_err;
-	}
-
 	lock_sock(sk);
-	spin_lock_bh(&msk->pm.lock);
-
-	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
-		msk->pm.add_addr_signaled++;
-		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
-		mptcp_pm_nl_addr_send_ack(msk);
-	}
-
-	spin_unlock_bh(&msk->pm.lock);
+	err = userspace_pm_address_announce(msk, &addr_val);
 	release_sock(sk);
+	if (err)
+		GENL_SET_ERR_MSG(info, "address_announce failed");
 
-	err = 0;
  announce_err:
 	sock_put(sk);
 	return err;
 }
 
-static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
-						     struct genl_info *info)
+static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk)
 {
 	struct mptcp_rm_list list = { .nr = 0 };
 	struct mptcp_subflow_context *subflow;
-	struct sock *sk = (struct sock *)msk;
 	bool has_id_0 = false;
 	int err = -EINVAL;
 
-	lock_sock(sk);
 	mptcp_for_each_subflow(msk, subflow) {
 		if (READ_ONCE(subflow->local_id) == 0) {
 			has_id_0 = true;
@@ -267,7 +282,7 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
 		}
 	}
 	if (!has_id_0) {
-		GENL_SET_ERR_MSG(info, "address with id 0 not found");
+		pr_debug("address with id 0 not found\n");
 		goto remove_err;
 	}
 
@@ -280,14 +295,36 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
 	err = 0;
 
 remove_err:
-	release_sock(sk);
 	return err;
 }
 
+static int userspace_pm_address_remove(struct mptcp_sock *msk, u8 id)
+{
+	struct sock *sk = (struct sock *)msk;
+	struct mptcp_pm_addr_entry *match;
+
+	if (id == 0)
+		return mptcp_userspace_pm_remove_id_zero_address(msk);
+
+	spin_lock_bh(&msk->pm.lock);
+	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
+	spin_unlock_bh(&msk->pm.lock);
+	if (!match)
+		return -EINVAL;
+
+	mptcp_pm_remove_addr_entry(msk, match);
+
+	spin_lock_bh(&msk->pm.lock);
+	list_del_rcu(&match->list);
+	sock_kfree_s(sk, match, sizeof(*match));
+	spin_unlock_bh(&msk->pm.lock);
+
+	return 0;
+}
+
 int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
-	struct mptcp_pm_addr_entry *match;
 	struct mptcp_sock *msk;
 	int err = -EINVAL;
 	struct sock *sk;
@@ -306,34 +343,42 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
-	if (id_val == 0) {
-		err = mptcp_userspace_pm_remove_id_zero_address(msk, info);
-		goto out;
-	}
-
 	lock_sock(sk);
+	err = userspace_pm_address_remove(msk, id_val);
+	release_sock(sk);
+	if (err)
+		GENL_SET_ERR_MSG(info, "address_remove failed");
 
-	spin_lock_bh(&msk->pm.lock);
-	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
-	spin_unlock_bh(&msk->pm.lock);
-	if (!match) {
-		GENL_SET_ERR_MSG(info, "address with specified id not found");
-		release_sock(sk);
-		goto out;
-	}
+	sock_put(sk);
+	return err;
+}
 
-	mptcp_pm_remove_addr_entry(msk, match);
+static int userspace_pm_subflow_create(struct mptcp_sock *msk,
+				       struct mptcp_pm_addr_entry *local,
+				       struct mptcp_addr_info *remote)
+{
+	struct sock *sk = (struct sock *)msk;
+	int err;
 
-	release_sock(sk);
+	if (local->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)
+		return -EINVAL;
+	local->flags |= MPTCP_PM_ADDR_FLAG_SUBFLOW;
 
+	if (!mptcp_pm_addr_families_match(sk, &local->addr, remote))
+		return -EINVAL;
+
+	err = mptcp_userspace_pm_append_new_local_addr(msk, local, false);
+	if (err < 0)
+		return err;
+
+	err = __mptcp_subflow_connect(sk, local, remote);
 	spin_lock_bh(&msk->pm.lock);
-	list_del_rcu(&match->list);
-	sock_kfree_s(sk, match, sizeof(*match));
+	if (err)
+		mptcp_userspace_pm_delete_local_addr(msk, local);
+	else
+		msk->pm.subflows++;
 	spin_unlock_bh(&msk->pm.lock);
 
-	err = 0;
-out:
-	sock_put(sk);
 	return err;
 }
 
@@ -364,41 +409,17 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -453,6 +474,46 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
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
@@ -460,8 +521,8 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	struct mptcp_pm_addr_entry local;
 	struct mptcp_addr_info addr_r;
 	struct mptcp_sock *msk;
-	struct sock *sk, *ssk;
 	int err = -EINVAL;
+	struct sock *sk;
 
 	if (!laddr || !raddr) {
 		GENL_SET_ERR_MSG(info, "missing required inputs");
@@ -486,78 +547,35 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
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
 	return err;
 }
 
-int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *loc,
-				 struct mptcp_addr_info *rem,
-				 struct genl_info *info)
+static int userspace_pm_set_flags(struct mptcp_sock *msk,
+				  struct mptcp_pm_addr_entry *local,
+				  struct mptcp_addr_info *remote)
 {
 	struct mptcp_pm_addr_entry *entry;
-	struct mptcp_sock *msk;
-	int ret = -EINVAL;
-	struct sock *sk;
 	u8 bkup = 0;
 
-	msk = mptcp_userspace_pm_get_sock(info);
-	if (!msk)
-		return ret;
-
-	sk = (struct sock *)msk;
-
-	if (loc->addr.family == AF_UNSPEC ||
-	    rem->family == AF_UNSPEC) {
-		GENL_SET_ERR_MSG(info, "invalid address families");
-		ret = -EINVAL;
-		goto set_flags_err;
+	if (local->addr.family == AF_UNSPEC ||
+	    remote->family == AF_UNSPEC) {
+		pr_debug("invalid address families\n");
+		return -EINVAL;
 	}
 
-	if (loc->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
+	if (local->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_userspace_pm_lookup_addr(msk, &loc->addr);
+	entry = mptcp_userspace_pm_lookup_addr(msk, &local->addr);
 	if (entry) {
 		if (bkup)
 			entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
@@ -566,11 +584,29 @@ int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *loc,
 	}
 	spin_unlock_bh(&msk->pm.lock);
 
+	return mptcp_pm_nl_mp_prio_send_ack(msk, &local->addr, remote, bkup);
+}
+
+int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *loc,
+				 struct mptcp_addr_info *rem,
+				 struct genl_info *info)
+{
+	struct mptcp_sock *msk;
+	int ret = -EINVAL;
+	struct sock *sk;
+
+	msk = mptcp_userspace_pm_get_sock(info);
+	if (!msk)
+		return ret;
+
+	sk = (struct sock *)msk;
+
 	lock_sock(sk);
-	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc->addr, rem, bkup);
+	ret = userspace_pm_set_flags(msk, loc, rem);
 	release_sock(sk);
+	if (ret)
+		GENL_SET_ERR_MSG(info, "set_flags failed");
 
-set_flags_err:
 	sock_put(sk);
 	return ret;
 }
@@ -590,6 +626,12 @@ static int mptcp_userspace_pm_set_bitmap(struct mptcp_sock *msk,
 	return 0;
 }
 
+static int userspace_pm_dump_addr(struct mptcp_sock *msk,
+				  struct mptcp_id_bitmap *bitmap)
+{
+	return mptcp_userspace_pm_set_bitmap(msk, bitmap);
+}
+
 int mptcp_userspace_pm_dump_addr(struct mptcp_id_bitmap *bitmap,
 				 const struct genl_info *info)
 {
@@ -605,7 +647,7 @@ int mptcp_userspace_pm_dump_addr(struct mptcp_id_bitmap *bitmap,
 
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
-	ret = mptcp_userspace_pm_set_bitmap(msk, bitmap);
+	ret = userspace_pm_dump_addr(msk, bitmap);
 	spin_unlock_bh(&msk->pm.lock);
 	release_sock(sk);
 
@@ -613,6 +655,12 @@ int mptcp_userspace_pm_dump_addr(struct mptcp_id_bitmap *bitmap,
 	return ret;
 }
 
+static struct mptcp_pm_addr_entry *
+userspace_pm_get_addr(struct mptcp_sock *msk, u8 id)
+{
+	return mptcp_userspace_pm_lookup_addr_by_id(msk, id);
+}
+
 int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 				const struct genl_info *info)
 {
@@ -629,7 +677,7 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
+	entry = userspace_pm_get_addr(msk, id);
 	if (entry) {
 		*addr = *entry;
 		ret = 0;
-- 
2.45.2

