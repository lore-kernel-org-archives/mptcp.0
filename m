Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A902CA7
	for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 22:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639693456; x=1671229456;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=u7ln60s7R4d1FomcW5RgcqIW5uF6tc/aywzy3OXklOw=;
  b=ZY3Fga8hMI5J2CCMLzgSB9r/rHpASC4eBo5p9Qzp8XEp28Lj9vbtP2dB
   9GaMAKRL9rrXtJXpKLSMK+RuVCBspVaRgv1md5OGTXW6Mbn562ercVlWD
   ieJ0nv0w6BYFuh22KV2oBt16gxKbTVjqgBVwWab7if5C2ImD5Njl1rM4i
   FAcuOK2gWB1ThXQPvrPQeL96JZLEW/ibwH05XtY6+sXXaknB0jcSApP0R
   iuQOhUVB2IX3bvPfkSQTV3UYrja0wknDZwpq3B6GKs9tgs/z6ZOuu5Zvs
   ps80Yaw3QX5EmCMdPX+4JA0Sk1E1vC/Iu+f6cyRHMfjJ1vQiy8GpxkvwX
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="300393161"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="300393161"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 14:24:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="519461238"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 14:24:10 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 06/21] mptcp: netlink: store lsk ref in mptcp_pm_addr_entry
Date: Thu, 16 Dec 2021 17:22:59 -0500
Message-Id: <20211216222314.1244708-7-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216222314.1244708-1-kishen.maloor@intel.com>
References: <20211216222314.1244708-1-kishen.maloor@intel.com>
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

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 net/mptcp/pm_netlink.c | 62 ++++++++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 21 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0cb03d78e22b..29f6d01ace2d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -35,7 +35,7 @@ struct mptcp_pm_addr_entry {
 	struct mptcp_addr_info	addr;
 	u8			flags;
 	int			ifindex;
-	struct socket		*lsk;
+	struct mptcp_local_lsk  *lsk_ref;
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

