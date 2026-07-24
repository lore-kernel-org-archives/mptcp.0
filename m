Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF0F43A81B;
	Fri, 24 Jul 2026 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784901770; cv=none; b=VRS5VY6BPJ7Muoa1PpZQEEFsyooKDLPDtOVQ5GmPk3mSmjXOK3Q6U5UlO0Pf65qGmxhtl8jalg081Fa/f8U2ZJqz3zqJpm9l1I0Axj4An3m52aVB3UTC7dGFK8QPah1jKouLuTu6xvVHmQ06JWcQkwf1zP2FdKlutgvboFo5mkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784901770; c=relaxed/simple;
	bh=S3MdV3UAR+ADbXfkUpujD9LpujITJkIrZfRUogdwTOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rG2FlA3VWKYywyOvxeV4DhhgCiNBrj15WmOAOBmZad4sYigbyt6FbmOxV61nvscg+ZqH0QawJIQkzjEDsiKowc4I7Dr9ukHXqxra5RgUpPt7TAZ+HSo8lPfn9PKYgfvT5vgPgqMGV4R9PD2fuAIJ9NElLkPiDBfmrS0MwfKGYww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYZp48Gp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYZp48Gp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BA21F000E9;
	Fri, 24 Jul 2026 14:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784901767;
	bh=eiIkZX9UKn62Wt3UHZGy8oEPX9InDuKj5kOafRz6D3M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gYZp48Gpn8wxKY98OEwH4fJVZL/ZImbDl5uOCR75i3jG1+w6tpJjsKv9omFE/qsfg
	 qlVXjsCaNpgE0t5Xd4bojwezYpSRi63sVzMR1PpjKeiOKwk8+q7HButPdUUtiA7gTC
	 heLbLjBUV1btBtC08rVvq1P3olYLxdQxDBCxU4jp+UDCe8/CURCRxI5E1PW5qvxEGF
	 XNuyvtI/cPgJxoqqMwcR6cEGxDtAil/xufYr25hqOuPIMsOMk/Rg5e/Na9TQ1RGp/+
	 6awyAluITZNaWBu9PcOn55eSIYCcD+DOMO3ENQh6HG6MeU2Zt8Bhj1Sl0z9upjcyOL
	 WyeIpLtgeJnvA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 24 Jul 2026 16:02:17 +0200
Subject: [PATCH net-next 5/5] mptcp: implemented OoO queue pruning
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-net-next-mptcp-oooq-pruning-v1-5-5dd4dec63a54@kernel.org>
References: <20260724-net-next-mptcp-oooq-pruning-v1-0-5dd4dec63a54@kernel.org>
In-Reply-To: <20260724-net-next-mptcp-oooq-pruning-v1-0-5dd4dec63a54@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3583; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=0TP0HmzvNCrhNepV2D684uiABQ8/iw2HmKqfNTiVn14=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLKSCyrLXn2vsjnL+X8Vx8zbfV+DjLU4WhbdMzs3bX0kY
 0/l02OpHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABPRn8/wz1ak6GH+cv6mFh0H
 y6Bshheu4WzVNTHaIc3OfNsm7pWdychwo+XsVcMN/mdVOCrmRrebG8vMdfS7uSPs5LzQdWopp52
 YAQ==
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
 net/mptcp/mib.c      |  1 +
 net/mptcp/mib.h      |  1 +
 net/mptcp/protocol.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index ef65e2df709f..d9bd4f4afcc0 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -87,6 +87,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("WinProbe", MPTCP_MIB_WINPROBE),
 	SNMP_MIB_ITEM("BacklogDrop", MPTCP_MIB_BACKLOGDROP),
 	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
+	SNMP_MIB_ITEM("OfoPruned", MPTCP_MIB_OFO_PRUNED),
 };
 
 /* mptcp_mib_alloc - allocate percpu mib counters
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index c84eb853d499..18f35f7e0a2d 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -90,6 +90,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_WINPROBE,		/* MPTCP-level zero window probe */
 	MPTCP_MIB_BACKLOGDROP,		/* Backlog over memory limit */
 	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constrains */
+	MPTCP_MIB_OFO_PRUNED,		/* MPTCP-level OoO queue pruned */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7f257419c5ea..5cf44eab76f1 100644
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
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFO_PRUNED);
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

