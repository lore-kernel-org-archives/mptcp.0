Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81451F5437
	for <mptcp@lists.linux.dev>; Sat,  5 Jul 2025 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751700308; cv=none; b=MQ5ZygIADnzx9Yhc2c6rEy1wuUFJUzsYx7n7aTiWpuCvqH2khbR3dmz9+zF47onuWMBMugYynNvP75TCO1k+fPN6t/D8l63XWGTr4+yaYafGI3NsuPg41vdLrgD/qJrjI3kzVJ9jYlSrhMQm8Hm+gO9ORQBcg7hDaBocEHhiwWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751700308; c=relaxed/simple;
	bh=vhbvzGIYvhzcP6qUzmEz3xWJbnbOm8rty53rfPySuYE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=hulBpsMs4e85GFQ2+s3VfquZWnjeOIo4z3KfNOqdKeCO2CwDWlGX+uykk4ImWmOB3VIVjip3Pd6AyLdfQMM9sxEa3R+MqtL3eTkW0ViVy7HebtuBzF7CtuIXKtuGCpVY/fYkbH8fb/ZnFP7xB+6Ias8VO2WiviPlRb9E3bg/sc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GpmGbtfj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpmGbtfj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751700305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1cyhGHEe+VQG6AFV5nE7OVzIwdDh8dvFRQuofcRk90=;
	b=GpmGbtfjPygT2r7mH8T6Svp0DsxN2x7HzodTGcSQTuo6fOOdCwixfWCKCRVn0KU3pUizrg
	soeaML4m4QxmoB5Xwzuh0XQ/OsnF7+ZR38Bt+k14aOzBkR6F1p13bXG8yWnkQyO2UypGf0
	rPnbBE8sP2i3r/DHzl6yrA4+l4YfCeI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-IGZ4gWDlNl26fUUEVKuPXw-1; Sat,
 05 Jul 2025 03:25:04 -0400
X-MC-Unique: IGZ4gWDlNl26fUUEVKuPXw-1
X-Mimecast-MFC-AGG-ID: IGZ4gWDlNl26fUUEVKuPXw_1751700302
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A435180029F
	for <mptcp@lists.linux.dev>; Sat,  5 Jul 2025 07:25:02 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AD935195608F
	for <mptcp@lists.linux.dev>; Sat,  5 Jul 2025 07:25:01 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 4/5] mptcp: track fallbacks accurately via mibs
Date: Sat,  5 Jul 2025 09:24:48 +0200
Message-ID: <5a78b3e0fc95d2f6356ff4754ec3bdf1dcf6b2cc.1751700000.git.pabeni@redhat.com>
In-Reply-To: <cover.1751699999.git.pabeni@redhat.com>
References: <cover.1751699999.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JlxVx-_69R0Wl2ikV2QXodCsu7xfDeKTsvXPKkKw0Q8_1751700302
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add the mibs required to cover the few possible fallback causes still
lacking suck info.

Move the relevant mib increment into the fallback helper, so that no
eventual future fallback operation will miss a paired mib increment.

Additionally track failed fallback via its own mib.

While at the above, rename an existing helper to reduce long lines
problems all along.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
still a couple of long lines I could not trim
---
 net/mptcp/ctrl.c     |  4 ++--
 net/mptcp/mib.c      |  5 +++++
 net/mptcp/mib.h      |  7 +++++++
 net/mptcp/options.c  |  2 +-
 net/mptcp/protocol.c | 44 ++++++++++++++++++++++++++++++--------------
 net/mptcp/protocol.h | 31 ++++++++-----------------------
 net/mptcp/subflow.c  | 10 ++++------
 7 files changed, 57 insertions(+), 46 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index d9290c5bb6c7..fed40dae5583 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -533,9 +533,9 @@ void mptcp_active_detect_blackhole(struct sock *ssk, bool expired)
 	to_max = mptcp_get_pernet(net)->syn_retrans_before_tcp_fallback;
 
 	if (timeouts == to_max || (timeouts < to_max && expired)) {
-		MPTCP_INC_STATS(net, MPTCP_MIB_MPCAPABLEACTIVEDROP);
 		subflow->mpc_drop = 1;
-		mptcp_subflow_early_fallback(mptcp_sk(subflow->conn), subflow);
+		mptcp_early_fallback(mptcp_sk(subflow->conn), subflow,
+				     MPTCP_MIB_MPCAPABLEACTIVEDROP);
 	}
 }
 
diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 0c24545f0e8d..064f5eaf0595 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -80,6 +80,11 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("RcvWndConflict", MPTCP_MIB_RCVWNDCONFLICT),
 	SNMP_MIB_ITEM("MPCurrEstab", MPTCP_MIB_CURRESTAB),
 	SNMP_MIB_ITEM("Blackhole", MPTCP_MIB_BLACKHOLE),
