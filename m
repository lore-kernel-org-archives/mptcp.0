Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793392975;
	b=QEA59nuGHDNa6+ZkoyNPZYxF2cR1x/G8sVQluEjR2tfmDP2hHDtohQj1UFCKDNmXEYy7
	 KN5PUpS7ecq4hAife1lQQ8AvOELt3LFnXkVYsPOU+ipCVn4qqKcDH1wHUqxVgjfBdb3sM
	 5yki+2xNMyrwTw3rDwDB7+7f237n4Byaxue+MaZQQndM1TYuH4Osse/Fa66LMYS8qXVE5
	 Lk1UDvx+tipDIyPLXbXghOUmPaiwiTOwLj2pW9TTx+lEtVlYdvuIAWQlMq1t5M8jvMswd
	 XqsWRRYavJ1rOPq08G1O31539YIiOBwaai9Gs4H9QlbLjwmUBMBX0cjE4Bbu8D7Wk0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793392975;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vPkLatQdw+wSnujGppZYG3gGAL9m1eMmBQQ7U81WU8A=;
	b=Ra9EPcs2ZIUil10cQdU8VPQHGrzxdB4Jlxv/hVXSWFQqbHRv5wlnARZUuDim1KT+tDpV
	 qHQTtrd98PXSnrNJIX1P7wyHsJJpGoRzXmTl40y9Zy6p+WDbxhcxEobbEjdFxGk2lDLnR
	 cyga/T42D+ao90Zy0enk2G4u6NF/NGaqykYLGygGKXoZPGsokRYwXzeoqYFSxJp0qsS+o
	 D/3WrvecUpnuZSm7GKLjzOBV/TJPCvUmECPEXTJf5BHHD8OJfWA+VYnBiLEHln92J4Ztb
	 tf4oaFTUSQPZ3rfF84mJOYyx2CM7mR5w2RBPVwTsFTnvDqFx0xJVWoXLe6pbf/3tsbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oY5vD8qb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC711606A31D
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 20:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oY5vD8qb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FD51F0093A;
	Fri, 30 Oct 2026 20:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793392974;
	bh=vPkLatQdw+wSnujGppZYG3gGAL9m1eMmBQQ7U81WU8A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oY5vD8qbl/oYVTyN0vrugVR0qGZzXR8sm0rg9tdsEvSceeAPjbpOqg3pzqc6HOcOJ
	 0LYtsew06gxJRskU03D2Wdn7TNHxK2cbi9U5SaqOvxeSAmlZ2Z/ShJfCd+N179dw8W
	 09O6QvrN1AnrScRvwmEl64wRD14VuqDWeF2FBQnj6innvWOTp5IpjePowigVjH2tw/
	 QZ0CpaU+N5DPjFTCAealgE7qeVVn0MWiuWtayztuAk/qu+562DuPylfvrcaufR9/b/
	 GWCgvioJcMOQCXbYUgGP6Zsw9ZIdrXlf47De2N3MM1lSHMF5lqH5PtI7wcCtD4CFLa
	 o+UF0A1DMUUtQ==
Subject:
 Re: [PATCH mptcp-next v16 3/4] mptcp: sync mptcp skb cb layout with tcp one
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, pabeni@redhat.com, kuba@kernel.org
Date: Fri, 30 Oct 2026 20:42:53 +0000
Message-ID: <179339297395.3132.968486542775672261@kernel.org>
In-Reply-To: =?utf-8?q?=3C147b74d32860b750a1b281ae5b25951067d499d7=2E1793255?=
 =?utf-8?q?126=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C147b74d32860b750a1b281ae5b25951067d499d7=2E17932551?=
 =?utf-8?q?26=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
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

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 2 · High: 1 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] mptcp: race and copied_seq reset in subflow_set_remote_key()
  on TFO
- [Critical] mptcp: mptcp_init_skb() subtracts offset from map_seq64
  corrupting data
