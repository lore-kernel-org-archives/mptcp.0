Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795482327;
	b=Nkgkcdpl9m0XLytzm3I3vLFDy0yDoTl4jVKMAUcc6ZckbEl8ST+/VpGz3A2tvVyDWhM+
	 3l3dO5Sts9lYXnHvNy0zew8/VB/KwrrllHwqmdY39zh2HEb+1fIbsscDDEFewot8Oa/bD
	 /FcBOryILjFRbyQvYrKRvkwbOdQpexprPuFfvsH9nL2jx2GpCAydoKUP7Of1zkE7jtrgC
	 Ujp/wIOiaMG1SHDr463BrxspULdl1wdL5tzteLprSuGWwECyB9O3vKrv/mTX99VF/0AZU
	 11D6v06IVg7JtL3GkngNWy5gPjduQzV6DaJ8N+5R3zp+uTSKiEFuEiBgO/UIXkOB89A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795482327;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wqQUXmw0eN+U1BEzVb6eIt/HY9PPX+8PEPTMI5posCg=;
	b=le1bkw8WFcnzGuvmJc44r+222qPJxDXSy+jPXCIihrdYsDOBw+St7RNqQiis37ev4fwi
	 lVAtuSiaPuWhN1LhvgT3pqAEQmUwwQvbWJezqg8O1Zr0sBSCXHRRL6GlSegrYwunRr5Mn
	 V9i9e3rArODRVEnAkv3TEziF66+ujaK5r7TeXLEFYovUjlouyIzaxXKYPHKBrk9kULjYl
	 YofYCSuEKVOqgSRSEcGZEedtL4GrM29Rpu50030IGri0POnCTmNoqRv1I+z8xHusx1w4M
	 NDYukyRwr2YQ9o0sMDrH11aoAdJ/uRE0rAn21lWTxvwOsFH9ZCxaeL9B2ZfO62DumLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O+lJ4WNY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13607606A321
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 01:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O+lJ4WNY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE4E1F000C6;
	Tue, 24 Nov 2026 01:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795482326;
	bh=wqQUXmw0eN+U1BEzVb6eIt/HY9PPX+8PEPTMI5posCg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=O+lJ4WNYakFGqp4FVUPFN78RFY4H+ewF1kOKcTvVKtRvt/9bimwSQ3qAzzUQr3Wck
	 cpC0xjDCyQj0AMesTpH4P8A0ZcKnIg4+JX+pY+0imeputPS0CKU7oROF8tvkrJYnoq
	 mhi5CyoJikb735E3JWOdd+CWD2JTcE7aVy86l/as3wLEktfa1sDPa2riJC0sgphSNR
	 VpBKV3ZkeIasLPvPiAHOJiBRTnV8CJo9H1ZukewGnkVvZum4s5wfcjH+VXo2b93oQo
	 3PbSyMklGipFbf4v8L7JYR7u3Mbvq/6ZoSa1troho+80TAqRKWA5aXEhBrHHqDM4Bm
	 HXFKDfXqmTvKQ==
Subject: Re: [PATCH mptcp-net v2 1/4] mptcp: handle ack_seq advancing past
 rcv_data_fin_seq
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 24 Nov 2026 01:05:26 +0000
Message-ID: <179548232602.3133.13372193952822740155@kernel.org>
In-Reply-To: <84d2d4f05df024cd45c1936a3d53ea1d2797ae2a.1795348666.git.tanggeliang@kylinos.cn>
References: <84d2d4f05df024cd45c1936a3d53ea1d2797ae2a.1795348666.git.tanggeliang@kylinos.cn>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch now lets mptcp_check_data_fin() run when msk->ack_seq
  is already past rcv_data_fin_seq, but the function still does…
- [High] Before this patch, the strict `ack_seq == rcv_data_fin_seq` test
  in mptcp_pending_data_fin() was the only positional check on an…
- [Medium] The commit message says that out-of-order segments in the OFO
  queue can push msk->ack_seq past rcv_data_fin_seq before…

--

mptcp: handle ack_seq advancing past rcv_data_fin_seq

This commit relaxes the check in mptcp_pending_data_fin() from
ack_seq == rcv_data_fin_seq to !before64(ack_seq, rcv_data_fin_seq). The
goal is to still process a DATA_FIN after OFO processing has moved
ack_seq past rcv_data_fin_seq.

> This handles the case where
> out-of-order segments in the OFO queue advance ack_seq past
> rcv_data_fin_seq before mptcp_pending_data_fin() runs.

[Severity: Medium]
Can this happen with a peer that follows the protocol?

rcv_data_fin_seq is the DSN of the DATA_FIN byte itself.
get_mapping_status() trims the mapped payload so that it ends right at
that DSN:

net/mptcp/subflow.c:get_mapping_status() {
    ...
		mptcp_update_rcv_data_fin(msk, data_fin_seq, mpext->dsn64);
		...
		/* Adjust for DATA_FIN using 1 byte of sequence space */
		data_len--;
    ...
}

The Linux sender places the DATA_FIN at write_seq - 1 in
mptcp_write_data_fin(), which is after all data. The fallback dummy FIN
is at map_seq + map_data_len, which is where the last mapping ends.