+	SNMP_MIB_ITEM("DataFallback", MPTCP_MIB_DATA_FALLBACK),
+	SNMP_MIB_ITEM("MD5sumFallback", MPTCP_MIB_MD5SUM_FALLBACK),
+	SNMP_MIB_ITEM("DssFallback", MPTCP_MIB_DSS_FALLBACK),
+	SNMP_MIB_ITEM("SimultFallback", MPTCP_MIB_SIMULT_FALLBACK),
+	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACK_FAILED),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 250c6b77977e..99c8788694c3 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -81,6 +81,13 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_RCVWNDCONFLICT,	/* Conflict with while updating msk rcv wnd */
 	MPTCP_MIB_CURRESTAB,		/* Current established MPTCP connections */
 	MPTCP_MIB_BLACKHOLE,		/* A blackhole has been detected */
+	MPTCP_MIB_DATA_FALLBACK,	/* Missing DSS/MPC+data on first
+					 * established packet
+					 */
+	MPTCP_MIB_MD5SUM_FALLBACK,	/* Conflicting TCP option enabled */
+	MPTCP_MIB_DSS_FALLBACK,		/* Bad or missing DSS */
+	MPTCP_MIB_SIMULT_FALLBACK,	/* Simultaneous connect */
+	MPTCP_MIB_FALLBACK_FAILED,	/* Can't fallback due to msk status */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4680d980e605..c9e1f3ec3772 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -978,7 +978,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		if (subflow->mp_join)
 			goto reset;
 		subflow->mp_capable = 0;
-		if (mptcp_do_fallback(ssk))
+		if (mptcp_do_fallback(ssk, MPTCP_MIB_DATA_FALLBACK))
 			goto reset;
 		pr_fallback(msk);
 		return false;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0dc55a17f274..5f99f02c827c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -67,6 +67,27 @@ static const struct proto_ops *mptcp_fallback_tcp_ops(const struct sock *sk)
 	return &inet_stream_ops;
 }
 
+bool __mptcp_do_fallback(struct mptcp_sock *msk, int fb_mib)
+{
+	struct net *net = sock_net((struct sock *)msk);
+
+	if (__mptcp_check_fallback(msk))
+		return true;
+
+	spin_lock_bh(&msk->fallback_lock);
+	if (!msk->allow_infinite_fallback) {
+		__MPTCP_INC_STATS(net, MPTCP_MIB_SIMULT_FALLBACK);
+		spin_unlock_bh(&msk->fallback_lock);
+		return false;
+	}
+
+	msk->allow_subflows = false;
+	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
+	__MPTCP_INC_STATS(net, fb_mib);
+	spin_unlock_bh(&msk->fallback_lock);
+	return true;
+}
+
 static int __mptcp_socket_create(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
@@ -560,10 +581,7 @@ static bool mptcp_check_data_fin(struct sock *sk)
 
 static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
 {
-	if (mptcp_do_fallback(ssk)) {
-		MPTCP_INC_STATS(sock_net(ssk),
-				MPTCP_MIB_DSSCORRUPTIONFALLBACK);
-	} else {
+	if (!mptcp_do_fallback(ssk, MPTCP_MIB_DSSCORRUPTIONFALLBACK)) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCORRUPTIONRESET);
 		mptcp_subflow_reset(ssk);
 	}
@@ -1142,12 +1160,11 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk,
 	mpext->infinite_map = 1;
 	mpext->data_len = 0;
 
-	if (!mptcp_do_fallback(ssk)) {
+	if (!mptcp_do_fallback(ssk, MPTCP_MIB_INFINITEMAPTX)) {
 		mptcp_subflow_reset(ssk);
 		return;
 	}
 
-	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPTX);
 	mptcp_subflow_ctx(ssk)->send_infinite_map = 0;
 	pr_fallback(msk);
 }
@@ -3717,16 +3734,15 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	 * TCP option space.
 	 */
 	if (rcu_access_pointer(tcp_sk(ssk)->md5sig_info))
