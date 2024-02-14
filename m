Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406BA4C79
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 01:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707875525; cv=none; b=MrNmsqDDZhqagE9Yr+wDA+09SKPJlh8/e6ri15rdHHJ0TEPbaRBTT2cc/U/UF85OkOcif7deQ3pUoII9oSQ8fyWplG5j9TL5u851lFvdgI5+qYUmTAjKDnC7AyG56b3YbgoNdiIgAN91eBrH2EeUv+51GoMrwVKZyVeGFm3yveo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707875525; c=relaxed/simple;
	bh=0XFLeu4DEzz8jHypdzpCDvuYIVlrtr0JyfJkosh7CZE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Rc3ER5eVaOq/ncfCQryQ03/onLpymGojHIc4C2yk0X3uyci3pcsayxqAbVZvc8FrHWEvHgWxRJHQ0joryzilvLDhmxRwD1rGla1h50osQG69fqXf73S3H9bqID5bHBVRjzrJ4S5aLtKCiVCKf17ZY795JSb599sjRu8WzEay6oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjMOCao8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjMOCao8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6245C433F1;
	Wed, 14 Feb 2024 01:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707875524;
	bh=0XFLeu4DEzz8jHypdzpCDvuYIVlrtr0JyfJkosh7CZE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=hjMOCao8g8ayArF2EHnwnh61pOVBGWqwtb3TBgGBLAIv29kK9j0Rvh54tuGeiizYA
	 ARQIGUHs3Uzckl2WrJZKVHOa4wbsVI06d4DFeo3aMpo1+/d8YS9Mrg5c1N6ta6kNgW
	 UR6lyXglnYokg8NvVKzOVFlvVg803rQ+vOUwhX9VHDl8IGeZEIkAr4vJWSg50IFH1V
	 DbH7SFOQSwgdbiTvR11QclVNNx+IAWtR4ruY5+hSNIbfZ3DbQ7pViFqBgPFnFKKcGw
	 IS9MtVC/HnV5n9uFumhn5tW6V7syFQ+UHrQICBDzmYolFTuXV97seTSjoXSG2WWq0O
	 mxD4FQ5vZ3cdw==
Date: Tue, 13 Feb 2024 17:52:04 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>, Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next] mptcp: add a sk_is_tcp check for
 sk_is_mptcp
In-Reply-To: <e97e306f73ff10b437eef979b7d5d82b822e2f52.1707113244.git.tanggeliang@kylinos.cn>
Message-ID: <a0979ee1-8af9-fe30-f166-33de3543d030@kernel.org>
References: <e97e306f73ff10b437eef979b7d5d82b822e2f52.1707113244.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 5 Feb 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> sk_is_mptcp() looks like it can be called using any struct sock *, but
> it only gives valid results with struct tcp_sock *. This patch adds a
> sk_is_tcp() check for it.
>

Hi Geliang -

This is exactly what I asked for in #453, however in our meeting last week 
Paolo was concerned about the overhead of the extra checks when most of 
the call sites are known to be tcp_socks (especially in the TCP code).

Paolo, what do you think about only adding the sk_is_tcp() check when 
CONFIG_DEBUG_NET is enabled? (kind of like Matthieu's "check the protocol 
with DEBUG_NET" series)


- Mat


> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/453
> Suggested-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> include/net/mptcp.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 63972d712a1d..30754bebd5fb 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -124,7 +124,7 @@ void mptcp_init(void);
>
> static inline bool sk_is_mptcp(const struct sock *sk)
> {
> -	return tcp_sk(sk)->is_mptcp;
> +	return sk_is_tcp(sk) ? tcp_sk(sk)->is_mptcp : false;
> }
>
> static inline bool rsk_is_mptcp(const struct request_sock *req)
> -- 
> 2.40.1
>
>
>
