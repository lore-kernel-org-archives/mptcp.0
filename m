Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795515763;
	b=wgejYgWDLLFJ4E/owSDSRKwFdtWOtIyFDtsASdrsBCiELISYtQzSylpTWDCAARUDyglH
	 sUAznsIFcg4cpgxFYdsCQdEc79gJmxyPDGMIERUXLtfc8GET8V3piy/5Tv5jSvfwlcAwE
	 PliDWQoJFCH4Ihkk2BYFsAcG6+5+53OGWudAxxNbK1LRovaJvVnOYqj/Uzk6pVGaTSFGC
	 lC+9H6Apl4bhvpQkpHsjeBZotZAyU7qQV0ZPawa/yUaX5VEGntEt0AzOSkyzKkJjDqkQu
	 g9ok8nNmd7fg96hB1dV8b0XL4+w+nZl0d/UwnU1lJc3X+IGJ6zaqrOsolM4vJnYVgzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795515763;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=ZzubOCy5JFWRXbOAX+kmaEEv47UtrRExfDXUww6NU0c=;
	b=L4heTgGl3DBLqA7TSuwCSYQml932Sq/4Yyb3ZIdJg1dRxGwhydIeAgLtBe+f28/nyddM
	 UGYI6TtGrgyXc4zdVn4IoYZfkWxPWuML+iXaeNqu1KivmSGPVhioFQcLEsZVICs5ucicy
	 g/jV1XuzLhL9TY1gkk7lZqSM/e5L4SLMmIWhUd86POtjN4w4pvu+S5aBjqlLVl+g7XQs1
	 Qo57sk0WPNr4VmTELBMC4R0oQcxY//y1ZSb3N62aBmosurZuTJXTc2yjbFmGo/LpZSj+u
	 9P6zDV8NXACU1iQ9dpQqzGqInn0eF591CXAGxug42O4nDG+tlfkYucpc0wA8fD87YfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