- [High] mptcp: __mptcp_recvmsg_mskq() offset underflow on MSG_PEEK and
  skb leak
- [Medium] mptcp_inq_hint() (net/mptcp/protocol.c:2395-2410) over-reports
  how many bytes are queued.
- [Medium] mptcp_data_queue_ofo() can admit an skb whose 64-bit DSN is
  about 2^63 away from msk->ack_seq.
- [Medium] mptcp: mptcp_inq_hint() uses map_seq64 instead of
  msk->copied_seq
- [Low] Two statements in the commit message do not match the code.

--

mptcp: sync mptcp skb cb layout with tcp one

This commit stores the MPTCP-level sequence numbers in the skb cb as 32
bits, so that map_seq, end_seq and flags sit at the same offsets as the
matching tcp_skb_cb fields. A separate 64-bit map_seq64 is kept for checks
that need the full sequence space. The receive and OFO queue comparisons
move to the 32-bit before()/after() helpers, and build time checks are
added for the cb layout.

> The 32-bit sequence numbers are safe because all SKBs in the receive queue
> and OFO queue have been validated against the receive window (max INT_MAX),
> so their sequence numbers are guaranteed to be within 2^31 of the current
> ack_seq or copied_seq. This ensures that 32-bit arithmetic (comparisons
> and subtractions) produces correct results even when 64-bit values cross
> the 2^32 boundary, as the relative distance remains small.
>
> Add build time check to ensure the latter invariant.

[Severity: Low]
Does "the latter invariant" refer to the 32-bit distance guarantee in the
previous paragraph? The only build time checks added are the CHK_CB_FIELD()
offsetof()/offsetofend() comparisons in mptcp_proto_init(). Those check the
cb layout, not any sequence distance.

