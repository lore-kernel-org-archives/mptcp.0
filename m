Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793839265;
	b=a9U07qt3O0IDLaMxC6KkQtu4NFsP1NZUFFxaX5+6FdqMK3yrfBFs+bYq/KeCz2TxC17o
	 I4UkauBNKJZrtHAJADZaPYxnfB268Y/TVkpSW9qCeQXmT4N14Fx8TEEKuOPScvwHwPLjy
	 TLqhkQE8LxG7kRDqmrMPLg3qEl4Ag+88sSn/iM4Nbifh8JtBUyTRfoAjGXDM84ICuSDxj
	 vQ25ibVNSzcXMNAsSv6jlxFahwHZlsygKP35LVQBM4DpWBQTbJy3RAbmre1p3XAu1zY4f
	 OwU/s5yb0zD3GQBZkv3ArnQMghagYZsQUIHm1QUnXfuTZxZT9edhDX+4zHZZCzpr73Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793839265;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=cbLYxzd52scvU9DU4iBatAL4umfWvyBtTslFkjnyNWE=;
	b=sAUEtPmbLdaedGWGNSSdyP4F9j3u9xgcZztfy3QUXbZGfidFKZIEaQhyV2NQEw5E4omJ
	 bLO2bMZJNz9S6uveYqDjvv39ZxtwhUngWGinm0DvEWU96TeSH0kGwmuWf9xqVi/QEZQM5
	 9hjCjAUHgujg4DL2s3BlL/NJg8FUPmbw9JDnRjwX9O+/tyMDgvCaLEHKfKcDLrQvFopFC
	 ZN29UZl9jOUTigiuT4qa/6VZWPWcJMSpZIrlUtQuCwTV5QsjCRldfvHaQPCpMDQaJHd5y
	 cAn/NW6nHS6WnTR3Cq378OK0i35rUPUdYy9TmD0x/UgDUobb/d5ooln3qVhFUzZUGWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LLzGr1Gh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59D2606A326
	for <mptcp@lists.linux.dev>; Thu,  5 Nov 2026 00:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LLzGr1Gh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCA91F00A02;
	Thu,  5 Nov 2026 00:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793839264;
	bh=cbLYxzd52scvU9DU4iBatAL4umfWvyBtTslFkjnyNWE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LLzGr1GhtebM2/4RIiDvEFJqdKVmgwcq4ebGgCQmmlaEUhImAmB7BpzbDNLrX/6/T
	 zGzP0VFz5TvTo0XJtu2+811/RK+keCcUL9Zd3W8109iGbm4PnzO0/s7zJ5uk/whE+O
	 PLzOHGPKyzjhq6WMiRmXB400n2W5Nmt94fnTnbPWYHWXzEW0DxxsDG8uEd8BwDKfgk
	 XZxMhQPMvCRlehHiXc8funmS3XHTrvaC3/OUh3YS8vWH6NGyCYOhZlGLNvyyNv4y0v
	 eqeNiXg0r/XsmIhEV/F8QAWGHzqS5TPWKtFLrIKD9lyjK68m2fMV42nFOOoY0qQ27F
	 PKjPSoBbhs/bg==
Subject:
 Re: [PATCH mptcp-next v20 5/6] mptcp: sync mptcp skb cb layout with tcp one
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, pabeni@redhat.com,
 kuba@kernel.org
Date: Thu, 05 Nov 2026 00:41:03 +0000
Message-ID: <179383926361.488855.10237992890460382669@kernel.org>
In-Reply-To: <cf2994ec4440d24183bea5c407c1962270392c32.1793695518.git.tanggeliang@kylinos.cn>
References: <cf2994ec4440d24183bea5c407c1962270392c32.1793695518.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Critical
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

Critical: 1 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] mptcp: subtracting offset in mptcp_init_skb() corrupts out-
  of-order data
- [High] mptcp_inq_hint() in net/mptcp/protocol.c was not converted to
  the new CB layout.
- [Low] The commit message is inaccurate and leaves out motivation and
  some behaviour changes.

