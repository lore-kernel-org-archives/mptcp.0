Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6B42EB5A1
	for <mptcp@lists.linux.dev>; Tue, 14 Oct 2025 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436661; cv=none; b=Cv3npwaJiAT9coyIzEPUviKQWKgpOO8Wuiz4qNzXnvK+cLy6gfpqJu8JPAy7GbZftzvjBzJOxprMTiLhylAQ3sugqLfOnUswTP/aU2OrC75wVztah2rFGKHHI4EkDZHW1poNWyIAm9t3qCV2hK7Gc1i+IHNXbGRohMDCNlhhUnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436661; c=relaxed/simple;
	bh=lm6zjqqeuUX/GhuRhwvCiwpwFPrKyKb9JLYiQVJlUKE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y7Gt6OJqEF1lv+Asdfh6JCJqqQ4HCJRJKrHSQOu/mYN0JgAHGE/r43VWgrAdKO/kYeSpIuOxKpjNmQ7xOEla9QsNR/RW7e4U+wpiHUHaM7VPcpPkL4vqt890tgZJVtG3KtUmKybjb9GpAsruZO3OyB07VMDUNOgO1ghpa0X8ui8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmU096jM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmU096jM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B0AC4CEE7;
	Tue, 14 Oct 2025 10:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760436660;
	bh=lm6zjqqeuUX/GhuRhwvCiwpwFPrKyKb9JLYiQVJlUKE=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=YmU096jM1iIrohymRCn7qYMBTT9FsCiP49SkHeJkJFncz9X25kod7uZuwG0KWYQNP
	 vf5RCDWMKJVDWU0uE8EodQuNJnWNsZQR1S77s2+y31HLKq6LKDOdOJhRiIyFIdWNjY
	 dCV21VDX9u1QlBSXFjkNDy2aegfa2BqV8DPHQWh3B4zqlq7ZRTjkSZREN0Av/ZwyWr
	 ACkQhjCzJ5EU7pXUfQfT+WfO6Yqjjgq1s3K8A72x2MjHXM8nJJ32frCObUE41fT68Q
	 jh/eBzRSbYSZro6fJWkrONyP7XoTZvKHv5PjaUeRdCJHXWWTKmWjEqN5QuS1qEr6Oz
	 +sacRsdMKqXvQ==
Message-ID: <8d1cf5304a2060799a2e3e54ed33a1f572f60e17.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 7/7] mptcp: pm: in kernel: only use fullmesh
 endp if any
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Tue, 14 Oct 2025 18:10:55 +0800
In-Reply-To: <20251008-c-flag-add-addr-delay-v1-7-c624eb3bf10d@kernel.org>
References: <20251008-c-flag-add-addr-delay-v1-0-c624eb3bf10d@kernel.org>
	 <20251008-c-flag-add-addr-delay-v1-7-c624eb3bf10d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Wed, 2025-10-08 at 16:00 +0200, Matthieu Baerts (NGI0) wrote:
> Our documentation is saying that the in-kernel PM is only using
> fullmesh
> endpoints to establish subflows to announced addresses when at least
> one
> endpoint has a fullmesh flag. But this was not totally correct: only
> fullmesh endpoints were used if at least one endpoint *from the same
> address family as the received ADD_ADDR* has the fullmesh flag.
> 
> This is confusing, and it seems clearer not to have differences
> depending on the address family.
> 
> So, now, when at least one MPTCP endpoint has a fullmesh flag, the
> local
> addresses are picked from all fullmesh endpoints, which might be 0 if
> there are no endpoints for the correct address family.
> 
> One selftest needs to be adapted for this behaviour change.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

This patch LGTM!

Reviewed-by: Geliang Tang <geliang@kernel.org>

Except for patch 1, I have added my reviewed-by tags to all other
patches. Please give me some more time to review patch 1. If you're
willing, please apply patches 2-7 first.

Thanks,
-Geliang

> ---
>  net/mptcp/pm_kernel.c                           | 10 +++-------
>  tools/testing/selftests/net/mptcp/mptcp_join.sh |  6 +++++-
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index 054d85045381..40a0572b3149 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -609,15 +609,11 @@ fill_local_addresses_vec(struct mptcp_sock
> *msk, struct mptcp_addr_info *remote,
>  			 struct mptcp_pm_local *locals)
>  {
>  	bool c_flag_case = remote->id &&
> mptcp_pm_add_addr_c_flag_case(msk);
> -	int i;
>  
>  	/* If there is at least one MPTCP endpoint with a fullmesh
> flag */
> -	if (mptcp_pm_get_endp_fullmesh_max(msk)) {
> -		i = fill_local_addresses_vec_fullmesh(msk, remote,
> locals,
> -						      c_flag_case);
> -		if (i)
> -			return i;
> -	}
> +	if (mptcp_pm_get_endp_fullmesh_max(msk))
> +		return fill_local_addresses_vec_fullmesh(msk,
> remote, locals,
> +							
> c_flag_case);
>  
>  	/* If there is at least one MPTCP endpoint with a laminar
> flag */
>  	if (mptcp_pm_get_endp_laminar_max(msk))
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 78a1aa4ecff2..e7a498dd5a46 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2952,7 +2952,11 @@ mixed_tests()
>  		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
>  		speed=slow \
>  			run_tests $ns1 $ns2 dead:beef:2::1
> -		chk_join_nr 1 1 1
> +		if mptcp_lib_kallsyms_has
> "mptcp_pm_get_endp_fullmesh_max$"; then
> +			chk_join_nr 0 0 0
> +		else
> +			chk_join_nr 1 1 1
> +		fi
>  	fi
>  
>  	# fullmesh still tries to create all the possibly subflows
> with
> 

