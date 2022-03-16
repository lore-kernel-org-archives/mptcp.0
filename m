Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C353D75
	for <mptcp@lists.linux.dev>; Wed, 16 Mar 2022 23:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647472606; x=1679008606;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ajmyumXsmta+AA8sihePEx0hoFIXrvP69Vv8wpOkbHE=;
  b=QNKlOZaqUfJj22fDsGvnSW0IE3IoFHQZgx6aY13kOyrf7GmmyMJ4Lv9n
   dkfsrl6oFWH4Tcu45MvkF6VB3oroIfQJvT6IAAk1WrnhiB/gs2tQZsBtB
   nm0GzDAdjgLsEtH83vts5lwBvFfVKJSZZrZtUNCR/RdXYfP3UVzHQeXjb
   5ScJiStR5zguc1o80V5vVSd2b4M3FZmh6U5XR/qtK9U6WUpnq9GMGQXXN
   guzdyRr0RIchPuggPgiOW7WrRXEZVggdSiAHn3RXu7oQbcajst7C+2jR4
   lvi/q4GIudS7zZLjUaTAzo8ISMv/uqAvf5kGX/GKJtSPQfrMSp/U42t68
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="317453507"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="317453507"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 16:16:43 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="613813301"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 16:16:42 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v5 03/14] mptcp: read attributes of addr entries managed by userspace PMs
Date: Wed, 16 Mar 2022 19:16:25 -0400
Message-Id: <20220316231636.645625-4-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220316231636.645625-1-kishen.maloor@intel.com>
References: <20220316231636.645625-1-kishen.maloor@intel.com>
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
index d8825bf580b7..b597e84affd5 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1106,31 +1106,47 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 
 	pernet = net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (addresses_equal(&entry->addr, &skc_local, entry->addr.port)) {
-			ret = entry->addr.id;
-			break;
+	if (mptcp_pm_is_kernel(msk)) {
+		rcu_read_lock();
+		list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
+			if (addresses_equal(&entry->addr, &skc_local, entry->addr.port)) {
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
@@ -1368,22 +1384,39 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
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
+			mptcp_data_lock(sk);
+			list_for_each_entry(entry, &msk->local_addr_list, list) {
+				if (id == entry->addr.id) {
+					match = entry;
+					break;
+				}
+			}
+			mptcp_data_unlock(sk);
+			if (match) {
+				*flags = match->flags;
+				*ifindex = match->ifindex;
+			}
 		}
-		rcu_read_unlock();
 	}
 
 	return 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2d18d2e7ee0e..870627304462 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -770,7 +770,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
-int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
+int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
+					 unsigned int id,
 					 u8 *flags, int *ifindex);
 
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 59657b7e4788..ff12893e03ab 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1455,7 +1455,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	if (local_id)
 		subflow_set_local_id(subflow, local_id);
 
-	mptcp_pm_get_flags_and_ifindex_by_id(sock_net(sk), local_id,
+	mptcp_pm_get_flags_and_ifindex_by_id(msk, local_id,
 					     &flags, &ifindex);
 	subflow->remote_key = msk->remote_key;
 	subflow->local_key = msk->local_key;
-- 
2.31.1

