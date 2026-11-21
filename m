Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254179;
	b=sHiRVZTm6L5oMntl5RRirxz6NX5HYMBkK1qOiY7sfElFAo72Sdu29SYs2X9JypZ+4nEm
	 xGF6B2pITCWgGUvwF6hshWW1rP2AyNWZCIWa0FXLpUGY+X3YDdLXZU39P5sV9tgMxXy5u
	 +foVNL2rcT0z+qnVpac3HJUaWL3FR7mXydKUxLgd2sMBcbfrqrBBBjJu/wlv8ICyDL9yu
	 LTjID2jv6tMKhavTNyvbI6vd5OmrCgu5O0ehSHGmRYHd0UjXFXjj4fZ2ZjaJGvU06p7nI
	 Bf++rB8zN+69yO5Ktiea62e5Aot+F8oVhWl+s6bNuaI1FUKPmpOQEc/slHSoTwJkKEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254179;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=3nozOWYPt0ZJfig0o0Xjewlw0ahJe0nGI2u2sVRmmdU=;
	b=rrfywwY9/Us0v1qtV6f/j+4nwf4gAgzar2juBsSGbYq6zoc504BEGbLOAm5OPorulIoi
	 gybBez5OVXVqblexiaxvyMrhvZRfCd5Rgt8frLUm1a8dgWhOCpmLfcHBK3QoArT0Zy1+N
	 xc0lP1HvAfy6YcjxmOTRGSku8LnMd7sFtpOOqoWG5qHCb/KusTqxY5foFX3/y7dfSCv+t
	 apNcRblHJRnxqANcaPlOcXLHVYVimRB+fUd9b3aS20T55JyvH8pElKdhcgO7VPNFtsyIg
	 qRHD1AudIID8M9tG5thIXIhrOxgsBkFu4UIpnPcIVVSczLVGRe2WX6AgMEU3L63K/Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="c+Ytnq/z";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD714606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c+Ytnq/z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CC31F000D2;
	Sat, 21 Nov 2026 09:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254179;
	bh=3nozOWYPt0ZJfig0o0Xjewlw0ahJe0nGI2u2sVRmmdU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=c+Ytnq/z79hx8HEZUvTHeiCo967zzfg+g3dv2y6z/PyesoP8CLd8f5I6IcARtYQbF
	 TkAVkhlgblUQ1f0Z9G5DfLq8vPCH5GSSAXZLFb2/SDg0qr0PS2LN/E9yo92MiaMPh/
	 9G7LdyQHSN4xads25HpqWZdpKUHQsj5D5THmzgRBjKuKy4B6ZWejkqaR3YcWjvsbSn
	 Z8JpW3dePNqATyjjQGgiDIZka1nUkZbwfaUhlqkCqp9k/zbm++Exxov520CQAwzmyh
	 irSnFp/tByoedspE6C8JGRlDbjeoxskOuV3ysdFkWnXer0c6k4jx4e+OkMKSjLTvwa
	 xNcjx/JVwNG4A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:44 +0100
Subject: [PATCH mptcp-net v2 46/62] mptcp: reclaim forward memory after
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-46-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2957; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=FmparkxhIMbiohGafjtjBYSkpw+HWVpI4C7QSx/bhV0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ07OP7dgi5jP3ZgunYn30xSy1erXG73PMU/833/hxv
 uGDwuEVHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABOZLMrwz6h47qaw1ytUdkqq
 3Za3drT/tHVFk+26ffXtPTcc31w+wcDI8CJg/+m6II4X8Z8nPf1xUZIp62RrcNdTjfzKDysDHT7
 d4QIA
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
index d90e6a5cc9ff..adae675227df 100644
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

