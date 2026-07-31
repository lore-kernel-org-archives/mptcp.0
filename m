Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ECD430CC8
	for <mptcp@lists.linux.dev>; Fri, 31 Jul 2026 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785509771; cv=none; b=QBLt95f+k+Z4FwlBboFona/H50loorBUKOzwC8fmKarn3O2xte9Llolq9dLYEgtatREK5mHoaIj1G8DVgNI80oYtWvwaieL0WSXV1h6xv/YRRM2LXRTzOHPoEd940P9VLasJUvh4w025+4ovPCPjV7gLvp4aVS14z0PTrAwcOtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785509771; c=relaxed/simple;
	bh=I5Yds2vFSZcgEVuLCvY2qWhQyESsfYJOnm4na2mg64Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xt6C3BYx2ToHr98UAdg29sXjoRmHPJhoCa+HY52IBxtn0cRzvqse4cVzZjgXgQ6drYQ1GQd5772xkbj9n1GoH0VW8MLdYAPfMNdzRC6H2JaH1059ra/dXGnqNw+HJZ01a5toUGMveBWODt8aVKaegGe8NHy04mmKkLmUnyZJ+U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfdsIDWK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfdsIDWK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CBD1F000E9;
	Fri, 31 Jul 2026 14:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785509770;
	bh=5qtVaB1aQS4/Zw7ZFHMt+C61PR8poH4bKeK6N1ib59g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FfdsIDWKEtYo8Od/EsKWxj8Vdl4LBDQ6+eL+ckNVcojvWtSmk0PZBCylPUOigfODj
	 j0p9+Koiabmq+lSvrqV7NQNxW5cG62lfryrxLGeodtsrRnJsTJ+vv2+cixHkPgbyQt
	 IA5+pJK1kFFmc8EvH0NEiupWdHv6ys2BZ3gWzL5GTscH4o6g+0r4naH34JQgBrSAH7
	 Jh8eaa/25qWSk0V4I54wx6ZB4wd7S6w7AasTYnD0vkk4qUs8vHy+6/5cq2Kp551VzD
	 XTjFdYL7Feft9hNueIpjtMet0R+i9/qCIuTXBz0FbrfWeZL+58GwJ+1eAoHdGbaJO2
	 G3+3DyYUs+yGw==
Message-ID: <81f26efb-2a53-44f7-a55d-51792507e32c@kernel.org>
Date: Fri, 31 Jul 2026 16:56:06 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v12 0/4] mptcp: MSG_ERRQUEUE support on the
 parent socket
Content-Language: fr
To: David Carlier <devnexen@gmail.com>, pabeni@redhat.com
Cc: martineau@kernel.org, geliang@kernel.org, mptcp@lists.linux.dev
References: <20260730071244.69473-1-devnexen@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260730071244.69473-1-devnexen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi David, Paolo,

On 30/07/2026 09:12, David Carlier wrote:
> This series lets MPTCP applications use poll(EPOLLERR) and
> recvmsg(MSG_ERRQUEUE) on the parent socket to drain TX timestamps
> through the standard inet ABI, the same way they would on a plain TCP
> socket. ICMP-derived errors stay on the subflow queue: the legacy
> RECVERR ABI cannot convey their per-subflow peer identity, and they
> are intended for a future MPTCP_RECERR channel.
> 
> Patch 1 splices subflow err-skbs onto the parent's sk_error_queue at
> error-report time. All forwarded events go through sock_queue_err_skb(),
> which re-homes skb->sk onto the parent and charges sk_rmem_alloc, so the
> parent's error queue stays bounded by sk_rcvbuf and is dropped under rmem
> pressure, matching tcp's tx-timestamp path and ip_icmp_error() /
> ipv6_icmp_error(). mptcp_recvmsg(MSG_ERRQUEUE) forwards directly to
> inet_recv_error(), and mptcp_poll() advertises EPOLLERR purely on the
> parent's sk_err / sk_error_queue, matching tcp_poll().
> 
> Patch 2 factors the existing inet_flags subflow-propagation hard-coded
> list into a mask, so the next patch can extend it without churn.
> 
> Patch 3 makes IP_RECVERR / IPV6_RECVERR (and the RFC4884 variants)
> propagate to the subflows. The parent stores the bit so MPTCP-aware
> helpers can branch on it.
> 
> Patch 4 is a selftest covering the propagation path.
> 
> Changes in v12 (addresses Paolo's v11 review):
>  - reordered the series so the core MSG_ERRQUEUE infrastructure lands
>    first, before the sockopt plumbing that exposes it to user space.
>    The former patch 3/4 is now 1/4.
>  - 1/4: narrow mptcp_errqueue_skb_forwardable() to
>    SO_EE_ORIGIN_TIMESTAMPING. SO_EE_ORIGIN_ZEROCOPY and
>    SO_EE_ORIGIN_LOCAL events cannot be generated on an MPTCP parent
>    today, so the helper only needs extending if and when they can be.
>  - 1/4: trim the block comment above sock_queue_err_skb() and the
>    matching changelog paragraphs, now redundant with the narrower
>    filter.
>  - 2/4: reverse christmas tree declaration ordering in
>    sync_socket_options().
>  - dropped the Suggested-by: Paolo Abeni tags from patches 1-3.
>  - rebased on current export.
Thank you for the v12 and for the previous reviews!

I just applied this series with Paolo's ACK, as I understood the v11 was
good for him, and you applied the last requests he had. I hope that's
OK, I can always fix that later.

Note that I also fixed a few checkpatch issues, not to get in troubles
when upstreaming these patches later.

New patches for t/upstream:
- d1c8339c6464: mptcp: support MSG_ERRQUEUE on the parent socket
- b10c2f76fdcf: mptcp: sockopt: factor inet_flags propagation into a mask
- 36a365e46b58: mptcp: propagate RECVERR sockopts to subflows
- a2f437ee45ab: selftests: mptcp: cover IP_RECVERR sockopt propagation
- Results: e5730411f842..e486d89a0699 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/0565f7c5598354965c1a391e4f96fe5d2f1c09a1/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