Received: from sender6-of-o54.zoho.com (sender6-of-o54.zoho.com [165.173.180.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE6A606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 10:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFE6A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1795515751; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mG3PLQCCUDVTlYHmidErwiWQAQeFzogBkhoiNf6+5pfXOpM4MpLxhpz9Trt2Uen2rRhWX1IE4KYwfLozdwo1RYPKNDg/fucwocJnxIbsTqLGBWHWvtQPASxFauVELbfDCZRXRAl/MF96JT7oEtrQW9/M2A14M7Ar2+KtbheFoxA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795515751; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZzubOCy5JFWRXbOAX+kmaEEv47UtrRExfDXUww6NU0c=; 
	b=WCoDwhFg4Dx8UHOipjfTQIUlxSaJwDRobMvhaiiSKUN8x7JxJWV91cJXS7ZPCVrcXeCxKJqR/2tdGnTZAbpORgYpSe6Ee800sARQfVKI/KdiLrDTi8uRcymGiCca7L73ibXHfFxUIBaAmiqvgXMuTNmo5Kpf4rTiWF4Ay1+Y0Mk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: a=rsa-sha256; b=lNubhswGIuFWK8VEZaVMokbJuvolvER+0qmE/Rfn80ryPjxlQNgZt2Z381UPYEffRKPQDP3QLAOG5ctkZZK2afI2MMmuPZmE8oVCRa7oO2FJuKmxSR6a2KZ/wBMANIzebrACOALi0B7T01vNC4Qipuibu0BGDvPcnXHVufTrIkE=; c=relaxed/relaxed; s=mpiric; d=mpiricsoftware.com; v=1; bh=ZzubOCy5JFWRXbOAX+kmaEEv47UtrRExfDXUww6NU0c=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795515749308757.8833535435043;
	Tue, 24 Nov 2026 02:22:29 -0800 (PST)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v8 1/2] mptcp: sched: add subflow avoid flag for BPF schedulers
Date: Tue, 24 Nov 2026 15:52:13 +0530
Message-ID: <20261124102214.3930527-2-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124102214.3930527-1-kalpan.jani@mpiricsoftware.com>
References: <20261124102214.3930527-1-kalpan.jani@mpiricsoftware.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The core marks a subflow as stale after
net.mptcp.stale_loss_cnt retransmission intervals without progress.
That bit belongs to the core and is tightly coupled to the RTO: it
gets cleared as soon as a packet is acked on the subflow
(mptcp_subflow_active() calls mptcp_subflow_set_active() once
rcv_tstamp moves forward).

"scheduled" doesn't cover this either. The core clears it right after
every send/retrans pass the scheduler set it in, so there's no way
to express "leave this subflow alone across future rounds" with it.

Add a scheduler-owned "avoid" bool to mptcp_subflow_context:

 - only mptcp_subflow_set_avoid() writes it. It is exposed to BPF
   struct_ops schedulers as a kfunc with the same registration and
   filter as mptcp_subflow_set_scheduled(), so only a BPF scheduler
   can change its value;

 - it is a standalone bool, alongside "scheduled" and "data_avail",
   rather than a bit in the adjacent flag bitfield.
   mptcp_subflow_data_available() clears map_valid, a bit in that
   bitfield, from the subflow's own receive path without holding the
   msk lock, while set_avoid() runs under the msk lock from BPF
   scheduler context. Bitfield writes are non-atomic read-modify-write
   operations on the whole containing word, so placing avoid there
   would race with that update and risk corrupting neighbouring bits.
   The standalone bool is accessed with READ_ONCE()/WRITE_ONCE();

 - the flag is exported through MPTCP diagnostics, allowing userspace
   to observe whether a subflow has been marked as avoided.

Make the MPTCP core consume the avoid state. Both send and
retransmission selection prefer non-avoided subflows while preserving
the existing active/backup selection priority. Avoided subflows remain
usable when no non-avoided alternative is available.

When a BPF scheduler schedules both avoided and non-avoided subflows,
the core drops the avoided selections. If it schedules only avoided
subflows, the core retries selection through the default selector.
This makes avoid a core-enforced preference rather than state that
each BPF scheduler must independently enforce.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/349
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
Changes since v7:
- Enforce the avoid preference in the MPTCP core for send and
  retransmission selection.
- Prefer non-avoided subflows while preserving active/backup
  selection priorities and retaining avoided fallback candidates.
- Drop avoided BPF selections when eligible non-avoided
  selections exist; retry the default selector when only
  avoided subflows are selected.
- Handle scheduler success without a selected subflow correctly.

v7: https://lore.kernel.org/all/20261123123730.3265284-2-kalpan.jani@mpiricsoftware.com/
---
 include/uapi/linux/mptcp.h |   1 +
 net/mptcp/bpf.c            |   1 +
 net/mptcp/diag.c           |   2 +
 net/mptcp/protocol.c       |  76 +++++++++++++-------
 net/mptcp/protocol.h       |   3 +
 net/mptcp/sched.c          | 141 +++++++++++++++++++++++++++++++++----
 6 files changed, 186 insertions(+), 38 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 72a5d030154e1..b4ca97e074453 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -22,6 +22,7 @@
 #define MPTCP_SUBFLOW_FLAG_FULLY_ESTABLISHED	_BITUL(6)
 #define MPTCP_SUBFLOW_FLAG_CONNECTED		_BITUL(7)
 #define MPTCP_SUBFLOW_FLAG_MAPVALID		_BITUL(8)
+#define MPTCP_SUBFLOW_FLAG_AVOID		_BITUL(9)
 
 #define MPTCP_PM_CMD_GRP_NAME	"mptcp_pm_cmds"
 #define MPTCP_PM_EV_GRP_NAME	"mptcp_pm_events"
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 74648ca1e99b5..6fcd2bb5e6bdd 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -312,6 +312,7 @@ BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock, KF_RET_NULL)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
+BTF_ID_FLAGS(func, mptcp_subflow_set_avoid)
 BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index 70cf9ebce8338..7a2c40a63dfa4 100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -49,6 +49,8 @@ static int subflow_get_info(struct sock *sk, struct sk_buff *skb, bool net_admin
 		flags |= MPTCP_SUBFLOW_FLAG_BKUP_LOC;
 	if (READ_ONCE(sf->fully_established))
 		flags |= MPTCP_SUBFLOW_FLAG_FULLY_ESTABLISHED;
+	if (READ_ONCE(sf->avoid))
+		flags |= MPTCP_SUBFLOW_FLAG_AVOID;
 	if (sf->conn_finished)
 		flags |= MPTCP_SUBFLOW_FLAG_CONNECTED;
 	if (sf->map_valid)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index be23768b6d051..cd1d5dc8a2057 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1630,26 +1630,30 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
  */
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
-	struct subflow_send_info send_info[SSK_MODE_MAX];
+	struct subflow_send_info send_info[SSK_MODE_MAX][2];
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
 	u32 pace, burst, wmem;
-	int i, nr_active = 0;
+	int i, j, nr_active = 0;
 	struct sock *ssk;
 	u64 linger_time;
 	long tout = 0;
 
-	/* pick the subflow with the lower wmem/wspace ratio */
+	/* Pick the subflow with the lower wmem/wspace ratio. */
 	for (i = 0; i < SSK_MODE_MAX; ++i) {
-		send_info[i].ssk = NULL;
-		send_info[i].linger_time = -1;
+		for (j = 0; j < 2; ++j) {
+			send_info[i][j].ssk = NULL;
+			send_info[i][j].linger_time = -1;
+		}
 	}
 
 	mptcp_for_each_subflow(msk, subflow) {
 		bool backup = subflow->backup || subflow->request_bkup;
+		bool avoid = READ_ONCE(subflow->avoid);
+		int mode = backup ? SSK_MODE_BACKUP : SSK_MODE_ACTIVE;
 
 		trace_mptcp_subflow_get_send(subflow);
-		ssk =  mptcp_subflow_tcp_sock(subflow);
+		ssk = mptcp_subflow_tcp_sock(subflow);
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
@@ -1664,17 +1668,29 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 				continue;
 		}
 
-		linger_time = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32, pace);
-		if (linger_time < send_info[backup].linger_time) {
-			send_info[backup].ssk = ssk;
-			send_info[backup].linger_time = linger_time;
+		linger_time = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32,
+				      pace);
+		if (linger_time < send_info[mode][avoid].linger_time) {
+			send_info[mode][avoid].ssk = ssk;
+			send_info[mode][avoid].linger_time = linger_time;
 		}
 	}
 	__mptcp_set_timeout(sk, tout);
 
