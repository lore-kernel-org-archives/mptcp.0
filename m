Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793486696;
	b=ImLo0566eqvNI5kuS92GbG1VMlcg0jSiKza/tuq1UqDFjCZCQAinBfplXf7eBKi6RnZh
	 Rfbn2HbYHAe0QEp27apmsiRFYbsf2byfY7mKubE6yreisNOfvza/cR0Elu8B7CxSxb+HZ
	 IQiJHr1hwA3UGcX9zp/yF5uIKPZ2smKYmpaa8HaWODqrN2FQacFazwx/kXZkoVzQXi56K
	 Lj3bGLQgu9Zx6c5keEYMWza/62E5u20d9Nz07nSdYkBavrO16ttdnmaKCjFKmw18dHGRL
	 gIrUlfdKQwl/xwgJpOKlVRgCAX+yJuPNjT9t57S2mCL6coCNCcRfraWb6Vw1xsfsibw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793486696;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=7/bh29xQqE8r8O9dTn62Z7e0qkplchHRC19jY7cOqlI=;
	b=jJhUG07WDleSepXpqa44OzsmaRmfmQ2O9Dnp5olp/A0fXmBXMiHr13IzBgWjnjICC18q
	 L39mtshPCKWTZhrJZfKC1ZTM8A9oPABZuvZmL9II6qi5CYU5n6dO74s4CzXdulAD0s1yS
	 bSe906xJL4WKe6xn48Mqx1VnT75s58aOHjID3YapjBY50ugUEPBQUV4qplz/fFi3nIIHF
	 AFQf1XmGgEi8M60gtE8XR12LWJj/w9QqqjRIXO9tnIWIEBqt5PtT3d5f0KgwvNjPxMhOl
	 C9diydIpIRKwE2zdVLjw8bYOGdbcmt1j68GcMPo85ToIsnkXBbtmebNMwJteGXyzfzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JGqmZ3w6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1B9606A31A
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 22:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JGqmZ3w6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B607D1F000C1;
	Sat, 31 Oct 2026 22:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793486695;
	bh=7/bh29xQqE8r8O9dTn62Z7e0qkplchHRC19jY7cOqlI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JGqmZ3w6/fgv57oo5hpTczUkZUYucHTo61hVzZph+z8aNHjMYBOhBJil6Aq/jPAs+
	 QA7lwQ42bdSRrhuR0s7NvL14JWELnm4rfP8kftvXTj5aavLcSFcHS3RQtYF9Rcm5NK
	 MBrbJ+PT/ftmcYqkJ8jrfdLtg71e9iqFznBZG6IvXXoJGIvo9sIjP+u31C0PweyZxC
	 5s6B7S1FmQxlMA9449kaW3jrG3Tl2Y1IEqQEO8HokbIyHefjz+FzNmLFsOgSoA/a3S
	 /4kGCwf7yJwKGacA4Xb4TndHGCOfclropeUQ4LrV+5hDUL4bFH+KvtwLs1u0C+yL0N
	 G8m3xNE7og4UQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 31 Oct 2026 23:44:37 +0100
Subject: [PATCH mptcp-next v2 5/8] mptcp: sched: reinject on an idle
 subflow with the default scheduler
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
Message-Id: <20261031-mptcp-sched-opp-retrans-v2-5-e9c4a30f6841@kernel.org>
References: <20261031-mptcp-sched-opp-retrans-v2-0-e9c4a30f6841@kernel.org>
In-Reply-To: <20261031-mptcp-sched-opp-retrans-v2-0-e9c4a30f6841@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Abdul Wasey <w453y.me@gmail.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10330; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mPer2Dt9JbZP4xvhLsgCxM7P3fH/vWFtvT4UR9qZzc0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLKe5cf9s1sZwDvxneD1O+I3BFg0Em9yVottFMrgD9F/l
 rvg0Iy0jlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIm8fcTwv25vgVnE+q9sAmJH
 DQtEX/d8unS4ovb9juaTL0xkrI59fcjI0PLY83nt7V+xvdu821//zWeZ9PjBP4VfPT4FbFNWG91
 9wAkA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Abdul Wasey <w453y.me@gmail.com>

