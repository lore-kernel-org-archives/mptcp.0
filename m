Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792859170;
	b=EDv1eB8zJ90wnHYAQGA1dD1CA5W/LedMszsE0WIyyzDlOPRnfyoxfoONQaa2oXWDzjRY
	 6iFgbTIxlAhxyDChnfZpXdDwL5MiPEA5yWi8G/awQz0b2z7NP3T6kIdng4Uj6qZ97RTDT
	 JhmKtdHowdWJTL9sWrV5unuAdDgiog795SMXIA6AbUV0dWIpklskNk17LEjOPZXxsijka
	 rhtEjcG9b0FPLR5nchLTDji+R3rPXi8KHtSOpGOJOdz/mvEYMRG9rmf+A96witKqUgy7R
	 RzpWjbVBBgEP00I0ie39Z0obFNuxPkfLwejpnaz58sQvX9s4cMgXKjQivy4EdCiDsLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792859170;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1oRFBwlmOCy+Bs2/t8Y34IHKip1N83FfFh/1FRLOi4Y=;
	b=kqn16XWC+oTAwnMWOm08z2ct4bZwL4u6nugyxAwKDglPgny50Nc1vaWveoKZNEpswORN
	 TWnfq5TSvRaJw4u6UUUjpa3Jaz04yYhWvPgip7C1CA6lDTEaKb+mfq7LruIiihsLvcst/
	 GFCQW7SDayQwAWm0i1xgwK8wLGaMPTdrQD6OxiCQ/4EAbrFGmMIqQEYIJtYWP0h+i8jmC
	 Rb1ruJQ+Me5vMG0aDB7dmmt8giCucCaC4Skj4hil1Yuz5HadDlYl0Ra1yjDPXb3UHbSDl
	 kIL7LbDkr5RBmK0T+RhetwzPpJScW5xFqCL+LO/KILo22cxUP8G0RwJWP10TuV32stg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1D9SfvK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AAC606A325
	for <mptcp@lists.linux.dev>; Sat, 24 Oct 2026 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1D9SfvK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288CE1F031E0;
	Sat, 24 Oct 2026 16:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792859170;
	bh=1oRFBwlmOCy+Bs2/t8Y34IHKip1N83FfFh/1FRLOi4Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=R1D9SfvKAjy8wDLdq3cEa+AB01DA3GOVR2CBzbQmNGHLV0S9PE+t1dhDtevFGNY09
	 BuQkZnNU8/5joCw5vAPzFCOeewR5LlPHZQpl9jq877+2WQp4tWj0bOHcwxBmhZVldM
	 6e20DwtetMlSTmmh6agQpYFCn6j5Emz09pw3jV2kIRiGons6ggKBq7yZ8P+/5agWey
	 8rOdnJI7DG2KEctSzgSPi9ghea1EGIYn5u7n++T1XDOihtjLeDmnMDfGOG/RAZZHef
	 KGmCOHTLM5foj9ivPH88TN3MyhowTh9AsVTxaiMAsa65MZXDKVBDYs+GCaTWAIvw/M
	 NaELxHGMswb3w==
Subject:
 Re: [PATCH mptcp-next v15 04/11] mptcp: sync mptcp skb cb layout with tcp one
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, yangang@kylinos.cn, kuba@kernel.org
Date: Sat, 24 Oct 2026 16:26:09 +0000
Message-ID: <179285916974.3132.1607917745186645456@kernel.org>
In-Reply-To: =?utf-8?q?=3Ca0dc7793379f9fd85ac0f9ba8acb9e7f8f7100e3=2E1792718?=
 =?utf-8?q?041=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3Ca0dc7793379f9fd85ac0f9ba8acb9e7f8f7100e3=2E17927180?=
 =?utf-8?q?41=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In __mptcp_ofo_queue() (net/mptcp/protocol.c), the patch
  replaces the 64-bit OFO dequeue checks with 32-bit after() comparisons…
- [Low] The commit message for "mptcp: sync mptcp skb cb layout with tcp
  one" does not match the code.

--

mptcp: sync mptcp skb cb layout with tcp one

This commit shrinks the MPTCP skb cb sequence fields to 32 bits, so that
map_seq, end_seq and flags sit at the same offsets as the matching
tcp_skb_cb fields. A 64-bit map_seq64 copy is kept for the admission and
in-sequence checks, while the OFO queue and recvmsg paths move to 32-bit
arithmetic. A build-time check on the field offsets is added in
mptcp_proto_init().

> As the msk-level rcvbuf buffer size is limited by the core socket code the
> INT_MAX; after validating the incoming skb vs the current receive window,
> we can safely use 32 bits for MPTCP-level sequence number.

[ ... ]

> Add build time check to ensure the latter invariant.

[Severity: Low]
This isn't a bug, but does this sentence describe what the patch adds?

It comes right after the paragraph arguing that 32-bit arithmetic is safe
within 2^31. The check added in mptcp_proto_init() only compares field
offsets against struct tcp_skb_cb:

	CHK_CB_FIELD(map_seq, seq);
	CHK_CB_FIELD(end_seq, end_seq);
	CHK_CB_FIELD(flags, tcp_flags);

Nothing checks the 2^31 distance invariant, at build time or at runtime.

The message also says the patch moves to 32 bits for the MPTCP-level
sequence number. However, struct mptcp_skb_cb still has a 64-bit
map_seq64 next to the 32-bit map_seq and end_seq. map_seq64 still drives
these checks:

  - the in-sequence test in __mptcp_move_skb()
  - OFO admission in mptcp_data_queue_ofo()
  - the partial-packet test in __mptcp_move_skb()
  - the coalesce check in __mptcp_try_coalesce()

