Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F632C9E
	for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 00:33:43 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="302742057"
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="302742057"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 16:33:30 -0800
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="465835392"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.72.63])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 16:33:29 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v4 4/6] mptcp: Make kernel path manager check for userspace-managed sockets
Date: Wed, 15 Dec 2021 16:33:22 -0800
Message-Id: <20211216003324.403195-5-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216003324.403195-1-mathew.j.martineau@linux.intel.com>
References: <20211216003324.403195-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Userspace-managed sockets should not have their subflows or
advertisements changed by the kernel path manager.

v3: Use helper function for PM mode (Paolo Abeni)

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c8977b0c6cb0..f12effa71942 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1173,7 +1173,8 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net)
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
 
-		if (!READ_ONCE(msk->fully_established))
+		if (!READ_ONCE(msk->fully_established) ||
+		    mptcp_pm_is_userspace(msk))
 			goto next;
 
 		lock_sock(sk);
@@ -1299,6 +1300,9 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		struct sock *sk = (struct sock *)msk;
 		bool remove_subflow;
 
+		if (mptcp_pm_is_userspace(msk))
+			goto next;
+
 		if (list_empty(&msk->conn_list)) {
 			mptcp_pm_remove_anno_addr(msk, addr, false);
 			goto next;
@@ -1340,7 +1344,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 		struct sock *sk = (struct sock *)msk;
 		struct mptcp_addr_info msk_local;
 
-		if (list_empty(&msk->conn_list))
+		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
 			goto next;
 
 		local_address((struct sock_common *)msk, &msk_local);
@@ -1449,9 +1453,11 @@ static void mptcp_nl_remove_addrs_list(struct net *net,
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
 
-		lock_sock(sk);
-		mptcp_pm_remove_addrs_and_subflows(msk, rm_list);
-		release_sock(sk);
+		if (!mptcp_pm_is_userspace(msk)) {
+			lock_sock(sk);
+			mptcp_pm_remove_addrs_and_subflows(msk, rm_list);
+			release_sock(sk);
+		}
 
 		sock_put(sk);
 		cond_resched();
@@ -1713,7 +1719,7 @@ static int mptcp_nl_addr_backup(struct net *net,
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
 
-		if (list_empty(&msk->conn_list))
+		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
 			goto next;
 
 		lock_sock(sk);
-- 
2.34.1