-	/* pick the best backup if no other subflow is active */
-	if (!nr_active)
-		send_info[SSK_MODE_ACTIVE].ssk = send_info[SSK_MODE_BACKUP].ssk;
+	/* Use backup subflows only if no non-backup subflow is active. */
+	if (!nr_active) {
+		for (j = 0; j < 2; ++j)
+			send_info[SSK_MODE_ACTIVE][j] =
+				send_info[SSK_MODE_BACKUP][j];
+	}
+
+	/*
+	 * Prefer non-avoided subflows within the selected active/backup
+	 * class. Use avoided subflows only when no preferred candidate exists.
+	 */
+	ssk = send_info[SSK_MODE_ACTIVE][0].ssk;
+	if (!ssk)
+		ssk = send_info[SSK_MODE_ACTIVE][1].ssk;
 
 	/* According to the blest algorithm, to avoid HoL blocking for the
 	 * faster flow, we need to:
@@ -1687,7 +1703,6 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	 * the queued mem, which basically ensure the above. We just need
 	 * to check that subflow has a non empty cwin.
 	 */
-	ssk = send_info[SSK_MODE_ACTIVE].ssk;
 	if (!ssk || !sk_stream_memory_free(ssk))
 		return NULL;
 
@@ -2568,37 +2583,50 @@ static void mptcp_tout_timer(struct timer_list *t)
  */
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 {
-	struct sock *backup = NULL, *pick = NULL;
+	struct sock *backup[2] = {};
+	struct sock *pick[2] = {};
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count = INT_MAX;
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool avoid = READ_ONCE(subflow->avoid);
 
 		if (!__mptcp_subflow_active(subflow))
 			continue;
 
 		/* still data outstanding at TCP level? skip this */
 		if (!tcp_rtx_and_write_queues_empty(ssk)) {
-			min_stale_count = min_t(int, min_stale_count, subflow->stale_count);
+			min_stale_count = min_t(int, min_stale_count,
+						subflow->stale_count);
 			continue;
 		}
 
 		if (subflow->backup || subflow->request_bkup) {
-			if (!backup)
-				backup = ssk;
+			if (!backup[avoid])
+				backup[avoid] = ssk;
 			continue;
 		}
 
-		if (!pick)
-			pick = ssk;
+		if (!pick[avoid])
+			pick[avoid] = ssk;
 	}
 
