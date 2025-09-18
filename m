Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB36B315D3A
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212988; cv=none; b=G2ZqgvcFU97rUyFT/t32eE7Vm3lgvwu0V0XHmQlJxKCMbdZFH9xTmQm7ZbVbMGvF0iPukkgxjMWQsgCbvh9kxw/Luu6pvblX5MsGQ6Di6BjZSGShZIYmdFRqk17cY0DQOgyBIF9in2/0ypQLvUaCfsxX3dBJipE5eznMdu58mQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212988; c=relaxed/simple;
	bh=io3Bg9ao1VouLRigE0Z46PgAqHjx7x6JaOOZPHjuHJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UrqW/hhXt/yYE3Spw5xkPkFY8HuJl67oMMj9o1uQJMe9idBBgKsGGQ1FaiKutfW08xybGMGtu2sZaz6jXreb6yQ2OHE4ka2d+lrUWAfre8/3ZYzN40myHWyNxEHp0Kxyz2qOfE5iKBGGG1CrUtewKY6K462iO0Ag59iHVGza36Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABZVBysM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABZVBysM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133C1C4CEE7
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 16:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758212988;
	bh=io3Bg9ao1VouLRigE0Z46PgAqHjx7x6JaOOZPHjuHJ8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ABZVBysMG04pEfYOf5/Up12AeByAir7bcI5qIvIGMm3DqZOqepU6pSDwC40N7yb7z
	 VEp7sCUymaXd0fZ9T94gDlFz7XFRtJnXF92MILRYYbyTty5oWiFl8su0tkvUZNfIZL
	 7se+6iWfKUJatUO1jBtDoL6DwLxSqZPRw+d7x8oaUQns3rc9VVa8g1FuX9KHOyCPQW
	 NMhl/trm0qu3tWfLx/T8qK1N5K0nfIetM5CAyjwHWZD/HmGMz2RNrYP4XNCAqIKRZA
	 Blk3eaX+iCULgz/pAkiEFEg51ZtTqOUzcWIeKAHqWlLUSqsYL1Zr2oR4ZTW1LxRMyq
	 10sXri8itIj5Q==
Message-ID: <7ecc8d89-6454-4b83-bef5-3b7d66fe2655@kernel.org>
Date: Thu, 18 Sep 2025 18:29:45 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 1/2] mptcp: pm: in-kernel: usable client side
 with C-flag
To: MPTCP Linux <mptcp@lists.linux.dev>
References: <20250916-pm-c-flag-client-default-v2-0-3be2c5bc4d6a@kernel.org>
 <20250916-pm-c-flag-client-default-v2-1-3be2c5bc4d6a@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: en-GB, fr-BE
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250916-pm-c-flag-client-default-v2-1-3be2c5bc4d6a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 16/09/2025 13:01, Matthieu Baerts (NGI0) wrote:
> When servers set the C-flag in their MP_CAPABLE to tell clients not to
> create subflows to the initial address and port, clients will likely not
> use their other endpoints. That's because the in-kernel path-manager
> uses the 'subflow' endpoints to create subflows only to the initial
> address and port.
> 
> If the limits have not been modified to accept ADD_ADDR, the client
> doesn't try to establish new subflows. If the limits accept ADD_ADDR,
> the routing routes will be used to select the source IP.
> 
> The C-flag is typically set when the server is operating behind a legacy
> Layer 4 load balancer, or using anycast IP address. Clients having their
> different 'subflow' endpoints setup, don't end up creating multiple
> subflows as expected, and causing some deployment issues.
> 
> A special case is then added here: when servers set the C-flag in the
> MPC and directly sends an ADD_ADDR, this single ADD_ADDR is accepted.
> The 'subflows' endpoints will then be used with this new remote IP and
> port. This exception is only allowed when the ADD_ADDR is sent
> immediately after the 3WHS, and makes the client switching to the 'fully
> established' mode. After that, 'select_local_address()' will not be able
> to find any subflows, because 'id_avail_bitmap' will be filled in
> mptcp_pm_create_subflow_or_signal_addr(), when switching to 'fully
> established' mode.
> 
> Fixes: df377be38725 ("mptcp: add deny_join_id0 in mptcp_options_received")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/536
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
> - I tried to find a simple solution that can hopefully be backported to
>   cover the 'CDN' use-case.
> - I tried to find a solution respecting the 'accepted add addr' limit,
>   but I don't see how to... That's why here I limit the exception a
>   maximum: when this limit is 0 (default case), only the first ADD_ADDR,
>   etc. Feel free to share what you think about that.
> - I have some additional code doing some cleanup, and I started to look
>   at #503, which is a bit linked to that.
> - v2: move conditions to new helper (Geliang) + rename var, squash comm.

(...)
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index f30df8e884a0b3de9fb092e5774cafe08f6350ce..d7cd89fa6a11a1ea7703edbfbdf2bbe86a6a3054 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c

(...)

> @@ -409,6 +411,10 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
>  			locals[i].flags = entry->flags;
>  			locals[i].ifindex = entry->ifindex;
>  
> +			if (c_flag_case)

Small note: here, it should be:

  if (c_flag_case && (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))

(but this doesn't change the global idea of this patch, I can apply it
when applying the patch)

> +				__clear_bit(locals[i].addr.id,
> +					    msk->pm.id_avail_bitmap);
> +
>  			/* Special case for ID0: set the correct ID */
>  			if (mptcp_addresses_equal(&locals[i].addr, &mpc_addr, locals[i].addr.port))
>  				locals[i].addr.id = 0;

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

