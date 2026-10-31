Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793486694;
	b=pkxUIlMOmZebXq2nI7nRcEMIV89e595c/mWnxwwpwtSEyvVM9bIfe45Itsj9jnW0/HBM
	 h4sbvDK0RUcBKA2xDBNg1fPoDCRL5E8wm3+nRQBWOe2wBsqCnYkp64FU6bnjoIiSSnw4d
	 sBoeGmnmFAINsEoRgt4QuDPNPfgUErWL/zaeE3YYtscUmxtk6MPqf1eeyEUhiCL2qlEmn
	 ZddtVgKczv6jXKEPQEK5IV9x/5YuMvxYVBYyD0RNMe4Q1cTIAj9YZS2Dn5+/Uh29g50ob
	 pAXKa4eCfsE/kVc+t+4J1WEw6pS98T/l/VoLSqrbED4X+jR9eoom19RMsrdw4QGxlRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793486694;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=N2P3sdTNYDif5zE6Qzd/988hWvobLBWE6gLCCKI9fAw=;
	b=E8lVPz7SpfHbfYEv0hZ1qHAwXrXeKsRtnf+EPDQN/Q1iSUf71c9hcDzZiHPFdLg6alu3
	 wqO95GVjhKDlQr6NOShzgfHMkSmOeANpFRpz166AJzSEkNoG1gRxjX+mCJsHNuJnbBMEc
	 Ovrgy+mc0FfB2T4BCXwhQwixUXluMyXakPZvKp3isXpJgX2ZMV08iUcDGeDITnmu82NMY
	 FFA+D+Fjy0IRk3iWwpYbJ058kjlxqchJPiVPMb3S+K0dlu52/aCMhfiZieVdw6x48jUrx
	 nw2jQRc2cvH9mvFmu02ETjJdbqnORQF9xHFgSWMfanrRb3TK9HDa3+S6jIXsrnPLLwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HhqoU7Kw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDB0606A31A
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 22:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HhqoU7Kw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3E61F000C1;
	Sat, 31 Oct 2026 22:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793486693;
	bh=N2P3sdTNYDif5zE6Qzd/988hWvobLBWE6gLCCKI9fAw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HhqoU7KwOad2PcgO2uiJZebnjTEBJ8YV997f/gMVFuB+lDabv60hBAVxW2GLo/elx
	 DXcBK9mmPqHsVjS46Xr7m5n4iDAXwexsbSzh1bc9YaY6BQ41bA+QInseEooWLESK5X
	 v+YAe1Qvs3FFHowTwPAeMvY5RNZyIcyTQCdt86pCHN8NsZ6fGwroiI5/Jc9VGbS/mx
	 FvfV+nn54QLdTaXbeLah+oNKxfnx7vi4fouWF0cvEU17O8WaSLKJ6af64EOGV+NaxL
	 yKa25cFl2yFZwpl/FF296KTxKxK70YhTaA+cMV/ut8BurM93pq4s9vGtJjNDdzP8bd
	 A+8WnE4IdvHpQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 31 Oct 2026 23:44:35 +0100
Subject: [PATCH mptcp-next v2 3/8] mptcp: sched: let get_retrans reinject
 on an idle subflow
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-mptcp-sched-opp-retrans-v2-3-e9c4a30f6841@kernel.org>
References: <20261031-mptcp-sched-opp-retrans-v2-0-e9c4a30f6841@kernel.org>
In-Reply-To: <20261031-mptcp-sched-opp-retrans-v2-0-e9c4a30f6841@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Abdul Wasey <w453y.me@gmail.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18754; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=C9LANHss9ce0aTBbd5VFxz0D+ujit+ktH6azHMaAu0g=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGrmb13IZd+id8h8YQWMWCuLuxMqcppnOw3tQhTe3L7EkBKRZ
 4h1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmrmb10ACgkQfCLwwvNHCpc1RQD/TErA
 fzplFYQQjoR2pQqJlS3xP6AgZYPBeP2ofnL1gjYBAKAEQdHM0C/C7s3s2S/1NWhAWGP5LU8s4j+
 wrccG1HwM
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Abdul Wasey <w453y.me@gmail.com>

