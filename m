Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792936013;
	b=4E2yM9fqFbeutz9hIL/B6Kh/4Cre0pK+Oetu64mCSXnBz6CmcZn6D+AWahmYx5BnO0mM
	 ko3k4rXlFhSqiLt1/OlGObMsqkGpo/pxfQM3Kfs8ZyahlYj2dpnDQZqLhHtzqFvumzTqV
	 aHeGYCN8C/xIS/VYM6SnSRAsfzFNZUR+LRoEmUwgm75zwX5wV+v2koagP9x/wprcMtyBz
	 1AHQpdNXePEFNShiZvV0lk7xtJnlKV78iJ0P6PPM5e1mfj0RlncEvovLsQH1XsItOYe0r
	 t36QbIkG4ycD2i5Zb0I562utZuDpwfIM967sbmdBEXMiFaJ5cXx/uiI9wVjFF/CAbCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792936013;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+mlyc5NaNFRu3TVjNMSuv7CxuBw0hydMFOnWhvootWM=;
	b=Z696BiJYiKaO0LQo5mGd58/NBM58XroOlpyiu/7zRafHuS8ruQx+RNNh8eX8rCwexU2Z
	 OdVLb8OfReL0LjbhFyaxFXWPItGgrBdnJE0dW/eNC5Gd0k2QN//TMLBZaMZDwZcZr7JYw
	 UE1Kgb9F32dV4Ntkr1Zl75jjGATjR5C1X2KBXYR9rdFqh/hMNAaz/Vm2WkunpoKljdRnO
	 qADFGrWLbY0WJX503YPY1s+2fgYdyyX7sTZkLrOGC0aOI7Yk2MSw7vd4daBEl7KFno2U0
	 IcdHBNwliJVL51PLhUJaLTbJcP9oIYqFp2es2+BZXu908CFB1AnYQb78B+JTXcxV4AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lEINeou8;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04627606A31A
	for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 13:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04627606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lEINeou8
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so3685806eec.0
        for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 06:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792936012; x=1793540812; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+mlyc5NaNFRu3TVjNMSuv7CxuBw0hydMFOnWhvootWM=;
        b=lEINeou8TZRa7jHgLa9k/Y28A2uk8SjsZfgOZccJ96msyRQQa7c8PkB/vDF+XfVdyF
         7/aXSQYq6OYVCQRGtT181lcLmbilXhpon3lRCViWZvFLOfwbkzJO7Em0oxgFidnNrHiW
         gI7xyD8n38tPMcHyE5i/I1uJkzFEKF6o5B8VXJiqXaCKlejbbnHGf8j9ipABTou4QuZs
         q3T8TWjlv7DitoL2DugRnIWgyJgUn+nm+AUgNDrsk2vVhgkUBbEM41NAEHR4suUQmRWh
         7wYNt59fxQUd2s+JVhcU+IyQP9GRLnj+8xtPErfUj5fQPzh6w/8Qym+AnqW4samzd3sV
         qEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792936012; x=1793540812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+mlyc5NaNFRu3TVjNMSuv7CxuBw0hydMFOnWhvootWM=;
        b=ci89TjqYwWJuFmoXTm0/O/FzXD/L+dlSi5p0KoL4bEfA+PSMIRfsQWyNYoC0VXZBFU
         Y/lbRPlDkXjveq+0kR7WyJByFHbHvuyjRAghNF22TGOorN9jegz4zJRs/GeoTMlTixpn
         HDanv10M4zJO7lWMHyHViM138mzBBXQrRFTWuWhRbpSIy/Uw3kwCWN+FgqeoDceu0ALd
         DqBj2KxoGDin6R/kWsG2nIGSomIuIzonuq4C6RO44JEo5ZaWDk43Gz3HjA4OMsULyntf
         jHgWp3KvFBVlhd6Fl6PxJx0m1Op4MCGxBWajcc8vwQGIym0cprv8uScKZWFl1YiTG4Sx
         v00w==
X-Gm-Message-State: AFq9FYI2qksRLEeb84YRuK4Hni989N21QNlkj8EQBOgYo0eXVA/tPZLK
	aEIaXPhTNbpecRDnSsyLjjZ2Lf667PENvzm5AECf/wdcZ0vwOjtvYvmAlCP3iA==
