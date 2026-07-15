Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67592931D7
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 11:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784113444; cv=none; b=TgfgOVDivG1APW/yNKjn/5NeR4fsew3fTj/I1mV73gT9H34cR+39LyJe8RnDtV/Qj42NDHQHm9L5+MH2+QrCSFp1LwE90eoxWRxOEn/E+yq9OQgyf9R8pJjzebgwDLVYC3wznp/kQQ2WgG1bB20f4aZOZsJNHjUNs5SCKa+6vok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784113444; c=relaxed/simple;
	bh=jME7UwAhFGdpy0DC+LD1XLRwwMwYlVOX++7xseGcuGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMQ4ojtp3+xpjEz3Dpx6tPOGjuT+gK+dah2tDyexJ7xAl0F1JrZj6CV80lWIupm1sfI3drK2K0xZRFuLZ0H05+Acu5pYg5vlkl1qjxPiSFpROvel6E3ytUO95tv5qEGUq2dNFncVSI267a9iymr76AbSkIs66hHzuQGdQ/q/FMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2xeuj4f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2xeuj4f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D351F00A3A;
	Wed, 15 Jul 2026 11:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784113443;
	bh=EYeyAMGYwgrEvRqPliDbY8/sG7cAJUpla97WO7oBIDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D2xeuj4fkwb4w8qJLyDjmZwufiWzwX+SAKmztQuRCnzjFK/7t5aJnhFGJ/DNSkbZJ
	 srQUU3AcNeVMQ7M01Q8MDrCHExxD5ze8CF/LfjBMIDFtzkvgpy7FHBW4Gn3h5Fh4+L
	 Obc/xYexE7nSnI/quw/fYWu+M7Kqdsb5hPRWsKJmreb/xzja5UpAD+7NqEfKR4NbQA
	 fDxD21qYDb00kpR88G1i6h582T78Q4YGrm61P31KrlFon/OXP6f9rOLTb66LrYXbbT
	 IM0rskgh5SvfVJ+ygvoKtVp4/3gAk6u4FfoMJ15dnFp0tc79DuXhClEAN35wIQVWZ6
	 2t6xP/BKxUL+w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v5 1/8] mptcp: use local variable tp in sendmsg_frag
Date: Wed, 15 Jul 2026 19:03:46 +0800
Message-ID: <e7f83ae2dfea26db0766ec66648fe33517d89459.1784113088.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784113088.git.tanggeliang@kylinos.cn>
References: <cover.1784113088.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In mptcp_sendmsg_frag(), tcp_sk(ssk) is called multiple times.
Introduce a local variable 'tp' to hold the tcp_sock pointer and
use it throughout the function. This avoids repeated dereferencing
and improves code readability, with no functional change.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ffcf5a1788f6..1cab07b1b9b1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1375,6 +1375,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	u64 data_seq = dfrag->data_seq + info->sent;
 	int offset = dfrag->offset + info->sent;
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct tcp_sock *tp = tcp_sk(ssk);
 	bool zero_window_probe = false;
 	struct mptcp_ext *mpext = NULL;
 	bool can_coalesce = false;
@@ -1410,14 +1411,14 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
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
 
@@ -1471,7 +1472,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	skb->truesize += copy;
 	sk_wmem_queued_add(ssk, copy);
 	sk_mem_charge(ssk, copy);
-	WRITE_ONCE(tcp_sk(ssk)->write_seq, tcp_sk(ssk)->write_seq + copy);
+	WRITE_ONCE(tp->write_seq, tp->write_seq + copy);
 	TCP_SKB_CB(skb)->end_seq += copy;
 	tcp_skb_pcount_set(skb, 0);
 
-- 
2.53.0

