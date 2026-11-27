Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795754189;
	b=BtA3XUroqfyxNVRHe+OyMyIJto295XqqusT5Bvo2q1auuj0vg8CpWAxv6/ee+8InJEIM
	 jdKCQMaZxuaOe3rgS/voNoi8F8fD8A8Q9xHmm5nYdAPFQo1H82VO56RYxoBxmJrYvGlyE
	 +ZCJ4pSK828EiWcKLfFgvZCnnTbx2l4jPVw2qgMqi/A9dAoPlpCIbnsG3nUlN2nW3N+KA
	 vTr4wEP/T1EcGbhl8hfbeubLNZXRPPVCUqGVIyVmiYva136K36CwrB7h//3qYojokNyYt
	 h7pfex0rlkveZPbFX3ULYa6ePbEpTn25NpAqZUUedfiPi+sJ4du0kP2Mlt8CQgbKNCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795754189;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kGbDCUUEghTXfUDed29AI32A6nM+GTG8GbtYwF0dp8w=;
	b=mLW8rvkeHaxQto0cOtdWqriMdh2j52Vcuhf/+GD7Uc85kyUtWgfSU4chkv80T1Ye4W6t
	 PqrHp61pjPChOGm6ezy61auCFqtF3Rh3mVZGRVKF+xx0h74qOjIeG4xn0Lnpfs71hhoxM
	 BRbxwk0qiWHCV4S8kfzhoPe153lOB6IB9lIaabxIJIiOCAuhuH9a9Dvo6KaY3S7m0IrrE
	 jQh22O/tQCB1ZvtGrmxoJ46WgErAzvY42mjJB+/+vDSUvGlPnlFlF3XnyHRTt8dOZZAM7
	 2Y5BtGMOpbTwBQ8zkOr1i1gmdNcuG8H6ifSVy9SNVEIFaspKVRnYy6v3Kff0X1FaTIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A8TBRW9n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E902606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 04:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A8TBRW9n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155E51F00898
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 04:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795754188;
	bh=kGbDCUUEghTXfUDed29AI32A6nM+GTG8GbtYwF0dp8w=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=A8TBRW9nFKXlwTRLkAez1gapxZz+56TCvRrZxqCzT37m219zNEfeUElxTK6sIXZws
	 0NAPHzdfx1tZfGyUaKpw1o7pCfhQx2lqPq4r23zcumD8fqs6hsH+BgCU+4JZPm+Mu4
	 06jDHif1FW4bAVccHj5C25zo5C4Q5TN88psv6ytX9m08R+2lRpIO4LKpcsU/a9TI79
	 btEQ1zUlDrKusLki1d5OZdXFUeQhGraMPk1JlxbGT8khDUPhwRs95VxunJ+pzUTZuL
	 q/pVX+uVvnnD7LJr9PolS5RtOO+Y/yeCUE/K7Wk2TFxhnrRqP91IF1B3X7mpICg09/
	 HsMN0q659o97g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v10 1/7] mptcp: use local variable tp in sendmsg_frag
Date: Fri, 27 Nov 2026 12:36:14 +0800
Message-ID: <80305d70e90d69946206bd13feffd9943c409a63.1795753727.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795753727.git.tanggeliang@kylinos.cn>
References: <cover.1795753727.git.tanggeliang@kylinos.cn>
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

