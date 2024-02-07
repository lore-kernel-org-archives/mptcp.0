Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56183FC0A
	for <mptcp@lists.linux.dev>; Wed,  7 Feb 2024 03:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707276953; cv=none; b=D8+CLeCWF9vh6/8GnlLbIh9nFk+0RN04c0uFdqxF/xbokNoNinP6TFxRp2eAmFZ2Z3+yHYR+MMku/AkRjhcwx53s/JxgsV/F8/P6BYHZeYSAK7V9NqamPnk4bUZ/3hueF/yonANEtfhq6W71mi8vbk0+GYtVwWLILkVKb96JGq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707276953; c=relaxed/simple;
	bh=hkWO7E7sXn8ixAuz+ClyaTpt/6xt/BrFyiw6XDqsluM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fFfOXGzZE5LxTInJ9OHJoScwPX0qX/wqeIHgDd5H1P/tbKfbqKa8HWGgyXQQ8lKplw3odKiPXYLTQ/ssd/Q66mrOY2MVT0RCB1PV89nPfOP8a2ZywdZMDpUT7a+CW/u3vmlPR8xxIb5kIU+s/kn+EeoDOdmutQP6CTYfMTE+aRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svAsCWTF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svAsCWTF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6FB6C433F1;
	Wed,  7 Feb 2024 03:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707276952;
	bh=hkWO7E7sXn8ixAuz+ClyaTpt/6xt/BrFyiw6XDqsluM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=svAsCWTFHb+43Uu7MtYnBJxvFPvTo8qToauZp7+BHW3PodaQoa8JigJ/WV3O03Cdy
	 H3ky8Mcx2yTvQeD/LKdQgJP0efnXnihjjZBp1skHxMkNLccdwhcQdZvCBO+QQaDgdB
	 vzvBcZWTmB6gFQWd87HrX4mAU2gkCoTOLYcszE07IyLr0naANa+3TVQ609zZUPe4VJ
	 h126jX1EUg+NZy+fbDwl2ZTdWRVYl6fbp8pX1Ql0ECD/1kof/lgBW+LG3tm1egjFCm
	 07NAGLIrS+EmL63jN+98Zga9XkAeTle0qB4L4Kh8C7bpyayj1f5QNJ/m35WDCq6pkB
	 ZeEVJcW8E5B5A==
Date: Tue, 6 Feb 2024 19:35:52 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 4/4] mptcp: fix duplicate subflow creation
In-Reply-To: <1392a4ef6a8a45ca3a920f933a12766283a828c6.1707144963.git.pabeni@redhat.com>
Message-ID: <e815d530-4f29-c0ed-fdad-e1f5573178d9@kernel.org>
References: <cover.1707144963.git.pabeni@redhat.com> <1392a4ef6a8a45ca3a920f933a12766283a828c6.1707144963.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 5 Feb 2024, Paolo Abeni wrote:

> Fullmesh endpoints could end-up unexpectedly generating duplicate
> subflows - same local and remote addresses - when multiple incoming
> ADD_ADDR are processed before the PM creates the subflow for the local
> endpoints.
>
> Address the issue explicitly checking for duplicates at subflow
> creation time.
>
> To avoid a quadratic computational complexity, track the unavailable
> remote address ids in a temporary bitmap and initialize such bitmap
> with the remote ids of all the existing subflows matching the local
> address currently processed.
>
> The above allows additionally replacing the existing code checking
> for duplicate entry in the current set with a simple bit test
> operation.
>
> Fixes: 2843ff6f36db ("mptcp: remote addresses fullmesh")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/435
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Note that there is no problem for the opposite event sequence.
> ---
> net/mptcp/pm_netlink.c | 33 ++++++++++++++++++---------------
> 1 file changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 066bc855365c..617aad83eb87 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -396,19 +396,6 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
> 	}
> }
>
> -static bool lookup_address_in_vec(const struct mptcp_addr_info *addrs, unsigned int nr,
> -				  const struct mptcp_addr_info *addr)
> -{
> -	int i;
> -
> -	for (i = 0; i < nr; i++) {
> -		if (addrs[i].id == addr->id)
> -			return true;
> -	}
> -
> -	return false;
> -}
> -
> /* Fill all the remote addresses into the array addrs[],
>  * and return the array size.
>  */
> @@ -440,6 +427,16 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
> 		msk->pm.subflows++;
> 		addrs[i++] = remote;
> 	} else {
> +		DECLARE_BITMAP(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
> +
> +		/* Forbit creation of new subflows matching existing

Looks ok code-wise, but s/forbit/forbid/ here and...

> +		 * ones, possibly already created by incoming ADD_ADDR
> +		 */
> +		bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
> +		mptcp_for_each_subflow(msk, subflow)
> +			if (READ_ONCE(subflow->local_id) == local->id)
> +				__set_bit(subflow->remote_id, unavail_id);
> +
> 		mptcp_for_each_subflow(msk, subflow) {
> 			ssk = mptcp_subflow_tcp_sock(subflow);
> 			remote_address((struct sock_common *)ssk, &addrs[i]);
> @@ -447,11 +444,17 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
> 			if (deny_id0 && !addrs[i].id)
> 				continue;
>
> +			if (test_bit(addrs[i].id, unavail_id))
> +				continue;
> +
> 			if (!mptcp_pm_addr_families_match(sk, local, &addrs[i]))
> 				continue;
>
> -			if (!lookup_address_in_vec(addrs, i, &addrs[i]) &&
> -			    msk->pm.subflows < subflows_max) {
> +			if (msk->pm.subflows < subflows_max) {
> +				/* forbit creating multiple address towards

...here too. Or "Prevent" works too :)

- Mat

> +				 * this id
> +				 */
> +				__set_bit(addrs[i].id, unavail_id);
> 				msk->pm.subflows++;
> 				i++;
> 			}
> -- 
> 2.43.0
>
>
>
