Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F31142E8F1;
	Fri, 31 Jul 2026 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507893; cv=none; b=iUPiaiVCjTcdxDVGq05K9FouLADcIh5Ugh6/4r+jNrduP+tcvOU74M47FZBUAkohybWZ6Z3UYczU1yWApFI5taCC3X0Hb5jrouNQn8/OtsgkyZ3hyGS+kK/cHmWb2UtZpES9uyhOY5rHclMInbn6TZHr9lCZzHkJ3hn7tHZqDXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507893; c=relaxed/simple;
	bh=+Dx8cUPxw+YGZkvoq7PDBOxtGrIMgZdMTOCWbzCps+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DMty5HuaKldeZkXmJ6MYwo0f7rd3uQzNWvBr7Hb4vgwSiTzUDWFRQMCU7WAts2Ig1yzkkGPNKOdkP+JgcwNlaCBiUdg5NmmQDivzL/+mcNXtnBXyt2mB8z36+cDhfYL8O1JcwqvdCstGldPJfyTAbHgdcpgCAsbBzW1GceWbnFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEY7EBY5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEY7EBY5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A5F1F00A3A;
	Fri, 31 Jul 2026 14:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785507891;
	bh=iMEczguGEeqG2dtckIYc08K1knNCRvfNyMKN/FdQiwA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KEY7EBY5WzUA6A0JqxWTGCj49kV/a6KzWKkWCGwrDqeLB+ZK65MZj4R5f+P+dtAna
	 3V7LOVT4+BU6f1YrCnPBfOMu5PuNgaHm2M372a+D7C+eYGYZcPBtqdd4HZ8XaxZf90
	 7Yy4DZf/C6r0to3KoNFj4UbUoY86DhtI0f8OJogs2q6B+mFXb0YMLph5cWE3m9XzBa
	 pEgWCOWkILa/qJdvXyJao6IkZonhT2K2J24Z5PjSqVygWOFR7zX+1EABHur93gSW3J
	 PtdBxAlgvqOpZStmt5aoUatYHdAcjwGfQAFpKgwCYcUKUk6cfhPdcK9lhE1jNgIcJr
	 blyBBs2VaD7RQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 31 Jul 2026 16:24:19 +0200
Subject: [PATCH net-next v2 3/5] mptcp: explicitly drop over memory limits
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-net-next-mptcp-oooq-pruning-v2-3-24838164fa21@kernel.org>
References: <20260731-net-next-mptcp-oooq-pruning-v2-0-24838164fa21@kernel.org>
In-Reply-To: <20260731-net-next-mptcp-oooq-pruning-v2-0-24838164fa21@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7073; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=LeIX1Vo+bsKwPXGsd8YW5pw/IYRaB8n/4Ijl3U2Mjrg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJyNqhvt2JLqFqnVMbk96dIZtOjX9IMpd8Wr3y0KFT9T
 NC/YvW8jlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgInw7GZkmLr62o7Vs59/8XoV
 s2C9xCpjq7WCRvsCnr96wHvv2Ax2rlMM/4NXxE5/XBmjuF1y7iL2MIMyfq2TNideTVoQprAw7pu
 tMR8A
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
[ Fix typo, comment, and bump LINUX_MIB_TCPRCVQDROP ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2:
 - mib: typo: "constrains" -> "constraints".
 - mptcp_over_limit: more than 0-win: retrans, dup or old acks.
 - mptcp_over_limit: bump LINUX_MIB_TCPRCVQDROP.
 - Note: Sashiko might point to a possible forward-allocated memory
   leak: this is a temp leak, and releasing additionally allocated fwd
   memory in the error path will be fix in a patch for -net.
---
 net/mptcp/mib.c      |  2 ++
 net/mptcp/mib.h      |  2 ++
 net/mptcp/options.c  | 32 +++++++++++++++++++++++++++++---
 net/mptcp/protocol.c | 31 +++++++++++++++++++++++--------
 4 files changed, 56 insertions(+), 11 deletions(-)

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
index 812218b5ed2b..9271205f682e 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -88,6 +88,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_SIMULTCONNFALLBACK,	/* Simultaneous connect */
 	MPTCP_MIB_FALLBACKFAILED,	/* Can't fallback due to msk status */
 	MPTCP_MIB_WINPROBE,		/* MPTCP-level zero window probe */
+	MPTCP_MIB_BACKLOGDROP,		/* Backlog over memory limit */
+	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constraints */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c664023d37ba..5642277c8b3d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1127,8 +1127,34 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
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
+	/* Avoid silently dropping pure acks, fin or already-acked segments. */
+	if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq ||
+	    TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN ||
+	    !after(TCP_SKB_CB(skb)->end_seq, tcp_sk(ssk)->rcv_nxt))
+		return false;
+
+	/* Dropped due to memory constraints, schedule an ack. */
+	inet_csk(ssk)->icsk_ack.pending |= ICSK_ACK_NOMEM | ICSK_ACK_NOW;
+	inet_csk_schedule_ack(ssk);
+
+	/* Plain TCP (fallback) and skb is dropped before the TCP recv queue. */
+	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP);
+
+	return true;
+}
+
+/* Return false when the caller must drop the packet, i.e. in case of error,
+ * subflow has been reset, or over memory limits.
  */
 bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 {
@@ -1154,7 +1180,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 
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