X-Gm-Gg: AYBFou2HqZOUB1sXhay2ORfgWFjqTjEPDmOknl8ZMYdfswUg+K2r/fPZayulZwxADHD
	Rg4JXGCO1nMVaJfBk0eRWiHxgNtxGD5cbSGjR6Oq/C/JMGe+1Cq/O+2UfAnINlSL9EIgkVN5WyD
	cDaWfcv3hMhSFeVjTp2HpJRkmRkYPAYkCHUDhs7BqK4qAf0WH03q2/0TPJtOeKJag3ynnMvsHp8
	xUucbYBATmnmCHeopVc4zwB6DhfZ1sw+DidtKqhyF/HSeqYf0dfJigp8PxBCnyXwZYj53Nh+pJX
	ioemkmTskY3Niu6ZmGuvdeTUcCfG4Gr3mWazrRpDWmdJTRuzTEoUSX2d3itlMkG2yZpP05qCsss
	usd1Rek2N1hQxZ8AlPpEpqR9z92bSAcgWhpiLi7iJ/sPZmdh+/XvX7JTzGAI3w46/MXGo/+hhOt
	0yRmBtC91sJQp5XPGb/BhSFmYJkErKMAVB2wV4KOfbbuq8Y1ZMCfBoywn4VUetJnJj0m90KUS3z
	EbEWc0gSLPaehyWNiQcgBuMyDygoMCwSYFjY9Bjg/G1HW/O9tbn8mDY647B
X-Received: by 2002:a05:7022:43a0:b0:182:9071:3249 with SMTP id a92af1059eb24-19936b55bbfmr9247023c88.30.1792936011768;
        Sun, 25 Oct 2026 06:46:51 -0700 (PDT)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee5asm14740436c88.8.2026.10.25.06.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 06:46:51 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [RFC PATCH mptcp-next 1/1] mptcp: opportunistic reinjection on an idle subflow
Date: Sun, 25 Oct 2026 13:46:42 +0000
Message-ID: <20261025134643.1537069-2-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261025134643.1537069-1-w453y.me@gmail.com>
References: <20261025134643.1537069-1-w453y.me@gmail.com>
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

With subflows of different speeds, data sent on a slow or lossy one holds
back the DATA_ACK while the fast one keeps delivering what comes after
it. Once the receive window or the send buffer is used up, nothing new
can be sent: the fast subflow drains and stays idle until the slow one
delivers, or until the MPTCP-level retransmission timer fires.

This is the "opportunistic retransmission" of section 4.2 of Raiciu et
al., NSDI 2012, which the out-of-tree kernel had in
mptcp_rcv_buf_optimization(). When a DATA_ACK shows that no new data can
go out while an active subflow has nothing queued or in flight, resend
on that subflow the DSN ranges the other subflows still hold, read from
the DSS mappings in their queues: resending everything from snd_una
would mostly duplicate data the peer already has.

Only the data of a subflow that is gone, or of one slower than the idle
subflow and with an RTT long enough for the copies to arrive at least
one RTT of the idle subflow sooner, is resent. A subflow that had a
retransmission timeout and no progress since may be broken: it is left
to the stale detection, which needs the MPTCP-level timeouts the copies
would avoid. At most once per snd_una value, and at most what the idle
subflow can send in the time saved: between paths of similar RTTs the
copies would only take capacity from the idle subflow.

In a 2-path netns setup with the default tcp_rmem, a single download
(Mbit/s, runs without / with the patch):
- 400 Mbit/20 ms + 15 Mbit/240 ms: 67-82 -> 320-332 with BBR (6 / 6),
  30-142 -> 322-345 with CUBIC (6 / 3);
- 40 Mbit/20 ms + 2 Mbit/500 ms with 5% loss: median 19 -> 34 with BBR
  (16 / 16), 21 -> 37 with CUBIC (16 / 13). 3 of the 16 BBR runs gain
  less (14-23).
Uploads gain the same: 72-76 -> 321-328 and 9-28 -> 34-37 with BBR,
32-134 -> 317-331 and 4-18 -> 37 with CUBIC (3 runs each).
Balanced paths, two lossy paths, a slow path with a deep buffer and
jittery 4G-like paths stay within the noise in both directions, also
with a 32 MB tcp_rmem, and simult_flows.sh times are the same as without
this patch (16 runs each; its opposed, unbalanced delay case missed the
time limit once with and once without it).

