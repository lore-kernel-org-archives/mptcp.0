Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881742CA3
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 22:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642025771; x=1673561771;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=0yonfpVIz44Immw5RoBY96P22Q6fLpYTWAMiV6tCawQ=;
  b=H6BGgR8+lP5LQm2jR7IoRxTHBQEdDxfUOdmAtAevn4G8kUJ+tofX/bhU
   yOkNje1Zj7fAMT3wjEoSbbwBL48sjcpRU11wid5KDEXTqhST0teB9jsxk
   k568Xq2tVKHApbMe0g3oO11qAlZxmrvlnPfuSvnenOtdKC2MVj08ibDcZ
   DZOC7w87i906tc5Nh68Re/GY7d4n8oyMOfbRT/sLqtH7T0xTJJ65o+RkX
   HBbh7gpH7NyGoWykAjDzYMROBCZGNzm3vJFKOrgGFDMdDS9bVZvh6dokr
   xkUxBxsTk1ADwQMqtvkXioz9sF7KXmsSAFcNp6JNunhFJduXLfYuqNpKj
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="307213932"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="307213932"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 14:16:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="490907342"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 14:16:07 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 05/21] mptcp: netlink: store per namespace list of refcounted listen socks
Date: Wed, 12 Jan 2022 17:15:07 -0500
Message-Id: <20220112221523.1829397-6-kishen.maloor@intel.com>
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

The kernel maintains listening sockets bound to announced addresses
via the ADD_ADDR option to be able to receive MP_JOIN requests. Path
managers may choose to advertise the same address over multiple
MPTCP connections. So this change provides a simple framework to
manage a list of all distinct listning sockets created in a
namespace by encapsulating it in a structure that is ref counted
and can be shared across multiple connections. The sockets (and
their enclosing structure) are released when there are no more
references.

v2: fixed formatting

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 net/mptcp/pm_netlink.c | 76 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index fc07ab9a53ba..4ad43310d50d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -22,6 +22,14 @@ static struct genl_family mptcp_genl_family;
 
 static int pm_nl_pernet_id;
 
+struct mptcp_local_lsk {
+	struct list_head	list;
+	struct mptcp_addr_info	addr;
+	struct socket		*lsk;
+	struct rcu_head		rcu;
+	refcount_t		refcount;
+};
+
 struct mptcp_pm_addr_entry {
 	struct list_head	list;
 	struct mptcp_addr_info	addr;
@@ -41,7 +49,10 @@ struct mptcp_pm_add_entry {
 struct pm_nl_pernet {
 	/* protects pernet updates */
 	spinlock_t		lock;
+	/* protects access to pernet lsk list */
+	spinlock_t		lsk_list_lock;
 	struct list_head	local_addr_list;
+	struct list_head	lsk_list;
 	unsigned int		addrs;
 	unsigned int		stale_loss_cnt;
 	unsigned int		add_addr_signal_max;
@@ -83,6 +94,69 @@ static bool addresses_equal(const struct mptcp_addr_info *a,
 	return a->port == b->port;
 }
 
+static struct mptcp_local_lsk *lsk_list_find(struct pm_nl_pernet *pernet,
+					     struct mptcp_addr_info *addr)
+{
+	struct mptcp_local_lsk *lsk_ref = NULL;
+	struct mptcp_local_lsk *i;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(i, &pernet->lsk_list, list) {
+		if (addresses_equal(&i->addr, addr, true)) {
+			if (refcount_inc_not_zero(&i->refcount)) {
+				lsk_ref = i;
+				break;
+			}
+		}
+	}
+
+	rcu_read_unlock();
+
+	return lsk_ref;
+}
+
+static void lsk_list_add_ref(struct mptcp_local_lsk *lsk_ref)
+{
+	refcount_inc(&lsk_ref->refcount);
+}
+
+static struct mptcp_local_lsk *lsk_list_add(struct pm_nl_pernet *pernet,
+					    struct mptcp_addr_info *addr,
+					    struct socket *lsk)
+{
+	struct mptcp_local_lsk *lsk_ref;
+
+	lsk_ref = kmalloc(sizeof(*lsk_ref), GFP_ATOMIC);
+
+	if (!lsk_ref)
+		return NULL;
+
+	lsk_ref->lsk = lsk;
+	memcpy(&lsk_ref->addr, addr, sizeof(struct mptcp_addr_info));
+	refcount_set(&lsk_ref->refcount, 1);
+
+	spin_lock_bh(&pernet->lsk_list_lock);
+	list_add_rcu(&lsk_ref->list, &pernet->lsk_list);
+	spin_unlock_bh(&pernet->lsk_list_lock);
+
+	return lsk_ref;
+}
+
+static void lsk_list_release(struct pm_nl_pernet *pernet,
+			     struct mptcp_local_lsk *lsk_ref)
+{
+	if (lsk_ref && refcount_dec_and_test(&lsk_ref->refcount)) {
+		sock_release(lsk_ref->lsk);
+
+		spin_lock_bh(&pernet->lsk_list_lock);
+		list_del_rcu(&lsk_ref->list);
+		spin_unlock_bh(&pernet->lsk_list_lock);
+
+		kfree_rcu(lsk_ref, rcu);
+	}
+}
+
 static bool address_zero(const struct mptcp_addr_info *addr)
 {
 	struct mptcp_addr_info zero;
@@ -2098,12 +2172,14 @@ static int __net_init pm_nl_init_net(struct net *net)
 	struct pm_nl_pernet *pernet = net_generic(net, pm_nl_pernet_id);
 
 	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
+	INIT_LIST_HEAD_RCU(&pernet->lsk_list);
 
 	/* Cit. 2 subflows ought to be enough for anybody. */
 	pernet->subflows_max = 2;
 	pernet->next_id = 1;
 	pernet->stale_loss_cnt = 4;
 	spin_lock_init(&pernet->lock);
+	spin_lock_init(&pernet->lsk_list_lock);
 
 	/* No need to initialize other pernet fields, the struct is zeroed at
 	 * allocation time.
-- 
2.31.1

