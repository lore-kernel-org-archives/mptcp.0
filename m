Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795783554;
	b=NY+lA9dsPbjY49oMcdGhS5+jhqg5dXGO4f35NIaDEQ6P75cybbhma9wjYcIJfu7SZidZ
	 qttiEAcQ1gwHgorq1/LVlTrhWVXQJHmB3v8vLRuZFPUKwTWeTmz5Fyxp49JMcetMHqJ1J
	 9VgcifWxErl3wBJwpAxrcA6hkpiuH2BrJdHrMqGxdYBru5BxKIAJXTv4Vyv8q+pGBLFqM
	 N+OUwSt/L9cW2u/u5P9bKvrQ0HzE8PGpks3fI8no1tamsXsUfzCFvThXaROfscD+0CILW
	 q24RShFCrbVFSupW70C7gbORvxWa8Igep5Fb8cb/WyqM8DjkPpCjPt7hKg4KDrCeeyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795783554;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kGbDCUUEghTXfUDed29AI32A6nM+GTG8GbtYwF0dp8w=;
	b=XRERiYO/4edTucj2a0RdoijupzPkSUalDNshJuzEcZ+QygLdDGKpaSzC+BDsMJl2wpkK
	 HXp4FKBpNL923VmxyYbIMBIrviuv+Wy4fuphYhOysbJEGH1uNR2YGJPSUBfl7pAP9erh/
	 SfUR8MNq/EqH+FY04oJeTJIJM/ROefMceJxzE8MXaWuAOnf41qT9Jb40uvoayoNLSjyn1
	 80Gv4JzNOmQbTFqe+Pn0wcO7l38awJG39SlFgtsxB7wml5jgo+/tzZjs6EEY46/jEDOnw
	 GgUuAVgiq6HnRRpQbO9npgpvIyAVsCmxWY8A2V+/uUYsEWUFmNRfV9pFEVJbZyHRmqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kUvFVKgG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC3D606A321
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kUvFVKgG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEF41F00899
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 12:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795783553;
	bh=kGbDCUUEghTXfUDed29AI32A6nM+GTG8GbtYwF0dp8w=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=kUvFVKgGOGKcM0giyvQtYh/rAubFnYUxWh/78OWhJM6e62ki2N8URQw0riJLlpCDE
	 KscP3Dum2ohK4gFDwPmh3bcbpBz75DX8DUD88wg9ejFjGVirpeYm8TsYWi24n5Xqcy
	 GtFvfEheA2KTrKs1uDSwT4U9cFjc6ffp/gQ0hATGf5LI4JQaOPQ78m+sRfcAYbxj4o
	 +dK5PnYCzyLZm1+ZpiVU8MdnV4QVd9jCVbLuLwQjxDR4Gwu7pMq4giMr7dbE2q+TgU
	 BNpPS33pJ0Jz9skKz+S/lZUuuVE7uHB0Nl2GEr6EXgWsPBGVIWyyGssV0p+IRq8+hn
	 o9ExVos/iNyAQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v11 1/7] mptcp: use local variable tp in sendmsg_frag
Date: Fri, 27 Nov 2026 20:45:21 +0800
Message-ID: <80305d70e90d69946206bd13feffd9943c409a63.1795783388.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795783388.git.tanggeliang@kylinos.cn>
References: <cover.1795783388.git.tanggeliang@kylinos.cn>
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

From: Geliang Tang <tanggeliang@kylinos.cn>

In mptcp_sendmsg_frag(), tcp_sk(ssk) is called multiple times.
Introduce a local variable 'tp' to hold the tcp_sock pointer and
use it throughout the function. This improves code readability,
with no functional change.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d64e04245963..b9ae52caf47e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1447,6 +1447,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	u64 data_seq = dfrag->data_seq + info->sent;
 	int offset = dfrag->offset + info->sent;
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct tcp_sock *tp = tcp_sk(ssk);
 	bool zero_window_probe = false;
 	struct mptcp_ext *mpext = NULL;
 	bool can_coalesce = false;
@@ -1483,14 +1484,14 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		mpext = mptcp_get_ext(skb);
 		if (!mptcp_skb_can_collapse_to(data_seq, skb, mpext)) {
 			TCP_SKB_CB(skb)->eor = 1;
-			tcp_mark_push(tcp_sk(ssk), skb);
+			tcp_mark_push(tp, skb);
 			goto alloc_skb;
 		}
 
 		i = skb_shinfo(skb)->nr_frags;
 		can_coalesce = skb_can_coalesce(skb, i, dfrag->page, offset);
 		if (!can_coalesce && i >= READ_ONCE(net_hotdata.sysctl_max_skb_frags)) {
-			tcp_mark_push(tcp_sk(ssk), skb);
+			tcp_mark_push(tp, skb);
 			goto alloc_skb;
 		}
 
@@ -1548,7 +1549,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	skb->truesize += copy;
 	sk_wmem_queued_add(ssk, copy);
 	sk_mem_charge(ssk, copy);
-	WRITE_ONCE(tcp_sk(ssk)->write_seq, tcp_sk(ssk)->write_seq + copy);
+	WRITE_ONCE(tp->write_seq, tp->write_seq + copy);
 	TCP_SKB_CB(skb)->end_seq += copy;
 	tcp_skb_pcount_set(skb, 0);
 
-- 
2.55.0

