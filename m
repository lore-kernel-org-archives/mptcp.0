Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DB625771
	for <mptcp@lists.linux.dev>; Sat, 18 Apr 2026 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776536546; cv=none; b=C9M4RJDSDX5CfOjiNztSgNVisocjOk3ooWT7qNDvUpslbsbleV6yDInU3Pdg68vQZg3qcIXyfjKgeCD3OPouAGuDfr1V/85fxgUg4ei5lfUjiHrHPb6tRcBjW2ljLZx9N4zfV7/0myZ1JaNDja1jZvWD8T52cFrc+uqiu16+8g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776536546; c=relaxed/simple;
	bh=2cYe1/We7L4+4EHrJvialLvvlnO0ZwQTk3HrSfSipkQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CIX3V57/MnCB2k5AEugiwBwTAY+FcBu6l3t4BBEyrRHyPjyAZeTaKg7RRtEcATbRhPI+leFH7M5tGLMcBtG+W/pX+K/rCq2Q0IhwetnOZsTUhby6U7asJvWvEAn5sLWm71kWmzJIOIO2XP/rUvwmrsQeiY7f14895FLAqx2PZs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aj4mEF6Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aj4mEF6Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8833C19424;
	Sat, 18 Apr 2026 18:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776536545;
	bh=2cYe1/We7L4+4EHrJvialLvvlnO0ZwQTk3HrSfSipkQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Aj4mEF6ZUAqW8p4v4KF+51c3VUks5G3sE5zWn6IjnhUJ1qU4d5H2JpTmduSaJa9tG
	 T9taw/JPKKa3ZaS1sOrFGTosBCA0uusQi5D5ST4YXJW/f1GksRAxMHrpnhUC7S+VeH
	 pTE+GvfmddsD5SPhBH2ZPPU/NVQiL767wDmRCsCBBKGDGb68VMbRQFUjyZnlBUyGE4
	 xKeQRvPi7wZLS6ZetAsWfyZxY2r8/pOMnkAKQ0EbGdZEdMLwoXUN4hM+23Xv2MwYMF
	 Ul9QT/9nFa0XmBVuPa1c8lh5C42r8CQJeaPyM/5GhY5+bOuvudjBg8iPSlMnElcP82
	 QIIGjSgb5ncYQ==
Date: Sat, 18 Apr 2026 11:22:25 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net v5 17/20] selftests: mptcp: join: validate 8x8
 subflows
In-Reply-To: <20260415-mptcp-inc-limits-v5-17-e54c3bf80e4e@kernel.org>
Message-ID: <54880733-bd55-a589-20bd-3806585c6e14@kernel.org>
References: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org> <20260415-mptcp-inc-limits-v5-17-e54c3bf80e4e@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 15 Apr 2026, Matthieu Baerts (NGI0) wrote:

> The limits have been recently increased, it is required to validate that
> having 64 subflows is allowed.
>
> Here, both the client and the server have 8 network interfaces. The
> server has 8 endpoints marked as 'signal' to announce all its v4
> addresses. The client also has 8 endpoints, but marked as 'subflow' and
> 'fullmesh' in order to create 8 subflows to each address announced by
> the server. This means 63 additional subflows will be created after the
> initial one.
>
> If it is not possible to increase the limits to 64, it means an older
> kernel version is being used, and the test is skipped.
>

Does this have much of an impact on total time for the tests? Would it be 
worthwhile to test the larger limits on kernels that can handle it, and 
run the existing tests on older kernels?

In other words, the larger limit test seems to have redundant coverage 
with some older tests, so maybe skip the redundant tests on new kernels.

- Mat

> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 28 +++++++++++++++++++++++++
> 1 file changed, 28 insertions(+)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 28da9df797ae..c6bb345d056b 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -513,6 +513,19 @@ reset_with_tcp_filter()
> 	fi
> }
>
> +# For kernel supporting limits above 8
> +# $1: title ; $2,4: addrs limit ns1,2 ; $3,5: subflows limit ns1,2
> +reset_with_high_limits()
> +{
> +	reset "${1}" || return 1
> +
> +	if ! pm_nl_set_limits "${ns1}" "${2}" "${3}" 2>/dev/null ||
> +	   ! pm_nl_set_limits "${ns2}" "${4}" "${5}" 2>/dev/null; then
> +		mark_as_skipped "unable to set the limits to ${*:2}"
> +		return 1
> +	fi
> +}
> +
> # $1: err msg
> fail_test()
> {
> @@ -3670,6 +3683,21 @@ fullmesh_tests()
> 		chk_prio_nr 0 1 1 0
> 		chk_rm_nr 0 1
> 	fi
> +
> +	# fullmesh in 8x8 to create 63 additional subflows
> +	if ifaces_nr=8 reset_with_high_limits "fullmesh 8x8" 64 64 64 64; then
> +		# higher chance to lose ADD_ADDR: allow retransmissions
> +		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
> +		local i
> +		for i in $(seq 1 8); do
> +			pm_nl_add_endpoint $ns2 10.0.$i.2 flags subflow,fullmesh
> +			pm_nl_add_endpoint $ns1 10.0.$i.1 flags signal
> +		done
> +		speed=slow \
> +			run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr 63 63 63
> +	fi
> +
> }
>
> fastclose_tests()
>
> -- 
> 2.53.0
>
>
>
