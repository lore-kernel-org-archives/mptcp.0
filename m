Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D222CAA
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 00:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643330324; x=1674866324;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=M06S7bs3hor2JxrN6EUh4dkLHusxQZUhYmstAzmLhH4=;
  b=DvYmNPpo7zKT36RtrpG02D15nFPYG2h7NQThHAKvcV5+HV27RdaugtEC
   c9B1rOpnCkYCbmfcuAkmnG5sOvljk8/b2j86nOjKQJ+GZEzKYfRAD/Sue
   LLg6Jwtgnv/fCKY2vsyAxA+2VJM+wRwox9FT74fJW/3qJNQr2nJPaNe24
   wOaWf4yEoeoF5LVrsY+PX1jeh/glfe653HHeNlSl9dIijAE/NE1iybT+z
   ciZz6coJg+vVeE15jB3BaXWvjeeNFSYwIcIsqa4qqdrVX7Jtdg4vg5Uyk
   3/avDykW/8DcbMxcM/+YLZzy6gtXyet3b6nU8DX+SK+HP0dNOxA0vGU6n
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="245846918"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="245846918"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:25 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="564001007"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:20 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v3 7/8] mptcp: attempt to add listening sockets for announced addrs
Date: Thu, 27 Jan 2022 19:38:11 -0500
Message-Id: <20220128003812.2732609-8-kishen.maloor@intel.com>
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
---
 include/uapi/linux/mptcp.h |  1 +
 net/mptcp/pm_netlink.c     | 47 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 2 deletions(-)

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
index dc02dfe917e1..ceb4517a6e2b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -43,6 +43,7 @@ struct mptcp_pm_add_entry {
 	struct mptcp_addr_info	addr;
 	struct timer_list	add_timer;
 	struct mptcp_sock	*sock;
+	struct mptcp_local_lsk	*lsk_ref;
 	u8			retrans_times;
 };
 
@@ -66,6 +67,10 @@ struct pm_nl_pernet {
 #define MPTCP_PM_ADDR_MAX	8
 #define ADD_ADDR_RETRANS_MAX	3
 
+static int mptcp_pm_nl_create_listen_socket(struct net *net,
+					    struct mptcp_pm_addr_entry *entry,
+					    struct socket **lsk);
+
 static bool addresses_equal(const struct mptcp_addr_info *a,
 			    const struct mptcp_addr_info *b, bool use_port)
 {
@@ -465,7 +470,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 }
 
 static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-				     struct mptcp_pm_addr_entry *entry)
+				     struct mptcp_pm_addr_entry *entry,
+				     struct mptcp_local_lsk *lsk_ref)
 {
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
@@ -485,6 +491,10 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry->addr = entry->addr;
 	add_entry->sock = msk;
 	add_entry->retrans_times = 0;
+	add_entry->lsk_ref = lsk_ref;
+
+	if (lsk_ref)
+		lsk_list_add_ref(lsk_ref);
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
 	sk_reset_timer(sk, &add_entry->add_timer,
@@ -497,8 +507,11 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_add_entry *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
+	struct pm_nl_pernet *pernet;
 	LIST_HEAD(free_list);
 
+	pernet = net_generic(sock_net(sk), pm_nl_pernet_id);
+
 	pr_debug("msk=%p", msk);
 
 	spin_lock_bh(&msk->pm.lock);
@@ -507,6 +520,8 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 
 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
 		sk_stop_timer_sync(sk, &entry->add_timer);
+		if (entry->lsk_ref)
+			lsk_list_release(pernet, entry->lsk_ref);
 		kfree(entry);
 	}
 }
@@ -611,7 +626,9 @@ lookup_id_by_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *add
 }
 
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
+	__must_hold(&msk->pm.lock)
 {
+	struct mptcp_local_lsk *lsk_ref = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *local;
 	unsigned int add_addr_signal_max;
@@ -648,12 +665,31 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
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
 
@@ -745,6 +781,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 }
 
 static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
+	__must_hold(&msk->pm.lock)
 {
 	struct mptcp_addr_info addrs[MPTCP_PM_ADDR_MAX];
 	struct sock *sk = (struct sock *)msk;
@@ -1379,11 +1416,17 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
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

