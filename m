Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76D6439906;
	Fri, 24 Jul 2026 14:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784901767; cv=none; b=Csa1JQqQpUETab8fPj4DP/y7MZzlDYjRzNtMs8oPpFhxaM9rdFvP26dAkjZDveHzmXh1GHYjzXnVTBCt6lKdCZdpE7nsAdb5LwF7CND0BsxX8H+76gqstme5mz1hOL0zTz4HvVgQq0UbfazLukKqb2yO0Uvwh+IYHGMkNiqr1s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784901767; c=relaxed/simple;
	bh=tRCs/Ywn6YThfo2FendTPgyTtyAcAJvsU0yUabYM+8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t45L54QtNAkSOOpjMiG8RPk8g1BPooYJu1VA1nafPObis97ATVdlH24CfBDE1IxSE3KH9HP/VU1t/nAbIkc4a7hX2k3SJ3lCMWv3sC1HmZGejmLL30m7gIGo/lNfbWlYBXsSGvmKy0vfGn2/FgeUmsD+izwtRubR5Vg7gk5VAGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7wReyni; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7wReyni"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEAE1F00A3A;
	Fri, 24 Jul 2026 14:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784901763;
	bh=3L2urecN0rup7TreSmxzOfhOmTGRwimuPlF5G6bq1K8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Q7wReyniWU63uNctpmvnqXOYur5FW0JGM5HgkTQeY0ch29NYl9xhEfL+ootlpD/V4
	 BPjPV2DptUAYTe/iqt+52D4k6E6BgLpe+qqC8wh/ZWJRGXKD9Q/hASVSXTAD36gcN+
	 Y2Y+HnzJLHdWRAeZ+2Ju24Mq6xExp1rMrOOYuvqApWNTS3+M36w/7xk5qAnDIU9CpM
	 aQPr6PtF7ZLvwGiVxpmUNz+K4z2aPfEq/u21uBpXIT5WQoksGXWOFsMcs+P+Ujhqv3
	 OJHpjpAVG63AThWKk6it5IU1O5IWQQcheS75JUCFUFTZA0IHlS6M7ZPmCK3CAlq2K3
	 hxTjQ/dW+Djaw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 24 Jul 2026 16:02:15 +0200
Subject: [PATCH net-next 3/5] mptcp: explicitly drop over memory limits
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-net-next-mptcp-oooq-pruning-v1-3-5dd4dec63a54@kernel.org>
References: <20260724-net-next-mptcp-oooq-pruning-v1-0-5dd4dec63a54@kernel.org>
In-Reply-To: <20260724-net-next-mptcp-oooq-pruning-v1-0-5dd4dec63a54@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6495; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=FdLKg8Yu88qWDJDxfs1mL1EwkqxvxVMEzBy1/9NUA/o=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLKSC8pz/c4/Xrq0w6U9Y56zysU11q5KiU73WCN3aP/Xc
 VsRWDCro5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCJzyhkZzt92bT9QYZaT/q7L
 +uC0O8uFHk8129hwSpJNtLH8ajHPZYb/AXld7dEb7jSVvOk5qi9g/8+s+NFFGeOICrVja5znxNt
 zAwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Currently the enforcement of the rcvbuf constraint is implemented
when moving the skbs into the msk receive or OoO queue, keeping the
incoming skbs in the subflow queue when over limits.

Under significant memory pressure the above can cause permanent data
transfer stalls, as the skb needed to make forward progress can be
stuck in a subflow queue.

Over memory limits, drop the incoming skb, relying on MPTCP-level
retransmissions.

Note that fallback socket must perform the limit before the skb reaches
the subflow-level queue, as dropping an in-sequence already acked skb
would break the stream.

This is not a complete fix for the stall issue, as the drop strategy
needs refinements that will come in the next patches.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/mib.c      |  2 ++
 net/mptcp/mib.h      |  2 ++
 net/mptcp/options.c  | 28 +++++++++++++++++++++++++---
 net/mptcp/protocol.c | 31 +++++++++++++++++++++++--------
 4 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index f23fda0c55a7..ef65e2df709f 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -85,6 +85,8 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("SimultConnectFallback", MPTCP_MIB_SIMULTCONNFALLBACK),
 	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACKFAILED),
 	SNMP_MIB_ITEM("WinProbe", MPTCP_MIB_WINPROBE),
+	SNMP_MIB_ITEM("BacklogDrop", MPTCP_MIB_BACKLOGDROP),
+	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
 };
 
 /* mptcp_mib_alloc - allocate percpu mib counters
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 812218b5ed2b..c84eb853d499 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -88,6 +88,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_SIMULTCONNFALLBACK,	/* Simultaneous connect */
 	MPTCP_MIB_FALLBACKFAILED,	/* Can't fallback due to msk status */
 	MPTCP_MIB_WINPROBE,		/* MPTCP-level zero window probe */
