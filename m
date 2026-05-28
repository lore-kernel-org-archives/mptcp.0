Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560581E1DE5
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 08:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779956503; cv=none; b=dMDqdssS8453k88ZxiiYYh5jkNI7HVvZh8s7e9Hto8JTJPsHhkZ7+S9cMLz6mLwJcAQbqACvw5Y3AMvSSFUuIeEDuBITST2BvVOrtxt4lUkd2ubLzDhMUSkgaZdtmVgnC8LJP6adUjGir52AT0Z3OOpzN1le/nbyopuvrvcdebk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779956503; c=relaxed/simple;
	bh=St/ZeGGq5TiQxVJ05PDvjnofkU9wn8xJve15gTY/TRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=QKYaj6urFSeCisC8aF8uP1s7e+01CwaCjZSyuxTaDIfvZDbaytgcDqXsQwobaVPXenZqb3iUllUteMfc09ZLNWRztk/Sljnk4FsFZ20sh2ZJtSKaVWNzpd1GUtoqpGaHMuD2/sH3yQNg/oWoeupbez89kUT9ZH1WrD5+3EnE7zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+xbqYyQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+xbqYyQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493311F000E9;
	Thu, 28 May 2026 08:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779956502;
	bh=xKQcqNw8l1IyFdPcugB9uDwCabha6kWD6NvD5Dm7kDQ=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To;
	b=M+xbqYyQqeHCHfN5Di3HqmYcdWhzgYjrwvhSFpz2JzQ2Y0YbwErMhrgHoWr4n5sU/
	 N9YAKSVCE3wpVs7RT2jHhKrGpDt7MXVRoNgYVHMi8Jmpo8OrwEJE9PiITZwZIzbbga
	 U6Xh9s5TWztFjYbneThUkGSd1+9XBCcYDACzmt3KF5L5OGLWJ4vQ326PCwYjfR/2n1
	 9DOfnuV4WIjhfiR5gAgqEP+9sGI/PxQK0Q6mtrDKQ9gLXk7COThvZefkbRtPBfcPuX
	 qZUnZyAoJI6vByzOov+wnAePSynpk8DwrvmNmGv/scQsiSbUbwx/nGcqsylUBgsa6K
	 dZlX9GyJM3bMA==
Message-ID: <eed92bb8-8b77-44e4-9f1f-242db72177b9@kernel.org>
Date: Thu, 28 May 2026 18:21:38 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v9 mptcp-next 2/6] mptcp: explicitly drop over memory
 limits
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>
References: <cover.1779876523.git.pabeni@redhat.com>
 <6ccf1a553f1e5a3ae63b5a5608f774623d71c9da.1779876523.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <6ccf1a553f1e5a3ae63b5a5608f774623d71c9da.1779876523.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 27/05/2026 20:45, Paolo Abeni wrote:
> Currently the enforcement of the rcvbuf constraint is implemented
> when moving the skbs into the msk receive or OoO queue, keeping the
> incoming skbs in the subflow queue when over limit.
> 
> Under significant memory pressure the above can cause permanent data
> transfer stalls, as the skb needed to make forward progress can be
> stuck in a subflow queue.
> 
> Over memory limits, drop the incoming skb, relaying on MPTCP-level
> retransmissions.
> 
> Note that fallback socket must perform the limit before the skb reaches
> the subflow-level queue, as dropping an in-sequence already acked skb
> would break the stream.
> 
> This is not a complete fix for the stall issue, as the drop strategy
> needs refinements that will come in the next patches.

Thank you for working on that!

(...)

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 97ea4aa37b33..2b35bdc113a5 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1161,8 +1161,30 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
>  	return hmac == mp_opt->ahmac;
>  }
>  
> -/* Return false in case of error (or subflow has been reset),
> - * else return true.
> +static bool mptcp_over_limit(struct sock *sk, struct sock *ssk,
> +			     const struct sk_buff *skb)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	u64 mem = sk_rmem_alloc_get(sk);
> +
> +	mem += READ_ONCE(msk->backlog_len);
> +	if (likely(mem <= READ_ONCE(sk->sk_rcvbuf)))
> +		return false;
> +
> +	/* Avoid silently dropping pure acks, fin or zero win probes. */
> +	if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq ||
> +	    TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN ||
> +	    !after(TCP_SKB_CB(skb)->end_seq, tcp_sk(ssk)->rcv_nxt))
> +		return false;
> +
> +	/* Dropped due to memory constraints, schedule an ack. */
> +	inet_csk(ssk)->icsk_ack.pending |= ICSK_ACK_NOMEM | ICSK_ACK_NOW;
> +	inet_csk_schedule_ack(ssk);

Just to be sure, no need to increment a MIB counter here?

> +	return true;
> +}
> +
> +/* Return false when the caller must drop the packet, i.e. in case of error,
> + * subflow has been reset, or over memory limits.
>   */
>  bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>  {
> @@ -1188,7 +1210,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>  
>  		__mptcp_data_acked(subflow->conn);
>  		mptcp_data_unlock(subflow->conn);
> -		return true;
> +		return !mptcp_over_limit(subflow->conn, sk, skb);
>  	}
>  
>  	mptcp_get_options(skb, &mp_opt);
(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

