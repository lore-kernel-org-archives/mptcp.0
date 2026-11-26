Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795725843;
	b=ufPQ8q+2xwnVMVdO6SoV8HJqZfNmRt7kB/07AykMkbC2+Lhjf69sCRWFlPOXfnEsdkCr
	 MxYLW+tiCb9pGi1M98tMqDi2JK+3Z2r/YSBzVi2KO6YYUH40sBEdlWTi1mqyQm/hU7jzo
	 6hK4Du4X+FPMQ8fCamXSnRmi1sEijCNiXTor1+O1qaHMcoVk2KiP1NCR60pEqmKM7kqvg
	 TUe2GqNA9nhDHjtS1AmKIS6oBGO3Vf5i79uyvbGRjMLdrjqxOkj2MJBPeteB8O/YVKlQz
	 RBpVBP6S7S2OwCrznv4jIH6mzvVOGZweCdo/wTejILfvuqOLQ0c+Je6JRG/KCL4tAQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795725843;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ksCC/bAi6GJEKqwRdIrZZLkRD/L3Urh3Jflx59Qyzyg=;
	b=lC480HPX6qs/P4OrnXD9dpQxdeeVLQ3EmdUllu1q6zJa4eGQrrSPJOnIujIaPU52LjF1
	 8GKT30SrFoZvCPAzLEiYU7OhH38AXojCpsZCbFBCsH4eSPLt8tBpnpOJaxk9pdqjIlu/k
	 t5Uy4G169212agPEWElK6xEAI3kNW4XOyqSlODtJaQGbec0uFc68gPZAOy89c+MgAUFGP
	 VUFv3iXARDho3IkHv6Ce9IwU7cHZT2g0purVF20IVT8yjZwQrHka0ZoibUBO43dNLUPuh
	 RUmekz1NzcAEfGjmV7k4oN7NEWH+gfwHTl6iKFwESw42jp3w/diwSqAUlfx0OtS5HoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ED/1DR7X";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D634606A6AA
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 20:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ED/1DR7X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52971F000C1;
	Thu, 26 Nov 2026 20:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795725843;
	bh=ksCC/bAi6GJEKqwRdIrZZLkRD/L3Urh3Jflx59Qyzyg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ED/1DR7X5xTeohD4+d3J6DptBQk1gLZUzECMLkXpy7XkNKyQOEwL+//591LbRpXKx
	 r5nTz/8DiuOTqkiw/80kgAzvnrtr7hv/SQq1wON2iR/GWc5E/Go928DCfe9QXwcwjn
	 +IAhtfE4szoPzTSXfdQYlCbcAa1GbqonrHsi8nCa+QmoUmet77YKQJnNpTg4LWncb2
	 8NSZUIZRNVkZzYXS6XUwCPG+/G8GEHpZcjB2cR8os7zdPxAGz93wcx2haI9MpOHnjG
	 0tLN6tBgx3VoUrUhZWEnHqOLaeBDJ8Mp3GwskCzM4lAvbYiyuItM32WYcPHD/NwrMf
	 z2YM9Qy1WZxKA==
Subject: Re: [PATCH mptcp-next v9 3/7] mptcp: add MSG_ZEROCOPY support
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 26 Nov 2026 20:44:02 +0000
Message-ID: <179572584234.3133.17908140893644210429@kernel.org>
In-Reply-To: <fef46d879cfe64c34ee1d792a5fd5713981f9ea4.1795591278.git.tanggeliang@kylinos.cn>
References: <fef46d879cfe64c34ee1d792a5fd5713981f9ea4.1795591278.git.tanggeliang@kylinos.cn>
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 5 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In mptcp_sendmsg_frag() (net/mptcp/protocol.c), zerocopy
  dfrags no longer bail out when tcp_wmem_schedule() returns <= 0.
- [Medium] mptcp_sendmsg_frag() pins whole user pages into subflow skbs
  (get_page(dfrag->page)) but charges the subflow only `copy` bytes…
