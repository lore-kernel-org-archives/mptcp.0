Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794123447;
	b=J1d1PTU0wI5xpFDoEzFfE71ktvwwH47OkUr61yHxa3gXGscAYKfQ1KzEMZ73py65bJzV
	 uiav1tugOF+szLyaYjEYP7w+MkYjxLil/gqS2FGMksW1CM4p38hAgkW2jkJ3mrOsUTiMs
	 6YUEe3RIAm+HPDNFtn0oXrpgGQaAJFeFQIL1ctmH63p/72Mem3egEnXorDLgICwEFBf4i
	 Iv0E+j9w6R+HIQPayZLRBVgW4GXTEHyUwnyKty1Z6Yl98S3Ks7cIDQnvELkGCJxwWfQfH
	 k81FXB6RzbX+XH7x9+dmDuJLFCox6wFyVY30cCr2d9P6ikjraD7GpWf3SfA3vDJWA+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794123447;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=MmbJZXRV/rmwUou2PQTnf74DPb29LnFo0GC5bS8lXlU=;
	b=grW+Ur9HpMH8hQa6/nnSk3vUCpd6lrC+2MD6XKDAPpo5Fx6GDFCczrOp/PWathFnbJrI
	 GQiOHI/gL3CDqSOnHF8Yebv0oHUWH4HmiqA4VzWexp3wVBK6gRqzC+FOKSWqIiWgKlFok
	 rmbyc8OLz6gbE4VXlQs6sDurjkleDJQIk2bxZa5+TvWGJ9GlEWdWf3/AD9YrGZHWCS1ZQ
	 vHRxDntyKjCjCSRKAKE/JWQdXmqvdIc9itVutInIYBapjCU49ynf1knenYu4rJS4rUSZ6
	 aXYKncsDzILTZEJgOQMjG2DEYip2PL2SIUNRBG9cUXUnV3oQwsa/2LK+JwWtPIqLNXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nUZtj9Lc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7C1606A31C
	for <mptcp@lists.linux.dev>; Sun,  8 Nov 2026 07:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nUZtj9Lc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BE71F008A5;
	Sun,  8 Nov 2026 07:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794123447;
	bh=MmbJZXRV/rmwUou2PQTnf74DPb29LnFo0GC5bS8lXlU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nUZtj9LcD+n7Boza4aSEjtSYcE2UDe2Ia+3ohufTCzdBOd0Sqs7QAvh7eau4lWh5O
	 1y7hQWZHwC+TDs+AAVpgF1vYKU/kSG4dHSXaxFK0I3CU73RPK6vaaTX1laOj22UF7u
	 wmX0RTdA0hZxmV/sibDgLvkfCA+bxd0OHbE1kBf0cW4L6P/G21HzQHMv4lkaYNkjxa
	 /PUuDRxE6ja/G6eeOpQwykh9IMXHblu1qy+jj6jRxBKCGyXfGwUMPndxiyctwhjv0w
	 QXsc5qjO6LsjSd6E6TNI6UIEChjal05atdodFEcHC9vR5/1w9C82298WEn6AQ0c0vk
	 ElBOBBjkn+zkw==
Subject: Re: [PATCH mptcp-next v23 6/8] mptcp: remove CB offset field
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, pabeni@redhat.com,
 kuba@kernel.org
Date: Sun, 08 Nov 2026 07:37:26 +0000
Message-ID: <179412344663.488855.11908782610872352577@kernel.org>
In-Reply-To: <bf2faa4c21a3faf79fece4448402bfd726fbf9e4.1793969127.git.tanggeliang@kylinos.cn>
References: <bf2faa4c21a3faf79fece4448402bfd726fbf9e4.1793969127.git.tanggeliang@kylinos.cn>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] mptcp: truesize corruption after pskb_pull() in mptcp_init_skb()
- [Medium] mptcp_init_skb() (net/mptcp/protocol.c) gains a new mapping-
  boundary branch.

--

mptcp: remove CB offset field

The patch drops the per-skb MPTCP_SKB_CB(skb)->offset field. Bytes
already consumed inside each skb are now tracked by a new msk-level
copied_seq field, as plain TCP does. When an skb spans multiple DSS
mappings, mptcp_init_skb() now strips the consumed prefix with
pskb_pull(), and it returns false if the pull fails.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index a6c4bad0a8b96..f75297c4d6b0d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -415,25 +414,38 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
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
> +		if (offset >= skb->len || !pskb_pull(skb, offset)) {
> +			WARN_ON_ONCE(1);
> +			sk_eat_skb(ssk, skb);
> +			return false;
> +		}
> +		offset = 0;
> +	}

[Severity: High]
Does this pskb_pull() leave skb->truesize out of sync with the head
size?

At this point the skb is still on ssk->sk_receive_queue and still owned
by the subflow, so skb->sk is ssk and skb->destructor is sock_rfree.
When offset exceeds skb_headlen(), pskb_pull() goes through
__pskb_pull_tail(). That calls pskb_expand_head() when tailroom is
short or the skb is cloned.