Two new MIB counters, OppReinject and OppReinjectBytes, count the events
and the bytes resent.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/332
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 net/mptcp/mib.c      |   2 +
 net/mptcp/mib.h      |   2 +
 net/mptcp/options.c  |   1 +
 net/mptcp/protocol.c | 291 +++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |   3 +
 5 files changed, 299 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 608cb568897c..5ef574679bd1 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -95,6 +95,8 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("BacklogDrop", MPTCP_MIB_BACKLOGDROP),
 	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
 	SNMP_MIB_ITEM("OFOPruned", MPTCP_MIB_OFOPRUNED),
+	SNMP_MIB_ITEM("OppReinject", MPTCP_MIB_OPPREINJ),
+	SNMP_MIB_ITEM("OppReinjectBytes", MPTCP_MIB_OPPREINJBYTES),
 };
 
 /* mptcp_mib_alloc - allocate percpu mib counters
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 1ebdb55e9534..e700b17b8e5d 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -98,6 +98,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_BACKLOGDROP,		/* Backlog over memory limit */
 	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constraints */
 	MPTCP_MIB_OFOPRUNED,		/* MPTCP-level OoO queue pruned */
+	MPTCP_MIB_OPPREINJ,		/* Opportunistic reinjections on an idle subflow */
+	MPTCP_MIB_OPPREINJBYTES,	/* Bytes sent by opportunistic reinjections */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index adbf8e0773db..b2b4e6b23b6b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1154,6 +1154,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
 		__mptcp_data_acked(sk);
 	}
 	msk->last_ack_recv = tcp_jiffies32;