-	if (pick)
-		return pick;
+	/* Prefer non-avoided non-backup subflows. */
+	if (pick[0])
+		return pick[0];
+	if (pick[1])
+		return pick[1];
+
+	/* Use backup only if there are no progresses anywhere. */
+	if (min_stale_count > 1) {
+		if (backup[0])
+			return backup[0];
+		if (backup[1])
+			return backup[1];
+	}
 
-	/* use backup only if there are no progresses anywhere */
-	return min_stale_count > 1 ? backup : NULL;
+	return NULL;
 }
 
 bool __mptcp_retransmit_pending_data(struct sock *sk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9febcaf84762d..24e2540c05caa 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -607,6 +607,7 @@ struct mptcp_subflow_context {
 		__unused : 9;
 	bool	data_avail;
 	bool	scheduled;
+	bool	avoid;		    /* pkt scheduler: skip subflow if possible */
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
 	bool	fully_established;  /* path validated */
 	bool	close_event_done;   /* has done the post-closed part,
@@ -935,6 +936,8 @@ static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
 
 void mptcp_subflow_set_active(struct mptcp_subflow_context *subflow);
 
+void mptcp_subflow_set_avoid(struct mptcp_subflow_context *subflow, bool avoid);
+
 bool mptcp_subflow_active(struct mptcp_subflow_context *subflow);
 
 void mptcp_subflow_drop_ctx(struct sock *ssk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 1e59072d478c9..822904fa939a7 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -165,13 +165,68 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 	WRITE_ONCE(subflow->scheduled, scheduled);
 }
 
-int mptcp_sched_get_send(struct mptcp_sock *msk)
+__bpf_kfunc void mptcp_subflow_set_avoid(struct mptcp_subflow_context *subflow,
+					 bool avoid)
+{
+	WRITE_ONCE(subflow->avoid, avoid);
+}
+
+enum mptcp_sched_subflow_state {
+	MPTCP_SCHED_SUBFLOW_NONE,
+	MPTCP_SCHED_SUBFLOW_AVOIDED_ONLY,
+	MPTCP_SCHED_SUBFLOW_ELIGIBLE,
+};
+
+static enum mptcp_sched_subflow_state
+mptcp_sched_get_subflow_state(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	bool avoided = false;
+	bool eligible = false;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (!READ_ONCE(subflow->scheduled))
+			continue;
+
+		if (READ_ONCE(subflow->avoid))
+			avoided = true;
+		else
+			eligible = true;
+	}
+
+	if (eligible && avoided) {
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled) &&
+			    READ_ONCE(subflow->avoid))
+				mptcp_subflow_set_scheduled(subflow, false);
+		}
+	}
+
+	if (eligible)
+		return MPTCP_SCHED_SUBFLOW_ELIGIBLE;
+
+	return avoided ? MPTCP_SCHED_SUBFLOW_AVOIDED_ONLY :
+		MPTCP_SCHED_SUBFLOW_NONE;
+}
+
+static void mptcp_sched_clear_scheduled(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
 
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled))
+			mptcp_subflow_set_scheduled(subflow, false);
+	}
+}
+
+int mptcp_sched_get_send(struct mptcp_sock *msk)
+{
+	enum mptcp_sched_subflow_state state;
+	int err;
+
 	msk_owned_by_me(msk);
 
-	/* the following check is moved out of mptcp_subflow_get_send */
+	/* Fallback uses the first subflow as a plain TCP socket. */
 	if (__mptcp_check_fallback(msk)) {
 		if (msk->first &&
 		    __tcp_can_send(msk->first) &&
@@ -182,34 +237,92 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 		return -EINVAL;
 	}
 
-	mptcp_for_each_subflow(msk, subflow) {
-		if (READ_ONCE(subflow->scheduled))
-			return 0;
+	state = mptcp_sched_get_subflow_state(msk);
+	if (state == MPTCP_SCHED_SUBFLOW_ELIGIBLE)
+		return 0;
+
+	if (state == MPTCP_SCHED_SUBFLOW_AVOIDED_ONLY) {
+		mptcp_sched_clear_scheduled(msk);
+		return mptcp_sched_default_get_send(msk);
 	}
 
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
+		err = mptcp_sched_default_get_send(msk);
+	else
+		err = msk->sched->get_send(msk);
+
+	state = mptcp_sched_get_subflow_state(msk);
+	if (state == MPTCP_SCHED_SUBFLOW_ELIGIBLE) {
+		if (err) {
+			mptcp_sched_clear_scheduled(msk);
+			return err;
+		}
+		return 0;
+	}
+
+	if (state == MPTCP_SCHED_SUBFLOW_AVOIDED_ONLY) {
+		if (err) {
+			mptcp_sched_clear_scheduled(msk);
+			return err;
+		}
+
+		if (msk->sched == &mptcp_sched_default || !msk->sched)
+			return 0;
+
+		mptcp_sched_clear_scheduled(msk);
 		return mptcp_sched_default_get_send(msk);
-	return msk->sched->get_send(msk);
+	}
+
+	return err ?: -EINVAL;
 }
 
 int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
-	struct mptcp_subflow_context *subflow;
+	enum mptcp_sched_subflow_state state;
+	int err;
 
 	msk_owned_by_me(msk);
 
-	/* the following check is moved out of mptcp_subflow_get_retrans */
 	if (__mptcp_check_fallback(msk))
 		return -EINVAL;
 
-	mptcp_for_each_subflow(msk, subflow) {
-		if (READ_ONCE(subflow->scheduled))
-			return 0;
+	state = mptcp_sched_get_subflow_state(msk);
+	if (state == MPTCP_SCHED_SUBFLOW_ELIGIBLE)
+		return 0;
+
+	if (state == MPTCP_SCHED_SUBFLOW_AVOIDED_ONLY) {
+		mptcp_sched_clear_scheduled(msk);
+		return mptcp_sched_default_get_retrans(msk);
 	}
 
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
+		err = mptcp_sched_default_get_retrans(msk);
+	else if (msk->sched->get_retrans)
+		err = msk->sched->get_retrans(msk);
+	else
+		err = msk->sched->get_send(msk);
+
+	state = mptcp_sched_get_subflow_state(msk);
+	if (state == MPTCP_SCHED_SUBFLOW_ELIGIBLE) {
+		if (err) {
+			mptcp_sched_clear_scheduled(msk);
+			return err;
+		}
+		return 0;
+	}
+
+	if (state == MPTCP_SCHED_SUBFLOW_AVOIDED_ONLY) {
+		if (err) {
+			mptcp_sched_clear_scheduled(msk);
+			return err;
+		}
+
+		if (msk->sched == &mptcp_sched_default || !msk->sched)
+			return 0;
+
+		mptcp_sched_clear_scheduled(msk);
 		return mptcp_sched_default_get_retrans(msk);
-	if (msk->sched->get_retrans)
-		return msk->sched->get_retrans(msk);
-	return msk->sched->get_send(msk);
+	}
+
+	return err ?: -EINVAL;
 }
-- 
2.43.0

