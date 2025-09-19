Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C501DE2BF
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758285415; cv=none; b=hTkD1Mbp/HPmOLkvSM6beq5T527VblqdIAjwEDgEmGjgE4hifIOiCzcV1Zcj7XaYY4LVJ1KBhr8fWNguqjT2tRhXENTx4zf35Pu26cMpKsjX/AWnU7ocaHtcFHYhH3CQ6tQ2UP80y8jmwteIWqFOhDiLaoM7PBJNTFfnOmxzolg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758285415; c=relaxed/simple;
	bh=cOyet8RESGxCSzq2oZlY3ZHO2co6ttE/tLzSnrzb0tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PWzDnC9EgGlUBfhi39RJc0PiEbbIZBJ1q5I8hjyclsy0Rhm3yEkhtLVKteMbPV3LmbUj7QW64xVToLaSd/V3ULzFqNNsGYSMGjurPU+4SP1hg2Q2oxbJbal86hA7tWao6Fj1iwfD0dKIR0/VtVTzUNVPOzFGVJ/b8tygIHEsZA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uf5iYs84; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uf5iYs84"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C74C4CEF0;
	Fri, 19 Sep 2025 12:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758285414;
	bh=cOyet8RESGxCSzq2oZlY3ZHO2co6ttE/tLzSnrzb0tw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=uf5iYs84ysbtIHxYPF/kr41tLXfdVYTr81XI4NnaqWCoxc/o4pEBoS/HoR+sXuIrh
	 9g81M2VvrxIHXHsEKWC9VQHCg+Gy5RFWu1ot7Ukp6SVOBajNRgvUghLctUIdRcN2C+
	 h1Gb1YJ9WujuQi4u4X3uY0iANSVG3sjhhamBid+LBNaPs7YxE34br04gNRWda34MOy
	 Vbag7wo1DuyRWDo4eKEYkmlc3SZK94KcGphIMPA9ywq7p0iQG3zKX57gfCReSRkxZT
	 R0tPRThjK3RtST62giaoDf+HNQ/dCm7opnjJ5UeIbsK32r2ctfAJ/WCWKNx78U2Qmk
	 UQvN5HcXVlxUQ==
Message-ID: <ae7f65d5-bb1c-4574-9873-b0102d251a09@kernel.org>
Date: Fri, 19 Sep 2025 14:36:52 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 06/12] mptcp: factor out a basic skb
 coalesce helper
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1758214563.git.pabeni@redhat.com>
 <0be52a39543e405a7812399646499b6f3c0cacde.1758214564.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0be52a39543e405a7812399646499b6f3c0cacde.1758214564.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 18/09/2025 19:14, Paolo Abeni wrote:
> The upcoming patch will introduced backlog processing for MPTCP
> socket, and we want to leverage coalescing in such data path.
> 
> Factor out the relevant bits not touching memory accounting to
> deal with such use-case.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/protocol.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 19b5b925e2acc..66ad9a38a6082 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -142,22 +142,34 @@ static void mptcp_drop(struct sock *sk, struct sk_buff *skb)
>  	__kfree_skb(skb);
>  }
>  
> -static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
> -			       struct sk_buff *from)
> +static int __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
> +				struct sk_buff *from, bool *fragstolen)
>  {
> -	bool fragstolen;
> +	int limit = READ_ONCE(sk->sk_rcvbuf);
>  	int delta;
>  
>  	if (unlikely(MPTCP_SKB_CB(to)->cant_coalesce) ||
>  	    MPTCP_SKB_CB(from)->offset ||
> -	    ((to->len + from->len) > (sk->sk_rcvbuf >> 3)) ||
> -	    !skb_try_coalesce(to, from, &fragstolen, &delta))
> -		return false;
> +	    ((to->len + from->len) > (limit >> 3)) ||
> +	    !skb_try_coalesce(to, from, fragstolen, &delta))
> +		return 0;
>  
>  	pr_debug("colesced seq %llx into %llx new len %d new end seq %llx\n",
>  		 MPTCP_SKB_CB(from)->map_seq, MPTCP_SKB_CB(to)->map_seq,
>  		 to->len, MPTCP_SKB_CB(from)->end_seq);
>  	MPTCP_SKB_CB(to)->end_seq = MPTCP_SKB_CB(from)->end_seq;
> +	return delta;
> +}
> +
> +static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
> +			       struct sk_buff *from)
> +{
> +	bool fragstolen;
> +	int delta;
> +
> +	delta = __mptcp_try_coalesce(sk, to, from, &fragstolen);
> +	if (!delta)
> +		return false;

Small idea: should __mptcp_try_coalesce() returns a bool, and take a
pointer to delta? Similar to what skb_try_coalesce() is doing then.
Here, you will then have:

  if (!__mptcp_try_coalesce(sk, to, from, &fragstolen, &delta))
      return false;

But that's a detail, if you prefer your version, I'm fine with it:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

