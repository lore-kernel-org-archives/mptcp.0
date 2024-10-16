Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF26A17D378
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070020; cv=none; b=Vm6ggd10S200W6c7Zx+JqIQftMC47kxtVCrxnK8LzmRNPB7TAwdbbGa3K71WaL2xNLr8u3z0c/3xz0h1JfLSY4ou7UAuNo6hHEcGgkVPQmri/mhQBIuwMV12dvV2LHuMsAo1/ziPrXEGukyHCTHKwAlplwnMtWe0NPmlkTDrt1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070020; c=relaxed/simple;
	bh=JyFRrbOuTWDBqfUobiyMmyG5mYpvqPKwXVtX68H4aNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivyb+h2e31SWg+IBj/IUSVesc6mIcICiAl03t/anKwGi3Uu0TLopU3crrMcN5/DmKAoHmqekghKqZY69aU9eDbIuiMOyutl46BDDil9SCzFOwQI2Vfpg41QCECBMveKGMj6udbAq1rUPbJx/KR7mBYL2Rt8AYp1tpD3g7SkhcU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeT8+3kr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeT8+3kr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49582C4CEC5;
	Wed, 16 Oct 2024 09:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729070019;
	bh=JyFRrbOuTWDBqfUobiyMmyG5mYpvqPKwXVtX68H4aNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UeT8+3krY1sjqEggzmwEPoNHCgY69h3t4QxhDROdUcDASGwIRtHrfR8fh0+8A3ser
	 +vJBl3Sgksz5N+U31zBnBCOm+xTVjpG0oRmnKjmcE7iXbGqhOCgCBw1kkQVEUpsEjO
	 L3u2ZZW6yjoWZBOvFXUQsmwIkd0wEt8Ujb/PgPfgdrKBr6MpTpSfpn89LAVrD/tiAU
	 mu3CkvtdiunCfzezq4XcrFT65PiRkQfDP2aBKxnUQ9MvqF/3aeCSYr8nrQpRPhscxd
	 UFGyzWadQ7zy7QWl+K3/IwxkhFIqjgYxMUh+XNAsq7YWLAUIK9HyoCWWeIGVnanEU6
	 V9Ia1g0vaswBQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 30/33] mptcp: implement userspace pm address interfaces
Date: Wed, 16 Oct 2024 17:12:34 +0800
Message-ID: <87c4d3dfcf3dc290b95e7f7c3221ae6597342f2f.1729069854.git.tanggeliang@kylinos.cn>
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

This patch implements address_announce() and address_remove() interfaces
of the userspace PM.

Extract address_announce() interface from the handler of netlink commond
MPTCP_PM_CMD_ANNOUNCE mptcp_pm_nl_announce_doit(), only leave the code for
obtaining msk through "info" and parsing address entry in the handler.

Extract address_remove() interface from the handler of netlink commond
MPTCP_PM_CMD_REMOVE mptcp_pm_nl_remove_doit(), only leave the code for
parsing address id and obtaining msk through "info" in the handler.

Both interfaces are invoked under holding the msk socket lock.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 110 ++++++++++++++++++++-------------------
 1 file changed, 57 insertions(+), 53 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 3cc8bf26ffb0..68eec0672743 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -195,6 +195,31 @@ static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *in
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
@@ -220,46 +245,24 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -267,7 +270,7 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
 		}
 	}
 	if (!has_id_0) {
-		GENL_SET_ERR_MSG(info, "address with id 0 not found");
+		pr_debug("address with id 0 not found\n");
 		goto remove_err;
 	}
 
@@ -280,14 +283,36 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
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
@@ -306,33 +331,12 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
-	if (id_val == 0) {
-		err = mptcp_userspace_pm_remove_id_zero_address(msk, info);
-		goto out;
-	}
-
 	lock_sock(sk);
-
-	spin_lock_bh(&msk->pm.lock);
-	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
-	spin_unlock_bh(&msk->pm.lock);
-	if (!match) {
-		GENL_SET_ERR_MSG(info, "address with specified id not found");
-		release_sock(sk);
-		goto out;
-	}
-
-	mptcp_pm_remove_addr_entry(msk, match);
-
+	err = userspace_pm_address_remove(msk, id_val);
 	release_sock(sk);
+	if (err)
+		GENL_SET_ERR_MSG(info, "address_remove failed");
 
-	spin_lock_bh(&msk->pm.lock);
-	list_del_rcu(&match->list);
-	sock_kfree_s(sk, match, sizeof(*match));
-	spin_unlock_bh(&msk->pm.lock);
-
-	err = 0;
-out:
 	sock_put(sk);
 	return err;
 }
-- 
2.43.0

