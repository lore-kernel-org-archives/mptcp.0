Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D4915A5
	for <mptcp@lists.linux.dev>; Sat,  6 Jan 2024 00:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9mCfg9Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E0AC433C7;
	Sat,  6 Jan 2024 00:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704502751;
	bh=lzrzkLg6GVdisrw+zcz9wArg39q8G3hb7PdlemnH7cE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=f9mCfg9Z4zQYrdxMC/QE6mfUqSTx4oOaMTewuj2bYhrXlYw+eKqeBKPNSENzL4VHf
	 28lNMvdO5zSu6SnamNmCH0o1EZ7MjJWeo7aw/kQNGlp4rg7M5AKkU2ZycK+DlafpRQ
	 0qaz4AuiH2D0U+3ds32/3rSrGFoGQU/Trf9UP9BAwB8kyIneWHO1RBFI8jUSMNAuJ0
	 /8rc/HaEWyjRUpdvRqTyFACF9HYAvy1KJuUH2sz+m5pRoyIpy3aqkaA2JFnUO3o2rI
	 oc+CbF9mlS2JrTD9moBymxqFD/clRDM6Tk72cg642ozLFzkFMma3AEFoAijgHrcT4f
	 eUyD3RfMIL+XQ==
Date: Fri, 5 Jan 2024 16:59:10 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@linux.dev>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v7 05/24] mptcp: map v4 address to v6 when
 destroying subflow
In-Reply-To: <d7339002bfb57e08c1192c24e1e4c60c92e2abd3.1703904325.git.geliang.tang@linux.dev>
Message-ID: <9c135580-84c5-58a5-3160-42e23a0ddae6@kernel.org>
References: <cover.1703904325.git.geliang.tang@linux.dev> <d7339002bfb57e08c1192c24e1e4c60c92e2abd3.1703904325.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Sat, 30 Dec 2023, Geliang Tang wrote:

> In mptcp_pm_nl_subflow_destroy_doit(), before checking local address
> family with remote address family, map an IPv4 address to an IPv6 address
> if the pair is a v4-mapped address.
>

Hi Geliang -

The code looks good, thanks. For the commit message, can you add some more 
detail about the problem that is being fixed? Is there a github issue to 
link?

- Mat

> Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
> Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
> ---
> net/mptcp/pm_userspace.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index c592536b9889..9df643373c39 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -499,6 +499,16 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
> 		goto destroy_err;
> 	}
>
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	if (addr_l.family == AF_INET && ipv6_addr_v4mapped(&addr_r.addr6)) {
> +		ipv6_addr_set_v4mapped(addr_l.addr.s_addr, &addr_l.addr6);
> +		addr_l.family = AF_INET6;
> +	}
> +	if (addr_r.family == AF_INET && ipv6_addr_v4mapped(&addr_l.addr6)) {
> +		ipv6_addr_set_v4mapped(addr_r.addr.s_addr, &addr_r.addr6);
> +		addr_r.family = AF_INET6;
> +	}
> +#endif
> 	if (addr_l.family != addr_r.family) {
> 		GENL_SET_ERR_MSG(info, "address families do not match");
> 		err = -EINVAL;
> -- 
> 2.39.2
>
>
>