+	MPTCP_MIB_BACKLOGDROP,		/* Backlog over memory limit */
+	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constrains */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c664023d37ba..7b954ef78672 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1127,8 +1127,30 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
 	return hmac == mp_opt->ahmac;
 }
 
-/* Return false in case of error (or subflow has been reset),
- * else return true.
+static bool mptcp_over_limit(struct sock *sk, struct sock *ssk,
+			     const struct sk_buff *skb)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	u64 mem = sk_rmem_alloc_get(sk);
+
+	mem += READ_ONCE(msk->backlog_len);
+	if (likely(mem <= READ_ONCE(sk->sk_rcvbuf)))
+		return false;
+
+	/* Avoid silently dropping pure acks, fin or zero win probes. */
+	if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq ||
+	    TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN ||
+	    !after(TCP_SKB_CB(skb)->end_seq, tcp_sk(ssk)->rcv_nxt))
+		return false;
+
+	/* Dropped due to memory constraints, schedule an ack. */
+	inet_csk(ssk)->icsk_ack.pending |= ICSK_ACK_NOMEM | ICSK_ACK_NOW;
+	inet_csk_schedule_ack(ssk);
+	return true;
+}
+
+/* Return false when the caller must drop the packet, i.e. in case of error,
+ * subflow has been reset, or over memory limits.
  */
 bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 {
@@ -1154,7 +1176,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 
 		__mptcp_data_acked(subflow->conn);
 		mptcp_data_unlock(subflow->conn);
-		return true;
+		return !mptcp_over_limit(subflow->conn, sk, skb);
 	}
 
 	mptcp_get_options(skb, &mp_opt);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 72b1fa3ca71c..5f7d8340a3d9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -381,6 +381,16 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 
 	mptcp_borrow_fwdmem(sk, skb);
 
+	/* Can't drop packets for fallback socket this late, or the stream
+	 * will break.
+	 */
+	if (unlikely(sk_rmem_alloc_get(sk) > READ_ONCE(sk->sk_rcvbuf)) &&
+	    !__mptcp_check_fallback(msk)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
+		mptcp_drop(sk, skb);
+		return false;
+	}
+
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
 		/* in sequence */
 		msk->bytes_received += copy_len;
@@ -675,6 +685,7 @@ static void __mptcp_add_backlog(struct sock *sk,
 	struct sk_buff *tail = NULL;
 	struct sock *ssk = skb->sk;
 	bool fragstolen;
+	u64 limit;
 	int delta;
 
 	if (unlikely(sk->sk_state == TCP_CLOSE)) {
@@ -682,6 +693,16 @@ static void __mptcp_add_backlog(struct sock *sk,
 		return;
 	}
 
+	/* Similar additional allowance as plain TCP. */
+	limit = READ_ONCE(sk->sk_rcvbuf);
+	limit += (limit >> 1) + 64 * 1024;
+	limit = min_t(u64, limit, UINT_MAX);
+	if (msk->backlog_len > limit && !__mptcp_check_fallback(msk)) {
+		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_BACKLOGDROP);
+		kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_BACKLOG);
+		return;
+	}
+
 	/* Try to coalesce with the last skb in our backlog */
 	if (!list_empty(&msk->backlog_list))
 		tail = list_last_entry(&msk->backlog_list, struct sk_buff, list);
@@ -753,7 +774,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 
 			mptcp_init_skb(ssk, skb, offset, len);
 
-			if (own_msk && sk_rmem_alloc_get(sk) < sk->sk_rcvbuf) {
+			if (own_msk) {
 				mptcp_subflow_lend_fwdmem(subflow, skb);
 				ret |= __mptcp_move_skb(sk, skb);
 			} else {
@@ -2204,10 +2225,6 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
 
 	*delta = 0;
 	while (1) {
-		/* If the msk recvbuf is full stop, don't drop */
-		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
-			break;
-
 		prefetch(skb->next);
 		list_del(&skb->list);
 		*delta += skb->truesize;
@@ -2235,9 +2252,7 @@ static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)
 	DEBUG_NET_WARN_ON_ONCE(msk->backlog_unaccounted && sk->sk_socket &&
 			       mem_cgroup_from_sk(sk));
 
-	/* Don't spool the backlog if the rcvbuf is full. */
-	if (list_empty(&msk->backlog_list) ||
-	    sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
+	if (list_empty(&msk->backlog_list))
 		return false;
 
 	INIT_LIST_HEAD(skbs);

-- 
2.53.0

