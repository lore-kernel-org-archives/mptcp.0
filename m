Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794955275;
	b=Aw9AtOfV5QYhPI04sOWva7p1+Yp7hr1OUNZLDnzZmiwPOPBmG0yvSE14X8n+JOpxOj3o
	 /k6aESwULn9kFvQ8aOMiLXOX+ufmhWs9al770rOjPn9FfXAc/GG75Bu3YQr1rJgPI+Ya0
	 rXiqmHZm/CXnjP023cI/ePX5G4rYI2uFxyViPKnfvlAKnyXQtI4jryre7FgRJHfn8dOQn
	 cY7NbBVmXtloJxr2mgJRSpB0D0p4rQot9WoRZI7kTJVp5fSlM6grbMICh6FCtsbgy/NQY
	 2CplsU18KHmDS6iRsXB0PnHboE6+t2Ubbsm8x2bMCu/X/iQkwRT5q5ReLOgvMwuTxXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955275;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sfIA2XsBs6WSiB53F35HZ3iluTxEmn0brrQyMizaVHI=;
	b=xHpQlTo5LsxTX6Lt3m7owFBJQuFmtbWewR5qDdn4ZPucPNylQ1ouJADbmCXYfhoDeUZk
	 BwIDjzG/Ve8bGyn7k9PxI4tSFob5YdpjsgEAj33sdfDEnNA1mBHR9aUCLJuH2EW5KaaTG
	 eBrK+WL+H5h0tWG//h7H1th3saObGVEQ+yBcJ7p+jRHy5ggYwc0JnCL+jXcwH/Ub+LqNS
	 4ktZRHBLj/xu6Oo9SqGY9GzFUX2itRtly0bF0RpvWYdUlPKeOrRvXV2ygRxYrVUbYPmiq
	 q9zIOisU2w2de0BJx4xD48C3KqHbH22ZZFznssUOJs0zd7vIS6EKoss4XX1lTi3XfOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iyR915MO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354B4606A31C
	for <mptcp@lists.linux.dev>; Tue, 17 Nov 2026 22:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iyR915MO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01921F000C4;
	Tue, 17 Nov 2026 22:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794955275;
	bh=sfIA2XsBs6WSiB53F35HZ3iluTxEmn0brrQyMizaVHI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iyR915MOgWSTrS/6d41ZxmqyPlY+pG2keZ/vSt2u6sduwwDLCqUpLaxqAE503K9iI
	 GXZ924LNhEiMkSG0M2vb9gv8IrrI+o1Jwm67e2kHu4sz3h+3rj3I9njrXQ4DVakwVZ
	 mCpC1Qa+77b4/1h+ql4tXzONnd/9sz3g65Un4cVWBfD0bsVjHpm+LIx+scbI0LFXUy
	 ZOr8Mr3mW7Keywein+UxPKEWzuQSJZVqkrS6YVnOSfEISOZx7Hy45qgjZWMOpw3OrN
	 jCJfKmGODumKl4IvGXs0D+66N2wrcOxRFGchak46R0TR3IQ2Av5NKyxL8EgIgaibN9
	 kbVhWYgUmzBBw==
Subject:
 Re: [PATCH mptcp-next v28 10/11] mptcp: sync mptcp skb cb layout with tcp one
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 17 Nov 2026 22:41:14 +0000
Message-ID: <179495527448.3133.11521292042768836769@kernel.org>
In-Reply-To: <af0a3423548713de827ea0597b8b637fde99e3b2.1794810809.git.tanggeliang@kylinos.cn>
References: <af0a3423548713de827ea0597b8b637fde99e3b2.1794810809.git.tanggeliang@kylinos.cn>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] mptcp: copied_seq offset underflow in recv path for OoO data
  after DATA_FIN
- [Low] This finding is about the commit message and design.
- [Low] struct mptcp_skb_cb in net/mptcp/protocol.h is now tied to struct
  tcp_skb_cb.

--

mptcp: sync mptcp skb cb layout with tcp one

