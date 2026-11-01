Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793498531;
	b=MhAXeI3apWLM87F1G0h8QBWIYaMJRdoL67R26JOGje4LxXsu2c/uhWl7P20utCGNKRv+
	 Y7qIHi4govgsoLGtX/UkpOBnM5/bDPppiRdglRqIfo6aELChhvNHbF5SJAC783WyHHrOz
	 uZKQa4kRL6A+xoFlSW1Lo8b/QZuggNdmyQr8uG3zOxNXKmaNyK59UZtxHeZf9oB4ErIhs
	 3A9oAFIT89B0bBAoz5FTpiBtb4Q9ETQjSuSN8/urhQRK5peXyBzDV9HvXy0jSoH4htGTa
	 5NI4kwZws5MYGmzpNSOtm7IlQdFzuPKoCIJmz6fkeeW+BgyVQNVGsV6gsvhQzqeXi6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793498531;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=y35hMrMjrdIKr4K0mAMFZ+ESDcQMtmL/Wc0XRzRGy9k=;
	b=G978CHmT6PBFFrYwWjHekptsjb4g83npGY+GEWD9AyFgE0VspRj+AJkYUAEEvyc1ZdG5
	 R4q0WWtNhH6yAgGuufEFArhc7PYCNMyDm4BZeBXwMp1UP4rg5oAAu9heWIzML7uProaJ/
	 7/A9FWQtZNiQO9ys6G43ZeilZy1FJsH6+PFybEfkNUETnpu0r0/TEZgcs9rW6YHKEgXY8
	 Pdb0yamdS3/QBnidoo25JZ306GFOOfbkppfxAE4eQOzBjGzx19w7Ag0N8tK7hB4gPbcTf
	 Uw7RhdPu22rmwxjnsZ0d9+twoTeKsEhJ3DS+Dx8EJw3fm5pUGT/8QTtAQ307sd2Pq2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aRDG7KMA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D224D606A324
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 02:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aRDG7KMA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F371F000C1;
	Sun,  1 Nov 2026 02:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793498530;
	bh=y35hMrMjrdIKr4K0mAMFZ+ESDcQMtmL/Wc0XRzRGy9k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aRDG7KMAndf5OBwxOkHEpqsnqLAqbME+ZWkEo2E6SMD+IoDga93dnbPMB59t1ZYoo
	 PTHogwqTRjPAE1ElRBJT9b18ydt/skrDizIKp+9HczYt7TaWCnMGvgD1QW4Mz36Z8q
	 XWfNDGGOKdLJ5bH+QdxBze3gkpT2I7M4Ru/2zXl2f1Zf51mycODjjV8wLSJbbXMXWB
	 X0AKySTEk9ieLaVAyZNkY6mQQ+uzoAyjQ8/yQD2mvFsQQevd57IpPqMdj5pBjUsrU1
	 af5z7vwPImQ7IbqFiEZ8GJa1g64SqclRpizEE187jE+99zm7dIV0tSwmfmJzEwkTqC
	 8134fu/Y6JMeQ==
Subject:
 Re: [PATCH mptcp-next v19 4/5] mptcp: sync mptcp skb cb layout with tcp one
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, pabeni@redhat.com,
 kuba@kernel.org
Date: Sun, 01 Nov 2026 02:02:09 +0000
Message-ID: <179349852975.3128.9481015994334102975@kernel.org>
In-Reply-To: =?utf-8?q?=3C1c928472a89719130041c92cadd7e0fb6dbf552a=2E1793361?=
 =?utf-8?q?629=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C1c928472a89719130041c92cadd7e0fb6dbf552a=2E17933616?=
 =?utf-8?q?29=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
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

Critical: 1 · High: 0 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] mptcp: subtracting offset from map_seq64 in mptcp_init_skb()
  corrupts OFO data
- [Low] The commit message of "mptcp: sync mptcp skb cb layout with tcp
  one" gets its own safety argument wrong in two places.
- [Low] The commit says the new layout makes "fields with a corresponding
  TCP-level data use the same area inside the CB itself".

--

mptcp: sync mptcp skb cb layout with tcp one

This commit narrows the MPTCP skb CB sequence numbers to 32 bits, so that
map_seq, end_seq and flags sit at the same offsets as the matching fields
in struct tcp_skb_cb. A 64-bit map_seq64 copy is kept for the admission
checks. The receive and OFO queue paths now use 32-bit after()/before()
arithmetic, and BUILD_BUG_ON() checks on the CB offsets are added in
mptcp_proto_init().

> The 32-bit sequence numbers are safe because all SKBs in the receive queue
> and OFO queue have been validated against the receive window (max INT_MAX),
> so their sequence numbers are guaranteed to be within 2^31 of the current
> ack_seq or copied_seq. This ensures that 32-bit arithmetic (comparisons
> and subtractions) produces correct results even when 64-bit values cross
> the 2^32 boundary, as the relative distance remains small.
>
> Add build time check to ensure the latter invariant.

[Severity: Low]
Is the last sentence accurate? The only build time check added is
CHK_CB_FIELD() in mptcp_proto_init():

    CHK_CB_FIELD(map_seq, seq);
    CHK_CB_FIELD(end_seq, end_seq);
    CHK_CB_FIELD(flags, tcp_flags);

These compare offsetof()/offsetofend() of the mptcp_skb_cb fields against
struct tcp_skb_cb. That checks the CB layout. Nothing checks the 2^31
sequence distance from the previous paragraph, either at build time or at
run time.