With subflows of different speeds, the data sent on a slow subflow holds
back the DATA_ACK while the fast one keeps delivering what comes after
it. Once the receive window or the send buffer is used up, nothing new
can be sent: the fast subflow drains and stays idle until the slow one
delivers, or until the MPTCP-level RTO fires. The same happens when the
application has nothing more to write for now: the end of what it wrote
waits on the slow subflow. The old out-of-tree kernel resent that data
on the idle subflow ("opportunistic retransmission", Raiciu et al., NSDI
2012), upstream has nothing for it [1].

Do it as a scheduler action, through get_retrans, so that there is still
one call per decision: get_retrans is now also called when an active
non-backup subflow has nothing queued or in flight while nothing new can
be sent, and msk->sched_retrans says why it is called:

- MPTCP_SCHED_RETRANS_RTO: the MPTCP-level timer fired, as before;
- MPTCP_SCHED_RETRANS_IDLE_WND: the peer's receive window is nearly
  full;
- MPTCP_SCHED_RETRANS_IDLE_SNDBUF: the application waits for send buffer
  space;
- MPTCP_SCHED_RETRANS_IDLE_APP: the application has nothing more to send
  for now.

On the IDLE reasons, the scheduler marks a subflow and sets the new
reinject_limit there. The core then resends on it, up to that many bytes
and one cwnd, the DSN ranges that the other subflows still hold, taken
from the DSS mappings of the skbs in their queues: a BPF program cannot
walk them. Most of the data after snd_una already reached the peer, so
this is less than resending everything from snd_una. A limit of 0, the
default, sends nothing. This is done at most once per snd_una value.

This is not done with the MPTCP checksum: a re-injection must then spool
a complete DSS, see commit 4e14867d5e91 ("mptcp: tune re-injections for
csum enabled mode").

This runs in the worker, under the msk socket lock, as the MPTCP-level
retransmission does. If no subflow is idle there, or if a send is
pending, nothing is decided for this snd_una. Otherwise, the answer of
the scheduler is final for this snd_una. Nothing wakes the worker yet:
that is the next patch.

Only a scheduler with its own get_retrans is asked: the default one does
not reinject yet, see a later patch. A BPF scheduler cannot set
reinject_limit yet either: a later patch allows it. One that does not
want to reinject can ignore the IDLE reasons.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/332 [1]
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/mib.c      |   2 +
 net/mptcp/mib.h      |   2 +
 net/mptcp/protocol.c |  89 +++++++++++++++++++
 net/mptcp/protocol.h |  44 +++++++++
 net/mptcp/sched.c    | 245 +++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 382 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index b39b5511345d..7fe0fd71cb43 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -97,6 +97,8 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("OFOPruned", MPTCP_MIB_OFOPRUNED),
 	SNMP_MIB_ITEM("CwndPenalised", MPTCP_MIB_CWNDPENALISED),
 	SNMP_MIB_ITEM("PenalCandidate", MPTCP_MIB_PENALCAND),
+	SNMP_MIB_ITEM("OppReinject", MPTCP_MIB_OPPREINJ),
+	SNMP_MIB_ITEM("OppReinjectBytes", MPTCP_MIB_OPPREINJBYTES),
 };
 
 /* mptcp_mib_alloc - allocate percpu mib counters
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index a7b5bf684af7..615666050f51 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -100,6 +100,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_OFOPRUNED,		/* MPTCP-level OoO queue pruned */
 	MPTCP_MIB_CWNDPENALISED,	/* subflow cwnd halved by the scheduler */
 	MPTCP_MIB_PENALCAND,		/* scheduler picked a slow (low-rate) subflow */
+	MPTCP_MIB_OPPREINJ,		/* Opportunistic reinjections on an idle subflow */
+	MPTCP_MIB_OPPREINJBYTES,	/* Bytes sent by opportunistic reinjections */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d960ab9c76b3..7117786e5251 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3057,6 +3057,92 @@ static int __mptcp_push_retrans(struct sock *sk, struct mptcp_data_frag *dfrag,
 	return len;
 }
 
