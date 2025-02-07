Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE3C236A64
	for <mptcp@lists.linux.dev>; Fri,  7 Feb 2025 09:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738920586; cv=none; b=A17co1jL8jUDEi2qM/gKCKd9qk2G5IjUnfObfbH93Jt9uPo/ro/hzpUAdckCqjtBBAPqQD6V0+elw4CNFZmgA/1M9olhD7OiM4o4Zcjx6od8WDg+vaaidxhWBohHIf/ZLYjXeBskB3a6jnZcTUAE+6jAnK+pBrAYcdbONS2x0j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738920586; c=relaxed/simple;
	bh=bh2JX3UEB3FYqDdzgYWMDAgmNZfKbnc3FYa/hZekcEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkD4Q0zzQRGpayMuL/lIKPh7GyVPx98GcXzk9S4F/GsxKWfFj2PmbeqnCSNMfb8dFN4C2oQ4rKk1OKjWs/G7Nmcl07eZ73FJClXoVdBnnrestcC/oOdCER+76uagRt+Fwek0QgMlIWsvP77fLWFFAlWZ/QCooFgwTGwXUee6fYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMnpMOFx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMnpMOFx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A27C4CED6;
	Fri,  7 Feb 2025 09:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738920585;
	bh=bh2JX3UEB3FYqDdzgYWMDAgmNZfKbnc3FYa/hZekcEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bMnpMOFx3Zf0WgS7fFcaZ6c7mqd2Muk/j2fPrJLXfwIfUkE1tQuPFdINiOlQB3ngh
	 /2JohkKdOBMyQIX1a/DU6wlfr5+ZVqOtOPiUzBKeXE0S4uePAPCCqwd+Xx+xyyD0Ft
	 Yby+0GA+uetYOdtvwMyO2Ld9sBGlSKrumWo4Gsgj1yo9EYVH7dLm3WU+4rE/T1DqUg
	 TFalVYcf9YfqplyCYIt+PcKL6rP6F8wPWciOygPv4gRQ+5XvjBT09LrrIO1B6q6WFe
	 qJ+5clX5OD3tWqzx7Yez+NyETKHLZ80jyQ2rwutuCUWqN3HjmKbXqet9mxwzK4xxty
	 crpJQP9QrxnFA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 3/4] mptcp: register default userspace pm
Date: Fri,  7 Feb 2025 17:29:33 +0800
Message-ID: <5c5188d92bede3ba33554818e3eb0fe0dc10feb9.1738919954.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738919954.git.tanggeliang@kylinos.cn>
References: <cover.1738919954.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch defines the original userspace pm as the default path manager,
named mptcp_userspace_pm, and register it in mptcp_pm_data_init().

Extract address_announce() interface of the userspace PM from the handler
of netlink command MPTCP_PM_CMD_ANNOUNCE mptcp_pm_nl_announce_doit(), only
leave the code for obtaining msk through "info" and parsing address entry
in the handler.

Extract address_remove() interface of the userspace PM from the handler
of netlink command MPTCP_PM_CMD_REMOVE mptcp_pm_nl_remove_doit(), only
leave the code for parsing address id and obtaining msk through "info"
in the handler.

Extract subflow_create() interface of the userspace PM from the handler of
netlink command MPTCP_PM_CMD_SUBFLOW_CREATE

	mptcp_pm_nl_subflow_create_doit(),

only leave the code for obtaining msk through "info", parsing local address
entry and parsing remote address info in the handler.

Extract subflow_destroy() interface of the userspace PM from the handler of
netlink command MPTCP_PM_CMD_SUBFLOW_DESTROY

	mptcp_pm_nl_subflow_destroy_doit(),

only leave the code for obtaining msk through "info", parsing local address
entry and parsing remote address info in the handler.

Extract set_flags() interface of the userspace PM from function
mptcp_userspace_pm_set_flags(), only leave the code for obtaining
msk through "info" in this function.

All fives interfaces are invoked under holding the msk socket lock.

Extract get_local_id() interface of the userspace PM from function
mptcp_userspace_pm_get_local_id(), only leave the code for setting
new address entry in this function.

