Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78A3C2C6
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 07:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494597; cv=none; b=C9Giv/4Xjk/SXa0HrIey2JOxApwucgAoAt1dYJT/Dm5YAHKe6eUFQQaARZSJo1BDf9HdVKH6LsPjj90BK0hvw4XoAtrJf3O0vgCEjiIALPvAOBORwsClXK+En4HDkRCKMt0apRGwqZ4g5nO7vj947p1F7lt1TbvcA25eB+JTKsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494597; c=relaxed/simple;
	bh=JAxk+mNkgHSbTPKJU6Use519Bj2eL+vhiKXfZ3dbbEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUOZ70NaX6zXWPZYzbIyZrvZXq3smsirQMGEk0UNaRvKWGXQAXBIvw5tz6sUStAkaYjLhVB/MLEl9LlkCKxJs9HDAoQ0f4rWof6AmT43i/9cEcN/XNHO8yIMzukHx8FYbUASJVTeL9WNr5sl2R7KXuJ825wOzRr3+hNB++XRUL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePDgsEOK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePDgsEOK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD23CC4CED6;
	Fri, 10 Jan 2025 07:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736494597;
	bh=JAxk+mNkgHSbTPKJU6Use519Bj2eL+vhiKXfZ3dbbEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ePDgsEOKtmcLAkvtLpl7CmqC5F+XUe7yFggQ+ocZPwePVgp1Jps3fJ6lNhxGIgclE
	 BF9F4UtcXc6rCl2HHhoyL7DyLbCovt9ig+vWWs1hKDUflz81KMxotH8JVYdjiOU4HU
	 skc7FznUxnTlgKZ/Hf1tW5+2U9pGXpBHHzwpnu5jwGMz7BNarHpDpFQ3xM0yo1WPAT
	 99vuMyq0QOc/nbwiYTCh1UDZ0Pn4eGAeTt0KnGH8TzLL52Cb2YXC8Z8YgQaXau63T6
	 w0ni1X0K7J0B25YNMN65pcrSw7amgArde5iFhTsz0357owEh0qaLeJQJ+YXAIC5o9S
	 /VS9QD1khyt3A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 7/7] mptcp: add local parameter for set_flags
Date: Fri, 10 Jan 2025 15:36:20 +0800
Message-ID: <3613363fc62da1323303ff776fba2914433e95c7.1736494320.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736494320.git.tanggeliang@kylinos.cn>
References: <cover.1736494320.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch updates the interfaces set_flags to reduce repetitive
code, adds a new parameter 'local' for them. The local address is
parsed in public helper mptcp_pm_nl_set_flags_doit(), then pass
it to mptcp_pm_nl_set_flags() and mptcp_userspace_pm_set_flags().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           | 16 ++++++++++++++--
 net/mptcp/pm_netlink.c   | 34 ++++++++++++----------------------
 net/mptcp/pm_userspace.c | 22 ++++++++--------------
 net/mptcp/protocol.h     |  6 ++++--
 4 files changed, 38 insertions(+), 40 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index c213f06bc702..b1f36dc1a091 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -506,9 +506,21 @@ int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
 
 static int mptcp_pm_set_flags(struct genl_info *info)
 {
+	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
+	struct nlattr *attr_loc;
+	int ret = -EINVAL;
+
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR))
+		return ret;
+
+	attr_loc = info->attrs[MPTCP_PM_ATTR_ADDR];
+	ret = mptcp_pm_parse_entry(attr_loc, info, false, &loc);
+	if (ret < 0)
+		return ret;
+
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_set_flags(info);
-	return mptcp_pm_nl_set_flags(info);
+		return mptcp_userspace_pm_set_flags(&loc, info);
+	return mptcp_pm_nl_set_flags(&loc, info);
 }
 
 int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 52fd9830b685..ec6afa5c3525 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1951,61 +1951,51 @@ static int mptcp_nl_set_flags(struct net *net,
 	return ret;
 }
 
-int mptcp_pm_nl_set_flags(struct genl_info *info)
+int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
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
-
-	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR))
-		return -EINVAL;
 
 	pernet = pm_nl_get_pernet(net);
 
-	attr = info->attrs[MPTCP_PM_ATTR_ADDR];
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
-	if (ret < 0)
-		return ret;
-
-	if (addr.addr.family == AF_UNSPEC) {
+	if (local->addr.family == AF_UNSPEC) {
 		lookup_by_id = 1;
-		if (!addr.addr.id) {
+		if (!local->addr.id) {
 			GENL_SET_ERR_MSG(info, "missing address ID");
 			return -EOPNOTSUPP;
 		}
 	}
 
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
index 4007f67cc7b1..431454578021 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -564,19 +564,18 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	return err;
 }
 
-int mptcp_userspace_pm_set_flags(struct genl_info *info)
+int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
+				 struct genl_info *info)
 {
-	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
 	struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
 	struct mptcp_pm_addr_entry *entry;
-	struct nlattr *attr, *attr_rem;
+	struct nlattr *attr_rem;
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
 	u8 bkup = 0;
 
-	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR) ||
-	    GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR_REMOTE))
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR_REMOTE))
 		return ret;
 
 	msk = mptcp_userspace_pm_get_sock(info);
@@ -585,12 +584,7 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
-	attr = info->attrs[MPTCP_PM_ATTR_ADDR];
-	ret = mptcp_pm_parse_entry(attr, info, false, &loc);
-	if (ret < 0)
-		goto set_flags_err;
-
-	if (loc.addr.family == AF_UNSPEC) {
+	if (local->addr.family == AF_UNSPEC) {
 		GENL_SET_ERR_MSG(info, "invalid local address family");
 		ret = -EINVAL;
 		goto set_flags_err;
@@ -608,11 +602,11 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 		goto set_flags_err;
 	}
 
-	if (loc.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
+	if (local->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_userspace_pm_lookup_addr(msk, &loc.addr);
+	entry = mptcp_userspace_pm_lookup_addr(msk, &local->addr);
 	if (entry) {
 		if (bkup)
 			entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
@@ -622,7 +616,7 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 	spin_unlock_bh(&msk->pm.lock);
 
 	lock_sock(sk);
-	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem, bkup);
+	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &local->addr, &rem, bkup);
 	release_sock(sk);
 
 	/* mptcp_pm_nl_mp_prio_send_ack() only fails in one case */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index aa014f514af3..9183c0bf8087 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1028,8 +1028,10 @@ bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
 				   const struct mptcp_addr_info *saddr);
 bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				     const struct mptcp_addr_info *addr);
-int mptcp_pm_nl_set_flags(struct genl_info *info);
-int mptcp_userspace_pm_set_flags(struct genl_info *info);
+int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
+			  struct genl_info *info);
+int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
+				 struct genl_info *info);
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
-- 
2.45.2

