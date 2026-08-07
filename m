Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFAA30E0E9;
	Fri,  7 Aug 2026 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110652; cv=none; b=h2RfGKI9GS31QGjwszZZvf1lomK6VZgWbizTgCIkdQQY0hWu5AJ/3fXC4EB8DNemqNRoCGKTnw40wq/USBzAoNtSsVlAmEnFeigeLwejm8PMzd9/rJ1bBSqA2jOgKOa0DHa8Za5Z7LFIn8bt7zWlYzQJ+++lcl1XHfYRXfyWrq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110652; c=relaxed/simple;
	bh=lUkBtkqx0K2qkY5bwN2OdiEBPUwziZTeHLobcsOpFk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SQiwjFzuTTF6FAfb41elPwfselAbNGO6LN+SZA5btDddlt6hWAHPeK9kIWIeLDZ37yCRlqKGrz4NnNvjvWRc73o063u0puErxhWksWyhd0KVzsm8rI8en0/voymzTcxRfm9gMych4Tnw7jyTQ5wIr1I+DCDZU83Xi/9ZMpgfF5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XR6Y9fDk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XR6Y9fDk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0640C1F00ACA;
	Fri,  7 Aug 2026 13:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786110642;
	bh=Hp8FSiOxKfQHeeC+JtYjdyoMvW0eZ8MoTAl8tlSx1hg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XR6Y9fDkpVf+iujxTEiwkS5KPecMzgosMxK6rLB9TLqiO29s+kAOJRx7vzjOQdIBf
	 4qtfp80hhadAicKPf391ooEekfOlyerLxdh0A/2HbWglr+5KmLmE4bjazXh7qMge6z
	 ZdNH9Lxr2a5Z4+muwm5ttoRy+GUQrbjCy1NWP41jvRATt/HUkOzIjOuqAyTmzMkZOP
	 /OnmyPz8iCzWUrNCCOvKPasBQHYCKsWuzIOYT3YMXsO80UqHtN/jO7cYNFoflfMvZU
	 iHf9IkM9sGxkaTtd51/mXzoWn6m34Y2cpcyEi/TdafjZL4dLQKfZr0XKez91gdkiHo
	 FZ/41Vmw7Zrsw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Aug 2026 15:49:07 +0200
Subject: [PATCH net-next v3 7/7] mptcp: implemented OoO queue pruning
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-net-next-mptcp-oooq-pruning-v3-7-dbc1eb853cc3@kernel.org>
References: <20260807-net-next-mptcp-oooq-pruning-v3-0-dbc1eb853cc3@kernel.org>
In-Reply-To: <20260807-net-next-mptcp-oooq-pruning-v3-0-dbc1eb853cc3@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4979; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=D17M8n5T3NEzzAe7GBb53KDyX6iU9Q4IORwBahYPUVs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJKH83vS0nJzOX6bbSnZOmB86/vZFws/rL0XX+fS0rXs
 WQZ9lNmHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABP5XMjwT99PbbqDlg77qt+G
 PCt4uuW3HT5wr+ed2dKo47v09yQvt2L4X1tZUB2c3LrZoCdCg1l5y/KwtVNerws8tM3k0NuFPXu
 28gAA
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
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2:
 - Uniform the new counter with the other OFO ones.
v3:
 - prune only for new data
 - reorganize the code to follow more closely TCP
---
 net/mptcp/mib.c      |  1 +
 net/mptcp/mib.h      |  1 +
 net/mptcp/protocol.c | 81 +++++++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 73 insertions(+), 10 deletions(-)

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
index 63f2c18bc01f..ec874d2ead6a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -242,6 +242,65 @@ static bool mptcp_rcvbuf_grow(struct sock *sk, u32 newval)
 	return false;
 }
 
+/* "Inspired" from the TCP version; main difference: stop as soon as the MPTCP
+ * socket is under memory limit.
+ */
+static void mptcp_prune_ofo_queue(struct sock *sk,
+				  const struct sk_buff *in_skb)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct rb_node *node, *prev;
+	bool pruned = false;
+	u64 mem;
+
+	if (RB_EMPTY_ROOT(&msk->out_of_order_queue))
+		return;
+
+	node = &msk->ooo_last_skb->rbnode;
+
+	do {
+		struct sk_buff *skb = rb_to_skb(node);
+
+		/* Stop pruning if the incoming skb would land in OoO tail. */
+		if (after64(MPTCP_SKB_CB(in_skb)->map_seq,
+			    MPTCP_SKB_CB(skb)->map_seq))
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
+}
+
+/* The stack can't drop packets for fallback socket at the msk level, or the
+ * stream will break.
+ */
+static bool mptcp_can_ingest(const struct sock *sk)
+{
+	return unlikely(sk_rmem_alloc_get(sk) <= READ_ONCE(sk->sk_rcvbuf)) ||
+			__mptcp_check_fallback(mptcp_sk(sk));
+}
+
+static bool mptcp_try_rmem_schedule(struct sock *sk, const struct sk_buff *skb)
+{
+	if (!mptcp_can_ingest(sk)) {
+		mptcp_prune_ofo_queue(sk, skb);
+		return mptcp_can_ingest(sk);
+	}
+	return true;
+}
+
 /* "inspired" by tcp_data_queue_ofo(), main differences:
  * - use mptcp seqs
  * - don't cope with sacks
@@ -253,6 +312,12 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	u64 seq, end_seq, max_seq;
 	struct sk_buff *skb1;
 
+	if (!mptcp_try_rmem_schedule(sk, skb)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
+		mptcp_drop(sk, skb);
+		return;
+	}
+
 	seq = MPTCP_SKB_CB(skb)->map_seq;
 	end_seq = MPTCP_SKB_CB(skb)->end_seq;
 	max_seq = atomic64_read(&msk->rcv_wnd_sent);
@@ -387,19 +452,15 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 
 	mptcp_borrow_fwdmem(sk, skb);
 
-	/* Can't drop packets for fallback socket this late, or the stream
-	 * will break.
-	 */
-	if (unlikely(sk_rmem_alloc_get(sk) > READ_ONCE(sk->sk_rcvbuf)) &&
-	    !__mptcp_check_fallback(msk)) {
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
-		mptcp_drop(sk, skb);
-		return false;
-	}
-
 	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
 		/* in sequence */
 insert:
+		if (!mptcp_try_rmem_schedule(sk, skb)) {
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
+			mptcp_drop(sk, skb);
+			return false;
+		}
+
 		msk->bytes_received += copy_len;
 		WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
 		tail = skb_peek_tail(&sk->sk_receive_queue);

-- 
2.53.0