pskb_expand_head() only fixes up truesize for skbs that are orphaned:

net/core/skbuff.c:pskb_expand_head() {
    ...
	if (!skb->sk || skb->destructor == sock_edemux)
		skb->truesize += size - osize;
    ...
}

So skb_end_offset(skb) grows and skb->truesize stays the same.
pskb_pull() then advances skb->data by the whole offset. That leaves
skb_headlen(skb) == 0, with all remaining payload in frags.

Now suppose this skb later becomes the from argument of
skb_try_coalesce(). That can happen through __mptcp_try_coalesce() from
__mptcp_move_skb(), __mptcp_add_backlog(), mptcp_data_queue_ofo() or
__mptcp_ofo_queue(). The headlen == 0 branch there computes:

	delta = from->truesize - SKB_TRUESIZE(skb_end_offset(from));

This delta is now short by the head expansion. It can fall below
from->len, or go negative, and trip WARN_ON_ONCE(delta < len).

The wrong delta is then added to to->truesize and charged through
mptcp_try_coalesce() into sk->sk_rmem_alloc and the msk forward memory.
On the backlog path it also feeds into the ssk rmem and
msk->backlog_len accounting. So the receive memory accounting drifts
for the rest of the connection's life. Even without coalescing, the
skb is under-charged when its truesize is moved to the msk.

As described for the other pskb_pull() concern, a peer can reach this
branch with a segment that partially overlaps already consumed data and
carries a DSS mapping starting in its middle. With GRO-merged or
coalesced paged skbs, this looks remotely triggerable.

How should this be fixed? One option is to uncharge or orphan the skb
from ssk before modifying it, and recompute truesize after the pull.
Another is to avoid reshaping the skb in this path at all. Which one
did you have in mind?

[Severity: Medium]
Can this pskb_pull() fail under normal runtime conditions and then WARN
and drop data?

When offset is larger than skb_headlen(), pskb_pull() goes through
__pskb_pull_tail(). That function returns NULL in two cases:

net/core/skbuff.c:__pskb_pull_tail() {
    ...
	if (!skb_frags_readable(skb))
		return NULL;

	if (eat > 0 || skb_cloned(skb)) {
		if (pskb_expand_head(skb, 0, eat > 0 ? eat + 128 : 0,
				     GFP_ATOMIC))
			return NULL;
	}
    ...
}

The first is any skb with unreadable (devmem/netmem) frags. The second
is a GFP_ATOMIC failure when the skb has no tailroom or is cloned, for
example while a packet tap is active.

So an ordinary atomic allocation failure in softirq hits WARN_ON_ONCE(1).
On hosts with panic_on_warn, that becomes a crash.

Can a remote peer steer packets into this branch?

validate_mapping() in net/mptcp/subflow.c compares tp->copied_seq, not
the skb start, against the mapping:

	u32 ssn = tcp_sk(ssk)->copied_seq - subflow->ssn_offset;

	if (unlikely(before(ssn, subflow->map_subflow_seq))) {

Suppose [S, S+100) has already been consumed. The peer can then send a
partially overlapping segment [S+50, S+200) whose DSS mapping starts at
S+100. tcp_data_queue() queues that segment untrimmed, and
mptcp_init_skb() is then called with offset > 0 on an skb that starts
before map_subflow_seq.

Even when the pull succeeds, the receiver may have to reallocate a
(possibly high-order) linear head in softirq. It then copies up to a
GRO-merged skb's worth of paged data (around 64KB) into it, only to
throw that data away.

The previous code handled the same case without any allocation by
recording MPTCP_SKB_CB(skb)->offset.

>  	/* the skb map_seq accounts for the skb offset:
>  	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq

[ ... ]

> @@ -855,7 +863,10 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>  		if (offset < skb->len) {
>  			size_t len = skb->len - offset;
>  
> -			mptcp_init_skb(ssk, skb, offset, len);
> +			if (!mptcp_init_skb(ssk, skb, offset)) {
> +				seq += len;
> +				goto out;
> +			}

On the failure path, is it intended that tp->copied_seq moves past the
skb that sk_eat_skb() just freed?

Those bytes have already been acked at the TCP level, but msk->ack_seq
never covers them. They are dropped without bumping any MIB counter. The
goto also skips the map_remaining < len DSS-corruption check below.

The MPTCP stream would then stall until MPTCP-level retransmission or
reinjection fills the hole.

The commit message only says:

    When pskb_pull() fails,
    the caller updates seq and jumps to the cleanup path to ensure
    tp->copied_seq and more_data_avail are properly updated.

It does not mention the WARN or the dropped data.

>  
>  			if (own_msk) {
>  				mptcp_subflow_lend_fwdmem(subflow, skb);
> @@ -878,6 +889,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>  			}
>  		}
>  
> +out:
>  		WRITE_ONCE(tp->copied_seq, seq);
>  		more_data_avail = mptcp_subflow_data_available(ssk);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793969127.git.tanggeliang%40kylinos.cn
