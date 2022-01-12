Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1901F2CAA
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 22:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642025774; x=1673561774;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=lBMtBBIaLYyptLinYA2sRrNd7xM53N1L9UuK6nFZQpc=;
  b=CF4eoyxdLFrYSVm7/kzNZe3ioS5JbHsP0k+lBUHX/BNnLL733I6lJ/Fe
   ClFgc6XCmoARCgdTKRE88Mglf0UlOJfX5p0y1s2Ck3bvnsNSSGu+olKgz
   cwztUbt0OYJCc40JRlxaaSHk1iGlbHgonFI/GT9xFR5AUAU7CrvrEY5LV
   jkwtU4eUm1ReHyEpiwuvU6zN2Z8yuJPWmL4ybXlfhhr0kDWl0FTyD9QTm
   piZ2/k5c+IqvijtGzGGhfBXZwitNzMm5YIjohPw1ILbBN2ndVu2xd1ORK
   ivtFRZbs2XLf4l3NrW0E/shQSS1dZygnFx2KRhEgrgU3U+bMl7Y9MZs4t
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="307213938"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="307213938"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 14:16:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="490907358"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 14:16:07 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 10/21] mptcp: handle local addrs announced by userspace PMs
Date: Wed, 12 Jan 2022 17:15:12 -0500
Message-Id: <20220112221523.1829397-11-kishen.maloor@intel.com>
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

This change adds a new internal function to store/retrieve local
addrs announced by userspace PM implementations from the kernel
context. The function does not stipulate any limitation on the #
of addrs, and handles the requirements of three scenarios:
1) ADD_ADDR announcements (which require that a local id be
provided), 2) retrieving the local id associated with an address,
also where one may need to be assigned, and 3) reissuance of
ADD_ADDRs when there's a successful match of addr/id.

The list of all stored local addr entries is held under the
MPTCP sock structure. This list, if not released by the REMOVE_ADDR
flow is freed while the sock is destructed.

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 net/mptcp/pm_netlink.c | 79 ++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c   |  2 ++
 net/mptcp/protocol.h   |  2 ++
 3 files changed, 83 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a8c9a89ee1c5..052a803a7f71 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -484,6 +484,31 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	return true;
 }
 
+void mptcp_free_local_addr_list(struct mptcp_sock *msk)
+{
+	struct mptcp_pm_addr_entry *entry, *tmp;
+	struct sock *sk = (struct sock *)msk;
+	struct pm_nl_pernet *pernet;
+	LIST_HEAD(free_list);
+
+	if (READ_ONCE(msk->pm.pm_type) == MPTCP_PM_TYPE_KERNEL)
+		return;
+
+	pernet = net_generic(sock_net(sk), pm_nl_pernet_id);
+
+	pr_debug("msk=%p", msk);
+
+	mptcp_data_lock(sk);
+	list_splice_init(&msk->local_addr_list, &free_list);
+	mptcp_data_unlock(sk);
+
+	list_for_each_entry_safe(entry, tmp, &free_list, list) {
+		if (entry->lsk_ref)
+			lsk_list_release(pernet, entry->lsk_ref);
+		kfree(entry);
+	}
+}
+
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_add_entry *entry, *tmp;
@@ -972,6 +997,60 @@ static bool address_use_port(struct mptcp_pm_addr_entry *entry)
 		MPTCP_PM_ADDR_FLAG_SIGNAL;
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
+		e = kmalloc(sizeof(*e), GFP_ATOMIC);
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
+
+		if (e->lsk_ref && e->addr.port)
+			lsk_list_add_ref(e->lsk_ref);
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
index 408a05bff633..331c1080396d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2531,6 +2531,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&msk->conn_list);
 	INIT_LIST_HEAD(&msk->join_list);
 	INIT_LIST_HEAD(&msk->rtx_queue);
+	INIT_LIST_HEAD(&msk->local_addr_list);
 	INIT_WORK(&msk->work, mptcp_worker);
 	__skb_queue_head_init(&msk->receive_queue);
 	msk->out_of_order_queue = RB_ROOT;
@@ -3027,6 +3028,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk)
 	msk->rmem_fwd_alloc = 0;
 	mptcp_token_destroy(msk);
 	mptcp_pm_free_anno_list(msk);
+	mptcp_free_local_addr_list(msk);
 }
 
 static void mptcp_destroy(struct sock *sk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c50247673c7e..63b4ea850d07 100644
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
@@ -733,6 +734,7 @@ struct mptcp_sock *mptcp_token_get_sock(struct net *net, u32 token);
 struct mptcp_sock *mptcp_token_iter_next(const struct net *net, long *s_slot,
 					 long *s_num);
 void mptcp_token_destroy(struct mptcp_sock *msk);
+void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 
 void mptcp_crypto_key_sha(u64 key, u32 *token, u64 *idsn);
 
-- 
2.31.1

