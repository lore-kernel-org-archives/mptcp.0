Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AAB25DD13
	for <mptcp@lists.linux.dev>; Mon, 24 Mar 2025 11:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742814170; cv=none; b=XLaVCUdUm9eQ4owe3uU0Mit3izUgpRH5V08pKnzGMKM8kAZmSucgjqTs/VIkCs6K9a1coIjiZrD8gsudkIBNeyBmIU3b94sfZJouqsGG2C2EfGd8iYFQ/idCyY6Oii3aPKS6RnZEL3gutaW6vnPLj3xoNLw4OL3yuGTZjeorT3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742814170; c=relaxed/simple;
	bh=CiWP0rAiwodXe1J/boh0M4jwTLWbK3/9LUU8XKi0Eiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PI+Pgnet3uUg4stdCEiyviCoj5YZEM2Y1xoMjUcYY88u3YkHQqdGt0l0+OL/pwbnXIXHE/6dyaVAYUcrGSeFJiLru5Yp0/Y82G+y2xbfrv2lgo+/j6/RLmJ/LzCtXJ5Bv00NdCfpeh6s1U+Y16EA7XtVi/rb+8plDwTE9R7KLNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJm7SIOw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJm7SIOw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB51C4CEF0;
	Mon, 24 Mar 2025 11:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742814169;
	bh=CiWP0rAiwodXe1J/boh0M4jwTLWbK3/9LUU8XKi0Eiw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OJm7SIOwS27UqBRRZVY3JxWnOJTzhhsVdnot/camI9yM2wZn0zVIGGzDU6ZiLsfaI
	 Xc4xN1d7iy3nkhXApPt7w7+dZnibhmthGR7riBpENV2iUOinpE6zoKnR0rGHZMFAJL
	 lvQgY4TuTKt3QrstAXBHWhEGOyzEN2qpQWKZCcIzufFy9ztQnQkQGRlwuP8x2GR8k+
	 oJNGSJlgLRdNCSwAEB5oaxyjwPwBAL0E/p9zOmw5LVA2lY69V1G1WH3gCXcFeCESaz
	 bfxqoqtjL9srSngNDyGYLgVNAxsGefdRgavZbXkNr7CUumqz6i5WNFN6n/JRwy1eUb
	 G9AzI6zrJduPw==
Message-ID: <fafc3aab-34f9-4fa6-b7e4-0b6712985933@kernel.org>
Date: Mon, 24 Mar 2025 12:02:47 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v4 8/9] mptcp: pm: add accept_new_subflow()
 interface
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1742804266.git.tanggeliang@kylinos.cn>
 <44138a92dbf1965a898c209d70ec32c34f784f9b.1742804266.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <44138a92dbf1965a898c209d70ec32c34f784f9b.1742804266.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/03/2025 09:19, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The helper mptcp_pm_is_userspace() is used to distinguish userspace PM
