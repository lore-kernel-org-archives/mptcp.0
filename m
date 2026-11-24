Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795563039;
	b=E75Q4iANP9OiPnAHY0FSnaAAasga8ljr8lFVeKwJe5Ab3aWds+Qa4y9RGRw8Qbmpv6VE
	 froLeeYwKFrbbjO7cZsnFanlzPoUV/eKYIcvDKEJA02SkTjGOME5BKFjX9JpTsmH90XFF
	 3ji/nDpGeT0es4B7SVr4mM6IuzlNgTmYQGWjehy8JqDSM0uvpsnjFFv8wI4CaaqjBU1io
	 yANvU+PQpqv8gH29bAb6YG3cyr3EiKW88MPo4Z7MwEBmvuaRm1PNHYXdseWAsY+WO0vRx
	 2YhNSx7Ukr5TiHgSs+A6TBs6IkfFNh962dP0xQYZiNQoTQhJvM9jm5sQASKPVB8Xo+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795563039;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=EjOqGS4g84AidL/UHivCcBsk99dwz+GvluKlncfMXm0=;
	b=KvUNiVYc1L5GaZdOAdtp5zCxO9sQFds1rYN/2g9lFblD3eGFUnFL9xkj2ASl412HueWM
	 ezzFwRqeQ1NQvzadIA6l1NSD9nojjUmDqyL0i0h1NmtxA/xtom4vOxURnx7taTj+hC1Q/
	 juj2Pbc3ELfzJD8oekHKIN69dxhmUvmviXuDFRedSvQ7te6h9a/er7+/uM4SA9Ic99uM0
	 U9Pyn/mxOr1Qu+h1zZelu8IomozUQjnLs10OC4m95PJcTMicXTsFoTcLJbfSmlnfFi1PZ
	 LoODaNcbNp5A7knhiMK3xAGULyphvuFcA5iiCWWlilI6L0vxirlspdt7lGg1XZokfDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WjQvY6BQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0624D606A323
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 23:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WjQvY6BQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2796B1F000C6;
	Tue, 24 Nov 2026 23:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795563038;
	bh=EjOqGS4g84AidL/UHivCcBsk99dwz+GvluKlncfMXm0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WjQvY6BQwoXWhvWemGw0Jlykt++PcsfeGiAKc4nV/Da8ptvILlku+Tt6WFheqwV9C
	 Llrmkuvh4rzOjJ2e22N1LDX+2a70aNWlI30avZRdRU7M53rPlJXUVIG//jB6wv1BV8
	 4xnkjO4BGpS0/pqAulxRfEJuEvWZu+z80OFcMltJ/gm4MEzfQ2WyiH718Lm7gYv9yo
	 SWqOMhraFo8YsCEKWuKzlrjfhdAZf1YEYDcUgO6psxu3zCsiu15ADkrevArYLjELmV
	 dvu4gmaSzoUkQmEuc1qw2AjLEJiNoldAJYn9bwQtSXjnUlUhsSSsb+dj2/abFRMQc9
	 ZJr0Xpb1oRCbA==
Subject:
 Re: [PATCH mptcp-next v8 1/7] ipv4: fix uninitialized memory in zerocopy cmsg
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 24 Nov 2026 23:30:37 +0000
Message-ID: <179556303770.3133.17186828372504774658@kernel.org>
In-Reply-To: <2819758329599addb172d144f078727112ecf17c.1795421388.git.tanggeliang@kylinos.cn>
References: <2819758329599addb172d144f078727112ecf17c.1795421388.git.tanggeliang@kylinos.cn>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message describes an uninitialized-memory leak that
  cannot happen in the current tree.
- [Low] The commit metadata has an author/sign-off identity mismatch.

--

ipv4: fix uninitialized memory in zerocopy cmsg

This patch adds an early return to ipv4_datagram_support_cmsg() when
ee_origin is SO_EE_ORIGIN_ZEROCOPY. The stated reason is that the IP_PKTINFO
path reads ip_hdr(skb)->saddr on zerocopy completion skbs, which have no IP
header, and so leaks uninitialized memory to userspace.

> Fixes: 829ae9d61165 ("net-timestamp: allow reading recv cmsg on errqueue with origin tstamp")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the author address (geliang@kernel.org) doesn't match
the Signed-off-by address (tanggeliang@kylinos.cn). checkpatch reports this
as FROM_SIGN_OFF_MISMATCH.

Could the sign-off use the author address, or the author be changed to
match? The other patches in this series have the same mismatch.

> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index e06c1f48ecad6..db15a57cccf16 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -504,6 +504,12 @@ static bool ipv4_datagram_support_cmsg(const struct sock *sk,
>  	if (ee_origin == SO_EE_ORIGIN_LOCAL)
>  		return false;
>  
> +	/* Zerocopy completion notifications don't have IP headers,
> +	 * so IP_PKTINFO cmsg is not applicable.
> +	 */
> +	if (ee_origin == SO_EE_ORIGIN_ZEROCOPY)
> +		return false;
> +

[Severity: Medium]
Before this patch, could ipv4_datagram_support_cmsg() ever reach
ip_hdr(skb)->saddr for a zerocopy notification?

The commit message says ipi_ifindex "aliases the ops pointer in
ubuf_info_msgzc stored in skb->cb" and is non-zero. But the only producer
of SO_EE_ORIGIN_ZEROCOPY error queue skbs, __msg_zerocopy_callback() in
net/core/skbuff.c, clears skb->cb before it queues the skb:

net/core/skbuff.c:__msg_zerocopy_callback() {
    ...
	serr = SKB_EXT_ERR(skb);
	memset(serr, 0, sizeof(*serr));
	serr->ee.ee_errno = 0;
	serr->ee.ee_origin = SO_EE_ORIGIN_ZEROCOPY;
    ...
}

It copies len, id and zerocopy out of uarg before the memset. So by the time
the skb reaches sk_error_queue, the ubuf_info_msgzc contents, including ops,
are gone.

struct sock_exterr_skb starts with header.h4, and struct inet_skb_parm
starts with int iif. PKTINFO_SKB_CB(skb) is a cast of skb->cb, and
ipi_ifindex is the first int of struct in_pktinfo. So it reads the same
zeroed bytes at cb offset 0.

skb_zerocopy_notify_extend() only updates ee.ee_data. Neither
sock_dequeue_err_skb() nor ip_recv_error() writes header before this call.

Given that, wouldn't the existing check already return false for every
zerocopy notification?

	info = PKTINFO_SKB_CB(skb);
	if (!(READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_CMSG) ||
	    !info->ipi_ifindex)
		return false;

If so, the new check does not change runtime behavior. The "fix
uninitialized memory" subject and the Fixes: tag, which would pull this into
stable, don't seem to match the code.

Could the commit message describe this as a clarity or hardening change, and
the Fixes: tag be dropped?

Also, if the premise were correct, wouldn't ip6_datagram_support_cmsg() in
net/ipv6/datagram.c have the same problem? It is gated only on
IP6CB(skb)->iif:

	if (serr->ee.ee_origin == SO_EE_ORIGIN_LOCAL)
		return false;

	if (!IP6CB(skb)->iif)
		return false;

This patch does not change it.

>  	/* Support IP_PKTINFO on tstamp packets if requested, to correlate
>  	 * timestamp with egress dev. Not possible for packets without iif
>  	 * or without payload (SOF_TIMESTAMPING_OPT_TSONLY).

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1795421388.git.tanggeliang%40kylinos.cn
