Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353543;
	b=DTDkhh5olWmFOwLtmVmIBUhKlSYhNFzxYobs1rxSXPB+6fFqymdfmOrow9BQzbRahU/O
	 VAYFUa1s4ts+EPL9kwlksLmEoAWyQ9P9aHmixDxxACmDE6OlyUnXavWGwxem9RmGSjjJK
	 80tOw0L1QFNJf2beSxfUgLv6SnUlEZFlkgTHHdf/liFIMXhOl/KP6qw+2s7ps5UKhNMsV
	 aIWmN5dg4nbCVpaMmdIVL8ybNYnfmwo225IUBbijbl2/4yHnUl+jXx5wfVezhQ50iMkFj
	 riX/l7FKMRR8zOFgoOOxPCAt1y5f/OPHugXbjUM9xuX37E2n8NPwzQl5fYxuZzAYbXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353543;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=scBfcB6719HJ0OZTcsR5Y4mGTXa2aA4tyJpPPXKxfWs=;
	b=iK/hJiAggwy+kcA2Ytnx46xLoPXNEO9H2vfJKGjqfxh7l7oesSzwcKty73hjB9tWF3pk
	 7yV9F079Opo/7SQ4tszoQyuMDBaNAcOfXGkfo0rDWp5rUnX2eABsm71n/kPpzeRs2/hfd
	 Ap3k4RGpoDgQdtt7WvXPif5USgriwx/9OiT10enzCssdYFOfxf7AAIFyQ1Cn9T1UbKQYV
	 2oLujTg6/xobjio7f1h2VKKSsuqEZSKvTZaJuS9KPPTJ1DJfzOu5pmWs2c9pQcmTmHc3Z
	 et3mhZjttId2B/MQtspMsGo2l2MgE4g+N0F2N3CDxT3Sb2u3CS20cSNuoeuTwxkEkUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GX7xrzi4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9688A606A325
	for <mptcp@lists.linux.dev>; Tue, 10 Nov 2026 23:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GX7xrzi4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5D21F0093C;
	Tue, 10 Nov 2026 23:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794353543;
	bh=scBfcB6719HJ0OZTcsR5Y4mGTXa2aA4tyJpPPXKxfWs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GX7xrzi4Lvq2N7oeTywtOzqLxGDIulSR4vIRXN1mMkWC7bbKr+mg/35GD0Q++QwBF
	 lTogIEuTvQuj3jzEozVxQve1NATxKbB7Kcf7rJNDO1knf3F8gS4Q1WkNLlwpHhJVOf
	 rt13DSzUXg0oKIqfw9nUdN+AXWfXwtqxA/W4dUlRw/FzMfxvLeIXSsmruQYY01BplU
	 10WTRaxqlRI6Q2m7Xs4sGLzKlvIItwUjZKznXnE9WkCm9zNYPPQ0Vq72EPfqWCo/yC
	 lf9h+HQUnbw1mK7pEo9ONCIC0P8sdEctwD9uJVEYmFG91+LDPnVyEypKcWYEl/vSpt
	 y0IlDP7aZGMVg==
Subject: Re: [PATCH mptcp-next v24 6/8] mptcp: remove CB offset field
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 10 Nov 2026 23:32:22 +0000
Message-ID: <179435354289.488855.15751733174603885935@kernel.org>
In-Reply-To: <8b30d5f811cfc37189badb3f7c86f565059063e4.1794215614.git.tanggeliang@kylinos.cn>
References: <8b30d5f811cfc37189badb3f7c86f565059063e4.1794215614.git.tanggeliang@kylinos.cn>
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The F_OFFSET guard does not fully protect validated data from an
  unvalidated prefix.
- [High] The orphan/re-own sequence in mptcp_init_skb() unbalances
  subflow forward-alloc accounting.
- [Medium] When offset > skb_headlen(skb), mptcp_init_skb() orphans the
  skb, calls pskb_pull(skb, offset), and then sets skb->truesize =…
- [Medium] msk->copied_seq counts only bytes copied to user space and
  never takes the DATA_FIN sequence slot.
- [Low] To drop a prefix that ends in the paged area, mptcp_init_skb()
  calls pskb_pull(skb, offset).

--

mptcp: remove CB offset field

