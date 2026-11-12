Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794459578;
	b=oil42sZkbQNDNBCbMghhVEv3nvmwLw7aLyVGf5fo/tQdMB5TuGofsZjU0tDmX8YwNS8O
	 N16uoFRYIYmj2ntuRdppRJexMjZEsk7XVjMP2vkaRBW3VgIoTuDI2G8ZbvsqY4YrCYMHX
	 4Qqrn2aVJ0qXMN4W/jhf19T8B8gDRrDTTSLfKa4xchN88yv65DfjjivkZHANWXXdktMRe
	 pgSRkIen8HVG70rY4vh85+YwROsemckI6B5DI592iD2Nt4g30BFYfzG41OGMJLvs3/7Eb
	 sDz9n8HigLiu0w4C4Yn0QSHbN2uCBzwjz1w2jwKgnIszty9Rg1Nw21EQJ77ZVhPDMIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794459578;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=WQKxTcW7Ei4lBWZxVdrnws9SkYw6w7AMGqxJJNcsTOw=;
	b=zgzoGYn+U2aUzf4Wz6Hlpi0INnt9kGvqxCsu/l52qzp1GPe2mbsBlbuEkIMA487Kv5ea
	 8ePI56rkfNv1VBLpMrkTU6EZP8nN3VZKaqxNO+xfXQK0ZDuWiNXy3HV9/6r/maRTQL8RQ
	 JrbcnmDEDXPCcunnifzBFkcmFm8RRQSAKY/RclTxsWaaBr0XcpV6xRpbIrZ5tLohsDRSo
	 gO28FpbwTf571hZCKd01sWZS8STqWy6+FIBD8DpRzhOGhp/ssgCCfrgH33M+J5gkA4+al
	 izuDRuLJJDJlCX/JKcIEYBKRhfqTm8MuIOb4wrDYxCr8qbdBpVKQh2haIdPCbrrhPtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ht9Fl379;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB37606A31C
	for <mptcp@lists.linux.dev>; Thu, 12 Nov 2026 04:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ht9Fl379
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2EE1F00A0C;
	Thu, 12 Nov 2026 04:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794459578;
	bh=WQKxTcW7Ei4lBWZxVdrnws9SkYw6w7AMGqxJJNcsTOw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ht9Fl379TpkEo+M3jLuB3d89VU/reqGU1OPlitVBbCrffjoU+JN4ln6sjQPh0BPlf
	 DvIbBblEjTNyJrR1d7b+O25ReFkvPdr1nr8XTBOTRmqnJYhofKBsiS8armuL5mha3M
	 pmz7JpXBe/FeRWV0jNjgIoEgxKXHEg/X89nM0QoWJs7xIHrGZRW9zO8bNoV3LJr1Ci
	 IP5+//rlWfvk4uEZv1w22M9BGvT0pgS+pBTfILMhGm3Id45Tp9A5hpKP/aC9/kSk6S
	 kLqwjdK/fAW1tAzy+tTVuTAgN5iyepg4/oRfICCABYm+xtJgqzxp4JUczbxC25tprD
	 Rf4ymy7ew/hhQ==
Subject: Re: [PATCH mptcp-next v25 6/8] mptcp: remove CB offset field
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 12 Nov 2026 04:59:38 +0000
Message-ID: <179445957808.488855.14829007570856345115@kernel.org>
In-Reply-To: <cb95c9ef7c21a759db68ab8e9697a52d32848b0c.1794304840.git.tanggeliang@kylinos.cn>
References: <cb95c9ef7c21a759db68ab8e9697a52d32848b0c.1794304840.git.tanggeliang@kylinos.cn>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] After this patch, the read position for every queued skb is
  computed as copied_seq - map_seq + mptcp_offset(skb).

--

mptcp: remove CB offset field