- [Medium] mptcp_sendmsg_zerocopy_iter() returns -EFAULT when pg_off >
  U16_MAX.
- [Medium] The commit message says the feature "silently downgrades to
  regular copy when MSG_FASTOPEN is set", but the code does not do that.
- [Medium] mptcp_sendmsg() turns on zerocopy for the whole msk whenever
  SOCK_ZEROCOPY and MSG_ZEROCOPY are set.
- [Low] In mptcp_sendmsg_zerocopy_iter(), the socket-memory check `if
  (!ubuf && !sk_wmem_schedule(sk, pg_len + sizeof(*dfrag)))` is dead…

--

mptcp: add MSG_ZEROCOPY support

This commit adds MSG_ZEROCOPY support to MPTCP sockets. User pages are
pinned with iov_iter_get_pages2() into separately allocated
mptcp_data_frag entries that hold a ubuf_info reference. Subflow skbs
built from those dfrags are marked with skb_zcopy_set() and
SKBFL_PURE_ZEROCOPY.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 504d0b196d84b..6bd10a4e1e938 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -1531,7 +1552,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
>  
>  	/* like TCP, allow some progress up to tcp_wmem[0] */
>  	avail = tcp_wmem_schedule(ssk, copy);
> -	if (avail <= 0) {
> +	if (!dfrag->ubuf && avail <= 0) {
>  		tcp_remove_empty_skb(ssk);
>  		return -ENOMEM;
>  	}

[Severity: Medium]

For zerocopy dfrags this no longer bails out when tcp_wmem_schedule()
returns 0, but the code right after still does copy = avail. What
happens when the subflow is under memory pressure?

When sk_wmem_schedule() fails and sk_wmem_queued is already above
tcp_wmem[0], tcp_wmem_schedule() returns min(copy, sk->sk_forward_alloc).
That looks easy to hit here, because zerocopy bytes are added to
ssk->sk_wmem_queued but are never sk_mem_charge()d.

With copy == 0, mptcp_sendmsg_frag() still does:

    get_page(dfrag->page);
    skb_fill_page_desc(skb, i, dfrag->page, offset, copy);
    skb_zcopy_set(skb, dfrag->ubuf, NULL);

For a fresh skb it also fills an mpext with use_map = 1 and data_len = 0.
It then returns 0 without calling tcp_remove_empty_skb(). The zero window
probe branch has the same problem: copy is forced to 1, then overwritten
with 0 on a frozen mpext.

__mptcp_alloc_tx_skb() has already done tcp_skb_entail(). Doesn't this
leave an empty skb (seq == end_seq) in the subflow write queue?

Later, a different data_seq may be sent on this subflow (another subflow
took the dfrag, or a retransmission). In that case
mptcp_skb_can_collapse_to() fails and a new skb is queued behind the
empty one. tcp_write_xmit() stops at an empty send head:

    if (TCP_SKB_CB(skb)->end_seq == TCP_SKB_CB(skb)->seq)
        break;

The subflow would then stall until the probe0 timer sends the empty skb
as a data-less segment with a zero-length DSS mapping.

There is also a smaller issue. When the schedule succeeds, forward
memory is reserved for copy bytes but never used, because sk_mem_charge()
is skipped for pure zerocopy skbs.

For comparison, tcp_sendmsg_locked() never calls tcp_wmem_schedule() for
pure zerocopy skbs, and never uses a 0 result as a frag length:

    if (!skb_zcopy_pure(skb)) {
        copy = tcp_wmem_schedule(sk, copy);
        if (!copy)
            goto wait_for_space;
    }

Should the zerocopy path here follow the same pattern?

> @@ -1542,13 +1563,19 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
>  	} else {
>  		get_page(dfrag->page);
>  		skb_fill_page_desc(skb, i, dfrag->page, offset, copy);
> +
> +		if (dfrag->ubuf && !skb_zcopy(skb)) {
> +			skb_zcopy_set(skb, dfrag->ubuf, NULL);
> +			skb_shinfo(skb)->flags |= SKBFL_PURE_ZEROCOPY;
> +		}
>  	}
>  
>  	skb->len += copy;
>  	skb->data_len += copy;
>  	skb->truesize += copy;
>  	sk_wmem_queued_add(ssk, copy);
> -	sk_mem_charge(ssk, copy);
> +	if (!skb_zcopy_pure(skb))
> +		sk_mem_charge(ssk, copy);

