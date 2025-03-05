Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBCA1428E7
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 01:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741138507; cv=none; b=JO40sySNZKkcBg9GC8ylE9o5YbJSBIVlPHtlii6XwlXYwROrmgMFJQx4GfNjvLTO4oThnjpdwEUI8skpsAdjn1Xb1+moYYEvsgi0epRAYGflee9kQROn5A2ilkMtZ6YDofv0bY4fLV/PV3ofLVT0SYsmju5kwo5dgtRnOKGP+7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741138507; c=relaxed/simple;
	bh=7tA5QyXeVS2DSxqWSuX41hiJ4VJd38h9VCKmwlmLzSc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Unqu6geHZ8V5Yu1mOp0eiQv5BjuUkcxA3BG4PniFh2jc8xuI/aFHdyuyqLbPR14dWO19PXvn8v0ErsgnBtvuK9BNXwwWqxfNpiMrYkTcEjM9nGvIax7/bHhRegfj0quHXTYzcEF70/dz5z+QJp17+UD+wSEzhBKxjd3WxbvtHzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgGMV2Ys; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgGMV2Ys"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01757C4CEE5;
	Wed,  5 Mar 2025 01:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741138506;
	bh=7tA5QyXeVS2DSxqWSuX41hiJ4VJd38h9VCKmwlmLzSc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=IgGMV2YsKcQ6fkve8J7a1A7WS2M+Nq4DgjAlxz8GJmRA/UfQKWM5xCZPCp56cVH4X
	 4IreH513PNLfSzrWPo8Vxr0BTuqQvNAL9Rsa2jIOXl2ljy/sZ3h8PCyQ5A6oRm1Dbn
	 HVGrIhElkrQkK/ltDWAtiad7k4sGyKAHIt+kBslS8o3VQCWFtJ+R4TtpFePkeqG+HS
	 /mYirjExnnSW0D+/4kCV6N6a1YRR/rMaOeUiM7pZeLKOYK+S/e7Ode1rlDpbyfQcaO
	 72bkdzVyg6nhF+iFt7XQBI55WhE7OqZLk8xS09Srfq9A1PEb8VA1BVylSfPB/AqlVk
	 q7/9hRxT0maeQ==
Message-ID: <e4ed726a27e8b7564ca33833dcbe735fc158f157.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v8 06/12] mptcp: pm: in-kernel: register
 mptcp_pm_kernel
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 05 Mar 2025 09:35:00 +0800
In-Reply-To: <818c00e2242d2f76604c6d70176ab6fa94d7eaa5.1741088339.git.tanggeliang@kylinos.cn>
References: <cover.1741088339.git.tanggeliang@kylinos.cn>
	 <818c00e2242d2f76604c6d70176ab6fa94d7eaa5.1741088339.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Tue, 2025-03-04 at 19:40 +0800, Geliang Tang wrote:
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
>  net/mptcp/pm.c        |  4 ++++
>  net/mptcp/pm_kernel.c | 26 ++++++++++++++++++++++++++
>  net/mptcp/protocol.h  |  3 +++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index a2b210873b23..28ea8bdaa8b0 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -1076,6 +1076,10 @@ int mptcp_pm_register(struct mptcp_pm_ops *pm)
>  
>  void mptcp_pm_unregister(struct mptcp_pm_ops *pm)
>  {
> +	/* skip unregistering the default path manager */
> +	if (pm == &mptcp_pm_kernel)
> +		return;
> +
>  	spin_lock(&mptcp_pm_list_lock);
>  	list_del_rcu(&pm->list);
>  	spin_unlock(&mptcp_pm_list_lock);
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index 806a9b5b3c07..e6a1aef738a8 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -1398,8 +1398,34 @@ static struct pernet_operations
> mptcp_pm_pernet_ops = {
>  	.size = sizeof(struct pm_nl_pernet),
>  };
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
> +		   (!!mptcp_pm_get_local_addr_max(msk) &&
> +		    subflows_allowed) ||
> +		   !!mptcp_pm_get_add_addr_signal_max(msk));
> +	WRITE_ONCE(pm->accept_addr,
> +		   !!mptcp_pm_get_add_addr_accept_max(msk) &&
> +		   subflows_allowed);
> +	WRITE_ONCE(pm->accept_subflow, subflows_allowed);
> +}
> +
> +struct mptcp_pm_ops mptcp_pm_kernel = {
> +	.init			= mptcp_pm_nl_initialize,

A better name would be mptcp_pm_nl_init, but this is already used in
pm_netlink.c. I would like to rename mptcp_pm_nl_init in pm_netlink.c
to mptcp_pm_genl_init, do you think this is a good idea?

If so, is it better to squash this renaming into "mptcp: pm: split
netlink and in-kernel init" or make it a separate patch?

Thanks,
-Geliang

> +	.name			= "kernel",
> +	.owner			= THIS_MODULE,
> +};
> +
>  void __init mptcp_pm_kernel_register(void)
>  {
>  	if (register_pernet_subsys(&mptcp_pm_pernet_ops) < 0)
>  		panic("Failed to register MPTCP PM pernet
> subsystem.\n");
> +
> +	mptcp_pm_register(&mptcp_pm_kernel);
>  }
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 246b44db9775..f700cb55bf49 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1050,6 +1050,9 @@ int mptcp_pm_remove_addr(struct mptcp_sock
> *msk, const struct mptcp_rm_list *rm_
>  void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
>  				struct mptcp_pm_addr_entry *entry);
>  
> +/* the default path manager, used in mptcp_pm_unregister */
> +extern struct mptcp_pm_ops mptcp_pm_kernel;
> +
>  struct mptcp_pm_ops *mptcp_pm_find(const char *name);
>  int mptcp_pm_validate(struct mptcp_pm_ops *pm);
>  int mptcp_pm_register(struct mptcp_pm_ops *pm);