+/* resend [start, end) on @ssk from the msk rtx queue; < 0 on a send error */
+static int mptcp_oppr_send_range(struct sock *sk, struct sock *ssk, u64 start,
+				 u64 end, int budget,
+				 struct mptcp_sendmsg_info *info)
+{
+	struct mptcp_data_frag *dfrag;
+	int copied = 0, ret;
+
+	list_for_each_entry(dfrag, &mptcp_sk(sk)->rtx_queue, list) {
+		if (!dfrag->already_sent || !before64(dfrag->data_seq, end))
+			break;
+		if (!after64(dfrag->data_seq + dfrag->already_sent, start))
+			continue;
+
+		info->sent = before64(dfrag->data_seq, start) ?
+			     start - dfrag->data_seq : 0;
+		info->limit = min_t(u64, dfrag->already_sent,
+				    end - dfrag->data_seq);
+		info->limit = min_t(u64, info->limit,
+				    info->sent + budget - copied);
+		while (info->sent < info->limit && copied < budget) {
+			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, info);
+			if (ret <= 0)
+				return copied ? : -1;
+			copied += ret;
+			info->sent += ret;
+		}
+		if (copied >= budget)
+			break;
+	}
+	return copied;
+}
+
+/* Opportunistic reinjection: the scheduling part is in sched.c */
+static void __mptcp_oppr(struct sock *sk)
+{
+	struct mptcp_sendmsg_info info = { .data_lock_held = true, };
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	int copied = 0, budget, ret, i;
+	struct mptcp_sched_oppr oppr;
+	struct sock *ssk;
+
+	mptcp_data_lock(sk);
+	__mptcp_clean_una_wakeup(sk);
+	oppr.una = msk->snd_una;
+	mptcp_data_unlock(sk);
+
+	if (!mptcp_sched_oppr_get(msk, &oppr))
+		return;
+
+	ssk = oppr.ssk;
+	lock_sock(ssk);
+	/* the scheduler's limit, and no more than one cwnd */
+	budget = min_t(u64, oppr.limit,
+		       tcp_snd_cwnd(tcp_sk(ssk)) * tcp_sk(ssk)->mss_cache);
+
+	spin_lock_bh(&msk->fallback_lock);
+	if (__mptcp_check_fallback(msk) || !msk->allow_subflows)
+		goto unlock;
+
+	for (i = 0; i < oppr.n && copied < budget; i++) {
+		ret = mptcp_oppr_send_range(sk, ssk, oppr.r[i].start,
+					    oppr.r[i].end, budget - copied,
+					    &info);
+		if (ret < 0)
+			break;
+		copied += ret;
+	}
+
+	if (copied) {
+		/* once per snd_una value; after a failed send, the next
+		 * DATA_ACK tries again
+		 */
+		WRITE_ONCE(msk->oppr_una, oppr.una);
+		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
+			 info.size_goal);
+		msk->allow_infinite_fallback = false;
+		msk->bytes_retrans += copied;
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OPPREINJ);
+		MPTCP_ADD_STATS(sock_net(sk), MPTCP_MIB_OPPREINJBYTES, copied);
+	}
+unlock:
+	spin_unlock_bh(&msk->fallback_lock);
+	release_sock(ssk);
+}
+
 static void __mptcp_retrans(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -3295,6 +3381,9 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		__mptcp_retrans(sk);
 
+	if (test_and_clear_bit(MPTCP_WORK_OPPR, &msk->flags))
+		__mptcp_oppr(sk);
+
 	fail_tout = msk->first ? READ_ONCE(mptcp_subflow_ctx(msk->first)->fail_tout) : 0;
 	if (fail_tout && time_after(jiffies, fail_tout))
 		mptcp_mp_fail_no_response(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4e8920747682..39dd56d882ce 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -117,6 +117,7 @@
 #define MPTCP_FALLBACK_DONE	2
 #define MPTCP_WORK_CLOSE_SUBFLOW 3
 #define MPTCP_RTX_ENABLED	4
+#define MPTCP_WORK_OPPR		5
 
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
@@ -294,6 +295,40 @@ struct mptcp_data_frag {
  */
 #define MPTCP_RTT_SAMPLES	5
 
+/* Why get_retrans is called, in msk->sched_retrans */
+enum mptcp_sched_retrans {
+	/* the MPTCP-level retransmission timer fired */
+	MPTCP_SCHED_RETRANS_RTO,
+	/* A subflow is idle, nothing new can be sent, and other subflows
+	 * hold data the peer is waiting for. The core resends that data on
+	 * the subflow the scheduler marks, up to the reinject_limit bytes it
+	 * sets there: 0, the default, sends nothing. Nothing new can be sent
+	 * because:
+	 */
+	/* the peer's receive window is nearly full */
+	MPTCP_SCHED_RETRANS_IDLE_WND,
+	/* the application waits for send buffer space */
+	MPTCP_SCHED_RETRANS_IDLE_SNDBUF,
+	/* the application has nothing more to send for now */
+	MPTCP_SCHED_RETRANS_IDLE_APP,
+};
+
+#define MPTCP_OPPR_MAX_RANGES	32
+
+struct mptcp_oppr_range {
+	u64 start;
+	u64 end;
+};
+
+/* What __mptcp_oppr() resends: see mptcp_sched_oppr_get() */
+struct mptcp_sched_oppr {
+	struct sock *ssk;
+	u32 limit;
+	u64 una;
+	int n;
+	struct mptcp_oppr_range r[MPTCP_OPPR_MAX_RANGES];
+};
+
 /* MPTCP connection sock */
 struct mptcp_sock {
 	/* inet_connection_sock must be the first member */
@@ -310,6 +345,10 @@ struct mptcp_sock {
 	atomic64_t	rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
 	u64		bytes_retrans;
+	u64		oppr_una;	/* snd_una of the last opportunistic
+					 * reinjection, or of its refusal
+					 */
+	u8		sched_retrans;	/* enum mptcp_sched_retrans */
 	u64		bytes_consumed;
 	int		snd_burst;
 	int		old_wspace;
@@ -610,6 +649,9 @@ struct mptcp_subflow_context {
 				     * most this many bytes before it is
 				     * asked again; 0 for no limit
 				     */
+	u32	reinject_limit;	    /* set by the scheduler, on an
+				     * MPTCP_SCHED_RETRANS_IDLE_* reason
+				     */
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
 	bool	fully_established;  /* path validated */
 	bool	close_event_done;   /* has done the post-closed part,
@@ -888,6 +930,8 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
 int mptcp_sched_get_retrans(struct mptcp_sock *msk);
+bool mptcp_sched_oppr_get(struct mptcp_sock *msk,
+			  struct mptcp_sched_oppr *oppr);
 
 static inline u64 mptcp_data_avail(const struct mptcp_sock *msk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c8d193cb0e4c..da5fa8c0fb12 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -28,6 +28,31 @@ static int mptcp_sched_default_get_send(struct mptcp_sock *msk)
 	return 0;
 }
 
+/* the active subflow with nothing to send or retransmit and the lowest RTT */
+static struct sock *mptcp_sched_oppr_idle_ssk(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *pick = NULL;
+	u32 best = U32_MAX;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		u32 rtt = READ_ONCE(tcp_sk(ssk)->srtt_us);
+
+		if (!__mptcp_subflow_active(subflow) || subflow->backup ||
+		    subflow->request_bkup || subflow->stale || !rtt)
+			continue;
+		/* racy on a DATA_ACK, only a hint: the worker checks again */
+		if (!data_race(tcp_rtx_and_write_queues_empty(ssk)))
+			continue;
+		if (rtt < best) {
+			best = rtt;
+			pick = ssk;
+		}
+	}
+	return pick;
+}
+
 static int mptcp_sched_default_get_retrans(struct mptcp_sock *msk)
 {
 	struct sock *ssk;
@@ -217,3 +242,223 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 		return msk->sched->get_retrans(msk);
 	return msk->sched->get_send(msk);
 }
+
+/* Opportunistic reinjection, "opportunistic retransmission" in section 4.2
+ * of Raiciu et al., NSDI 2012.
+ *
+ * With paths of different speeds, data sent on a slow or lossy path holds
+ * back the DATA_ACK while the fast path keeps delivering what comes after
+ * it. Once the receive window or the send buffer is used up, nothing new
+ * can be sent: the fast path drains and stays idle until the slow path
+ * delivers, or until the MPTCP-level RTO fires. The same happens when the
+ * application has nothing more to send for now: the end of what it wrote
+ * waits on the slow path, and so does the application if it expects an
+ * answer.
+ *
+ * That state can be seen when a DATA_ACK comes in: no new data can go out,
+ * and an active subflow has nothing queued or in flight. The data at
+ * snd_una is then held by another subflow, so resend on the idle subflow
+ * the ranges that the other subflows still hold, taken from the DSS
+ * mappings in their queues, instead of everything from snd_una: most of
+ * that already reached the peer.
+ *
+ * The scheduler decides on which subflow, and how much, through get_retrans
+ * with the reason in msk->sched_retrans. This is done at most once per
+ * snd_una value.
+ */
+#define MPTCP_OPPR_MIN		(16 * 1024)
+
+/* can the scheduler be asked to reinject: see mptcp_sched_get_reinject() */
+static bool mptcp_sched_has_reinject(const struct mptcp_sock *msk)
+{
+	const struct mptcp_sched_ops *sched = READ_ONCE(msk->sched);
+
+	return sched && sched != &mptcp_sched_default && sched->get_retrans;
+}
+
+/* Ask the scheduler where to resend the data other subflows hold, because a
+ * subflow is idle while nothing new can be sent, for @reason: see
+ * MPTCP_SCHED_RETRANS_IDLE_WND. Only a scheduler with its own get_retrans is
+ * asked; the default one does not reinject.
+ */
+static int mptcp_sched_get_reinject(struct mptcp_sock *msk, u8 reason)
+{
+	struct mptcp_subflow_context *subflow;
+	int err;
+
+	msk_owned_by_me(msk);
+
+	if (__mptcp_check_fallback(msk))
+		return -EINVAL;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled))
+			return -EBUSY;
+		subflow->reinject_limit = 0;
+	}
+
+	if (!mptcp_sched_has_reinject(msk))
+		return -EOPNOTSUPP;
+
+	msk->sched_retrans = reason;
+	err = msk->sched->get_retrans(msk);
+	msk->sched_retrans = MPTCP_SCHED_RETRANS_RTO;
+	return err;
+}
+
+/* Why nothing new can go out while the peer waits for data: an
+ * MPTCP_SCHED_RETRANS_IDLE_* reason, or 0 when new data can still go out
+ * (the scheduler will then use the idle subflow) or nothing is waiting.
+ * Read without the msk socket lock when called from a DATA_ACK.
+ */
+static u8 mptcp_sched_oppr_reason(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	u64 snd_una = READ_ONCE(msk->snd_una);
+	struct socket *sock;
+
+	/* with csum, a resend must spool a complete DSS */
+	if (snd_una == READ_ONCE(msk->snd_nxt) ||
+	    snd_una == READ_ONCE(msk->oppr_una) ||
+	    READ_ONCE(msk->csum_enabled) || __mptcp_check_fallback(msk))
+		return 0;
+
+	/* only the DATA_FIN is waiting */
+	if (snd_una + 1 == READ_ONCE(msk->snd_nxt) &&
+	    mptcp_data_fin_enabled(msk))
+		return 0;
+
+	if (mptcp_send_head(sk)) {
+		if (mptcp_wnd_end(msk) - READ_ONCE(msk->snd_nxt) >= MPTCP_OPPR_MIN)
+			return 0;
+		return MPTCP_SCHED_RETRANS_IDLE_WND;
+	}
+
+	/* everything written so far was handed to a subflow */
+	sock = READ_ONCE(sk->sk_socket);
+	if (sock && test_bit(SOCK_NOSPACE, &sock->flags))
+		return MPTCP_SCHED_RETRANS_IDLE_SNDBUF;
+	return MPTCP_SCHED_RETRANS_IDLE_APP;
+}
+
+/* Add what @skb holds to @r, sorted by start. When @r is full, keep the lowest
+ * ones: the data at snd_una is the one the peer is waiting for.
+ */
+static int mptcp_sched_oppr_add_skb(const struct sk_buff *skb, u64 una,
+				    u64 *last, struct mptcp_oppr_range *r,
+				    int n)
+{
+	const struct mptcp_ext *mpext = mptcp_get_ext(skb);
+	u64 start, end;
+	int i;
+
+	if (!mpext || !mpext->use_map || !mpext->data_len ||
+	    mpext->data_seq == *last)
+		return n;
+
+	/* one mapping can span several skbs after a TCP split */
+	*last = mpext->data_seq;
+	start = mpext->data_seq;
+	end = start + mpext->data_len;
+	if (!after64(end, una))
+		return n;
+	if (before64(start, una))
+		start = una;
+
+	if (n == MPTCP_OPPR_MAX_RANGES) {
+		if (!before64(start, r[n - 1].start))
+			return n;
+		n--;
+	}
+
+	for (i = n; i > 0 && after64(r[i - 1].start, start); i--)
+		r[i] = r[i - 1];
+	r[i].start = start;
+	r[i].end = end;
+	return n + 1;
+}
+
+/* The DSN ranges at or after @una that the subflows other than @idle still
+ * hold, sent or not: the data the peer is waiting for. Sorted by start, and
+ * merged: data resent before can sit on more than one subflow.
+ */
+static int mptcp_sched_oppr_collect(struct mptcp_sock *msk, struct sock *idle,
+				    u64 una, struct mptcp_oppr_range *r)
+{
+	struct mptcp_subflow_context *subflow;
+	int n = 0, i, k;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		struct sk_buff *skb;
+		u64 last = 0;
+
+		if (ssk == idle)
+			continue;
+
+		lock_sock(ssk);
+		skb_rbtree_walk(skb, &ssk->tcp_rtx_queue)
+			n = mptcp_sched_oppr_add_skb(skb, una, &last, r, n);
+		skb_queue_walk(&ssk->sk_write_queue, skb)
+			n = mptcp_sched_oppr_add_skb(skb, una, &last, r, n);
+		release_sock(ssk);
+	}
+
+	for (i = 1, k = 0; i < n; i++) {
+		if (!after64(r[i].start, r[k].end)) {
+			if (after64(r[i].end, r[k].end))
+				r[k].end = r[i].end;
+		} else {
+			r[++k] = r[i];
+		}
+	}
+	return n ? k + 1 : 0;
+}
+
+/* What to resend from @oppr->una for an opportunistic reinjection, if anything:
+ * ask the scheduler, then take the ranges from the subflows. Called from the
+ * worker.
+ */
+bool mptcp_sched_oppr_get(struct mptcp_sock *msk,
+			  struct mptcp_sched_oppr *oppr)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	u8 reason;
+	int err;
+
+	/* no subflow to use yet: the next DATA_ACK checks again */
+	reason = mptcp_sched_oppr_reason(sk);
+	if (!reason || !mptcp_sched_oppr_idle_ssk(msk))
+		return false;
+
+	/* same with a send pending: new data is about to go out */
+	err = mptcp_sched_get_reinject(msk, reason);
+	if (err == -EBUSY)
+		return false;
+
+	oppr->ssk = NULL;
+	oppr->limit = 0;
+	oppr->n = 0;
+	mptcp_for_each_subflow(msk, subflow) {
+		if (!READ_ONCE(subflow->scheduled))
+			continue;
+		if (!err && !oppr->ssk && subflow->reinject_limit) {
+			oppr->ssk = mptcp_subflow_tcp_sock(subflow);
+			oppr->limit = subflow->reinject_limit;
+		}
+		mptcp_subflow_set_scheduled(subflow, false);
+	}
+
+	/* the scheduler declined, or nothing to resend: not again for this
+	 * snd_una
+	 */
+	if (oppr->ssk)
+		oppr->n = mptcp_sched_oppr_collect(msk, oppr->ssk, oppr->una,
+						   oppr->r);
+	if (!oppr->n) {
+		WRITE_ONCE(msk->oppr_una, oppr->una);
+		return false;
+	}
+	return true;
+}

-- 
2.55.0