> operations from in-kernel PM in mptcp_can_accept_new_subflow(). It seems
> reasonable to add a mandatory .accept_new_subflow interface for struct
> mptcp_pm_ops.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  include/net/mptcp.h      |  1 +
>  net/mptcp/pm.c           | 31 +++++++++++--------------------
>  net/mptcp/pm_kernel.c    |  6 ++++++
>  net/mptcp/pm_userspace.c |  6 ++++++
>  net/mptcp/subflow.c      |  4 +---
>  5 files changed, 25 insertions(+), 23 deletions(-)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 18d3679a752c..8c1ac7368693 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -133,6 +133,7 @@ struct mptcp_pm_ops {
>  	/* required */
>  	bool (*add_addr_echo)(struct mptcp_sock *msk,
>  			      const struct mptcp_addr_info *addr);
> +	bool (*accept_new_subflow)(const struct mptcp_sock *msk);

Similar to get_local_id() and get_priority(), I guess this callback will
be triggered from the subflow context, and not the msk context, right?

Detail: probably we should gather them together in this structure, with
an additional comment clearly mentioning in which context the callbacks
will be called.

>  	char			name[MPTCP_PM_NAME_MAX];
>  	struct module		*owner;
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index d37f89bf0180..ca105bbd03ea 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -454,33 +454,24 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
>  {
>  	struct mptcp_pm_data *pm = &msk->pm;
>  	unsigned int subflows_max;
> -	int ret = 0;
> +	bool ret = true;
>  
> -	if (mptcp_pm_is_userspace(msk)) {
> -		if (mptcp_userspace_pm_active(msk)) {
> -			spin_lock_bh(&pm->lock);
> -			pm->subflows++;
> -			spin_unlock_bh(&pm->lock);
> -			return true;
> -		}
> +	if (!pm->ops->accept_new_subflow(msk))
>  		return false;
> -	}
> -
> -	subflows_max = mptcp_pm_get_subflows_max(msk);
>  
> -	pr_debug("msk=%p subflows=%d max=%d allow=%d\n", msk, pm->subflows,
> -		 subflows_max, READ_ONCE(pm->accept_subflow));
> +	spin_lock_bh(&pm->lock);
> +	if (!mptcp_pm_is_userspace(msk) && READ_ONCE(pm->accept_subflow)) {
> +		subflows_max = mptcp_pm_get_subflows_max(msk);
>  
> -	/* try to avoid acquiring the lock below */
> -	if (!READ_ONCE(pm->accept_subflow))
> -		return false;
> +		pr_debug("msk=%p subflows=%d max=%d allow=%d\n", msk, pm->subflows,
> +			 subflows_max, READ_ONCE(pm->accept_subflow));
>  
> -	spin_lock_bh(&pm->lock);
> -	if (READ_ONCE(pm->accept_subflow)) {
>  		ret = pm->subflows < subflows_max;
> -		if (ret && ++pm->subflows == subflows_max)
> +		if (ret && pm->subflows == subflows_max - 1)
>  			WRITE_ONCE(pm->accept_subflow, false);
>  	}

Maybe I missed something, but could we not move this code to
mptcp_pm_kernel_accept_new_subflow()?

There here, we would have something like:

  if (pm->ops->accept_new_subflow(msk)) {
      spin_lock_bh(&pm->lock);
      pm->subflows++;
      spin_unlock_bh(&pm->lock);
  }

No?

EDIT: just noticed you are doing that in patch 9/9. Can you not do that
in the same callback, but passing an extra argument to it? Or is it an
issue with the locks?

  bool (*accept_new_subflow)(const struct mptcp_sock *msk, bool allow);

> +	if (ret)
> +		pm->subflows++;
>  
>  	spin_unlock_bh(&pm->lock);
>  
>  	return ret;
> @@ -1057,7 +1048,7 @@ struct mptcp_pm_ops *mptcp_pm_find(const char *name)
>  int mptcp_pm_validate(struct mptcp_pm_ops *pm_ops)
>  {
>  	if (!pm_ops->get_local_id || !pm_ops->get_priority ||
> -	    !pm_ops->add_addr_echo) {
> +	    !pm_ops->add_addr_echo || !pm_ops->accept_new_subflow) {
>  		pr_err("%s does not implement required ops\n", pm_ops->name);
>  		return -EINVAL;
>  	}
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index 9d159196afe5..7ec8fafeda0e 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -1404,6 +1404,11 @@ static bool mptcp_pm_kernel_add_addr_echo(struct mptcp_sock *msk,
>  	       (addr->id > 0 && !READ_ONCE(msk->pm.accept_addr));
>  }
>  
> +static bool mptcp_pm_kernel_accept_new_subflow(const struct mptcp_sock *msk)
> +{
> +	return READ_ONCE(msk->pm.accept_subflow);
> +}
> +
>  static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
>  {
>  	bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
> @@ -1432,6 +1437,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
>  	.add_addr_received	= mptcp_pm_kernel_add_addr_received,
>  	.rm_addr_received	= mptcp_pm_kernel_rm_addr_received,
>  	.add_addr_echo		= mptcp_pm_kernel_add_addr_echo,
> +	.accept_new_subflow	= mptcp_pm_kernel_accept_new_subflow,
>  	.init			= mptcp_pm_kernel_init,
>  	.name			= "kernel",
>  	.owner			= THIS_MODULE,
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 3f7778ab064b..d6301d809376 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -689,6 +689,11 @@ static bool mptcp_pm_userspace_add_addr_echo(struct mptcp_sock *msk,
>  	return mptcp_userspace_pm_active(msk);
>  }
>  
> +static bool mptcp_pm_userspace_accept_new_subflow(const struct mptcp_sock *msk)
> +{
> +	return mptcp_userspace_pm_active(msk);
> +}
> +
>  static void mptcp_pm_userspace_release(struct mptcp_sock *msk)
>  {
>  	mptcp_userspace_pm_free_local_addr_list(msk);
> @@ -698,6 +703,7 @@ static struct mptcp_pm_ops mptcp_pm_userspace = {
>  	.get_local_id		= mptcp_pm_userspace_get_local_id,
>  	.get_priority		= mptcp_pm_userspace_get_priority,
>  	.add_addr_echo		= mptcp_pm_userspace_add_addr_echo,
> +	.accept_new_subflow	= mptcp_pm_userspace_accept_new_subflow,
>  	.release		= mptcp_pm_userspace_release,
>  	.name			= "userspace",
>  	.owner			= THIS_MODULE,
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 409bd415ef1d..be79940da424 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -61,9 +61,7 @@ static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
>  static bool mptcp_can_accept_new_subflow(const struct mptcp_sock *msk)
>  {
>  	return mptcp_is_fully_established((void *)msk) &&
> -		((mptcp_pm_is_userspace(msk) &&
> -		  mptcp_userspace_pm_active(msk)) ||
> -		 READ_ONCE(msk->pm.accept_subflow));
> +		msk->pm.ops->accept_new_subflow(msk);

I think pm->ops should only be used from pm.c. In other words, I suggest
having a dedicated patch changing this helper to call a new one added in
pm.c, e.g.

  return mptcp_is_fully_established((void *)msk) &&
         mptcp_pm_accept_new_subflow(msk);

WDYT?

>  }
>  
>  /* validate received token and create truncated hmac and nonce for SYN-ACK */

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

