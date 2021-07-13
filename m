Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B8172
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 21:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1626210838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BVYyGYCTLXzEHq+qZPVQEkwb+u+QVFckL2SpzMLcKk0=;
	b=Lha83kOZftT4GUTHD+4piC0UFbSMe77NAqdXjXBK+6nb65DViZt2pWs43OKWguHZ21+Fsr
	KHDUm2g5mVeYNalWcg4NaZfF97/jdeRSKHAanGt5JcRH+ZqJ7eYy3mHDbZ2K9+44A8gupi
	M6iu/0mbVHj9BLvH4/22/Xd9ZnmWoPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-u-U2jf_eO-KncsGcB61bcw-1; Tue, 13 Jul 2021 17:13:57 -0400
X-MC-Unique: u-U2jf_eO-KncsGcB61bcw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12C9F100B3AC
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 21:13:56 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-113-114.ams2.redhat.com [10.36.113.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 73E0560C5F
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 21:13:55 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 5/8] mptcp: faster active backup recovery
Date: Tue, 13 Jul 2021 23:13:35 +0200
Message-Id: <3f5c7f52467c1bee161388688305b8911aaa8d8a.1626210682.git.pabeni@redhat.com>
In-Reply-To: <cover.1626210682.git.pabeni@redhat.com>
References: <cover.1626210682.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
v1 -> v2:
 - moved stale_loss_cnt definition in mptcp_pernet
 - added sysctl documentation
---
 Documentation/networking/mptcp-sysctl.rst | 12 ++++++++
 net/mptcp/ctrl.c                          | 14 +++++++++
 net/mptcp/pm.c                            |  2 ++
 net/mptcp/pm_netlink.c                    | 36 +++++++++++++++++++++++
 net/mptcp/protocol.c                      | 27 +++++++++++++++--
 net/mptcp/protocol.h                      | 12 ++++++--
 6 files changed, 98 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 76d939e688b8..45fa8b2aefa8 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -45,3 +45,15 @@ allow_join_initial_addr_port - BOOLEAN
 	This is a per-namespace sysctl.
 
 	Default: 1
+
+stale_loss_cnt - INTEGER
+        The number of MPTCP-level retransmission intervals with no traffic and
+        pending outstanding data on a given subflow required to declare it stale.
+        The packet scheduler ignores stale subflows.
+        A low stale_loss_cnt  value allows for fast active-backup switch-over,
+        an high value maximixe links utilization on edge scenarios e.g. lossy
+        link with high BER or peer pausing the data processing.
+
+	This is a per-namespace sysctl.
+
+	Default: 4
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 63bba9d8e289..8b235468c88f 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -22,6 +22,7 @@ struct mptcp_pernet {
 #endif
 
 	unsigned int add_addr_timeout;
+	unsigned int stale_loss_cnt;
 	u8 mptcp_enabled;
 	u8 checksum_enabled;
 	u8 allow_join_initial_addr_port;
@@ -52,12 +53,18 @@ int mptcp_allow_join_id0(const struct net *net)
 	return mptcp_get_pernet(net)->allow_join_initial_addr_port;
 }
 
+unsigned int mptcp_stale_loss_cnt(const struct net *net)
+{
+	return mptcp_get_pernet(net)->stale_loss_cnt;
+}
+
 static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled = 1;
 	pernet->add_addr_timeout = TCP_RTO_MAX;
 	pernet->checksum_enabled = 0;
 	pernet->allow_join_initial_addr_port = 1;
+	pernet->stale_loss_cnt = 4;
 }
 
 #ifdef CONFIG_SYSCTL
@@ -95,6 +102,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.extra1       = SYSCTL_ZERO,
 		.extra2       = SYSCTL_ONE
 	},
+	{
+		.procname = "stale_loss_cnt",
+		.maxlen = sizeof(unsigned int),
+		.mode = 0644,
+		.proc_handler = proc_douintvec_minmax,
+	},
 	{}
 };
 
@@ -114,6 +127,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[1].data = &pernet->add_addr_timeout;
 	table[2].data = &pernet->checksum_enabled;
 	table[3].data = &pernet->allow_join_initial_addr_port;
