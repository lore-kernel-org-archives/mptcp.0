Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795200113;
	b=qL6O9ZnJ1yPxnOwWC1MfmSd9d4XG9Xac9zHL8MnqXRU9sMeWUGJW67jfZgJ271UosNrJ
	 gmTtJzLdKWJL3Q2A8r9AgyT05r91gfYcqlUjKILgEVAkAMN1ERgovtJ+7ynU+LtQgsEww
	 GUnY6Z1Y2mcSKOMsbEaNtgVz6+VY4XQbXDP8zC03slAX9BPTFiD2eCkZtpoYEybFZjYJ/
	 vxDHyrMCVyxeOBufTO8yiEdu6UlUjV5kWk9tWx0aqv3mu2/Ywt62uZLf8SjDf/eWtSmqt
	 4pZk+5ZpxOkfukBhRi75fXZpaOKBbUdG6zeHwOCciDUjV9i5ERIA1fOqPV1werJBvSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795200113;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=rGwGBerm3MiW0D/3qcNyMBYusn1V6xBg5czHEU1biMk=;
	b=wNnNtPQTVCyUrSXMBEBRrUgBIchpahUf35aBSUQN7kBsMSHD27wQ74qjgroYb2POD14Z
	 ZDcvTZ7CPG1Vs9YVkbwLyij2QTRIbvEBYGai2wA0AXiRc5XohP6qB5S9KIgz1YEjaItVu
	 uD3xhosOIoc0CJxQ6YijTgVt0qq7wpucLWptu5Zm4+hQAEQ/ZngX+He/i9K7ZC8tAobgh
	 Xre4RgpcqBFTdYoJ3HNxgTWPZdxMC9NM69WQeYcn84AlBmz9I9fa3xqNX7NiEzuRigOr7
	 Z4keTJtHl6tU0FURLckRGC6r2jbZ3Dg20lSSu0jGUjc3sOyNVYu8rakkvf1j09jsojA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rmgq0ixQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E1A60A260A
	for <mptcp@lists.linux.dev>; Fri, 20 Nov 2026 18:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rmgq0ixQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF81C1F000D4;
	Fri, 20 Nov 2026 18:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795200113;
	bh=rGwGBerm3MiW0D/3qcNyMBYusn1V6xBg5czHEU1biMk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Rmgq0ixQdw16BH+DNURE6KN9qjBw2P4Q4KkNGXCH+c/uRHDsTZVKwustYmvGjI23a
	 3YXGszb3ATaXgACaWwYfxRDvKBwAvwixmmfnC2AK3rjv/OFb1DCoXrILvLS/sGsO9O
	 DDvWweosOUps0VYV2KzFQ8XvvRJ6RH9TZzchSbtPWDPCy5boe+MsZEnO61aHFDz5oG
	 +mDhAa8nLxy6JlfbOyTf5XGNtrVmSL8pWJ6xJxbpuwIbkGcprhaRUkdPZZTqYOcBrd
	 npMuZ5UmouUllVH483YMSYcdNWo2OPT5omm76rr3YyA4rnmtRWJw8cRPGq7QINe/hM
	 i8au50dee0rbw==
Subject: Re: [PATCH mptcp-next v29 6/8] mptcp: remove CB offset field
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Fri, 20 Nov 2026 18:41:52 +0000
Message-ID: <179520011242.3133.5608778876652732838@kernel.org>
In-Reply-To: <fbc3299b9062220507c5e1d50c13eae8c513b6f4.1795063943.git.tanggeliang@kylinos.cn>
References: <fbc3299b9062220507c5e1d50c13eae8c513b6f4.1795063943.git.tanggeliang@kylinos.cn>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The resync skip branch this patch adds to
  __mptcp_recvmsg_mskq() and mptcp_recv_skb() runs when the reader…
- [Medium] Before this patch, __mptcp_move_skb() (partial-packet path)
  and __mptcp_ofo_queue() moved CB offset/map_seq up to msk->ack_seq.
- [Low] The commit message says only that the CB offset field is removed
  and that end_seq changes meaning.
- [Low] The commit message justifies the explicit
  __mptcp_sync_rcv_sequence() call in __mptcp_move_skb() as needed 'when…

--

mptcp: remove CB offset field

This commit drops the per-skb MPTCP CB offset field. A new msk-level
copied_seq now tracks the bytes already copied to user space, as TCP
does. end_seq now stores map_seq + copy_len, and mptcp_dsn() and
mptcp_end_dsn() derive the DSNs from map_seq, end_seq and skb->len.