-		mptcp_subflow_early_fallback(msk, subflow);
+		mptcp_early_fallback(msk, subflow, MPTCP_MIB_MD5SUM_FALLBACK);
 #endif
 	if (subflow->request_mptcp) {
-		if (mptcp_active_should_disable(sk)) {
-			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPCAPABLEACTIVEDISABLED);
-			mptcp_subflow_early_fallback(msk, subflow);
-		} else if (mptcp_token_new_connect(ssk) < 0) {
-			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_TOKENFALLBACKINIT);
-			mptcp_subflow_early_fallback(msk, subflow);
-		}
+		if (mptcp_active_should_disable(sk))
+			mptcp_early_fallback(msk, subflow,
+					    MPTCP_MIB_MPCAPABLEACTIVEDISABLED);
+		else if (mptcp_token_new_connect(ssk) < 0)
+			mptcp_early_fallback(msk, subflow,
+					     MPTCP_MIB_TOKENFALLBACKINIT);
 	}
 
 	WRITE_ONCE(msk->write_seq, subflow->idsn);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 34c0863f1eae..ceb2f2ba2cc7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1220,24 +1220,6 @@ static inline bool mptcp_check_fallback(const struct sock *sk)
 	return __mptcp_check_fallback(msk);
 }
 
-static inline bool __mptcp_do_fallback(struct mptcp_sock *msk)
-{
-	if (__mptcp_check_fallback(msk)) {
-		pr_debug("TCP fallback already done (msk=%p)\n", msk);
-		return true;
-	}
-	spin_lock_bh(&msk->fallback_lock);
-	if (!msk->allow_infinite_fallback) {
-		spin_unlock_bh(&msk->fallback_lock);
-		return false;
-	}
-
-	msk->allow_subflows = false;
-	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
-	spin_unlock_bh(&msk->fallback_lock);
-	return true;
-}
-
 static inline bool __mptcp_has_initial_subflow(const struct mptcp_sock *msk)
 {
 	struct sock *ssk = READ_ONCE(msk->first);
@@ -1247,14 +1229,16 @@ static inline bool __mptcp_has_initial_subflow(const struct mptcp_sock *msk)
 			TCPF_SYN_RECV | TCPF_LISTEN));
 }
 
-static inline bool mptcp_do_fallback(struct sock *ssk)
+bool __mptcp_do_fallback(struct mptcp_sock *msk, int fb_mib);
+
+static inline bool mptcp_do_fallback(struct sock *ssk, int fb_mib)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = subflow->conn;
 	struct mptcp_sock *msk;
 
 	msk = mptcp_sk(sk);
-	if (!__mptcp_do_fallback(msk))
+	if (!__mptcp_do_fallback(msk, fb_mib))
 		return false;
 	if (READ_ONCE(msk->snd_data_fin_enable) && !(ssk->sk_shutdown & SEND_SHUTDOWN)) {
 		gfp_t saved_allocation = ssk->sk_allocation;
@@ -1272,12 +1256,13 @@ static inline bool mptcp_do_fallback(struct sock *ssk)
 
 #define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)\n", __func__, a)
 
-static inline void mptcp_subflow_early_fallback(struct mptcp_sock *msk,
-						struct mptcp_subflow_context *subflow)
+static inline void mptcp_early_fallback(struct mptcp_sock *msk,
+					struct mptcp_subflow_context *subflow,
+					int fb_mib)
 {
 	pr_fallback(msk);
 	subflow->request_mptcp = 0;
-	__mptcp_do_fallback(msk);
+	__mptcp_do_fallback(msk, fb_mib);
 }
 
 static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 11c5b042c2e1..e140d032eb3e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -544,11 +544,10 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	mptcp_get_options(skb, &mp_opt);
 	if (subflow->request_mptcp) {
 		if (!(mp_opt.suboptions & OPTION_MPTCP_MPC_SYNACK)) {
-			if (!mptcp_do_fallback(sk))
+			if (!mptcp_do_fallback(sk,
+					    MPTCP_MIB_MPCAPABLEACTIVEFALLBACK))
 				goto do_reset;
 
-			MPTCP_INC_STATS(sock_net(sk),
-					MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
 			pr_fallback(msk);
 			goto fallback;
 		}
@@ -1406,7 +1405,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			return true;
 		}
 
-		if (!mptcp_do_fallback(ssk)) {
+		if (!mptcp_do_fallback(ssk, MPTCP_MIB_DSS_FALLBACK)) {
 			/* fatal protocol error, close the socket.
 			 * subflow_error_report() will introduce the appropriate barriers
 			 */
@@ -1424,7 +1423,6 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			WRITE_ONCE(subflow->data_avail, false);
 			return false;
 		}
-
 	}
 
 	skb = skb_peek(&ssk->sk_receive_queue);
@@ -1860,7 +1858,7 @@ static void subflow_state_change(struct sock *sk)
 
 	msk = mptcp_sk(parent);
 	if (subflow_simultaneous_connect(sk)) {
-		mptcp_do_fallback(sk);
+		mptcp_do_fallback(sk, MPTCP_MIB_SIMULT_FALLBACK);
 		pr_fallback(msk);
 		subflow->conn_finished = 1;
 		mptcp_propagate_state(parent, sk, subflow, NULL);
-- 
2.49.0

