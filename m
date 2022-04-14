Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAC93229
	for <mptcp@lists.linux.dev>; Thu, 14 Apr 2022 21:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649971169; x=1681507169;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=lHYmzC0QosL9S+s+n7LoGDxHz6NQ05t2eXXemjOqBeY=;
  b=XSPZgcKKsfLAtNN3184HOxEKL/z+Lagn5QaCvrSiAUX3s300QJLaOBhg
   erIgA1ejfn1mEcRcGUJKZfVBDG+v5L99LB6SFmC+xCS1pv/Ay9Fic2Mnp
   1EKpoaPGbtNbasILiYzU3xMPLK75twYURqROclsWc2tGRz4IOHzKzdFXv
   VMo3kQz3p51mYKnlM8uLf8EIMAS1d8egUjoM9PHlg5WR0Xe3xCSENI3mg
   dIPK+rFGuMHGUntAEz2p6QOMhjVRy5xNt3AhTKq6H9dZHpov5RA9KK/T9
   hNvEkG24E/Qiu2wDHFOx6Ajt5IZw1RW4CsQo8oseEBcAlh/nUp3vtLnr6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="349467251"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="349467251"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 14:19:25 -0700
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="573998118"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 14:19:24 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v10 02/14] mptcp: handle local addrs announced by userspace PMs
Date: Thu, 14 Apr 2022 17:19:08 -0400
Message-Id: <20220414211920.1987961-3-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220414211920.1987961-1-kishen.maloor@intel.com>
References: <20220414211920.1987961-1-kishen.maloor@intel.com>
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
v6:
-Move local_addr_list into struct mptcp_pm_data.
-Replace mptcp_data_lock() with the pm spinlock.
-Move mptcp_userspace_pm_append_new_local_addr() and
mptcp_free_local_addr_list() into a new pm_userspace.c.
-Make addresses_equal() helper non-static and rename to
mptcp_addresses_equal().

v8:
-Add copyright notice to pm_userspace.c.
---
 net/mptcp/Makefile       |  2 +-
 net/mptcp/pm.c           |  1 +
 net/mptcp/pm_netlink.c   | 34 +++++++++---------
 net/mptcp/pm_userspace.c | 78 ++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c     |  1 +
 net/mptcp/protocol.h     |  7 ++++
 6 files changed, 105 insertions(+), 18 deletions(-)
 create mode 100644 net/mptcp/pm_userspace.c

diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 168c55d1c917..4004347db47e 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -2,7 +2,7 @@
 obj-$(CONFIG_MPTCP) += mptcp.o
 
 mptcp-y := protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o diag.o \
-	   mib.o pm_netlink.o sockopt.o
+	   mib.o pm_netlink.o sockopt.o pm_userspace.o
 
 obj-$(CONFIG_SYN_COOKIES) += syncookies.o
 obj-$(CONFIG_INET_MPTCP_DIAG) += mptcp_diag.o
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 5d6832c4d9f2..cdc2d79071f8 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -469,6 +469,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 {
 	spin_lock_init(&msk->pm.lock);
 	INIT_LIST_HEAD(&msk->pm.anno_list);
+	INIT_LIST_HEAD(&msk->pm.userspace_pm_local_addr_list);
 	mptcp_pm_data_reset(msk);
 }
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 98b205c2c101..92d47e8e8983 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -66,8 +66,8 @@ pm_nl_get_pernet_from_msk(const struct mptcp_sock *msk)
 	return pm_nl_get_pernet(sock_net((struct sock *)msk));
 }
 
-static bool addresses_equal(const struct mptcp_addr_info *a,
-			    const struct mptcp_addr_info *b, bool use_port)
+bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
+			   const struct mptcp_addr_info *b, bool use_port)
 {
 	bool addr_equals = false;
 
@@ -131,7 +131,7 @@ static bool lookup_subflow_by_saddr(const struct list_head *list,
 		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
 
 		local_address(skc, &cur);
-		if (addresses_equal(&cur, saddr, saddr->port))
+		if (mptcp_addresses_equal(&cur, saddr, saddr->port))
 			return true;
 	}
 
@@ -149,7 +149,7 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
 		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
 
 		remote_address(skc, &cur);
-		if (addresses_equal(&cur, daddr, daddr->port))
+		if (mptcp_addresses_equal(&cur, daddr, daddr->port))
 			return true;
 	}
 
@@ -269,7 +269,7 @@ mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 	lockdep_assert_held(&msk->pm.lock);
 
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (addresses_equal(&entry->addr, addr, true))
+		if (mptcp_addresses_equal(&entry->addr, addr, true))
 			return entry;
 	}
 
