Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A074430CCF;
	Fri, 31 Jul 2026 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507897; cv=none; b=ZnKQb0oqpDURYc6N0m9loyb6TVvoLjpM48sSkR7XhRhv1dmcUC5BwCMV7bMhssxr5ksnCcKiuu/6OxIEkySzEmkoiUwduH8gnbxkUV1cf3HGLvh6ZLDyA7It/2eQFcKXGLaY8EVMG7gguntr7tbJr70Kd6cbDos1rQtxLSAQteg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507897; c=relaxed/simple;
	bh=8WTTDl4a9wwi9SJqmtB4tkmhZeXGLeshxgFYd3umo44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WIu8oTitA8wSRuuuMyZEi7XGcdIvpoSmTti3llRyfBswfoYFguBgImw+SOJR3kUvW1TtxHe5KHckJ/gwMVL9wEKlZw0xkV4Lom6WsZ26znIMYcn1kCrxGE6axflLn6y988CzAPwzrka+OKE6wm9e6VXPsmpHrqd1fwlY9vIeJnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5yZtHA0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5yZtHA0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2821F00A3A;
	Fri, 31 Jul 2026 14:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785507896;
	bh=ExSEsOdV4wuf/2uulhV5hDXrmpUu+s8RPklwU3Unvu8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=l5yZtHA0PntBDJu8D5srmdMsGDVkfcO+uIGdrcB+DFwVbtfITl7E8mRnlptL8NZTP
	 BxWCsLTmr20YGGt707OhJ4rRGd5J+66qJ/+u4IoyypCcYRskrt8lmOkknYoM3A+LmP
	 GNr6dvEwg1JU85iG/DIoO/4iBzWm6V1yl9y+Dqmj3npLXQz+Z3TkKemZpvH3ex1Wf6
	 ShFUXGqhBKtK0K4JqqQOQduvhUMowjr/9qPQ8gxbp338+12yJoOMvJWHqRFpAZEwAB
	 fo/aKY5xOjvOpsfA/UVbPRrIbR5KLkaGYc6Zdt1tTUd6ddACrXdjH/gWQ3GAbWehjk
	 9DXoj/M1MJEcA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 31 Jul 2026 16:24:21 +0200
Subject: [PATCH net-next v2 5/5] mptcp: implemented OoO queue pruning
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-net-next-mptcp-oooq-pruning-v2-5-24838164fa21@kernel.org>
References: <20260731-net-next-mptcp-oooq-pruning-v2-0-24838164fa21@kernel.org>
In-Reply-To: <20260731-net-next-mptcp-oooq-pruning-v2-0-24838164fa21@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3674; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3BQN5XEdm09zV4M6DVMQUulq14bHbT2dtzRN+MyfgFE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJyNmi905jyO29hYN+T2//Sjga/MZIznXPNw+6pcv16z
 0ZNiVsHO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYSUsnwP778xP8DSuILJnid
 /M7rWPbvX9/0G872mjxXdeQXVHxjncfw318pmKMmgW3CmSlexpudPhRM5JjDpBkubBHYHOHJP+8
 hJwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

When moving incoming skbs in the msk receive queue and the latter
is above limits, prune it as needed quite alike what TCP is doing
at the subflow level. The main difference relies in the stop condition:
since MPTCP does not perform collapsing, it's better off dropping the
bare minimum to fit the (newer) incoming packet.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Tested-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
[ Uniform OFO MIB counters ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2:
 - Uniform the new counter with the other OFO ones.
---
 net/mptcp/mib.c      |  1 +
 net/mptcp/mib.h      |  1 +
 net/mptcp/protocol.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index ef65e2df709f..2569385bab7c 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -87,6 +87,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("WinProbe", MPTCP_MIB_WINPROBE),
 	SNMP_MIB_ITEM("BacklogDrop", MPTCP_MIB_BACKLOGDROP),
 	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
+	SNMP_MIB_ITEM("OFOPruned", MPTCP_MIB_OFOPRUNED),
 };
 
 /* mptcp_mib_alloc - allocate percpu mib counters
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 9271205f682e..3a3425e258a7 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -90,6 +90,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_WINPROBE,		/* MPTCP-level zero window probe */
 	MPTCP_MIB_BACKLOGDROP,		/* Backlog over memory limit */
 	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constraints */
+	MPTCP_MIB_OFOPRUNED,		/* MPTCP-level OoO queue pruned */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7f257419c5ea..68c9d952d1d3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -373,6 +373,49 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
 	skb_dst_drop(skb);
 }
 
+/* "Inspired" from the TCP version; main difference: stop as soon as the MPTCP
+ * socket is under memory limit.
+ */
+static bool mptcp_prune_ofo_queue(struct sock *sk, u64 seq)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct rb_node *node, *prev;
+	bool pruned = false;
+	u64 mem;
+
+	if (RB_EMPTY_ROOT(&msk->out_of_order_queue))
+		goto out;
+
+	node = &msk->ooo_last_skb->rbnode;
+
+	do {
+		struct sk_buff *skb = rb_to_skb(node);
+
+		/* Stop pruning if the incoming skb would land in OoO tail. */
+		if (after64(seq, MPTCP_SKB_CB(skb)->map_seq))
+			break;
+
+		pruned = true;
+		prev = rb_prev(node);
+		rb_erase(node, &msk->out_of_order_queue);
+		mptcp_drop(sk, skb);
+		msk->ooo_last_skb = rb_to_skb(prev);
+
+		mem = (unsigned int)sk_rmem_alloc_get(sk);
+		if (mem <= sk->sk_rcvbuf)
+			break;
+
+		node = prev;
+	} while (node);
+
+	if (pruned)
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOPRUNED);
+
+out:
+	mem = (unsigned int)sk_rmem_alloc_get(sk);
+	return mem <= sk->sk_rcvbuf;
+}
+
 static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 {
 	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
@@ -385,7 +428,8 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 	 * will break.
 	 */
 	if (unlikely(sk_rmem_alloc_get(sk) > READ_ONCE(sk->sk_rcvbuf)) &&
-	    !__mptcp_check_fallback(msk)) {
+	    !__mptcp_check_fallback(msk) &&
+	    !mptcp_prune_ofo_queue(sk, MPTCP_SKB_CB(skb)->map_seq)) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
 		mptcp_drop(sk, skb);
 		return false;

-- 
2.53.0

