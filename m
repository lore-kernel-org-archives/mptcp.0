Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455A32134A
	for <mptcp@lists.linux.dev>; Wed, 31 Jan 2024 02:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667606; cv=none; b=LtKjXOQkszUKVydiI0q27LzAk+1yVx0nP2iXxSZpIQAo4Ge9Fqk3dqlB27lywsc1Stbfp61uHwW+LTLC0/kEMh7sna4MeD2AeKA+9QI137PoCOLkAL5WGlT34xN2CqYnC1MqJOyaSXWcpfoxEkJ1IuoJ2kLQ6B/KSMvi5hYUwnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667606; c=relaxed/simple;
	bh=pRJ9UIlYGRdW4/ro3GlfTd7OJ1HOTCuISOZ2SESXhLo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SH+CHZtG1qAOcn1D75bG3GcIJw2Mbq5SdOwkRI1cP+EZf2dQeB29lVDu+fgCQaAeHGVg5frHKwjZ4nZYGhvGxq0RvdZGHTjSe/8CbIPJF4OPy0EDmXc+u75jRh+SwvrI9XacbWkCc3GaJMA7TgTz1GRobyl9dsMUnj2AYqtjj0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWRF3Dcj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWRF3Dcj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DD2C433F1;
	Wed, 31 Jan 2024 02:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706667605;
	bh=pRJ9UIlYGRdW4/ro3GlfTd7OJ1HOTCuISOZ2SESXhLo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=jWRF3DcjfYpXAmZAvWYxdsrgXI5LZ1St1Dkny955Wa84maKXxKIjvXYvnCU8rLpEy
	 LObkqWihiI/1lSTdq38HThCivzfJu9vnzck8hurxNaPTVXMshIUitO8nRBrMqlFcq2
	 MNTgKVpBQV+oAnBUhbFW6OmReovdU/hIgajqEQA5hpJU7G7foVNwF8XRf0GC6kQ+1v
	 PSB67ojEFpCygd4MuO1iLLGX1B1l370MTllnRDLjGOmPdIr74/6dsvvtals8iC+A6h
	 2+caBkpS9ilIMHbNMIamqy8gtXDwdvtlxWsybAaV8tzeEz8KdSIfyRh9FER/Gzv2VM
	 YEyF7IcaIuWQg==
Date: Tue, 30 Jan 2024 18:20:04 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v10 02/23] mptcp: add needs_id for userspace
 appending addr
In-Reply-To: <eb36016f963d58a1531b7e90e9ee9f753f48da9a.1705558030.git.tanggeliang@kylinos.cn>
Message-ID: <0688eff5-6092-7ab6-8913-781867f8a9f8@kernel.org>
References: <cover.1705558030.git.tanggeliang@kylinos.cn> <eb36016f963d58a1531b7e90e9ee9f753f48da9a.1705558030.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 18 Jan 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> When userspace PM requires to create an ID 0 subflow in "userspace pm
> create id 0 subflow" test like this:
>
>        userspace_pm_add_sf $ns2 10.0.3.2 0
>
> An ID 1 subflow, in fact, is created.
>
> Since in mptcp_pm_nl_append_new_local_addr(), 'id 0' will be treated as
> no ID is set by userspace, and will allocate a new ID immediately:
>
>     if (!e->addr.id)
>             e->addr.id = find_next_zero_bit(pernet->id_bitmap,
>                                             MPTCP_PM_MAX_ADDR_ID + 1,
>                                             1);
>
> To solve this issue, a new parameter needs_id is added for
> mptcp_userspace_pm_append_new_local_addr() to distinguish between
> whether userspace PM has set an ID 0 or whether userspace PM has
> not set any address.
>
> In mptcp_userspace_pm_get_local_id(), needs_id is always true, but in
> mptcp_pm_nl_announce_doit() and mptcp_pm_nl_subflow_create_doit(),
> pass mptcp_pm_has_addr_attr_id() to needs_it.
>
> Fixes: e5ed101a6028 ("mptcp: userspace pm allow creating id 0 subflow")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> net/mptcp/pm_userspace.c | 15 +++++++++------
> 1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 4f3901d5b8ef..8ca6e28a121e 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -26,7 +26,8 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
> }
>
> static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
> -						    struct mptcp_pm_addr_entry *entry)
> +						    struct mptcp_pm_addr_entry *entry,
> +						    bool needs_id)
> {
> 	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
> 	struct mptcp_pm_addr_entry *match = NULL;
> @@ -41,7 +42,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
> 	spin_lock_bh(&msk->pm.lock);
> 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
> 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
> -		if (addr_match && entry->addr.id == 0)
> +		if (addr_match && entry->addr.id == 0 && needs_id)
> 			entry->addr.id = e->addr.id;
> 		id_match = (e->addr.id == entry->addr.id);
> 		if (addr_match && id_match) {
> @@ -64,7 +65,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
> 		}
>
> 		*e = *entry;
> -		if (!e->addr.id)
> +		if (!e->addr.id && needs_id)
> 			e->addr.id = find_next_zero_bit(id_bitmap,
> 							MPTCP_PM_MAX_ADDR_ID + 1,
> 							1);
> @@ -153,7 +154,7 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
> 	if (new_entry.addr.port == msk_sport)
> 		new_entry.addr.port = 0;
>
> -	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry);
> +	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry, true);
> }
>
> int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
> @@ -198,7 +199,8 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
> 		goto announce_err;
> 	}
>
> -	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val);
> +	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val,
> +						       !mptcp_pm_has_addr_attr_id(addr, info));

Why would we want the kernel to assign an ID when the userspace PM should 
be reponsible for that? Seems to me that it is a bug that the kernel was 
assigning a subflow ID at all for connections managed by a userspace PM.

> 	if (err < 0) {
> 		GENL_SET_ERR_MSG(info, "did not match address and id");
> 		goto announce_err;
> @@ -378,7 +380,8 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
> 	}
>
> 	local.addr = addr_l;
> -	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
> +	err = mptcp_userspace_pm_append_new_local_addr(msk, &local,
> +						       !mptcp_pm_has_addr_attr_id(laddr, info));

Same issue here, the userspace PM should be required to assign the ID. If 
there's a problem with breaking userspace please let me know and we can 
discuss!

- Mat

> 	if (err < 0) {
> 		GENL_SET_ERR_MSG(info, "did not match address and id");
> 		goto create_err;
> -- 
> 2.40.1
>
>
>
