Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C132CAA
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 00:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643330321; x=1674866321;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Gr13AAUhe5eTCkooVg6zrYFWSbdk1t9Q+M9BsCv7uS4=;
  b=Cbe61ZTn8PH2HcJrfDvvcslHnfzyaUtQGygQXOxLU4UGP98dQIAUTEJY
   aTUnQ/l3IZY0zsubUfEgPW2L0UPrQED4dNl2GH1la8NSCPSIE01yQumQx
   6n+Lu8ov+Xw1cWJyj+gyiBTYxafEy4LeUT1LIuvozo03vzos5kxi2eS+J
   oLDKL3obOC2AAnatvanFUzCiOLbkeRDFEIqtF359Yx/Xn83sE+bExqvXl
   0jI7QhjcJ6jbq0SnaVAFkRshknB3Yi+4ERCL4e2w6re7mCLg6CqDBieG7
   2gOdavswTXHrJIKJ1yY6EYBQNrDVd7L+v8JnT3yzDEEkN4YIZO7wjU3RV
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="245846917"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="245846917"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:25 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="564001002"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:20 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v3 5/8] mptcp: netlink: store per namespace list of refcounted listen socks
Date: Thu, 27 Jan 2022 19:38:09 -0500
Message-Id: <20220128003812.2732609-6-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220128003812.2732609-1-kishen.maloor@intel.com>
References: <20220128003812.2732609-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel can create listening sockets bound to announced addresses
via the ADD_ADDR option for receiving MP_JOIN requests. Path
managers may further choose to advertise the same addr+port over multiple
MPTCP connections. So this change provides a simple framework to
manage a list of all distinct listning sockets created in the kernel
over a namespace by encapsulating the socket in a structure that is
ref counted and can be shared across multiple connections. The sockets
are released when there are no more references.

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
v2: fixed formatting
---
 net/mptcp/pm_netlink.c | 76 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f90e77c3775d..aac9438dbf6c 100644
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
@@ -2137,12 +2211,14 @@ static int __net_init pm_nl_init_net(struct net *net)
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

