Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437B32C9D
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 07:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643873119; x=1675409119;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=EtJNFBe+tNKy51yk4DnKNVwStlaZ9uX06yyF25qBonE=;
  b=k4UbdTwCsJF9/yhXvKYMExTgH8Vg/UYbFI7KzWW19IbR6tFrvE6rkMMx
   8OhoDvr80WgRGcewvri60zjyc6VF1UPATe8fZ1BuRJ/vP68eiGKO0kMLO
   OstzROlZB6DccKsc8BL/4Y0tWPWWWaUQhhZMf2QR9DciVTgFFdQxUqEXw
   roUG1fbbojA0DaCHymWTcUSUNnxjZelThKwVtmhRM3m3ojD2dTzhy4gpM
   ac77ezGX55/Izk9F/xWkAwzhtFem/3L03/W2W02Lf7hpQDvTsaBpOzFxu
   MElNyQE4YTFZ70zj6bpux0B12K5pR+qIfLNMhb9on5B8/dY+WS2+D/mgI
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="272580775"
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="272580775"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 23:25:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="535118729"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 23:25:14 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v5 6/8] mptcp: netlink: store lsk ref in mptcp_pm_addr_entry
Date: Thu,  3 Feb 2022 02:25:06 -0500
Message-Id: <20220203072508.3072309-7-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220203072508.3072309-1-kishen.maloor@intel.com>
References: <20220203072508.3072309-1-kishen.maloor@intel.com>
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
of the lsk itself. Code blocks that previously operated on
the lsk in struct mptcp_pm_addr_entry have been updated to work
with the lsk ref instead, utilizing new helper functions.

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
v2: fixed formatting
v3: added helper lsk_list_find_or_create(), updated
mptcp_pm_nl_create_listen_socket() to take struct net* as param
v4: call lsk_list_find() after a failed lsk_list_find_or_create()
for a chance to retrieve a recently created lsk by a simultaneous
call
v5: fixed implicit declaration error
---
 net/mptcp/pm_netlink.c | 83 +++++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 21 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3d6251baef26..a4fb9acbba51 100644
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
@@ -66,6 +66,10 @@ struct pm_nl_pernet {
 #define MPTCP_PM_ADDR_MAX	8
 #define ADD_ADDR_RETRANS_MAX	3
 
+static int mptcp_pm_nl_create_listen_socket(struct net *net,
+					    struct mptcp_pm_addr_entry *entry,
+					    struct socket **lsk);
+
 static bool addresses_equal(const struct mptcp_addr_info *a,
 			    const struct mptcp_addr_info *b, bool use_port)
 {
@@ -157,6 +161,33 @@ static void lsk_list_release(struct pm_nl_pernet *pernet,
 	}
 }
 
+static struct mptcp_local_lsk *lsk_list_find_or_create(struct net *net,
+						       struct pm_nl_pernet *pernet,
+						       struct mptcp_pm_addr_entry *entry,
+						       int *createlsk_err)
+{
+	struct mptcp_local_lsk *lsk_ref;
+	struct socket *lsk;
+	int err;
+
+	lsk_ref = lsk_list_find(pernet, &entry->addr);
+
+	if (!lsk_ref) {
+		err = mptcp_pm_nl_create_listen_socket(net, entry, &lsk);
+
+		if (createlsk_err)
+			*createlsk_err = err;
+
+		if (lsk)
+			lsk_ref = lsk_list_add(pernet, &entry->addr, lsk);
+
+		if (lsk && !lsk_ref)
+			sock_release(lsk);
+	}
+
+	return lsk_ref;
+}
+
 static bool address_zero(const struct mptcp_addr_info *addr)
 {
 	struct mptcp_addr_info zero;
@@ -999,8 +1030,9 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 	return ret;
 }
 
-static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
-					    struct mptcp_pm_addr_entry *entry)
+static int mptcp_pm_nl_create_listen_socket(struct net *net,
+					    struct mptcp_pm_addr_entry *entry,
+					    struct socket **lsk)
 {
 	int addrlen = sizeof(struct sockaddr_in);
 	struct sockaddr_storage addr;
@@ -1009,12 +1041,12 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	int backlog = 1024;
 	int err;
 
-	err = sock_create_kern(sock_net(sk), entry->addr.family,
-			       SOCK_STREAM, IPPROTO_MPTCP, &entry->lsk);
+	err = sock_create_kern(net, entry->addr.family,
+			       SOCK_STREAM, IPPROTO_MPTCP, lsk);
 	if (err)
 		return err;
 
-	msk = mptcp_sk(entry->lsk->sk);
+	msk = mptcp_sk((*lsk)->sk);
 	if (!msk) {
 		err = -EINVAL;
 		goto out;
@@ -1046,7 +1078,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	return 0;
 
 out:
-	sock_release(entry->lsk);
+	sock_release(*lsk);
+	*lsk = NULL;
 	return err;
 }
 
@@ -1095,7 +1128,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	entry->addr.port = 0;
 	entry->ifindex = 0;
 	entry->flags = 0;
-	entry->lsk = NULL;
+	entry->lsk_ref = NULL;
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
 	if (ret < 0)
 		kfree(entry);
@@ -1304,18 +1337,25 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 
 	*entry = addr;
 	if (entry->addr.port) {
-		ret = mptcp_pm_nl_create_listen_socket(skb->sk, entry);
-		if (ret) {
-			GENL_SET_ERR_MSG(info, "create listen socket error");
+		entry->lsk_ref = lsk_list_find_or_create(sock_net(skb->sk), pernet, entry, &ret);
+
+		if (!entry->lsk_ref)
+			entry->lsk_ref = lsk_list_find(pernet, &entry->addr);
+
+		if (!entry->lsk_ref) {
+			GENL_SET_ERR_MSG(info, "can't create/allocate lsk");
 			kfree(entry);
+			ret = (ret == 0) ? -ENOMEM : ret;
 			return ret;
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
@@ -1418,10 +1458,11 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
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
 
@@ -1503,7 +1544,7 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
 
 	mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), &entry->addr);
 	synchronize_rcu();
-	__mptcp_pm_release_addr_entry(entry);
+	__mptcp_pm_release_addr_entry(pernet, entry);
 
 	return ret;
 }
@@ -1559,7 +1600,7 @@ static void mptcp_nl_remove_addrs_list(struct net *net,
 }
 
 /* caller must ensure the RCU grace period is already elapsed */
-static void __flush_addrs(struct list_head *list)
+static void __flush_addrs(struct pm_nl_pernet *pernet, struct list_head *list)
 {
 	while (!list_empty(list)) {
 		struct mptcp_pm_addr_entry *cur;
@@ -1567,7 +1608,7 @@ static void __flush_addrs(struct list_head *list)
 		cur = list_entry(list->next,
 				 struct mptcp_pm_addr_entry, list);
 		list_del_rcu(&cur->list);
-		__mptcp_pm_release_addr_entry(cur);
+		__mptcp_pm_release_addr_entry(pernet, cur);
 	}
 }
 
@@ -1592,7 +1633,7 @@ static int mptcp_nl_cmd_flush_addrs(struct sk_buff *skb, struct genl_info *info)
 	spin_unlock_bh(&pernet->lock);
 	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
 	synchronize_rcu();
-	__flush_addrs(&free_list);
+	__flush_addrs(pernet, &free_list);
 	return 0;
 }
 
@@ -2242,7 +2283,7 @@ static void __net_exit pm_nl_exit_net(struct list_head *net_list)
 		 * other modifiers, also netns core already waited for a
 		 * RCU grace period.
 		 */
-		__flush_addrs(&pernet->local_addr_list);
+		__flush_addrs(pernet, &pernet->local_addr_list);
 	}
 }
 
-- 
2.31.1

