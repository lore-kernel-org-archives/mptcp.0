Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.227])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1EB70
	for <mptcp@lists.linux.dev>; Wed,  9 Jun 2021 06:35:05 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.218:57970.1169011320
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9?logid-c13bce74b0324c29aa46b36870331201 (unknown [172.18.0.218])
	by chinatelecom.cn (HERMES) with SMTP id 3E05E28010F;
	Wed,  9 Jun 2021 14:24:52 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([172.18.0.218])
	by app0025 with ESMTP id c13bce74b0324c29aa46b36870331201 for mptcp@lists.linux.dev;
	Wed Jun  9 14:24:52 2021
X-Transaction-ID: c13bce74b0324c29aa46b36870331201
X-filter-score:  filter<0>
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.218
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
From: Yonglong Li <liyonglong@chinatelecom.cn>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mathew.j.martineau@linux.intel.com,
	geliangtang@gmail.com,
	Yonglong Li <liyonglong@chinatelecom.cn>
Subject: [PATCH] mptcp: use icsk_rto of first subflow as ADD_ADDR timeout value
Date: Wed,  9 Jun 2021 14:24:46 +0800
Message-Id: <1623219886-69610-1-git-send-email-liyonglong@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

ADD_ADDR is sent on first subflow, so we can use icsk_rto of first
subflow as ADD_ADDR retransmission timeout value.

Change sysctl add_addr_timeout type to millsecond and default value
to TCP_RTO_MIN.

Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
---
 net/mptcp/ctrl.c       | 13 +++++++++----
 net/mptcp/pm_netlink.c |  5 +++--
 net/mptcp/protocol.h   |  2 +-
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 6c2639b..40e8579 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -36,9 +36,14 @@ int mptcp_is_enabled(struct net *net)
 	return mptcp_get_pernet(net)->mptcp_enabled;
 }
 
-unsigned int mptcp_get_add_addr_timeout(struct net *net)
+unsigned int mptcp_get_add_addr_timeout(struct net *net, struct mptcp_sock *msk)
 {
-	return mptcp_get_pernet(net)->add_addr_timeout;
+	unsigned int timeout = mptcp_get_pernet(net)->add_addr_timeout;
+
+	if (msk->first && inet_csk(msk->first)->icsk_rto)
+		timeout = inet_csk(msk->first)->icsk_rto;
+
+	return timeout;
 }
 
 int mptcp_is_checksum_enabled(struct net *net)
@@ -49,7 +54,7 @@ int mptcp_is_checksum_enabled(struct net *net)
 static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled = 1;
-	pernet->add_addr_timeout = TCP_RTO_MAX;
+	pernet->add_addr_timeout = TCP_RTO_MIN;
 	pernet->checksum_enabled = 0;
 }
 
@@ -70,7 +75,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 		.procname = "add_addr_timeout",
 		.maxlen = sizeof(unsigned int),
 		.mode = 0644,
-		.proc_handler = proc_dointvec_jiffies,
+		.proc_handler = proc_dointvec_ms_jiffies,
 	},
 	{
 		.procname = "checksum_enabled",
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d4732a4..c53e500 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -333,7 +333,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
 		sk_reset_timer(sk, timer,
-			       jiffies + mptcp_get_add_addr_timeout(sock_net(sk)));
+			       jiffies + mptcp_get_add_addr_timeout(sock_net(sk), msk));
 
 	spin_unlock_bh(&msk->pm.lock);
 
@@ -385,9 +385,10 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry->sock = msk;
 	add_entry->retrans_times = 0;
 
+	pr_debug("msk=%p, timeout:%d", msk, mptcp_get_add_addr_timeout(net, msk));
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
 	sk_reset_timer(sk, &add_entry->add_timer,
-		       jiffies + mptcp_get_add_addr_timeout(net));
+		       jiffies + mptcp_get_add_addr_timeout(net, msk));
 
 	return true;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 160c2ab..6c2322e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -538,7 +538,7 @@ static inline void mptcp_subflow_delegated_done(struct mptcp_subflow_context *su
 }
 
 int mptcp_is_enabled(struct net *net);
-unsigned int mptcp_get_add_addr_timeout(struct net *net);
+unsigned int mptcp_get_add_addr_timeout(struct net *net, struct mptcp_sock *msk);
 int mptcp_is_checksum_enabled(struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
-- 
1.8.3.1

