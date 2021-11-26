Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3632C87
	for <mptcp@lists.linux.dev>; Fri, 26 Nov 2021 12:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1637929162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CcFuKKDteL0v8dMSWCZosRlT3CTedbLG4nJgSUOgpA8=;
	b=egtJZBU+uCuGE8/NMh8mzS76xknIuzspG3G4HeHoEBg+BVS3rNRlKSDG7pWSkYYcxRu4s5
	WZ9L+Nyr9aSPz2jDl+8wfrSfmju50YNNILUisbDLBU1vk7/i+b2T0IwtlqXYG/8l36stXx
	RpMXzXvtRPVxLh3qfTUXOu7a8daPjbw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-5hjWXBmoPtKR-rsezmebEw-1; Fri, 26 Nov 2021 07:19:20 -0500
X-MC-Unique: 5hjWXBmoPtKR-rsezmebEw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CD741F2DA
	for <mptcp@lists.linux.dev>; Fri, 26 Nov 2021 12:19:20 +0000 (UTC)
Received: from gerbillo.fritz.box (unknown [10.39.194.163])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7172219C46
	for <mptcp@lists.linux.dev>; Fri, 26 Nov 2021 12:19:19 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 3/4] mptcp: do not block subflows creation on errors
Date: Fri, 26 Nov 2021 13:19:08 +0100
Message-Id: <7eaa67c01eb780dacbbac368004d2306a7981e09.1637929034.git.pabeni@redhat.com>
In-Reply-To: <cover.1637929034.git.pabeni@redhat.com>
References: <cover.1637929034.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

If the MPTCP configuration allows for multiple subflows
creation, and the first additional subflows never reach
the fully established status - e.g. due to packets drop or
reset - the in kernel path manager do not move to the
next subflow.

This patch introduces a new PM helper to cope with MPJ
subflow creation failure and delay and hook it where appropriate.

Such helper triggers additional subflow creation, as needed
and updates the PM subflow counter, if the current one is
closing.

Note that we don't need an additional timer to catch timeout
and/or long delay in connection completion: we just need to
measure the time elapsed since the subflow creation every
time we emit an MPJ sub-option.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
 - fix compile warning (CI)

v1 -> v2:
 - explicitly hook on subflow close instead of error notification
 - fix checkpatch issue (Mat)
 - introduce and use a new pm helper to cope with subflow close
 - update pm subflow counters on close
---
 net/mptcp/options.c  | 21 ++++++++++++++++++---
 net/mptcp/pm.c       | 27 +++++++++++++++++++++++++--
 net/mptcp/protocol.c |  6 ++++++
 net/mptcp/protocol.h |  4 +++-
 net/mptcp/subflow.c  |  5 ++++-
 5 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 7a6a39b71633..00a8697addcd 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1257,10 +1257,10 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
 void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			 struct mptcp_out_options *opts)
 {
-	if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
-		const struct sock *ssk = (const struct sock *)tp;
-		struct mptcp_subflow_context *subflow;
+	const struct sock *ssk = (const struct sock *)tp;
+	struct mptcp_subflow_context *subflow;
 
+	if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
 		subflow = mptcp_subflow_ctx(ssk);
 		subflow->send_mp_fail = 0;
 
@@ -1382,6 +1382,21 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 		/* MPC is additionally mutually exclusive with MP_PRIO */
 		goto mp_capable_done;
 	} else if (OPTIONS_MPTCP_MPJ & opts->suboptions) {
+		if (ssk) {
+			/* we are still in the MPJ handshake and "a lot" of time passed
+			 * e.g. due to syn retranmissions. We can attempt next
+			 * subflow creation
+			 */
+			subflow = mptcp_subflow_ctx(ssk);
+			if (subflow->start_stamp &&
+			    unlikely(after(tcp_jiffies32, subflow->start_stamp + HZ / 10))) {
+				mptcp_pm_subflow_check_next(mptcp_sk(subflow->conn), ssk, subflow);
+
+				/* avoid triggering the PM multiple times due to timeout */
+				subflow->start_stamp = 0;
+			}
+		}
+
 		if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
 			*ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
 					      TCPOLEN_MPTCP_MPJ_SYN,
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 1ff856dd92c4..df8a596cd3ff 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -172,9 +172,32 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk)
 	spin_unlock_bh(&pm->lock);
 }
 
-void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id)
+void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
+				 const struct mptcp_subflow_context *subflow)
 {
-	pr_debug("msk=%p", msk);
+	struct mptcp_pm_data *pm = &msk->pm;
+	bool closed;
+
+	closed = ssk->sk_state == TCP_CLOSE;
+	if (subflow->fully_established && !closed)
+		return;
+
+	spin_lock_bh(&pm->lock);
+	if (closed) {
+		pm->local_addr_used--;
+		pm->subflows--;
+		/* do not enable the pm worker: we don't want to pick again
+		 * the just closed subflow
+		 */
+	}
+
+	/* Even if this subflow is not really established, tell the PM to try
+	 * to pick the next one, if possible.
+	 */
+	if (pm->work_pending)
+		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
+
+	spin_unlock_bh(&pm->lock);
 }
 
 void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ef2125798e64..2ee2fe97c553 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2351,6 +2351,12 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 {
 	if (sk->sk_state == TCP_ESTABLISHED)
 		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
+
+	/* subflow aborted before reaching the fully_established status
+	 * attempt the creation of the next subflow
+	 */
+	mptcp_pm_subflow_check_next(mptcp_sk(sk), ssk, subflow);
+
 	__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_PUSH);
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d384f285b6c1..4da1ef964b88 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -433,6 +433,7 @@ struct mptcp_subflow_context {
 		stale : 1;	    /* unable to snd/rcv data, do not use for xmit */
 	enum mptcp_data_avail data_avail;
 	u32	remote_nonce;
+	u32	start_stamp;
 	u64	thmac;
 	u32	local_nonce;
 	u32	remote_token;
@@ -733,7 +734,8 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk,
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);
 void mptcp_pm_connection_closed(struct mptcp_sock *msk);
 void mptcp_pm_subflow_established(struct mptcp_sock *msk);
-void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id);
+void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
+				 const struct mptcp_subflow_context *subflow);
 void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0f90bd61de01..76556743e952 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1273,7 +1273,8 @@ void __mptcp_error_report(struct sock *sk)
 
 static void subflow_error_report(struct sock *ssk)
 {
-	struct sock *sk = mptcp_subflow_ctx(ssk)->conn;
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	struct sock *sk = subflow->conn;
 
 	mptcp_data_lock(sk);
 	if (!sock_owned_by_user(sk))
@@ -1444,6 +1445,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	subflow->remote_id = remote_id;
 	subflow->request_join = 1;
 	subflow->request_bkup = !!(flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+	subflow->start_stamp = tcp_jiffies32;
 	mptcp_info2sockaddr(remote, &addr, ssk->sk_family);
 
 	mptcp_add_pending_subflow(msk, subflow);
@@ -1461,6 +1463,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	spin_lock_bh(&msk->join_list_lock);
 	list_del(&subflow->node);
 	spin_unlock_bh(&msk->join_list_lock);
+	mptcp_pm_subflow_check_next(msk, ssk, subflow);
 	sock_put(mptcp_subflow_tcp_sock(subflow));
 
 failed:
-- 
2.33.1

