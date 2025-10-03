Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEC81E515
	for <mptcp@lists.linux.dev>; Fri,  3 Oct 2025 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759506095; cv=none; b=B2jdkuDEkrgRosz3Zbpe+Qolm5dMbXPZpGt5OxYhWfzUTa7yHD3gvHOd/T4l1wjJjHJIgij2wamuEFJ05st+nph6El8L5koGaTclPnJdWfBOcszGUlSp20/JmJvtskqy/3BR58yi+TmLFk/GumUTjYmzQ3qAdB6jXNy+UOXFWxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759506095; c=relaxed/simple;
	bh=WYx+Pxl74Rnq5rCKUtEaKKRZo0gQiBJWDD+2goCaAsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=lJ1Zoo3SW3hcZN1hlV+CntbzjCa3cVKGmd7XlSReIy0BTvfAcX+FXYM4IzwFpOjeloiziSPtpZ+n6FNe77LfwF0HoPDDwqlKoG1OP9l/aBJEmVGYa7yaaE6MKHcyaIZhNTmMFy9xMB+fZGihD7TeTxZJLupitvJ6Cau3cB0JtYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCehECBD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCehECBD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3107CC4CEF5;
	Fri,  3 Oct 2025 15:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759506094;
	bh=WYx+Pxl74Rnq5rCKUtEaKKRZo0gQiBJWDD+2goCaAsw=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=NCehECBD5o0Dc/UsLDy1EcElROeLHaS9kmVBqS2LqXvxM+xDBVGmeCC+ijGMSqahr
	 aP/EKawB/z9jyJyXnNR8wYeYNMsKRwdbXg1R02zBns8hG3xltIgMjQ5k0CoiNREwr0
	 RwZcGWutDmiSKE9DTrFiHYcQA08nlICtcgt09jUxNgXgrFOTwdJ8bK4cdAPWOZkwtQ
	 tNNDvsFmQrStqwtHtoAXaJogi5nqRvDC9KQKBVvLtYdWl9aBEnrIDJXgryUM5G10r/
	 Elo7J3JRVNXORuUkZNfHSMKmjAUXRYEsk9H0RokK8EqsCjXZFesqOekJv5f1np7MOK
	 SgUFmsn5oN5Hg==
Message-ID: <32f75f94-9d7a-4b4c-b09a-28340cabaabc@kernel.org>
Date: Fri, 3 Oct 2025 17:41:31 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4 mptcp-next 1/8] mptcp: borrow forward memory from
 subflow
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>
References: <cover.1759499837.git.pabeni@redhat.com>
 <db89c7930def69c9e0741f1461e17097a8b4c04b.1759499837.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <db89c7930def69c9e0741f1461e17097a8b4c04b.1759499837.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 03/10/2025 16:01, Paolo Abeni wrote:
> In the MPTCP receive path, we release the subflow allocated
> fwd memory just to allocate it again shortly after for the msk.
> 
> That could increases the failures chances, especially during
> backlog processing, when other actions could consume the just
> released memory before the msk socket has a chance to do the
> rcv allocation.
> 
> Replace the skb_orphan() call with an open-coded variant that
> explicitly borrows, with a PAGE_SIZE granularity, the fwd memory
> from the subflow socket instead of releasing it. During backlog
> processing the borrowed memory is accounted at release_cb time.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>   - rebased
>   - explain why skb_orphan is removed

Thank you for the new version!

> ---
>  net/mptcp/protocol.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 574a1e222d9cf..34661ab979158 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -337,11 +337,12 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
>  		mptcp_rcvbuf_grow(sk);
>  }
>  
> -static void mptcp_init_skb(struct sock *ssk,
> -			   struct sk_buff *skb, int offset, int copy_len)
> +static int mptcp_init_skb(struct sock *ssk,
> +			  struct sk_buff *skb, int offset, int copy_len)

There is a conflict here with the export branch. Sorry, that's my fault:
when I sent the patches upstream, I moved some arguments to the previous
line (as reported by Geliang):

 static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, (...)

I manually resolved the conflicts and sent it to our CI:

https://github.com/multipath-tcp/mptcp_net-next/commit/2ed154e487d2cbb1ea49428d0c524354289a3eb4/checks

While at it, I also restarted the syzkaller instances to validate this
series.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

