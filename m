Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C232CA3
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 22:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642025773; x=1673561773;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=+SCOcRKlIRGNRsZw9Gv0iFFymUvaM1ywAOywIEPOCSI=;
  b=au3YupcQB6LXKBAtM1UVqbWB7fJDaBV2GEFuJ9daQyY0XWbupJtoHBGS
   bJA1JcQJEPWE1/X5zh5tfy3ZbuaEMeGNKdZUFwTMsnyDovpff+bjwMCOu
   NE5k2nR3O55yNfZxbCHFpCLGlQ7LqZZUdaOs9IQbbKOuNhhm/22vyhQ45
   SnAvbMzIC8wBwTuyYRyQjF+CCRIVkifwx277OUxEkqsqPI7zAZFYXzmRa
   C5tSUrcFH+R3EaoskbVHuEH5Bwm+tXcTgGT77yB2Iyu8na8TZou+F4Os3
   ZTXps/8I2D7cqb6P/dguPj6+lFNY1IXr5GOEpISKkCg/pf2S+MPIYisrp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="307213936"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="307213936"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 14:16:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="490907352"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 14:16:07 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 08/21] mptcp: attempt to add listening sockets for announced addrs
Date: Wed, 12 Jan 2022 17:15:10 -0500
Message-Id: <20220112221523.1829397-9-kishen.maloor@intel.com>
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

When ADD_ADDR announcements use the port associated with an
active subflow, this change ensures that a listening socket is
bound to the announced address and port for subsequently
receiving MP_JOINs from the remote end. In case there's
a recorded lsk bound to that address+port, it is reused.
But if a listening socket for this address is already held by the
application then no further action is taken.

When a listening socket is created, it is stored in
struct mptcp_pm_add_entry and released accordingly.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/203

v2: fixed formatting

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 net/mptcp/pm_netlink.c | 56 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 779ec9d375f0..e2211f3b8c8c 100644
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
 
+static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
+					    struct mptcp_pm_addr_entry *entry,
+					    struct socket **lsk);
+
 static bool addresses_equal(const struct mptcp_addr_info *a,
 			    const struct mptcp_addr_info *b, bool use_port)
 {
@@ -438,7 +443,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 }
 
 static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-				     struct mptcp_pm_addr_entry *entry)
+				     struct mptcp_pm_addr_entry *entry,
+				     struct mptcp_local_lsk *lsk_ref)
 {
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
@@ -458,6 +464,10 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry->addr = entry->addr;
 	add_entry->sock = msk;
 	add_entry->retrans_times = 0;
+	add_entry->lsk_ref = lsk_ref;
+
+	if (lsk_ref)
+		lsk_list_add_ref(lsk_ref);
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
 	sk_reset_timer(sk, &add_entry->add_timer,
@@ -470,8 +480,11 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_add_entry *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
+	struct pm_nl_pernet *pernet;
 	LIST_HEAD(free_list);
 
+	pernet = net_generic(sock_net(sk), pm_nl_pernet_id);
+
 	pr_debug("msk=%p", msk);
 
 	spin_lock_bh(&msk->pm.lock);
@@ -480,6 +493,8 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 
 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
 		sk_stop_timer_sync(sk, &entry->add_timer);
+		if (entry->lsk_ref)
+			lsk_list_release(pernet, entry->lsk_ref);
 		kfree(entry);
 	}
 }
@@ -570,13 +585,16 @@ lookup_id_by_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *add
 }
 
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
+	__must_hold(&msk->pm.lock)
 {
+	struct mptcp_local_lsk *lsk_ref = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *local;
 	unsigned int add_addr_signal_max;
 	unsigned int local_addr_max;
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
+	struct socket *lsk;
 
 	pernet = net_generic(sock_net(sk), pm_nl_pernet_id);
 
@@ -607,12 +625,39 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		local = select_signal_address(pernet, msk);
 
 		if (local) {
-			if (mptcp_pm_alloc_anno_list(msk, local)) {
+			if (!local->addr.port) {
+				local->addr.port =
+					((struct inet_sock *)inet_sk
+					 ((struct sock *)msk))->inet_sport;
+
+				lsk_ref = lsk_list_find(pernet, &local->addr);
+
+				if (!lsk_ref) {
+					spin_unlock_bh(&msk->pm.lock);
+
+					mptcp_pm_nl_create_listen_socket(sk, local, &lsk);
+
+					spin_lock_bh(&msk->pm.lock);
+
+					if (lsk)
+						lsk_ref = lsk_list_add(pernet, &local->addr, lsk);
+
+					if (lsk && !lsk_ref)
+						sock_release(lsk);
+				}
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
 
@@ -704,6 +749,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 }
 
 static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
+	__must_hold(&msk->pm.lock)
 {
 	struct mptcp_addr_info addrs[MPTCP_PM_ADDR_MAX];
 	struct sock *sk = (struct sock *)msk;
@@ -1352,11 +1398,17 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
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

