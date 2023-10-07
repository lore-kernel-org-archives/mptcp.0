Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70E6328BE
	for <mptcp@lists.linux.dev>; Sat,  7 Oct 2023 21:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aoe6DV8v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BF9C433C7;
	Sat,  7 Oct 2023 21:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696712677;
	bh=VlraTGDlgLjF5U7SPVpmnjRPz5+oBAueGLalRxm2jhg=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Aoe6DV8vu6OXs/T0ylZ9KScoFEjj+Dp6VVdHlOUCgTjQtj1tEs1iMjVJfuiLxvryr
	 H9L0I0/hFGky1urAekFghm0X6owZnqEK2l8oHmrHQ71ROiIO1oMfUG/iRChcEA3YWi
	 syiLZFYhqQPLk0QZYeVEtWlDEBHxxHWYj+HpivbZPCijimj1ZshI5sB9rAe7icEExu
	 BoSdcwmOFmPPzhWIfGgyaNFQWFqQETn+iOMLkCGmZigevF7eQYJA0hIN4KfRWsuHhf
	 KsIgp5fgqmPhL70qQ5RDJccDIDPr7zQOrngySfHBVbEP8/aqjFTk3xhKsU8vLhj0sx
	 EzBmkc+WV9LTw==
Message-ID: <b3da54fb-37ba-4095-b10d-3fcb836212ed@kernel.org>
Date: Sat, 7 Oct 2023 23:04:34 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 18/29] mptcp: add userspace pm addr entry
 refcount
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1695631132.git.geliang.tang@suse.com>
 <f1389728746b0a44344a343dec208f31d7ed1986.1695631132.git.geliang.tang@suse.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 Fe7fduHbABmYz9cefQpO7wDE/Q==
Organization: Tessares
In-Reply-To: <f1389728746b0a44344a343dec208f31d7ed1986.1695631132.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 25/09/2023 10:41, Geliang Tang wrote:
> This patch adds userspace PM address entry refcount. Add a new filed
> 'refcont' in struct mptcp_pm_addr_entry, inited to 1.

Small nits: s/refcont/refcnt/  and s/inited/initiated/

(same comment for the next patch)

> Increase this counter in mptcp_nl_cmd_sf_create(), and decrease it in
> mptcp_userspace_pm_delete_local_addr() according the subflows value.

Please *always* explain why this commit is needed: why do we need a
refcount per address entry? Feel free to look at the ticket 403 for
inspirations.

(same comment for the next patch)

Also, please add the Closes tag:

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403

Another thing: should we consider this as a bug-fix? I think we can
because without this modification, we were not able to send a RM_ADDR if
another subflow using the same local address has been removed before. It
should not be a too annoying issue but if we consider it as an issue,
this should target 'mptcp-net' and have a Fixes tag:

Fixes: 24430f8bf516 ("mptcp: add address into userspace pm list")

One last thing: do you mind adding a new test to cover this case please?
e.g.

- the client creates an MPTCP connection: A <-> A
- it asks the userspace PM to add 2 subflows using the same source IP
address: B <-> B ; B <-> C
- it deletes one subflow: B <-> B
- it sends a RM_ADDR for B

Before the patch, it should fail: the kernel has removed the
corresponding entry for the local address from the list when removing
the subflow while another subflow was using the same local address.
After the patch, it should succeed.

Also, trying to send yet another RM_ADDR for B after the previous one
should result in an expected error. (it is possible we don't handle that
correctly)

> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/pm_userspace.c | 21 +++++++++++++++------
>  net/mptcp/protocol.h     |  2 ++
>  2 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 30f4dd074a70..8efca1602e11 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -70,6 +70,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
>  							1);
>  		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
>  		msk->pm.local_addr_used++;
> +		refcount_set(&e->refcnt, 1);
>  		ret = e->addr.id;
>  	} else if (match) {
>  		ret = entry->addr.id;

Should you not increment the refcount here if there is a match?

> @@ -107,9 +108,12 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
>  	if (!entry)
>  		return -EINVAL;
>  
> -	/* TODO: a refcount is needed because the entry can
> -	 * be used multiple times (e.g. fullmesh mode).
> -	 */
> +	if (!refcount_dec_not_one(&entry->refcnt)) {
> +		pr_debug("userspace refcount error: refcnt=%d",
> +			 refcount_read(&entry->refcnt));
> +		return -EINVAL;

I'm not sure to understand why you treat that as an error.

Should you not simply use refcount_dec_and_test()? If after the
decrement, the counter is not 0, there is nothing to do: the entry is
still being used by another subflow, that's fine. You can keep a
pr_debug() but please do not mention 'error' and do not return a
negative value, no?

> +	}
> +
>  	list_del_rcu(&entry->list);
>  	kfree(entry);
>  	msk->pm.local_addr_used--;
> @@ -387,10 +391,15 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
>  	release_sock(sk);
>  
>  	spin_lock_bh(&msk->pm.lock);
> -	if (err)
> +	if (err) {
>  		mptcp_userspace_pm_delete_local_addr(msk, &local);
> -	else
> -		msk->pm.subflows++;
> +	} else {
> +		struct mptcp_pm_addr_entry *entry;
> +
> +		entry = mptcp_userspace_pm_get_entry(msk, &addr_l);
> +		if (entry && refcount_inc_not_zero(&entry->refcnt))

I don't think you need to change the code here: before creating the
subflow, 'mptcp_userspace_pm_append_new_local_addr()' has been called
which has initialised or incremented the refcount. Then it cannot be 0
and it doesn't need to be incremented, no?

> +			msk->pm.subflows++;
> +	}
>  	spin_unlock_bh(&msk->pm.lock);
>  
>   create_err:

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
