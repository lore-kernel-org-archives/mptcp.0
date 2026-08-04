Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ADB3F44FB
	for <mptcp@lists.linux.dev>; Tue,  4 Aug 2026 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867764; cv=none; b=BkrH9sSWp/xornB/4ZUwKkgUVRBAt7D+GErhIXKgYBsZfnU/lyEXmaQd/ky+RaOS7VEYkDpcbKUht9lNzfKzTbZkc32WoMEEOEkSEterOFEYnf+5Dmu05ci/fM4BAsTSneiQzaMoq7gkMvfWGQnXI7BF3CnywwduSzX4OVQ6Ho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867764; c=relaxed/simple;
	bh=JgiQuJ9hA9NlYnj1TMPYOdP7iOpmdxpxK+AnI0B45Mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P34vknMGw9S8hTADQq/b0oV3wQezoall1fAVttkx6DoTwTrJDylj78aCzTbbjpNMYF4EGd0EkrrZvJS2d6R8k8YurpuZNnU+jguxx4tgzXOpe6aQuAo4GPgE4rS43az07cuEFb5xPRk3XkgoyKlhpZakaqm2L3y42b4BN0h1Lfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKUpePGM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKUpePGM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89C91F000E9;
	Tue,  4 Aug 2026 18:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785867763;
	bh=YEYXSOGBuQFvi5Hb4FTz642JzKV3m2rqHQAkAoEwAMQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nKUpePGMuHER6yMiYZORix6fZ2gNXeQLfCz8SQeEuewvmBdtdzfdbxZAyWaQ94QYf
	 YnvPRoJLe5ey6HD16+iZhIyB8LfNyQ9EAns764VQ0qhE//7lE+1eRvzMOXjLnNT0Fj
	 59A3NDjuZRij/4DGZR0xdbmmnh0Z/c9b59Eu+G+Dn53OoxXkvPgUYawblBvTVWDesF
	 t8snDDQP/ntQciV+f0QI3d7ORsOfYvO850XSZ7SP93MPV/Yyph0mgXXduG1TW8b4dd
	 q7P8GasNYeTQlkSrrIJyj2eBsr5jIJ83jy6VsHvyPVVj2sC9ztX0mCHt5ZxzKk0BNn
	 eDhMDAT9yZotQ==
Message-ID: <63f14fa5-f2d3-46e4-bb3a-f02430701cc8@kernel.org>
Date: Tue, 4 Aug 2026 20:22:40 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 MPTCP-net] pm: userspace: fix address ID overflow when
 all IDs exhausted
Content-Language: fr
To: luoqing <l1138897701@163.com>
Cc: mptcp@lists.linux.dev
References: <20260714080356.805839-1-l1138897701@163.com>
 <20260804022350.181323-1-l1138897701@163.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260804022350.181323-1-l1138897701@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi luoqing,

(-cc David/Paolo)

Thank you for the patch.

Please only Cc the MPTCP mailing list.

Also, please send new versions in a new email thread, not as a reply to
a previous one.

One last thing: here, you can send the fix and the selftest as part of
the same series, not as separated patches, so the CI will validate the
new selftest with the fix. It is fine to have patches for -net and -next
in the same series. Also, please use 'mptcp-ne(x)t', no capital letters.

On 04/08/2026 04:23, luoqing wrote:
> From: Qing Luo <luoqing@kylinos.cn>
> 
> When all MPTCP address IDs (1-255) are exhausted in the userspace PM,
> find_next_zero_bit() returns MPTCP_PM_MAX_ADDR_ID + 1 (256). This value
> overflows when stored in the u8 field e->addr.id, resulting in ID 0
> being stored and the entry being incorrectly added to the list.
> 
> ID 0 is reserved for the initial connection in MPTCP, so this overflow
> can cause address conflicts.
> 
> Note: the in-kernel PM already has an 'endpoints == MPTCP_PM_MAX_ADDR_ID'
> check in mptcp_pm_nl_append_new_local_addr() that returns -ERANGE before
> reaching find_next_zero_bit(), preventing this overflow. So this fix only
> addresses the userspace PM path.
> 
> Store the find_next_zero_bit() result in a temporary unsigned int, check
> against MPTCP_PM_MAX_ADDR_ID, and return -ENOSPC if all IDs are truly
> exhausted. Properly free the allocated entry with sock_kfree_s() on error.
> 
> Also modify the CSF (subflow create) handler to pass !entry.addr.id as
> the needs_id parameter. When no local ID is provided by user-space
> (entry.addr.id == 0), this triggers auto-allocation instead of silently
> using the reserved ID 0.
> 
> Fixes: 4638de5aefe5 ("mptcp: handle local addrs announced by userspace PMs")
> Assisted-by: LLM # review
> Signed-off-by: Qing Luo <luoqing@kylinos.cn>
> ---
>  net/mptcp/pm_userspace.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 945aa5afc2dd..ada7d6cef625 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -74,10 +74,17 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
>  			goto append_err;
>  		}
>  
> -		if (!e->addr.id && needs_id)
> -			e->addr.id = find_next_zero_bit(id_bitmap,
> -							MPTCP_PM_MAX_ADDR_ID + 1,
> -							1);
> +		if (!e->addr.id && needs_id) {
> +			unsigned int id = find_next_zero_bit(id_bitmap,
> +							     MPTCP_PM_MAX_ADDR_ID + 1,
> +							     1);
> +			if (id > MPTCP_PM_MAX_ADDR_ID) {
> +				sock_kfree_s(sk, e, sizeof(*e));
> +				ret = -ENOSPC;
> +				goto append_err;
> +			}
> +			e->addr.id = id;
> +		}
>  		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
>  		msk->pm.local_addr_used++;
>  		ret = e->addr.id;
> @@ -400,7 +407,8 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
>  		goto create_err;
>  	}
>  
> -	err = mptcp_userspace_pm_append_new_local_addr(msk, &entry, false);
> +	err = mptcp_userspace_pm_append_new_local_addr(msk, &entry,
> +						       !entry.addr.id);

I don't think you can do that: it is valid to give an ID set to 0. But
it is different to give no ID.

I don't think this modification here should be part of this patch: it is
different from the overflow case you are trying to fix. It could be in
another patch, but that's changing the behaviour, and that's not a fix I
think.

Also, see my series:


https://lore.kernel.org/20260727-mptcp-pm-userspace-id0-case-v1-0-9877f02a9bae@kernel.org

*Maybe*, for -next, we could check if the ID was not set via Netlink
(and not set to 0), and pick an ID for it. *But*, it might not be a good
idea: the userspace daemon will not know the ID that has been picked,
and will need to get it via another request. That doesn't sound like a
good idea, no?

>  	if (err < 0) {
>  		NL_SET_ERR_MSG_ATTR(info->extack, laddr,
>  				    "did not match address and id");

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