Let the default scheduler use the reinjection added by the previous
patches. On an IDLE reason, it picks the active non-backup subflow with
nothing queued or in flight and the lowest RTT, and resends there only
the data held by a subflow that is gone, or slower than the idle one
with an RTT long enough for a copy to arrive at least one RTT of the
idle subflow sooner. Below that, the copies cost the idle subflow more
than they save, and on subflows of similar RTT nothing is resent. The
limit is what the idle subflow can send in the time the copies save, at
most 256 KB, or 256 KB when the slow subflow is gone.

A subflow that had a retransmission timeout without progress since is
not counted as slow: it may be broken, and the stale detection needs the
MPTCP-level timeouts that copies would avoid.

A subflow is gone when it cannot send anymore but still holds data: not
when it is joining, as it only holds a SYN, nor when it is closed, even
if its queues do not look empty after a tcp_disconnect().

With more than two subflows, only what these subflows hold is resent,
and the check on each DATA_ACK uses the same condition: the worker is
only woken when there is something worth resending.

Two subflows in netns, netem on both directions, one download, at least
5 runs each, tcp_rmem max 6 MB:

- 40M/10ms + 2M/250ms with 5% loss: BBR 27-30 -> 37-38 Mbit/s,
  CUBIC 9-35 -> 37-38.
- 400M/10ms + 15M/120ms: BBR 67-82 -> 320-332 Mbit/s, CUBIC 30-142 ->
  322-345.
- 1 MB request/response, p95 completion time in ms:
  40M/10 + 2M/250 5%: 2396 -> 317; 400M/10 + 15M/120: 530 -> 104.
  The copies are 1 to 3% of the bytes sent.
- 50M/10 + 50M/10: nothing resent, results unchanged.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/332
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sched.c | 140 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 128 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 087b36381e7a..b70e4a690817 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -28,6 +28,9 @@ static int mptcp_sched_default_get_send(struct mptcp_sock *msk)
 	return 0;
 }
 
+#define MPTCP_OPPR_BUDGET	(256 * 1024)
+#define MPTCP_OPPR_GONE		U32_MAX
+
 /* the active subflow with nothing to send or retransmit and the lowest RTT */
 static struct sock *mptcp_sched_oppr_idle_ssk(struct mptcp_sock *msk)
 {
@@ -53,11 +56,98 @@ static struct sock *mptcp_sched_oppr_idle_ssk(struct mptcp_sock *msk)
 	return pick;
 }
 
