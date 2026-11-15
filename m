Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794704607;
	b=O8mkcBmw147YZRZd0mAa8CAXVWsTNukzfyuwc3OdL7Nm+iHFMdzbnrI6qSHABlcJd8yp
	 5JfcIMgEJTvp8MQPxQzxjI6+5eUU0bm3P4mMpqRQNiDlCIqvLsn7fW/uxOCthu0cWjs6F
	 s118NgUQ1+Lap+rVJm8g0ZrCWqBa7CgOi5m9CqqpFK3EqXd94GEtrGp6Tawh8ZPA7rZc2
	 NNQRO2UgF2o8MTt87xCZYgAUh2ZzZzOBIL1JlJV8Om4sgDSM2iCjLorFNEfPn/EAa/IOX
	 LwnNv5zFS41vT94vNHnv8WCefuSWnLh+Mf3yQ570ctctIxNTYwZeuOwoxh65ckhqUdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794704607;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=qYUvLEsTh+zMQMafV7ZBwK8ERtClh8Povjm5n1ikVYA=;
	b=3XJTbVHH75/NoEJju+ZXgzw+/JtfL97tvOF1BmNFfMt6TJOfvSDhcJ8g7+7SqXy5EiI2
	 nypurcXfCWNzW/YMDYhPxJmCGNQJeHyh86HCM7YPY5E35GV71tYpWc9nuQPw7btrvOp4+
	 xuNVq7t6E++OekiyVG2W6fdUq5HhfQ1avAG1U+4R1WsemZIK2VaT6VseRG9JlGGJyLLON
	 +eC6h6V8vutaE9ljE9CGtOqpYwAAFYEzW2sGGaldpXUVcHW69GAZ7H7HwqHLDvWeSWNPg
	 3HgvvRPRn2xsjObcppshV//PD5hAcKiTJ4N42BbUPx1cELKlZE9wo3oNGi/hgMjpv9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VcxcnLsB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68869606A329
	for <mptcp@lists.linux.dev>; Sun, 15 Nov 2026 01:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VcxcnLsB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD32E1F000C6;
	Sun, 15 Nov 2026 01:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794704607;
	bh=qYUvLEsTh+zMQMafV7ZBwK8ERtClh8Povjm5n1ikVYA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VcxcnLsB8lbqGFvCBwSuwXu8WZddwK86UNBMCzAZXWzMvrM3ewBrBv8wBONogXLte
	 9H+PnpMx/JP+kB9/q+seKAz4bpPQqLV++hIjRof9rxSjgSoaCLBsHufo24eEu6LeiL
	 iORwijMzB1lS/AaF2t9tTO1Cx81nZtRQ1DEdlgQSSwK1VNv3oNtaqDCmiPkB6XktlK
	 3mvAtFQZKGsioTCQ0eWOG6muvpVme6zftr20IpPUJv2GL9LP19CJBv24U7Bo5zGX+d
	 yY9yXzesJ0/wv9ZQBbHRmhKrAR+gwHxby6MWVhhWqQ+aLspSgEAzk+hrOceNKVrFbE
	 ReUYrdoArNULg==
Subject:
 Re: [PATCH mptcp-next v26 7/8] mptcp: sync mptcp skb cb layout with tcp one
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sun, 15 Nov 2026 01:03:26 +0000
Message-ID: <179470460645.488855.7337103447859456088@kernel.org>
In-Reply-To: <328ddc33883506606aecad77f6645616df082740.1794563432.git.tanggeliang@kylinos.cn>
References: <328ddc33883506606aecad77f6645616df082740.1794563432.git.tanggeliang@kylinos.cn>
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 4 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Integer underflow in __mptcp_move_skb() (net/mptcp/protocol.c)
  corrupts msk->ack_seq and msk->bytes_received for skbs flagged…
- [High] mptcp: __mptcp_try_coalesce() overwrites target skb offset in
  end_seq
- [High] mptcp: rmem and fwdmem leak in __mptcp_move_skb() on
  rcv_data_fin drop
- [High] mptcp: mptcp_data_queue_ofo() uses map_seq instead of payload
  start dsn
- [Medium] mptcp: incomplete DATA_FIN sequence and state check in
  __mptcp_move_skb()
- [Low] The commit message calls map_seq, end_seq and flags the 'three
  shared fields' with TCP's tcp_skb_cb, and CHK_CB_FIELD() in…

--

mptcp: sync mptcp skb cb layout with tcp one

