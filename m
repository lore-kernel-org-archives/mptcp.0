Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF467A
	for <mptcp@lists.linux.dev>; Fri, 25 Feb 2022 09:01:34 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.188:59116.1625256782
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9 (unknown [172.18.0.188])
	by chinatelecom.cn (HERMES) with SMTP id 049BB2800DF;
	Fri, 25 Feb 2022 16:53:59 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([172.18.0.188])
	by app0023 with ESMTP id abdff6f5ae484c348652c149af82ca1f for mptcp@lists.linux.dev;
	Fri, 25 Feb 2022 16:53:59 CST
X-Transaction-ID: abdff6f5ae484c348652c149af82ca1f
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.188
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
From: Yonglong Li <liyonglong@chinatelecom.cn>
To: mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net,
	Yonglong Li <liyonglong@chinatelecom.cn>
Subject: [PATCH] mptcp: send ADD_ADDR echo before create subflows
Date: Fri, 25 Feb 2022 16:53:53 +0800
Message-Id: <1645779233-19742-1-git-send-email-liyonglong@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

In some corner case, It may receive ADD_ADDR retransmit package
before created subflows done.
It's more reasonable to send ADD_ADDR echo before creating subflows.

Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
---
 net/mptcp/pm_netlink.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e3b0384..c1f4bef 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -650,7 +650,6 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	unsigned int add_addr_accept_max;
 	struct mptcp_addr_info remote;
 	unsigned int subflows_max;
-	bool reset_port = false;
 	int i, nr;
 
 	add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
@@ -661,14 +660,15 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 		 msk->pm.remote.family);
 
 	remote = msk->pm.remote;
+	mptcp_pm_announce_addr(msk, &remote, true);
+	mptcp_pm_nl_addr_send_ack(msk);
+
 	if (lookup_subflow_by_daddr(&msk->conn_list, &remote))
-		goto add_addr_echo;
+		return;
 
 	/* pick id 0 port, if none is provided the remote address */
-	if (!remote.port) {
-		reset_port = true;
+	if (!remote.port)
 		remote.port = sk->sk_dport;
-	}
 
 	/* connect to the specified remote address, using whatever
 	 * local address the routing configuration will pick.
@@ -684,14 +684,6 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	for (i = 0; i < nr; i++)
 		__mptcp_subflow_connect(sk, &addrs[i], &remote);
 	spin_lock_bh(&msk->pm.lock);
-
-	/* be sure to echo exactly the received address */
-	if (reset_port)
-		remote.port = 0;
-
-add_addr_echo:
-	mptcp_pm_announce_addr(msk, &remote, true);
-	mptcp_pm_nl_addr_send_ack(msk);
 }
 
 void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
-- 
1.8.3.1