> Note that the explicit synchronization in __mptcp_move_skb() is needed to
> ensure that the TFO skb in the receive queue got its map_seq synched
> before the next skb lands into the receive queue when spooling the backlog
> at mptcp_release_cb() time, as the release CB synchronization will happen
> later.

[Severity: Low]
Is this description accurate? Both mptcp_release_cb() and
mptcp_move_skbs() handle MPTCP_SYNC_SEQ at the top of every loop
iteration. That happens before mptcp_can_spool_backlog() splices the
backlog:

net/mptcp/protocol.c:mptcp_release_cb() {
    ...
		if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
			msk->copied_seq += msk->tfo_iasn;
			__mptcp_sync_rcv_sequence(sk);
		}

		spool_bl = mptcp_can_spool_backlog(sk, &skbs);
    ...
}

The earlier commit "mptcp: drop the cant_coalesce CB field" describes
the same ordering.

The other caller of __mptcp_move_skb() is the BH path through
__mptcp_move_skbs_from_subflow(). It only runs when the msk is not owned,
and in that case subflow_set_remote_key() has already updated copied_seq
and synced map_seq together.

So the sync in __mptcp_move_skb() seems to matter only when tfo_iasn is
0 (TFO followed by fallback before the remote key arrives). In that case
it leaves map_seq unchanged and just clears rcvd_dummy_seq.

The map_seq sync and the copied_seq += tfo_iasn update are now separate.
They stay consistent only if __mptcp_move_skb() never runs while
MPTCP_SYNC_SEQ is pending. Could the commit message state that invariant
instead?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1a5d1f97c0875..1ed232a4e8b4d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -168,7 +168,8 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
>  	int limit = READ_ONCE(sk->sk_rcvbuf);
>  
>  	if (MPTCP_SKB_CB(from)->map_seq != mptcp_end_dsn(to) ||
> -	    MPTCP_SKB_CB(from)->offset ||
> +	    (MPTCP_SKB_CB(from)->flags | MPTCP_SKB_CB(to)->flags) &
> +	     MPTCP_SKB_CB_F_OFFSET ||
>  	    ((to->len + from->len) > (limit >> 3)) ||
>  	    !skb_try_coalesce(to, from, fragstolen, delta))
>  		return false;

[Severity: Low]
This isn't a bug, but the commit message leaves out two changes. First,
offset is replaced by a new u16 flags field that carries
MPTCP_SKB_CB_F_OFFSET. Second, __mptcp_try_coalesce() now also refuses
to coalesce when the destination skb (to) has an initial offset. Before
this patch, only MPTCP_SKB_CB(from)->offset blocked coalescing.

The new restriction on to looks necessary with the new end_seq encoding.
Copying from->end_seq into a to skb that has an offset would make
mptcp_dsn(to) collapse to map_seq.

It is still a behaviour change. Skbs with an offset are common with
reinjection, where subflow_check_data_avail() discards prefixes that were
already acked. Such skbs can no longer absorb later in-sequence skbs, in
the receive queue or in the OFO queue.

Why MPTCP_SKB_CB_F_OFFSET is tied to TCPHDR_FLAGS_MASK only becomes
clear in the later commit "mptcp: sync mptcp skb cb layout with tcp
one".

Could the changelog mention the new flags field and the coalescing
change?

[ ... ]

> @@ -495,10 +496,6 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
>  	/* Partial packet */
>  	if (after64(mptcp_end_dsn(skb), msk->ack_seq)) {
>  		copy_len = mptcp_end_dsn(skb) - msk->ack_seq;
> -		MPTCP_SKB_CB(skb)->offset += msk->ack_seq -
> -					     MPTCP_SKB_CB(skb)->map_seq;
> -		MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq -
> -					      MPTCP_SKB_CB(skb)->map_seq;
>  		goto insert;
>  	}

[Severity: Medium]
Without this clamping, can the reader deliver a different number of
bytes than the copy_len credited to bytes_received?

Before this patch, both this partial path and __mptcp_ofo_queue() moved
offset and map_seq up to msk->ack_seq. The reader therefore delivered
exactly copy_len bytes. Now the reader computes the offset from its own
copied_seq:

    offset = *seq - MPTCP_SKB_CB(skb)->map_seq;
    data_len = skb->len - offset;

bytes_received, however, is still credited relative to ack_seq. The two
diverge once ack_seq moves without matching queued data. One example is
the DATA_FIN increment in mptcp_check_data_fin():

    WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);

