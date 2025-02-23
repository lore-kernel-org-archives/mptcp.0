Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B7C13C67C
	for <mptcp@lists.linux.dev>; Sun, 23 Feb 2025 16:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740329051; cv=none; b=Fhhx3IeqQWSjT6Z94Ft1MI/NlUrggSxiiyyYK4njtn95gZh9aHEfmnq/221xpVvpDEMttKxTCDFfpi5S5BSAS61e6LYdx+C3+JXzU6ePzFhSqtjgUC98beUQFrvguPZ+FZIyeloW3e7XV+jm/R4C/5kKJmjSXrRvBoaz52jW1R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740329051; c=relaxed/simple;
	bh=4GfAp2lnDXwaqm23iilRauGhgWAp4W0aLl0DOZoagAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUiaPze1/B3ZY3LcsvynP4RL4z+Vl/vCxYhBvZuxqBE9MdcZZYOfJQrMF7wjeqEVI/mGHyaVYCCl5/z3HPSul/gKAKZG3F/jCtEQPoyy2333kcR7E1HX3u+svB680ndf1+ESSV7JRsMps5oAQpHSVIEJUILF9ncbkMFhSW0ToYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lK9CVvGI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lK9CVvGI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22282C4CEDD;
	Sun, 23 Feb 2025 16:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740329050;
	bh=4GfAp2lnDXwaqm23iilRauGhgWAp4W0aLl0DOZoagAs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lK9CVvGIn20dABxJjQfzXbnPllK4iqgtRaE3FPKXEbG09+ku8MxJAKVX1J8/hRPxM
	 Sq83wBykaW6WvhLBlFC75LroPe6+dTGWdtqmdToATbYC+5FUAeNzyx/quFcPqxlo99
	 5+fDnQJJnVCnK5DltzbFqfDc+02f42JDcqzwcGSsPQ5FbCt5PJgELsJiVFpNLJpIVi
	 +HvKEGKiCa/O9vgu4rKWP8gNw4aH3Kt7emuPPwwPmhfPHFfixOuhGuJOzXljk47soE
	 tDe4eu068e7XgpkRDvUqQVgUyV0vUpJw5M2s/imO2lj6SmuLGX8as36Il6erFcpRhv
	 /Bk7Wgr7AlLFQ==
Message-ID: <f2992359-3706-4e4c-8789-0a6181ce8e6b@kernel.org>
Date: Sun, 23 Feb 2025 17:44:08 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v6 05/13] mptcp: pm: in-kernel: register
 mptcp_in_kernel_pm
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1740320007.git.tanggeliang@kylinos.cn>
 <31c3324f479d9a59c579d8cc3434aebf48eff252.1740320007.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <31c3324f479d9a59c579d8cc3434aebf48eff252.1740320007.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/02/2025 15:19, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch defines the original in-kernel netlink path manager as a new
> struct mptcp_pm_ops named "mptcp_in_kernel_pm", and register it in
> mptcp_pm_nl_init().
> 
> This mptcp_pm_ops will be skipped in mptcp_pm_unregister().
> 
> Only get_local_id() and get_priority() interfaces are implemented here.
> mptcp_pm_nl_is_backup() becomes a wrapper of get_priority().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm.c         |  3 +++
>  net/mptcp/pm_netlink.c | 18 +++++++++++++++++-
>  net/mptcp/protocol.h   |  2 ++
>  3 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 97fccd930cd0..07789526eecc 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -698,6 +698,9 @@ int mptcp_pm_register(struct mptcp_pm_ops *pm)
>  
>  void mptcp_pm_unregister(struct mptcp_pm_ops *pm)
>  {
> +	if (pm == &mptcp_in_kernel_pm)
> +		return;
> +
>  	spin_lock(&mptcp_pm_list_lock);
>  	list_del_rcu(&pm->list);
>  	spin_unlock(&mptcp_pm_list_lock);
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 69a2f7aa1825..aa9be671293d 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1169,7 +1169,8 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
>  	return ret;
>  }
>  
> -bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
> +static bool mptcp_pm_nl_get_priority(struct mptcp_sock *msk,
> +				     struct mptcp_addr_info *skc)
>  {
>  	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
>  	struct mptcp_pm_addr_entry *entry;
> @@ -1183,6 +1184,11 @@ bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
>  	return backup;
>  }
>  
> +bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
> +{
> +	return mptcp_pm_nl_get_priority(msk, skc);
> +}

Why do you need this helper simply calling mptcp_pm_nl_is_backup()? Why
not using mptcp_pm_nl_is_backup() directly?

Same for the userspace PM. No need to add an extra level.

> +
>  #define MPTCP_PM_CMD_GRP_OFFSET       0
>  #define MPTCP_PM_EV_GRP_OFFSET        1
>  
> @@ -2370,6 +2376,14 @@ static struct pernet_operations mptcp_pm_pernet_ops = {
>  	.size = sizeof(struct pm_nl_pernet),
>  };
>  
> +struct mptcp_pm_ops mptcp_in_kernel_pm = {
> +	.get_local_id		= mptcp_pm_nl_get_local_id,
> +	.get_priority		= mptcp_pm_nl_get_priority,
> +	.type			= MPTCP_PM_TYPE_KERNEL,

Do you need the type?

> +	.name			= "in-kernel",
> +	.owner			= THIS_MODULE,
> +};
> +
>  void __init mptcp_pm_nl_init(void)
>  {
>  	if (register_pernet_subsys(&mptcp_pm_pernet_ops) < 0)
> @@ -2377,4 +2391,6 @@ void __init mptcp_pm_nl_init(void)
>  
>  	if (genl_register_family(&mptcp_genl_family))
>  		panic("Failed to register MPTCP PM netlink family\n");
> +
> +	mptcp_pm_register(&mptcp_in_kernel_pm);
>  }
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 3c24e8e1bc13..2b1fd10b4b7e 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1048,6 +1048,8 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
>  void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
>  				struct mptcp_pm_addr_entry *entry);
>  
> +extern struct mptcp_pm_ops mptcp_in_kernel_pm;
> +
>  struct mptcp_pm_ops *mptcp_pm_find(const char *name);
>  int mptcp_pm_validate(struct mptcp_pm_ops *pm);
>  int mptcp_pm_register(struct mptcp_pm_ops *pm);

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

