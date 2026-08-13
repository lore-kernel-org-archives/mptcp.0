Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE74341686D
	for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 11:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786619381; cv=none; b=XMXUVGUyF6cqMcrawG/PGt3iAOmMLvifbk2p0jBjA3fECD1xd/JjJXCApj1MTKtYM7gOIWIPmTLWEafELm2XZxYSvkvvGwWxdNoLod6DKA8fVhRmrlZckU2bc+Jc2C98GUjDVsDw536mLHBbO1j1a1LsLk16sb1GtJGDPWGk5Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786619381; c=relaxed/simple;
	bh=QIS0enR2lOhb+jzZUh64fleMqKuubHvRCcqahDZBusI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ja2/j+hWkYR7c6tSJYo1SFWbIr23N68Mc0CSjrFdmBcscWa2k6JgbigxIznqpDqGN+UZ7fUzlHMLsB0WtFabsRtkTE+zO+WNtI1C3TXdXe7g3fVWTMdcT0mmhJShY6hlsM3Dq1iGGoSe+Y7hQeFR6mE+cZWj5EIcuENSNjONG0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ix7i7zVo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ix7i7zVo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6FD1F00A3A;
	Thu, 13 Aug 2026 11:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786619377;
	bh=d3C5mZIH4NmSI3B8V1CAocjtQPdJzfOkIH6awNVfmyw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ix7i7zVo++nWHMWG3yXb6nboRM/U4efwacHrCn3c7SMlRHVmfMjzlwlp/oi1Ejeob
	 sSF6c1A1NYrGCsuV8HfIywEi7P4GGbN64J+gVWwMr1cIuIo9AitBLqznIiAi2muVrH
	 H8e8dZy0AyIqA9DDl+ePA2g2bqhyFXQSb/P5SqaNFpDO52J0iev9hE1Y8GIwuZ6Wd2
	 7jH5pBG07WmRQOxEZXPgtBM8RpamoQrfDdmbhP/NEYYd1J6OhWdbk/u6v4K5NbYjwQ
	 F9qHE1gLvr/flnAI3NzPZCKvHBQ3cwM8CVheb+hhmGy5bgLRFrANkDZip7d/mX33y/
	 oXhLmyi3mBgyA==
Message-ID: <9e955f41-a12c-44e1-b3cc-1598a5e59474@kernel.org>
Date: Thu, 13 Aug 2026 13:09:35 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 0/4] mptcp: a few fixes
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <cover.1786553006.git.pabeni@redhat.com>
 <cbdf8539-65c0-4bf2-ab43-bf3481b0971f@kernel.org>
 <0858d963-e20e-474a-9f03-ae5d323ff6d1@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0858d963-e20e-474a-9f03-ae5d323ff6d1@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

On 13/08/2026 08:34, Paolo Abeni wrote:
> On 8/12/26 10:54 PM, Matthieu Baerts wrote:
>> 12 Aug 2026 19:08:30 Paolo Abeni <pabeni@redhat.com>:
>>
>>> This is mostly a follow-up to the recent OoO queue pruning series.
>>> Explicitly targeting net as we have already a lot of patches pending for
>>> net-next, and no need to rush IMHO.
>>
>> (I hope it was OK for me to send a few small cleanup patches)
> 
> ATM I haven't checked yet if you already did... but pw says ~400 patches to
> be processed before EoW, I would love if such count is not going to increase:)

Indeed, I understand.

(If I did, can I say it was my cat walking on the keyboard? 😇 Sorry..)

>>> First 2 patches addresses explicit comments from sashiko, 3rd one is a
>>> somewhat unrelated cleanup I stumbled upon while implementing patch 4.
>>>
>>> The last patch fixes another thing implided by sashiko while reviewing
>>> the mentioned series.
>>
>> When reading this, it sounds like there should be 5 patches but only 4
>> have been shared. Just to be sure: is everything there?
> Yes, patch 4 == last patch.

OK, thanks!

> Also patch 4 is the one I think opus 5 could raise some concern on. A safer 
> alternative would be replacing it with the following, which is simpler, but I'm
> not fancy of adding another conditional.

Thank you!

> Staging the series a little bit in the export branch will give some time
> to ponder about a better solution.

Fine for me!

> ---
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ca644ec53eed..45d627981f15 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -995,13 +995,15 @@ static bool mptcp_rtx_timer_pending(struct sock *sk)
>  
>  static void mptcp_reset_rtx_timer(struct sock *sk)
>  {
> +	struct mptcp_sock *msk = mptcp_sk(sk);
>  	unsigned long tout;
>  
>  	/* prevent rescheduling on close */
> -	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
> +	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE) ||
> +	    test_bit(MPTCP_FALLBACK_DONE, msk->flags))
>  		return;
>  
> -	tout = mptcp_sk(sk)->timer_ival;
> +	tout = msk->timer_ival;
>  	sk_reset_timer(sk, &sk->mptcp_retransmit_timer, jiffies + tout);
>  }

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

