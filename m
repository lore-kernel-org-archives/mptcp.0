Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02973A6B89
	for <mptcp@lists.linux.dev>; Fri,  1 May 2026 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777650979; cv=none; b=hO32Tz/KazDhHh3Kktr4ySA9pjaduxNdVZ30AQd4347Gdr41fhbZEctFtjLbTKHINnp+rN3WLU6sJCsCYyZqWW/WyK4w7511UwwruBmaWO0VuD1VHjY7WqT38+vUW3zWx+SYyiSdvreHdfonN2bwQWzbFKE2lc1oTMIrnZEyjYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777650979; c=relaxed/simple;
	bh=5ZbbcqSHQiw57QfRGV0935NzGGliKXjiMP4NoRcP3T4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9Kuf888bhe7tqVWEfvrlh3IlTiJR141mQYRrN2zt6iAQ7IHC6ReLYz99Y9R06EB3KzJMuR0oJMkSWXeL2WYnXBd173XNweZnoifj+GHyVKoK+g3aPaIpzF12fnH/Qi0sdgpNL7jferCQ0lPE8HrUcehjhUkhCZ/rAU84cio8lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdPUPiyg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdPUPiyg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28272C2BCB4;
	Fri,  1 May 2026 15:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777650979;
	bh=5ZbbcqSHQiw57QfRGV0935NzGGliKXjiMP4NoRcP3T4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VdPUPiygfZz70pCBwj2hnnBGbdVQZgHpStMYmGBYlTFW/nCbEdQdWf4j9qiXntVrw
	 C4RcmOGh90sxhdqPmSRNyg5Umq48P++mis19rj3NtxeEtEOtb7ONA7WRC85CNwoX3B
	 WC9XojUwNs0adVaZE9WI0zO3UWypV92joLv+b6gOb7kfxuyD2UI8lvlcjGCy4CTGBm
	 VQMapPhjEC2qZ7uM69sl4LfS9DVLefhU7ZAsK1TnXkOJlqFSR7GzLXKpDKRl5ZYbH3
	 vU0lF9O87Ke3WJDSP9fwvcGP4BBN63Cp4dnp6VbiwTKTd4d93w0UzMI8/Q0xveQ4WP
	 L5YKGAkKvLDIg==
Message-ID: <b9eb46be-0916-4932-b9d2-165eea2aeb6b@kernel.org>
Date: Fri, 1 May 2026 17:56:16 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v4 2/4] mptcp: propagate RECVERR sockopts to
 subflows
Content-Language: fr
To: David Carlier <devnexen@gmail.com>, mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20260421223338.52743-1-devnexen@gmail.com>
 <cover.1777324037.git.devnexen@gmail.com>
 <21762831cbe0d70fd963dd7f0ed9e05b050a7d1f.1777324037.git.devnexen@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <21762831cbe0d70fd963dd7f0ed9e05b050a7d1f.1777324037.git.devnexen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/04/2026 23:10, David Carlier wrote:
> Propagate IP_RECVERR/IP_RECVERR_RFC4884 and
> IPV6_RECVERR/IPV6_RECVERR_RFC4884 from the MPTCP socket to existing
> and future subflows. The setsockopt path forwards each option to
> every subflow via mptcp_setsockopt_all_sf(); newly-joining subflows
> inherit the four RECVERR bits through sync_socket_options() now that
> MPTCP_INET_FLAGS_MASK covers them.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Assisted-by: Codex:gpt-5
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  net/mptcp/sockopt.c | 97 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 79 insertions(+), 18 deletions(-)
> 
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 41c9dc9cf95e..171e83e66a97 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c

(...)

> @@ -388,6 +394,41 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
>  	return -EOPNOTSUPP;
>  }
>  
> +static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
> +				   int optname, sockptr_t optval,
> +				   unsigned int optlen)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	int ret = 0;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +		ret = tcp_setsockopt(ssk, level, optname, optval, optlen);
> +		if (ret)
> +			break;
> +	}
> +	return ret;
> +}
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +static int mptcp_setsockopt_v6_recverr(struct mptcp_sock *msk, int optname,
> +				       sockptr_t optval, unsigned int optlen)
> +{
> +	struct sock *sk = (struct sock *)msk;
> +	int ret;
> +
> +	ret = ipv6_setsockopt(sk, SOL_IPV6, optname, optval, optlen);
> +	if (ret)
> +		return ret;
> +
> +	lock_sock(sk);
> +	ret = mptcp_setsockopt_all_sf(msk, SOL_IPV6, optname, optval, optlen);
> +	release_sock(sk);
> +	return ret;
> +}
> +#endif

Maybe you could have one generic helper to call xxx_setsockopt() on the
MPTCP socket, and then call mptcp_setsockopt_all_sf(). You can pass the
level, and call the right function.

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

