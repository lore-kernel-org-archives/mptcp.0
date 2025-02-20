Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A3D1F1508
	for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047833; cv=none; b=Kr2BcF/TcApNxWlYWjrXhXBsjpw1TM8floKczvE2PPfdKSZwxYGQUctKl5LPD2gsOPNVyNt4oJo80kTVHk3wsNXlE3jCKKsH5ugql+DclGog4151xtiZrJIQTMJXMwP7f95IL5TISZF/Av+gJ/dXBlZRWaDtbB/S10GKWyYZAVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047833; c=relaxed/simple;
	bh=egZ43gRKd1v74mdOUJD4pUrM8ceSnxV3lGaDD3TTqHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swd9bLBKJMWfjaYWM+mUQZyA1wEGNmlYgvkUJ4VaZ+lV31SmE21AWuzAeEQ02mN8y9PBN8Gc1Y0EvV/011lMyqrL2cvvsjxonkrneLTpqpgXAp646sgvfUW8ihLGSpQ3nt/ra72r3bro24vxA9kL4bVPuylVIS5THWV88exAk+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpkEBtGD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpkEBtGD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0EAC4CED1;
	Thu, 20 Feb 2025 10:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740047833;
	bh=egZ43gRKd1v74mdOUJD4pUrM8ceSnxV3lGaDD3TTqHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MpkEBtGDpQgynJqXci+XE5w8pjYh5IRh+veqKK30yKVMTpJcF2RoGc8es2buF7QD1
	 /AGoaUnOn5KUQR126vnqh3D9pEXz1S6GHz3YNTbDr66VGFedQMH68zqewAsvsGx6GV
	 QVdcSqVZdi/D8w3FWCnl2GYedfjiYNpxOA83lBdGVc0I2YgaXVnGxoqPr7vafj89aj
	 VrB3VkdJRwigty3PPn1URAgYvfkhBXQ1bHbjYQJIl59EmQ1j9qrQnJSHRwdK/dFj8p
	 jZFst9xvwpGr8LbQm4yfh+xeB/GLLpgUorbD5Afcght1j3NCZxDfk+7W2Vlc21eQ6N
	 6+90ctwLnDiPg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 7/9] mptcp: pm: userspace: address_removed interface
Date: Thu, 20 Feb 2025 18:36:56 +0800
Message-ID: <c7bb046b76843959098c2d89ab652304a81d9086.1740047738.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740047738.git.tanggeliang@kylinos.cn>
References: <cover.1740047738.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Extract address_removed() interface of the userspace PM from the handler
of netlink command MPTCP_PM_CMD_REMOVE mptcp_pm_nl_remove_doit(), only
leave the code for parsing address id and obtaining msk through "info"
in the handler.

This interface is invoked under holding the msk socket lock.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 74 ++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index baac1027cfb8..770d1c3e5c81 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -267,11 +267,8 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk)
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
@@ -279,7 +276,7 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk)
 		}
 	}
 	if (!has_id_0)
-		goto remove_err;
+		return -EINVAL;
 
 	list.ids[list.nr++] = 0;
 
@@ -287,11 +284,7 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk)
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
@@ -314,20 +307,46 @@ void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 	spin_unlock_bh(&msk->pm.lock);
 }
 
+static int mptcp_userspace_pm_address_removed(struct mptcp_sock *msk,
+					      struct mptcp_pm_param *param)
+{
+	struct mptcp_pm_addr_entry *entry;
+	u8 id = param->addr.id;
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
+	struct mptcp_addr_info addr;
+	struct mptcp_pm_param param;
 	struct mptcp_sock *msk;
 	struct nlattr *id;
 	int err = -EINVAL;
 	struct sock *sk;
-	u8 id_val;
 
 	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_LOC_ID))
 		return err;
 
 	id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
-	id_val = nla_get_u8(id);
+	addr.id = nla_get_u8(id);
 
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
@@ -335,36 +354,16 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
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
+	mptcp_pm_param_set_contexts(&param, NULL, &addr);
+	err = msk->pm.ops && msk->pm.ops->address_removed ?
+	      msk->pm.ops->address_removed(msk, &param) :
+	      mptcp_userspace_pm_address_removed(msk, &param);
 	release_sock(sk);
-
-	sock_kfree_s(sk, match, sizeof(*match));
-
-	err = 0;
-out:
 	if (err)
 		NL_SET_ERR_MSG_ATTR_FMT(info->extack, id,
 					"address with id %u not found",
-					id_val);
+					addr.id);
 
 	sock_put(sk);
 	return err;
@@ -705,6 +704,7 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 
 static struct mptcp_pm_ops mptcp_userspace_pm = {
 	.address_announced	= mptcp_userspace_pm_address_announced,
+	.address_removed	= mptcp_userspace_pm_address_removed,
 	.get_local_id		= mptcp_userspace_pm_get_local_id,
 	.get_priority		= mptcp_userspace_pm_get_priority,
 	.type			= MPTCP_PM_TYPE_USERSPACE,
-- 
2.43.0

