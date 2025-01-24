Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41AF13AC1
	for <mptcp@lists.linux.dev>; Fri, 24 Jan 2025 01:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737683614; cv=none; b=R8dEbcYkfZJshxsAcAJgUxg6kEe50q9c22WFViNT4yo4N0guBf2c+Iu3uYGpN8cJOUvltmZTvigtiZlggGDHop1V3+iaUqJ4WueJCJbc/FVW7XhmXjmEXvCERbnaUNbx/HE2zPk1hKaiH4nHH8QDO+ww/c6lF9gomo3+F/xS2HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737683614; c=relaxed/simple;
	bh=eTjEJofsnJ0oitrFZYJIOABji/Tj/Jwr4FF72xjRWXA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=k4uIMHm/ukxK9FP1HZTpBPchavJ4He6zIjkLvF44s5gsiLFzYVaz6r4tJO+PFqdMytGiWhoeXmi4qCGRlzfEeBlklN8ZpguEDAY9PDJ7aflBp0mpBnHvaxZRF6jS3wopGS/0PnVxf/ZBjezEyY3Pyk4f1SDNwLEWfgQTlrlvOO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnaepcdI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnaepcdI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E62EC4CED3;
	Fri, 24 Jan 2025 01:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737683613;
	bh=eTjEJofsnJ0oitrFZYJIOABji/Tj/Jwr4FF72xjRWXA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=XnaepcdIWeDa/Uyp/EsvXR7OQO2iXLdpFFVdYIS2hoIz6FSBANBHBTSJXL3irxosK
	 T4eprXzaoCDeUYQ0g8lIKWzn5FHGmr9zG0R2mA1xHilaJn8r3vWKtnuxWQWw9D+e0/
	 bOoRW78tBTl9GhQOLsAanGrQv8ktRncQ+u92Lb1ji8VItSsIJoo9+dEtKj/EEkQ9uf
	 DhkvXeD4OZaZSKEYORL/5MWpu25RA6pwRxETyAAkylsWK+rWYoO8K9G4QLHFuTkk3D
	 AHc1/jMWpsJX/rU9rdEy3fMpeydCRpxgghihiZ39gOcm+R2CkZWL3DY0p+X3mlwfcU
	 pNao/rEhExwDw==
Date: Thu, 23 Jan 2025 17:53:32 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 2/2] mptcp: pm: change to fullmesh only
 for 'subflow'
In-Reply-To: <20250122-mptcp-issue-540-v3-2-4aeed3022f23@kernel.org>
Message-ID: <a75623be-882b-0d3f-97e8-7adb04c46f39@kernel.org>
References: <20250122-mptcp-issue-540-v3-0-4aeed3022f23@kernel.org> <20250122-mptcp-issue-540-v3-2-4aeed3022f23@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 22 Jan 2025, Matthieu Baerts (NGI0) wrote:

> If an endpoint doesn't have the 'subflow' endpoint

'flag'?

> -- in fact, has no
> type, so not 'subflow', 'signal', nor 'implicit' -- there are then no
> subflows created from this local endpoint to at least the initial
> destination address. In this case, no need to call mptcp_pm_nl_fullmesh()
> which is there to recreate the subflows to reflect the new value of the
> fullmesh attribute.
>
> Similarly, there is then no need to iterate over all connections to do
> nothing, if only the 'fullmesh' flag has been changed, and the endpoint
> doesn't have the 'subflow' one. So stop early when dealing with this
> specific case.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
> v2:
>  - clarify the modifications: new comment and updated description (Mat)

The new comment (with the one fix above) does make it clearer, thank you!

Reviewed-by: Mat Martineau <martineau@kernel.org>

> ---
> net/mptcp/pm_netlink.c | 16 +++++++++-------
> 1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index ff1e5695dc1db5e32d5f45bef7cf22e43aea0ef1..1a0695e087af02347678b9b6914d303554bcf1f3 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1923,11 +1923,16 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
> }
>
> static void mptcp_nl_set_flags(struct net *net, struct mptcp_addr_info *addr,
> -			       u8 bkup, u8 changed)
> +			       u8 flags, u8 changed)
> {
> +	u8 is_subflow = !!(flags & MPTCP_PM_ADDR_FLAG_SUBFLOW);
> +	u8 bkup = !!(flags & MPTCP_PM_ADDR_FLAG_BACKUP);
> 	long s_slot = 0, s_num = 0;
> 	struct mptcp_sock *msk;
>
> +	if (changed == MPTCP_PM_ADDR_FLAG_FULLMESH && !is_subflow)
> +		return;
> +
> 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
> 		struct sock *sk = (struct sock *)msk;
>
> @@ -1937,7 +1942,8 @@ static void mptcp_nl_set_flags(struct net *net, struct mptcp_addr_info *addr,
> 		lock_sock(sk);
> 		if (changed & MPTCP_PM_ADDR_FLAG_BACKUP)
> 			mptcp_pm_nl_mp_prio_send_ack(msk, addr, NULL, bkup);
> -		if (changed & MPTCP_PM_ADDR_FLAG_FULLMESH)
> +		/* Subflows will only be recreated if the SUBFLOW flag is set */
> +		if (is_subflow && (changed & MPTCP_PM_ADDR_FLAG_FULLMESH))
> 			mptcp_pm_nl_fullmesh(msk, addr);
> 		release_sock(sk);
>
> @@ -1959,7 +1965,6 @@ int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
> 	struct mptcp_pm_addr_entry *entry;
> 	struct pm_nl_pernet *pernet;
> 	u8 lookup_by_id = 0;
> -	u8 bkup = 0;
>
> 	pernet = pm_nl_get_pernet(net);
>
> @@ -1972,9 +1977,6 @@ int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
> 		}
> 	}
>
> -	if (local->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
> -		bkup = 1;
> -
> 	spin_lock_bh(&pernet->lock);
> 	entry = lookup_by_id ? __lookup_addr_by_id(pernet, local->addr.id) :
> 			       __lookup_addr(pernet, &local->addr);
> @@ -1996,7 +1998,7 @@ int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
> 	*local = *entry;
> 	spin_unlock_bh(&pernet->lock);
>
> -	mptcp_nl_set_flags(net, &local->addr, bkup, changed);
> +	mptcp_nl_set_flags(net, &local->addr, entry->flags, changed);
> 	return 0;
> }
>
>
> -- 
> 2.47.1
>
>
>
