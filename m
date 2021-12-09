Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8652CB2
	for <mptcp@lists.linux.dev>; Thu,  9 Dec 2021 17:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1639071054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bP+3KtDR0QxbzwJnnoMEg83kww9Zzm5gGT0L2smBgTI=;
	b=R8QpnlL3opCvC4x8fmdPDfBms0cPdnz1ds+jBJG+hb5FE/EBWgQuyJgg/YkhgDaMFUUvH7
	T8BuFMhG2YjGqgrFm1FJj3ExCLu1FtqZ5XWdR++Lu4MyJmkpmcclCKfjObDWcrCQzO6q9W
	Ws75tySWplg2T7kUuxJDp+Z5OTLyPWc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-YVW93C2hMnuSOPazGtxAuA-1; Thu, 09 Dec 2021 12:30:52 -0500
X-MC-Unique: YVW93C2hMnuSOPazGtxAuA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D439A14755
	for <mptcp@lists.linux.dev>; Thu,  9 Dec 2021 17:30:51 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.216])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3F4405E275
	for <mptcp@lists.linux.dev>; Thu,  9 Dec 2021 17:30:51 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v5 4/5] mptcp: do not block subflows creation on errors
Date: Thu,  9 Dec 2021 18:30:41 +0100
Message-Id: <9b71adc2d81f4eff820862dfcd3ba32d31ac520b.1639070864.git.pabeni@redhat.com>
In-Reply-To: <cover.1639070864.git.pabeni@redhat.com>
References: <cover.1639070864.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
v3 -> v4:
 - fix 'subflows' underflow

v2 -> v3:
 - fix compile warning (CI)

v1 -> v2:
 - explicitly hook on subflow close instead of error notification
 - fix checkpatch issue (Mat)
 - introduce and use a new pm helper to cope with subflow close
 - update pm subflow counters on close
---
 net/mptcp/options.c    | 21 ++++++++++++++++++---
 net/mptcp/pm.c         | 23 +++++++++++++++++++++--
 net/mptcp/pm_netlink.c | 20 ++++++++++++--------
 net/mptcp/protocol.c   |  6 ++++++
 net/mptcp/protocol.h   |  5 ++++-
 net/mptcp/subflow.c    |  5 ++++-
 6 files changed, 65 insertions(+), 15 deletions(-)

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
index d6d22f18c418..7e2c76924492 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -172,9 +172,28 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk)
 	spin_unlock_bh(&pm->lock);
 }
 
-void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id)
+void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
+				 const struct mptcp_subflow_context *subflow)
 {
-	pr_debug("msk=%p", msk);
+	struct mptcp_pm_data *pm = &msk->pm;
+	bool update_subflows;
+
+	update_subflows = (ssk->sk_state == TCP_CLOSE) &&
+			  (subflow->request_join || subflow->mp_join);
+	if (!READ_ONCE(pm->work_pending) && !update_subflows)
+		return;
+
+	spin_lock_bh(&pm->lock);
+	if (update_subflows)
+		pm->subflows--;
+
+	/* Even if this subflow is not really established, tell the PM to try
+	 * to pick the next one, if possible.
+	 */
+	if (mptcp_pm_nl_check_work_pending(msk))
+		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
+
+	spin_unlock_bh(&pm->lock);
 }
 
 void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1be7f92e9fc8..d908c0a0477b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -251,14 +251,17 @@ unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk)
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_local_addr_max);
 
-static void check_work_pending(struct mptcp_sock *msk)
+bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet = net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
 
 	if (msk->pm.subflows == mptcp_pm_get_subflows_max(msk) ||
 	    (find_next_and_bit(pernet->id_bitmap, msk->pm.id_avail_bitmap, MAX_ADDR_ID + 1, 0) ==
-	     MAX_ADDR_ID + 1))
+	     MAX_ADDR_ID + 1)) {
 		WRITE_ONCE(msk->pm.work_pending, false);
+		return false;
+	}
+	return true;
 }
 
 struct mptcp_pm_add_entry *
@@ -503,12 +506,12 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 	/* do lazy endpoint usage accounting for the MPC subflows */
 	if (unlikely(!(msk->pm.status & BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED))) && msk->first) {
-		struct mptcp_addr_info local;
+		struct mptcp_addr_info mpc_addr;
 		int mpc_id;
 
-		local_address((struct sock_common *)msk->first, &local);
-		mpc_id = lookup_id_by_addr(pernet, &local);
-		if (mpc_id < 0)
+		local_address((struct sock_common *)msk->first, &mpc_addr);
+		mpc_id = lookup_id_by_addr(pernet, &mpc_addr);
+		if (mpc_id >= 0)
 			__clear_bit(mpc_id, msk->pm.id_avail_bitmap);
 
 		msk->pm.status |= BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED);
@@ -553,7 +556,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			spin_lock_bh(&msk->pm.lock);
 		}
 	}
-	check_work_pending(msk);
+	mptcp_pm_nl_check_work_pending(msk);
 }
 
 static void mptcp_pm_nl_fully_established(struct mptcp_sock *msk)
@@ -760,11 +763,12 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 				 i, rm_list->ids[i], subflow->local_id, subflow->remote_id);
 			spin_unlock_bh(&msk->pm.lock);
 			mptcp_subflow_shutdown(sk, ssk, how);
+
+			/* the following takes care of updating the subflows counter */
 			mptcp_close_ssk(sk, ssk, subflow);
 			spin_lock_bh(&msk->pm.lock);
 
 			removed = true;
-			msk->pm.subflows--;
 			__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
 		__set_bit(rm_list->ids[1], msk->pm.id_avail_bitmap);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 63602c68f03d..aa0a1fe749d9 100644
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
index e63fe60f70b8..bd1165189233 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -443,6 +443,7 @@ struct mptcp_subflow_context {
 		stale : 1;	    /* unable to snd/rcv data, do not use for xmit */
 	enum mptcp_data_avail data_avail;
 	u32	remote_nonce;
+	u32	start_stamp;
 	u64	thmac;
 	u32	local_nonce;
 	u32	remote_token;
@@ -744,7 +745,9 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk,
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);
 void mptcp_pm_connection_closed(struct mptcp_sock *msk);
 void mptcp_pm_subflow_established(struct mptcp_sock *msk);
-void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id);
+bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk);
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

