Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94721448D5
	for <mptcp@lists.linux.dev>; Tue, 21 Jan 2025 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737460550; cv=none; b=aLm3AvD0WBksF/GqFkl0kgWReInxhEO0JbUSPrQBFByTFN+Dgqegcm23rU8mcX3gABDP3J/udSn5X5VeIh6l2KlZxfruYWPvbMxt6JkGau+95T6+713/85GS7bWEh7eWlZKnNqCBAKAol4ohlspqAfO6E5MRkkqTj4cf7GRN5G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737460550; c=relaxed/simple;
	bh=EyUKZ6iXUEy5tbTxszWzHKIwLWVYbtvrOgGjvYaEjbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Ok/IE9+HKYxJSmw7Tvn91Mqu7YTlZVQThwz2EKeLodYw2QmS8NxcPCpnBLVKBTMr2MeVB8eIj43ZzviDgm+t+aYMMV2kGSIHmj3gUaF58w/zZQVOlC9xFRXdJES21c0OHPNj3E1G48otlfZsPy8UQftu9iuzAvvFPTJZnR0YDJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsLJwCn5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsLJwCn5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0354C4CEDF;
	Tue, 21 Jan 2025 11:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737460549;
	bh=EyUKZ6iXUEy5tbTxszWzHKIwLWVYbtvrOgGjvYaEjbE=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=JsLJwCn5qEUEYLgi+h1c0le/b+UJPWdAUtcyjd5t9YDLF6lmfncM5G7abuxyrOnP9
	 bDebui/LoIJQhMtu39cw63P9zTjL7yw5dxkOdYIc7VTkmIJ8sjgO274aXGo4/8xn7v
	 6b1TnN9zOgAlKDIFtdXmJNf/uvQ1Ak9Jfm93ylS4h8Ch1vwzQ2k+5uYYXUHvEmqPUx
	 75cBHLoZNnFwxNeXbgty7GKmhcXIpmATt6s0dEW45xchD1xNSOR3t+HPa2CAWCPqs6
	 8Dmy2eMGiffxXkwsgTJJjzab2K8vyq7Hzqe8dEvUq4K9D1h13IDTE6LZ452xlYeb7M
	 JL+MWPF4PeifA==
Message-ID: <58a57216-3bc9-4ca5-9b08-70e85e9135ec@kernel.org>
Date: Tue, 21 Jan 2025 12:55:38 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] mptcp: drop __mptcp_fastopen_gen_msk_ackseq()
To: Paolo Abeni <pabeni@redhat.com>
References: <e96b1f70660ffd750c09c051991e2b65a7d1b492.1737398231.git.pabeni@redhat.com>
Content-Language: en-GB
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <e96b1f70660ffd750c09c051991e2b65a7d1b492.1737398231.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 20/01/2025 19:39, Paolo Abeni wrote:
> When we will move the whole RX path under the msk socket lock, updating
> the already queued skb for passive fastopen socket at 3rd ack time will
> be extremely painful and race prone
> 
> The map_seq for already enqueued skbs is used only to allow correct
> coalescing with later data; preventing collapsing to the first skb of
> a fastopen connect we can completely remove the
> __mptcp_fastopen_gen_msk_ackseq() helper.

Thank you for having looked at that!

It looks good to me, just one question below.

> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/539
> 
> Must be applied just before commit:
>  "mptcp: move the whole rx path under msk socket lock protection"
> 
> To such extent, the patch will require a little mangling, as
> __mptcp_fastopen_gen_msk_ackseq() at that history point still lacks
> the
> 	DEBUG_NET_WARN_ON_ONCE(sock_owned_by_user_nocheck(sk));
> annotation.
> 
> I preferred such option to a cleanly applying patch for the target
> place in the repo log to trigger the CI at submission time.

I prefer that too, for the same reason, and also because it often feels
easier for me to resolve conflicts when I have the end results.

> Optimistically sharing this only with very little testing, to distract
> myself from the net-next PR burden.

:)

It looks like the queue is progressing well :)

(...)

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index b1ece280e139..2c1232bfd722 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -130,7 +130,8 @@ struct mptcp_skb_cb {
>  	u64 map_seq;
>  	u64 end_seq;
>  	u32 offset;
> -	u8  has_rxtstamp:1;
> +	u8  has_rxtstamp;
> +	u8  cant_coalesce;

Out of curiosity: while do you prefer to use a "full" u8, instead of one
bit in the previous u8, or a bool? Is it a small optimisation because
this new item is used in the fast path? We have free space there, so
that's fine, but just wondering :)

>  };
>  
>  #define MPTCP_SKB_CB(__skb)	((struct mptcp_skb_cb *)&((__skb)->cb[0]))

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