get_flags() interface of the userspace PM is defined as the same as
the function mptcp_userspace_pm_get_flags(), then this function
becomes a wrapper.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           |   1 +
 net/mptcp/pm_userspace.c | 280 +++++++++++++++++++++++----------------
 net/mptcp/protocol.h     |   1 +
 3 files changed, 171 insertions(+), 111 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 344bc477c502..1304a0c99e12 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -648,6 +648,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 void __init mptcp_pm_init(void)
 {
 	mptcp_pm_nl_init();
+	mptcp_userspace_pm_init();
 }
 
 /* Must be called with rcu read lock held */
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6bf6a20ef7f3..3d324aaec550 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -130,19 +130,27 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 	return NULL;
 }
 
-int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
-				    struct mptcp_addr_info *skc)
+static int userspace_pm_get_local_id(struct mptcp_sock *msk,
+				     struct mptcp_pm_addr_entry *skc)
 {
-	struct mptcp_pm_addr_entry *entry = NULL, new_entry;
-	__be16 msk_sport =  ((struct inet_sock *)
-			     inet_sk((struct sock *)msk))->inet_sport;
+	struct mptcp_pm_addr_entry *entry;
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_userspace_pm_lookup_addr(msk, skc);
+	entry = mptcp_userspace_pm_lookup_addr(msk, &skc->addr);
 	spin_unlock_bh(&msk->pm.lock);
 	if (entry)
 		return entry->addr.id;
 
+	return mptcp_userspace_pm_append_new_local_addr(msk, skc, true);
+}
+
+int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
+				    struct mptcp_addr_info *skc)
+{
+	__be16 msk_sport = ((struct inet_sock *)
+			    inet_sk((struct sock *)msk))->inet_sport;
+	struct mptcp_pm_addr_entry new_entry;
+
 	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
 	new_entry.addr = *skc;
 	new_entry.addr.id = 0;
@@ -151,11 +159,11 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	if (new_entry.addr.port == msk_sport)
 		new_entry.addr.port = 0;
 
-	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry, true);
+	return userspace_pm_get_local_id(msk, &new_entry);
 }
 
-bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
-				  struct mptcp_addr_info *skc)
+static bool userspace_pm_get_priority(struct mptcp_sock *msk,
+				      struct mptcp_addr_info *skc)
 {
 	struct mptcp_pm_addr_entry *entry;
 	bool backup;
@@ -168,6 +176,12 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
 	return backup;
 }
 
+bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
+				  struct mptcp_addr_info *skc)
+{
+	return userspace_pm_get_priority(msk, skc);
+}
+
 static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *info)
 {
 	struct mptcp_sock *msk;
@@ -193,6 +207,28 @@ static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *in
 	return msk;
 }
 
+static int userspace_pm_address_announced(struct mptcp_sock *msk,
+					  struct mptcp_pm_addr_entry *local)
+{
+	int err;
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
 	struct mptcp_pm_addr_entry addr_val;
@@ -227,26 +263,13 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 		goto announce_err;
 	}
 
-	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val, false);
-	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, addr,
-				    "did not match address and id");
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
+	err = userspace_pm_address_announced(msk, &addr_val);
 	release_sock(sk);
+	if (err)
+		NL_SET_ERR_MSG_ATTR(info->extack, addr,
+				    "did not match address and id");
 
-	err = 0;
  announce_err:
 	sock_put(sk);
 	return err;
@@ -256,11 +279,8 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk)
 {
 	struct mptcp_rm_list list = { .nr = 0 };
 	struct mptcp_subflow_context *subflow;
-	struct sock *sk = (struct sock *)msk;
 	bool has_id_0 = false;
-	int err = -EINVAL;
 
-	lock_sock(sk);
 	mptcp_for_each_subflow(msk, subflow) {
 		if (READ_ONCE(subflow->local_id) == 0) {
 			has_id_0 = true;
@@ -268,7 +288,7 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk)
 		}
 	}
 	if (!has_id_0)
-		goto remove_err;
+		return -EINVAL;
 
 	list.ids[list.nr++] = 0;
 
@@ -276,11 +296,7 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk)
 	mptcp_pm_remove_addr(msk, &list);
 	spin_unlock_bh(&msk->pm.lock);
 
-	err = 0;
-
-remove_err:
-	release_sock(sk);
-	return err;
+	return 0;
 }
 
 void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
@@ -303,9 +319,32 @@ void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 	spin_unlock_bh(&msk->pm.lock);
 }
 
