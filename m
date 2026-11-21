Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795286929;
	b=UQcLT0+feg+tGJvqqbMIIg2oenHEfTBaFv4PBRtEPzoFGnSyP8nJ+fNogmWnw2zHB059
	 N/eHHpga/4LFuXmAetWpuoSg2nNHoYGFTueFmUj8VxzFfifZVWmOsiydk1kbNWRl/Nse2
	 lf0h9n48oESeXlmAAYdinTp4jzydl5gFCvdDpRRCTPtHSttT3V9N+KA335nDHmGqSI7qd
	 qUxs4/5JBzSTiu5KDS7262qRXYk5gky7XW2GqY3chTpkPeVAZt7AK58BJgdSJy4lOPQP5
	 eUZW9NPiqju6hfjNQp/Ag3kXBDF4o9TILcwf/3Bnxo9boKU1DmnUlztoqRrN2y/eutw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795286929;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=LvE/5lLzSA3kBIgfVFY53of7yDlw+Ma3kInHk6d+oL0=;
	b=unLb6MNFxxmwEWXGfqBqMBvX9ibx16aEAfaWWbsITkYJy2c7gDOpeMnfIG82TGOoxSd1
	 Jd9UWyn6hAaflfpHb3heF7IKhlIHLgALXDuSXebnZgGodrRNOCQti+kV0wXrQPUdLAkZ9
	 ZCNoDe+ECHPEp4+aTqH3kVlWVVuD/E/ZzYJTFEcm7hifmZ58fik6owkmII25WHFWU0/8b
	 K6/6fYSq/p9E2s3dHChYPOS6cwfjrUAk2s8jTVOtz6UkD7QzCpxkEu5HJA46GJWWGN+ks
	 E2p9WBHvORzRjKYHA++QFMnmyTPU61Kr1ur9Fa4k/lUut8UZzIDxfNAQRLZQJoy48mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jz300aHP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CF2606A337;
	Sat, 21 Nov 2026 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jz300aHP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8EC1F000C6;
	Sat, 21 Nov 2026 18:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795286929;
	bh=LvE/5lLzSA3kBIgfVFY53of7yDlw+Ma3kInHk6d+oL0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jz300aHPGSQulcL3tnS+E5ZZNbAk0C/RApZQxCO5OHlwajhEZtLOTtxClkOq4AkYX
	 M0xeY24f52Ao6VI6mOTCVU6JWO/eC/ErTU8djGrGCyshwGFBfwT+ytcs9UCQe2JqWV
	 0cIf0wgBR4JdvB8TZwpUmwUtY8hFs4E1yzgO8ttnvE63nfbEsmh4cvNzUYIzfxa9A2
	 E/tJY0RQf2Ab4V0Xn7ave5fPmVPw7dHSpwSuLwKAMc+U68sTzGzbOLkTGcUQQerV8B
	 0y8FyceeEzRd2yK/aKnPbqskXGCkg+MYyDyceAmECmgPcZ6PCJ+j3ShBn+gyiR1Kx2
	 ziEgYl03IIpag==
Subject: Re: [PATCH v3 net-next 3/7] tcp: Stop collapsing if not bloated.
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: edumazet@kernel.org, ncardwell@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, matttbe@kernel.org, martineau@kernel.org,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 mptcp@lists.linux.dev
Date: Sat, 21 Nov 2026 18:48:48 +0000
Message-ID: <179528692814.3135.815253982622168176@kernel.org>
In-Reply-To: <20261119071649.374106-4-kuniyu@google.com>
References: <20261119071649.374106-4-kuniyu@google.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This patch changes what tcp_collapse() does, but the comments
  describing it are now out of date.

--

tcp: Stop collapsing if not bloated.

This patch changes tcp_collapse() to look for sub-ranges that start with
a bloated skb. Each range stops at the first dense, non-overlapping skb,
and collapsing repeats for every such range. On the OOO rbtree,
overlapping skbs are still merged whatever their density, and a range is
skipped when an overlapping skb cannot be merged.

> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index b4e3d623c4a21..5df60dd35afed 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5848,8 +5848,8 @@ static struct sk_buff *tcp_collapse_one(struct sock *sk, struct sk_buff *skb,
>  	return next;
>  }
>  
> -/* Collapse contiguous sequence of skbs head..tail with
> - * sequence numbers start..end.
> +/* Collapse bloated sub-ranges in contiguous sequence of skbs
> + * head..tail starting from sequence number start.
>   *
>   * If tail is NULL, this means until the end of the queue.
>   *

[ ... ]

> @@ -5882,38 +5885,59 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,

[ ... ]

> +	/* Second, find consecutive collapsible skb. */
> +	sub_end = TCP_SKB_CB(skb)->end_seq;
> +	n = tcp_skb_next(skb, list);
> +
> +	while (n && n != tail) {
> +		bool overlap;
> +
> +		if (!after(TCP_SKB_CB(n)->end_seq, sub_end)) {
> +			n = tcp_collapse_one(sk, n, list, root);
> +			continue;
> +		}
> +
> +		/* seq and end_seq must increase monotonically for rbtree. */
> +		overlap = !list && before(TCP_SKB_CB(n)->seq, sub_end);
> +
> +		if (!skb_frags_readable(n) ||
> +		    TCP_SKB_CB(n)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN) ||
> +		    !tcp_skb_can_collapse_rx(skb, n)) {
> +			if (overlap)
> +				goto skip;
> +			break;
> +		}
>  
> -	while (before(start, end)) {
> -		int copy = min_t(int, TCP_COLLAPSE_MAX_SIZE, end - start);
> +		if (!overlap &&
> +		    !tcp_collapse_skb_bloated(n, sub_end,
> +					      TCP_COLLAPSE_SCALING_RATIO))
> +			break;

[Severity: Low]
This isn't a bug, but are the comments around tcp_collapse() still
accurate after this change?

The new tcp_collapse() header says it collapses "bloated sub-ranges".
On the OOO rbtree, though, this loop does more than that:

  - it pulls in non-bloated skbs when overlap is true, because the
    tcp_collapse_skb_bloated() check is skipped
  - it frees skbs that sub_end fully covers, via tcp_collapse_one()
  - it skips the whole range with goto skip when an overlapping skb
    can't be merged

These overlap rules keep the rbtree ordered. Right now they are only
described in the commit message and the one-line inline comment.

The comment above tcp_collapse_ofo_queue() is also unchanged:

/* Collapse ofo queue. Algorithm: select contiguous sequence of skbs
 * and tcp_collapse() them until all the queue is collapsed.
 */

With this patch, tcp_collapse() repacks only sub-ranges that start at a
bloated skb, and it leaves dense skbs in place. So the queue is no
longer fully collapsed.

Both comments are still unchanged at the end of the series. By then,
tcp_collapse() also skips ranges whose repacked skbs would not be denser,
and it caps the total size with TCP_COLLAPSE_MAX_TOTAL_SIZE.

Could these two comments be updated to describe the sub-range and
overlap behavior?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119071649.374106-1-kuniyu%40google.com
