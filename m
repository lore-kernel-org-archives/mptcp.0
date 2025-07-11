Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD161F3B85
	for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226221; cv=none; b=StZAy9kpwSUYUt+YiLf2y6bkQ7rgvvh7+YbQl3pAXSqe/TDoxBReeQU1WHFUeqdK8AE8HCzg+EJwX5hU9viFilIim+hycknx611ZKaR9OwThVAQMv+Fe8Emwt8j6xYT5NyMbLpVsNV35vEEBFIadCpldVplauczvstu0mDAuouM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226221; c=relaxed/simple;
	bh=B0LfOYgOHZKmSMSk227tGHX8pNO1atEaeF0OACYWX0E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=HsYCcfcu0+qymHJeC72ZdhLdA3rtxONg1JrKbu6PGaSpki68XqTlt9xyvrLyyL9vI7yjpYcWBdXnZBIR9+O6DZR5QsGFdPjrc9kb9zR3zH1TVhpeh2dMwBckTnTj3bocsNjCwj7Q9GQb+Bt6s5rUxtXF/OHXCkpCTviJODjiFDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BEN1roY9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BEN1roY9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752226218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=osDjSeStnKbikc8PMvv7L6surP/E//x2kEv7mMEV6P0=;
	b=BEN1roY9tGQo92ZHBfcReFjInSv8/EqR4J/4ISn6JcNBQKrbJnqrxyodqDyi4vnlfJd00/
	3+DMmI6595I6OS6q01gCiJb/+M5w1Ic1XySW15j4WeD5y3w0WZbJZjUrjFydH+Pl6jcMSD
	P3Rd/48Kiwd2CzzsQ3mrTsTb7luCk5s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-X3W59EysOKWn1zyey7VD5w-1; Fri,
 11 Jul 2025 05:30:17 -0400
X-MC-Unique: X3W59EysOKWn1zyey7VD5w-1
X-Mimecast-MFC-AGG-ID: X3W59EysOKWn1zyey7VD5w_1752226216
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67417180ACC9
	for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 09:29:59 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.145])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8CD6B1800287
	for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 09:29:58 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v4 mptcp-net 4/5] mptcp: track fallbacks accurately via mibs
Date: Fri, 11 Jul 2025 11:29:44 +0200
Message-ID: <d21e61d2b929988ed540f6a2a8dfa90b5c16050a.1752221786.git.pabeni@redhat.com>
In-Reply-To: <cover.1752221786.git.pabeni@redhat.com>
References: <cover.1752221786.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9SZSKocmXYPkw4jsIqFJRxOaAy0JZEIXRS3zFB50H3k_1752226216
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add the mibs required to cover the few possible fallback causes still
lacking suck info.

Move the relevant mib increment into the fallback helper, so that no
eventual future fallback operation will miss a paired mib increment.

Additionally track failed fallback via its own mib, such mib is
incremented only when a fallback mandated by the protocol fails - due
to racing subflow creation.

While at the above, rename an existing helper to reduce long lines
problems all along.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v3 -> v4:
  - let MIB exposed name match the symbolic name

v2 -> v3:
  - a bunch of mibs rename
---
 net/mptcp/ctrl.c     |  4 ++--
 net/mptcp/mib.c      |  5 +++++
 net/mptcp/mib.h      |  7 +++++++
 net/mptcp/options.c  |  4 +++-
 net/mptcp/protocol.c | 44 ++++++++++++++++++++++++++++++--------------
 net/mptcp/protocol.h | 31 ++++++++-----------------------
 net/mptcp/subflow.c  | 12 +++++++-----
 7 files changed, 62 insertions(+), 45 deletions(-)

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
index 0c24545f0e8d..cf879c188ca2 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -80,6 +80,11 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("RcvWndConflict", MPTCP_MIB_RCVWNDCONFLICT),
 	SNMP_MIB_ITEM("MPCurrEstab", MPTCP_MIB_CURRESTAB),
 	SNMP_MIB_ITEM("Blackhole", MPTCP_MIB_BLACKHOLE),
