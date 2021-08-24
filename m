Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD6D3FC8
	for <mptcp@lists.linux.dev>; Tue, 24 Aug 2021 01:05:52 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10085"; a="197456289"
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="197456289"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 18:05:51 -0700
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="515224409"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.11.16])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 18:05:50 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Yonglong Li <liyonglong@chinatelecom.cn>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Geliang Tang <geliangtang@gmail.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 5/6] mptcp: remove MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT
Date: Mon, 23 Aug 2021 18:05:43 -0700
Message-Id: <20210824010544.68600-6-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210824010544.68600-1-mathew.j.martineau@linux.intel.com>
References: <20210824010544.68600-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yonglong Li <liyonglong@chinatelecom.cn>

MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT are not necessary, we can get
these info from pm.local or pm.remote.

Drop mptcp_pm_should_add_signal_ipv6 and mptcp_pm_should_add_signal_port
too.

Co-developed-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm.c         |  6 +-----
 net/mptcp/pm_netlink.c |  6 ++----
 net/mptcp/protocol.h   | 12 ------------
 3 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index f1b520df228a..da0c4c925350 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -37,10 +37,6 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 		msk->pm.local = *addr;
 		add_addr |= BIT(MPTCP_ADD_ADDR_SIGNAL);
 	}
-	if (addr->family == AF_INET6)
-		add_addr |= BIT(MPTCP_ADD_ADDR_IPV6);
-	if (addr->port)
-		add_addr |= BIT(MPTCP_ADD_ADDR_PORT);
 	WRITE_ONCE(msk->pm.addr_signal, add_addr);
 	return 0;
 }
@@ -280,7 +276,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 	}
 
 	*echo = mptcp_pm_should_add_signal_echo(msk);
-	*port = mptcp_pm_should_add_signal_port(msk);
+	*port = !!(*echo ? msk->pm.remote.port : msk->pm.local.port);
 
 	family = *echo ? msk->pm.remote.family : msk->pm.local.family;
 	if (remaining < mptcp_add_addr_len(family, *echo, *port))
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d8dfd872a6dd..1e4289c507ff 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -647,10 +647,8 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 		bool slow;
 
 		spin_unlock_bh(&msk->pm.lock);
-		pr_debug("send ack for %s%s%s",
-			 mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr",
-			 mptcp_pm_should_add_signal_ipv6(msk) ? " [ipv6]" : "",
-			 mptcp_pm_should_add_signal_port(msk) ? " [port]" : "");
+		pr_debug("send ack for %s",
+			 mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr");
 
 		slow = lock_sock_fast(ssk);
 		tcp_send_ack(ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 27afacb6fde2..7cd3d5979bcd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -178,8 +178,6 @@ enum mptcp_pm_status {
 enum mptcp_addr_signal_status {
 	MPTCP_ADD_ADDR_SIGNAL,
 	MPTCP_ADD_ADDR_ECHO,
-	MPTCP_ADD_ADDR_IPV6,
-	MPTCP_ADD_ADDR_PORT,
 	MPTCP_RM_ADDR_SIGNAL,
 };
 
@@ -762,16 +760,6 @@ static inline bool mptcp_pm_should_add_signal_echo(struct mptcp_sock *msk)
 	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_ADD_ADDR_ECHO);
 }
 
-static inline bool mptcp_pm_should_add_signal_ipv6(struct mptcp_sock *msk)
-{
-	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_ADD_ADDR_IPV6);
-}
-
-static inline bool mptcp_pm_should_add_signal_port(struct mptcp_sock *msk)
-{
-	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_ADD_ADDR_PORT);
-}
-
 static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL);
-- 
2.33.0

