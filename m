Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254A92CA2
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 03:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643858052; x=1675394052;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=k+4XqxMIvO34Lb3ry8eXXbAKxyE/G1bxl0Gzzk62aRs=;
  b=naELr2R6hcR6GGVoklT7ikaXPHu+XO+jhFZWOjbAdiuO1yPTQqrO8v3h
   ObV1dXs3toq83KtudTqUtB89wcz+TKUiyzm1cHJtpreX9EQa3O3FuCbB8
   /fVzEB32u0Ln5yi4BpJWX72m0iu8vBmqX8456Kv9WKZ1cwb0CCZiEHeUy
   TOr36yfydqp7GRXpKWjDs8GbqhaKyh7Yc9eYAK+nkTQrN2XvvDAVh4uNB
   9jFYpINUtV1f2cGP50WJjCB+mFTXBy6v76eOPVoV0b3wzn9RK3tKtLkqX
   sz6uMm1kv1OH7+IPKjn8Z22WZcek7O7f/ERQbn5W+oFaBQMGHcBop5BDD
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="235467497"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="235467497"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 19:14:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="631204621"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 19:14:09 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v4 02/13] mptcp: handle local addrs announced by userspace PMs
Date: Wed,  2 Feb 2022 22:13:52 -0500
Message-Id: <20220203031403.2996549-3-kishen.maloor@intel.com>
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

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
v4: use the sock option memory buffer to store/limit local addrs
populated by userspace PMs
---
 net/mptcp/pm_netlink.c | 79 ++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c   |  2 ++
 net/mptcp/protocol.h   |  2 ++
 3 files changed, 83 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2a3c10194d05..ac5d152fbb77 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -511,6 +511,31 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	return true;
 }
 
+void mptcp_free_local_addr_list(struct mptcp_sock *msk)
+{
+	struct mptcp_pm_addr_entry *entry, *tmp;
+	struct sock *sk = (struct sock *)msk;
+	struct pm_nl_pernet *pernet;
+	LIST_HEAD(free_list);
+
+	if (mptcp_pm_is_kernel(msk))
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
+		sock_kfree_s(sk, entry, sizeof(*entry));
+	}
+}
+
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_add_entry *entry, *tmp;
@@ -1010,6 +1035,60 @@ static bool address_use_port(struct mptcp_pm_addr_entry *entry)
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
index 6142b4b25769..ddb07a9ee098 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2539,6 +2539,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&msk->conn_list);
 	INIT_LIST_HEAD(&msk->join_list);
 	INIT_LIST_HEAD(&msk->rtx_queue);
+	INIT_LIST_HEAD(&msk->local_addr_list);
 	INIT_WORK(&msk->work, mptcp_worker);
 	__skb_queue_head_init(&msk->receive_queue);
 	msk->out_of_order_queue = RB_ROOT;
@@ -3035,6 +3036,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk)
 	msk->rmem_fwd_alloc = 0;
 	mptcp_token_destroy(msk);
 	mptcp_pm_free_anno_list(msk);
+	mptcp_free_local_addr_list(msk);
 }
 
 static void mptcp_destroy(struct sock *sk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1a8d09796627..6b7e51a2bd09 100644
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
@@ -732,6 +733,7 @@ struct mptcp_sock *mptcp_token_get_sock(struct net *net, u32 token);
 struct mptcp_sock *mptcp_token_iter_next(const struct net *net, long *s_slot,
 					 long *s_num);
 void mptcp_token_destroy(struct mptcp_sock *msk);
+void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 
 void mptcp_crypto_key_sha(u64 key, u32 *token, u64 *idsn);
 
-- 
2.31.1