This commit shrinks map_seq and end_seq in struct mptcp_skb_cb to u32. It
adds a map_seq64 field carrying the full 64-bit DSN and aligns flags with
TCP's tcp_flags, with a build time check on the offsets. The receive path
now mostly uses 32-bit before()/after() comparisons, and map_seq64 is used
for the window, coalescing and DATA_FIN checks.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 99dfcd0488a45..d124b702c9576 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -427,10 +428,11 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
>  
>  	/* the skb map_seq accounts for the skb offset:
>  	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
> -	 * value
> +	 * value; note that end seq number is only available in 32bits format.
>  	 */
> -	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow) -
> -				     offset;
> +	MPTCP_SKB_CB(skb)->map_seq64 = mptcp_subflow_get_mapped_dsn(subflow) -
> +				       offset;
> +	MPTCP_SKB_CB(skb)->map_seq = (u32)MPTCP_SKB_CB(skb)->map_seq64;
>  	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + copy_len;
>  	MPTCP_SKB_CB(skb)->flags = offset ? MPTCP_SKB_CB_F_OFFSET : 0;
>  	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;

[ ... ]

>  static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
>  {
> -	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
> -	u64 dsn = MPTCP_SKB_CB(skb)->map_seq + skb->len - copy_len;
> +	u32 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
> +	u64 dsn = MPTCP_SKB_CB(skb)->map_seq64 + skb->len - copy_len;
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  	struct sk_buff *tail;

[Severity: High]
When the target skb was initialized with a non-zero offset, doesn't
this lose the offset that mptcp_init_skb() encoded into it?

mptcp_init_skb() stores the subflow offset implicitly: map_seq64 is
mapped_dsn - offset, and end_seq is map_seq + skb->len - offset.
__mptcp_move_skb() and __mptcp_ofo_queue() recover the offset as
skb->len - (end_seq - map_seq). The check above only refuses a from
skb carrying MPTCP_SKB_CB_F_OFFSET. A to skb with the flag set is
still a valid coalescing target.

In such a pair, from has no offset and starts at
to->map_seq64 + to->len, so its end_seq is
to->map_seq + to->len + from->len. Copying that into to->end_seq
makes end_seq - map_seq equal to the new to->len, so the recovered
offset becomes zero. Both consumers then compute:

    dsn = map_seq64 + skb->len - (end_seq - map_seq) = map_seq64

That is offset bytes before the first valid byte of the skb.

In __mptcp_ofo_queue(), after((u32)dsn, ack_seq) can then be false
while the real start is still beyond ack_seq. The skb is dequeued
across a range that was never received, and seq_delta covers the whole
skb. The offset prefix bytes, which the subflow had already consumed
or discarded, are queued to sk_receive_queue as stream data at
[dsn - offset, dsn). Backlog skbs coalesced this way have the same
problem in __mptcp_move_skb(). There, both the in-sequence test and
copy_len are derived from end_seq - map_seq.

The peer controls the mappings and segment boundaries. It can make an
offset skb land in the backlog or at the OFO tail, and then have the
next contiguous skb coalesce into it.

The end_seq assignment predates this patch, but this patch reworks the
coalescing condition anyway. Should this be:

    MPTCP_SKB_CB(to)->end_seq += from->len;

so the offset of to is preserved? Or should coalescing into a to skb
that has MPTCP_SKB_CB_F_OFFSET be refused as well?

[ ... ]

> @@ -505,8 +508,8 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
>  	}
>  
>  	/* Partial packet */
> -	if (after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
> -		copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
> +	if (after64(MPTCP_SKB_CB(skb)->map_seq64 + skb->len, msk->ack_seq)) {
> +		copy_len = MPTCP_SKB_CB(skb)->end_seq - (u32)msk->ack_seq;
>  		goto insert;
>  	}

[Severity: High]
Can copy_len underflow here for skbs flagged MPTCP_SKB_CB_F_OFFSET?

The guard now checks the real end of the skb (map_seq64 + skb->len), but
copy_len is still computed from end_seq. In mptcp_init_skb(), map_seq64 is
mapped_dsn - offset. The copy_len passed in by
__mptcp_move_skbs_from_subflow() is skb->len - offset. So end_seq ends up
as:

    end_seq = map_seq + skb->len - offset

That is offset bytes short of the real end. If msk->ack_seq falls between
end_seq and map_seq64 + skb->len, the guard is true but end_seq is below
ack_seq. The u32 subtraction then wraps to roughly 4G.

Here is one way to reach this. While the msk is owned by user space, two
subflows queue skbs to the backlog through this path:

mptcp_data_ready()
  __mptcp_move_skbs_from_subflow(own_msk=false)
    __mptcp_add_backlog()

The two skbs are:

  skb A (subflow 1): DSN [X, X+1100)
  skb B (subflow 2): map [X-200, X+1200), len 1400

For B, subflow_check_data_avail() sees mapped DSN X-200 < ack_seq X, and
mptcp_subflow_discard_data() moves copied_seq 200 bytes into B. That gives
offset = 200, map_seq64 = X-200 and end_seq = X+1000. A and B don't
coalesce in the backlog because their skb->sk differs.

When __mptcp_move_skbs() spools the backlog, A moves ack_seq to X+1100.
For B, dsn = X < ack_seq and after64(X+1200, X+1100) is true, so:

    copy_len = (X+1000) - (X+1100) = 0xFFFFFF9C

Then at the insert label:

    msk->bytes_received += copy_len;
    WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);

