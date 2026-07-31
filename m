Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2D13E7BB2
	for <mptcp@lists.linux.dev>; Fri, 31 Jul 2026 10:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785493038; cv=none; b=VEsHzBX3vr3NIba9g5aN2TpCphEhO0vCeXY+Mi1BJjwgJLEJgfpXYE1jDU19zlkV+rh1cX+nE5qIlsiH40NrKefmPDofpGzlCjfMLHV9gxJPmf3TTxbcQ9vjbGHbe1j00OWGegol9N95YdCuzR8R7At09ZW5PFg9GOn0WB3zT+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785493038; c=relaxed/simple;
	bh=AvpUXtwHjJPOuh9LKYeH0+pz8sS+X9XDTChHi5tpDpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NaegKISOIPOsyvgFLNQuW3lhTcWzsS4jAVg6E0QNnYJfv4+IvwPYeDt3KBqxcVUhStyvlIrUv68Udf5pVgPZaz/URTNmzLnemp1TbOpTvhU2IZMv4G77heykK33wtT/dDS5mczTYQ/vVcon7F2bdrX3G7bxZ76o8nHgkY89GHho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YakjCYSm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YakjCYSm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E8F1F000E9;
	Fri, 31 Jul 2026 10:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785493029;
	bh=CdJSRMN0Pf2DtlqmcZBxTeBsos9sbkpW01aEBxfJyMk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YakjCYSm91Uc7whuD7H3ncvUiDV4MxWQRbcAqx6mpZ0FEH3wo2T1DxtGJ413LfSMY
	 JeDOiuI2Q3LSw6XMwaA5BLQ+xwJsQZna3zqBaVaA7dKYOgNKzTK/1TnbAH6o2M+qaP
	 7FYDTnBAnSM/YqjHwiCMXXXkxcTYgZsyIeobpO0TNDFfxjh8QCbijrO29Eo41gqJ5h
	 p+1DWEMErr47Dj55c88vft/5TgiRQuQ1sxSsAFbCFM+96QWCfIf64T3CRtl9NfEAkc
	 UsAs+jAS4zmf0UscAvKSC5W4CV0o0hgxtCxB5FanHX0SDpAvFOweU14aeb9V4lEAuV
	 EdmFfHWhfBQmg==
Message-ID: <b5f74349-ab93-401a-9f90-a7bfc7ea4f1d@kernel.org>
Date: Fri, 31 Jul 2026 12:17:06 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 1/2] Squash to "mptcp: explicitly drop over
 memory limits"
Content-Language: fr
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>
References: <20260731-mptcp-squash-ooo-pruning-v1-0-a5f5115e1e24@kernel.org>
 <20260731-mptcp-squash-ooo-pruning-v1-1-a5f5115e1e24@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260731-mptcp-squash-ooo-pruning-v1-1-a5f5115e1e24@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 31/07/2026 11:23, Matthieu Baerts (NGI0) wrote:
> Address comments from Clashiko [1]:
> 
> - mib: typo: "constrains" -> "constraints".
> 
> - mptcp_over_limit: precise it is not only 0-win, but retrans, dup or
>   old acks.
> 
> - mptcp_over_limit: bump LINUX_MIB_TCPRCVQDROP, as previously discussed
>   in [2].
> 
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260724-net-next-mptcp-oooq-pruning-v1-0-5dd4dec63a54%40kernel.org?part=3 [1]
> Link: https://lore.kernel.org/b5244dd4-205d-4abd-8ea5-fd879a97038f@redhat.com
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/mib.h     | 2 +-
>  net/mptcp/options.c | 6 +++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> index 18f35f7e0a2d..25f360724c57 100644
> --- a/net/mptcp/mib.h
> +++ b/net/mptcp/mib.h
> @@ -89,7 +89,7 @@ enum linux_mptcp_mib_field {
>  	MPTCP_MIB_FALLBACKFAILED,	/* Can't fallback due to msk status */
>  	MPTCP_MIB_WINPROBE,		/* MPTCP-level zero window probe */
>  	MPTCP_MIB_BACKLOGDROP,		/* Backlog over memory limit */
> -	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constrains */
> +	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constraints */
>  	MPTCP_MIB_OFO_PRUNED,		/* MPTCP-level OoO queue pruned */
>  	__MPTCP_MIB_MAX
>  };
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index d6b009319839..23503984a084 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1193,7 +1193,7 @@ static bool mptcp_over_limit(struct sock *sk, struct sock *ssk,
>  	if (likely(mem <= READ_ONCE(sk->sk_rcvbuf)))
>  		return false;
>  
> -	/* Avoid silently dropping pure acks, fin or zero win probes. */
> +	/* Avoid silently dropping pure acks, fin or already-acked segments. */
>  	if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq ||
>  	    TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN ||
>  	    !after(TCP_SKB_CB(skb)->end_seq, tcp_sk(ssk)->rcv_nxt))
> @@ -1202,6 +1202,10 @@ static bool mptcp_over_limit(struct sock *sk, struct sock *ssk,
>  	/* Dropped due to memory constraints, schedule an ack. */
>  	inet_csk(ssk)->icsk_ack.pending |= ICSK_ACK_NOMEM | ICSK_ACK_NOW;
>  	inet_csk_schedule_ack(ssk);
> +
> +	/* In fallback mode: skb is dropped before the TCP recv queue. */
> +	MPTCP_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP);

Arf, it should be NET_INC_STATS(), not the MPTCP version: I changed to
LINUX_MIB_TCPRCVQDROP just before sending the patches, without checking
in between...

Sorry for the noise, v2 is coming.

> +
>  	return true;
>  }
>  
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

