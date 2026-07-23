Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D643D28033B
	for <mptcp@lists.linux.dev>; Thu, 23 Jul 2026 01:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769010; cv=none; b=m/IFtUqvks84jfY9izjG/hHgeFE+vaPECrzGIVv9iLoRwxxhKo6dk3SjqqSZA92EduzW3wCKMR0NEzjyOyf/UxJTUEWXwMM8W0sxiUKYsL3psA74/1uPio0wNgboY6O6hIwnh3Qu/vuMVNUuIw+B9UQTQm84TE3QbTWxwE/9bz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769010; c=relaxed/simple;
	bh=wgnaYI/o/RwW78RPmcyJQ0uOiSRnrC7tvLqcdX0MVsI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PA0uP/LyPE5b6ZTJpNiy/1kMPzXhwlxyoG2vNSlXmedLwCkRybGw0P7/dgamt+ZCuRCxYaB6u4xN1BOKWFLDFA9ESvlT8MAhYI/7xC8TS+J9NCaivfVQJev1DqDe6ygNgVuRD60/7k0FCT02VVpI6sojCBeV28xZ9ueBzZwgUC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lV64kDRa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lV64kDRa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732AF1F000E9;
	Thu, 23 Jul 2026 01:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784769009;
	bh=VsSGxGgQHAydGGn2pwxrR+Ml3gofRJhtpaQr3OxLch0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lV64kDRa3R6rmSHu8zB+yLlFw5Qlc8OcqmLdfGD4oixxTnkrGk0BL/Hyj2vrluCmg
	 PMqkY+UORtyPa6pcVz74UCe0rQEB4DWUuwo4PJrgXKDb8aBjOUdqoJ0cTAueea11Dv
	 +voA1SGXzGpYlBB60KJy9YUkASg+sFkT7aVkFVVEY3UhBpsMAnauhMJ++LRsOyKSgO
	 vyh8mj3ETYeqHe+1fsfUJeAshpi+QaQQXu5+ODS1ODdVN/9dv2vClyNxnSkA9yqyud
	 /FWECKTInq0hEHKzFlQg1IwpPwYor0zjc/322w4TrH7S5Op1ubguaoiFggnChx0VKQ
	 /dZZ9DHjrEVrg==
Message-ID: <f28023650f3feaec991e266ee0226c5c0110f17e.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 2/7] mptcp: take TCP_MAXSEG handling into
 __mptcp_setsockopt_set_val
From: Geliang Tang <geliang@kernel.org>
To: Gang Yan <gang.yan@linux.dev>, mptcp@lists.linux.dev
Cc: pabeni@redhat.com, Gang Yan <yangang@kylinos.cn>
Date: Thu, 23 Jul 2026 09:10:01 +0800
In-Reply-To: <11304a8f1ec63390553390404d9164f7a4213b79.1784601268.git.yangang@kylinos.cn>
References: <cover.1784601268.git.yangang@kylinos.cn>
	 <11304a8f1ec63390553390404d9164f7a4213b79.1784601268.git.yangang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Gang,

On Tue, 2026-07-21 at 10:40 +0800, Gang Yan wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> mptcp_setsockopt_all_sf is only used in 'TCP_MAXSEG', and it can be
> replaced with __mptcp_setsockopt_set_val.
> 
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  net/ipv4/tcp.c      |  1 +
>  net/mptcp/sockopt.c | 27 ++-------------------------
>  2 files changed, 3 insertions(+), 25 deletions(-)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index b427f924608c..5915d0e62f43 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3830,6 +3830,7 @@ int tcp_sock_set_maxseg(struct sock *sk, int
> val)
>  	WRITE_ONCE(tcp_sk(sk)->rx_opt.user_mss, val);
>  	return 0;
>  }
> +EXPORT_SYMBOL(tcp_sock_set_maxseg);
>  
>  /*
>   *	Socket option code for TCP.
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 9c4faa0d82ef..3e000436ab94 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -808,28 +808,6 @@ static int mptcp_setsockopt_first_sf_only(struct
> mptcp_sock *msk, int level, int
>  	return ret;
>  }
>  
> -static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int
> level,
> -				   int optname, sockptr_t optval,
> -				   unsigned int optlen)
> -{
> -	struct mptcp_subflow_context *subflow;
> -	int ret = 0;
> -
> -	mptcp_for_each_subflow(msk, subflow) {
> -		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> -		int err;
> -
> -		err = tcp_setsockopt(ssk, level, optname, optval,
> optlen);
> -		if (err < 0 && ret == 0)
> -			ret = err;
> -	}
> -
> -	if (!ret)
> -		sockopt_seq_inc(msk);
> -
> -	return ret;
> -}

This helper will also be used when implementing IPV6_TCLASS [1], so
don't delete it for now. Let's wait until IPV6_TCLASS is merged before
posting this patch.

Thanks,
-Geliang

[1]
https://patchwork.kernel.org/project/mptcp/patch/2617b8684039574734b8622936ef126d6a7cd519.1754986785.git.tanggeliang@kylinos.cn/

> -
>  static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int
> optname,
>  				    sockptr_t optval, unsigned int
> optlen)
>  {
> @@ -889,9 +867,8 @@ static int mptcp_setsockopt_sol_tcp(struct
> mptcp_sock *msk, int optname,
>  						 val);
>  		break;
>  	case TCP_MAXSEG:
> -		msk->maxseg = val;
> -		ret = mptcp_setsockopt_all_sf(msk, SOL_TCP, optname,
> optval,
> -					      optlen);
> +		ret = __mptcp_setsockopt_set_val(msk,
> &tcp_sock_set_maxseg,
> +						 &msk->maxseg, val);
>  		break;
>  	default:
>  		ret = -ENOPROTOOPT;
