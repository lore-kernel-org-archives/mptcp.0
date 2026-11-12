Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794459579;
	b=2uup6n5OcxOWSOIcPpq0S6rEdZCZVw52bgYcpgBorqpIhiWrHT0nhn/glvughBhxHyyA
	 wTRVDxOtLDuXP+AcWBD3qsclfxrseXVAmarKIe6BAaqFTZMOQrC5mbXi9lmwQf45zo6NE
	 jr6VENM9hLw5YkHY454ojyulN13vsXxQs5I6IsloskUv+/OEyp3jYb8Lgv77gx3QhoPeZ
	 4RdVUwT+GJAreSPiLagtQTgIFGKp9C+PrnpjobJLE13NGPEFXP3V6V/BL1oahibtWmrvB
	 9cMt/lwWipud6T39/myUAc6RDgOmhdYXrcptDw8GfyXDBEkvhvtMVGEn+M4G6sLKBYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794459579;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sCwhAbk1U7zhliYAxZkMA/nfNOcSzIYNCrOZGxReTY8=;
	b=cxQ+5LLrv+VWgmF4dMTKghZHVUEVRRmo+TXulgOVLu+DCJuf2zxNlI0MNE2EUU1BGPQd
	 K9mcuG3qYBkKzafVel3H/YQw4O2xfoTRIZIABij5eNAcm1+X1B3CakeEYXopIiEdKhM5Y
	 O9uO5r21H/fkU+c8LLshfunPlSu+7u1dQkO5aKc6sECer+jdV2WV3QU3aJA111RmQVHib
	 4uVtjDenWF297Tol9udt7JQo1E2ZqgdSa2ez/hAX93y7ro8lYXyYaW22lCGO7EFxzcj1B
	 k2VMQgwuwQoUiiSdhGLEibg6dU4jvOW0UHs/e+daBaJcZF7B4t2b7GCLtfOmqgSvpNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pk4E2d6e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8821606A31C
	for <mptcp@lists.linux.dev>; Thu, 12 Nov 2026 04:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pk4E2d6e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677CB1F00A0C;
	Thu, 12 Nov 2026 04:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794459579;
	bh=sCwhAbk1U7zhliYAxZkMA/nfNOcSzIYNCrOZGxReTY8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Pk4E2d6edh5cLiApvp3xm+UHl4DuZbBY6VGGABl8K/sOZbIKXcLyYG+QiCSN9HQ5N
	 Jea9/6HBVwNyAAGaurE0b8zpJvnLwA2Ul2Q5CvCw4QJF1+zVLOfJNMncl4hNPlStZX
	 nfWe9YwMbazLqs3IPZ1c5t9nO+hqLUW0u0VJJABYeyYtxhninU4DNm4jNNYQHRm1xL
	 6LDILXsYW+6iS1CYwY38U/4BzFI6NcOfwMwphBQbG+I/aE+y0DtNMcBVbr+f3ulRFw
	 0vQ43Qdom/klXqEoHQYt2AG5G2o/KTdIQ7srzpo/ws7rJcvnbniIlINXHfs7KhmpI3
	 NAMuZGXVs1Keg==
Subject:
 Re: [PATCH mptcp-next v25 7/8] mptcp: sync mptcp skb cb layout with tcp one
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 12 Nov 2026 04:59:38 +0000
Message-ID: <179445957892.488855.11648346256985509007@kernel.org>
In-Reply-To: <df3814cd79f7708ede64778d172fe07db2bc7766.1794304840.git.tanggeliang@kylinos.cn>
References: <df3814cd79f7708ede64778d172fe07db2bc7766.1794304840.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message gives the wrong reason why the new 32-bit
  MPTCP sequence numbers are safe.

--

mptcp: sync mptcp skb cb layout with tcp one

This commit shrinks the MPTCP skb cb map_seq and end_seq fields to 32 bits
so they sit at the same offsets as the matching tcp_skb_cb fields. It also
adds a map_seq64 field that keeps the full 64-bit DSN. Most receive path
comparisons now use the 32-bit before()/after() helpers, while map_seq64
is used for the window admission and coalescing checks.

> The CB layout changes map_seq and end_seq from u64 to u32, adds a new
> map_seq64 field to track the full 64-bit DSN, and aligns the existing flags
> field with TCP's tcp_flags offset. The 32-bit sequence numbers are safe
> because all SKBs in the receive queue and OFO queue have been validated
> against the receive window (max INT_MAX), so their sequence numbers are
> guaranteed to be within 2^31 of the current ack_seq or copied_seq.

[Severity: Low]
Does this description hold for the receive queue?

On the receive side, the only MPTCP-level check against rcv_wnd_sent seems
to be in mptcp_data_queue_ofo(). It only covers skbs that go into the OFO
queue:

net/mptcp/protocol.c:mptcp_data_queue_ofo() {
    ...
	if (after64(MPTCP_SKB_CB(skb)->map_seq64, max_seq) ||
	    after64(end_seq, max_seq)) {
		/* out of window */
    ...
}

In __mptcp_move_skb(), the in-sequence branch and the partial-overlap
branch both jump to the insert label. The skb is then queued on
sk_receive_queue with no rcv_wnd_sent check:

net/mptcp/protocol.c:__mptcp_move_skb() {
    ...
	if (MPTCP_SKB_CB(skb)->map_seq64 == msk->ack_seq) {
		/* in sequence */
insert:
		if (!mptcp_try_rmem_schedule(sk, skb)) {
    ...
	if (after64(MPTCP_SKB_CB(skb)->map_seq64 + copy_len, msk->ack_seq)) {
		copy_len = MPTCP_SKB_CB(skb)->end_seq - (u32)msk->ack_seq;
		goto insert;
	}
    ...
}

The only gate on that path is mptcp_try_rmem_schedule()->mptcp_can_ingest().
That is an rmem check, not a window check, and fallback sockets skip it
entirely:

net/mptcp/protocol.c:mptcp_can_ingest() {
	return likely(sk_rmem_alloc_get(sk) <= READ_ONCE(sk->sk_rcvbuf)) ||
	       __mptcp_check_fallback(mptcp_sk(sk));
}

The 32-bit arithmetic still looks correct, but for other reasons.

The before()/after() comparisons on OFO skbs in __mptcp_ofo_queue(),
mptcp_data_queue_ofo() and mptcp_prune_ofo_queue() are bounded by
rcv_wnd_sent - ack_seq. That is roughly the TCP-scaled window, not
INT_MAX.

The unsigned offset calculations on receive queue skbs in
__mptcp_recvmsg_mskq() and mptcp_recv_skb() are safe because copied_seq
falls inside or at the edge of the head skb. No window check is involved.

Could the commit message say which bound protects which comparison? The
last patch in the series ("mptcp: defer read_sock cleanup to
mptcp_worker") doesn't touch these paths or this text.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794304840.git.tanggeliang%40kylinos.cn
