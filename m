Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACDC2C81
	for <mptcp@lists.linux.dev>; Thu,  7 Oct 2021 00:00:06 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="226439236"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="226439236"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 16:59:59 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="560351282"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.0.106])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 16:59:59 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	kishen.maloor@intel.com
Subject: [RFC PATCH 3/6] mptcp: Make kernel path manager check for userspace-managed sockets
Date: Wed,  6 Oct 2021 16:59:50 -0700
Message-Id: <20211006235953.212243-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006235953.212243-1-mathew.j.martineau@linux.intel.com>
References: <20211006235953.212243-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Userspace-managed sockets should not have their subflows or advertisements changed by the kernel path manager.

(Possible squash with earlier commit)

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 30b974801d51..434049836707 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1131,7 +1131,8 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net)
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
 
-		if (!READ_ONCE(msk->fully_established))
+		if (!READ_ONCE(msk->fully_established) ||
+		    READ_ONCE(msk->pm.userspace))
 			goto next;
 
 		lock_sock(sk);
@@ -1269,6 +1270,9 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		struct sock *sk = (struct sock *)msk;
 		bool remove_subflow;
 
+		if (READ_ONCE(msk->pm.userspace))
+			goto next;
+
 		if (list_empty(&msk->conn_list)) {
 			mptcp_pm_remove_anno_addr(msk, addr, false);
 			goto next;
@@ -1310,7 +1314,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 		struct sock *sk = (struct sock *)msk;
 		struct mptcp_addr_info msk_local;
 
-		if (list_empty(&msk->conn_list))
+		if (list_empty(&msk->conn_list) || READ_ONCE(msk->pm.userspace))
 			goto next;
 
 		local_address((struct sock_common *)msk, &msk_local);
@@ -1419,9 +1423,11 @@ static void mptcp_nl_remove_addrs_list(struct net *net,
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
 
-		lock_sock(sk);
-		mptcp_pm_remove_addrs_and_subflows(msk, rm_list);
-		release_sock(sk);
+		if (!READ_ONCE(msk->pm.userspace)) {
+			lock_sock(sk);
+			mptcp_pm_remove_addrs_and_subflows(msk, rm_list);
+			release_sock(sk);
+		}
 
 		sock_put(sk);
 		cond_resched();
@@ -1683,7 +1689,8 @@ static int mptcp_nl_addr_backup(struct net *net,
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
 
-		if (list_empty(&msk->conn_list))
+		if (list_empty(&msk->conn_list) ||
+		    READ_ONCE(msk->pm.userspace))
 			goto next;
 
 		lock_sock(sk);
-- 
2.33.0