Could the message mention this?

The patch also depends on two new invariants:

  - map_seq == (u32)map_seq64
  - end_seq - map_seq == skb->len

Every CB writer has to keep them in sync: mptcp_init_skb(),
__mptcp_sync_rcv_sequence(), mptcp_fastopen_subflow_synack_set_params()
and __mptcp_try_coalesce(). They seem to hold in the current tree. Would a
comment next to struct mptcp_skb_cb in protocol.h help?

The claim that receive-queue skbs are validated against the receive
window is covered in the __mptcp_ofo_queue() comment below.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f2840c8d9c825..01eb7fb314e76 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -893,37 +903,37 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
>  {
>  	struct sock *sk = (struct sock *)msk;
>  	struct sk_buff *skb, *tail;
> +	u32 seq_delta, ack_seq;
>  	bool moved = false;
>  	struct rb_node *p;
> -	u64 end_seq;
>  
>  	p = rb_first(&msk->out_of_order_queue);
>  	pr_debug("msk=%p empty=%d\n", msk, RB_EMPTY_ROOT(&msk->out_of_order_queue));
>  	while (p) {
> +		ack_seq = msk->ack_seq;
>  		skb = rb_to_skb(p);
> -		if (after64(MPTCP_SKB_CB(skb)->map_seq, msk->ack_seq))
> +		if (after(MPTCP_SKB_CB(skb)->map_seq, ack_seq))
>  			break;

[Severity: Medium]
Is this 32-bit after() still correct when an OFO entry is 2^31 bytes or
more behind ack_seq at the time __mptcp_ofo_queue() runs?

The commit message says "all SKBs in the receive queue and OFO queue have
been validated against the receive window". However, only
mptcp_data_queue_ofo() checks against rcv_wnd_sent. The in-sequence and
partial paths in __mptcp_move_skb() advance ack_seq with no window check:

net/mptcp/protocol.c:__mptcp_move_skb() {
    ...
	if (MPTCP_SKB_CB(skb)->map_seq64 == msk->ack_seq) {
		/* in sequence */
insert:
		if (!mptcp_try_rmem_schedule(sk, skb)) {
    ...
		WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
    ...
}

The only limit on that path is mptcp_can_ingest():

	return likely(sk_rmem_alloc_get(sk) <= READ_ONCE(sk->sk_rcvbuf)) ||
	       __mptcp_check_fallback(mptcp_sk(sk));

This is always true for fallback sockets. It is also always true once
sk_rcvbuf reaches INT_MAX, which mptcp_rcvbuf_grow() can reach when
tcp_rmem[2] is set to INT_MAX.

__mptcp_ofo_queue() runs only once per batch: at the end of
move_skbs_to_msk(), and once per backlog spool in __mptcp_move_skbs().
The backlog limit in __mptcp_add_backlog() is about rcvbuf * 1.5 + 64K,
roughly 3.2 GB at INT_MAX. On fallback it is skipped.

Consider this sequence:

  1. A peer places an OFO segment X.
  2. On other subflows it sends in-sequence data that covers X and
     extends more than 2^31 bytes past it, all within one batch.
  3. The after() check above then sees X as ahead of ack_seq and keeps
     it. The old after64() logic would have dropped it as DUPDATA.

Later, about 4 GiB further on, (u32)ack_seq falls inside
[X.map_seq, X.end_seq). X then passes both 32-bit checks. It is appended
to sk_receive_queue by itself, because only the map_seq64 test in
__mptcp_try_coalesce() rejects coalescing. ack_seq then advances by:

	seq_delta = MPTCP_SKB_CB(skb)->end_seq - ack_seq;

__mptcp_recvmsg_mskq() then computes:

	u32 offset = (u32)(*seq) - MPTCP_SKB_CB(skb)->map_seq;

It copies X's stale payload to the application as current stream data.
The real data for that range is dropped as duplicate, yet it is still
DATA_ACKed.

I could not confirm that more than 2 GiB can be processed in a single
batch with real window dynamics and lock hold times. Still, nothing in
the code seems to prevent it.

Could __mptcp_ofo_queue() keep 64-bit arithmetic instead, for example by
comparing map_seq64 and map_seq64 + skb->len against msk->ack_seq? The
other option would be to enforce the claimed bound on the in-sequence
path.

>  
>  		p = rb_next(p);
>  		rb_erase(&skb->rbnode, &msk->out_of_order_queue);
>  
> -		if (unlikely(!after64(MPTCP_SKB_CB(skb)->end_seq,
> -				      msk->ack_seq))) {
> +		if (unlikely(!after(MPTCP_SKB_CB(skb)->end_seq, ack_seq))) {
>  			mptcp_drop(sk, skb);
>  			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
>  			continue;
>  		}
>  
> -		end_seq = MPTCP_SKB_CB(skb)->end_seq;
> +		seq_delta = MPTCP_SKB_CB(skb)->end_seq - ack_seq;
>  		tail = skb_peek_tail(&sk->sk_receive_queue);
>  		if (!tail || !mptcp_try_coalesce(sk, tail, skb)) {

[ ... ]

> -		msk->bytes_received += end_seq - msk->ack_seq;
> -		WRITE_ONCE(msk->ack_seq, end_seq);
> +		msk->bytes_received += seq_delta;
> +		WRITE_ONCE(msk->ack_seq, msk->ack_seq + seq_delta);
>  		moved = true;
>  	}
>  	return moved;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792718041.git.tanggeliang%40kylinos.cn