The claim that all skbs in the receive queue were validated against the
receive window also doesn't seem to match __mptcp_move_skb(). In-sequence
and partial skbs go onto sk_receive_queue without any rcv_wnd_sent
comparison:

    if (MPTCP_SKB_CB(skb)->map_seq64 == msk->ack_seq) {
        /* in sequence */
    insert:
        if (!mptcp_try_rmem_schedule(sk, skb)) {
        ...
        __skb_queue_tail(&sk->sk_receive_queue, skb);

The rcv_wnd_sent check exists only in mptcp_data_queue_ofo(). For fallback
sockets, mptcp_can_ingest() also skips the rcvbuf bound on purpose:

    return likely(sk_rmem_alloc_get(sk) <= READ_ONCE(sk->sk_rcvbuf)) ||
           __mptcp_check_fallback(mptcp_sk(sk));

The message also leaves out functional changes that the 32-bit narrowing
appears to depend on:

  - the new after64(MPTCP_SKB_CB(skb)->map_seq64, max_seq) admission check
    in mptcp_data_queue_ofo()
  - clamping max_seq to ack_seq in mptcp_data_queue_ofo()
  - the new 64-bit contiguity check on map_seq64 in __mptcp_try_coalesce()

As far as I can tell the code itself is fine. OFO distances are bounded by
the TCP selected window, and the receive queue offset math only needs
distances below 2^32.

Could the commit message be updated to describe what actually guarantees
the invariant, and what the build time check covers?

[ ... ]

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

[Severity: Low]
The commit message says the new layout makes fields "with a corresponding
TCP-level data use the same area inside the CB itself". Is that true for
has_rxtstamp?

In struct tcp_skb_cb, has_rxtstamp is a 1-bit field in the byte at
offset 16:

    __u8        txstamp_ack:2,
                eor:1,
                has_rxtstamp:1,
                unused:4;

Offset 14 in struct tcp_skb_cb is sacked.

Here the u8 has_rxtstamp lands at offset 14, on top of TCP's sacked.
map_seq64 takes offsets 16-23, so it overlaps TCP's
txstamp_ack/eor/has_rxtstamp byte and ack_seq. On an msk-level skb,
TCP_SKB_CB(skb)->has_rxtstamp or ->eor would read bits from the low byte
of map_seq64.

CHK_CB_FIELD() in mptcp_proto_init() checks only map_seq, end_seq and
flags, so the build does not catch this.

Nothing reads those TCP fields on msk skbs today. That includes the
following patch, "mptcp: defer read_sock cleanup to mptcp_worker". The
TLS strparser helpers tls_strp_check_queue_ok() and tls_rx_msg_size() use
only TCP_SKB_CB(skb)->seq, and that field is aliased correctly.

Should the commit message say the layout is only partially synced? The
other option is to move has_rxtstamp to match TCP and add it to the
CHK_CB_FIELD() checks.

[ ... ]

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -421,11 +430,13 @@ static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset)
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
>  
>  	__skb_unlink(skb, &ssk->sk_receive_queue);

[Severity: Critical]
mptcp_init_skb() assigns DSNs to the whole skb starting at
mptcp_subflow_get_mapped_dsn(subflow) - offset. Here offset is
tp->copied_seq - TCP_SKB_CB(skb)->seq, as computed in
__mptcp_move_skbs_from_subflow(). Only the bytes [offset, skb->len)
belong to the DSS mapping that subflow_check_data_avail() validated
with validate_mapping() and, when checksums are enabled,
validate_data_csum().

The leading [0, offset) bytes are something else. They are either
data dropped by mptcp_subflow_discard_data() for an earlier mapping,
or the overlapping head of a TCP segment that tcp_data_queue() or
tcp_ofo_queue() queued with seq before copied_seq. They can come from
a different mapping. Nothing guarantees that their DSNs are
[mapped_dsn - offset, mapped_dsn), where mapped_dsn is the value
returned by mptcp_subflow_get_mapped_dsn().

When the mapping is in order at the msk level, msk->ack_seq is
already at or past mapped_dsn. The prefix is then skipped by the
partial packet branch in __mptcp_move_skb() and by the read offset in
__mptcp_recvmsg_mskq() and mptcp_recv_skb(). That no longer holds
when mapped_dsn is after msk->ack_seq:

  - If mapped_dsn - offset is at or before msk->ack_seq,
    __mptcp_move_skb() takes the in-sequence or partial packet
    branch. The skb is queued on (or coalesced into)
    sk_receive_queue, and msk->ack_seq moves across
    [msk->ack_seq, mapped_dsn), which was never received. recvmsg
    then returns the stale prefix bytes for that range.

  - Otherwise mptcp_data_queue_ofo() puts the skb in the OFO tree
    starting at mapped_dsn - offset. When the real data for
    [mapped_dsn - offset, mapped_dsn) arrives later on another
    subflow, it is dropped as MPTCP_MIB_DUPDATA. Also,
    __mptcp_try_coalesce() can append the prefix to a preceding OFO
    skb that ends at mapped_dsn - offset. __mptcp_ofo_queue() moves
    the skb to the receive queue once msk->ack_seq reaches
    mapped_dsn - offset.

In both cases user space silently gets corrupted stream data, and the
prefix never went through the DSS checksum. A peer can trigger this
by sending an out-of-order mapping on a subflow whose head skb has a
non-zero offset.

The subtraction is not new here: the old 64-bit map_seq was computed
the same way. This patch does rewrite these lines, though, and now
derives map_seq, end_seq and map_seq64 from the same shifted base.
Should the prefix be pulled off the skb before it lands in the msk
queues, at least when the mapping is ahead of msk->ack_seq? Or is
there something I am missing that rules out a non-zero offset in that
case?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793361629.git.tanggeliang%40kylinos.cn
