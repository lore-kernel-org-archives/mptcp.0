Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C72E2853E9
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 01:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780018519; cv=none; b=OFZgwwMa6f3m69/3TwQf59rjpb8ztrbq7U5uS2JH84MamaQmCT3eF7Oxg/5ShDOgWrm3VbNDw0DhB2F7eza7YzpvoMzeVet1Wfqjg25oJbuzwGynXe3nVZygQu+5/w4+9jR4XkhVE1sGY+LTzBBpolDFEx2WtJK97Mh3GeShjxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780018519; c=relaxed/simple;
	bh=8GybPtfQ9v4sauOCmHc2pxyoeQwZucgAWSctO/Fqv6c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VoeHMgTvDJ5nn8oTcB5PxcxTKqbvJGXqhhMLW5nXCAqjna7k49l3zCfkvZvzOFhoQnBfopDpTveLm6BNwXX+tKLx/0i26cFLB3+PQzrLl15/DO5l8dB2olhMyJmUXwimJwnB2bm7CCvPRi/bEARmKSTIctQ8Fv4Jp3KH+T/SqDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/oqdhGo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/oqdhGo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4114B1F000E9;
	Fri, 29 May 2026 01:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780018518;
	bh=AMIH2vV8nSueOUT65mCyBEb5b5vCEud+Tg+NXsIeoYM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=G/oqdhGoAS9/VS31qMYJuSUHe4EvG/vopBencIPV78dXAr79eWOlIWnW6r01pIlWm
	 ivb+59iRTJI2HMYx8m5R4HXIxZEeGrCI3QZhuB9/qh/bf2LIfEe2sMWGWTNGZuaNx6
	 LaKrbK5/XqJ9hyIWYPXKMAkrZm5pZLtkmiU1qZfWImKXjhwLChUOW/dkymPhSjPz86
	 He6jXvytQtE5+8KF0KfuyMIpieXT9c9/afYEC5k1HiPQ1XbA3ZhvkxLmPXOgeDgbHZ
	 qQOWtKHb+FHgDnspP7FoNJm2qB/qXUxsML0/Vs0E+WrsVfj/N4c5ad5WsTEhRfOI/v
	 0bg7s/DkCSGIA==
Date: Thu, 28 May 2026 18:35:17 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net] mptcp: sockopt: check timestamping ret value
In-Reply-To: <20260527-mptcp-sockopt-timestamping-ret-v1-1-8eda97e24562@kernel.org>
Message-ID: <d0660d1a-b217-17ce-199f-dad0b65fd25c@kernel.org>
References: <20260527-mptcp-sockopt-timestamping-ret-v1-1-8eda97e24562@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 27 May 2026, Matthieu Baerts (NGI0) wrote:

> sock_set_timestamping() can fail for different reasons. The returned
> value should then be checked.
>
> If sock_set_timestamping() fails for at least one subflow, the first
> error is now reported to the userspace, similar to what is done with
> other socket options.
>
> Fixes: 9061f24bf82e ("mptcp: sockopt: propagate timestamp request to subflows")
> Reported-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Closes: https://lore.kernel.org/willemdebruijn.kernel.178a41a53d041@gmail.com
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> net/mptcp/sockopt.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 87b5796d0135..91aa57f1d0fd 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -241,15 +241,19 @@ static int mptcp_setsockopt_sol_socket_timestamping(struct mptcp_sock *msk,
>
> 	mptcp_for_each_subflow(msk, subflow) {
> 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +		int err;
>
> 		lock_sock(ssk);
> -		sock_set_timestamping(ssk, optname, timestamping);
> +		err = sock_set_timestamping(ssk, optname, timestamping);
> 		release_sock(ssk);
> +
> +		if (err < 0 && ret == 0)
> +			ret = err;
> 	}
>
> 	release_sock(sk);
>
> -	return 0;
> +	return ret;
> }
>
> static int mptcp_setsockopt_sol_socket_linger(struct mptcp_sock *msk, sockptr_t optval,
>
> ---
> base-commit: 599cb099e01efc713c7c120654ebd9fb49ac2782
> change-id: 20260527-mptcp-sockopt-timestamping-ret-e2029bf0f24a
>

Looks good to me, thanks Matthieu

Reviewed-by: Mat Martineau <martineau@kernel.org>

