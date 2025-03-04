Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F43BE4E
	for <mptcp@lists.linux.dev>; Tue,  4 Mar 2025 01:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741052590; cv=none; b=WGx+ZK9QEeZE2jOG7Z18TJugWUQ1MU49TE7CgBXcB8KCRbC9xucpar8RqHW9CsRrkpL5DqX+lFJSNnocqywm92BjF2sBcbur9JDDWkmMW3TYQzedIBtaD8iL7Uqn35PChSx/EHaDe/lolutcNl3ZexxdmMQRrL9F3Eoa/tbUmWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741052590; c=relaxed/simple;
	bh=fzt7CWKb1jor71u0yWbpC1QuzJFNTA+C8HNbTkYbawI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gXL8lu+Dedt6GepMttAncpMLVlQbQ/rkd6t7RCFN1QwA3VSVLr+wn7FHSikIrVG6uAC3OaYat0O7ZuI3j64SYOHw9lUbM8g6FRfb+ZeQ7MeguUNPMEz/jb3eCpH6UytDE5c2KChkYcbxB1bUw2sMhY2IAl4p9dxehryyd4hA7Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xu7Ca2CI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xu7Ca2CI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFE0C4CEE4;
	Tue,  4 Mar 2025 01:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741052589;
	bh=fzt7CWKb1jor71u0yWbpC1QuzJFNTA+C8HNbTkYbawI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Xu7Ca2CIu1Ols9J4JzTjOrzjNawrCGi4iedOd+EN/RM1z/KRhKMCfYNbJBbKoHk5m
	 XlC8grpPgrW2tust5E9hvinV4tLT7/NVIT8WodYzryrM3ATCOWUT3OmjW3McYedZOv
	 nergKmwf4iCq1eF0jrl3V1uQ4dG772Pu3xbpc+ZhGM9hqII0kF24gFsVvP13bJewHV
	 kpy5zuJqb7gMPVCw98GEIh3nn/IOADMsSKjHODQCVg3TsC+dVQuNexUqxv9+RegwVN
	 WpoFcuIXZ0kjxxw/ZWF4I9KTIGLZ5fvnkhQme8dQnDBi3EF6IinIc7++zxGon7BoEb
	 TInqcKNvZpVVg==
Date: Mon, 3 Mar 2025 17:43:09 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <geliang@kernel.org>
Subject: Re: [PATCH mptcp-next] mptcp: pm: split netlink and in-kernel init
In-Reply-To: <20250303-mptcp-pm-split-init-nl-kernel-v1-1-533c1575b5c2@kernel.org>
Message-ID: <f28aaca1-0114-9f77-7c83-57dc418a7398@kernel.org>
References: <20250303-mptcp-pm-split-init-nl-kernel-v1-1-533c1575b5c2@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 3 Mar 2025, Matthieu Baerts (NGI0) wrote:

> The registration of mptcp_genl_family is useful for both the in-kernel
> and the userspace PM. It should then be done in pm_netlink.c.
>
> On the other hand, the registration of the in-kernel pernet subsystem is
> specific to the in-kernel PM, and should stay there in pm_kernel.c.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> net/mptcp/pm.c         | 1 +
> net/mptcp/pm_kernel.c  | 5 +----
> net/mptcp/pm_netlink.c | 6 ++++++
> net/mptcp/protocol.h   | 1 +
> 4 files changed, 9 insertions(+), 4 deletions(-)

Hi Matthieu -

Looks good to me:

Reviewed-by: Mat Martineau <martineau@kernel.org>

>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 833839d7286e717599579356af3117f70e39de0a..8e6a325a389803196c35175cd5ea7637624d0ee2 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -1022,5 +1022,6 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
>
> void __init mptcp_pm_init(void)
> {
> +	mptcp_pm_kernel_register();
> 	mptcp_pm_nl_init();
> }
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index daf8f98a316439a67c12f63f2388ef497dae08dd..62ae68abb2cb0066a30a3fab88ae5f082c523413 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -1400,11 +1400,8 @@ static struct pernet_operations mptcp_pm_pernet_ops = {
> 	.size = sizeof(struct pm_nl_pernet),
> };
>
> -void __init mptcp_pm_nl_init(void)
> +void __init mptcp_pm_kernel_register(void)
> {
> 	if (register_pernet_subsys(&mptcp_pm_pernet_ops) < 0)
> 		panic("Failed to register MPTCP PM pernet subsystem.\n");
> -
> -	if (genl_register_family(&mptcp_genl_family))
> -		panic("Failed to register MPTCP PM netlink family\n");
> }
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index b2e5bbdcd5df920887ffbd9b6d652f422b32d49e..50aaf259959aeaf36e7ab954c6f7957eaf2bc390 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -625,3 +625,9 @@ struct genl_family mptcp_genl_family __ro_after_init = {
> 	.mcgrps		= mptcp_pm_mcgrps,
> 	.n_mcgrps	= ARRAY_SIZE(mptcp_pm_mcgrps),
> };
> +
> +void __init mptcp_pm_nl_init(void)
> +{
> +	if (genl_register_family(&mptcp_genl_family))
> +		panic("Failed to register MPTCP PM netlink family\n");
> +}
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 9bdfd915d62f52feb8e3f29f6f429dfa837f5f2b..bb9504e0510a1630d6903201d4fc8dcf7e47808e 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1152,6 +1152,7 @@ static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflo
> 	return local_id;
> }
>
> +void __init mptcp_pm_kernel_register(void);
> void __init mptcp_pm_nl_init(void);
> void mptcp_pm_worker(struct mptcp_sock *msk);
> void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
>
> ---
> base-commit: b084c48057bbf45fbedc06d7a9d4ec417992fb1e
> change-id: 20250303-mptcp-pm-split-init-nl-kernel-a9ec7d8d9756
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