@@ -286,7 +286,7 @@ bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
 
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (addresses_equal(&entry->addr, &saddr, true)) {
+		if (mptcp_addresses_equal(&entry->addr, &saddr, true)) {
 			ret = true;
 			goto out;
 		}
@@ -421,7 +421,7 @@ static bool lookup_address_in_vec(const struct mptcp_addr_info *addrs, unsigned
 	int i;
 
 	for (i = 0; i < nr; i++) {
-		if (addresses_equal(&addrs[i], addr, addr->port))
+		if (mptcp_addresses_equal(&addrs[i], addr, addr->port))
 			return true;
 	}
 
@@ -457,7 +457,7 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullm
 		mptcp_for_each_subflow(msk, subflow) {
 			ssk = mptcp_subflow_tcp_sock(subflow);
 			remote_address((struct sock_common *)ssk, &addrs[i]);
-			if (deny_id0 && addresses_equal(&addrs[i], &remote, false))
+			if (deny_id0 && mptcp_addresses_equal(&addrs[i], &remote, false))
 				continue;
 
 			if (!lookup_address_in_vec(addrs, i, &addrs[i]) &&
@@ -490,7 +490,7 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if ((!lookup_by_id && addresses_equal(&entry->addr, info, true)) ||
+		if ((!lookup_by_id && mptcp_addresses_equal(&entry->addr, info, true)) ||
 		    (lookup_by_id && entry->addr.id == info->id))
 			return entry;
 	}
@@ -505,7 +505,7 @@ lookup_id_by_addr(const struct pm_nl_pernet *pernet, const struct mptcp_addr_inf
 
 	rcu_read_lock();
 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if (addresses_equal(&entry->addr, addr, entry->addr.port)) {
+		if (mptcp_addresses_equal(&entry->addr, addr, entry->addr.port)) {
 			ret = entry->addr.id;
 			break;
 		}
@@ -739,7 +739,7 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 		struct mptcp_addr_info local;
 
 		local_address((struct sock_common *)ssk, &local);
-		if (!addresses_equal(&local, addr, addr->port))
+		if (!mptcp_addresses_equal(&local, addr, addr->port))
 			continue;
 
 		if (subflow->backup != bkup)
@@ -909,9 +909,9 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 	 * singled addresses
 	 */
 	list_for_each_entry(cur, &pernet->local_addr_list, list) {
-		if (addresses_equal(&cur->addr, &entry->addr,
-				    address_use_port(entry) &&
-				    address_use_port(cur))) {
+		if (mptcp_addresses_equal(&cur->addr, &entry->addr,
+					  address_use_port(entry) &&
+					  address_use_port(cur))) {
 			/* allow replacing the exiting endpoint only if such
 			 * endpoint is an implicit one and the user-space
 			 * did not provide an endpoint id
@@ -1038,14 +1038,14 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	 */
 	local_address((struct sock_common *)msk, &msk_local);
 	local_address((struct sock_common *)skc, &skc_local);
-	if (addresses_equal(&msk_local, &skc_local, false))
+	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
 		return 0;
 
 	pernet = pm_nl_get_pernet_from_msk(msk);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (addresses_equal(&entry->addr, &skc_local, entry->addr.port)) {
+		if (mptcp_addresses_equal(&entry->addr, &skc_local, entry->addr.port)) {
 			ret = entry->addr.id;
 			break;
 		}
@@ -1416,7 +1416,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 			goto next;
 
 		local_address((struct sock_common *)msk, &msk_local);
-		if (!addresses_equal(&msk_local, addr, addr->port))
+		if (!mptcp_addresses_equal(&msk_local, addr, addr->port))
 			goto next;
 
 		lock_sock(sk);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
new file mode 100644
index 000000000000..c50f8900ffba
--- /dev/null
+++ b/net/mptcp/pm_userspace.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Multipath TCP
+ *
+ * Copyright (c) 2022, Intel Corporation.
+ */
+
+#include "protocol.h"
+
+void mptcp_free_local_addr_list(struct mptcp_sock *msk)
+{
+	struct mptcp_pm_addr_entry *entry, *tmp;
+	struct sock *sk = (struct sock *)msk;
+	LIST_HEAD(free_list);
+
+	if (!mptcp_pm_is_userspace(msk))
+		return;
+
+	spin_lock_bh(&msk->pm.lock);
+	list_splice_init(&msk->pm.userspace_pm_local_addr_list, &free_list);
+	spin_unlock_bh(&msk->pm.lock);
+
+	list_for_each_entry_safe(entry, tmp, &free_list, list) {
+		sock_kfree_s(sk, entry, sizeof(*entry));
+	}
+}
+
+int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
+					     struct mptcp_pm_addr_entry *entry)
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
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
+		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
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
+			spin_unlock_bh(&msk->pm.lock);
+			return -ENOMEM;
+		}
+
+		*e = *entry;
+		if (!e->addr.id)
+			e->addr.id = find_next_zero_bit(id_bitmap,
+							MPTCP_PM_MAX_ADDR_ID + 1,
+							1);
+		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
+		ret = e->addr.id;
+	} else if (match) {
+		ret = entry->addr.id;
+	}
+
+	spin_unlock_bh(&msk->pm.lock);
+	return ret;
+}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b2c654992de0..b016822f44dc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3103,6 +3103,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk)
 	msk->rmem_fwd_alloc = 0;
 	mptcp_token_destroy(msk);
 	mptcp_pm_free_anno_list(msk);
+	mptcp_free_local_addr_list(msk);
 }
 
 static void mptcp_destroy(struct sock *sk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 187c932deef0..40dabf9462a8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -208,6 +208,7 @@ struct mptcp_pm_data {
 	struct mptcp_addr_info local;
 	struct mptcp_addr_info remote;
 	struct list_head anno_list;
+	struct list_head userspace_pm_local_addr_list;
 
 	spinlock_t	lock;		/*protects the whole PM data */
 
@@ -601,6 +602,9 @@ void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk);
 
+bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
+			   const struct mptcp_addr_info *b, bool use_port);
+
 /* called with sk socket lock held */
 int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 			    const struct mptcp_addr_info *remote);
@@ -779,6 +783,9 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
+int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
+					     struct mptcp_pm_addr_entry *entry);
+void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-- 
2.31.1