This moves ack_seq about 2^32 forward in the 64-bit DSN space.

After that, subflow_check_data_avail() would see every new mapping as
before ack_seq and discard it as duplicate data. DATA_ACKs would carry a
bogus value and the DATA_FIN match would never succeed. mptcp_data_avail()
would also report about 4G bytes that don't exist. The connection would
stall.

Before this patch the guard and the subtraction both used the u64 end_seq,
so B was dropped as old data instead.

The peer controls whether DSN ranges overlap across subflows. Ordinary
reinjection can also produce this.

This code appears unchanged at the end of the series ("mptcp: defer
read_sock cleanup to mptcp_worker").

Would it avoid the wrap to compute copy_len the same way __mptcp_ofo_queue()
computes seq_delta?

    copy_len = MPTCP_SKB_CB(skb)->map_seq64 + skb->len - msk->ack_seq;

[ ... ]

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index e195993f7aec6..90d67c170e7aa 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -131,10 +131,12 @@
>  #define MPTCP_SKB_CB_F_OFFSET	0x0100
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
This isn't a bug today, but the commit message says:

  Add a build time check to ensure the CB layout matches TCP's layout for
  the three shared fields: map_seq, end_seq, and flags.

CHK_CB_FIELD() in mptcp_proto_init() only checks offsets and sizes. Does
end_seq actually have the same meaning as in TCP?

TCP's end_seq is seq + len (plus SYN/FIN). mptcp_init_skb() sets end_seq
to map_seq + skb->len - offset, so for MPTCP_SKB_CB_F_OFFSET skbs it is
not the real end. That mismatch is what leads to the copy_len underflow in
__mptcp_move_skb() above.

Other overlapping fields don't line up either:

  has_rxtstamp (u8 at offset 14) sits on tcp_skb_cb's sacked.

  TCP's has_rxtstamp bit at offset 16 overlaps the low byte of map_seq64.

  unused at offset 8 overlaps tcp_tw_isn/tcp_gso_segs and is never
  initialized.

No in-tree code reads TCP_SKB_CB() on msk-level receive queue skbs, so
this has no runtime effect today. The last patch in the series mentions an
upcoming MPTCP TLS series.

Could the commit message say which code needs TCP-compatible access to
these skbs, and whether matching only the offsets is enough for it?

[ ... ]

> @@ -455,19 +457,20 @@ void __mptcp_sync_rcv_sequence(struct sock *sk)
>  	if (!skb)
>  		return;
>  
> -	MPTCP_SKB_CB(skb)->map_seq = msk->tfo_iasn - skb->len;
> +	MPTCP_SKB_CB(skb)->map_seq64 = msk->tfo_iasn - skb->len;
> +	MPTCP_SKB_CB(skb)->map_seq = (u32)MPTCP_SKB_CB(skb)->map_seq64;
>  	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;
>  }
>  
>  static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
>  {
> -	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
> -	u64 dsn = MPTCP_SKB_CB(skb)->map_seq + skb->len - copy_len;
> +	u32 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;
> +	u64 dsn = MPTCP_SKB_CB(skb)->map_seq64 + skb->len - copy_len;
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  	struct sk_buff *tail;
>  
>  	if (READ_ONCE(msk->rcv_data_fin) &&
> -	    !before64(MPTCP_SKB_CB(skb)->map_seq,
> +	    !before64(MPTCP_SKB_CB(skb)->map_seq64,
>  		      READ_ONCE(msk->rcv_data_fin_seq))) {
>  		mptcp_drop(sk, skb);
>  		return false;

[Severity: High]
Can this drop leak memory? Every caller of __mptcp_move_skb() has
already run mptcp_subflow_lend_fwdmem() on the skb. That clears
skb->destructor but leaves skb->sk pointing at the subflow and
skb->truesize charged to ssk->sk_rmem_alloc. mptcp_borrow_fwdmem()
is what moves that charge to the msk, and mptcp_drop() relies on it
having run. Its comment says the forward memory was already
transferred, and with no destructor __kfree_skb() uncharges nothing.

Here the DATA_FIN check calls mptcp_drop() before
mptcp_borrow_fwdmem(). skb->truesize then stays in
ssk->sk_rmem_alloc for good, and the lent forward memory never reaches
sk->sk_forward_alloc. inet_sock_destruct() will warn about the
non-zero sk_rmem_alloc when the subflow is destroyed.

The peer can trigger this by sending data at or beyond the DATA_FIN
sequence while rcv_data_fin is still set, for example by leaving a
hole before the DATA_FIN. Every such segment grows the leaked charge.
Over time that can make the subflow believe its receive buffer is
full.

This patch doesn't introduce the ordering, but it does rework this
check. Could mptcp_borrow_fwdmem() be moved above the DATA_FIN test?
Then every mptcp_drop() in this function would see an skb whose
memory was already handed over to the msk.

[Severity: Medium]
Is this DATA_FIN check still complete after switching to map_seq64?
Two cases look like they get through.

First, map_seq64 is the start of the skb, not its end. For skbs with
MPTCP_SKB_CB_F_OFFSET, it is also offset bytes before the first valid
byte. A segment that starts before rcv_data_fin_seq and extends past
it passes the check. So does an offset skb whose real dsn is at or
after rcv_data_fin_seq but whose map_seq64 is dsn - offset. Once
queued, such an skb moves msk->ack_seq past rcv_data_fin_seq.
mptcp_pending_data_fin() only fires when ack_seq == rcv_data_fin_seq,
so the DATA_FIN is never acted on and the msk never reaches
RCV_SHUTDOWN.

Second, the check is gated on msk->rcv_data_fin.
mptcp_check_data_fin() clears that flag after setting RCV_SHUTDOWN and
moving ack_seq to rcv_data_fin_seq + 1. A segment the peer sends at
rcv_data_fin_seq + 1 after that matches dsn == ack_seq and is queued
to sk_receive_queue. copied_seq stays at rcv_data_fin_seq, so in
__mptcp_recvmsg_mskq() the offset (u32)(*seq) - map_seq wraps to
0xffffffff. The skb is skipped and never eaten, and it stays charged
to the msk receive memory until close. bytes_received is also bumped
for data the application can never read.

Neither case is new with this patch, but this comparison is being
changed anyway. Should it test the end of the data, map_seq64 +
skb->len, against rcv_data_fin_seq? Should data also be dropped here
once RCV_SHUTDOWN is set? And for a segment that straddles
rcv_data_fin_seq, is the intent to trim it or to drop it?

[ ... ]

> @@ -303,14 +303,15 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
>  {
>  	struct sock *sk = (struct sock *)msk;
>  	struct rb_node **p, *parent;
> -	u64 seq, end_seq, max_seq;
> +	u64 end_seq, max_seq;
>  	struct sk_buff *skb1;
> +	u32 seq;
>  
>  	seq = MPTCP_SKB_CB(skb)->map_seq;
> -	end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;
> +	end_seq = MPTCP_SKB_CB(skb)->map_seq64 + skb->len;
>  	max_seq = atomic64_read(&msk->rcv_wnd_sent);
>  
> -	pr_debug("msk=%p seq=%llx limit=%llx empty=%d\n", msk, seq, max_seq,
> +	pr_debug("msk=%p seq=%x limit=%llx empty=%d\n", msk, seq, max_seq,
>  		 RB_EMPTY_ROOT(&msk->out_of_order_queue));
>  	if (after64(end_seq, max_seq)) {
>  		/* out of window */

[Severity: High]
Should the OFO queue be ordered on map_seq here?

For skbs with MPTCP_SKB_CB_F_OFFSET, map_seq is dsn - offset. The
range [map_seq, map_seq + skb->len) therefore includes the subflow
prefix, which was already consumed or discarded and isn't valid data
at that DSN. __mptcp_move_skb() sends the skb here based on the real
dsn, and __mptcp_ofo_queue() only dequeues it once ack_seq reaches
that real dsn. mptcp_data_queue_ofo(), however, orders and
deduplicates on the range starting at map_seq.

That makes the prefix look like data that is present. Suppose skb1 in
the OFO queue has an offset, and a valid segment covering
[dsn1 - offset1, dsn1) arrives later. The walk sees seq inside skb1
and end_seq not after skb1's end, so it drops the new segment as
MPTCP_MIB_DUPDATA. The subflow has already acked those bytes at the
TCP level, so ack_seq can't reach dsn1 and __mptcp_ofo_queue() never
releases skb1. A reinjected copy is dropped the same way, and the
connection can stall.

The reverse case also happens. An incoming offset skb whose range
covers existing nodes in [dsn - offset, dsn) replaces them through
rb_replace_node(), or removes them in the merge_right loop. That
discards the only valid copy of that data.

seq was map_seq before this patch as well, but this hunk retypes it
and switches end_seq to map_seq64 anyway. Would it be better to start
the range at the dsn that __mptcp_move_skb() already computed? Or to
trim the offset from the skb before it is queued, so that map_seq
matches its first valid byte?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794563432.git.tanggeliang%40kylinos.cn
