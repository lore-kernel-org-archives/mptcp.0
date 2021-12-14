Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D186E2CB3
	for <mptcp@lists.linux.dev>; Tue, 14 Dec 2021 16:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1639501167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YXKWaY06yqUZy5gXm7C2FQ1b73lSr4zfHsZ6PP+OS80=;
	b=QlqjV6+8OVmDYiEMPotB+o0MQczEGdmC2N3K01l9Fst0uUfc8K3lYxbt9aiuxsQc+mIJ+s
	83NJNy+dgWRhyTADah2BNbVYdllSxFtwDLfcwo1IxfopQoJHCGEyTZn9Vvvm3JYRXUwV1G
	2+VC60iwlPdC7SD3Fouweau6rPsfoRc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-fW0Iq88oOYe7Uo6gHLCTLg-1; Tue, 14 Dec 2021 11:59:25 -0500
X-MC-Unique: fW0Iq88oOYe7Uo6gHLCTLg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58665100F944
	for <mptcp@lists.linux.dev>; Tue, 14 Dec 2021 16:59:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.135])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 89E28106A7AE
	for <mptcp@lists.linux.dev>; Tue, 14 Dec 2021 16:59:23 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v6 mptcp-next 4/7] mptcp: do not block subflows creation on errors
Date: Tue, 14 Dec 2021 17:58:54 +0100
Message-Id: <b66876de6c02e51f6a8fda08fca77cd33763fb47.1639500873.git.pabeni@redhat.com>
In-Reply-To: <cover.1639500873.git.pabeni@redhat.com>
References: <cover.1639500873.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Additionally start all the needed additional subflows
as soon as the MPTCP socket is fully established, so we don't
have to cope with slow MPJ handshake blocking the next subflow
creation.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v5 -> v6:
 - start all the subflows at once.

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
 net/mptcp/pm.c         | 23 ++++++++++++--
 net/mptcp/pm_netlink.c | 69 +++++++++++++++++++++++++-----------------
 net/mptcp/protocol.c   |  6 ++++
 net/mptcp/protocol.h   |  4 ++-
 4 files changed, 71 insertions(+), 31 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d6d22f18c418..fac02ac195c7 100644
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
+	 * to pick the next ones, if possible.
+	 */
+	if (mptcp_pm_nl_check_work_pending(msk))
+		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
+
+	spin_unlock_bh(&pm->lock);
 }
 
 void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1be7f92e9fc8..33af358129cc 100644
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
@@ -427,6 +430,7 @@ static bool lookup_address_in_vec(struct mptcp_addr_info *addrs, unsigned int nr
 static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullmesh,
 					      struct mptcp_addr_info *addrs)
 {
+	bool deny_id0 = READ_ONCE(msk->pm.remote_deny_join_id0);
 	struct sock *sk = (struct sock *)msk, *ssk;
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_addr_info remote = { 0 };
@@ -434,22 +438,28 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullm
 	int i = 0;
 
 	subflows_max = mptcp_pm_get_subflows_max(msk);
+	remote_address((struct sock_common *)sk, &remote);
 
 	/* Non-fullmesh endpoint, fill in the single entry
 	 * corresponding to the primary MPC subflow remote address
 	 */
 	if (!fullmesh) {
-		remote_address((struct sock_common *)sk, &remote);
+		if (deny_id0)
+			return 0;
+
 		msk->pm.subflows++;
 		addrs[i++] = remote;
 	} else {
 		mptcp_for_each_subflow(msk, subflow) {
 			ssk = mptcp_subflow_tcp_sock(subflow);
-			remote_address((struct sock_common *)ssk, &remote);
-			if (!lookup_address_in_vec(addrs, i, &remote) &&
+			remote_address((struct sock_common *)ssk, &addrs[i]);
+			if (deny_id0 && addresses_equal(&addrs[i], &remote, false))
+				continue;
+
+			if (!lookup_address_in_vec(addrs, i, &addrs[i]) &&
 			    msk->pm.subflows < subflows_max) {
 				msk->pm.subflows++;
-				addrs[i++] = remote;
+				i++;
 			}
 		}
 	}
@@ -503,12 +513,12 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
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
@@ -534,26 +544,28 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	}
 
 	/* check if should create a new subflow */
-	if (msk->pm.local_addr_used < local_addr_max &&
-	    msk->pm.subflows < subflows_max &&
-	    !READ_ONCE(msk->pm.remote_deny_join_id0)) {
+	while (msk->pm.local_addr_used < local_addr_max &&
+	       msk->pm.subflows < subflows_max) {
+		struct mptcp_addr_info addrs[MPTCP_PM_ADDR_MAX];
+		bool fullmesh;
+		int i, nr;
+
 		local = select_local_address(pernet, msk);
-		if (local) {
-			bool fullmesh = !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
-			struct mptcp_addr_info addrs[MPTCP_PM_ADDR_MAX];
-			int i, nr;
+		if (!local)
+			break;
 
-			msk->pm.local_addr_used++;
-			nr = fill_remote_addresses_vec(msk, fullmesh, addrs);
-			if (nr)
-				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
-			spin_unlock_bh(&msk->pm.lock);
-			for (i = 0; i < nr; i++)
-				__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
-			spin_lock_bh(&msk->pm.lock);
-		}
+		fullmesh = !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
+
+		msk->pm.local_addr_used++;
+		nr = fill_remote_addresses_vec(msk, fullmesh, addrs);
+		if (nr)
+			__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
+		spin_unlock_bh(&msk->pm.lock);
+		for (i = 0; i < nr; i++)
+			__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
+		spin_lock_bh(&msk->pm.lock);
 	}
-	check_work_pending(msk);
+	mptcp_pm_nl_check_work_pending(msk);
 }
 
 static void mptcp_pm_nl_fully_established(struct mptcp_sock *msk)
@@ -760,11 +772,12 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
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
index e63fe60f70b8..f38c93c7805c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -744,7 +744,9 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk,
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
-- 
2.33.1

