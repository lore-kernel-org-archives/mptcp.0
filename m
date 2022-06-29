Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F89F63F
	for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 01:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656466030; x=1688002030;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=WAHi9xSqZUOGlvExsnLcgEDUdapMop7tfl0SFEHrI48=;
  b=ewdngf+m0WVRSXLXINlrMjUOWHzDx/zrgo0wUZDL/NJgizzBPUFbvnEV
   L1b9XEfXR29Caul4vIlR7gYfSDOsQS0GoDI60l6+PMfzyZqtSIyOw+25O
   n1xQCB+p2si/KxlFbYqwskC4B2k8UbixMX5jqrSoQhbm433B4YgsA01gA
   OeDmlsvdV0EHMAIo8siIW3jibaFU61VaQzuNTZ2aTS87zLXe9ulkTCwhF
   49sYVSYhUISpUPcH2mDhWsLAtr8NO9sIZWaNauPL3W4FvoZ2bCD5SAMHJ
   Lia7VmnLxs+kmqR2AjPr3P3396OgCUuG9Uyb7qKGbx0DgTCmK9Ikt/sFg
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="281926308"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="281926308"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 18:27:07 -0700
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="693355086"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 18:27:07 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v4 1/2] mptcp: netlink: issue MP_PRIO signals from userspace PMs
Date: Tue, 28 Jun 2022 21:27:01 -0400
Message-Id: <20220629012702.425574-2-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220629012702.425574-1-kishen.maloor@intel.com>
References: <20220629012702.425574-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change updates MPTCP_PM_CMD_SET_FLAGS to allow userspace PMs
to issue MP_PRIO signals over a specific subflow selected by
the connection token, local and remote address+port.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/286
Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
v3:
-use local and remote address+port (instead of address ID) alongwith the
connection token to select a subflow.

v4:
-fixed bug during rebase in v3.
---
 net/mptcp/pm_netlink.c   | 30 +++++++++++++++++++++++++-----
 net/mptcp/pm_userspace.c | 30 ++++++++++++++++++++++++++++++
 net/mptcp/protocol.h     |  8 +++++++-
 3 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 05c6a95e9c28..c4ac0a6ad4dc 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -717,9 +717,10 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 	}
 }
 
-static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
-					struct mptcp_addr_info *addr,
-					u8 bkup)
+int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
+				 struct mptcp_addr_info *addr,
+				 struct mptcp_addr_info *rem,
+				 u8 bkup)
 {
 	struct mptcp_subflow_context *subflow;
 
@@ -728,13 +729,19 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct sock *sk = (struct sock *)msk;
-		struct mptcp_addr_info local;
+		struct mptcp_addr_info local, remote;
 		bool slow;
 
 		local_address((struct sock_common *)ssk, &local);
 		if (!mptcp_addresses_equal(&local, addr, addr->port))
 			continue;
 
+		if (rem && rem->family != AF_UNSPEC) {
+			remote_address((struct sock_common *)ssk, &remote);
+			if (!mptcp_addresses_equal(&remote, rem, rem->port))
+				continue;
+		}
+
 		slow = lock_sock_fast(ssk);
 		if (subflow->backup != bkup)
 			msk->last_snd = NULL;
@@ -1839,7 +1846,7 @@ static int mptcp_nl_set_flags(struct net *net,
 
 		lock_sock(sk);
 		if (changed & MPTCP_PM_ADDR_FLAG_BACKUP)
-			ret = mptcp_pm_nl_mp_prio_send_ack(msk, addr, bkup);
+			ret = mptcp_pm_nl_mp_prio_send_ack(msk, addr, NULL, bkup);
 		if (changed & MPTCP_PM_ADDR_FLAG_FULLMESH)
 			mptcp_pm_nl_fullmesh(msk, addr);
 		release_sock(sk);
@@ -1855,6 +1862,9 @@ static int mptcp_nl_set_flags(struct net *net,
 static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, }, *entry;
+	struct mptcp_pm_addr_entry remote = { .addr = { .family = AF_UNSPEC }, };
+	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
+	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
@@ -1867,6 +1877,12 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		return ret;
 
+	if (attr_rem) {
+		ret = mptcp_pm_parse_entry(attr_rem, info, false, &remote);
+		if (ret < 0)
+			return ret;
+	}
+
 	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
 	if (addr.addr.family == AF_UNSPEC) {
@@ -1875,6 +1891,10 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
 			return -EOPNOTSUPP;
 	}
 
+	if (token)
+		return mptcp_userspace_pm_set_flags(sock_net(skb->sk),
+						    token, &addr, &remote, bkup);
+
 	spin_lock_bh(&pernet->lock);
 	entry = __lookup_addr(pernet, &addr.addr, lookup_by_id);
 	if (!entry) {
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 26212bebc5ed..51e2f066d54f 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -420,3 +420,33 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 	sock_put((struct sock *)msk);
 	return err;
 }
+
+int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
+				 struct mptcp_pm_addr_entry *loc,
+				 struct mptcp_pm_addr_entry *rem, u8 bkup)
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
+	if (loc->addr.family == AF_UNSPEC ||
+	    rem->addr.family == AF_UNSPEC)
+		goto set_flags_err;
+
+	lock_sock((struct sock *)msk);
+	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc->addr, &rem->addr, bkup);
+	release_sock((struct sock *)msk);
+
+set_flags_err:
+	sock_put((struct sock *)msk);
+	return ret;
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 033c995772dc..480c5320b86e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -772,6 +772,10 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);
 void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
 void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq);
+int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
+				 struct mptcp_addr_info *addr,
+				 struct mptcp_addr_info *rem,
+				 u8 bkup);
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 			      const struct mptcp_pm_addr_entry *entry);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
@@ -788,7 +792,9 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 						   unsigned int id,
 						   u8 *flags, int *ifindex);
-
+int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
+				 struct mptcp_pm_addr_entry *loc,
+				 struct mptcp_pm_addr_entry *rem, u8 bkup);
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
-- 
2.31.1