+	mptcp_oppr_check(sk);
 	mptcp_data_unlock(sk);
 
 	trace_ack_update_msk(mp_opt->data_ack,
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 02a4f479d9d8..cd9aebd66b1e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2964,6 +2964,294 @@ static int __mptcp_push_retrans(struct sock *sk, struct mptcp_data_frag *dfrag,
 	return len;
 }
 
+/* Opportunistic reinjection, "opportunistic retransmission" in section 4.2
+ * of Raiciu et al., NSDI 2012.
+ *
+ * With paths of different speeds, data sent on a slow or lossy path holds
+ * back the DATA_ACK while the fast path keeps delivering what comes after
+ * it. Once the receive window or the send buffer is used up, nothing new
+ * can be sent: the fast path drains and stays idle until the slow path
+ * delivers, or until the MPTCP-level RTO fires.
+ *
+ * That state can be seen when a DATA_ACK comes in: no new data can go out,
+ * and an active subflow has nothing queued or in flight. The data at
+ * snd_una is then held by another subflow, so resend on the idle subflow
+ * the ranges that the other subflows still hold, taken from the DSS
+ * mappings in their queues, instead of everything from snd_una: most of
+ * that already reached the peer.
+ *
+ * Only data held by a subflow that is gone, or that is slower than the
+ * idle one and whose RTT is long enough for a copy to arrive at least one
+ * RTT of the idle subflow sooner. Below that, the copies cost the idle
+ * subflow more than they save. This is done at most once per snd_una
+ * value, and at most what the idle subflow can send in the time saved.
+ */
+#define MPTCP_OPPR_MIN		(16 * 1024)
+#define MPTCP_OPPR_BUDGET	(256 * 1024)
+#define MPTCP_OPPR_MAX_RANGES	32
+
+struct mptcp_oppr_range {
+	u64 start;
+	u64 end;
+};
+
+/* the active subflow with nothing to send or retransmit and the lowest RTT */
+static struct sock *mptcp_oppr_idle_ssk(struct mptcp_sock *msk)
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
+		if (!tcp_rtx_and_write_queues_empty(ssk))
+			continue;
+		if (rtt < best) {
+			best = rtt;
+			pick = ssk;
+		}
+	}
+	return pick;
+}
+
+static bool mptcp_oppr_blocked(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	u64 snd_una = READ_ONCE(msk->snd_una);
+
+	if (snd_una == READ_ONCE(msk->snd_nxt) ||
+	    snd_una == READ_ONCE(msk->oppr_una) ||
+	    __mptcp_check_fallback(msk))
+		return false;
+
+	/* new data can still go out: the scheduler will use the idle subflow */
+	if (mptcp_send_head(sk) &&
+	    mptcp_wnd_end(msk) - READ_ONCE(msk->snd_nxt) >= MPTCP_OPPR_MIN)
+		return false;
+	return true;
+}
+
+/* How much earlier, in us, a copy sent now on @idle would reach the peer
+ * than the data held by @ssk: about half an RTT of each, the current one of
+ * @ssk and the base one of @idle, whose queue is empty. 0 if @ssk is not
+ * slower than @idle, or if the copy would not save at least one RTT of
+ * @idle: with a smaller gain, the copies cost more than they save.
+ */
+static u32 mptcp_oppr_gain(const struct sock *ssk, const struct sock *idle)
+{
+	u32 srtt = READ_ONCE(tcp_sk(ssk)->srtt_us) >> 3;
+	u32 min_rtt = tcp_min_rtt(tcp_sk(idle));
+
+	/* A retransmission timeout without progress since: the subflow may
+	 * be broken, which the stale detection handles (it needs the
+	 * MPTCP-level timeouts that copies would avoid).
+	 */
+	if (READ_ONCE(inet_csk(ssk)->icsk_retransmits))
+		return 0;
+	if (READ_ONCE(ssk->sk_pacing_rate) >= READ_ONCE(idle->sk_pacing_rate) ||
+	    min_rtt == ~0U || srtt <= 3 * min_rtt)
+		return 0;
+	return (srtt - min_rtt) / 2;
+}
+
+/* Does a subflow other than @idle hold data worth resending on it: one
+ * that is gone, or one slow enough for the copies to arrive sooner?
+ */
+static bool mptcp_oppr_worth(struct mptcp_sock *msk, struct sock *idle)
+{
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		if (ssk == idle || tcp_rtx_and_write_queues_empty(ssk))
+			continue;
+		if (!__mptcp_subflow_active(subflow) ||
+		    mptcp_oppr_gain(ssk, idle))
+			return true;
+	}
+	return false;
+}
+
+/* called on each DATA_ACK, under the msk data lock */
+void mptcp_oppr_check(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sock *idle;
+
+	if (!mptcp_oppr_blocked(sk))
+		return;
+	idle = mptcp_oppr_idle_ssk(msk);
+	if (!idle || !mptcp_oppr_worth(msk, idle))
+		return;
+	if (!test_and_set_bit(MPTCP_WORK_OPPR, &msk->flags))
+		mptcp_schedule_work(sk);
+}
+
+static int mptcp_oppr_add_skb(const struct sk_buff *skb, u64 una, u64 *last,
+			      struct mptcp_oppr_range *r, int n)
+{
+	const struct mptcp_ext *mpext = mptcp_get_ext(skb);
+	u64 start, end;
+
+	if (!mpext || !mpext->use_map || !mpext->data_len ||
+	    mpext->data_seq == *last || n >= MPTCP_OPPR_MAX_RANGES)
+		return n;
+
+	/* one mapping can span several skbs after a TCP split */
+	*last = mpext->data_seq;
+	start = mpext->data_seq;
+	end = start + mpext->data_len;
+	if (!after64(end, una))
+		return n;
+
+	r[n].start = before64(start, una) ? una : start;
+	r[n].end = end;
+	return n + 1;
+}
+
+/* The DSN ranges at or after @una that the subflows slower than @idle still
+ * hold, sent or not: the data the peer is waiting for. Sorted by start.
+ * @gain is set to the largest time the copies can save.
+ */
+static int mptcp_oppr_collect(struct mptcp_sock *msk, struct sock *idle,
+			      u64 una, struct mptcp_oppr_range *r, u32 *gain)
+{
+	struct mptcp_subflow_context *subflow;
+	int n = 0, i, k;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		struct sk_buff *skb;
+		u64 last = 0;
+		u32 g = 0;
+
+		if (ssk == idle)
+			continue;
+		if (__mptcp_subflow_active(subflow)) {
+			g = mptcp_oppr_gain(ssk, idle);
+			if (!g)
+				continue;
+		}
+		*gain = max(*gain, g);
+
+		lock_sock(ssk);
+		skb_rbtree_walk(skb, &ssk->tcp_rtx_queue)
+			n = mptcp_oppr_add_skb(skb, una, &last, r, n);
+		skb_queue_walk(&ssk->sk_write_queue, skb)
+			n = mptcp_oppr_add_skb(skb, una, &last, r, n);
+		release_sock(ssk);
+	}
+
+	for (i = 1; i < n; i++) {
+		struct mptcp_oppr_range t = r[i];
+
+		for (k = i; k > 0 && after64(r[k - 1].start, t.start); k--)
+			r[k] = r[k - 1];
+		r[k] = t;
+	}
+	return n;
+}
+
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
+static void __mptcp_oppr(struct sock *sk)
+{
+	struct mptcp_sendmsg_info info = { .data_lock_held = true, };
+	struct mptcp_oppr_range r[MPTCP_OPPR_MAX_RANGES];
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	int copied = 0, budget, ret, n, i;
+	struct sock *ssk;
+	u32 gain = 0;
+	u64 una;
+
+	mptcp_data_lock(sk);
+	__mptcp_clean_una_wakeup(sk);
+	mptcp_data_unlock(sk);
+
+	/* with csum, the retransmission could send new data */
+	if (!mptcp_oppr_blocked(sk) || READ_ONCE(msk->csum_enabled))
+		return;
+	ssk = mptcp_oppr_idle_ssk(msk);
+	if (!ssk || !mptcp_rtx_head(sk))
+		return;
+
+	una = msk->snd_una;
+	WRITE_ONCE(msk->oppr_una, una);
+	n = mptcp_oppr_collect(msk, ssk, una, r, &gain);
+	if (!n)
+		return;
+
+	lock_sock(ssk);
+	/* The copies delay what @ssk sends next: no more than it can send in
+	 * the time they save. A subflow that is gone saves an MPTCP RTO.
+	 */
+	budget = min_t(int, MPTCP_OPPR_BUDGET,
+		       tcp_snd_cwnd(tcp_sk(ssk)) * tcp_sk(ssk)->mss_cache);
+	if (gain)
+		budget = min_t(u64, budget,
+			       div_u64((u64)READ_ONCE(ssk->sk_pacing_rate) * gain,
+				       USEC_PER_SEC));
+
+	spin_lock_bh(&msk->fallback_lock);
+	if (__mptcp_check_fallback(msk) || !msk->allow_subflows)
+		goto unlock;
+
+	for (i = 0; i < n && copied < budget; i++) {
+		ret = mptcp_oppr_send_range(sk, ssk, r[i].start, r[i].end,
+					    budget - copied, &info);
+		if (ret < 0)
+			break;
+		copied += ret;
+	}
+
+	if (copied) {
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
@@ -3202,6 +3490,9 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		__mptcp_retrans(sk);
 
+	if (test_and_clear_bit(MPTCP_WORK_OPPR, &msk->flags))
+		__mptcp_oppr(sk);
+
 	fail_tout = msk->first ? READ_ONCE(mptcp_subflow_ctx(msk->first)->fail_tout) : 0;
 	if (fail_tout && time_after(jiffies, fail_tout))
 		mptcp_mp_fail_no_response(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3be60da12924..5bd0f0479f9e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -117,6 +117,7 @@
 #define MPTCP_FALLBACK_DONE	2
 #define MPTCP_WORK_CLOSE_SUBFLOW 3
 #define MPTCP_RTX_ENABLED	4
+#define MPTCP_WORK_OPPR		5
 
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
@@ -310,6 +311,7 @@ struct mptcp_sock {
 	atomic64_t	rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
 	u64		bytes_retrans;
+	u64		oppr_una;	/* snd_una at the last opportunistic reinjection */
 	u64		bytes_consumed;
 	int		snd_burst;
 	int		old_wspace;
@@ -1003,6 +1005,7 @@ static inline u64 mptcp_expand_seq(u64 old_seq, u64 cur_seq, bool use_64bit)
 }
 void __mptcp_check_push(struct sock *sk, struct sock *ssk);
 void __mptcp_data_acked(struct sock *sk);
+void mptcp_oppr_check(struct sock *sk);
 void __mptcp_error_report(struct sock *sk);
 bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool use_64bit);
 static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
-- 
2.43.0