--

mptcp: sync mptcp skb cb layout with tcp one

This patch narrows the MPTCP skb control block sequence numbers to 32 bits
and keeps the full 64-bit DSN in a new map_seq64 field. map_seq, end_seq and
flags are placed so they line up with the matching tcp_skb_cb fields. The
receive path sequence arithmetic is switched to the 32-bit before()/after()
helpers, and a build time layout check is added in mptcp_proto_init().

> As the msk-level rcvbuf buffer size is limited by the core socket code the
> INT_MAX; after validating the incoming skb vs the current receive window,
> we can safely use 32 bits for MPTCP-level sequence number. This allow
> updating the MPTCP CB layout so that fields with a corresponding TCP-level
> data use the same area inside the CB itself.

[ ... ]

> Add build time check to ensure the latter invariant.

[Severity: Low]
Is the layout description accurate for has_rxtstamp?

In the new struct mptcp_skb_cb, has_rxtstamp is a full u8 at offset 14. That
overlaps tcp_skb_cb's sacked. In tcp_skb_cb, has_rxtstamp is a bitfield in
the byte at offset 16, and here that byte is the low byte of map_seq64.

The build time check added in mptcp_proto_init() only compares field offsets
and sizes:

	CHK_CB_FIELD(map_seq, seq);
	CHK_CB_FIELD(end_seq, end_seq);
	CHK_CB_FIELD(flags, tcp_flags);

It checks nothing about sequence numbers staying within 2^31 of ack_seq or
copied_seq, which "the latter invariant" seems to refer to. Could the
wording be adjusted?

Nothing in this patch or the rest of the series seems to use the shared
layout. flags is only ever set to 0. The final patch in the series ("mptcp:
defer read_sock cleanup to mptcp_worker") adds no TCP_SKB_CB() user for
msk-level skbs. Could the commit message say what the layout change is for?

The patch also changes some behaviour that the message does not mention.
mptcp_data_queue_ofo() now uses max(rcv_wnd_sent, ack_seq) as the admission
bound and adds an after64(map_seq64, max_seq) check.
__mptcp_try_coalesce() gains a map_seq64 contiguity check. Should these be
described as well?

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 7878e6ac6c0b6..fa54f70ab501d 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -129,9 +129,12 @@
>  #define MPTCP_SYNC_SEQ		8
>  
>  struct mptcp_skb_cb {
> -	u64 map_seq;
> -	u64 end_seq;
> +	u32 map_seq;
> +	u32 end_seq;
> +	u32 unused;
> +	u16 flags;
>  	u8  has_rxtstamp;
> +	u64 map_seq64;
>  };

[Severity: High]
Now that map_seq is a u32, was mptcp_inq_hint() in net/mptcp/protocol.c
missed in the conversion? It still does:

net/mptcp/protocol.c:mptcp_inq_hint() {
    ...
	skb = skb_peek(&sk->sk_receive_queue);
	if (skb) {
		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;

		if (hint_val >= INT_MAX)
			return INT_MAX;

		return (unsigned int)hint_val;
	}
    ...
}

The u32 map_seq is zero-extended, so hint_val keeps the upper 32 bits of the
64-bit msk->ack_seq. subflow_set_remote_key() initializes msk->ack_seq from
the IASN:

	mptcp_crypto_key_sha(subflow->remote_key, NULL, &subflow->iasn);
	subflow->iasn++;
	...
	WRITE_ONCE(msk->ack_seq, subflow->iasn);

The IASN is derived from the peer's random key, so its upper 32 bits are
non-zero on nearly every connection. When ack_seq is below 2^32 and the low
32 bits have wrapped, the u64 subtraction underflows instead.

In both cases, does mptcp_inq_hint() return INT_MAX whenever the receive
queue is not empty?

That value reaches userspace through SIOCINQ in mptcp_ioctl():

	*karg = mptcp_inq_hint(sk);

It also reaches userspace through the TCP_CM_INQ cmsg in mptcp_recvmsg().

mptcp_rcv_space_adjust() is affected too:

	copied = msk->rcvq_space.copied;
	copied -= mptcp_inq_hint(sk);
	if (copied <= msk->rcvq_space.space)
		goto new_measure;

Subtracting INT_MAX makes the int copied negative. Would msk-level rcvbuf
autotuning, and the subflow tcp_rcvbuf_grow() calls after it, then be
skipped whenever data is still queued at measurement time?

The other map_seq readers were converted. __mptcp_recvmsg_mskq(),
mptcp_recv_skb() and __mptcp_ofo_queue() use a (u32) cast, and
__mptcp_move_skb() switched to map_seq64. This one is still unchanged at the
end of the series, including after "mptcp: defer read_sock cleanup to
mptcp_worker".

Would something like this work, possibly with a clamp, or should it use
map_seq64 instead?

	u32 hint_val = (u32)READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;

[ ... ]

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -425,10 +434,14 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset)
>  	 *
>  	 * This is correct even when offset > 0 and mapping is out-of-order,
>  	 * because consumed prefix bytes are part of the same logical DSN range.
> +	 *
> +	 * Note that end seq number is only available in 32bits format.
>  	 */
> -	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow) -
> -				     offset;
> +	MPTCP_SKB_CB(skb)->map_seq64 = mptcp_subflow_get_mapped_dsn(subflow) -
> +				       offset;
> +	MPTCP_SKB_CB(skb)->map_seq = (u32)MPTCP_SKB_CB(skb)->map_seq64;
>  	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;
> +	MPTCP_SKB_CB(skb)->flags = 0;
>  	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
>  
>  	__skb_unlink(skb, &ssk->sk_receive_queue);

