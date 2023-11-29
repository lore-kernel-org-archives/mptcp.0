Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4724AF96
	for <mptcp@lists.linux.dev>; Wed, 29 Nov 2023 18:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6BZRwVA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FE5C433C7;
	Wed, 29 Nov 2023 18:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701281226;
	bh=LioWiE2hTNG/Fkt75yVvekD5H/p5BmUZtNouQArLOiE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=j6BZRwVAa80kSWIIxKGBBaD5RR50CXxtAOIh/RllrFXNfdCuK85Jr8/eIeRxpRjqF
	 TR2kZseOr3ADJmIldXbnaFH4tHmcSqcYBVrGshqUzB31LLZNj8MAtm0vxmwQl8H7Y1
	 oiA69hdJB53zzG+929Id2ImLpG9Sh34KkNSKlwVJ6GuUvZZlbsGFXoa/JWcfvvpeVx
	 VwvUpxQ7mFhA06CB2SSvzVaSeG1d0AISu7DalBM+slG1N/coW++q8s1lcd0Tc1iU3i
	 Yu7oARtrG4cfKgPW1B50gIrGsjn9Wt0xcOWQ0Nqxz9YRp2C+4XKNJ4AMYmjm+PRE4p
	 TgBZEYmSZLAiQ==
Date: Wed, 29 Nov 2023 10:07:05 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Maxim Galaganov <max@internet.ru>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next 1/3] mptcp: rename
 mptcp_setsockopt_sol_ip_set_transparent()
In-Reply-To: <20231129113403.157953-2-max@internet.ru>
Message-ID: <85e155a3-f804-4c3d-919a-cbf645c0414a@kernel.org>
References: <20231129113403.157953-1-max@internet.ru> <20231129113403.157953-2-max@internet.ru>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 29 Nov 2023, Maxim Galaganov wrote:

> Next patch extends this function so that it's not specific to
> IP_TRANSPARENT. Change function name to mptcp_setsockopt_sol_ip_set().
>
> Signed-off-by: Maxim Galaganov <max@internet.ru>

Reviewed-by: Mat Martineau <martineau@kernel.org>

> ---
> net/mptcp/sockopt.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index cabe856b2a45..a4bf337e6f77 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -683,8 +683,8 @@ static int mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, sockptr_t op
> 	return 0;
> }
>
> -static int mptcp_setsockopt_sol_ip_set_transparent(struct mptcp_sock *msk, int optname,
> -						   sockptr_t optval, unsigned int optlen)
> +static int mptcp_setsockopt_sol_ip_set(struct mptcp_sock *msk, int optname,
> +				       sockptr_t optval, unsigned int optlen)
> {
> 	struct sock *sk = (struct sock *)msk;
> 	struct sock *ssk;
> @@ -755,7 +755,7 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
> 	switch (optname) {
> 	case IP_FREEBIND:
> 	case IP_TRANSPARENT:
> -		return mptcp_setsockopt_sol_ip_set_transparent(msk, optname, optval, optlen);
> +		return mptcp_setsockopt_sol_ip_set(msk, optname, optval, optlen);
> 	case IP_TOS:
> 		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
> 	}
> -- 
> 2.43.0
>
>
>
