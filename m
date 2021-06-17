Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.228])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B2670
	for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 09:15:05 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.48:35304.1563350684
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9?logid-5115ca8f26c14b9a91d0dcf6ea180cd4 (unknown [172.18.0.48])
	by chinatelecom.cn (HERMES) with SMTP id 042BB2800E8;
	Thu, 17 Jun 2021 17:15:06 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([172.18.0.48])
	by app0024 with ESMTP id bff8cccb66654aa3b319f290cee68882 for mptcp@lists.linux.dev;
	Thu Jun 17 17:15:05 2021
X-Transaction-ID: bff8cccb66654aa3b319f290cee68882
X-filter-score:  filter<0>
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
From: Yonglong Li <liyonglong@chinatelecom.cn>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mathew.j.martineau@linux.intel.com,
	geliangtang@gmail.com,
	Yonglong Li <liyonglong@chinatelecom.cn>
Subject: [PATCH v3 4/4] mptcp: remove MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT
Date: Thu, 17 Jun 2021 17:14:36 +0800
Message-Id: <1623921276-97178-5-git-send-email-liyonglong@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1623921276-97178-1-git-send-email-liyonglong@chinatelecom.cn>
References: <1623921276-97178-1-git-send-email-liyonglong@chinatelecom.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

there not need MPTCP_ADD_ADDR_PORT and MPTCP_ADD_ADDR_PORT, we can
get these info from pm.addr or pm.remote

Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
---
 net/mptcp/pm.c         |  4 ----
 net/mptcp/pm_netlink.c |  6 ++----
 net/mptcp/protocol.h   | 12 ------------
 3 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index a62d4a5..f051e48 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -35,10 +35,6 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
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
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0f302d2..bfa9d6d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -543,10 +543,8 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
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
index 90fb532..71e747c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -176,8 +176,6 @@ enum mptcp_pm_status {
 enum mptcp_addr_signal_status {
 	MPTCP_ADD_ADDR_SIGNAL,
 	MPTCP_ADD_ADDR_ECHO,
-	MPTCP_ADD_ADDR_IPV6,
-	MPTCP_ADD_ADDR_PORT,
 	MPTCP_RM_ADDR_SIGNAL,
 };
 
@@ -723,16 +721,6 @@ static inline bool mptcp_pm_should_add_signal_echo(struct mptcp_sock *msk)
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
1.8.3.1