Say a peer DATA_FIN at F has been processed, so ack_seq is F+1 and the
reader's copied_seq is F. The peer then sends a 15-byte mapping starting
at F-5:

    subflow_check_data_avail()
      mptcp_subflow_discard_data()  /* drops 6 bytes, up to ack_seq */
    mptcp_init_skb()                /* offset 6, map_seq F-5, copy_len 9 */
    __mptcp_move_skb()              /* dsn == ack_seq, bytes_received += 9 */
    __mptcp_recvmsg_mskq()          /* offset = F - (F-5) = 5, copies 10 */

Does the reader then give user space a byte the subflow had already
discarded as a duplicate, and add 10 to bytes_consumed? That would make
bytes_consumed larger than bytes_received and wrap the u64 subtraction
in mptcp_data_avail(). The effects would be:

    - SIOCINQ and TCP_CM_INQ report INT_MAX
    - rcvbuf autotuning is skipped
    - EPOLLIN is always reported
    - mptcp_close() does an MP_FASTCLOSE instead of a graceful close

If the peer instead sends in-sequence data at F+1, map_seq is after
copied_seq. The new resync branch in the reader then silently drops the
whole payload.

Nothing in the rx path seems to reject data after DATA_FIN.
mptcp_data_ready() only checks subflow->closing, and
__mptcp_add_backlog() only drops in TCP_CLOSE. The final patch in the
series still leaves this partial path unclamped.

[ ... ]

> @@ -2208,33 +2202,39 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
[ ... ]
>  	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
> -		u32 delta, offset = MPTCP_SKB_CB(skb)->offset;
> -		u32 data_len = skb->len - offset;
> +		u32 data_len;
> +		u64 offset;
>  		u32 count;
>  		int err;
>  
> -		if (flags & MSG_PEEK) {
> -			/* skip already peeked skbs */
> -			if (total_data_len + data_len <= copied_total) {
> -				total_data_len += data_len;
> +		if (unlikely(before64(*seq, MPTCP_SKB_CB(skb)->map_seq))) {
> +			*seq = mptcp_end_dsn(skb);
> +			msk->bytes_consumed += skb->len;
> +			if (!(flags & MSG_PEEK))
> +				mptcp_eat_recv_skb(sk, skb);
> +			else
>  				*last = skb;
> -				continue;
> -			}
> +			continue;
> +		}

[Severity: Medium]
Should bytes_consumed be updated here when MSG_PEEK is set? With
MSG_PEEK the skb stays queued (*last = skb) and msk->copied_seq does not
move. The normal copy path in this same function only updates
bytes_consumed when !(flags & MSG_PEEK).

mptcp_recvmsg() also rebuilds peek_seq from copied_seq after
mptcp_move_skbs() and after sk_wait_data():

		if (flags & MSG_PEEK)
			peek_seq = msk->copied_seq + copied;

This throws away the jump to mptcp_end_dsn(skb) that the branch just
made, so the branch fires again for the same skb. Every later peek adds
skb->len again. So does the final real read, whether through recvmsg()
or through mptcp_recv_skb() for read_sock and splice:

net/mptcp/protocol.c:mptcp_recv_skb() {
    ...
		if (unlikely(before64(msk->copied_seq,
				      MPTCP_SKB_CB(skb)->map_seq))) {
			msk->copied_seq = mptcp_end_dsn(skb);
			msk->bytes_consumed += skb->len;
			mptcp_eat_recv_skb(sk, skb);
			continue;
		}
    ...
}

Can bytes_consumed then grow past bytes_received and wrap the u64
subtraction in mptcp_data_avail()?

    return READ_ONCE(msk->bytes_received) - READ_ONCE(msk->bytes_consumed);

The branch is reachable once ack_seq is ahead of the queued data. For
example, after a DATA_FIN at F, mptcp_check_data_fin() bumps ack_seq to
F+1. If the peer then sends in-sequence data mapped at F+1,
subflow_check_data_avail() and __mptcp_add_backlog() accept it in
CLOSE_WAIT. The reader at copied_seq == F is before map_seq F+1, so it
takes the skip branch.

The consequences would be:

    - mptcp_inq_hint() returns INT_MAX
    - rcvbuf autotuning is skipped in mptcp_rcv_space_adjust()
    - mptcp_epollin_ready() always returns true
    - mptcp_close() picks MP_FASTCLOSE because of apparent unread data

The skipped payload is also dropped without a MIB counter or a warning.
The commit message does not mention this new way of dropping data.

The final patch in the series still has the unconditional
bytes_consumed += skb->len in both __mptcp_recvmsg_mskq() and
mptcp_recv_skb().

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1795063943.git.tanggeliang%40kylinos.cn
