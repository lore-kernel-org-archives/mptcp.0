Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0800F1FDA97
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 11:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741175875; cv=none; b=oMi6vyCNb263wHW82P1GqNoZCTLBf25fCCZsJKX2I8o8MiK9zNOvKWVTZczDYKtfKygvf72QZ8RJLm93J8rKu/nFjOWZ6hSPKQtVrcJzWlkoeLl65zciwnKbMqwDcNEEXm/07TvnT5xGQ7KPf8bPqjcFL5uS1j4YodFTb5/1WI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741175875; c=relaxed/simple;
	bh=79iCa7DVrX+DYv1s94NVzOmOtyN7XOpv/qJ+TbrHz/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t7NTgJkkqVGO0vUFTcNwKWHFscAE2tuLLIwSmUaAERHmLtim0ceWYww2l9ShQkJgC9NkQ1n2/g7Wv06aZU5XZbhT8U8gnnyT7NXxQRwhIoyqaC2IQ7L9ul4uAH34l0X+JLuoxgN4AcSN7Zq/sP4MJg7cDIwMDvZS7SWnTyNNy8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pir2gFOJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pir2gFOJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0533C4CEE2;
	Wed,  5 Mar 2025 11:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741175874;
	bh=79iCa7DVrX+DYv1s94NVzOmOtyN7XOpv/qJ+TbrHz/4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pir2gFOJJExSut/fBaHMa2RiIXPuz6Dh3037s+V208kavsXUy5damUxV2flfz5RsD
	 Yjz/kWz5ql3whixhadcabRdibl7DahJSHtyijgudEe8hixPI6WRmOgGVE112+LEd2X
	 Uw6FJ3mOyFABK8ZAkqRx/LdJ4q2MuUAV5O0cZ5eqWvwLgl1JFMPc+4sbP2Iuksbriw
	 Bgkkd6B3lWfhZwTEO5HM5VSLGYHxikR8LxV/iQCVHjf2o5OM6lupgTvCY0wSqlTJ6W
	 K6tVpQWCVEvCU6+Vyk3yGFuJZ535Fw/0MzucnqpdiJ5mdQSL8GCiO3m7+1u7gLs2L/
	 DN2i3M4ZVXDFw==
Message-ID: <385de26e-26ba-4227-a815-19e3edbb585c@kernel.org>
Date: Wed, 5 Mar 2025 12:57:51 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v8 08/12] mptcp: pm: initialize and release
 mptcp_pm_ops
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1741088339.git.tanggeliang@kylinos.cn>
 <0fd4e42c04c60d63c11463c792084b751c4e2e48.1741088339.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0fd4e42c04c60d63c11463c792084b751c4e2e48.1741088339.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 04/03/2025 12:40, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Add a struct mptcp_pm_ops pointer "ops" in struct mptcp_pm_data, and two
> functions mptcp_pm_initialize() and mptcp_pm_release(), to set and release
> this pointer. mptcp_pm_initialize() is invoked in mptcp_pm_data_reset(),
> while mptcp_pm_release() is invoked in mptcp_pm_destroy().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm.c       | 57 +++++++++++++++++++++++++++-----------------
>  net/mptcp/protocol.h |  1 +
>  2 files changed, 36 insertions(+), 22 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 5018ed3c575f..e4d84aad3795 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -970,16 +970,45 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
>  	spin_unlock_bh(&msk->pm.lock);
>  }
>  
> +static void mptcp_pm_initialize(struct mptcp_sock *msk,
> +				struct mptcp_pm_ops *pm)

To avoid confusions, probably best to use "pm_ops" for "mptcp_pm_ops"
structures, and keep "pm" for "mptcp_pm_data" ones.

> +{
> +	if (!pm || !bpf_try_module_get(pm, pm->owner)) {
> +		pr_warn_once("pm %s fails, fallback to default pm",
> +			     pm->name);
> +		pm = &mptcp_pm_kernel;
> +	}
> +
> +	msk->pm.ops = pm;
> +	if (msk->pm.ops->init)

Note: this should be kept like that if 'init' is no longer mandatory
(see my comment on patch 7 -- but if it was mandatory because of what is
done in mptcp_pm_validate(), no need to check if it is set then)

> +		msk->pm.ops->init(msk);
> +
> +	pr_debug("pm %s initialized\n", pm->name);
> +}
> +
> +static void mptcp_pm_release(struct mptcp_sock *msk)
> +{
> +	struct mptcp_pm_ops *pm = msk->pm.ops;

Same here: pm_ops?

> +
> +	if (!pm)
When can we have this case? If we can have this case, that means each
time we will want to use "pm->ops", we will need to check if it is not
NULL. That feels wrong. The PM should be released only once.

We could add a WARN_ON_ONCE() here, but still, that feels wrong: why
adding a check only there? And if it is not needed, why adding it?

> +		return;
> +
> +	msk->pm.ops = NULL;
> +	if (pm->release)
> +		pm->release(msk);
> +
> +	bpf_module_put(pm, pm->owner);
Probably good to add this after:

  pr_debug("pm %s released\n", pm->name);

(...)

> @@ -991,25 +1020,9 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
>  	pm->rm_list_rx.nr = 0;
>  	WRITE_ONCE(pm->pm_type, pm_type);
>  
> -	if (pm_type == MPTCP_PM_TYPE_KERNEL) {
> -		bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
> -
> -		/* pm->work_pending must be only be set to 'true' when
> -		 * pm->pm_type is set to MPTCP_PM_TYPE_KERNEL
> -		 */
> -		WRITE_ONCE(pm->work_pending,
> -			   (!!mptcp_pm_get_local_addr_max(msk) &&
> -			    subflows_allowed) ||
> -			   !!mptcp_pm_get_add_addr_signal_max(msk));
> -		WRITE_ONCE(pm->accept_addr,
> -			   !!mptcp_pm_get_add_addr_accept_max(msk) &&
> -			   subflows_allowed);
> -		WRITE_ONCE(pm->accept_subflow, subflows_allowed);
> -	} else {
> -		WRITE_ONCE(pm->work_pending, 0);
> -		WRITE_ONCE(pm->accept_addr, 0);
> -		WRITE_ONCE(pm->accept_subflow, 0);
This should be kept here, for all PM, then calling pm->ops->init(), see
my comment in patch 7.


Also, not directly related to this patch, it feels like we should add a
"struct_group(reset, ...)" in struct mptcp_pm_data to simplify the
reset, and make sure we don't miss any. This should be done in a
dedicated patch, and can be done later.
Note that mptcp_pm_data_reset() is called when the msk is created, and
after a disconnect, to be able to re-use the socket again after. We
should make sure everything has been reset, that's not something we
heavily test. In fact, maybe we already missed the reset of some fields
that could cause some issues? Can you check that please?

> -	}
> +	rcu_read_lock();
> +	mptcp_pm_initialize(msk, mptcp_pm_find(path_manager));
> +	rcu_read_unlock();
>  
>  	WRITE_ONCE(pm->addr_signal, 0);
>  	WRITE_ONCE(pm->remote_deny_join_id0, false);
Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