[Severity: Medium]

For zerocopy dfrags, get_page(dfrag->page) pins a whole user page into
the subflow skb. The subflow is only charged copy bytes in truesize and
sk_wmem_queued, though. Can a sender use this to pin far more pages than
sndbuf allows?

TCP's own MSG_ZEROCOPY path charges the full page span of each pinned
chunk in zerocopy_fill_skb_from_iter():

    skb->truesize += PAGE_ALIGN(copied + start);

Here, the only page-sized charge is the PAGE_SIZE + overhead that
mptcp_sendmsg_zerocopy_iter() adds to the msk. dfrag_clear() drops that
charge as soon as the MPTCP DATA_ACK covers the data. ack_update_msk()
accepts a DATA_ACK up to msk->snd_nxt, independent of subflow level TCP
ACKs.

Consider a sender using 1-byte-per-page iovecs and a peer that sends
DATA_ACKs but withholds subflow ACKs:

- Each subflow skb could pin up to sysctl_max_skb_frags full pages for
  roughly 1-1.5KB of accounted truesize.
- sk_stream_memory_free(ssk) would keep admitting more data.
- The pages stay pinned until the subflow times out or resets.

mm_account_pinned_pages() counts bytes rather than pages, so
RLIMIT_MEMLOCK would not catch this either.

[ ... ]

> @@ -1966,7 +1994,7 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>  	lock_sock(ssk);
>  	msg->msg_flags |= MSG_DONTWAIT;
>  	msk->fastopening = 1;
> -	ret = tcp_sendmsg_fastopen(ssk, msg, copied_syn, len, NULL);
> +	ret = tcp_sendmsg_fastopen(ssk, msg, copied_syn, len, ubuf);

[Severity: Medium]

The commit message says:

  The feature silently downgrades to regular copy when MSG_FASTOPEN is
  set or the application has not opted in via setsockopt(SO_ZEROCOPY).

Is that accurate for MSG_FASTOPEN? mptcp_sendmsg() allocates the ubuf
and sets zc = true before the DEFER_CONNECT/MSG_FASTOPEN branch. This
hunk then passes that ubuf to tcp_sendmsg_fastopen() instead of NULL, and
tcp_send_syn_data() attaches it to the SYN skb:

    skb_zcopy_set(syn_data, fo->uarg, NULL);

If mptcp_sendmsg_fastopen() returns 0, the main loop continues with zc
still true. The remaining bytes then go through
mptcp_sendmsg_zerocopy_iter(), because nothing clears zc or ubuf for
MSG_FASTOPEN.

The SYN payload is copied, but the completion is not marked
SO_EE_CODE_ZEROCOPY_COPIED.

Should the code or the commit message be updated so that they match?

[ ... ]

