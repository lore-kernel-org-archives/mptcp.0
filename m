Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0FD241666
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741175476; cv=none; b=pz0YxGI7aYwUdlspbZqEDOfGRY4tURALpk9fPgU5FyvqfPT+1MbZhtoRXMMGx9Lcw/GwaX4aP02L8ItXNHLy9IDNvr4WFcdO8COqD7VTd8h4zyEJel6sdNc49RAZnBaELar1G6msjV9tPkk2WEZEMPp7lJ18omxvvd4BGRx1ycc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741175476; c=relaxed/simple;
	bh=rWCT7doCl+1N1YwejA3i/KrlnLK2Lo0hoz29nXJgRwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cwRwBlhTq9KAV9Q08P6DOiWYJhDQUwphcgz461vXNckLwb8Z57riN3UDzl68Ema0vzqAw9NlxtQr7fhxS3ljblYfLN8ujhigopxx9SeVh5dvw/QFG0xSQg7EGUSP3+ewiEY7qcgEjhdm0Pkawdl5M3sTYTVlNK5b/YMsU+ZciHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFc1u3mg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFc1u3mg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3623FC4CEE2;
	Wed,  5 Mar 2025 11:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741175475;
	bh=rWCT7doCl+1N1YwejA3i/KrlnLK2Lo0hoz29nXJgRwY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MFc1u3mgdh6PqL8bK1JiZUGtFdHhIw8ItDFkgK0gNnXhOC7GpircSyEarD6J7bw/b
	 d1Cro+jBNJ4ExvUoQZQQ6F5XJfASfUIN5Y0hg7w3qQG2RNSOCxU/BIQE4O4b3TxRAc
	 1MM4wyV0MMnf6LgRNFjzCXUQPfOpEj1NLN+lI4dRBM2Gi7ks3m2QDVo6M8YPLQi1xb
	 e1qoZifyd3Etp4FxDZ9pRxzFKx8dFBR3uKSIWodDoqF12rMuag+2nbEJS1bjenFUGl
	 02y4l0nZT9xx8fk16TQVvfThCcUvdlvNirtmUr+jboMJ5cldZRucmYdquk90LiPoD3
	 sADiz6FRFj+3A==
Message-ID: <02398941-0bb7-4156-a286-536db728c411@kernel.org>
Date: Wed, 5 Mar 2025 12:51:13 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v8 06/12] mptcp: pm: in-kernel: register
 mptcp_pm_kernel
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1741088339.git.tanggeliang@kylinos.cn>
 <818c00e2242d2f76604c6d70176ab6fa94d7eaa5.1741088339.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <818c00e2242d2f76604c6d70176ab6fa94d7eaa5.1741088339.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 04/03/2025 12:40, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch defines the original in-kernel netlink path manager as a
> new struct mptcp_pm_ops named "mptcp_pm_kernel", and register it in
> mptcp_pm_kernel_register().
> 
> This mptcp_pm_ops will be skipped in mptcp_pm_unregister().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm.c        |  4 ++++
>  net/mptcp/pm_kernel.c | 26 ++++++++++++++++++++++++++
>  net/mptcp/protocol.h  |  3 +++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index a2b210873b23..28ea8bdaa8b0 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -1076,6 +1076,10 @@ int mptcp_pm_register(struct mptcp_pm_ops *pm)
>  
>  void mptcp_pm_unregister(struct mptcp_pm_ops *pm)
>  {
> +	/* skip unregistering the default path manager */

Please see my questions from v7: why this skip?

When looking at this, I can understand that we don't want to unregister
built-in modules and the default one, but:

- When are we going to that? mptcp_pm_unregister() is still unused in
this series.

- Why would we want to unregister the userspace PM as well?

It makes sense to have an exception for the default one, but it feels
like we should simply not try to unregister the in-kernel ones. In other
words, there is probably no need to have such exceptions because
mptcp_pm_unregister() should never be called with the built-in PMs. In
this case, maybe we could add a WARN_ON_ONCE()?

  if (WARN_ON_ONCE(pm == &mptcp_pm_kernel))
       return;

(or something else if we need to catch the userspace PM as well, e.g.
pm->built_in, but that should not be needed)


> +	if (pm == &mptcp_pm_kernel)
> +		return;
> +
>  	spin_lock(&mptcp_pm_list_lock);
>  	list_del_rcu(&pm->list);
>  	spin_unlock(&mptcp_pm_list_lock);
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index 806a9b5b3c07..e6a1aef738a8 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -1398,8 +1398,34 @@ static struct pernet_operations mptcp_pm_pernet_ops = {
>  	.size = sizeof(struct pm_nl_pernet),
>  };
>  
> +static void mptcp_pm_nl_initialize(struct mptcp_sock *msk)
> +{
> +	bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
> +	struct mptcp_pm_data *pm = &msk->pm;
> +
> +	/* pm->work_pending must be only be set to 'true' when
> +	 * pm is the default path manager
> +	 */
> +	WRITE_ONCE(pm->work_pending,
> +		   (!!mptcp_pm_get_local_addr_max(msk) &&
> +		    subflows_allowed) ||
> +		   !!mptcp_pm_get_add_addr_signal_max(msk));
> +	WRITE_ONCE(pm->accept_addr,
> +		   !!mptcp_pm_get_add_addr_accept_max(msk) &&
> +		   subflows_allowed);
> +	WRITE_ONCE(pm->accept_subflow, subflows_allowed);

It might feel clearer to add this helper in patch 8 ("mptcp: pm:
initialize and release mptcp_pm_ops"), to understand you are moving
existing code here.

If you do that, then maybe better to squash the existing patches 6
("mptcp: pm: in-kernel: register mptcp_pm_kernel") and 7 ("mptcp: pm:
userspace: register mptcp_pm_userspace"), no?

  mptcp: pm: register in-kernel and userspace PM


> +}
> +
> +struct mptcp_pm_ops mptcp_pm_kernel = {
> +	.init			= mptcp_pm_nl_initialize,
> +	.name			= "kernel",
> +	.owner			= THIS_MODULE,
> +};
> +
>  void __init mptcp_pm_kernel_register(void)
>  {
>  	if (register_pernet_subsys(&mptcp_pm_pernet_ops) < 0)
>  		panic("Failed to register MPTCP PM pernet subsystem.\n");
> +
> +	mptcp_pm_register(&mptcp_pm_kernel);
>  }
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 246b44db9775..f700cb55bf49 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1050,6 +1050,9 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
>  void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
>  				struct mptcp_pm_addr_entry *entry);
>  
> +/* the default path manager, used in mptcp_pm_unregister */
(to be adapted if it is no longer used there. Or: mptcp_pm_initialize)

Or maybe better: it could be exported in patch 8 ("mptcp: pm: initialize
and release mptcp_pm_ops").

> +extern struct mptcp_pm_ops mptcp_pm_kernel;
> +
>  struct mptcp_pm_ops *mptcp_pm_find(const char *name);
>  int mptcp_pm_validate(struct mptcp_pm_ops *pm);
>  int mptcp_pm_register(struct mptcp_pm_ops *pm);

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