Is it also accurate that skbs in the receive queue have been validated
against the receive window? In __mptcp_move_skb(), both the in-sequence
branch and the partial packet branch reach insert: without looking at
msk->rcv_wnd_sent:

    if (MPTCP_SKB_CB(skb)->map_seq64 == msk->ack_seq) {
        /* in sequence */
insert:
    ...
    /* Partial packet */
    if (after64(MPTCP_SKB_CB(skb)->map_seq64 + skb->len, msk->ack_seq)) {
        ...
        goto insert;
    }

Only mptcp_data_queue_ofo() reads rcv_wnd_sent. For skbs in the receive
queue, the bound seems to come from them starting at or before ack_seq,
plus the skb length and rmem limits, not from a window check.

As noted below for mptcp_data_queue_ofo(), the window check also does not
bound the distance when rcv_wnd_sent lags ack_seq.

Could the commit message give the actual reason the truncation is safe?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f89ed94b668d9..bbce1bafa40ee 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -302,16 +304,21 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
>  {
>  	struct sock *sk = (struct sock *)msk;
>  	struct rb_node **p, *parent;
> -	u64 seq, end_seq, max_seq;
> +	u64 end_seq, max_seq;
>  	struct sk_buff *skb1;
> +	u32 seq;
>  
>  	seq = MPTCP_SKB_CB(skb)->map_seq;
> -	end_seq = MPTCP_SKB_CB(skb)->end_seq;
> +	end_seq = MPTCP_SKB_CB(skb)->map_seq64 + skb->len;
>  	max_seq = atomic64_read(&msk->rcv_wnd_sent);
>  

[ ... ]

> -	if (after64(end_seq, max_seq)) {
> +	/* Use the full sequence space to perform the admission checks, to
> +	 * protect vs possible wrap-arounds.
> +	 */
> +	if (after64(MPTCP_SKB_CB(skb)->map_seq64, max_seq) ||
> +	    after64(end_seq, max_seq)) {

[Severity: Medium]
Do these checks bound the distance from msk->ack_seq that the later 32-bit
comparisons depend on? They only compare against the upper edge,
rcv_wnd_sent, using modular 64-bit arithmetic.

rcv_wnd_sent can lag ack_seq:

  - subflow_set_remote_key() sets both to iasn.
  - __mptcp_move_skb() advances ack_seq for in-sequence data without
    checking rcv_wnd_sent.
  - rcv_wnd_sent only moves in mptcp_set_rwin() when a DSS ack is written.

Let A = ack_seq, W = rcv_wnd_sent and L = A - W > 0. Suppose the peer sends
a dsn64 mapping with data_seq = A + 2^63 - L/2 and len > L/2:

  subflow_check_data_avail()
    before64(ack_seq, old_ack) is false, mapping accepted
  __mptcp_move_skb()
    after64(map_seq64, ack_seq) is true -> mptcp_data_queue_ofo()
  mptcp_data_queue_ofo()
    map_seq64 - W = 2^63 + L/2, which is negative as s64, so after64()
    is false
    end_seq - W is also negative as s64, so after64() is false
    the skb is admitted to the OFO queue

The 32-bit values stored are map_seq = (u32)A - L/2 and
end_seq = (u32)A + len - L/2. Then in __mptcp_ofo_queue():

		if (after(MPTCP_SKB_CB(skb)->map_seq, ack_seq))
			break;
		...
		if (unlikely(!after(MPTCP_SKB_CB(skb)->end_seq, ack_seq))) {
		...
		seq_delta = MPTCP_SKB_CB(skb)->end_seq - ack_seq;

the skb appears to overlap ack_seq. It is queued to sk_receive_queue and
ack_seq advances by len - L/2. Readers then deliver this data at stream
position A, even though its DSN is about 2^63 away.

Before this patch, after64(map_seq, ack_seq) in __mptcp_ofo_queue() would
have stopped at this skb, so it was never delivered.

Would an explicit full-width distance check from ack_seq help here? For
example, rejecting skbs where map_seq64 - ack_seq exceeds the window or
INT_MAX, before relying on the truncated values.

[ ... ]

> @@ -2392,7 +2399,8 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
>  
>  	skb = skb_peek(&sk->sk_receive_queue);
>  	if (skb) {
> -		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
> +		u64 hint_val = READ_ONCE(msk->ack_seq) -
> +			       MPTCP_SKB_CB(skb)->map_seq64;

[Severity: Medium]
The head skb's map_seq64 is only written when the skb is queued, in
mptcp_init_skb(), mptcp_fastopen_subflow_synack_set_params() and
subflow_set_remote_key(). Nothing moves it forward as data is read or
skipped. So ack_seq - map_seq64 also counts bytes that userspace has
already consumed.

Besides the partial read case in __mptcp_recvmsg_mskq() and
__mptcp_read_sock(), the head skb can start before copied_seq without
any read at all:

  - __mptcp_move_skb() queues a partially overlapping skb through the
    partial packet branch with map_seq64 < ack_seq;
  - __mptcp_ofo_queue() does the same for an OFO skb whose map_seq is
    before ack_seq;
  - mptcp_init_skb() sets map_seq64 to the mapped DSN minus offset
    when the subflow skb has a non-zero offset.

In each case the skipped prefix is reported as unread through SIOCINQ
in mptcp_ioctl() and through the TCP_CM_INQ cmsg in mptcp_recvmsg().
Later in-order data can be coalesced into the head skb by
mptcp_try_coalesce(), up to sk_rcvbuf >> 3. That keeps the stale
map_seq64 at the head for longer, and the error can grow with each
partial read.

In mptcp_rcv_space_adjust(), copied -= mptcp_inq_hint(sk) subtracts
the inflated value. copied can then drop to or below rcvq_space.space,
or even go negative, and mptcp_rcvbuf_grow() is skipped while the
application is draining data.

Since copied_seq now tracks the first unread byte, would
READ_ONCE(msk->ack_seq) - msk->copied_seq be the right value here?

[Severity: Medium]
Can this over-report the amount of queued data after a partial read?

The previous patch in the series ("mptcp: remove CB offset field") removed
the MPTCP_SKB_CB(skb)->map_seq updates from __mptcp_recvmsg_mskq(),
__mptcp_read_sock(), __mptcp_move_skb() and __mptcp_ofo_queue(). Read
progress now lives in msk->copied_seq.

That commit message mentions "the new ack_seq - copied_seq hint", but the
hint here still subtracts the start sequence of the head skb.

After a partial read in __mptcp_recvmsg_mskq():

			msk->copied_seq += count;
			if (count < data_len)
				break;

the head skb stays in sk_receive_queue with its original map_seq64. For
example, with a single 1000-byte skb, after reading 100 bytes SIOCINQ and
TCP_CM_INQ report 1000 instead of 900.

If the head skb partially overlapped earlier data (queued with
map_seq64 < ack_seq), the overlapping bytes are counted as well.

mptcp_rcv_space_adjust() also does:

	copied -= mptcp_inq_hint(sk);

so rcvbuf autotuning is skewed too.

Should this be READ_ONCE(msk->ack_seq) - msk->copied_seq instead? The same
expression is still there at the end of the series.

[ ... ]

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -542,6 +542,7 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
>  		skb = skb_peek(&sk->sk_receive_queue);
>  		if (skb) {
>  			MPTCP_SKB_CB(skb)->map_seq = subflow->iasn - skb->len;
> +			MPTCP_SKB_CB(skb)->map_seq64 = subflow->iasn - skb->len;
>  			MPTCP_SKB_CB(skb)->end_seq = subflow->iasn;
>  			msk->copied_seq -= skb->len;
>  		}

[Severity: Critical]
With read progress now tracked only in msk->copied_seq, can this
rewrite discard data the application has already read?

On a passive MPTFO connection,
mptcp_fastopen_subflow_synack_set_params() queues the SYN data skb on
the msk receive queue with map_seq64 = -(u64)skb->len. It sets
copied_seq to the same value. The child can be accepted and read
before the third ACK carrying the peer key arrives.

Suppose the application first reads count < skb->len bytes.
__mptcp_recvmsg_mskq() moves copied_seq to -(u64)skb->len + count and
leaves the skb at the head of sk_receive_queue. When the key arrives,
subflow_set_remote_key() sets copied_seq to iasn and then subtracts
skb->len, so copied_seq equals the new map_seq64 again. The next read
returns those count bytes a second time, and bytes_consumed runs ahead
of bytes_received.

IASN is assumed to be 0 until the key is known. Would shifting the
existing copied_seq by iasn, instead of resetting it, preserve the
partial read?

There is also a locking question. check_fully_established() reaches
this function through __mptcp_subflow_fully_established() in softirq.
It holds only mptcp_data_lock() and does not check
sock_owned_by_user() on the msk. __mptcp_recvmsg_mskq() and
__mptcp_read_sock() walk sk_receive_queue under lock_sock() only.
mptcp_eat_recv_skb() unlinks and frees the head skb without the data
lock.

This allows two races:

  - If the reader eats the TFO skb right after the skb_peek() here,
    the map_seq, map_seq64 and end_seq writes land in a freed skb.
  - If the reader runs between msk->copied_seq += count and
    mptcp_eat_recv_skb() on a fully read skb, copied_seq is left
    skb->len behind ack_seq once the skb is unlinked. Every later skb
    then computes offset >= skb->len in __mptcp_recvmsg_mskq() and is
    skipped.

The skb_peek() and cb rewrite predate this patch, but the reliance on
copied_seq makes the race more damaging. When the msk is owned by the
user, should this adjustment be deferred, for example through a
cb_flags bit handled in mptcp_release_cb()?

[ ... ]

> @@ -422,11 +429,13 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset)
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
>  	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;
> +	MPTCP_SKB_CB(skb)->flags = 0;
>  	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
>  	MPTCP_SKB_CB(skb)->cant_coalesce = 0;
>  

[Severity: Critical]
Does subtracting offset here assign DSNs to bytes that the current DSS
mapping does not cover?

offset is tp->copied_seq - TCP_SKB_CB(skb)->seq on the subflow. The
mapping returned by mptcp_subflow_get_mapped_dsn() starts at
tp->copied_seq, so it only covers skb bytes [offset, skb->len). The
leading offset bytes belong to an earlier mapping.

For example, subflow_check_data_avail() can call
mptcp_subflow_discard_data() for an old mapping that ends in the
middle of the skb. get_mapping_status() then installs the next mapping
on the rest of the same skb. A partially overlapping TCP segment left
on the subflow queue has the same effect.

With map_seq64 = mapped_dsn - offset and end_seq = map_seq + skb->len,
the skb claims DSN [mapped_dsn - offset, mapped_dsn) for that prefix.
When mapped_dsn is at or before ack_seq, the prefix overlaps data that
was already received and is skipped.

The mapping can also be out of order at the msk level, because the
intervening DSNs travel on another subflow. In that case
__mptcp_move_skb() hands the skb to mptcp_data_queue_ofo() with the
shifted range, and then:

  - __mptcp_ofo_queue() moves it to sk_receive_queue once ack_seq
    reaches mapped_dsn - offset, and advances ack_seq over the prefix.
    The stale subflow bytes are delivered to userspace as stream data.
  - The real data for [mapped_dsn - offset, mapped_dsn) from the other
    subflow can be dropped as MPTCP_MIB_DUPDATA. This happens either in
    __mptcp_move_skb() or in the overlap handling in
    mptcp_data_queue_ofo().

The DSS checksum in validate_data_csum() also starts at offset, so the
prefix is never checked either.

The subtraction came with the removal of the cb offset field earlier in
the series. Here it is carried into map_seq64, which all the admission
checks now rely on. Could the prefix be trimmed from the skb before it
is moved to the msk? Or should map_seq64 stay at mapped_dsn, with the
skip recorded some other way?

[ ... ]

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -128,10 +128,13 @@
>  #define MPTCP_SYNC_SNDBUF	7
>  
>  struct mptcp_skb_cb {
> -	u64 map_seq;
> -	u64 end_seq;
> +	u32 map_seq;
> +	u32 end_seq;
> +	u32 unused;
> +	u16 flags;
>  	u8  has_rxtstamp;
>  	u8  cant_coalesce;
> +	u64 map_seq64;
>  };
>  
>  #define MPTCP_SKB_CB(__skb)	((struct mptcp_skb_cb *)&((__skb)->cb[0]))

[Severity: High]
Not part of this hunk, but __mptcp_recvmsg_mskq() now computes the read
position against this 32-bit field:

    offset = (u32)msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;

and skips the skb when offset >= skb->len. Does that still work for
MSG_PEEK?

With MSG_PEEK, copied_seq is not advanced while walking the queue. For
the second skb in sk_receive_queue, map_seq is after copied_seq, so the
u32 subtraction wraps to a value close to 2^32. The offset >= skb->len
check then fires. That skb and every following one are skipped before
any of the MSG_PEEK handling below is reached.

A peek can therefore never return more than the remainder of the head
skb. With MSG_PEEK | MSG_WAITALL, or with SO_RCVLOWAT larger than that
remainder, the caller can sleep in sk_wait_data() even though enough
data is queued.

Would it fix this to track a local u32 sequence instead? It would start
at msk->copied_seq, advance by the bytes each walked skb contributes,
and offset would be computed against it.

In the !MSG_PEEK case, an skb lying entirely before copied_seq is also
skipped with continue. It is left on sk_receive_queue, still charged to
sk_rmem_alloc. mptcp_recv_skb() calls mptcp_eat_recv_skb() in the same
situation. Should __mptcp_recvmsg_mskq() eat such skbs too? Otherwise
they stay at the head of the queue, and mptcp_inq_hint() keeps using
their map_seq64.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793255126.git.tanggeliang%40kylinos.cn
