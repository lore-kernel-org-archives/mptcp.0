Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7CF28FF
	for <mptcp@lists.linux.dev>; Sat, 12 Apr 2025 00:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744416685; cv=none; b=ZDywSX1lQj1Mnqm1C1cyRqd636k6x+SB0MvSnoEbd4yBHENY44jx6PLHlY05jybT4KBqwdgCEWm0Zi7+3Y9dFZnySlXXaK3m5diewGzvGzyIPfwtvMyDZq+n6Ewz6dX+wWulHDfu1rcRn3b+SU9evhYMgjGmTZvue9/jGGi/MLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744416685; c=relaxed/simple;
	bh=uO1c9m68mplSnahIYUtiNifJ2AWKXP1Gfw2Pg5DX8BQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cuWx2FMpT/dd05I2+rN/3hui2o0PLdcVtEB1E/wNcNB8BVB4/vMJDglJdxpdL1294FpLBD/K0SPfcrZg2PSgVoth/JvSRCPY4wL/9BP+by7sE6jiidyaeerVXiKuXGLEwBrJgFsocqJcj0HOeIpbke+el/wN2lf45KaZ9Dqyc68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLsN3bzs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLsN3bzs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B9CC4CEE2;
	Sat, 12 Apr 2025 00:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744416685;
	bh=uO1c9m68mplSnahIYUtiNifJ2AWKXP1Gfw2Pg5DX8BQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=fLsN3bzstePTwKg4YDzuPbCwyz6Y9ydfqW+hLB9jBXjBmiNeTqFLwLh+rvcuYMxf1
	 iFqbX7k8GiEZyZ24K15bkOklkr/zqFvokSFvficniOSzhNEqgdbl06K4BaAKJ93HgM
	 klYCu5jordRr+oQa5+bTKMz74oAnbRge3iamoz3FC/mXLBDhG3FPy4rkCQJRKgEyME
	 WnZGQsP11h/9CDQWr9AUn+ZGrIEB9CaVIb/WLgYOY6ikT664Zl8YRJTNZE8namKszm
	 Qya5axseMTI8+lKQkX2tlC/GozWYrWR1Cu3CWJBsJ4N6xrltkvxSvc3JEl8BnjpGOr
	 1OcujJYHPouaA==
Date: Fri, 11 Apr 2025 17:11:24 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v2] mptcp: pm: Defer freeing of MPTCP userspace
 path manager entries
In-Reply-To: <c1a833c4-0ec8-48b3-b2b0-cd9b5e8f050f@kernel.org>
Message-ID: <b170929e-8adb-5bbb-a51b-9bd7368b1706@kernel.org>
References: <20250410224503.2056587-1-martineau@kernel.org> <c1a833c4-0ec8-48b3-b2b0-cd9b5e8f050f@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 11 Apr 2025, Matthieu Baerts wrote:

> Hi Mat,
>
> On 11/04/2025 00:44, Mat Martineau wrote:
>> When path manager entries are deleted from the local address list, they
>> are first unlinked from the address list using list_del_rcu(). The
>> entries must not be freed until after the RCU grace period, but the
>> existing code immediately frees the entry.
>>
>> Use kfree_rcu_mightsleep() and adjust sk_omem_alloc in open code instead
>> of using the sock_kfree_s() helper. This code path is only called in a
>> netlink handler, so the "might sleep" function is preferable to adding
>> a rarely-used rcu_head member to struct mptcp_pm_addr_entry.
>>
>> Fixes: 88d097316371 ("mptcp: drop free_list for deleting entries")
>> Signed-off-by: Mat Martineau <martineau@kernel.org>
>> ---
>>
>> v2: Add comment explaining connection to sock_kfree_s, add "Fixes" tag
>
> Thank you for the v2, and your reply on my previous review. This v2
> looks good to me:
>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
> I guess I should wait to apply "only remove entry from local_addr_list
> when sending a REMOVE_ADDR" series first then, right? Are these other
> patches supposed to be fixes for net? They are not marked as that for
> the moment: in that case, should we add another patch to fix
> mptcp_userspace_pm_delete_local_addr() as well?
>

I don't think there's any issue or conflict with applying this to 
export-net first, it would leave the bug not fixed in 
mptcp_userspace_pm_delete_local_addr(). If this patch needs to stand 
alone, then it would need to be reworked to add a struct rcu_head to the 
local addr entry because mptcp_userspace_pm_delete_local_addr() gets 
called in contexts where sleepable calls aren't allowed.

I'll reply separately to v2 of the "only remove entry from local_addr_list 
when sending a REMOVE_ADDR" series.

- Mat
