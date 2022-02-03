Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43CF2CA1
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 07:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643873119; x=1675409119;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=OM51OlNI4UM843dpo4EL8un5G66rQEcWF4rAEz4dh1o=;
  b=QgOczU8MULUlvXhQO/cO/7bchyvsXrZ4ij7NZwvuDv9Gg+OpEBP19fNc
   B9Y10JC/w74a1nZw/6obYrGUj8VsUacfoMX2BuMIIk6cUjtKDN9gpFFNC
   vQfoIY9FOJr5EHLfEEfxn5Gr8DkuP/qD/gnUWx3KsKsp3iSg6Tz40Jdh/
   x7/dout8HJ7Wa2C5+77LW1/M9tqgFapanO2yf1bjkLN06aGhQc4Y0pYVL
   y9Tw4vvlzqvhraZ6Q5nL0pvCKT0pE98kEB9FWP72UMizOpWgGH57QVDYZ
   AAu1EcWL0tdCed/3hOM0DaWY0pmaAT3M3QS5GA9MBQSq+Cwr2qvkqWB9/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="272580776"
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="272580776"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 23:25:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="535118732"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 23:25:14 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v5 7/8] mptcp: attempt to add listening sockets for announced addrs
Date: Thu,  3 Feb 2022 02:25:07 -0500
Message-Id: <20220203072508.3072309-8-kishen.maloor@intel.com>
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

When ADD_ADDR announcements use the port associated with an
active subflow, this change ensures that a listening socket is bound
to the announced addr+port in the kernel for subsequently receiving
MP_JOINs. But if a listening socket for this address is already held
by the application then no action is taken.

A listening socket is created (when there isn't a listener)
just prior to the addr advertisement. If it is desired to not create
a listening socket in the kernel for an address, then this can be
requested by including the MPTCP_PM_ADDR_FLAG_NO_LISTEN flag
with the address.

When a listening socket is created, it is stored in
struct mptcp_pm_add_entry and released accordingly.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/203
Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
v2: fixed formatting
v3: added new addr flag MPTCP_PM_ADDR_FLAG_NO_LISTEN to skip creating a
listening socket in the kernel during an ADD_ADDR request, use this flag
along the in-kernel PM flow for ADD_ADDR requests (Note: listening sockets
are always created for port-based endpoints as before), use the
lsk_list_find_or_create() helper
v4: call lsk_list_find() after a failed lsk_list_find_or_create()
for a chance to retrieve a recently created lsk by a simultaneous
call
---
 include/uapi/linux/mptcp.h |  1 +
 net/mptcp/pm_netlink.c     | 46 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index f106a3941cdf..265cabc0d7aa 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -81,6 +81,7 @@ enum {
 #define MPTCP_PM_ADDR_FLAG_SUBFLOW			(1 << 1)
 #define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
 #define MPTCP_PM_ADDR_FLAG_FULLMESH			(1 << 3)
+#define MPTCP_PM_ADDR_FLAG_NO_LISTEN			(1 << 4)
 
 enum {
 	MPTCP_PM_CMD_UNSPEC,
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a4fb9acbba51..9b3d871d3712 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -43,6 +43,7 @@ struct mptcp_pm_add_entry {
 	struct mptcp_addr_info	addr;
 	struct timer_list	add_timer;
 	struct mptcp_sock	*sock;
+	struct mptcp_local_lsk	*lsk_ref;
 	u8			retrans_times;
 };
 
@@ -469,7 +470,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 }
 
 static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-				     struct mptcp_pm_addr_entry *entry)
+				     struct mptcp_pm_addr_entry *entry,
+				     struct mptcp_local_lsk *lsk_ref)
 {
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
@@ -489,6 +491,10 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry->addr = entry->addr;
 	add_entry->sock = msk;
 	add_entry->retrans_times = 0;
+	add_entry->lsk_ref = lsk_ref;
+
+	if (lsk_ref)
+		lsk_list_add_ref(lsk_ref);
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
 	sk_reset_timer(sk, &add_entry->add_timer,
@@ -501,8 +507,11 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_add_entry *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
+	struct pm_nl_pernet *pernet;
 	LIST_HEAD(free_list);
 
+	pernet = net_generic(sock_net(sk), pm_nl_pernet_id);
+
 	pr_debug("msk=%p", msk);
 
 	spin_lock_bh(&msk->pm.lock);
@@ -511,6 +520,8 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 
 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
 		sk_stop_timer_sync(sk, &entry->add_timer);
+		if (entry->lsk_ref)
+			lsk_list_release(pernet, entry->lsk_ref);
 		kfree(entry);
 	}
 }
@@ -615,7 +626,9 @@ lookup_id_by_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *add
 }
 
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
+	__must_hold(&msk->pm.lock)
 {
+	struct mptcp_local_lsk *lsk_ref = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *local;
 	unsigned int add_addr_signal_max;
@@ -652,12 +665,34 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		local = select_signal_address(pernet, msk);
 
 		if (local) {
-			if (mptcp_pm_alloc_anno_list(msk, local)) {
+			if (!(local->flags & MPTCP_PM_ADDR_FLAG_NO_LISTEN) &&
+			    !local->addr.port) {
+				local->addr.port =
+					((struct inet_sock *)inet_sk
+					 ((struct sock *)msk))->inet_sport;
+
+				spin_unlock_bh(&msk->pm.lock);
+
+				lsk_ref = lsk_list_find_or_create(sock_net(sk), pernet,
+								  local, NULL);
+
+				spin_lock_bh(&msk->pm.lock);
+
+				if (!lsk_ref)
+					lsk_ref = lsk_list_find(pernet, &local->addr);
+
+				local->addr.port = 0;
+			}
+
+			if (mptcp_pm_alloc_anno_list(msk, local, lsk_ref)) {
 				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 				msk->pm.add_addr_signaled++;
 				mptcp_pm_announce_addr(msk, &local->addr, false);
 				mptcp_pm_nl_addr_send_ack(msk);
 			}
+
+			if (lsk_ref)
+				lsk_list_release(pernet, lsk_ref);
 		}
 	}
 
@@ -749,6 +784,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 }
 
 static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
+	__must_hold(&msk->pm.lock)
 {
 	struct mptcp_addr_info addrs[MPTCP_PM_ADDR_MAX];
 	struct sock *sk = (struct sock *)msk;
@@ -1389,11 +1425,17 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
 static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				      struct mptcp_addr_info *addr)
 {
+	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_add_entry *entry;
+	struct pm_nl_pernet *pernet;
+
+	pernet = net_generic(sock_net(sk), pm_nl_pernet_id);
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
 	if (entry) {
 		list_del(&entry->list);
+		if (entry->lsk_ref)
+			lsk_list_release(pernet, entry->lsk_ref);
 		kfree(entry);
 		return true;
 	}
-- 
2.31.1

