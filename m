Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202FE70
	for <mptcp@lists.linux.dev>; Mon, 28 Jun 2021 16:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1624896442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AXaWSLHIrje9VumwqejMkjpta0U9YWCTjg2dQaaV2rs=;
	b=czzldZIqXdhqyeuB4Qu0WMaRIFtkBaydqfHDgmSaLqDaSbDhKsdeWmxjAw4fzYAh5tAIu+
	c3pWfAm8RxFHxDqNzyrnJ+urczOrkN8iiT9lTLggypdUX9opOrnWZe5xvh+buEo7XIr037
	wtdpDhm/oOPa1KIqIF1G07osbE/2ejg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-f0Vl6Lr6N6W5-Upc_zMDLA-1; Mon, 28 Jun 2021 12:05:57 -0400
X-MC-Unique: f0Vl6Lr6N6W5-Upc_zMDLA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05B99C73B4
	for <mptcp@lists.linux.dev>; Mon, 28 Jun 2021 15:54:30 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-129.ams2.redhat.com [10.36.114.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 42C6D60875;
	Mon, 28 Jun 2021 15:54:29 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: fwestpha@redhat.com
Subject: [PATCH mptcp-next 4/7] mptcp: faster active backup recovery
Date: Mon, 28 Jun 2021 17:54:08 +0200
Message-Id: <c6388b0440bdfc08de13898a90e66cda5f27bf21.1624895054.git.pabeni@redhat.com>
In-Reply-To: <cover.1624895054.git.pabeni@redhat.com>
References: <cover.1624895054.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

the msk can use backup subflows to transmit in-sequence data
only if there are no other active subflow. On active backup
scenario, the MPTCP connection can do forward progress only
due to MPTCP retransmissions - rtx can pick backup subflows.

This patch introduces a new flag flow MPTCP subflows: if the
underlaying TCP connection made no progresses for long time,
and there are other less problematic subflows available, the
given subflow become stale.

Stale subflows are not considered active: if all non backup
subflows become stale, the MPTCP scheduler can pick backup
subflows for plain transmissions.

Stale subflows can return in active state, as soon as any reply
from the peer is observed.

Active backup scenarios can now leverage the available b/w
with no restrinction.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/207
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm.c         |  2 ++
 net/mptcp/pm_netlink.c | 39 +++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c   | 27 ++++++++++++++++++++++++---
 net/mptcp/protocol.h   | 11 +++++++++--
 4 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 9ff17c5205ce..d8a85fe92360 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -320,8 +320,10 @@ void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 	} else if (subflow->stale_rcv_tstamp == rcv_tstamp) {
 		if (subflow->stale_count < U8_MAX)
 			subflow->stale_count++;
+		mptcp_pm_nl_subflow_chk_stale(msk, ssk);
 	} else {
 		subflow->stale_count = 0;
+		mptcp_subflow_set_active(subflow);
 	}
 }
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d2591ebf01d9..d93e5f73b5cb 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -47,6 +47,7 @@ struct pm_nl_pernet {
 	spinlock_t		lock;
 	struct list_head	local_addr_list;
 	unsigned int		addrs;
+	unsigned int		stale_loss_cnt;
 	unsigned int		add_addr_signal_max;
 	unsigned int		add_addr_accept_max;
 	unsigned int		local_addr_max;
@@ -900,6 +901,43 @@ static const struct nla_policy mptcp_pm_policy[MPTCP_PM_ATTR_MAX + 1] = {
 	[MPTCP_PM_ATTR_SUBFLOWS]	= { .type	= NLA_U32,	},
 };
 
+void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
+{
+	struct mptcp_subflow_context *iter, *subflow = mptcp_subflow_ctx(ssk);
+	struct sock *sk = (struct sock *)msk;
+	unsigned int active_max_loss_cnt;
+	struct net *net = sock_net(sk);
+	struct pm_nl_pernet *pernet;
+	unsigned int stale_loss_cnt;
+	bool slow, push;
+
+	pernet = net_generic(net, pm_nl_pernet_id);
+	stale_loss_cnt = READ_ONCE(pernet->stale_loss_cnt);
+
+	if (subflow->stale || !stale_loss_cnt || subflow->stale_count <= stale_loss_cnt)
+		return;
+
+	/* look for another available subflow not in loss state */
+	active_max_loss_cnt = max_t(int, stale_loss_cnt - 1, 1);
+	mptcp_for_each_subflow(msk, iter) {
+		if (iter != subflow && mptcp_subflow_active(iter) &&
+		    iter->stale_count < active_max_loss_cnt) {
+			/* we have some alteratives, try to mark this subflow as idle ...*/
+			slow = lock_sock_fast(ssk);
+			if (!tcp_rtx_and_write_queues_empty(ssk)) {
+				subflow->stale = 1;
+				push = __mptcp_retransmit_pending_data(sk, ssk);
+			}
+			unlock_sock_fast(ssk, slow);
+
+			/* pending data on the idle subflow: retransmit */
+			if (push)
+				__mptcp_push_pending(sk, 0);
+			return;
+		}
+	}
+}
+
 static int mptcp_pm_family_to_addr(int family)
 {
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -1923,6 +1961,7 @@ static int __net_init pm_nl_init_net(struct net *net)
 
 	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
 	pernet->next_id = 1;
+	pernet->stale_loss_cnt = 4;
 	spin_lock_init(&pernet->lock);
 
 	/* No need to initialize other pernet fields, the struct is zeroed at
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b0a7eba202fc..fc41e4a59b8f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1365,6 +1365,27 @@ static long mptcp_timeout_from_ssk(const struct sock *ssk)
 	return inet_csk(ssk)->icsk_pending ? inet_csk(ssk)->icsk_timeout - jiffies : 0;
 }
 
+void mptcp_subflow_set_active(struct mptcp_subflow_context *subflow)
+{
+	if (!subflow->stale)
+		return;
+
+	subflow->stale = 0;
+}
+
+bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
+{
+	if (unlikely(subflow->stale)) {
+		u32 rcv_tstamp = READ_ONCE(tcp_sk(mptcp_subflow_tcp_sock(subflow))->rcv_tstamp);
+
+		if (subflow->stale_rcv_tstamp == rcv_tstamp)
+			return false;
+
+		mptcp_subflow_set_active(subflow);
+	}
+	return __mptcp_subflow_active(subflow);
+}
+
 /* implement the mptcp packet scheduler;
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
@@ -1445,7 +1466,7 @@ static void mptcp_push_release(struct sock *sk, struct sock *ssk,
 	release_sock(ssk);
 }
 
-static void __mptcp_push_pending(struct sock *sk, unsigned int flags)
+void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
 	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -2089,7 +2110,7 @@ static void mptcp_timeout_timer(struct timer_list *t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-static struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
+static struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 {
 	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
@@ -2103,7 +2124,7 @@ static struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-		if (!mptcp_subflow_active(subflow))
+		if (!__mptcp_subflow_active(subflow))
 			continue;
 
 		/* still data outstanding at TCP level? skip this */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0218b777cdc3..6cc9059c6a40 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -429,7 +429,8 @@ struct mptcp_subflow_context {
 		send_mp_prio : 1,
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
-		disposable : 1;	    /* ctx can be free at ulp release time */
+		disposable : 1,	    /* ctx can be free at ulp release time */
+		stale : 1;	    /* unable to snd/rcv data, do not use for xmit */
 	enum mptcp_data_avail data_avail;
 	u32	remote_nonce;
 	u64	thmac;
@@ -560,6 +561,7 @@ int mptcp_allow_join_id0(struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool __mptcp_retransmit_pending_data(struct sock *sk, const struct sock *ssk);
+void __mptcp_push_pending(struct sock *sk, unsigned int flags);
 bool mptcp_subflow_data_available(struct sock *sk);
 void __init mptcp_subflow_init(void);
 void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how);
@@ -578,7 +580,7 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 			 struct sockaddr_storage *addr,
 			 unsigned short family);
 
-static inline bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
+static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
 {
 	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -590,6 +592,10 @@ static inline bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
 	return ((1 << ssk->sk_state) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT));
 }
 
+void mptcp_subflow_set_active(struct mptcp_subflow_context *subflow);
+
+bool mptcp_subflow_active(struct mptcp_subflow_context *subflow);
+
 static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
 					      struct mptcp_subflow_context *ctx)
 {
@@ -696,6 +702,7 @@ void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u8 *msg, int len, void *hmac);
 void __init mptcp_pm_init(void);
 void mptcp_pm_data_init(struct mptcp_sock *msk);
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
+void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int server_side);
 void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk, gfp_t gfp);
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);
-- 
2.26.3