This patch drops the per-skb MPTCP_SKB_CB()->offset field and adds a new
msk->copied_seq. The read position of each queued skb is now computed as
copied_seq - map_seq + mptcp_offset(skb). A new MPTCP_SKB_CB_F_OFFSET flag
stops skbs that carry a prefix from being coalesced, and the partial packet
paths no longer adjust map_seq/offset.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ce0f9c2e6fd1a..645eaf3078a93 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -494,10 +493,6 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
>  	/* Partial packet */
>  	if (after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
>  		copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
> -		MPTCP_SKB_CB(skb)->offset += msk->ack_seq -
> -					     MPTCP_SKB_CB(skb)->map_seq;
> -		MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq -
> -					      MPTCP_SKB_CB(skb)->map_seq;
>  		goto insert;
>  	}

[ ... ]

> @@ -2207,33 +2199,25 @@ static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
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
> +		u64 offset = *seq - MPTCP_SKB_CB(skb)->map_seq +
> +			     mptcp_offset(skb);
>  		u32 data_len = skb->len - offset;
>  		u32 count;
>  		int err;
>  
> -		if (flags & MSG_PEEK) {
> -			/* skip already peeked skbs */
> -			if (total_data_len + data_len <= copied_total) {
> -				total_data_len += data_len;
> -				*last = skb;
> -				continue;
> -			}
> -
> -			/* skip the already peeked data in the current skb */
> -			delta = copied_total - total_data_len;
> -			offset += delta;
> -			data_len -= delta;
> +		/* Skip the already peeked data. */
> +		if (offset >= skb->len) {
> +			*last = skb;
> +			continue;
>  		}

[Severity: Medium]

Is this offset calculation still correct after a DATA_FIN has been
processed?

The formula assumes msk->copied_seq and msk->ack_seq move in the same
sequence space. However, mptcp_check_data_fin() advances only ack_seq for
the DATA_FIN slot:

net/mptcp/protocol.c:mptcp_check_data_fin() {
    ...
	if (mptcp_pending_data_fin(sk, &rcv_data_fin_seq)) {
		WRITE_ONCE(msk->ack_seq, msk->ack_seq + 1);
    ...
}

copied_seq counts only payload bytes, so it can never go past F, the
DATA_FIN sequence number.

get_mapping_status() expands new mappings against ack_seq and does not
compare them with rcv_data_fin_seq. The subflow also stays open in
CLOSE_WAIT. So if the peer sends a mapping at DSN F+1 after its DATA_FIN,
__mptcp_move_skb() sees map_seq == msk->ack_seq and queues the skb in
sequence. It is not coalesced, because the tail's end_seq is F.

The readers then compute offset = F - (F+1) + prefix.

With prefix == 0 in __mptcp_recvmsg_mskq(), the u64 offset wraps, so
offset >= skb->len is true. Even the non-MSG_PEEK path then takes the
"*last = skb; continue;" branch. Does that mean the skb is never eaten?
Its truesize would stay charged until close. Any later skbs that coalesce
into it would be stuck too. SIOCINQ/TCP_CM_INQ would keep reporting bytes
that can never be read.

With prefix >= 1 (for example a partially overlapping TCP retransmission),
offset becomes prefix - 1. Wouldn't skb_copy_datagram_msg() then return one
stale byte from the earlier mapping?

In that case bytes_consumed ends up one larger than bytes_received.
mptcp_data_avail() underflows, and mptcp_inq_hint() returns INT_MAX. That
is the same symptom "mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint"
fixes earlier in this series.

In the read_sock/splice path, mptcp_recv_skb() computes the same value
and finds it is >= skb->len:

	offset = msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq +
		 mptcp_offset(skb);
	if (offset < skb->len) {
		...
	}
	mptcp_eat_recv_skb(sk, skb);

The skb is then eaten without bytes_consumed being updated. Can that drop
the data and leave the inq/epollin accounting permanently non-zero?

There is a similar case when the peer sends a DATA_FIN at DSN X and then
data mapped at X. That skb takes the partial packet path in
__mptcp_move_skb() quoted above, which no longer advances map_seq/offset.
The reader would again read one byte too many.

The old per-skb CB->offset was advanced by the partial path, so it did not
depend on copied_seq staying in step with ack_seq.

As far as I can tell, the problem is still there at the end of the series.
"mptcp: sync mptcp skb cb layout with tcp one" switches both readers to u32
arithmetic but keeps the same formula, and mptcp_check_data_fin() still
bumps only ack_seq.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794304840.git.tanggeliang%40kylinos.cn
