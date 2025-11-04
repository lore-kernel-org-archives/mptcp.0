Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E30346785
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 21:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762293131; cv=none; b=lGzT/CbXPIJkDdEq9nD7a4RQF4eWSsjQ+N2zd0KGIFAWia78p+XWeZ5YiISXYneJ2wvmW7i7T3KGfkd4DRV4Y5RFq6nI91SB2baWvVb8MAPEHYuc+/T4y8/H4M6pvuRR4/k7A2buTksbiq6WwMPHvQJqYdebG7Uc2czfKdvoXSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762293131; c=relaxed/simple;
	bh=04CtghEKinoNE2kJLz2d9cXT1ME/nYe9c1E96D2n290=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=DqTIXqgAFminS00DtM//2l6xaQCnHgkLwQ5bKNwwwSf0Vlkac34rYnnXxwSrdnppPxmyNIJXsRWZsTIhPLaYBxB18uXsNZoCAGpm/V/D3K3UVFuI6HWx5GWYvDgVIEfS281iV5+JTIurSTWh439VOAuCWFfSVWohblFSs4q+lTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WG9Fvmf/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WG9Fvmf/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762293128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SsRaVVvc8g1ztE+wrObc5V5YjWWZxFKQP6KFVKVjGEM=;
	b=WG9Fvmf/SFe+cnud8YEET9DWRBmCET6vWXzblB9bYMAVpJ/+rllL7tNp7th6ZlInObo787
	4CvZJQr/22RkSAS2w8v2lIo7fAM/39/NxJfZshF41QMraoLz3Ln/wp0bIDAMo4P+3F1rIZ
	+BmtozXGQgSzbjrFfQ6iz8hdFa8u7Os=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-FaV5YqjVMRqBMC4W_MFkrg-1; Tue,
 04 Nov 2025 16:52:07 -0500
X-MC-Unique: FaV5YqjVMRqBMC4W_MFkrg-1
X-Mimecast-MFC-AGG-ID: FaV5YqjVMRqBMC4W_MFkrg_1762293126
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3546818009C0
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 21:52:06 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.32])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 41BAE19560B2
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 21:52:04 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 5/7] mptcp: better rcv space initialization
Date: Tue,  4 Nov 2025 22:51:39 +0100
Message-ID: <704300b6e3c86122a4373775aca5b9ffc4e66c82.1762292476.git.pabeni@redhat.com>
In-Reply-To: <cover.1762292476.git.pabeni@redhat.com>
References: <cover.1762292476.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zwiJUgLBYccQsHi4j8JB8ePTHKGSru5QmT1rDXjxfa4_1762293126
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
index 07e1703688ea..c85ad7ef29b0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -923,6 +923,7 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	mptcp_sockopt_sync_locked(msk, ssk);
 	mptcp_stop_tout_timer(sk);
 	__mptcp_propagate_sndbuf(sk, ssk);
+	__mptcp_propagate_rcvspace(sk, ssk);
 	return true;
 }
 
@@ -2050,17 +2051,21 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
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
@@ -2081,7 +2086,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 		return;
 
 	if (!msk->rcvspace_init)
-		mptcp_rcv_space_init(msk, msk->first);
+		mptcp_rcv_space_init(msk);
 
 	msk->rcvq_space.copied += copied;
 
@@ -3507,6 +3512,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	 */
 	mptcp_copy_inaddrs(nsk, ssk);
 	__mptcp_propagate_sndbuf(nsk, ssk);
+	__mptcp_propagate_rcvspace(nsk, ssk);
 
 	msk->rcvq_space.time = mptcp_stamp();
 
@@ -3606,8 +3612,10 @@ static void mptcp_release_cb(struct sock *sk)
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
 
@@ -3723,13 +3731,13 @@ bool mptcp_finish_join(struct sock *ssk)
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
@@ -3743,7 +3751,15 @@ bool mptcp_finish_join(struct sock *ssk)
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
 
@@ -3755,8 +3771,8 @@ bool mptcp_finish_join(struct sock *ssk)
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
@@ -3767,7 +3783,7 @@ bool mptcp_finish_join(struct sock *ssk)
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
index b64ab7649908..33b88991cffb 100644
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
2.51.0

