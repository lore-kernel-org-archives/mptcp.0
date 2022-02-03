Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECA62CA1
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 03:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643858051; x=1675394051;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=nCFbXJvRXu4v7kZJGSu1BKj2zC6DwwvUDEjIpEjsWKw=;
  b=SZVAbfe27DQNYOr03t5m0c37QH/xlE+9EkwGk2SV2FCnZL+l9E0RkmeI
   tjTgbKoQxbPzdk5RnOxkjaxQnaROuupc8UEhSY8pezJU/qGeC/91f4WdN
   goRRMy83wSZEJgWXU0guibtCgG001oL2D5HfCeWbhyhV32LVnuOTDRiek
   kIMsZZ4AAZ+6Yv5gW2Dq5U+AIhpbirev5HiARYlzV3kaxGTC8XXfFfXw4
   i6bVxSMgOe9smOfQlCXCkp3KA5GGtlGeGOwmKppMmHGkh/sQWADc+IdY4
   SrdD94pgxGoivL3/zPmy/hMH5wBexr5G5OCHFX05DxG1pFSOS6ppiMn79
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="235467498"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="235467498"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 19:14:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="631204624"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 19:14:09 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v4 03/13] mptcp: read attributes of addr entries managed by userspace PMs
Date: Wed,  2 Feb 2022 22:13:53 -0500
Message-Id: <20220203031403.2996549-4-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220203031403.2996549-1-kishen.maloor@intel.com>
References: <20220203031403.2996549-1-kishen.maloor@intel.com>
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
 net/mptcp/pm_netlink.c | 97 ++++++++++++++++++++++++++++--------------
 net/mptcp/protocol.h   |  2 +-
 net/mptcp/subflow.c    |  2 +-
 3 files changed, 67 insertions(+), 34 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ac5d152fbb77..7058d55e3a0a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1230,31 +1230,47 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 
 	pernet = net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (addresses_equal(&entry->addr, &skc_local, entry->addr.port)) {
-			ret = entry->addr.id;
-			break;
-		}
-	}
-	rcu_read_unlock();
-	if (ret >= 0)
-		return ret;
-
 	/* address not found, add to local list */
-	entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
-	if (!entry)
-		return -ENOMEM;
-
-	entry->addr = skc_local;
-	entry->addr.id = 0;
-	entry->addr.port = 0;
-	entry->ifindex = 0;
-	entry->flags = 0;
-	entry->lsk_ref = NULL;
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
-	if (ret < 0)
-		kfree(entry);
+	if (mptcp_pm_is_kernel(msk)) {
+		rcu_read_lock();
+		list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
+			if (addresses_equal(&entry->addr, &skc_local, entry->addr.port)) {
+				ret = entry->addr.id;
+				break;
+			}
+		}
+		rcu_read_unlock();
+
+		if (ret >= 0)
+			return ret;
+
+		entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
+		if (!entry)
+			return -ENOMEM;
+
+		entry->addr = skc_local;
+		entry->addr.id = 0;
+		entry->addr.port = 0;
+		entry->ifindex = 0;
+		entry->flags = 0;
+		entry->lsk_ref = NULL;
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
+
+		if (new_entry.addr.port == msk_sport)
+			new_entry.addr.port = 0;
+
+		ret = mptcp_userspace_pm_append_new_local_addr(msk, &new_entry);
+	}
 
 	return ret;
 }
@@ -1488,22 +1504,39 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
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
index 6b7e51a2bd09..b6af57d5ff5b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -771,7 +771,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
 				struct mptcp_addr_info *addr);
-int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
+int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
 					 u8 *flags, int *ifindex);
 
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d3691b95401a..19df5293334f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1416,7 +1416,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 		local_id = err;
 	}
 
-	mptcp_pm_get_flags_and_ifindex_by_id(sock_net(sk), local_id,
+	mptcp_pm_get_flags_and_ifindex_by_id(msk, local_id,
 					     &flags, &ifindex);
 	subflow->remote_key = msk->remote_key;
 	subflow->local_key = msk->local_key;
-- 
2.31.1

