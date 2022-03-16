Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFB93B3A
	for <mptcp@lists.linux.dev>; Wed, 16 Mar 2022 19:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647457700; x=1678993700;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=th85AhYzB5srn1plLxTxsj72lIVhNRGakG7OlUxeCZk=;
  b=E1zDHi6grT6vkg/m0KKr2oL/f36sHksANW7w5gRK1ozLIhqARcxc+ahb
   krO4m6diU/3PvvXdbZODssJ0qJ7aeMqLFnYC1LhDU1XJH/RUuokYiELa9
   /+0LBqz2nBpOD8Zw7s+H+4JTz/vSHJLwW4GyJVLotlsvEDnnztPh9kVPg
   Cf4c2T3W1hc4OD/lK7sv0NAF/IesdlRSEeeOfw/r1DDpas1K/flYn6EHe
   sbt8SwwB2TICV5pZuC2U7/3luKRzMB+PhsArfV/zy92RgiVJ0dNdjxBzi
   fVx6vIi6BLiD8mGB7hGJRNJKxrd0mUt4INxmzMj3x1H/Zm5KkYEd0Ls6I
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="256880337"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="256880337"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 12:08:18 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="557595355"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 12:08:18 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 02/14] mptcp: handle local addrs announced by userspace PMs
Date: Wed, 16 Mar 2022 15:08:01 -0400
Message-Id: <20220316190813.634423-3-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220316190813.634423-1-kishen.maloor@intel.com>
References: <20220316190813.634423-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change adds an internal function to store/retrieve local
addrs announced by userspace PM implementations to/from its kernel
context. The function addresses the requirements of three scenarios:
1) ADD_ADDR announcements (which require that a local id be
provided), 2) retrieving the local id associated with an address,
and also where one may need to be assigned, and 3) reissuance of
ADD_ADDRs when there's a successful match of addr/id.

The list of all stored local addr entries is held under the
MPTCP sock structure. Memory for these entries is allocated from
the sock option buffer, so the list of addrs is bounded by optmem_max.
The list if not released via REMOVE_ADDR signals is ultimately
freed when the sock is destructed.

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 net/mptcp/pm_netlink.c | 75 ++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c   |  2 ++
 net/mptcp/protocol.h   |  2 ++
 3 files changed, 79 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 98e59576415b..c994a2ef3ed3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -390,6 +390,27 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	return true;
 }
 
+void mptcp_free_local_addr_list(struct mptcp_sock *msk)
+{
+	struct mptcp_pm_addr_entry *entry, *tmp;
+	struct sock *sk = (struct sock *)msk;
+	struct pm_nl_pernet *pernet;
+	LIST_HEAD(free_list);
+
+	if (!mptcp_pm_is_userspace(msk))
+		return;
+
+	pernet = net_generic(sock_net(sk), pm_nl_pernet_id);
+
+	mptcp_data_lock(sk);
+	list_splice_init(&msk->local_addr_list, &free_list);
+	mptcp_data_unlock(sk);
+
+	list_for_each_entry_safe(entry, tmp, &free_list, list) {
+		sock_kfree_s(sk, entry, sizeof(*entry));
+	}
+}
+
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_add_entry *entry, *tmp;
@@ -878,6 +899,60 @@ static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
 	kfree(entry);
 }
 
+static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
+						    struct mptcp_pm_addr_entry *entry)
+{
+	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	struct mptcp_pm_addr_entry *match = NULL;
+	struct sock *sk = (struct sock *)msk;
+	struct mptcp_pm_addr_entry *e;
+	bool addr_match = false;
+	bool id_match = false;
+	int ret = -EINVAL;
+
+	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+
+	mptcp_data_lock(sk);
+	list_for_each_entry(e, &msk->local_addr_list, list) {
+		addr_match = addresses_equal(&e->addr, &entry->addr, true);
+		if (addr_match && entry->addr.id == 0)
+			entry->addr.id = e->addr.id;
+		id_match = (e->addr.id == entry->addr.id);
+		if (addr_match && id_match) {
+			match = e;
+			break;
+		} else if (addr_match || id_match) {
+			break;
+		}
+		__set_bit(e->addr.id, id_bitmap);
+	}
+
+	if (!match && !addr_match && !id_match) {
+		/* Memory for the entry is allocated from the
+		 * sock option buffer.
+		 */
+		e = sock_kmalloc(sk, sizeof(*e), GFP_ATOMIC);
+		if (!e) {
+			mptcp_data_unlock(sk);
+			return -ENOMEM;
+		}
+
+		*e = *entry;
+		if (!e->addr.id)
+			e->addr.id = find_next_zero_bit(id_bitmap,
+							MPTCP_PM_MAX_ADDR_ID + 1,
+							1);
+		list_add_tail_rcu(&e->list, &msk->local_addr_list);
+		ret = e->addr.id;
+	} else if (match) {
+		ret = entry->addr.id;
+	}
+
+	mptcp_data_unlock(sk);
+
+	return ret;
+}
+
 static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 					     struct mptcp_pm_addr_entry *entry)
 {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 97b0338fe96f..f7661083eee8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2547,6 +2547,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&msk->conn_list);
 	INIT_LIST_HEAD(&msk->join_list);
 	INIT_LIST_HEAD(&msk->rtx_queue);
+	INIT_LIST_HEAD(&msk->local_addr_list);
 	INIT_WORK(&msk->work, mptcp_worker);
 	__skb_queue_head_init(&msk->receive_queue);
 	msk->out_of_order_queue = RB_ROOT;
@@ -3043,6 +3044,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk)
 	msk->rmem_fwd_alloc = 0;
 	mptcp_token_destroy(msk);
 	mptcp_pm_free_anno_list(msk);
+	mptcp_free_local_addr_list(msk);
 }
 
 static void mptcp_destroy(struct sock *sk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9b655d049b94..2d18d2e7ee0e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -281,6 +281,7 @@ struct mptcp_sock {
 	struct sk_buff_head receive_queue;
 	struct list_head conn_list;
 	struct list_head rtx_queue;
+	struct list_head local_addr_list;
 	struct mptcp_data_frag *first_pending;
 	struct list_head join_list;
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
@@ -731,6 +732,7 @@ struct mptcp_sock *mptcp_token_get_sock(struct net *net, u32 token);
 struct mptcp_sock *mptcp_token_iter_next(const struct net *net, long *s_slot,
 					 long *s_num);
 void mptcp_token_destroy(struct mptcp_sock *msk);
+void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 
 void mptcp_crypto_key_sha(u64 key, u32 *token, u64 *idsn);
 
-- 
2.31.1