[Severity: Critical]
The offset subtraction is not new in this patch. This hunk rewrites it,
though, and the new 32-bit end_seq is derived from it, so could the
assumption in the comment above be double checked?

mptcp_init_skb() gives the first offset bytes of the skb the DSN range
[mapped_dsn - offset, mapped_dsn). end_seq is computed from the full
skb->len, and those bytes are never pulled. That is only correct if the
bytes before tp->copied_seq in this skb belong to the same DSS mapping
as the bytes after it.

Is that guaranteed? In subflow_check_data_avail(),
mptcp_subflow_discard_data() can drop the tail of a previous mapping M1
and clear map_valid. The loop then goes back to get_mapping_status()
and can activate the next mapping M2 on the remaining bytes of the same
skb. A partially overlapping segment queued by tcp_data_queue(), with
seq < copied_seq < end_seq, looks like it can lead to the same state.

When data is striped over several subflows, consecutive mappings on one
subflow are generally not DSN-contiguous. The prefix bytes would then
get a DSN range they never had. validate_mapping() and
validate_data_csum() only cover data from tp->copied_seq onwards, so
the prefix is not protected by the M2 DSS checksum either.

If M2 is out of order at the msk level, there seem to be two outcomes.

When mapped_dsn - offset is not after msk->ack_seq, __mptcp_move_skb()
treats the skb as in sequence or partial and moves msk->ack_seq across
a gap that was never received. __mptcp_recvmsg_mskq() or
mptcp_recv_skb() then copies the stale prefix bytes to userspace for
that range.

Otherwise mptcp_data_queue_ofo() puts the skb in the OoO queue starting
at mapped_dsn - offset. __mptcp_try_coalesce() can append it to a
preceding skb that ends there. The real data for that range, arriving
on another subflow, is then dropped as MPTCP_MIB_DUPDATA.
__mptcp_ofo_queue() releases the skb once ack_seq reaches
mapped_dsn - offset.

Wouldn't either case silently corrupt the byte stream the application
sees, in a way a remote peer could steer?

Should the prefix be pulled, or the offset tracked separately, so that
map_seq64 always starts at mapped_dsn? Or is there a guarantee I am
missing that the head skb can never span two mappings at this point?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793695518.git.tanggeliang%40kylinos.cn
