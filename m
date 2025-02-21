Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BBA2500D0
	for <mptcp@lists.linux.dev>; Fri, 21 Feb 2025 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158626; cv=none; b=ZsSZS0QjWVbVFrkFe2HJMxncrPrDnY0mTnaPS3ShleMeJ8XdiLiv7Uf4zpKiKbGNvPieZgFpQRc8rM8KYXqpy5tXN7sV+m9Da8t7wt0Jm9o1EKD81Douhbpkbge2Ehy94x7N1ksY5K5QuPEcDqKRbGWq8wReaEz9n0A48R/LwMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158626; c=relaxed/simple;
	bh=zzj1NPS5yLppxfqlZx9JcM8355YmPqmK+elG4v0DaSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwWtUdQMydh2EuLJlkba2FGDsruwkzBp50p6LDK9cziN57kJjGJHyCfP3pICJyQ+cadC4Hr4nLhvxiAwmmW7s0y7b6NetxWFwgLvsBi8a47tA4bRYYKL/cOrMnmkrcA8t9Pt2Q/oi4g3zQrGy0DZvNo0mF3H/i3L55NwyK8hnVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=re4bGjQl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="re4bGjQl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE6AC4CED6;
	Fri, 21 Feb 2025 17:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740158626;
	bh=zzj1NPS5yLppxfqlZx9JcM8355YmPqmK+elG4v0DaSE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=re4bGjQl/Uqq6BEMyJrJHqdwJF3rx9TcUoMVB8HKGyo2Yi/ieLclOCFa/P0VXyFYl
	 Tn8ZbBv8sGdD5hj57Kf9ijoNjRK7M/kaYW5hb/bcH92e4uCQqpUQDMkUVnjFfZjQYl
	 +SZhNnLhK9A7pMnFieE0Shpj6NROynMS1e+mahw2dL+YODcJ9yoR2RhkISrXRLKnYZ
	 yBkGK1xdDo3bieaV2F/fBDqcP/Gre9p/YqJtOBvPZkILE4Rp1qyXLA+49xDXtr3Qhj
	 wW4ood6Egpfd7Kh3l32gSEsE6NFJ9dYCueu5WHxJxg0HpQJI1dGZOfD4HUazp2JKOt
	 H2QW5isBJWtRg==
Message-ID: <b7333a19-921a-41e1-9a87-ff70aab3e000@kernel.org>
Date: Fri, 21 Feb 2025 18:23:43 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v5 4/9] mptcp: pm: define struct mptcp_pm_ops
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1740019794.git.tanggeliang@kylinos.cn>
 <5f83856741646b16dde9a741fcfbfa55753eee39.1740019794.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <5f83856741646b16dde9a741fcfbfa55753eee39.1740019794.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 20/02/2025 03:57, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> In order to allow users to develop their own BPF-based path manager,
> this patch defines a struct ops "mptcp_pm_ops" for a userspace path
> manager, which contains a set of interfaces.
> 
> Add a set of functions to register, unregister, find and validate a
> given struct ops.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  include/net/mptcp.h  | 29 ++++++++++++++++++++++
>  net/mptcp/pm.c       | 59 ++++++++++++++++++++++++++++++++++++++++++++
>  net/mptcp/protocol.h |  5 ++++
>  3 files changed, 93 insertions(+)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index a41d6c74760f..f51e75d3882d 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -134,6 +134,35 @@ struct mptcp_pm_param {
>  	struct mptcp_addr_info		addr;
>  };
>  
> +struct mptcp_pm_ops {
> +	int (*created)(struct mptcp_sock *msk);
> +	int (*established)(struct mptcp_sock *msk);
> +	int (*closed)(struct mptcp_sock *msk);
> +	int (*address_announced)(struct mptcp_sock *msk,
> +				 struct mptcp_pm_param *param);
> +	int (*address_removed)(struct mptcp_sock *msk,
> +			       struct mptcp_pm_param *param);
> +	int (*subflow_established)(struct mptcp_sock *msk,
> +				   struct mptcp_pm_param *param);
> +	int (*subflow_closed)(struct mptcp_sock *msk,
> +			      struct mptcp_pm_param *param);
> +	int (*get_local_id)(struct mptcp_sock *msk,
> +			    struct mptcp_pm_param *param);
> +	bool (*get_priority)(struct mptcp_sock *msk,
> +			     struct mptcp_pm_param *param);
> +	int (*set_priority)(struct mptcp_sock *msk,
> +			    struct mptcp_pm_param *param);
> +	int (*listener_created)(struct mptcp_sock *msk);
> +	int (*listener_closed)(struct mptcp_sock *msk);
> +
> +	u8			type;

I guess the type matches net.mptcp.pm_type sysctl knob, right?

I wonder if we should not deprecate this sysctl, and use a string like
with the scheduler. So instead, we could have:

  char			name[MPTCP_PM_NAME_MAX];

And on ctrl.c, we could map pm_type for the moment with a custom
proc_handler (and even remove this sysctl knob in a few releases):

 - 0  → in-kernel
 - 1  → userspace
 - >1 → bpf

WDYT? Would it not be clearer for devs and users?

Note that if for the implementation, if it is easier to keep this "type"
entry for the moment for the sysctl stuff, I'm fine with that. But if we
don't need it, let's not introduce it.

> +	struct module		*owner;
> +	struct list_head	list;
> +
> +	void (*init)(struct mptcp_sock *msk);
> +	void (*release)(struct mptcp_sock *msk);

To answer my question from the v3 review: the init/release is done for
each MPTCP connection handled by this PM.

> +} ____cacheline_aligned_in_smp;
> +
>  #ifdef CONFIG_MPTCP
>  void mptcp_init(void);
>  
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index e3457f34621c..f56b2d1e3409 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -6,12 +6,17 @@
>  #define pr_fmt(fmt) "MPTCP: " fmt
>  
>  #include <linux/kernel.h>
> +#include <linux/rculist.h>
> +#include <linux/spinlock.h>
>  #include <net/mptcp.h>
>  #include "protocol.h"
>  
>  #include "mib.h"
>  #include "mptcp_pm_gen.h"
>  
> +static DEFINE_SPINLOCK(mptcp_pm_list_lock);
> +static LIST_HEAD(mptcp_pm_list);
> +
>  /* path manager command handlers */
>  
>  int mptcp_pm_announce_addr(struct mptcp_sock *msk,
> @@ -661,3 +666,57 @@ void __init mptcp_pm_init(void)
>  {
>  	mptcp_pm_nl_init();
>  }
> +
> +/* Must be called with rcu read lock held */
> +struct mptcp_pm_ops *mptcp_pm_find(enum mptcp_pm_type type)
> +{
> +	struct mptcp_pm_ops *pm;
> +
> +	list_for_each_entry_rcu(pm, &mptcp_pm_list, list) {
> +		if (pm->type == type)
> +			return pm;
> +	}
> +
> +	return NULL;
> +}
> +
> +int mptcp_pm_validate(struct mptcp_pm_ops *pm)
> +{
> +	if (!pm->created && !pm->established && !pm->closed &&
> +	    !pm->address_announced && !pm->address_removed &&
> +	    !pm->subflow_established && !pm->subflow_closed &&
> +	    !pm->get_local_id && !pm->get_priority && !pm->set_priority &&
> +	    !pm->listener_created && !pm->listener_closed) {

I'm not sure to understand the purpose of this validation.

Why not forcing some or all of them?

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

