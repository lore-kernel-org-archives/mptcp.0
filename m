Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D38420E7
	for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 02:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648520085; x=1680056085;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=0dVjhJcyMvuA6cfy3Yli/JxihGksjSyQHiTGQ9QokOU=;
  b=aXbFqiwkDyfrJbTT7Rx+txs7IWRSR/paETDm4OB2Ogdjes3LP62RRQti
   pRdVr/ordKWsPZpVHxNFQCO87HUA+M2vba5RC2KB347mHl4yVhADZOZ+Y
   FIlVD0S+CZpIczCK/VrXt+VkzMcUWsU4b75lppLHSjZjMorEkyUMlDN86
   +EFKZp6Am+WKz4oDT/gR6JAgYcVRuuvhtIrcSfkx7ZiPwQTiW68o0s3cF
   85h0L1sfd/qPO+Az840vmJouCo/Q3v4RtPLbiXcXHCdleWobgwBVHREWt
   9oTEa9j/Rv6B2fqs5Dn1WyGCtm3O38YrtLZg5Y/MwPMyxhk2mXrQ73s0i
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="284037578"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="284037578"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 19:14:42 -0700
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="564202883"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 19:14:41 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v6 03/14] mptcp: read attributes of addr entries managed by userspace PMs
Date: Mon, 28 Mar 2022 22:14:26 -0400
Message-Id: <20220329021437.1196552-4-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220329021437.1196552-1-kishen.maloor@intel.com>
References: <20220329021437.1196552-1-kishen.maloor@intel.com>
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
 net/mptcp/pm_netlink.c | 95 ++++++++++++++++++++++++++++--------------
 net/mptcp/protocol.h   |  3 +-
 net/mptcp/subflow.c    |  2 +-
 3 files changed, 67 insertions(+), 33 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 836f6df9f744..a258593f2cb1 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1036,31 +1036,47 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 
 	pernet = net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &skc_local, entry->addr.port)) {
-			ret = entry->addr.id;
-			break;
+	if (mptcp_pm_is_kernel(msk)) {
+		rcu_read_lock();
+		list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
+			if (mptcp_addresses_equal(&entry->addr, &skc_local, entry->addr.port)) {
+				ret = entry->addr.id;
+				break;
+			}
 		}
+		rcu_read_unlock();
+		if (ret >= 0)
+			return ret;
+
+		/* address not found, add to local list */
+		entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
+		if (!entry)
+			return -ENOMEM;
+
+		entry->addr = skc_local;
+		entry->addr.id = 0;
+		entry->addr.port = 0;
+		entry->ifindex = 0;
+		entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
+		entry->lsk = NULL;
+		ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
+		if (ret < 0)
+			kfree(entry);
+	} else if (mptcp_pm_is_userspace(msk)) {
+		struct mptcp_pm_addr_entry new_entry;
+		__be16 msk_sport =  ((struct inet_sock *)
+				     inet_sk((struct sock *)msk))->inet_sport;
+
+		memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
+		new_entry.addr = skc_local;
+		new_entry.addr.id = 0;
+		new_entry.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
+
+		if (new_entry.addr.port == msk_sport)
+			new_entry.addr.port = 0;
+
+		ret = mptcp_userspace_pm_append_new_local_addr(msk, &new_entry);
 	}
-	rcu_read_unlock();
-	if (ret >= 0)
-		return ret;
-
-	/* address not found, add to local list */
-	entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
-	if (!entry)
-		return -ENOMEM;
-
-	entry->addr = skc_local;
-	entry->addr.id = 0;
-	entry->addr.port = 0;
-	entry->ifindex = 0;
-	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
-	entry->lsk = NULL;
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
-	if (ret < 0)
-		kfree(entry);
 
 	return ret;
 }
@@ -1298,22 +1314,39 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
-int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
+int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
 					 u8 *flags, int *ifindex)
 {
-	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_pm_addr_entry *entry, *match = NULL;
+	struct sock *sk = (struct sock *)msk;
+	struct net *net = sock_net(sk);
 
 	*flags = 0;
 	*ifindex = 0;
 
 	if (id) {
-		rcu_read_lock();
-		entry = __lookup_addr_by_id(net_generic(net, pm_nl_pernet_id), id);
-		if (entry) {
-			*flags = entry->flags;
-			*ifindex = entry->ifindex;
+		if (mptcp_pm_is_kernel(msk)) {
+			rcu_read_lock();
+			entry = __lookup_addr_by_id(net_generic(net, pm_nl_pernet_id), id);
+			if (entry) {
+				*flags = entry->flags;
+				*ifindex = entry->ifindex;
+			}
+			rcu_read_unlock();
+		} else {
+			spin_lock_bh(&msk->pm.lock);
+			list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+				if (id == entry->addr.id) {
+					match = entry;
+					break;
+				}
+			}
+			spin_unlock_bh(&msk->pm.lock);
+			if (match) {
+				*flags = match->flags;
+				*ifindex = match->ifindex;
+			}
 		}
-		rcu_read_unlock();
 	}
 
 	return 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 40dabf9462a8..4ae3253d7f9a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -775,7 +775,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
-int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
+int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
+					 unsigned int id,
 					 u8 *flags, int *ifindex);
 
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
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

