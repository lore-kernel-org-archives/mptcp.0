Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFA02CAE
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 00:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643330325; x=1674866325;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=nGeG430NBJeF9Y+vsoUaxacWf29cVhQeW2t6F+8m2pc=;
  b=EGERoqDCJvTaLE9i+La5rQ91CgRhcfleJOYgYI+pXkKZ1rbBWKsAGWlq
   S0DbxZuvdFxrkuX0noUEQs0Agm3mNHPsPfn6aX1C+BkUwHPNi1ekmq+YO
   pvTm6zQ3tRUxyc5BrALjsbw8nxsi6dO5rqqabnacPYR83bEKKih6TQRCR
   T+3l7lIqJLLXS722KuRJJ5JA52E8g0oykP0fRujQ5Eh9xNDiqfQtm7QM1
   yuXW2yu8n5qBK+l4hSfoSPNpChpakwAuBukQHKkTx7/VNnyP2eMS7U+AJ
   ExxkA/QLloXad8TQuio0J4pmp91iOZt3wim1mhRLzUkHAWTZ9IBm4uu1i
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="333358332"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="333358332"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:42 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="480527112"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:41 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v3 03/14] mptcp: handle local addrs announced by userspace PMs
Date: Thu, 27 Jan 2022 19:38:25 -0500
Message-Id: <20220128003836.2732694-4-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220128003836.2732694-1-kishen.maloor@intel.com>
References: <20220128003836.2732694-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change adds a new internal function to store/retrieve local
addrs announced by userspace PM implementations to/from its kernel
context. The function captures the requirements of three scenarios:
1) ADD_ADDR announcements (which require that a local id be
provided), 2) retrieving the local id associated with an address,
also where one may need to be assigned, and 3) reissuance of
ADD_ADDRs when there's a successful match of addr/id.

The list of all stored local addr entries is held under the
MPTCP sock structure. This list, if not released by the REMOVE_ADDR
flow is freed while the sock is destructed.

Additionally, this function enforces the kernel imposed limit on
the number of local addresses that may be used over a connection.

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
v3: incorporate the new sysctl configurable limit on the # of local
addresses that may be populated by userspace PMs
---
 net/mptcp/pm_netlink.c | 88 ++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c   |  2 +
 net/mptcp/protocol.h   |  2 +
 3 files changed, 92 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 726dc0a56fca..ebec3610bb38 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -511,6 +511,34 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
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
+	spin_lock_bh(&msk->pm.lock);
+	msk->pm.local_addr_used = 0;
+	spin_unlock_bh(&msk->pm.lock);
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
@@ -1007,6 +1035,66 @@ static bool address_use_port(struct mptcp_pm_addr_entry *entry)
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
+		spin_lock_bh(&msk->pm.lock);
+		if (msk->pm.local_addr_used <
+		    mptcp_get_userspace_pm_local_addr_max(sock_net(sk))) {
+			e = kmalloc(sizeof(*e), GFP_ATOMIC);
+			if (!e) {
+				mptcp_data_unlock(sk);
+				return -ENOMEM;
+			}
+
+			*e = *entry;
+			if (!e->addr.id)
+				e->addr.id = find_next_zero_bit(id_bitmap,
+								MPTCP_PM_MAX_ADDR_ID + 1,
+								1);
+			list_add_tail_rcu(&e->list, &msk->local_addr_list);
+			++msk->pm.local_addr_used;
+			ret = e->addr.id;
+
+			if (e->lsk_ref && e->addr.port)
+				lsk_list_add_ref(e->lsk_ref);
+		}
+		spin_unlock_bh(&msk->pm.lock);
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
index 7c591177c3e8..82b4f9b76f42 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2540,6 +2540,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&msk->conn_list);
 	INIT_LIST_HEAD(&msk->join_list);
 	INIT_LIST_HEAD(&msk->rtx_queue);
+	INIT_LIST_HEAD(&msk->local_addr_list);
 	INIT_WORK(&msk->work, mptcp_worker);
 	__skb_queue_head_init(&msk->receive_queue);
 	msk->out_of_order_queue = RB_ROOT;
@@ -3036,6 +3037,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk)
 	msk->rmem_fwd_alloc = 0;
 	mptcp_token_destroy(msk);
 	mptcp_pm_free_anno_list(msk);
+	mptcp_free_local_addr_list(msk);
 }
 
 static void mptcp_destroy(struct sock *sk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6cfa8ec26482..dbf0c134e923 100644
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

