Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516F426ACB
	for <mptcp@lists.linux.dev>; Tue, 21 Jan 2025 23:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737502806; cv=none; b=ausleuKQvrXbK1Vf7j09BBVVFwiHPa7g31RsCbqPZF5RdTYflYQLIzwoi4LdhqbW5ZKTb1Rs1TTSnyYk1snpsidf7VexN4zxl1/7Ooac1xTd55EiFlloTSFOOB5C4pbsmWFPAZk3fwEmnkFXJRYGZmKbil2/5INRE+TVj96MKfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737502806; c=relaxed/simple;
	bh=Pa+PGLyjcGsEkj4Z7vVNxI+Pk68/U87RVHX+M0+bTEE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PclgmMtVgR380Jpb8KcFawrXmUJ9PqwZXNCZwR6sHG3Hz8Q1jX4P7opiMoFZvSeJ6/Cf5Og36dPgPpEha4u7HapeqMS0ZgJLm5LSsWa1SrPWMDVTsLefaRTYj4Pwtjps8FuN52LA2aHqvUZycUVNA/6KeK4PBL67OS9tm0Fi5wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRJCHFyO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRJCHFyO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B96C4CEE1;
	Tue, 21 Jan 2025 23:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737502805;
	bh=Pa+PGLyjcGsEkj4Z7vVNxI+Pk68/U87RVHX+M0+bTEE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=sRJCHFyOoLgyW24eKlUoj+67SD6Ow9SMP7A+mVDq+a2BaFdCb22aVO9D5j5H7xiUb
	 p+aA+K9oSQLwrAA/eWpE6q3sWP2nJ1rUYlaHo1SBY6Dnvwoa0aajDYN1HVCflEKE5K
	 PtSz+kEVJs8mqMw+pvuv+Z+VQ2vKVHiewn+Cq8FgEhsxtcQzcyDwz16Pk6wrP6AFU5
	 ZUK9wTnvakfmuG1p5B+Q/HXQFO5Qj3z1MZl8jYC2I8W7iQsfuboCwxIvzZdB7SPISf
	 7k6kjbwGpvFkRh4tYlRU4vri4e1dBchEIiOzx1taLgRwfff50yPsuDz0d7xvCZ2q4x
	 pIUlZq9Rs2i0Q==
Date: Tue, 21 Jan 2025 15:40:03 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v2 3/3] mptcp: pm: change to fullmesh only for
 'subflow'
In-Reply-To: <20250117-mptcp-issue-540-v2-3-a194740fb380@kernel.org>
Message-ID: <78fc5ea9-c662-8d72-7f97-5880de6e9762@kernel.org>
References: <20250117-mptcp-issue-540-v2-0-a194740fb380@kernel.org> <20250117-mptcp-issue-540-v2-3-a194740fb380@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 17 Jan 2025, Matthieu Baerts (NGI0) wrote:

Hi Matthieu -

> If an entrypoint

Did you mean "endpoint" here?

> has no type -- so not 'subflow', 'signal', 'implicit' --
> there are then no subflows to re-create from this local endpoint.
>
> In this case, there is then no need to iterate over all connections to
> do nothing. So stop early when this case is present.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> net/mptcp/pm_netlink.c | 15 ++++++++-------
> 1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index ff1e5695dc1db5e32d5f45bef7cf22e43aea0ef1..b1fe2a74fcfe97896de8f9eaee9a1afa5378fabb 100644
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
> @@ -1937,7 +1942,7 @@ static void mptcp_nl_set_flags(struct net *net, struct mptcp_addr_info *addr,
> 		lock_sock(sk);
> 		if (changed & MPTCP_PM_ADDR_FLAG_BACKUP)
> 			mptcp_pm_nl_mp_prio_send_ack(msk, addr, NULL, bkup);
> -		if (changed & MPTCP_PM_ADDR_FLAG_FULLMESH)
> +		if (is_subflow && (changed & MPTCP_PM_ADDR_FLAG_FULLMESH))

Could you add something to the beginning of the commit message explaining 
this part of the change? It matches the subject line but the body of the 
commit message only explains the loop optimization above.

Thanks,
Mat

> 			mptcp_pm_nl_fullmesh(msk, addr);
> 		release_sock(sk);
>
> @@ -1959,7 +1964,6 @@ int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
> 	struct mptcp_pm_addr_entry *entry;
> 	struct pm_nl_pernet *pernet;
> 	u8 lookup_by_id = 0;
> -	u8 bkup = 0;
>
> 	pernet = pm_nl_get_pernet(net);
>
> @@ -1972,9 +1976,6 @@ int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
> 		}
> 	}
>
> -	if (local->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
> -		bkup = 1;
> -
> 	spin_lock_bh(&pernet->lock);
> 	entry = lookup_by_id ? __lookup_addr_by_id(pernet, local->addr.id) :
> 			       __lookup_addr(pernet, &local->addr);
> @@ -1996,7 +1997,7 @@ int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
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
