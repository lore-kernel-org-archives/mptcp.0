Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599672;
	b=R/mq0DIAcEnP/THqt9gWgBJG6RAM2HjkOuvp/YGJqHxq1EArE84k+k0xPcN5jESCjAW8
	 Pihq5B2E2cVrAatUlgdwBaDMYDQ/JQEuvmPKu11o4r/Q19JuPnMs3WlMaVT7X79lZ4kat
	 86qkwXYxFXZvx26GEO+PQW/AnlDtyg2J8qTpTsUdH32z4wiyBS5d6HljXWk4lBM59JrW9
	 5QDWnXzXmGj/JiZDsiw7l6svQhWvZ8vvM/ghfie4v7kYQ27T+aXt78/6nHbKr+yrhPBV+
	 JrgRZfXhV1KAYdYGA/+GeuIg9SZUHxRawrk5PQIYz8WuWXUZ25dKRlilhfyzNYikmsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599672;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=/G5+PMtTvr+Lji9tNex0mMGBnXcKq+n71breNybFLwI=;
	b=NcP6rBH/KBAGqs38/jdlH5EgFGN1zDHGyoUm6WT286PFnhv9miB+FxaT43/Cfssr5iCR
	 GzjPE1H+UBt6UQNe8W63PwG1afS1rJAbb6/duL+VDkj5gf4epzJvsWfmzlxtyT7/jbqf2
	 /ZzfnusHTYuSm1jw1knT2LtnZxu6u5dt40rYVy9a3VOwBiw9MBo6PZQFBPwjAPYLwMgFG
	 cadQtj20tEh9SKLwK5IamJIglGQGKcV7TWL3GrJgStDFiN1I/bg7s7U1enW7Sb5TvVjE/
	 4Eou6Vuab0cist1fEBNBzzvfm2rtjBq1ZS8FNUBsvu86NG5Dr9QtTlMqdhUs/pgKPXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z8SLv2IG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F11C606F35C
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z8SLv2IG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC881F000C4;
	Fri, 13 Nov 2026 19:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599672;
	bh=/G5+PMtTvr+Lji9tNex0mMGBnXcKq+n71breNybFLwI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Z8SLv2IGmYK+uxrEcZ1z5VerYUGjZWI32XjyaYzM+sWtPuOuNnOl0BEqXqA6wvbbK
	 puZJcxzws9JrmkOvq5VqOYbfBRoiV5RoKadUnXSyYH0Xh7aWvprQjl0zFU8nHEXvYV
	 JfX/SpqmByscbLSJuMS5h9pG97DbQHOElPdYqrldqAkZzG1AmwPy8PbzA+qBSNwrIu
	 mc7WB8NCtNjMaYYgUMlg73H9dVlY/LkQN1EGg1Xccwznvp9gtz/Eyyd6q0b8FviLit
	 Cfh+CoBF+uWB43yc8vYQ8tSCmuXFPVUq5ahTGsQzEXeOdi1bWWe/a73zcRYz3eYIlv
	 S3q8y0kwYdHAQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:53:46 +0100
Subject: [PATCH mptcp-net 08/34] mptcp: force the charge for the first skb
 of a subflow
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-8-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4156; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JV1b3vfWEhvSWda0MnQVjLNbR4EdsNIPeWXIobkd0Tw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Z13nOfPrc+/e78fz2pNZF5jxNH5Z/eTZpCcSgUx3p
 7S2tc2a01HKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjARuZMMf0V3bF5zo2FdlX2x
 3f446T9n407u388TLav1QcXlmL6urTLD/zJxJ1l1prk1SYcdT/Y/WPfp9JPiRIF7ywrdPkzIU1m
 4lx0A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chris Mason <mason@kernel.org>

After a fallback to TCP, an MPTCP connection can stay stalled once TCP
memory use is back below the hard limit of net.ipv4.tcp_mem, and above
that limit send() on an idle MPTCP socket can leave its data unsent.

A push moves data from the write queue of the MPTCP socket to a subflow,
and charges the subflow twice: for a new skb in __mptcp_alloc_tx_skb()
and for the payload in mptcp_sendmsg_frag(). On an idle socket, with
nothing queued, TCP forces both charges past the limit, in
tcp_stream_alloc_skb() and tcp_wmem_schedule(), since no ACK would ever
restart such a socket. But a push forces neither, so above the hard
limit both can be refused, and the push then moves no data.

The earlier commit "mptcp: arm the rtx timer if a push leaves data
behind" repeats such a push from the MPTCP retransmission (rtx) timer.
But each attempt fails while memory use stays above the limit. After a
fallback that timer is disabled, so the data stays unsent until another
event, such as the next send(), repeats the push.

The fix used here is to:
- force the charge for the skb if the subflow has nothing queued
- charge the payload with tcp_wmem_schedule()
- send only the bytes that tcp_wmem_schedule() grants

The first skb of an MPTCP-level reinjection is then forced too, as it is
sent on a subflow with nothing queued. This is bounded the same way.

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer shared with the original version of this patch:
a TCP memory shortage, for 30 seconds, during which each of ten idle
MPTCP clients calls send() once. Without this patch, only 5 of them had
their answer during the shortage, versus 8 with it: the 2 others are
blocked in send() during the shortage, which is not fixed here. Some
answers only came after the next send(), 300 seconds later, because of
the issue fixed by the previous commit:

  IDLE label=behind-the-second-send t=338.9 conn=0 [...] answer_at=336.4
  IDLE label=behind-the-second-send t=338.9 conn=1 [...] answer_at=4.2

Fixes: 724cfd2ee8aa ("mptcp: allocate TX skbs in msk context")
Signed-off-by: Chris Mason <mason@kernel.org>
[ Shorter comments. Commit message: the first skb of a reinjection is
  forced too + how the issue was found, and its symptoms. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index dc8cdda31a98..8d6ed293f6e5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1387,13 +1387,17 @@ static struct sk_buff *__mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk, g
 	if (!skb)
 		return NULL;
 
-	if (likely(sk_wmem_schedule(ssk, skb->truesize))) {
-		tcp_skb_entail(ssk, skb);
-		return skb;
+	/* like TCP, force the charge if nothing is queued */
+	if (tcp_rtx_and_write_queues_empty(ssk)) {
+		sk_forced_mem_schedule(ssk, skb->truesize);
+	} else if (unlikely(!sk_wmem_schedule(ssk, skb->truesize))) {
+		tcp_skb_tsorted_anchor_cleanup(skb);
+		kfree_skb(skb);
+		return NULL;
 	}
-	tcp_skb_tsorted_anchor_cleanup(skb);
-	kfree_skb(skb);
-	return NULL;
+
+	tcp_skb_entail(ssk, skb);
+	return skb;
 }
 
 static struct sk_buff *mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk, bool data_lock_held)
@@ -1449,6 +1453,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	bool reuse_skb = true;
 	struct sk_buff *skb;
 	size_t copy;
+	int avail;
 	int i;
 
 	pr_debug("msk=%p ssk=%p sending dfrag at seq=%llu len=%u already sent=%u\n",
@@ -1522,10 +1527,14 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	}
 
 	copy = min_t(size_t, copy, info->limit - info->sent);
-	if (!sk_wmem_schedule(ssk, copy)) {
+
+	/* like TCP, allow some progress up to tcp_wmem[0] */
+	avail = tcp_wmem_schedule(ssk, copy);
+	if (avail <= 0) {
 		tcp_remove_empty_skb(ssk);
 		return -ENOMEM;
 	}
+	copy = avail;
 
 	if (can_coalesce) {
 		skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], copy);

-- 
2.55.0

