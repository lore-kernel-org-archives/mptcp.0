Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DE0137E
	for <mptcp@lists.linux.dev>; Tue,  6 Feb 2024 01:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707182910; cv=none; b=HdCPO6ie7W4fdOjt++Tug1xtt62Xddiep5UTqbtIKneFNK2qjSOUlgZFtzQibuSgWh7U0j4IcROzL7Q/EKfHCePaVyeSay8INXu94WdFCc51m/bCzH5/2QQ26PqsmjJ1grKwWbD2qGS42qp8BOHPg4xMRa7PhuHw+A1IHD+CUec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707182910; c=relaxed/simple;
	bh=wuduWD0SVgHaGO7hYDol4Pj0OnmvCUBNuKe57B0+u78=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HzNv8CIUB9s+6jsq8N/JZvGU1YBjWpX7Rtgv+51r5hqx4pzx9STMZ5DHCQyNgbNBw2In952I2zVMhDXvoYikk2E9HhtVgSfC2dIaR7I9t5L5ZA4BtuFS/7/fQmCUz0Xl5b1+ZZtbv2TH2QGZMk1mb9I26/6EApFH2Lw8Pro/8hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jw9F0aRv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jw9F0aRv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2519BC433F1;
	Tue,  6 Feb 2024 01:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707182910;
	bh=wuduWD0SVgHaGO7hYDol4Pj0OnmvCUBNuKe57B0+u78=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Jw9F0aRvuBL240jcn4ag6Fd1w3gvpaVWvJbcQPiXS81MPWPfjKU/ILZcGLaT1lVL9
	 jz6ZBy1JUzZqM0YdAch568DBgXn5trPyX4nknimsnq67dOQWdrXn3bnpn9sopr9fiX
	 Y8HzRcQ8zeYOSBW3s4NfWxKLAnwTlP+GEBe9cayqMQu3m8gPkUyYD5bsGTYjuwNAE1
	 SclXHrxqpWZebXqZMPZcxVAfSxeVbS41z9t8LkWgy3n+VC3lix8+iGBlHnCJAiPuio
	 hPRCln+AlJRWgRtNY88+H/7a/0HvyA99TRtP8ix+aJoJ4NEUMMcA0xcIlExmsopuiW
	 Uwg8hfMx9ixaQ==
Date: Mon, 5 Feb 2024 17:28:29 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-net 1/4] mptcp: add needs_id for userspace appending
 addr
In-Reply-To: <0d089da27becde2a0ff936dbbe856b2baf9bf710.1706759413.git.tanggeliang@kylinos.cn>
Message-ID: <05aee749-23c2-104f-d62f-96ee4c6bf0a8@kernel.org>
References: <cover.1706759413.git.tanggeliang@kylinos.cn> <0d089da27becde2a0ff936dbbe856b2baf9bf710.1706759413.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 1 Feb 2024, Geliang Tang wrote:

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
> needs_id is true in mptcp_userspace_pm_get_local_id(), but false in
> mptcp_pm_nl_announce_doit() and mptcp_pm_nl_subflow_create_doit().
>
> Fixes: e5ed101a6028 ("mptcp: userspace pm allow creating id 0 subflow")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

Hi Geliang -

LGTM:

Reviewed-by: Mat Martineau <martineau@kernel.org>

> ---
> net/mptcp/pm_userspace.c | 13 +++++++------
> 1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 4f3901d5b8ef..e582b3b2d174 100644
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
> @@ -198,7 +199,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
> 		goto announce_err;
> 	}
>
> -	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val);
> +	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val, false);
> 	if (err < 0) {
> 		GENL_SET_ERR_MSG(info, "did not match address and id");
> 		goto announce_err;
> @@ -378,7 +379,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
> 	}
>
> 	local.addr = addr_l;
> -	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
> +	err = mptcp_userspace_pm_append_new_local_addr(msk, &local, false);
> 	if (err < 0) {
> 		GENL_SET_ERR_MSG(info, "did not match address and id");
> 		goto create_err;
> -- 
> 2.40.1
>
>
>
