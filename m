Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14982CA2
	for <mptcp@lists.linux.dev>; Fri,  8 Apr 2022 19:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649447173; x=1680983173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A6/HcZMYr7wj1VttDcE9T6xhb2rGLh7zrqQJJHG02VE=;
  b=Syr2jPTTf2nT3C+ArD7ThRqjT6rBgfg6zer28RPB8WjtbZfgtTw2zOE4
   7Hkt84knXnlcFO6ZfK7K9+UR4h4BI+8tmY5JifOipb+SVPPimh0vFsKAT
   HpKxGY9v8QmZKkD/IPIj35OARul5RdxxsTE80taoc6CQX/ceS2TcMRJYK
   xjIrJuXu5AS4cxvUT7WoPqrd8iK6au3wrZ2lQhB2cDW6j5PRomMtMVLwk
   y3sh1CJM3P2AF+5B2DwKxqFZXHj5I6WOgbT52pBUncs49tmIObklAClhP
   2mr3OqPniMv+hQvZlNU0Si4jGeXBo9Ei0gFbJCl8cw9Iyz5/GWIsI2bkz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="322365301"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="322365301"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:46:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="659602158"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.134.75.99])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:46:09 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 4/8] mptcp: add pm_nl_pernet helpers
Date: Fri,  8 Apr 2022 12:45:57 -0700
Message-Id: <20220408194601.305969-5-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408194601.305969-1-mathew.j.martineau@linux.intel.com>
References: <20220408194601.305969-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

This patch adds two pm_nl_pernet related helpers, named pm_nl_get_pernet()
and pm_nl_get_pernet_from_msk() to get pm_nl_pernet from 'net' or 'msk'.
Use these helpers instead of using net_generic() directly.

Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e3dcc5501579..c20261b612e9 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -55,6 +55,17 @@ struct pm_nl_pernet {
 #define MPTCP_PM_ADDR_MAX	8
 #define ADD_ADDR_RETRANS_MAX	3
 
+static struct pm_nl_pernet *pm_nl_get_pernet(const struct net *net)
+{
+	return net_generic(net, pm_nl_pernet_id);
+}
+
+static struct pm_nl_pernet *
+pm_nl_get_pernet_from_msk(const struct mptcp_sock *msk)
+{
+	return pm_nl_get_pernet(sock_net((struct sock *)msk));
+}
+
 static bool addresses_equal(const struct mptcp_addr_info *a,
 			    const struct mptcp_addr_info *b, bool use_port)
 {
@@ -206,43 +217,39 @@ select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk)
 
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk)
 {
-	const struct pm_nl_pernet *pernet;
+	const struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 
-	pernet = net_generic(sock_net((const struct sock *)msk), pm_nl_pernet_id);
 	return READ_ONCE(pernet->add_addr_signal_max);
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_add_addr_signal_max);
 
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk)
 {
-	struct pm_nl_pernet *pernet;
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 
-	pernet = net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
 	return READ_ONCE(pernet->add_addr_accept_max);
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_add_addr_accept_max);
 
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk)
 {
-	struct pm_nl_pernet *pernet;
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 
-	pernet = net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
 	return READ_ONCE(pernet->subflows_max);
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_subflows_max);
 
 unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk)
 {
-	struct pm_nl_pernet *pernet;
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 
-	pernet = net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
 	return READ_ONCE(pernet->local_addr_max);
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_local_addr_max);
 
 bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 {
-	struct pm_nl_pernet *pernet = net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 
 	if (msk->pm.subflows == mptcp_pm_get_subflows_max(msk) ||
 	    (find_next_and_bit(pernet->id_bitmap, msk->pm.id_avail_bitmap,
@@ -508,7 +515,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
 
-	pernet = net_generic(sock_net(sk), pm_nl_pernet_id);
+	pernet = pm_nl_get_pernet(sock_net(sk));
 
 	add_addr_signal_max = mptcp_pm_get_add_addr_signal_max(msk);
 	local_addr_max = mptcp_pm_get_local_addr_max(msk);
@@ -604,7 +611,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	unsigned int subflows_max;
 	int i = 0;
 
-	pernet = net_generic(sock_net(sk), pm_nl_pernet_id);
+	pernet = pm_nl_get_pernet_from_msk(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
 	rcu_read_lock();
@@ -1023,7 +1030,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	if (addresses_equal(&msk_local, &skc_local, false))
 		return 0;
 
-	pernet = net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
+	pernet = pm_nl_get_pernet_from_msk(msk);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
@@ -1214,7 +1221,7 @@ static int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
 
 static struct pm_nl_pernet *genl_info_pm_nl(struct genl_info *info)
 {
-	return net_generic(genl_info_net(info), pm_nl_pernet_id);
+	return pm_nl_get_pernet(genl_info_net(info));
 }
 
 static int mptcp_nl_add_subflow_or_signal_addr(struct net *net)
@@ -1308,7 +1315,7 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
 
 	if (id) {
 		rcu_read_lock();
-		entry = __lookup_addr_by_id(net_generic(net, pm_nl_pernet_id), id);
+		entry = __lookup_addr_by_id(pm_nl_get_pernet(net), id);
 		if (entry) {
 			*flags = entry->flags;
 			*ifindex = entry->ifindex;
@@ -1655,7 +1662,7 @@ static int mptcp_nl_cmd_dump_addrs(struct sk_buff *msg,
 	void *hdr;
 	int i;
 
-	pernet = net_generic(net, pm_nl_pernet_id);
+	pernet = pm_nl_get_pernet(net);
 
 	spin_lock_bh(&pernet->lock);
 	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
@@ -2167,7 +2174,7 @@ static struct genl_family mptcp_genl_family __ro_after_init = {
 
 static int __net_init pm_nl_init_net(struct net *net)
 {
-	struct pm_nl_pernet *pernet = net_generic(net, pm_nl_pernet_id);
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet(net);
 
 	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
 
@@ -2189,7 +2196,7 @@ static void __net_exit pm_nl_exit_net(struct list_head *net_list)
 	struct net *net;
 
 	list_for_each_entry(net, net_list, exit_list) {
-		struct pm_nl_pernet *pernet = net_generic(net, pm_nl_pernet_id);
+		struct pm_nl_pernet *pernet = pm_nl_get_pernet(net);
 
 		/* net is removed from namespace list, can't race with
 		 * other modifiers, also netns core already waited for a
-- 
2.35.1

