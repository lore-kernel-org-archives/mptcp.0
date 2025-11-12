Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78252FF16E
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940482; cv=none; b=oqJU+rvx5DmAUekr6dcVwXc350pEabdmHN2Ta9YACALHqYbnRgW9lZ9+bS08RtSDtkllnXXgWcFa9VGSXdg9acd0K9mi1z50tVhcjcEgdnzcm9B3g+tQWfhJ9Qgo53byD/0PCgeikLolTEeYuHI8zdETW/OZU8UPV5V3iiRUhwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940482; c=relaxed/simple;
	bh=ym7a5sdeBjRvKyysOwKQyvI738oppfOs/jBDz0nlIb4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ifxemfmWM7SrEo7bhAFuovxDWrDqSzxTkqTB82qEYsu6760Uv+NSFhEjEausNRDCu2x44N6JvauDU+CC5uyxF6Sd83G3G3WI+JyDa1a2H38bh0TKZBmV8WGAqsravA75++RsSN3m7oYcggEY/C7hFHloMDdpKeNCCbhM36l2L2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PtWAn4gE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtWAn4gE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762940480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xr42XIT6/5lStrzXw0r+GES57H0Cw3EyXYZeOq2nNmo=;
	b=PtWAn4gEcqnJLluHnWcwmvBmi4oR/SdOUgyQdwWFeKlxLJqcrqMN2t2tpEc/5rgmxHchlY
	Pb7zElLrpzBMzXzS7qb44WzZV2CsekwQZtTScROf3R/Tgx/ARtGc8PU2BxQo5jzncJwWIN
	NPZKZ1vXEo5Pav9AgriZZMHmqT4VQl4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-OB987pOhM0apiLxesixJxg-1; Wed,
 12 Nov 2025 04:41:18 -0500
X-MC-Unique: OB987pOhM0apiLxesixJxg-1
X-Mimecast-MFC-AGG-ID: OB987pOhM0apiLxesixJxg_1762940478
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C867195605B
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 09:41:18 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.120])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2D3CD1955F1A
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 09:41:16 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v4 mptcp-next 4/6] mptcp: better rcv space initialization
Date: Wed, 12 Nov 2025 10:41:04 +0100
Message-ID: <add0910a988cd8f45b7c3f5c76dea0fc3f4ee666.1762940290.git.pabeni@redhat.com>
In-Reply-To: <cover.1762940290.git.pabeni@redhat.com>
References: <cover.1762940290.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7mcpadJMiCo9X-YE_OrtWmc8mmwyvZN3RHBFQ51Abds_1762940478
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Each additional subflow can overshot the rcv space by a full rcv wnd,
as the TCP socket at creation time will announce such window even if
the MPTCP-level window is closed.

Underestimating the initial real rcv space can overshot the initial rcv
win increase significantly.

Keep track explicitly of the rcv space contribution by newly created
subflow, updating rcvq_space.space accordingly for every successfully
completed subflow handshake.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 44 ++++++++++++++++++++++++++++++--------------
 net/mptcp/protocol.h | 30 ++++++++++++++++++++++++++++++
 net/mptcp/subflow.c  |  3 +++
 3 files changed, 63 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 06eabad05784..4f23809e5369 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -925,6 +925,7 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	mptcp_sockopt_sync_locked(msk, ssk);
 	mptcp_stop_tout_timer(sk);
 	__mptcp_propagate_sndbuf(sk, ssk);
+	__mptcp_propagate_rcvspace(sk, ssk);
 	return true;
 }
 
@@ -2052,17 +2053,21 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 	return copied;
 }
 
-static void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
+static void mptcp_rcv_space_init(struct mptcp_sock *msk)
 {
-	const struct tcp_sock *tp = tcp_sk(ssk);
+	struct sock *sk = (struct sock *)msk;
 
 	msk->rcvspace_init = 1;
 
-	/* initial rcv_space offering made to peer */
-	msk->rcvq_space.space = min_t(u32, tp->rcv_wnd,
-				      TCP_INIT_CWND * tp->advmss);
-	if (msk->rcvq_space.space == 0)
+	mptcp_data_lock(sk);
+	__mptcp_sync_rcvspace(sk);
+
+	/* Paranoid check: at least one subflow pushed data to the msk. */
+	if (msk->rcvq_space.space == 0) {
+		DEBUG_NET_WARN_ON_ONCE(1);
 		msk->rcvq_space.space = TCP_INIT_CWND * TCP_MSS_DEFAULT;
+	}
+	mptcp_data_unlock(sk);
 }
 
 /* receive buffer autotuning.  See tcp_rcv_space_adjust for more information.
@@ -2083,7 +2088,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 		return;
 
 	if (!msk->rcvspace_init)
-		mptcp_rcv_space_init(msk, msk->first);
+		mptcp_rcv_space_init(msk);
 
 	msk->rcvq_space.copied += copied;
 
@@ -3524,6 +3529,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	 */
 	mptcp_copy_inaddrs(nsk, ssk);
 	__mptcp_propagate_sndbuf(nsk, ssk);
+	__mptcp_propagate_rcvspace(nsk, ssk);
 
 	msk->rcvq_space.time = mptcp_stamp();
 
