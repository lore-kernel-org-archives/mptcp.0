Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795286928;
	b=5ez2RcrGoy4uUDXFpQDhacZ1XBTB6d/RuCEkRwumIKXo+4QM2J4CUK73LYma9uCtrLhK
	 /cF/DtsrORuNCeQg/MrmR6rddLB/Y+tIrIKD2kXSZYljU1COeJxOk3iojPKuvq9vLucAk
	 r4/x3H9hIWjn6/ZBT8kRsHb08b4Ucv0NlKPpbJwzwAtDB94X6uYqGo1QkJMC1M8O2ORv0
	 0CDyvA74L2ZN4NklsQQqr/46VimCzzt15RMU/EGDm+pbJoKCtxdrGaO/BH5u+4URwYFXm
	 8cgAMPsy4d/Vw4kfJTgHkvCxz3oltGjYgKfrH2koyCa4FiNe6sCiDjizVgkBPsqCCNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795286928;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=cyGBZWRFo7khWBx16+BXqfWWwxYQto9azSudfKDY96Q=;
	b=xB7x1JrKCMwWi3REecRhSB3m4qzOpTuqtN1kkX5pHFD1q5Hf3pH9RF2WPZO85UjpYdUU
	 z2HNBBfp7YCwrBdEaPZ0i+2nJedFq4nVsf7i3s6SFzFlYBGggr95xBzjDT31+WkyRvUzN
	 SQG/YMafAWaRJJ+C4hQEQCaxVhU4H5gKZ5hv0YyDobMkJIUXB6IQILmPvhAB6vvhX9D8k
	 F/c+6SI7/Mg7b3nulcu18/RMsTQR9pZ4cTEtjMkX2dTOTIf4emf6LcRGRJNCYnd8Oewtv
	 bBf4qNhEAjAzrAw0+ADLI/sIi9T1pXoy/sUkDsoakBZ+Te7Hb6nX2FfuuGaNEmQgXrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UszwaTW+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BF9606A320;
	Sat, 21 Nov 2026 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UszwaTW+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC9D1F000C6;
	Sat, 21 Nov 2026 18:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795286928;
	bh=cyGBZWRFo7khWBx16+BXqfWWwxYQto9azSudfKDY96Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UszwaTW+nuXUpn2RGGvprRlwg6zzC7vIzrLwvumzQX7ePqukvZ8TS8t1n5MbxOvzf
	 aGXM7zjahByikBTnNpyx4rDzmzdxrZyFvbaJTM0nS4ltfPMuR6LViMaJpWK4yc3KH4
	 tU/lDP0kug/vAbBLPUsVjsszWUTmEPtZ1QSjVS6h6Ue2Tg39Z06dZA5uzstWcZ1nYR
	 NAEzDSdZwoAiZromzEUHHuBuDt8oaFJhY/sIvNafXglOc/ZH3bcM7tYMNMy4fWROM3
	 ILtfSAPpPiGJ6mvjweZPqqz+2FmzYwhH6Qs6aNfyd3fDICkENWt1X68Y9Y5vDWxKfC
	 4tJuFR8BDmpEQ==
Subject:
 Re: [PATCH v3 net-next 1/7] tcp: Refactor the first loop in tcp_collapse().
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: edumazet@kernel.org, ncardwell@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, matttbe@kernel.org, martineau@kernel.org,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 mptcp@lists.linux.dev
Date: Sat, 21 Nov 2026 18:48:46 +0000
Message-ID: <179528692693.3135.11505988142988648858@kernel.org>
In-Reply-To: <20261119071649.374106-2-kuniyu@google.com>
References: <20261119071649.374106-2-kuniyu@google.com>
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

- [Low] The commit "tcp: Refactor the first loop in tcp_collapse()" is
  titled as a refactor.
- [Low] In tcp_collapse() (net/ipv4/tcp_input.c), the patch merges the
  `!skb_frags_readable(skb)` test into the condition directly below the…

--

tcp: Refactor the first loop in tcp_collapse().

This patch restructures the first loop in tcp_collapse(). SYN/FIN skbs
and skbs with unreadable frags now go to skip_this, which removes
end_of_skbs and the rechecks after the loop. The skb_frags_readable()
test also moves below the fully-covered check, and the v2 note documents
the SYN/FIN overlap behaviour change.

> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index d35048c363be5..838d4f470c944 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5849,23 +5849,17 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,

[ ... ]

>  restart:
> -	for (end_of_skbs = true; skb != NULL && skb != tail; skb = n) {
> +	for (; skb && skb != tail; skb = n) {
>  		n = tcp_skb_next(skb, list);
>  
> -		if (!skb_frags_readable(skb))
> -			goto skip_this;
> -
>  		/* No new bits? It is possible on ofo queue. */
>  		if (!before(start, TCP_SKB_CB(skb)->end_seq)) {
>  			skb = tcp_collapse_one(sk, skb, list, root);
> -			if (!skb)
> -				break;
>  			goto restart;
>  		}

[Severity: Low]
In tcp_collapse(), the skb_frags_readable() test now runs after the "No
new bits?" check. Should the commit message describe what this changes
for unreadable (devmem/net_iov) skbs?

Before this patch, an unreadable skb that was fully covered by start
always went to skip_this. It stayed in the receive queue or the ofo
rbtree, and this line could move start backwards:

    start = TCP_SKB_CB(skb)->end_seq;

With this patch, the same skb reaches tcp_collapse_one() first. It is
unlinked or rb_erase()d and freed, and start only moves forward.

The commit message only says:

    Also, skb_frags_readable() should be tested after the fully
    overlapping check.

It gives no reason for the move. It also does not say that fully covered
unreadable skbs are now freed.

The v2 note already covers the SYN/FIN change. Could it also cover this
one? The new behaviour looks fine to me, so this is only about the commit
message.

> @@ -5874,27 +5868,25 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
>  		 * - bloated or contains data before "start" or
>  		 *   overlaps to the next one and mptcp allow collapsing.
>  		 */
> -		if (!(TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)) &&
> -		    (tcp_win_from_space(sk, skb->truesize) > skb->len ||
> -		     before(TCP_SKB_CB(skb)->seq, start))) {
> -			end_of_skbs = false;
> +		if (!skb_frags_readable(skb) ||
> +		    TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN))
> +			goto skip_this;
> +
> +		if (tcp_win_from_space(sk, skb->truesize) > skb->len ||
> +		    before(TCP_SKB_CB(skb)->seq, start))
>  			break;
> -		}
>  
>  		if (n && n != tail && skb_frags_readable(n) &&
>  		    tcp_skb_can_collapse_rx(skb, n) &&
> -		    TCP_SKB_CB(skb)->end_seq != TCP_SKB_CB(n)->seq) {
> -			end_of_skbs = false;
> +		    TCP_SKB_CB(skb)->end_seq != TCP_SKB_CB(n)->seq)
>  			break;
> -		}

[Severity: Low]
This isn't a bug, but the readability test now sits directly under the
comment in tcp_collapse() that lists the conditions for the first skb to
collapse:

    /* The first skb to collapse is:
     * - not SYN/FIN and
     * - bloated or contains data before "start" or
     *   overlaps to the next one and mptcp allow collapsing.
     */

The comment does not say that the skb's frags must be readable. It also
does not mention the skb_frags_readable(n) requirement in the overlap
check.

A later patch in the series rewrites this comment as "not SYN/FIN and
the unread portion starting from "start" is bloated". That version still
leaves out readability.

Would it be worth adding the readability requirement to the comment?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119071649.374106-1-kuniyu%40google.com
