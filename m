Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB631366
	for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 00:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655945996; x=1687481996;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=vvj/lpl/Ht10ibAe0ySlf5CaHdJ3WbdmdDTNHjVhBHM=;
  b=IsdeuByIzpoBfUORDovh3BL5Ux7xq01ZyChEZNkeCGonrEW/fn798sAD
   jas8t2Ng8LosE2vmKwNO6r+a2etFtqneLjdZ4KIo98+lBJHTqKc/tfiwb
   4yBMx5os0pkNlIxfMk7srhNShA/lEbLPPFjmfFw3ab57K1sldQoNKyOwE
   IYp4UxJccKgQY1L6IUgJw5fUMcFFnJz202ZYBDZNXS8vIN1SFxOFACwwC
   PPZiDK+yKvKZOOcAtX4BGjCha1qZjzEL2eVlo/6pMLgf1DcWTz4lUGK0H
   PULNGul+yIkNF6zaCidUjPt5SuYF2G4XMcxpzzLJJ+EVjX6FbPmVyNMEr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="278137859"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="278137859"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 17:59:54 -0700
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="914950196"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 17:59:53 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 1/2] mptcp: netlink: issue MP_PRIO signals from userspace PMs
Date: Wed, 22 Jun 2022 20:59:47 -0400
Message-Id: <20220623005948.291792-2-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220623005948.291792-1-kishen.maloor@intel.com>
References: <20220623005948.291792-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change updates MPTCP_PM_CMD_SET_FLAGS to allow userspace PMs
to issue MP_PRIO signals for a specified address ID over a chosen
(by token) MPTCP connection.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/286
Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 net/mptcp/pm_netlink.c   | 23 +++++++++++++++++------
 net/mptcp/pm_userspace.c | 30 ++++++++++++++++++++++++++++++
 net/mptcp/protocol.h     |  6 +++++-
 3 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e099f2a12504..063700ff8cbb 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -717,9 +717,9 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 	}
 }
 
-static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
-					struct mptcp_addr_info *addr,
-					u8 bkup)
+int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
+				 struct mptcp_addr_info *addr,
+				 u8 bkup, bool use_id)
 {
 	struct mptcp_subflow_context *subflow;
 
@@ -730,10 +730,15 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 		struct sock *sk = (struct sock *)msk;
 		struct mptcp_addr_info local;
 
-		local_address((struct sock_common *)ssk, &local);
-		if (!mptcp_addresses_equal(&local, addr, addr->port))
+		if (use_id && subflow->local_id != addr->id)
 			continue;
 
+		if (!use_id) {
+			local_address((struct sock_common *)ssk, &local);
+			if (!mptcp_addresses_equal(&local, addr, addr->port))
+				continue;
+		}
+
 		if (subflow->backup != bkup)
 			msk->last_snd = NULL;
 		subflow->backup = bkup;
@@ -1837,7 +1842,7 @@ static int mptcp_nl_set_flags(struct net *net,
 		lock_sock(sk);
 		spin_lock_bh(&msk->pm.lock);
 		if (changed & MPTCP_PM_ADDR_FLAG_BACKUP)
-			ret = mptcp_pm_nl_mp_prio_send_ack(msk, addr, bkup);
+			ret = mptcp_pm_nl_mp_prio_send_ack(msk, addr, bkup, false);
 		if (changed & MPTCP_PM_ADDR_FLAG_FULLMESH)
 			mptcp_pm_nl_fullmesh(msk, addr);
 		spin_unlock_bh(&msk->pm.lock);
@@ -1854,6 +1859,7 @@ static int mptcp_nl_set_flags(struct net *net,
 static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, }, *entry;
+	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
@@ -1868,6 +1874,11 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
 
 	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
+
+	if (token)
+		return mptcp_userspace_pm_set_flags(sock_net(skb->sk),
+						    token, &addr, bkup);
+
 	if (addr.addr.family == AF_UNSPEC) {
 		lookup_by_id = 1;
 		if (!addr.addr.id)
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 3d1d365e9c6f..b9df969cd38a 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -429,3 +429,33 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 	sock_put((struct sock *)msk);
 	return err;
 }
+
+int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
+				 struct mptcp_pm_addr_entry *entry, u8 bkup)
+{
+	struct mptcp_sock *msk;
+	int ret = -EINVAL;
+	u32 token_val;
+
+	token_val = nla_get_u32(token);
+
+	msk = mptcp_token_get_sock(net, token_val);
+	if (!msk)
+		return ret;
+
+	if (!mptcp_pm_is_userspace(msk))
+		goto set_flags_err;
+
+	if (entry->addr.family != AF_UNSPEC)
+		goto set_flags_err;
+
+	lock_sock((struct sock *)msk);
+	spin_lock_bh(&msk->pm.lock);
+	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &entry->addr, bkup, true);
+	spin_unlock_bh(&msk->pm.lock);
+	release_sock((struct sock *)msk);
+
+set_flags_err:
+	sock_put((struct sock *)msk);
+	return ret;
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bef7dea9f358..9bb49d199fa5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -783,6 +783,9 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);
 void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
 void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq);
+int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
+				 struct mptcp_addr_info *addr,
+				 u8 bkup, bool use_id);
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 			      const struct mptcp_pm_addr_entry *entry);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
@@ -799,7 +802,8 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 						   unsigned int id,
 						   u8 *flags, int *ifindex);
-
+int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
+				 struct mptcp_pm_addr_entry *entry, u8 bkup);
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
-- 
2.31.1