+static int userspace_pm_address_removed(struct mptcp_sock *msk, u8 id)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	if (id == 0)
+		return mptcp_userspace_pm_remove_id_zero_address(msk);
+
+	spin_lock_bh(&msk->pm.lock);
+	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
+	if (!entry) {
+		spin_unlock_bh(&msk->pm.lock);
+		return -EINVAL;
+	}
+
+	list_del_rcu(&entry->list);
+	spin_unlock_bh(&msk->pm.lock);
+
+	mptcp_pm_remove_addr_entry(msk, entry);
+
+	sock_kfree_s((struct sock *)msk, entry, sizeof(*entry));
+
+	return 0;
+}
+
 int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct mptcp_pm_addr_entry *match;
 	struct mptcp_sock *msk;
 	struct nlattr *id;
 	int err = -EINVAL;
@@ -324,32 +363,9 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
-	if (id_val == 0) {
-		err = mptcp_userspace_pm_remove_id_zero_address(msk);
-		goto out;
-	}
-
 	lock_sock(sk);
-
-	spin_lock_bh(&msk->pm.lock);
-	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
-	if (!match) {
-		spin_unlock_bh(&msk->pm.lock);
-		release_sock(sk);
-		goto out;
-	}
-
-	list_del_rcu(&match->list);
-	spin_unlock_bh(&msk->pm.lock);
-
-	mptcp_pm_remove_addr_entry(msk, match);
-
+	err = userspace_pm_address_removed(msk, id_val);
 	release_sock(sk);
-
-	sock_kfree_s(sk, match, sizeof(*match));
-
-	err = 0;
-out:
 	if (err)
 		NL_SET_ERR_MSG_ATTR_FMT(info->extack, id,
 					"address with id %u not found",
@@ -359,12 +375,38 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+static int userspace_pm_subflow_established(struct mptcp_sock *msk,
+					    struct mptcp_pm_addr_entry *entry,
+					    struct mptcp_addr_info *remote)
+{
+	struct sock *sk = (struct sock *)msk;
+	struct mptcp_pm_local local;
+	int err;
+
+	err = mptcp_userspace_pm_append_new_local_addr(msk, entry, false);
+	if (err < 0)
+		return err;
+
+	local.addr = entry->addr;
+	local.flags = entry->flags;
+	local.ifindex = entry->ifindex;
+
+	err = __mptcp_subflow_connect(sk, &local, remote);
+	spin_lock_bh(&msk->pm.lock);
+	if (err)
+		mptcp_userspace_pm_delete_local_addr(msk, entry);
+	else
+		msk->pm.subflows++;
+	spin_unlock_bh(&msk->pm.lock);
+
+	return err;
+}
+
 int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry entry = { 0 };
 	struct mptcp_addr_info addr_r;
 	struct nlattr *raddr, *laddr;
-	struct mptcp_pm_local local;
 	struct mptcp_sock *msk;
 	int err = -EINVAL;
 	struct sock *sk;
@@ -402,31 +444,13 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	err = mptcp_userspace_pm_append_new_local_addr(msk, &entry, false);
-	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, laddr,
-				    "did not match address and id");
-		goto create_err;
-	}
-
-	local.addr = entry.addr;
-	local.flags = entry.flags;
-	local.ifindex = entry.ifindex;
-
 	lock_sock(sk);
-	err = __mptcp_subflow_connect(sk, &local, &addr_r);
+	err = userspace_pm_subflow_established(msk, &entry, &addr_r);
 	release_sock(sk);
 
 	if (err)
 		GENL_SET_ERR_MSG_FMT(info, "connect error: %d", err);
 
-	spin_lock_bh(&msk->pm.lock);
-	if (err)
-		mptcp_userspace_pm_delete_local_addr(msk, &entry);
-	else
-		msk->pm.subflows++;
-	spin_unlock_bh(&msk->pm.lock);
-
  create_err:
 	sock_put(sk);
 	return err;
@@ -478,14 +502,34 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
 	return NULL;
 }
 
