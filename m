Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EAB2CA5
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 22:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642025772; x=1673561772;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=r4GMc6LKC2K42+FKNenk3il7PVutlelI2qbyAddfPCU=;
  b=UdRJpfgntvbmElw4l24uq3yC4lWAJq5WTA1taUipJzs1rTey9s8GHsbH
   1QvDAopmYCggY7sQ0tPbl3hfHZtv3Q+I+aeqpFafamd8plht3kd/3agLc
   cF1g5CLChufLGrndvATzUZQZrXTHCpDNfVQDCqEfImV5xrZgJ+VYSEchc
   Z9Pw2QmDrCwR8CorP6m8njEWCH7ZLvH+lNRUkJA8o5R+vu9KIwme1EykP
   x84PJaMeGD8ZBm+4tKWipHiDLKKhppipat7LzkIpRfhMiZvzz4iRo5X7B
   grsaFYHQrvk71FGdlOXYSMs8JrtSEF+CE9C9kmNm3p5aBmw++9Scg9KLx
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="307213933"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="307213933"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 14:16:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="490907345"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 14:16:07 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 06/21] mptcp: netlink: store lsk ref in mptcp_pm_addr_entry
Date: Wed, 12 Jan 2022 17:15:08 -0500
Message-Id: <20220112221523.1829397-7-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220112221523.1829397-1-kishen.maloor@intel.com>
References: <20220112221523.1829397-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change updates struct mptcp_pm_addr_entry to store a
listening socket (lsk) reference, i.e. a pointer to a reference
counted structure containing the lsk (struct socket *) instead
of the lsk itself. Code blocks that directly operated on
the lsk in struct mptcp_pm_addr_entry have been updated to work
with the lsk ref instead, utilizing the new helper functions that
operate on lsk refs.

v2: fixed formatting

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 net/mptcp/pm_netlink.c | 62 ++++++++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 21 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4ad43310d50d..4c1895dbc2a5 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -35,7 +35,7 @@ struct mptcp_pm_addr_entry {
 	struct mptcp_addr_info	addr;
 	u8			flags;
 	int			ifindex;
-	struct socket		*lsk;
+	struct mptcp_local_lsk	*lsk_ref;
 };
 
 struct mptcp_pm_add_entry {
@@ -983,7 +983,8 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 }
 
 static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
-					    struct mptcp_pm_addr_entry *entry)
+					    struct mptcp_pm_addr_entry *entry,
+					    struct socket **lsk)
 {
 	struct sockaddr_storage addr;
 	struct mptcp_sock *msk;
@@ -992,11 +993,11 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	int err;
 
 	err = sock_create_kern(sock_net(sk), entry->addr.family,
-			       SOCK_STREAM, IPPROTO_MPTCP, &entry->lsk);
+			       SOCK_STREAM, IPPROTO_MPTCP, lsk);
 	if (err)
 		return err;
 
-	msk = mptcp_sk(entry->lsk->sk);
+	msk = mptcp_sk((*lsk)->sk);
 	if (!msk) {
 		err = -EINVAL;
 		goto out;
@@ -1025,7 +1026,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	return 0;
 
 out:
-	sock_release(entry->lsk);
+	sock_release(*lsk);
+	*lsk = NULL;
 	return err;
 }
 
@@ -1074,7 +1076,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	entry->addr.port = 0;
 	entry->ifindex = 0;
 	entry->flags = 0;
-	entry->lsk = NULL;
+	entry->lsk_ref = NULL;
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
 	if (ret < 0)
 		kfree(entry);
@@ -1270,6 +1272,7 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry addr, *entry;
+	struct socket *lsk;
 	int ret;
 
 	ret = mptcp_pm_parse_addr(attr, info, true, &addr);
@@ -1284,18 +1287,34 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 
 	*entry = addr;
 	if (entry->addr.port) {
-		ret = mptcp_pm_nl_create_listen_socket(skb->sk, entry);
-		if (ret) {
-			GENL_SET_ERR_MSG(info, "create listen socket error");
-			kfree(entry);
-			return ret;
+		entry->lsk_ref = lsk_list_find(pernet, &entry->addr);
+
+		if (!entry->lsk_ref) {
+			ret = mptcp_pm_nl_create_listen_socket(skb->sk, entry, &lsk);
+
+			if (ret) {
+				GENL_SET_ERR_MSG(info, "create listen socket error");
+				kfree(entry);
+				return ret;
+			}
+
+			entry->lsk_ref = lsk_list_add(pernet, &entry->addr, lsk);
+
+			if (!entry->lsk_ref) {
+				GENL_SET_ERR_MSG(info, "can't allocate lsk ref");
+				sock_release(lsk);
+				kfree(entry);
+				return -ENOMEM;
+			}
 		}
 	}
+
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
+
 	if (ret < 0) {
 		GENL_SET_ERR_MSG(info, "too many addresses or duplicate one");
-		if (entry->lsk)
-			sock_release(entry->lsk);
+		if (entry->lsk_ref)
+			lsk_list_release(pernet, entry->lsk_ref);
 		kfree(entry);
 		return ret;
 	}
@@ -1398,10 +1417,11 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 }
 
 /* caller must ensure the RCU grace period is already elapsed */
-static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
+static void __mptcp_pm_release_addr_entry(struct pm_nl_pernet *pernet,
+					  struct mptcp_pm_addr_entry *entry)
 {
-	if (entry->lsk)
-		sock_release(entry->lsk);
+	if (entry->lsk_ref)
+		lsk_list_release(pernet, entry->lsk_ref);
 	kfree(entry);
 }
 
@@ -1483,7 +1503,7 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
 
 	mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), &entry->addr);
 	synchronize_rcu();
-	__mptcp_pm_release_addr_entry(entry);
+	__mptcp_pm_release_addr_entry(pernet, entry);
 
 	return ret;
 }
@@ -1539,7 +1559,7 @@ static void mptcp_nl_remove_addrs_list(struct net *net,
 }
 
 /* caller must ensure the RCU grace period is already elapsed */
-static void __flush_addrs(struct list_head *list)
+static void __flush_addrs(struct pm_nl_pernet *pernet, struct list_head *list)
 {
 	while (!list_empty(list)) {
 		struct mptcp_pm_addr_entry *cur;
@@ -1547,7 +1567,7 @@ static void __flush_addrs(struct list_head *list)
 		cur = list_entry(list->next,
 				 struct mptcp_pm_addr_entry, list);
 		list_del_rcu(&cur->list);
-		__mptcp_pm_release_addr_entry(cur);
+		__mptcp_pm_release_addr_entry(pernet, cur);
 	}
 }
 
@@ -1572,7 +1592,7 @@ static int mptcp_nl_cmd_flush_addrs(struct sk_buff *skb, struct genl_info *info)
 	spin_unlock_bh(&pernet->lock);
 	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
 	synchronize_rcu();
-	__flush_addrs(&free_list);
+	__flush_addrs(pernet, &free_list);
 	return 0;
 }
 
@@ -2199,7 +2219,7 @@ static void __net_exit pm_nl_exit_net(struct list_head *net_list)
 		 * other modifiers, also netns core already waited for a
 		 * RCU grace period.
 		 */
-		__flush_addrs(&pernet->local_addr_list);
+		__flush_addrs(pernet, &pernet->local_addr_list);
 	}
 }
 
-- 
2.31.1