+/* How much earlier, in us, a copy sent now on @idle would reach the peer
+ * than the data held by @subflow: about half an RTT of each, the current one
+ * of @subflow and the base one of @idle, whose queue is empty. 0 if @subflow
+ * holds nothing, is not slower than @idle, or if the copy would not save at
+ * least one RTT of @idle: with a smaller gain, the copies cost more than they
+ * save. MPTCP_OPPR_GONE if @subflow is gone.
+ */
+static u32 mptcp_sched_oppr_gain(struct mptcp_subflow_context *subflow,
+				 const struct sock *idle)
+{
+	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+	u32 srtt, min_rtt;
+
+	/* racy on a DATA_ACK, only a hint: the worker checks again */
+	if (ssk == idle || data_race(tcp_rtx_and_write_queues_empty(ssk)))
+		return 0;
+
+	/* A joining subflow only holds its SYN, and a closed one nothing, even
+	 * if its queues look used: tcp_disconnect() moves the write_seq.
+	 */
+	if ((1 << inet_sk_state_load(ssk)) &
+	    (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_CLOSE))
+		return 0;
+
+	if (!__mptcp_subflow_active(subflow))
+		return MPTCP_OPPR_GONE;
+
+	/* A retransmission timeout without progress since: the subflow may
+	 * be broken, which the stale detection handles (it needs the
+	 * MPTCP-level timeouts that copies would avoid).
+	 */
+	if (READ_ONCE(inet_csk(ssk)->icsk_retransmits))
+		return 0;
+
+	srtt = READ_ONCE(tcp_sk(ssk)->srtt_us) >> 3;
+	/* same here, @idle is not locked */
+	min_rtt = data_race(tcp_min_rtt(tcp_sk(idle)));
+	if (READ_ONCE(ssk->sk_pacing_rate) >= READ_ONCE(idle->sk_pacing_rate) ||
+	    min_rtt == ~0U || srtt <= 3 * min_rtt)
+		return 0;
+	return (srtt - min_rtt) / 2;
+}
+
+/* The largest gain of the subflows, 0 if nothing is worth resending on @idle */
+static u32 mptcp_sched_oppr_max_gain(struct mptcp_sock *msk,
+				     const struct sock *idle)
+{
+	struct mptcp_subflow_context *subflow;
+	u32 gain = 0;
+
+	mptcp_for_each_subflow(msk, subflow)
+		gain = max(gain, mptcp_sched_oppr_gain(subflow, idle));
+	return gain;
+}
+
+/* The default scheduler's choice on an MPTCP_SCHED_RETRANS_IDLE_* reason,
+ * whichever it is: the idle subflow with the lowest RTT, if another subflow
+ * holds data worth resending on it. The limit is what the idle subflow can
+ * send in the time the copies save; a subflow that is gone saves an MPTCP
+ * RTO.
+ */
+static struct sock *mptcp_sched_oppr_default(struct mptcp_sock *msk)
+{
+	struct sock *idle;
+	u64 limit;
+	u32 gain;
+
+	idle = mptcp_sched_oppr_idle_ssk(msk);
+	if (!idle)
+		return NULL;
+
+	gain = mptcp_sched_oppr_max_gain(msk, idle);
+	if (!gain)
+		return NULL;
+
+	limit = MPTCP_OPPR_BUDGET;
+	if (gain != MPTCP_OPPR_GONE)
+		limit = min_t(u64, limit,
+			      div_u64((u64)READ_ONCE(idle->sk_pacing_rate) * gain,
+				      USEC_PER_SEC));
+	mptcp_subflow_ctx(idle)->reinject_limit = limit;
+	return idle;
+}
+
 static int mptcp_sched_default_get_retrans(struct mptcp_sock *msk)
 {
 	struct sock *ssk;
 
-	ssk = mptcp_subflow_get_retrans(msk);
+	if (msk->sched_retrans != MPTCP_SCHED_RETRANS_RTO)
+		ssk = mptcp_sched_oppr_default(msk);
+	else
+		ssk = mptcp_subflow_get_retrans(msk);
 	if (!ssk)
 		return -EINVAL;
 
@@ -263,23 +353,36 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
  * that already reached the peer.
  *
  * The scheduler decides on which subflow, and how much, through get_retrans
- * with the reason in msk->sched_retrans. This is done at most once per
- * snd_una value.
+ * with the reason in msk->sched_retrans. The default one resends only data
+ * held by a subflow that is gone, or that is slower than the idle one and
+ * whose RTT is long enough for a copy to arrive at least one RTT of the
+ * idle subflow sooner. Below that, the copies cost the idle subflow more
+ * than they save. This is done at most once per snd_una value, and at most
+ * what the idle subflow can send in the time saved, or MPTCP_OPPR_BUDGET for
+ * a subflow that is gone.
  */
 #define MPTCP_OPPR_MIN		(16 * 1024)
 
+/* the in-kernel default scheduler */
+static bool mptcp_sched_is_default(const struct mptcp_sock *msk)
+{
+	const struct mptcp_sched_ops *sched = READ_ONCE(msk->sched);
+
+	return !sched || sched == &mptcp_sched_default;
+}
+
 /* can the scheduler be asked to reinject: see mptcp_sched_get_reinject() */
 static bool mptcp_sched_has_reinject(const struct mptcp_sock *msk)
 {
 	const struct mptcp_sched_ops *sched = READ_ONCE(msk->sched);
 
-	return sched && sched != &mptcp_sched_default && sched->get_retrans;
+	return !sched || sched->get_retrans;
 }
 
 /* Ask the scheduler where to resend the data other subflows hold, because a
  * subflow is idle while nothing new can be sent, for @reason: see
- * MPTCP_SCHED_RETRANS_IDLE_WND. Only a scheduler with its own get_retrans is
- * asked; the default one does not reinject.
+ * MPTCP_SCHED_RETRANS_IDLE_WND. Only the default scheduler and one with its
+ * own get_retrans are asked.
  */
 static int mptcp_sched_get_reinject(struct mptcp_sock *msk, u8 reason)
 {
@@ -301,7 +404,10 @@ static int mptcp_sched_get_reinject(struct mptcp_sock *msk, u8 reason)
 		return -EOPNOTSUPP;
 
 	msk->sched_retrans = reason;
-	err = msk->sched->get_retrans(msk);
+	if (mptcp_sched_is_default(msk))
+		err = mptcp_sched_default_get_retrans(msk);
+	else
+		err = msk->sched->get_retrans(msk);
 	msk->sched_retrans = MPTCP_SCHED_RETRANS_RTO;
 	return err;
 }
@@ -344,14 +450,20 @@ static u8 mptcp_sched_oppr_reason(struct sock *sk)
 /* called on each DATA_ACK, or when the msk socket lock is released if a process
  * owned it: see __mptcp_check_oppr(). Under the msk data lock, with a stable
  * subflow list. The worker takes the msk socket lock, which delays the receive
- * path, so wake it only when the scheduler may reinject: if a subflow is idle.
+ * path, so wake it only when the scheduler may reinject: when a subflow is idle
+ * and, for the default one, when mptcp_sched_oppr_default() would pick it.
  */
 void mptcp_sched_oppr_check(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sock *idle;
 
-	if (!mptcp_sched_has_reinject(msk) || !mptcp_sched_oppr_reason(sk) ||
-	    !mptcp_sched_oppr_idle_ssk(msk))
+	if (!mptcp_sched_has_reinject(msk) || !mptcp_sched_oppr_reason(sk))
+		return;
+
+	idle = mptcp_sched_oppr_idle_ssk(msk);
+	if (!idle || (mptcp_sched_is_default(msk) &&
+		      !mptcp_sched_oppr_max_gain(msk, idle)))
 		return;
 
 	if (!test_and_set_bit(MPTCP_WORK_OPPR, &msk->flags))
@@ -396,8 +508,9 @@ static int mptcp_sched_oppr_add_skb(const struct sk_buff *skb, u64 una,
 }
 
 /* The DSN ranges at or after @una that the subflows other than @idle still
- * hold, sent or not: the data the peer is waiting for. Sorted by start, and
- * merged: data resent before can sit on more than one subflow.
+ * hold, sent or not: the data the peer is waiting for. With the default
+ * scheduler, only from the subflows this is worth it for. Sorted by start,
+ * and merged: data resent before can sit on more than one subflow.
  */
 static int mptcp_sched_oppr_collect(struct mptcp_sock *msk, struct sock *idle,
 				    u64 una, struct mptcp_oppr_range *r)
@@ -412,6 +525,9 @@ static int mptcp_sched_oppr_collect(struct mptcp_sock *msk, struct sock *idle,
 
 		if (ssk == idle)
 			continue;
+		if (mptcp_sched_is_default(msk) &&
+		    !mptcp_sched_oppr_gain(subflow, idle))
+			continue;
 
 		lock_sock(ssk);
 		skb_rbtree_walk(skb, &ssk->tcp_rtx_queue)

-- 
2.55.0