+static int userspace_pm_subflow_closed(struct mptcp_sock *msk,
+				       struct mptcp_pm_addr_entry *local,
+				       struct mptcp_addr_info *remote)
+{
+	struct sock *ssk, *sk = (struct sock *)msk;
+
+	ssk = mptcp_nl_find_ssk(msk, &local->addr, remote);
+	if (!ssk)
+		return -ESRCH;
+
+	spin_lock_bh(&msk->pm.lock);
+	mptcp_userspace_pm_delete_local_addr(msk, local);
+	spin_unlock_bh(&msk->pm.lock);
+	mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
+	mptcp_close_ssk(sk, ssk, mptcp_subflow_ctx(ssk));
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
+
+	return 0;
+}
+
 int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry addr_l;
 	struct mptcp_addr_info addr_r;
 	struct nlattr *raddr, *laddr;
 	struct mptcp_sock *msk;
-	struct sock *sk, *ssk;
 	int err = -EINVAL;
+	struct sock *sk;
 
 	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR) ||
 	    GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR_REMOTE))
@@ -536,37 +580,47 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	}
 
 	lock_sock(sk);
-	ssk = mptcp_nl_find_ssk(msk, &addr_l.addr, &addr_r);
-	if (!ssk) {
-		GENL_SET_ERR_MSG(info, "subflow not found");
-		err = -ESRCH;
-		goto release_sock;
-	}
-
-	spin_lock_bh(&msk->pm.lock);
-	mptcp_userspace_pm_delete_local_addr(msk, &addr_l);
-	spin_unlock_bh(&msk->pm.lock);
-	mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
-	mptcp_close_ssk(sk, ssk, mptcp_subflow_ctx(ssk));
-	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
-release_sock:
+	err = userspace_pm_subflow_closed(msk, &addr_l, &addr_r);
 	release_sock(sk);
+	if (err)
+		GENL_SET_ERR_MSG(info, "subflow not found");
 
 destroy_err:
 	sock_put(sk);
 	return err;
 }
 
+static int userspace_pm_set_priority(struct mptcp_sock *msk,
+				     struct mptcp_pm_addr_entry *local,
+				     struct mptcp_addr_info *remote)
+{
+	struct mptcp_pm_addr_entry *entry;
+	u8 bkup = 0;
+
+	if (local->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
+		bkup = 1;
+
+	spin_lock_bh(&msk->pm.lock);
+	entry = mptcp_userspace_pm_lookup_addr(msk, &local->addr);
+	if (entry) {
+		if (bkup)
+			entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
+		else
+			entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
+	}
+	spin_unlock_bh(&msk->pm.lock);
+
+	return mptcp_pm_nl_mp_prio_send_ack(msk, &local->addr, remote, bkup);
+}
+
 int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
 				 struct genl_info *info)
 {
 	struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
-	struct mptcp_pm_addr_entry *entry;
 	struct nlattr *attr, *attr_rem;
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
-	u8 bkup = 0;
 
 	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR_REMOTE))
 		return ret;
@@ -597,21 +651,8 @@ int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
 		goto set_flags_err;
 	}
 
-	if (local->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
-		bkup = 1;
-
-	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_userspace_pm_lookup_addr(msk, &local->addr);
-	if (entry) {
-		if (bkup)
-			entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
-		else
-			entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
-	}
-	spin_unlock_bh(&msk->pm.lock);
-
 	lock_sock(sk);
-	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &local->addr, &rem, bkup);
+	ret = userspace_pm_set_priority(msk, local, &rem);
 	release_sock(sk);
 
 	/* mptcp_pm_nl_mp_prio_send_ack() only fails in one case */
@@ -691,3 +732,20 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 	sock_put(sk);
 	return ret;
 }
+
+static struct mptcp_pm_ops mptcp_userspace_pm = {
+	.address_announced	= userspace_pm_address_announced,
+	.address_removed	= userspace_pm_address_removed,
+	.subflow_established	= userspace_pm_subflow_established,
+	.subflow_closed		= userspace_pm_subflow_closed,
+	.get_local_id		= userspace_pm_get_local_id,
+	.get_priority		= userspace_pm_get_priority,
+	.set_priority		= userspace_pm_set_priority,
+	.type			= MPTCP_PM_TYPE_USERSPACE,
+	.owner			= THIS_MODULE,
+};
+
+void __init mptcp_userspace_pm_init(void)
+{
+	mptcp_pm_register(&mptcp_userspace_pm);
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index cd36ffe8509b..79cd10447b7b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1159,6 +1159,7 @@ static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflo
 }
 
 void __init mptcp_pm_nl_init(void);
+void __init mptcp_userspace_pm_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
-- 
2.43.0

