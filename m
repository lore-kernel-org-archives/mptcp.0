Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0BD2C99
	for <mptcp@lists.linux.dev>; Thu, 18 Nov 2021 01:30:16 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="231577914"
X-IronPort-AV: E=Sophos;i="5.87,243,1631602800"; 
   d="scan'208";a="231577914"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 17:30:14 -0800
X-IronPort-AV: E=Sophos;i="5.87,243,1631602800"; 
   d="scan'208";a="568294749"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.27.251])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 17:30:14 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next 4/6] mptcp: Make kernel path manager check for userspace-managed sockets
Date: Wed, 17 Nov 2021 17:30:03 -0800
Message-Id: <20211118013005.263660-5-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211118013005.263660-1-mathew.j.martineau@linux.intel.com>
References: <20211118013005.263660-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Userspace-managed sockets should not have their subflows or
advertisements changed by the kernel path manager.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index bab78e2f5299..95880cff9764 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1119,7 +1119,8 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net)
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
 
-		if (!READ_ONCE(msk->fully_established))
+		if (!READ_ONCE(msk->fully_established) ||
+		    (READ_ONCE(msk->pm.pm_type) != MPTCP_PM_TYPE_KERNEL))
 			goto next;
 
 		lock_sock(sk);
@@ -1257,6 +1258,9 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		struct sock *sk = (struct sock *)msk;
 		bool remove_subflow;
 
+		if (READ_ONCE(msk->pm.pm_type) != MPTCP_PM_TYPE_KERNEL)
+			goto next;
+
 		if (list_empty(&msk->conn_list)) {
 			mptcp_pm_remove_anno_addr(msk, addr, false);
 			goto next;
@@ -1298,7 +1302,8 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 		struct sock *sk = (struct sock *)msk;
 		struct mptcp_addr_info msk_local;
 
-		if (list_empty(&msk->conn_list))
+		if (list_empty(&msk->conn_list) ||
+		    (READ_ONCE(msk->pm.pm_type) != MPTCP_PM_TYPE_KERNEL))
 			goto next;
 
 		local_address((struct sock_common *)msk, &msk_local);
@@ -1407,9 +1412,11 @@ static void mptcp_nl_remove_addrs_list(struct net *net,
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
 
-		lock_sock(sk);
-		mptcp_pm_remove_addrs_and_subflows(msk, rm_list);
-		release_sock(sk);
+		if (READ_ONCE(msk->pm.pm_type) == MPTCP_PM_TYPE_KERNEL) {
+			lock_sock(sk);
+			mptcp_pm_remove_addrs_and_subflows(msk, rm_list);
+			release_sock(sk);
+		}
 
 		sock_put(sk);
 		cond_resched();
@@ -1671,7 +1678,8 @@ static int mptcp_nl_addr_backup(struct net *net,
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
 
-		if (list_empty(&msk->conn_list))
+		if (list_empty(&msk->conn_list) ||
+		    (READ_ONCE(msk->pm.pm_type) != MPTCP_PM_TYPE_KERNEL))
 			goto next;
 
 		lock_sock(sk);
-- 
2.34.0