> @@ -2048,27 +2076,113 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
>  	}
>  }
>  
> +static ssize_t mptcp_sendmsg_zerocopy_iter(struct sock *sk, struct msghdr *msg,
> +					   struct ubuf_info *ubuf,
> +					   u32 copy_limit)
> +{

[ ... ]

> +	if (pg_len > U16_MAX) {
> +		iov_iter_revert(&msg->msg_iter, pg_len - U16_MAX);
> +		pg_len = U16_MAX;
> +	}
> +
> +	if (pg_off > U16_MAX) {
> +		iov_iter_revert(&msg->msg_iter, pg_len);
> +		put_page(pages[0]);
> +		return -EFAULT;
> +	}

[Severity: Medium]

Is -EFAULT the right error here? The user memory is valid; the offset
just doesn't fit in the u16 dfrag->offset field. mptcp_sendmsg() still
treats it as a real fault:

    if (ret == -EFAULT) {
        if (copied)
            goto do_error;
        uarg_to_msgzc(ubuf)->zerocopy = 0;
        zc = false;

Take PAGE_SIZE >= 128K (for example 256K page powerpc or hexagon configs)
and a buffer starting at page offset 0:

  chunk 1 is clamped to 65535 bytes
  chunk 2 starts at pg_off 65535 and is clamped to 1 byte by the
    pg_off + pg_len > U16_MAX + 1 check below
  chunk 3 has pg_off 65536 > U16_MAX and returns -EFAULT

A blocking sendmsg() would then return a short count of 65536 bytes even
though no error occurred. A buffer that starts at page offset >= 65536
would silently lose zerocopy for the whole message.

On 64K pages the same clamping produces alternating 65535-byte and 1-byte
dfrags, each charged PAGE_SIZE + overhead.

> +
> +	if (pg_off + pg_len > U16_MAX + 1) {
> +		size_t len = U16_MAX + 1 - pg_off;
> +
> +		iov_iter_revert(&msg->msg_iter, pg_len - len);
> +		pg_len = len;
> +	}
> +
> +	dfrag = kzalloc_obj(*dfrag, GFP_KERNEL_ACCOUNT);
> +	if (!dfrag) {
> +		iov_iter_revert(&msg->msg_iter, pg_len);
> +		put_page(pages[0]);
> +		return -ENOMEM;
> +	}
> +
> +	if (!ubuf && !sk_wmem_schedule(sk, pg_len + sizeof(*dfrag))) {
> +		kfree(dfrag);
> +		iov_iter_revert(&msg->msg_iter, pg_len);
> +		put_page(pages[0]);
> +		return -EAGAIN;
> +	}

[Severity: Low]

Can ubuf ever be NULL here? mptcp_sendmsg_zerocopy_iter() is only called
when zc is true, and zc is only set after msg_zerocopy_realloc() returns
a non-NULL ubuf.

If not, this sk_wmem_schedule() check and its -EAGAIN path are dead
code. Zerocopy dfrag metadata is then never charged to the msk's
sk_forward_alloc.

Instead, the dfrag above is allocated with a hard-coded
GFP_KERNEL_ACCOUNT. That charges the current task's memcg rather than
sk->sk_memcg, and it ignores sk->sk_allocation, unlike the rest of the
MPTCP tx path.

Only sk_wmem_queued is increased, by PAGE_SIZE + overhead. The free in
dfrag_clear() is symmetric, so nothing leaks.

[ ... ]

>  static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  {

[ ... ]

> +	if (!sock_flag(sk, SOCK_ZEROCOPY))
> +		msg->msg_flags &= ~MSG_ZEROCOPY;
> +
> +	if ((msg->msg_flags & MSG_ZEROCOPY) && len) {
> +		ubuf = msg_zerocopy_realloc(sk, len, NULL, false);
> +		if (!ubuf) {
> +			ret = -ENOBUFS;
> +			goto do_error;
> +		}
> +		zc = true;
> +	}

[Severity: Medium]

Should there be a NETIF_F_SG check before zerocopy is enabled here?
tcp_sendmsg_locked() does:

    if (sk->sk_route_caps & NETIF_F_SG)
        zc = MSG_ZEROCOPY;
    else
        uarg_to_msgzc(uarg)->zerocopy = 0;

mptcp_sendmsg() enables zerocopy for the whole msk without checking the
subflow routes, and it never sets zerocopy = 0.

On a subflow without SG, the pinned page frags would be linearized or
copied before transmit. The completion would still report real zerocopy
instead of SO_EE_CODE_ZEROCOPY_COPIED.

TCP subflows usually get NETIF_F_SG through sk_setup_caps(). So this
seems limited to devices without SG where GSO is masked, for example
non-offloaded xfrm with dst->header_len, or sk_gso_disabled.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1795591278.git.tanggeliang%40kylinos.cn
