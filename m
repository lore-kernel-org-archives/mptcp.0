Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557697;
	b=ERw7Kq7tqhWCCv4gztyMSm4oiJk80un3S4P1yFHtN0SnuFAVLvEZaYCvipm9gbi6yWou
	 suL90vdglzDutgPGnNmafghj7clL4TyzbhINXbTl10tyctzaH8ierfAuVhqpz7UnOC3tw
	 oeK2VTsbB4j1lJyuu56DpqiH6kr8OLManlfk0z/TCTugnLSh6Z+6JqZzj6yruR4wrOJfx
	 NrkFHxNAen215f9H3LbFUK6z+YZSCuQB6EuORCnByXGdIZCSBj6C+73BLoMiCMBkJIe2e
	 BVhrqgA66qre2qc2bbkohORI3j5A4UBSKp/tGBU5Qm16PnPxpXyQ53YfsK/gz2qwCbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557697;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=MSb2J0ZqhG2VmwfH23ZJbs/41OHMAOYAQLojgljwPa4=;
	b=fQGDKKATwmsRr0Ij2Yl2g3fLbk9wIFIefmFdGvMsHUk2BwQv8dm9WMjY7/Ex/Fuc8xJf
	 Frf7J/O65Fh9CP1zL3cGnFWbTgLMB++dPwO0H5896HdfnMvNm0EmPEiEnEFTw1VT6ppaR
	 aKplrwkGRuizpOkAl90oavxifACNAY9uctPlFcswCLAZ3fhrJI2EvbU+2vzVWPll9V4hP
	 5UBgdRmsFRX3JVmP1174K4NECaXws65viuThP/sSyTio2eKVPJmb91T50nCwttHm8soLV
	 jVqzrFJocV+YtwsfDG7TTBoVIRp2N06XwXdfrPKMCMoa4ikCOUxN2aMgUZNYX5AxpWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HMRHk11Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0414606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HMRHk11Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008601F000E1;
	Tue, 24 Nov 2026 22:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557697;
	bh=MSb2J0ZqhG2VmwfH23ZJbs/41OHMAOYAQLojgljwPa4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HMRHk11Zuc9jqAzq5epRJodI0ypq1Zq9gQQOADzv4MN8Z0qvsGoqu/A1j5uzhiGj6
	 Su/WIbq4vEFMtIb54abcTMKZ/C9cs9xo9FTVbeh8oAT0ziORfQ8ZZrS69FK+KQhqX7
	 uy26mMWVLbMA75mQBl+QlaxNX+D3gMUQ9n30WxRjofnakGGEUptrNEht40+jCmCI9A
	 DKhl4VrNtUjRVbh2YRGFbULcff1KakcYHyvbXpCGA71z/2BV87krhdL6h5XBh0PuD/
	 s9xK5glVzx3BnJcCRBm0bbjSQcqrvO9/dQfg4EuVRd9mFWoNoO9UWYxgupoP+qLdxn
	 tQZFl4in0z6xw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:49 +0100
Subject: [PATCH mptcp-net v3 32/50] mptcp: reclaim forward memory after
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-32-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3133; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=kI2nu9d4O553MYbh4Xf7mn+DNy11OkedNos71ZehiQY=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGsGCQqhK6TAuy45gPcd1ft/Ou6W5kaaU2fN8cu94eCuldkfL
 oh1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmsGCQoACgkQfCLwwvNHCpfZmwD/fSod
 25AVwCMc4dd4FbjBcAZiBMLbQerdQ+stY5O9RzAA/3dcBj1eSSuX/V0vJzxwTk1e/bM8n6xLERx
 OlnnW9nAP
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
Note (Clashiko on v2): with an owned skb, the new reclaim is a no-op,
sock_rfree() having already reclaimed: the comment is for the borrowed
skbs, the ones needing it.
---
 net/mptcp/protocol.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f3dd15293bc8..f8cb585da0b3 100644
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

