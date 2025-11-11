Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B1F2459EA
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 07:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845901; cv=none; b=gNFa8AOT4URT6oegRdodzgLR8ZzM1XdtSOFfH5oDesPEausuqoc2dMcMamnp1o9ZM/iKktVnMb+0GG8MNi7tv5ymI2DOMAlwVc9U/cM4DbhoNZ7ZT1PkWc0ngZz6tDazz0PxQjOTsRq52szmXNPanwd9UBxyOiJ2AQ6uL/VB/kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845901; c=relaxed/simple;
	bh=THoz6u2y7rM4Q5mgpcCkXd2Y5DOiBoPMA/kG9Hhlu3E=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j8XclODMXMFICEY61QpeHy0fEphXaB3Sso/7NYfxVYuHD2iOECbuYL0W7aho3AYu39VrTxXyHf5dxdpDzWTB8/5vVnN/b6F95fFH9srtxnZX8IBhj3h7aGKDrBEJBdUIj55NBMx5IbynMKg3OaN/c5E2nUKfUrQ0K90qgdsqubg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdyFjYZt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdyFjYZt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C8DC2BC86;
	Tue, 11 Nov 2025 07:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762845899;
	bh=THoz6u2y7rM4Q5mgpcCkXd2Y5DOiBoPMA/kG9Hhlu3E=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=TdyFjYZt35fhBPDU4tSOof3xvgNdMnnlvKfDTe2Dmol6hyTEMHwuR51xFT94+JMh7
	 NHSKQI09j/u6hrSqza+XM7koruytqRwK4VMH3X3JoVjjoF0UqJuuCu+EpbB1OXl1XD
	 sT2Y0461UERQ+CO+FpjFl0W6Bssw3Ytkie0IKgtIWdaXiZIDv8CqTkzScWmt0IfvVK
	 F5lcboyWXSt+zJb92Ab/KKTvHcgqeq3hB2u5SyZhTNWI3akfyAaWELq+omrh+v0ax2
	 kfPtU3YTUbn5CuJZctNF2yOTNLmt/Yq5L4S8YlGnZPg6+KPvmC+cE6p37IeF/xwl88
	 nch/HpewZNXhA==
Message-ID: <e9a05dbbd8030cd12d280b19d9f5fe119926323c.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 2/3] mptcp: factor-out cgroup data inherit
 helper
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Tue, 11 Nov 2025 15:24:57 +0800
In-Reply-To: <60403f2c512fa05217c72b2d0d840bad3f60d402.1762551942.git.pabeni@redhat.com>
References: <cover.1762551942.git.pabeni@redhat.com>
	 <60403f2c512fa05217c72b2d0d840bad3f60d402.1762551942.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

On Fri, 2025-11-07 at 22:55 +0100, Paolo Abeni wrote:
> MPTCP will soon need the same functionality for passive sockets,
> factor them out in a common helper. No functional change intended.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

This patch looks good to me.

    Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
>  net/mptcp/protocol.h |  2 ++
>  net/mptcp/subflow.c  | 20 ++++++++++++--------
>  2 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 051f21b06d33..300ac7030958 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -755,6 +755,8 @@ mptcp_subflow_delegated_next(struct
> mptcp_delegated_action *delegated)
>  	return ret;
>  }
>  
> +void __mptcp_inherit_cgrp_data(struct sock *sk, struct sock *ssk);
> +
>  int mptcp_is_enabled(const struct net *net);
>  unsigned int mptcp_get_add_addr_timeout(const struct net *net);
>  int mptcp_is_checksum_enabled(const struct net *net);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 60f100b2a0c9..599a21d92590 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1721,21 +1721,25 @@ int __mptcp_subflow_connect(struct sock *sk,
> const struct mptcp_pm_local *local,
>  	return err;
>  }
>  
> -static void mptcp_attach_cgroup(struct sock *parent, struct sock
> *child)
> +void __mptcp_inherit_cgrp_data(struct sock *sk, struct sock *ssk)
>  {
>  #ifdef CONFIG_SOCK_CGROUP_DATA
> -	struct sock_cgroup_data *parent_skcd = &parent-
> >sk_cgrp_data,
> -				*child_skcd = &child->sk_cgrp_data;
> +	struct sock_cgroup_data *sk_cd = &sk->sk_cgrp_data,
> +				*ssk_cd = &ssk->sk_cgrp_data;
>  
>  	/* only the additional subflows created by kworkers have to
> be modified */
> -	if (cgroup_id(sock_cgroup_ptr(parent_skcd)) !=
> -	    cgroup_id(sock_cgroup_ptr(child_skcd))) {
> -		cgroup_sk_free(child_skcd);
> -		*child_skcd = *parent_skcd;
> -		cgroup_sk_clone(child_skcd);
> +	if (cgroup_id(sock_cgroup_ptr(sk_cd)) !=
> +	    cgroup_id(sock_cgroup_ptr(ssk_cd))) {
> +		cgroup_sk_free(ssk_cd);
> +		*ssk_cd = *sk_cd;
> +		cgroup_sk_clone(sk_cd);
>  	}
>  #endif /* CONFIG_SOCK_CGROUP_DATA */
> +}
>  
> +static void mptcp_attach_cgroup(struct sock *parent, struct sock
> *child)
> +{
> +	__mptcp_inherit_cgrp_data(parent, child);
>  	if (mem_cgroup_sockets_enabled)
>  		mem_cgroup_sk_inherit(parent, child);
>  }