+	table[4].data = &pernet->stale_loss_cnt;
 
 	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
 	if (!hdr)
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
index d2591ebf01d9..eb1f5cf89423 100644
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
@@ -900,6 +901,40 @@ static const struct nla_policy mptcp_pm_policy[MPTCP_PM_ATTR_MAX + 1] = {
 	[MPTCP_PM_ATTR_SUBFLOWS]	= { .type	= NLA_U32,	},
 };
 
+void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
+{
+	struct mptcp_subflow_context *iter, *subflow = mptcp_subflow_ctx(ssk);
+	struct sock *sk = (struct sock *)msk;
+	unsigned int active_max_loss_cnt;
+	struct net *net = sock_net(sk);
+	unsigned int stale_loss_cnt;
+	bool slow, push;
+
+	stale_loss_cnt = mptcp_stale_loss_cnt(net);
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
+				push = __mptcp_retransmit_pending_data(sk);
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
@@ -1923,6 +1958,7 @@ static int __net_init pm_nl_init_net(struct net *net)
 
 	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
 	pernet->next_id = 1;
+	pernet->stale_loss_cnt = 4;
 	spin_lock_init(&pernet->lock);
 
 	/* No need to initialize other pernet fields, the struct is zeroed at
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7fe4c17fb4f5..e936b88d340d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1391,6 +1391,27 @@ struct subflow_send_info {
 	u64 ratio;
 };
 
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
@@ -1472,7 +1493,7 @@ static void mptcp_push_release(struct sock *sk, struct sock *ssk,
 	release_sock(ssk);
 }
 
-static void __mptcp_push_pending(struct sock *sk, unsigned int flags)
+void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
 	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -2115,7 +2136,7 @@ static void mptcp_timeout_timer(struct timer_list *t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-static struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
+static struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 {
 	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
@@ -2129,7 +2150,7 @@ static struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-		if (!mptcp_subflow_active(subflow))
+		if (!__mptcp_subflow_active(subflow))
 			continue;
 
 		/* still data outstanding at TCP level? skip this */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 43ff6c5baddc..8bdd038def38 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -432,7 +432,8 @@ struct mptcp_subflow_context {
 		send_mp_prio : 1,
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
-		disposable : 1;	    /* ctx can be free at ulp release time */
+		disposable : 1,	    /* ctx can be free at ulp release time */
+		stale : 1;	    /* unable to snd/rcv data, do not use for xmit */
 	enum mptcp_data_avail data_avail;
 	u32	remote_nonce;
 	u64	thmac;
@@ -560,9 +561,11 @@ int mptcp_is_enabled(const struct net *net);
 unsigned int mptcp_get_add_addr_timeout(const struct net *net);
 int mptcp_is_checksum_enabled(const struct net *net);
 int mptcp_allow_join_id0(const struct net *net);
+unsigned int mptcp_stale_loss_cnt(const struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool __mptcp_retransmit_pending_data(struct sock *sk);
+void __mptcp_push_pending(struct sock *sk, unsigned int flags);
 bool mptcp_subflow_data_available(struct sock *sk);
 void __init mptcp_subflow_init(void);
 void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how);
@@ -581,7 +584,7 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 			 struct sockaddr_storage *addr,
 			 unsigned short family);
 
-static inline bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
+static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
 {
 	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -593,6 +596,10 @@ static inline bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
 	return ((1 << ssk->sk_state) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT));
 }
 
+void mptcp_subflow_set_active(struct mptcp_subflow_context *subflow);
+
+bool mptcp_subflow_active(struct mptcp_subflow_context *subflow);
+
 static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
 					      struct mptcp_subflow_context *ctx)
 {
@@ -699,6 +706,7 @@ void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u8 *msg, int len, void *hmac);
 void __init mptcp_pm_init(void);
 void mptcp_pm_data_init(struct mptcp_sock *msk);
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
+void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int server_side);
 void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk, gfp_t gfp);
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);
-- 
2.26.3