This patch replaces the per-skb CB offset field with a new msk-level
copied_seq, which tracks bytes copied to user space the way TCP does.
mptcp_init_skb() now rewinds map_seq by the already consumed offset and
marks such skbs with MPTCP_SKB_CB_F_OFFSET. When the skb spans a DSS
mapping boundary, it trims the prefix instead.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ce0f9c2e6fd1a..30933dd9f0b1d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -375,6 +375,11 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
>  				 *  |     skb1    |
>  				 * continue traversing
>  				 */
> +			} else if (MPTCP_SKB_CB(skb)->flags &
> +				   MPTCP_SKB_CB_F_OFFSET) {
> +				/* skb covers skb1 but has an unvalidated
> +				 * prefix; keep skb1, continue traversing.
> +				 */

[Severity: High]
Is validated data still protected from the unvalidated prefix on the
other paths through mptcp_data_queue_ofo()?

mptcp_init_skb() now rewinds map_seq by offset. A TCP partial-overlap
retransmission S therefore also claims the prefix
[TCP_SKB_CB(skb)->seq, tp->copied_seq) in DSN space.
validate_data_csum() never checksums those bytes, because it starts at:

    seq = tcp_sk(ssk)->copied_seq + subflow->map_csum_len;

This branch only skips the equal-seq rb_replace_node(). After it, the
traversal goes right and S is inserted. The merge_right loop then drops
any later entry covered by S, and it does not check the flag:

merge_right:
	while ((skb1 = skb_rb_next(skb)) != NULL) {
		if (before64(end_seq, MPTCP_SKB_CB(skb1)->end_seq))
			break;
		rb_erase(&skb1->rbnode, &msk->out_of_order_queue);
		mptcp_drop(sk, skb1);

Here is an example. A1 [d, d+m) and A2 [d+m, d+a) come from the same
mapping. The (limit >> 3) check leaves them uncoalesced, which is easy
to hit with 64KB GRO skbs and the default rcvbuf. S covers [d, d+a+n)
and has F_OFFSET set:

mptcp_data_queue_ofo(S)
  takes the F_OFFSET branch at A1, goes right
  goes left of A2, inserts S
  merge_right: skb_rb_next(S) == A2, drops the validated A2

__mptcp_ofo_queue() then queues A1 and S without coalescing. recvmsg
reads DSN [d+m, d+a) from S's unvalidated prefix. The same thing
happens when S is inserted to the left of skb1 (seq before skb1's
map_seq).

The in-sequence path in __mptcp_move_skb() also ignores the flag:

	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {

__mptcp_move_skbs() runs __mptcp_move_skb() on every backlog skb before
it calls __mptcp_ofo_queue(). So ack_seq can reach S's rewound map_seq
while an earlier copy is still in the OFO queue. A2 being dropped under
rmem pressure, followed by S taking the partial path, has the same
effect.

Before this patch, S's map_seq started at the first new byte, so the
prefix was never delivered. The commit message says previously
validated data "is not overwritten by an unvalidated prefix".

With DSS checksums enabled, could a middlebox that rewrites only the
overlapping part of a retransmission go undetected here? Would it work
better to trim the prefix, or to stop F_OFFSET skbs from covering
existing data on every path?

The later commit "mptcp: sync mptcp skb cb layout with tcp one" keeps
the same logic.

>  			} else {
>  				/* skb's seq == skb1's seq and skb covers skb1.
>  				 * Replace skb1 with skb.

[ ... ]

> @@ -415,25 +420,54 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
>  	skb_set_owner_r(skb, sk);
>  }
>  
> -static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
> -			   int copy_len)
> +static bool mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset)
>  {
>  	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
>  	bool has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
>  
> +	/* Detect mapping boundary: skb spans multiple mappings */
> +	if (unlikely(offset > 0 &&
> +		     before(TCP_SKB_CB(skb)->seq - subflow->ssn_offset,
> +			    subflow->map_subflow_seq))) {
> +		if (offset >= skb->len) {
> +			sk_eat_skb(ssk, skb);
> +			return false;
> +		}
> +
> +		if (offset > skb_headlen(skb)) {
> +			skb_orphan(skb);
> +			if (!pskb_pull(skb, offset)) {
> +				sk_eat_skb(ssk, skb);
> +				return false;
> +			}

[Severity: Low]
Is pskb_pull() the right tool for discarding a prefix that ends in the
paged area?

pskb_pull() goes through __pskb_pull_tail(skb, offset - headlen). That
can call pskb_expand_head(skb, 0, eat + 128, GFP_ATOMIC) and then copy
every prefix byte into the new head with skb_copy_bits(). __skb_pull()
then throws those bytes away.

For a large GRO skb, this is a high-order GFP_ATOMIC allocation in
softirq context, made only to hold data that is never read. The dead
bytes also stay in the enlarged head until the skb is freed.

__pskb_pull_tail() also fails for unreadable (devmem) frags. On any
failure, sk_eat_skb() drops the whole skb, including valid bytes after
the prefix that TCP has already acked. Recovery then depends on
MPTCP-level retransmission.

Would a frag-trimming head trim like __pskb_trim_head(), which needs
no allocation and copies nothing, fit better here?

> +			skb->truesize = SKB_TRUESIZE(skb_end_offset(skb)) +
> +					skb->data_len;

[Severity: Medium]
Does this truesize computation under-account the remaining frags?

This branch only runs when the prefix reaches into the paged area, so
page frags or frag_list members usually remain after the pull.
skb->data_len counts only their payload, not the memory they pin. Some
examples: 2-4KB buffers holding about 1.5KB, high-order GRO pages, and
the sk_buff and head overhead of each frag_list member.

skb_condense() rebuilds truesize from the head size only after all
frags are gone, because fragments do not record their own truesize:

	skb->truesize = SKB_TRUESIZE(skb_end_offset(skb));

The commit message says:

    To avoid truesize corruption in pskb_expand_head(), we first orphan
    the skb to disconnect it from the socket, perform the pull,
    recompute truesize manually, then reattach with skb_set_owner_r().
    This ensures proper memory accounting.

Is that accurate? pskb_expand_head() only changes truesize for
orphaned skbs:

	if (!skb->sk || skb->destructor == sock_edemux)
		skb->truesize += size - osize;

An owned skb would keep its truesize, and the charge/uncharge pair
would stay balanced. The orphan seems to be what makes truesize change
in the first place.

The understated truesize then feeds skb_set_owner_r(ssk), lend/borrow,
backlog_len, the msk rmem/rcvbuf checks, the protocol memory_allocated
counter and memcg. A remote peer can reach this path: it sends a
segment, then an overlapping retransmission whose new DSS mapping
starts at the old end.

> +			skb_set_owner_r(skb, ssk);

[Severity: High]
Can this orphan and re-own sequence drive ssk->sk_forward_alloc
negative?

The skb is in the TCP receive queue with sock_rfree as its destructor.
TCP already scheduled its truesize T_old:

mptcp_init_skb()
  skb_orphan(skb)
    sock_rfree()
      sk_mem_uncharge(ssk, T_old)
        sk_mem_reclaim()   <- returns whole pages of ssk forward alloc
  pskb_pull()
  skb_set_owner_r(skb, ssk)
    sk_mem_charge(ssk, T_new)   <- only sk_forward_alloc_add(sk, -size)

Nothing calls sk_rmem_schedule() for T_new, so ssk->sk_forward_alloc
ends up around -T_new. mptcp_subflow_lend_fwdmem() and
mptcp_borrow_fwdmem() then credit T_new to the msk forward alloc. The
protocol counter no longer covers that memory, and the msk later
reclaims and uncharges those pages a second time.

The peer can close the subflow right away, with a FIN or RST after the
crafted segment. The ssk is then destroyed with a negative forward
alloc, which trips this check in inet_sock_destruct():

	WARN_ON_ONCE(sk->sk_forward_alloc);

It also leaves tcp_memory_allocated and the memcg socket counters
permanently too low. The peer can repeat this across connections.

Since pskb_expand_head() leaves truesize alone for owned skbs, is the
orphan needed at all? The later commits in the series keep this code
unchanged.

> +		} else {
> +			if (!skb_pull(skb, offset)) {
> +				sk_eat_skb(ssk, skb);
> +				return false;
> +			}
> +		}
> +		offset = 0;
> +	}

[ ... ]

> @@ -2207,33 +2240,24 @@ static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
>  }
>  
>  static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
> -				size_t len, int flags, int copied_total,
> +				size_t len, int flags, u64 *seq,
>  				struct scm_timestamping_internal *tss,
>  				int *cmsg_flags, struct sk_buff **last)
>  {
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  	struct sk_buff *skb, *tmp;
> -	int total_data_len = 0;
>  	int copied = 0;
>  
>  	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
> -		u32 delta, offset = MPTCP_SKB_CB(skb)->offset;
> +		u64 offset = *seq - MPTCP_SKB_CB(skb)->map_seq;

[Severity: Medium]
What keeps msk->copied_seq in the same DSN space as map_seq once a
DATA_FIN has been processed?

copied_seq only advances by the bytes copied to user space, but
mptcp_check_data_fin() also consumes a sequence slot:

		WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);

The old code anchored the per-skb offset and map_seq to ack_seq in the
partial-packet and OFO paths, and this patch removes that. Data at or
past rcv_data_fin_seq is not rejected by __mptcp_move_skb(), by
__mptcp_add_backlog(), or on the subflow path.

Suppose a peer sends a mapping that covers the DATA_FIN slot.
subflow_check_data_avail() discards the bytes below ack_seq through
mptcp_subflow_discard_data(). mptcp_init_skb() then rewinds map_seq to
fin_seq - k and sets F_OFFSET. After that:

__mptcp_move_skb()
  partial path: copy_len = end_seq - ack_seq   (bytes_received += len - k - 1)
__mptcp_recvmsg_mskq()
  offset = copied_seq - map_seq = k            (bytes_consumed += len - k)

bytes_consumed now exceeds bytes_received by 1, so the u64
mptcp_data_avail() underflows. The effects:

- mptcp_inq_hint() reports INT_MAX.
- mptcp_epollin_ready() is always true.
- mptcp_close() sees unread data and does a fastclose.
- The byte at the FIN slot reaches the application.

Now suppose the data instead has map_seq == fin_seq + 1 == ack_seq. It
is queued in sequence, and offset here becomes (u64)-1. The skb is
skipped as already peeked and never freed, so it stays charged in
sk_receive_queue until close. On the read_sock/splice path,
mptcp_recv_skb() silently eats it instead.

Only a misbehaving peer that sends data past its own DATA_FIN can
trigger this. Should copied_seq account for the DATA_FIN slot? The
later commits in the series still don't adjust it.

>  		u32 data_len = skb->len - offset;
>  		u32 count;
>  		int err;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794215614.git.tanggeliang%40kylinos.cn