@@ -3623,8 +3629,10 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_sync_state(sk, msk->pending_state);
 		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
 			__mptcp_error_report(sk);
-		if (__test_and_clear_bit(MPTCP_SYNC_SNDBUF, &msk->cb_flags))
+		if (__test_and_clear_bit(MPTCP_SYNC_SNDBUF, &msk->cb_flags)) {
 			__mptcp_sync_sndbuf(sk);
+			__mptcp_sync_rcvspace(sk);
+		}
 	}
 }
 
@@ -3740,13 +3748,13 @@ bool mptcp_finish_join(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
-	struct sock *parent = (void *)msk;
+	struct sock *sk = (void *)msk;
 	bool ret = true;
 
 	pr_debug("msk=%p, subflow=%p\n", msk, subflow);
 
 	/* mptcp socket already closing? */
-	if (!mptcp_is_fully_established(parent)) {
+	if (!mptcp_is_fully_established(sk)) {
 		subflow->reset_reason = MPTCP_RST_EMPTCP;
 		return false;
 	}
@@ -3760,7 +3768,15 @@ bool mptcp_finish_join(struct sock *ssk)
 		}
 		mptcp_subflow_joined(msk, ssk);
 		spin_unlock_bh(&msk->fallback_lock);
-		mptcp_propagate_sndbuf(parent, ssk);
+		mptcp_data_lock(sk);
+		if (!sock_owned_by_user(sk)) {
+			__mptcp_propagate_sndbuf(sk, ssk);
+			__mptcp_propagate_rcvspace(sk, ssk);
+		} else {
+			__mptcp_bl_rcvspace(sk, ssk);
+			__set_bit(MPTCP_SYNC_SNDBUF, &mptcp_sk(sk)->cb_flags);
+		}
+		mptcp_data_unlock(sk);
 		return true;
 	}
 
@@ -3772,8 +3788,8 @@ bool mptcp_finish_join(struct sock *ssk)
 	/* If we can't acquire msk socket lock here, let the release callback
 	 * handle it
 	 */
-	mptcp_data_lock(parent);
-	if (!sock_owned_by_user(parent)) {
+	mptcp_data_lock(sk);
+	if (!sock_owned_by_user(sk)) {
 		ret = __mptcp_finish_join(msk, ssk);
 		if (ret) {
 			sock_hold(ssk);
@@ -3784,7 +3800,7 @@ bool mptcp_finish_join(struct sock *ssk)
 		list_add_tail(&subflow->node, &msk->join_list);
 		__set_bit(MPTCP_FLUSH_JOIN_LIST, &msk->cb_flags);
 	}
-	mptcp_data_unlock(parent);
+	mptcp_data_unlock(sk);
 
 	if (!ret) {
 err_prohibited:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7c9e143c0fb5..adc0851bad69 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -360,6 +360,7 @@ struct mptcp_sock {
 
 	struct list_head backlog_list;	/* protected by the data lock */
 	u32		backlog_len;
+	u32		bl_space;	/* rcvspace propagation via bl */
 };
 
 #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
@@ -976,6 +977,35 @@ static inline void mptcp_write_space(struct sock *sk)
 		sk_stream_write_space(sk);
 }
 
+static inline void __mptcp_sync_rcvspace(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	msk->rcvq_space.space += msk->bl_space;
+	msk->bl_space = 0;
+}
+
+static inline u32 mptcp_subflow_rcvspace(struct sock *ssk)
+{
+	struct tcp_sock *tp = tcp_sk(ssk);
+	int space;
+
+	space = min_t(u32, tp->rcv_wnd, TCP_INIT_CWND * tp->advmss);
+	if (space == 0)
+		space = TCP_INIT_CWND * TCP_MSS_DEFAULT;
+	return space;
+}
+
+static inline void __mptcp_propagate_rcvspace(struct sock *sk, struct sock *ssk)
+{
+	mptcp_sk(sk)->rcvq_space.space += mptcp_subflow_rcvspace(ssk);
+}
+
+static inline void __mptcp_bl_rcvspace(struct sock *sk, struct sock *ssk)
+{
+	mptcp_sk(sk)->bl_space += mptcp_subflow_rcvspace(ssk);
+}
+
 static inline void __mptcp_sync_sndbuf(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 32f06510ba7a..1984fc609b82 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -462,6 +462,7 @@ void __mptcp_sync_state(struct sock *sk, int state)
 
 	subflow = mptcp_subflow_ctx(ssk);
 	__mptcp_propagate_sndbuf(sk, ssk);
+	__mptcp_sync_rcvspace(sk);
 
 	if (sk->sk_state == TCP_SYN_SENT) {
 		/* subflow->idsn is always available is TCP_SYN_SENT state,
@@ -516,8 +517,10 @@ static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,
 
 	if (!sock_owned_by_user(sk)) {
 		__mptcp_sync_state(sk, ssk->sk_state);
+		__mptcp_propagate_rcvspace(sk, ssk);
 	} else {
 		msk->pending_state = ssk->sk_state;
+		__mptcp_bl_rcvspace(sk, ssk);
 		__set_bit(MPTCP_SYNC_STATE, &msk->cb_flags);
 	}
 	mptcp_data_unlock(sk);
-- 
2.51.1