+	SNMP_MIB_ITEM("MPCapableDataFallback", MPTCP_MIB_MPCAPABLEDATAFALLBACK),
+	SNMP_MIB_ITEM("MD5SigFallback", MPTCP_MIB_MD5SIGFALLBACK),
+	SNMP_MIB_ITEM("DssFallback", MPTCP_MIB_DSSFALLBACK),
+	SNMP_MIB_ITEM("SimultConnectFallback", MPTCP_MIB_SIMULTCONNFALLBACK),
+	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACKFAILED),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 250c6b77977e..309bac6fea32 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -81,6 +81,13 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_RCVWNDCONFLICT,	/* Conflict with while updating msk rcv wnd */
 	MPTCP_MIB_CURRESTAB,		/* Current established MPTCP connections */
 	MPTCP_MIB_BLACKHOLE,		/* A blackhole has been detected */
+	MPTCP_MIB_MPCAPABLEDATAFALLBACK,	/* Missing DSS/MPC+data on first
+					 * established packet
+					 */
+	MPTCP_MIB_MD5SIGFALLBACK,	/* Conflicting TCP option enabled */
+	MPTCP_MIB_DSSFALLBACK,		/* Bad or missing DSS */
+	MPTCP_MIB_SIMULTCONNFALLBACK,	/* Simultaneous connect */
+	MPTCP_MIB_FALLBACKFAILED,	/* Can't fallback due to msk status */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 9288a8d1235e..b49a8b3ffe00 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -978,8 +978,10 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		if (subflow->mp_join)
 			goto reset;
 		subflow->mp_capable = 0;
-		if (!mptcp_try_fallback(ssk))
+		if (!mptcp_try_fallback(ssk, MPTCP_MIB_MPCAPABLEDATAFALLBACK)) {
+			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_FALLBACKFAILED);
 			goto reset;
+		}
 		pr_fallback(msk);
 		return false;
 	}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 46bc5cc5a4d7..d4e17d99cbc9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -67,6 +67,26 @@ static const struct proto_ops *mptcp_fallback_tcp_ops(const struct sock *sk)
 	return &inet_stream_ops;
 }
 
+bool __mptcp_try_fallback(struct mptcp_sock *msk, int fb_mib)
+{
+	struct net *net = sock_net((struct sock *)msk);
+
+	if (__mptcp_check_fallback(msk))
+		return true;
+
+	spin_lock_bh(&msk->fallback_lock);
+	if (!msk->allow_infinite_fallback) {
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
@@ -560,10 +580,7 @@ static bool mptcp_check_data_fin(struct sock *sk)
 
 static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
 {
-	if (mptcp_try_fallback(ssk)) {
-		MPTCP_INC_STATS(sock_net(ssk),
-				MPTCP_MIB_DSSCORRUPTIONFALLBACK);
-	} else {
+	if (!mptcp_try_fallback(ssk, MPTCP_MIB_DSSCORRUPTIONFALLBACK)) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCORRUPTIONRESET);
 		mptcp_subflow_reset(ssk);
 	}
@@ -1142,12 +1159,12 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk,
 	mpext->infinite_map = 1;
 	mpext->data_len = 0;
 
-	if (!mptcp_try_fallback(ssk)) {
+	if (!mptcp_try_fallback(ssk, MPTCP_MIB_INFINITEMAPTX)) {
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_FALLBACKFAILED);
 		mptcp_subflow_reset(ssk);
 		return;
 	}
 
-	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPTX);
 	mptcp_subflow_ctx(ssk)->send_infinite_map = 0;
 	pr_fallback(msk);
 }
@@ -3688,16 +3705,15 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	 * TCP option space.
 	 */
 	if (rcu_access_pointer(tcp_sk(ssk)->md5sig_info))
