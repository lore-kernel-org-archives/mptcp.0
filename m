Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6C420EC
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 02:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651631949; x=1683167949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=op3ufkMsUw3X5mNCgmwsCaCzkYqkwQ6qdR+SQOk/NSM=;
  b=hElFR6ro5M/mtMS8yjA67TjUq64+WHbZMrMeHweBnoipNDfYguOFP8AA
   7JWw8ESa7pu6qWTg1AIGg1X3GGbyKi7QSFMbAgBM5/ZQinN9HdtZOChtw
   y+FdSIAkqy5uhs1r26I68M2YnDjbTKgT5R9cOlMTpTBEEXmCWgCeffou5
   gOkmdRxUiBGE05K+Evd+JnWNsJlrzQVVZnvorxjypIGoW/KtVtvyM2y7r
   XQ39vZv8TVuDGqkXkkYktHNeShH8yhMzbrUzihsnbAXU3wjbj7AOlH0O4
   H0i9ynUBZjw41vB+oy8ibOtUcTuRxZEIR24J5Q4htUK4pAUo4lLc569II
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="266488756"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="266488756"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 19:39:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="584493370"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.20.240])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 19:39:07 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Kishen Maloor <kishen.maloor@intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 02/13] mptcp: read attributes of addr entries managed by userspace PMs
Date: Tue,  3 May 2022 19:38:50 -0700
Message-Id: <20220504023901.277012-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220504023901.277012-1-mathew.j.martineau@linux.intel.com>
References: <20220504023901.277012-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kishen Maloor <kishen.maloor@intel.com>

This change introduces a parallel path in the kernel for retrieving
the local id, flags, if_index for an addr entry in the context of
an MPTCP connection that's being managed by a userspace PM. The
userspace and in-kernel PM modes deviate in their procedures for
obtaining this information.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c   | 13 +++++++++++-
 net/mptcp/pm_userspace.c | 43 ++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h     |  7 ++++++-
 net/mptcp/subflow.c      |  2 +-
 4 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9d515c3e0b16..79f5e7197a06 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1033,6 +1033,9 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
 		return 0;
 
+	if (mptcp_pm_is_userspace(msk))
+		return mptcp_userspace_pm_get_local_id(msk, &skc_local);
+
 	pernet = pm_nl_get_pernet_from_msk(msk);
 
 	rcu_read_lock();
@@ -1297,15 +1300,23 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
-int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
+int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
 					 u8 *flags, int *ifindex)
 {
 	struct mptcp_pm_addr_entry *entry;
+	struct sock *sk = (struct sock *)msk;
+	struct net *net = sock_net(sk);
 
 	*flags = 0;
 	*ifindex = 0;
 
 	if (id) {
+		if (mptcp_pm_is_userspace(msk))
+			return mptcp_userspace_pm_get_flags_and_ifindex_by_id(msk,
+									      id,
+									      flags,
+									      ifindex);
+
 		rcu_read_lock();
 		entry = __lookup_addr_by_id(pm_nl_get_pernet(net), id);
 		if (entry) {
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index c50f8900ffba..910116b0f5b9 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -76,3 +76,46 @@ int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	spin_unlock_bh(&msk->pm.lock);
 	return ret;
 }
+
+int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
+						   unsigned int id,
+						   u8 *flags, int *ifindex)
+{
+	struct mptcp_pm_addr_entry *entry, *match = NULL;
+
+	*flags = 0;
+	*ifindex = 0;
+
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (id == entry->addr.id) {
+			match = entry;
+			break;
+		}
+	}
+	spin_unlock_bh(&msk->pm.lock);
+	if (match) {
+		*flags = match->flags;
+		*ifindex = match->ifindex;
+	}
+
+	return 0;
+}
+
+int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
+				    struct mptcp_addr_info *skc)
+{
+	struct mptcp_pm_addr_entry new_entry;
+	__be16 msk_sport =  ((struct inet_sock *)
+			     inet_sk((struct sock *)msk))->inet_sport;
+
+	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
+	new_entry.addr = *skc;
+	new_entry.addr.id = 0;
+	new_entry.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
+
+	if (new_entry.addr.port == msk_sport)
+		new_entry.addr.port = 0;
+
+	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry);
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f41089e54555..7257dc7aed43 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -783,8 +783,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
-int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
+int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
+					 unsigned int id,
 					 u8 *flags, int *ifindex);
+int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
+						   unsigned int id,
+						   u8 *flags, int *ifindex);
 
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
@@ -862,6 +866,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
+int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a0e7af33fb26..6d59336a8e1e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1468,7 +1468,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	if (local_id)
 		subflow_set_local_id(subflow, local_id);
 
-	mptcp_pm_get_flags_and_ifindex_by_id(sock_net(sk), local_id,
+	mptcp_pm_get_flags_and_ifindex_by_id(msk, local_id,
 					     &flags, &ifindex);
 	subflow->remote_key = msk->remote_key;
 	subflow->local_key = msk->local_key;
-- 
2.36.0

