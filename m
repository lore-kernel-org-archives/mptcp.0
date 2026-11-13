Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599695;
	b=zQKbhWahdycs1hTLUxjDV9AlOmq8VI5b9+6+9bD/L+WLr8WJTZKh0A0GYwGMt3n/71et
	 Ajn/TvKXj7QsdwoTXweXuBnS6zeMpdOb8kDrg6F1KpbKqZNzyUs3BBMg/cKhhyAiow5N9
	 +XpvmOPVNrcvTIEehgZhHN052lR0Tbs58OuoESyVkBhQ4nsXH1q53xMPBAJpAWweQx7lb
	 PP+ajvizcpBeXj0IHuLjK4mV9VlBNSqXDEJo0lmE+qtDbtiRfQQYPf2ybU/7yiQGqwApt
	 btix4VvXr8Ysb03kuqYYKq+yJVGHsIxJ5m8cf34OXSjQd66mVd6T3xTCvrpBHg3BcsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599695;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=THxN1T4aANbFzmX1cuvclRlaxB/76WnQPGnh/XvBdBQ=;
	b=aXHxSuv8nBW+7KF/5sIGe524zTOdgX/cGm057wd53320zXOR4PrjKi8q7oxgBRAaBBUy
	 YR3VHBY3x0Lzg3mMLK1DmyTkAjk6/WuuBKKFa9F+LcS5H37lEw+22BPr87N5qXxorGc2O
	 uafHznp5y0QsU4OoLnagCwX4vHY3FGBbTTG9BPh87k//V+vdXNXdoOnk2vQw83nw0boMW
	 g/i9qiqXEkRMzgfCzh9ILF/gIEqHr53rnstG8gLk6xY2Y9vE4/jWGsbayC5nD6EH0bB2N
	 KAo/e/QrLCDfGCNt4iRUIxB6ro3cgyyu9h7I86pyXLQRzMVi2Ydb0rFL4vGkK2j6FlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a+VdbB3K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F7C60A3801
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a+VdbB3K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977111F000C6;
	Fri, 13 Nov 2026 19:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599695;
	bh=THxN1T4aANbFzmX1cuvclRlaxB/76WnQPGnh/XvBdBQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=a+VdbB3Kp/OzjW1q48HPqvAYeFYPsv4j91XeAqGF6q2bk6Ad/aTep62QrmihkRI/3
	 1P4W1tQ8KJTBpBEU57KVAbNaX621Mr8BYjPiUvIOoFE3e6guCOv+1DX7f8NtvCxbVP
	 zSWDAVEAAcZpx9CM4/mTYlglmgtJ/CESx09Xh/V5jYlsDp9t7pC8L1d3n3RHGXAGJo
	 Qty48hN30RhMQ3XWPn8uoj4j0aVNnCiXoVyndWAzGgMzJORTrqDlS49ZGkImmVDRXw
	 RC/dfIMQXchDRtM1EsPfElwUzD9vHO5MMJKANDpZextJOI1vdexYzdGX60dXrMne+q
	 q9FUTtluOWfIw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:54:06 +0100
Subject: [PATCH mptcp-net 28/34] mptcp: reclaim forward memory after
 coalescing skbs
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-28-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2957; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=iNMKPU9f1mtAwb9m5EG4B3dJgQMqVdeOh6NRUwvXimQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Zz3b/D7m+fIr959E7D5x3WrLjQ+v9FIFzXU4LJr/z
 t2q8Kr9VUcpC4MYF4OsmCKLdFtk/sznVbwlXn4WMHNYmUCGMHBxCsBEqg8zMqw6Yam+N5dXyOSv
 SAALw+Q3pm83LJzxsefOM3Hez2ZJq+4z/FNbv0/vyErLk96PhDldtve1PBDJPBdi5FFtujL6sGT
 fKRYA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chris Mason <mason@kernel.org>

If MPTCP sockets receive many small segments whose data stays queued,
TCP can stall on the whole host, and an MPTCP server can be OOM killed
in its memory cgroup, although almost no memory is in use.

When the MPTCP socket (msk) takes over an skb from a subflow,
mptcp_borrow_fwdmem() adds skb->truesize to the sk_forward_alloc of the
msk, and the subflow reserves new memory for the next skb. Both
sk_forward_alloc and sk_rmem_alloc count against tcp_mem and the memory
cgroup, but only sk_rmem_alloc has a limit, sk_rcvbuf, so what queueing
the skb does not move to sk_rmem_alloc has to be released. But
mptcp_try_coalesce() moves only the increase in truesize of the skb that
receives the data, and skb_condense() in mptcp_data_queue_ofo() can
lower skb->truesize, so the rest piles up in sk_forward_alloc.

The fix used here is to return every whole page of sk_forward_alloc with
sk_mem_reclaim(), in mptcp_try_coalesce() once the merged skb is freed,
and in mptcp_data_queue_ofo() once the skb is queued.

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer shared with the original version of this patch:
a remote peer sends 33000 segments of one byte after a hole in the data
sequence, which are merged in the out-of-order queue. Without this
patch, the memory forward-allocated by the MPTCP socket -- msk_f -- grew
with each merged segment, above 29 MB, versus 3200 bytes with it:

  SNAP label=stage1-1-connections tcp_mem_pages=7168 [...] msk_f=29445248 [...]
  [...] OFOQueue=33000 OFOMerge=32862 [...]

With more connections, the original version of this patch reported that
the TCP memory went above tcp_mem[2], stalling the other TCP
connections, or that the memory cgroup went above its limit.

Fixes: 9db5b3cec4ec ("mptcp: borrow forward memory from subflow")
Signed-off-by: Chris Mason <mason@kernel.org>
[ Shorter comment. Commit message: the rest of the borrowed amount has
  to be released + how the issue was found, and its symptoms. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 388e77da8f16..0758b048316e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -197,6 +197,9 @@ static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	sk_mem_charge(sk, delta);
 	kfree_skb_partial(from, fragstolen);
 
+	/* release what is left of the borrowed 'from' truesize */
+	sk_mem_reclaim(sk);
+
 	return true;
 }
 
@@ -422,6 +425,9 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 end:
 	skb_condense(skb);
 	skb_set_owner_r(skb, sk);
+
+	/* skb_condense() can shrink the truesize borrowed from the subflow */
+	sk_mem_reclaim(sk);
 }
 
 static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,

-- 
2.55.0

