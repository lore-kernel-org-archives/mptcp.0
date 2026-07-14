Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E7021ABD7;
	Tue, 14 Jul 2026 02:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783995738; cv=none; b=U8vtlF38Ibqny6+2D81+JfokYQuQJOrVC77uWaLVF7reE8FQSrp/eX96uDVWxxB8xqHGLlkQq2Mr+38KMkFgxDZ37VlkPhbcX3QpqhZnsccctwsZBvMcXLO6gh+BUF8UK0c0qDtvHvpKaYxjZevSxcsdimagviswTU90Xhu+q48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783995738; c=relaxed/simple;
	bh=Q3PL6OREjtCHX20dFolGJy3noRev7G8fgAJ3W6EcbD4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pdEdqGpLm+kLRceVVY8Xzk2gkptlsfKick3gaqoJu0RmpQD1/K+I9O1G6F5zl+THgsgLUC1vx4ojTj2H6vzAfI8HxDqfoEuNU8ThGITUG1rZzlvNjuGZqyjlLOarlgaweH4ecMvrVJm5eNMgYV9SoHTHPDDjRVs4YzKubr3Ye+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6R5dQhP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6R5dQhP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69401F000E9;
	Tue, 14 Jul 2026 02:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783995736;
	bh=fKGsXxGIq8JhLYyL/PNxqs8d2jziD2sNSoKakr1IH+w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=m6R5dQhPyRGnYUI2k6+c1JldvROY4qFqj/xCb3a3eotT+UV0CLqR7VvIvKVXysZlD
	 bKnskP/jvIWpUzjFPNpH9B6U9b+G+xyK/MBLDUmIWohF4theXK5rBOdQizG9MYIyBT
	 cj93R8DZtLDjJL2Dnb1gZ2rDCFZ3nQNp+8HIKmPllWY2UyYfI8DYaJ2M3q0mVgYALy
	 drrr0SZ/3Cb7p0FYa6kDjx99FB8YqposQjJZa0LmC2lAC/EKlnxUWivKHnEnYan/7e
	 qRpSuXIkztwUYA7JTdn7yj2prZ6OjHYb9pehmGQ/tmclAOHFDvTASuqE9HzVK6Kdyc
	 wwRGX0SGRk8xA==
Message-ID: <c3b017e1c96cdafce15012e737389108d7cbf8f6.camel@kernel.org>
Subject: Re: [PATCH net-next v2] mptcp: sockopt: implement IPV6_TCLASS
From: Geliang Tang <geliang@kernel.org>
To: David 'equinox' Lamparter <equinox@diac24.net>, Matthieu Baerts
	 <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev
Date: Tue, 14 Jul 2026 10:22:12 +0800
In-Reply-To: <20260713135551.569365-1-equinox@diac24.net>
References: <20260713135551.569365-1-equinox@diac24.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David,

Thanks for your patch. However there is already a version under review
on the MPTCP mailing list that adds IPV6_TCLASS [1] (as well as IP_TTL
and IPV6_UNICAST_HOPS).

Thanks,
-Geliang

https://patchwork.kernel.org/project/mptcp/patch/2617b8684039574734b8622936ef126d6a7cd519.1754986785.git.tanggeliang@kylinos.cn/

On Mon, 2026-07-13 at 15:51 +0200, David 'equinox' Lamparter wrote:
> The IPV6_TCLASS setsockopt just needs to be forwarded to the
> individual
> TCP sockets, like IP_TOS is already handled for IPv4.  The code here
> is
> pretty much identical, except there's no helper for IPv6 like IPv4's
> __ip_sock_set_tos().
> 
> Coincidentally, ssh uses this sockopt and prints an error in the
> middle
> of your ongoing SSH session when it doesn't work (very annoying when
> doing SCP/SFTP on a multiplexed session.)
> 
> Signed-off-by: David 'equinox' Lamparter <equinox@diac24.net>
> Cc: Matthieu Baerts <matttbe@kernel.org>
> Cc: Mat Martineau <martineau@kernel.org>
> Cc: Geliang Tang <geliang@kernel.org>
> ---
> [v2: added guard for CONFIG_IPV6=n.  I could also add a stub for
> ipv6_setsockopt() in include/net/ipv6.h, that might be prettier?]
> ---
>  net/mptcp/sockopt.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index fcf6feb2a9eb..1b83bba0b58e 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -394,6 +394,39 @@ static int mptcp_setsockopt_sol_socket(struct
> mptcp_sock *msk, int optname,
>  	return -EOPNOTSUPP;
>  }
>  
> +static int mptcp_setsockopt_v6_set_tclass(struct mptcp_sock *msk,
> int optname,
> +					  sockptr_t optval, unsigned
> int optlen)
> +{
> +#if !IS_ENABLED(CONFIG_IPV6)
> +	return -EOPNOTSUPP;
> +#else
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *sk = (struct sock *)msk;
> +	int err, val;
> +
> +	err = ipv6_setsockopt(sk, SOL_IPV6, optname, optval,
> optlen);
> +
> +	if (err != 0)
> +		return err;
> +
> +	lock_sock(sk);
> +	sockopt_seq_inc(msk);
> +	val = READ_ONCE(inet6_sk(sk)->tclass);
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +		bool slow;
> +
> +		slow = lock_sock_fast(ssk);
> +		inet6_sk(ssk)->tclass = val;
> +		sk_dst_reset(ssk);
> +		unlock_sock_fast(ssk, slow);
> +	}
> +	release_sock(sk);
> +
> +	return 0;
> +#endif
> +}
> +
>  static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
>  			       sockptr_t optval, unsigned int
> optlen)
>  {
> @@ -436,6 +469,8 @@ static int mptcp_setsockopt_v6(struct mptcp_sock
> *msk, int optname,
>  
>  		release_sock(sk);
>  		break;
> +	case IPV6_TCLASS:
> +		return mptcp_setsockopt_v6_set_tclass(msk, optname,
> optval, optlen);
>  	}
>  
>  	return ret;
> @@ -1485,6 +1520,9 @@ static int mptcp_getsockopt_v6(struct
> mptcp_sock *msk, int optname,
>  	struct sock *sk = (void *)msk;
>  
>  	switch (optname) {
> +	case IPV6_TCLASS:
> +		return mptcp_put_int_option(msk, optval, optlen,
> +					    READ_ONCE(inet6_sk(sk)-
> >tclass));
>  	case IPV6_V6ONLY:
>  		return mptcp_put_int_option(msk, optval, optlen,
>  					    sk->sk_ipv6only);