-		mptcp_subflow_early_fallback(msk, subflow);
+		mptcp_early_fallback(msk, subflow, MPTCP_MIB_MD5SIGFALLBACK);
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
+					     MPTCP_MIB_MPCAPABLEACTIVEDISABLED);
+		else if (mptcp_token_new_connect(ssk) < 0)
+			mptcp_early_fallback(msk, subflow,
+					     MPTCP_MIB_TOKENFALLBACKINIT);
 	}
 
 	WRITE_ONCE(msk->write_seq, subflow->idsn);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c8b4ebe198dc..74579743264f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1220,24 +1220,6 @@ static inline bool mptcp_check_fallback(const struct sock *sk)
 	return __mptcp_check_fallback(msk);
 }
 
-static inline bool __mptcp_try_fallback(struct mptcp_sock *msk)
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
 
-static inline bool mptcp_try_fallback(struct sock *ssk)
+bool __mptcp_try_fallback(struct mptcp_sock *msk, int fb_mib);
+
+static inline bool mptcp_try_fallback(struct sock *ssk, int fb_mib)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = subflow->conn;
 	struct mptcp_sock *msk;
 
 	msk = mptcp_sk(sk);
-	if (!__mptcp_try_fallback(msk))
+	if (!__mptcp_try_fallback(msk, fb_mib))
 		return false;
 	if (READ_ONCE(msk->snd_data_fin_enable) && !(ssk->sk_shutdown & SEND_SHUTDOWN)) {
 		gfp_t saved_allocation = ssk->sk_allocation;
@@ -1272,12 +1256,13 @@ static inline bool mptcp_try_fallback(struct sock *ssk)
 
 #define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)\n", __func__, a)
 
-static inline void mptcp_subflow_early_fallback(struct mptcp_sock *msk,
-						struct mptcp_subflow_context *subflow)
+static inline void mptcp_early_fallback(struct mptcp_sock *msk,
+					struct mptcp_subflow_context *subflow,
+					int fb_mib)
 {
 	pr_fallback(msk);
 	subflow->request_mptcp = 0;
-	WARN_ON_ONCE(!__mptcp_try_fallback(msk));
+	WARN_ON_ONCE(!__mptcp_try_fallback(msk, fb_mib));
 }
 
 static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1802bc5435a1..600e59bba363 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -544,11 +544,13 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	mptcp_get_options(skb, &mp_opt);
 	if (subflow->request_mptcp) {
 		if (!(mp_opt.suboptions & OPTION_MPTCP_MPC_SYNACK)) {
-			if (!mptcp_try_fallback(sk))
+			if (!mptcp_try_fallback(sk,
+						MPTCP_MIB_MPCAPABLEACTIVEFALLBACK)) {
+				MPTCP_INC_STATS(sock_net(sk),
+						MPTCP_MIB_FALLBACKFAILED);
 				goto do_reset;
+			}
 
-			MPTCP_INC_STATS(sock_net(sk),
-					MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
 			pr_fallback(msk);
 			goto fallback;
 		}
@@ -1406,7 +1408,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			return true;
 		}
 
-		if (!mptcp_try_fallback(ssk)) {
+		if (!mptcp_try_fallback(ssk, MPTCP_MIB_DSSFALLBACK)) {
 			/* fatal protocol error, close the socket.
 			 * subflow_error_report() will introduce the appropriate barriers
 			 */
@@ -1859,7 +1861,7 @@ static void subflow_state_change(struct sock *sk)
 
 	msk = mptcp_sk(parent);
 	if (subflow_simultaneous_connect(sk)) {
-		WARN_ON_ONCE(!mptcp_try_fallback(sk));
+		WARN_ON_ONCE(!mptcp_try_fallback(sk, MPTCP_MIB_SIMULTCONNFALLBACK));
 		pr_fallback(msk);
 		subflow->conn_finished = 1;
 		mptcp_propagate_state(parent, sk, subflow, NULL);
-- 
2.50.0

