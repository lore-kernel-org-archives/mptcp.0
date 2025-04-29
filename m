Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097641E515
	for <mptcp@lists.linux.dev>; Tue, 29 Apr 2025 11:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745925457; cv=none; b=sKHXXLv8hHxLSczUEJbek3cqV/Bh41H++rs/o18aF0/5LDlTvVrM+0HgUdY60G4+1CYFy/k5DRl0P1Ku93E90j7NaZ4k4jG4x308eqBhB1udvORFbISh93uyQyxNW7Rzmieldg32jhPj7zocKhrmenNdqmU/Z4fLmnG/FrZIEbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745925457; c=relaxed/simple;
	bh=SaTXvPxxOMhSwC0R4jloirdDYn0T6p9nO8TdIWyRq54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gYBZ+XuwMZG2UPJ7y15wCaneRs0sDOBGgZ1ob4v7IU9+1O4EHa2isfMDzZhgf0mEtr4jkrWLd+5lY/kQEB2/7+i9rymTeBmxrlNsj4hDhAaFuMyhPWBuVA5qpySxwOeRML1lcAi92pPVKpFJE+JsjvFNZmABPMwCVWJHB0c9Hlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gG9IUFCD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gG9IUFCD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FDCC4CEE3;
	Tue, 29 Apr 2025 11:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745925456;
	bh=SaTXvPxxOMhSwC0R4jloirdDYn0T6p9nO8TdIWyRq54=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gG9IUFCDBPNG6f2lpQL4pOelKbAOuPRfb/Rh5F7HfxB+NL2eamOsqQ9WohD91DHyg
	 aDwOMXYWWQRO7TVr63/8AOUXOATy2CGiX0CXGBO+31+j7DgYKaLtyFADG4DLMDgyiO
	 Jocq7Z//pl+gS82Ec0aznX3xkK66l7gxVUk9Sa4vsr8cMrflUdgWMmnUdF/UD2COKW
	 WE8uODN0bSa/aBIRUUNZVWGLaVYWmJEflUdJ/tQoGQ54UHmHZQkQ/PYmOfvPAzlhkN
	 mfprf7xfY+MtRcNuzYRI6YJDPtrLVa2ctvCVRRty+E7zCK35RDbCMCJ3xr2tjyeG7z
	 6IoK2860SrUWw==
Message-ID: <2458838f-f9dd-45e6-ba1d-669720a1283d@kernel.org>
Date: Tue, 29 Apr 2025 13:17:33 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 2/3] mptcp: add TCP_MAXSEG sockopt support
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1745401025.git.tanggeliang@kylinos.cn>
 <8160ae5fd83c0815cee2f5998948199200574bc7.1745401025.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <8160ae5fd83c0815cee2f5998948199200574bc7.1745401025.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 23/04/2025 11:40, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The TCP_MAXSEG socket option is currently not supported by MPTCP, mainly
> because it has never been requested before. But there are still valid
> use-cases, e.g. with HAProxy.
> 
> This patch adds its support in MPTCP by propagating the value to all
> subflows.
> 
> Similar to mptcp_setsockopt_first_sf_only(), a generic helper
> mptcp_setsockopt_all_subflows() is added to set sockopt for each
> subflows of the mptcp socket.
> 
> Add a new member for struct mptcp_sock to store the TCP_MAXSEG value,
> and return this value in getsockopt.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/515
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/protocol.h |  1 +
>  net/mptcp/sockopt.c  | 24 ++++++++++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 64aa091cb685..91aaed17fe56 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -327,6 +327,7 @@ struct mptcp_sock {
>  	int		keepalive_cnt;
>  	int		keepalive_idle;
>  	int		keepalive_intvl;
> +	int		maxseg;
>  	struct work_struct work;
>  	struct sk_buff  *ooo_last_skb;
>  	struct rb_root  out_of_order_queue;
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 3caa0a9d3b38..a7992cbc5ed9 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -798,6 +798,22 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
>  	return ret;
>  }
>  
> +static int mptcp_setsockopt_all_subflows(struct mptcp_sock *msk, int level, int optname,
> +					 sockptr_t optval, unsigned int optlen)
> +{
> +	struct mptcp_subflow_context *subflow;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +		int ret = 0;
> +
> +		ret = tcp_setsockopt(ssk, level, optname, optval, optlen);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
>  static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
>  				    sockptr_t optval, unsigned int optlen)
>  {
> @@ -859,6 +875,11 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
>  						 &msk->keepalive_cnt,
>  						 val);
>  		break;
> +	case TCP_MAXSEG:
> +		msk->maxseg = val;
> +		ret = mptcp_setsockopt_all_subflows(msk, SOL_TCP, optname,
> +						    optval, optlen);
> +		break;
>  	default:
>  		ret = -ENOPROTOOPT;
>  	}
> @@ -1407,6 +1428,8 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
>  		return mptcp_put_int_option(msk, optval, optlen, msk->notsent_lowat);
>  	case TCP_IS_MPTCP:
>  		return mptcp_put_int_option(msk, optval, optlen, 1);
> +	case TCP_MAXSEG:
> +		return mptcp_put_int_option(msk, optval, optlen, msk->maxseg);

I just checked what TCP is doing, and I see that this is different: with
TCP, the cached MSS is returned when the connection is not closed (and
something else for TCP_REPAIR). We should then do the same.

Should we then simply call mptcp_getsockopt_first_sf_only()?

>  	}
>  	return -EOPNOTSUPP;
>  }
> @@ -1553,6 +1576,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
>  	tcp_sock_set_keepidle_locked(ssk, msk->keepalive_idle);
>  	tcp_sock_set_keepintvl(ssk, msk->keepalive_intvl);
>  	tcp_sock_set_keepcnt(ssk, msk->keepalive_cnt);
> +	tcp_sock_set_maxseg(ssk, msk->maxseg);
>  
>  	inet_assign_bit(TRANSPARENT, ssk, inet_test_bit(TRANSPARENT, sk));
>  	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