msk->ack_seq only advances in two ways:

  - to the end_seq of received data, in __mptcp_move_skb() and
    __mptcp_ofo_queue()
  - by 1 when the DATA_FIN is consumed

A DATA_FIN retransmitted after that is rejected by the state check in
mptcp_pending_data_fin(), because CLOSE_WAIT, CLOSING and CLOSE are not
accepted states.

So OFO processing can bring ack_seq up to rcv_data_fin_seq, but it
doesn't seem able to push it past. The old == check would match in that
case. To get ack_seq > rcv_data_fin_seq, it looks like you need a peer
that sends data at or beyond its own DATA_FIN, or a forged or stale
DATA_FIN.

Could the commit message describe the real scenario, ideally with a
reproducer? As written, it reads like a fix for a common OFO ordering
bug. The change actually relaxes validation of input from a misbehaving
peer or a forger, and that leads to the two issues below.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index fdd373ca0f94d..02542293f5acc 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -568,7 +568,7 @@ static bool mptcp_pending_data_fin(struct sock *sk, u64 *seq)
>  	     (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2))) {
>  		u64 rcv_data_fin_seq = READ_ONCE(msk->rcv_data_fin_seq);
>  
> -		if (READ_ONCE(msk->ack_seq) == rcv_data_fin_seq) {
> +		if (!before64(READ_ONCE(msk->ack_seq), rcv_data_fin_seq)) {

[Severity: High]
With this change, mptcp_check_data_fin() can run while msk->ack_seq is
already past rcv_data_fin_seq. It still does this, though:

net/mptcp/protocol.c:mptcp_check_data_fin() {
    ...
	if (mptcp_pending_data_fin(sk, &rcv_data_fin_seq)) {
		WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
    ...
}

The +1 was only correct while ack_seq == rcv_data_fin_seq. The
rcv_data_fin_seq value filled in by mptcp_pending_data_fin() is never
used.

Say ack_seq is A and the DATA_FIN DSN is F, with F < A. Won't ack_seq
end up as A + 1, rather than F + 1 or staying at A?

Three things seem to follow from that.

First, the DATA_ACK sent by mptcp_send_ack() acknowledges A + 1. If the
peer's snd_nxt is A, ack_update_msk() on the peer ignores it:

	if (unlikely(before64(snd_nxt, old_snd_una) ||
		     after64(new_snd_una, snd_nxt)))
		new_snd_una = old_snd_una;

Could the peer's DATA_FIN then never be acked?

Second, the msk moves to CLOSE_WAIT. __mptcp_add_backlog() only drops
data in TCP_CLOSE, so a later in-order skb with map_seq == A is still
accepted. __mptcp_move_skb() would then treat it as a partial packet:

	/* Partial packet */
	if (after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
		copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
		...

Is byte A of the stream silently lost here?

Third, any bytes in [F, A) already on sk_receive_queue are passed to
userspace before EOF, even though the peer marked the end of the stream
at F.

Should ack_seq be derived from rcv_data_fin_seq here? Or should
ack_seq > rcv_data_fin_seq be treated as a protocol violation?

As far as I can tell, no later patch in the series touches
mptcp_check_data_fin(), so the final tree still adds 1 unconditionally.

[Severity: High]
Before this patch, the strict == test was the only check on where an
incoming DATA_FIN sits. Now, does any DATA_FIN whose DSN is at or behind
ack_seq get acted on immediately?

A zero-length subflow segment that carries a DSS DATA_FIN with
data_len == 1 reaches mptcp_update_rcv_data_fin() directly:

net/mptcp/options.c:mptcp_incoming_options() {
    ...
	if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq) {
		if (mp_opt.data_fin && mp_opt.data_len == 1 &&
		    mptcp_update_rcv_data_fin(msk, mp_opt.data_seq, mp_opt.dsn64))
			mptcp_schedule_work((struct sock *)msk);
    ...
}

No payload, mapping or checksum covers that DSN.
mptcp_update_rcv_data_fin() stores it through mptcp_expand_seq() without
checking it against ack_seq:

  - with dsn64, the raw value is stored
  - with 32-bit DSNs, any value in the 2^31 window behind ack_seq
    expands to a past DSN

So a forged or stale DATA_FIN used to need the exact 64-bit DSN. Now
roughly half of the DSN space works, for example DSN 0 with dsn64.

mptcp_check_data_fin() then sets RCV_SHUTDOWN and sends a DATA_ACK. It
also changes the msk state:

  - ESTABLISHED goes to CLOSE_WAIT
  - FIN_WAIT1 goes to CLOSING
  - FIN_WAIT2 calls mptcp_shutdown_subflows() and goes to TCP_CLOSE

Together with the unconditional ack_seq + 1 above, the next legitimate
in-order skb would also lose one byte.

Could a misbehaving peer truncate the stream this way? Could an off-path
attacker who can blind-inject an in-window zero-length segment do the
same? For comparison, plain TCP only acts on a FIN at rcv_nxt.

It looks like the relaxed !before64() check is also kept in the
mptcp_data_fin() helper later in the series.

>  			if (seq)
>  				*seq = rcv_data_fin_seq;
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1795348666.git.tanggeliang%40kylinos.cn
