Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EA2652
	for <mptcp@lists.linux.dev>; Sat,  9 Apr 2022 01:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649468318; x=1681004318;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=cU4mDnfUAvkiTsCreg+MNcMQDY9hjXXA42yZUnVxXGw=;
  b=ifHelseKt+NZ2DCE5pXbZoQVoyAWrndLuBw9ENNGGx+g3pyLwIeN+YkL
   JD7IfgJh+JylMlVlOB3hVqWxLJttFnrJwoSyWOv67WkP8YH24he932nON
   P2GoLmPJNe6OHyiOxYU6O1e2Gde115dIXxsa6EH2ssNquWVCkKYUTeHi+
   DnxmncM5WT7vj9fnzWf2lP/Ajaa47xNGS2BW5/KDQYIKFtcS1jHz+wUpo
   uzsItS8EzuEvXF5RizY5CeXAvNk58NyqxXiUhuxSbIEXIxjwcM5c9u4h0
   fPzU4vdBBDAKLtrT/W67MzVZqDYSQZ+BS+0OBvOClM4RvrQFaPjCeehv4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="261921145"
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="261921145"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 18:38:30 -0700
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="698436074"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 18:38:29 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v9 03/14] mptcp: read attributes of addr entries managed by userspace PMs
Date: Fri,  8 Apr 2022 21:38:14 -0400
Message-Id: <20220409013825.1877395-4-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220409013825.1877395-1-kishen.maloor@intel.com>
References: <20220409013825.1877395-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change introduces a parallel path in the kernel for retrieving
the local id, flags, if_index for an addr entry in the context of
an MPTCP connection that's being managed by a userspace PM. The
userspace and in-kernel PM modes deviate in their procedures for
obtaining this information.

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
v7:
-Move userspace PM specific handling into mptcp_userspace_pm_get_local_id()
and mptcp_userspace_pm_get_flags_and_ifindex_by_id().
---
 net/mptcp/pm_netlink.c   | 13 +++++++++++-
 net/mptcp/pm_userspace.c | 43 ++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h     |  7 ++++++-
 net/mptcp/subflow.c      |  2 +-
 4 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 92d47e8e8983..ceb1c310d0c6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1041,6 +1041,9 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
 		return 0;
 
+	if (mptcp_pm_is_userspace(msk))
+		return mptcp_userspace_pm_get_local_id(msk, &skc_local);
+
 	pernet = pm_nl_get_pernet_from_msk(msk);
 
 	rcu_read_lock();
@@ -1305,15 +1308,23 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
-int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
+int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
 					 u8 *flags, int *ifindex)
 {
 	struct mptcp_pm_addr_entry *entry;
+	struct sock *sk = (struct sock *)msk;
+	struct net *net = sock_net(sk);
 
 	*flags = 0;
 	*ifindex = 0;
 
 	if (id) {
+		if (mptcp_pm_is_userspace(msk))
+			return mptcp_userspace_pm_get_flags_and_ifindex_by_id(msk,
+									      id,
+									      flags,
+									      ifindex);
+
 		rcu_read_lock();
 		entry = __lookup_addr_by_id(pm_nl_get_pernet(net), id);
 		if (entry) {
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index c50f8900ffba..910116b0f5b9 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -76,3 +76,46 @@ int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	spin_unlock_bh(&msk->pm.lock);
 	return ret;
 }
+
+int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
+						   unsigned int id,
+						   u8 *flags, int *ifindex)
+{
+	struct mptcp_pm_addr_entry *entry, *match = NULL;
+
+	*flags = 0;
+	*ifindex = 0;
+
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (id == entry->addr.id) {
+			match = entry;
+			break;
+		}
+	}
+	spin_unlock_bh(&msk->pm.lock);
+	if (match) {
+		*flags = match->flags;
+		*ifindex = match->ifindex;
+	}
+
+	return 0;
+}
+
+int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
+				    struct mptcp_addr_info *skc)
+{
+	struct mptcp_pm_addr_entry new_entry;
+	__be16 msk_sport =  ((struct inet_sock *)
+			     inet_sk((struct sock *)msk))->inet_sport;
+
+	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
+	new_entry.addr = *skc;
+	new_entry.addr.id = 0;
+	new_entry.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
+
+	if (new_entry.addr.port == msk_sport)
+		new_entry.addr.port = 0;
+
+	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry);
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 40dabf9462a8..a6ee811e5d02 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -775,8 +775,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
-int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
+int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
+					 unsigned int id,
 					 u8 *flags, int *ifindex);
+int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
+						   unsigned int id,
+						   u8 *flags, int *ifindex);
 
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
@@ -854,6 +858,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
+int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a0e7af33fb26..6d59336a8e1e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1468,7 +1468,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	if (local_id)
 		subflow_set_local_id(subflow, local_id);
 
-	mptcp_pm_get_flags_and_ifindex_by_id(sock_net(sk), local_id,
+	mptcp_pm_get_flags_and_ifindex_by_id(msk, local_id,
 					     &flags, &ifindex);
 	subflow->remote_key = msk->remote_key;
 	subflow->local_key = msk->local_key;
-- 
2.31.1