This patch changes struct mptcp_skb_cb so that map_seq, end_seq and flags
sit at the same offsets as seq, end_seq and tcp_flags in struct
tcp_skb_cb. map_seq and end_seq shrink to 32 bits, and a new map_seq64
field holds the full DSN. Most receive path comparisons now use the
32-bit before()/after() helpers, and mptcp_proto_init() gains a build
time layout check.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 78ca580c6d9c5..50ae8cdec8a4a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -4904,11 +4906,23 @@ static int mptcp_napi_poll(struct napi_struct *napi, int budget)
>  	return work_done;
>  }
>  
> +#define CHK_CB_FIELD(mptcp_field, tcp_field)	\
> +	({					\
> +		BUILD_BUG_ON(offsetof(struct mptcp_skb_cb, mptcp_field) !=    \
> +			     offsetof(struct tcp_skb_cb, tcp_field));	      \
> +		BUILD_BUG_ON(offsetofend(struct mptcp_skb_cb, mptcp_field) != \
> +			     offsetofend(struct tcp_skb_cb, tcp_field));      \
> +	})
> +
>  void __init mptcp_proto_init(void)
>  {
>  	struct mptcp_delegated_action *delegated;
>  	int cpu;
>  
> +	CHK_CB_FIELD(map_seq, seq);
> +	CHK_CB_FIELD(end_seq, end_seq);
> +	CHK_CB_FIELD(flags, tcp_flags);
> +

[Severity: Low]
Which consumer needs struct mptcp_skb_cb to match struct tcp_skb_cb? The
commit message says what changes, but not why the layout has to follow
TCP's.

In net/mptcp/protocol.c, nothing reads an msk receive queue skb through
TCP_SKB_CB() after mptcp_init_skb() has run. The remaining TCP_SKB_CB()
users are __mptcp_move_skbs_from_subflow(), which works on subflow skbs
before mptcp_init_skb(), and the transmit path.

The last patch in the series ("mptcp: defer read_sock cleanup to
mptcp_worker") mentions an upcoming MPTCP TLS series. So the intended
user looks like the kTLS strparser, where tls_strp_check_queue_ok() reads
TCP_SKB_CB(skb)->seq.

Could the commit message say so? This change moves the receive path from
64-bit to 32-bit sequence arithmetic. It also keeps two copies of the DSN
(map_seq and map_seq64), which mptcp_init_skb(),
__mptcp_sync_rcv_sequence() and
mptcp_fastopen_subflow_synack_set_params() all have to keep in sync.

The commit message also says:

  Add a build time check to ensure the CB layout matches TCP's layout for
  the three shared fields: map_seq, end_seq, and flags.

Do these fields share anything beyond their offsets? In
__mptcp_move_skbs_from_subflow():

		len = skb->len - offset;
		...
			mptcp_init_skb(ssk, skb, offset, len);

and in mptcp_init_skb():

	MPTCP_SKB_CB(skb)->map_seq64 = mptcp_subflow_get_mapped_dsn(subflow) -
				       offset;
	MPTCP_SKB_CB(skb)->map_seq = (u32)MPTCP_SKB_CB(skb)->map_seq64;
	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + copy_len;

Here map_seq is the DSN of skb->data[0], while end_seq is
map_seq + skb->len - offset. For an skb with MPTCP_SKB_CB_F_OFFSET set,
TCP_SKB_CB(skb)->end_seq - TCP_SKB_CB(skb)->seq gives the copy length,
not skb->len as it would under TCP semantics.

The other fields don't line up either. has_rxtstamp sits on the byte
where tcp_skb_cb keeps sacked. map_seq64 overlaps TCP's has_rxtstamp
bitfield byte and ack_seq.

CHK_CB_FIELD() only compares offsetof() and offsetofend(), so it can't
catch any of these mismatches. A later patch might reuse TCP receive or
ofo helpers because of the advertised compatibility. Would such a patch
misread skbs that carry an offset?

Should end_seq follow TCP's seq + skb->len? If not, should it be
documented as not TCP compatible for offset skbs?

One smaller wording issue. The commit message says:

  __mptcp_try_coalesce() gains a map_seq64 contiguity check to ensure
  skbs are truly adjacent in the 64-bit DSN space.

The baseline already had this check, with map_seq as a u64:

	if (MPTCP_SKB_CB(from)->map_seq != mptcp_end_dsn(to) ||

So the patch only renames the field in the existing check.

Nothing breaks at runtime today, because every reader goes through
MPTCP_SKB_CB(), mptcp_dsn() and mptcp_end_dsn(). The last commit in the
series leaves all of this unchanged.

[ ... ]

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 0c7c58b51f61c..86634c04f499e 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -131,10 +131,12 @@
>  #define MPTCP_SKB_CB_F_OFFSET	(TCPHDR_FLAGS_MASK + 1)
>  
>  struct mptcp_skb_cb {
> -	u64 map_seq;
> -	u64 end_seq;
> +	u32 map_seq;
> +	u32 end_seq;
> +	u32 unused;
>  	u16 flags;
>  	u8  has_rxtstamp;
> +	u64 map_seq64;
>  };

[Severity: Low]
This isn't a bug, but could struct mptcp_skb_cb get a comment? It would
say that map_seq, end_seq and flags must keep the same offsets and sizes
as seq, end_seq and tcp_flags in struct tcp_skb_cb.

The new unused member exists only to pad over TCP's tcp_tw_isn /
tcp_gso_segs+tcp_gso_size union. The constraint is written down only in
the CHK_CB_FIELD() block in mptcp_proto_init().

Someone who reorders fields here, drops unused, or widens has_rxtstamp
would only find out from a BUILD_BUG_ON in net/mptcp/protocol.c. A short
comment on the struct and on unused, pointing at that check, would cover
it.

[ ... ]

> @@ -2231,7 +2233,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
>  	int copied = 0;
>  
>  	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
> -		u64 offset = *seq - MPTCP_SKB_CB(skb)->map_seq;
> +		u32 offset = (u32)(*seq) - MPTCP_SKB_CB(skb)->map_seq;
>  		u32 data_len = skb->len - offset;
>  		u32 count;
>  		int err;

[Severity: Medium]
The commit message says this u32 offset is safe because copied_seq
always falls inside or at the edge of the head skb. Does that still
hold once a DATA_FIN has been processed?

mptcp_check_data_fin() moves msk->ack_seq to rcv_data_fin_seq + 1 to
account for the DATA_FIN. msk->copied_seq stops at rcv_data_fin_seq,
because no payload byte goes with the FIN.

The check added earlier in the series, mptcp_seq_after_data_fin(),
only runs in __mptcp_move_skbs_from_subflow(). It only acts once
msk->rcv_data_fin or RCV_SHUTDOWN is already set.

A peer can send an out-of-order segment whose DSS mapping is at or
beyond the DATA_FIN sequence, before the DATA_FIN itself arrives. That
segment passes the check and waits in msk->out_of_order_queue or
msk->backlog_list. When the DATA_FIN later arrives, there are a few
ways this goes wrong.

If the queued segment covers rcv_data_fin_seq, __mptcp_ofo_queue()
moves msk->ack_seq past it before mptcp_pending_data_fin() runs. Then
ack_seq never equals rcv_data_fin_seq, and the DATA_FIN is never acted
on.

If the queued segment starts at rcv_data_fin_seq + 1 with no offset,
mptcp_check_data_fin() bumps ack_seq to that value first. Then
__mptcp_ofo_queue() or __mptcp_move_skb() treats the segment as in
sequence and moves it to sk->sk_receive_queue. Its map_seq is one past
msk->copied_seq.

__mptcp_recvmsg_mskq() and mptcp_recv_skb() then compute an offset of
0xffffffff. The skb looks fully consumed and is freed through
mptcp_eat_recv_skb(). Neither msk->bytes_consumed nor msk->copied_seq
is updated, so mptcp_data_avail() stays non-zero after EOF. SIOCINQ
through mptcp_inq_hint() reports unread data. __mptcp_close() also
sees unread data and resets the connection through
mptcp_do_fastclose() instead of closing cleanly.

If instead the skb carries MPTCP_SKB_CB_F_OFFSET, map_seq is at or
before rcv_data_fin_seq, and the computed offset is one byte short.
recvmsg copies the byte at the DATA_FIN sequence, which belongs to the
prefix mptcp_init_skb() meant to skip. bytes_consumed then gets ahead
of bytes_received, and mptcp_data_avail() underflows to U64_MAX.

All of this is reachable by a remote peer that only reorders its own
DSS mappings around the DATA_FIN.

What is the intended fix? One option is to apply the
mptcp_seq_after_data_fin() test again when skbs leave the ofo queue or
the backlog, in __mptcp_ofo_queue() and __mptcp_move_skb(). Another is
to purge anything at or after rcv_data_fin_seq when the DATA_FIN is
accepted. Either way, the safety argument for the 32-bit offset in
this patch depends on that invariant, so it should actually hold
before the receive path relies on it.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794810809.git.tanggeliang%40kylinos.cn
