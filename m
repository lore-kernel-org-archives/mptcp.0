Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B453596B
	for <mptcp@lists.linux.dev>; Thu, 25 Sep 2025 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817278; cv=none; b=MzVpAdcAZJVKEt11hbeP4WyesH81AhuTXlLkS+HQ6Dhl/o7L1MyukGT0dCWFBKMiLhXnXyXGVY7JncN4MN18DNrtmM1HQp3mJ4OwRAuDE8urcShQWTVE0CVFkcHRfVJAWWBkI7njEJVjHClaHxCQQDxjFCJVNJPjReKlC4VOCQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817278; c=relaxed/simple;
	bh=nj+mG5LXLOPFh6RF0UwUf4wrqBfAqNXDc/9jlWr5ELY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HQoIaR3G8u8r6BkvIAIYfEWK+5LfDoIXonPztT2Ul9apshTnyKd1cYCmiwRsdObtx6HISlYKpqLMPid5MxqHMcCQWhG/XAChef0p8P/PrEFpeD7QxOZx03Br+xqmZ0+yuu5Ex7IVHhMMnJjTjUXhfZVlqP0bLIOd59mCPQeQOYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cC//yJon; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cC//yJon"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E473C4CEF0;
	Thu, 25 Sep 2025 16:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758817275;
	bh=nj+mG5LXLOPFh6RF0UwUf4wrqBfAqNXDc/9jlWr5ELY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=cC//yJonw40x2Y7HvkpFRfzCNYz+JLWMa2Ss9Wbm5ZO5rGGCakcvlTBfKwEPcvs59
	 lzbPY6R5R6LTWcUyhYBGeWqFSyf3XZPlyHKmI4dMREuCy1dcT2sK/9G2XTV+GZVZfq
	 hxvnWkjLy8UJdEEQJoKPtiXjH2TIeJ/Z0vvpYqSN6/6UYZu+blEGVKGuJioAHRGnnF
	 +aPSQydJyxMSNS/zrClaJ7lUow9CwfeorbBj8/KjIAErRFFkd//8NzVyA8PYI55hwh
	 kLsefIcw/NsAS1uFfDmqJDTiRKNCJ6O9rRlhii0n3U/etR4bWTEwTmccUNoqGpqjXt
	 55vivEhv/OJuA==
Date: Thu, 25 Sep 2025 09:21:15 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next v3 6/6] selftests: mptcp: join: validate new
 laminar endp
In-Reply-To: <20250925-pm-kern-endp-add_addr-new-v3-6-1697a14ffa7d@kernel.org>
Message-ID: <7d3ff782-3623-6ce0-dbc3-1c508d04d1be@kernel.org>
References: <20250925-pm-kern-endp-add_addr-new-v3-0-1697a14ffa7d@kernel.org> <20250925-pm-kern-endp-add_addr-new-v3-6-1697a14ffa7d@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 25 Sep 2025, Matthieu Baerts (NGI0) wrote:

> Here are a few sub-tests for mptcp_join.sh, validating the new 'laminar'
> endpoint type.
>
> In a setup where subflows created using the routing rules would be
> rejected by the listener, and where the latter announces one IP address,
> some cases are verified:
>
> - Without any 'laminar' endpoints: no new subflows are created.
>
> - With one 'laminar' endpoint: a second subflow is created.
>
> - With multiple 'laminar' endpoints: 2 IPv4 subflows are created.
>
> - With one 'laminar' endpoint, but the server announcing a second IP
>  address, only one subflow is created.
>
> - With one 'laminar' + 'subflow' endpoint, the same endpoint is only
>  used once.
>

Tests look good, thanks!

Reviewed-by: Mat Martineau <martineau@kernel.org>

> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> v3:
> - rename 'address' -> 'laminar' (Mat)
> - add a new test with 'laminar' + 'subflow' flags
> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 69 +++++++++++++++++++++++++
> tools/testing/selftests/net/mptcp/pm_nl_ctl.c   |  9 ++++
> 2 files changed, 78 insertions(+)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index a94b3960ad5e009dbead66b6ff2aa01f70aa3e1f..c90d8e8b95cbb6ba80f79208d1cc844673f2c249 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2320,6 +2320,74 @@ signal_address_tests()
> 	fi
> }
>
> +laminar_endp_tests()
> +{
> +	# no laminar endpoints: routing rules are used
> +	if reset_with_tcp_filter "without a laminar endpoint" ns1 10.0.2.2 REJECT &&
> +	   mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_set_limits $ns2 2 2
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		run_tests $ns1 $ns2 10.0.1.1
> +		join_syn_tx=1 \
> +			chk_join_nr 0 0 0
> +		chk_add_nr 1 1
> +	fi
> +
> +	# laminar endpoints: this endpoint is used
> +	if reset_with_tcp_filter "with a laminar endpoint" ns1 10.0.2.2 REJECT &&
> +	   mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_set_limits $ns2 2 2
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags laminar
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr 1 1 1
> +		chk_add_nr 1 1
> +	fi
> +
> +	# laminar endpoints: these endpoints are used
> +	if reset_with_tcp_filter "with multiple laminar endpoints" ns1 10.0.2.2 REJECT &&
> +	   mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_set_limits $ns2 2 2
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> +		pm_nl_add_endpoint $ns2 dead:beef:3::2 flags laminar
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags laminar
> +		pm_nl_add_endpoint $ns2 10.0.4.2 flags laminar
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr 2 2 2
> +		chk_add_nr 2 2
> +	fi
> +
> +	# laminar endpoints: only one endpoint is used
> +	if reset_with_tcp_filter "single laminar endpoint" ns1 10.0.2.2 REJECT &&
> +	   mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_set_limits $ns2 2 2
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags laminar
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr 1 1 1
> +		chk_add_nr 2 2
> +	fi
> +
> +	# laminar endpoints: subflow and laminar flags
> +	if reset_with_tcp_filter "sublow + laminar endpoints" ns1 10.0.2.2 REJECT &&
> +	   mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
> +		pm_nl_set_limits $ns1 0 4
> +		pm_nl_set_limits $ns2 2 4
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,laminar
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,laminar
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr 1 1 1
> +		chk_add_nr 1 1
> +	fi
> +}
> +
> link_failure_tests()
> {
> 	# accept and use add_addr with additional subflows and link loss
> @@ -4109,6 +4177,7 @@ all_tests_sorted=(
> 	f@subflows_tests
> 	e@subflows_error_tests
> 	s@signal_address_tests
> +	L@laminar_endp_tests
> 	l@link_failure_tests
> 	t@add_addr_timeout_tests
> 	r@remove_tests
> diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> index d4981b76693bbddca74169437a540ad6294cf1d5..65b374232ff5ac06876dcd621fd2109c4d82cd12 100644
> --- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> +++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> @@ -830,6 +830,8 @@ int add_addr(int fd, int pm_family, int argc, char *argv[])
> 					flags |= MPTCP_PM_ADDR_FLAG_SUBFLOW;
> 				else if (!strcmp(tok, "signal"))
> 					flags |= MPTCP_PM_ADDR_FLAG_SIGNAL;
> +				else if (!strcmp(tok, "laminar"))
> +					flags |= MPTCP_PM_ADDR_FLAG_LAMINAR;
> 				else if (!strcmp(tok, "backup"))
> 					flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
> 				else if (!strcmp(tok, "fullmesh"))
> @@ -1018,6 +1020,13 @@ static void print_addr(struct rtattr *attrs, int len)
> 					printf(",");
> 			}
>
> +			if (flags & MPTCP_PM_ADDR_FLAG_LAMINAR) {
> +				printf("laminar");
> +				flags &= ~MPTCP_PM_ADDR_FLAG_LAMINAR;
> +				if (flags)
> +					printf(",");
> +			}
> +
> 			if (flags & MPTCP_PM_ADDR_FLAG_BACKUP) {
> 				printf("backup");
> 				flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
>
> -- 
> 2.51.0
>
>
>
