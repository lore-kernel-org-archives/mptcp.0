Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD902A95E
	for <mptcp@lists.linux.dev>; Fri, 14 Nov 2025 01:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763083821; cv=none; b=hk5DOj7ZiSpVYkjuDJ/wnzJ3OQBoxzvBG1+/fHF6D4FJVrSCoyiveXxv8/zwTeP6SDkskBMCzNXDjE20N//PgK9n6KBGuUYc5DY+BASjPq0Pp0nbVyBety3vtjHiDDOtsXkUiBK5NX2I2PkwrvYEr+resf25XiKuPVY3Y9X5MF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763083821; c=relaxed/simple;
	bh=2to9946Qzs8QEtSfLIorDPayF68AU5d0pBj4oIUdVnY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GspX+26ccCBacq1BeV3Fpj8t5TtaxFKU9xNg/gPTumg0tvApXi+9wbSfPQJZcU5AQq3dMo+S6bKn0EQA4qk7lu9aZJxF9NObnExUN3q+D9NPo8aYdLolS9LDItCd4GxSzqCfRZkMEnB8snhVQfvVwLQGvUah9owBOyr8caH33OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZX0z4KSv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZX0z4KSv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AE7C4AF09;
	Fri, 14 Nov 2025 01:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763083821;
	bh=2to9946Qzs8QEtSfLIorDPayF68AU5d0pBj4oIUdVnY=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=ZX0z4KSvi37A+Emwe7njK2Jd6F0KjRfLN89tvcG188uwizFJU9X2MjnUoTarkY+Os
	 JrBQL05JEsFTrXMehBpT41OyyWUM4ohxRTGcLnlaoEIVtqFubLOsm4+cjelRSxob3/
	 d1uGVyPqBBJ2KYVkkqCTQa7IzuA6e4IEXkKGnruJS25aSC7emieTl3xlsy9/nrff0s
	 xFy6J4uE5yOBypX36pjAKnI9m2jBFZwClDLchwve6R9z9pDDY7mC3GCfmiVJqckYo0
	 Fsl/AQ9mlSiC0K4hSDU2+3o4Xbiaq6lxgR1SmmS+lHO2C4S9JfDjbxWWlhZU07Og9t
	 n1fgtv3G8LNZQ==
Message-ID: <19e9fe8e0ebbfe2dce632c29771df9eeed470d2e.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: get stats just
 before timing out"
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Fri, 14 Nov 2025 09:30:18 +0800
In-Reply-To: <20251113-slft-timeout-stats-kill-v1-1-9a09d8f46392@kernel.org>
References: <20251113-slft-timeout-stats-kill-v1-1-9a09d8f46392@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for this fix.

On Thu, 2025-11-13 at 12:11 +0100, Matthieu Baerts (NGI0) wrote:
> Geliang reported that mptcp_connect.sh test runtime got increased
> after
> this patch.
> 
> That's because the previous 'kill' command was only killing the
> background job, but the 'sleep' command was still running.
> 
> It is not very clear to me why there was a delay at the end, but
> switching to mptcp_lib_kill_group_wait to kill the background job and
> the running command fixed the issue. The new code is also looking
> clearer I think, so that's good.
> 
> Link:
> https://lore.kernel.org/2a6869ca39bda7ddf8b486cd03e0867b30e0d565.camel@kernel.org
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

It works.

    Reviewed-by: Geliang Tang <geliang@kernel.org>

-Geliang

> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 7 ++++++-
>  tools/testing/selftests/net/mptcp/mptcp_join.sh    | 7 ++++++-
>  tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 7 ++++++-
>  tools/testing/selftests/net/mptcp/simult_flows.sh  | 7 ++++++-
>  4 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index 458b07673910..a6447f7a31fe 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -415,7 +415,12 @@ do_transfer()
>  	local retc=$?
>  	wait $spid
>  	local rets=$?
> -	kill $timeout_pid 2>/dev/null && timeout_pid=0
> +
> +	if kill -0 $timeout_pid; then
> +		# Finished before the timeout: kill the background
> job
> +		mptcp_lib_kill_group_wait $timeout_pid
> +		timeout_pid=0
> +	fi
>  
>  	local stop
>  	stop=$(date +%s%3N)
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 222babd43682..7a72efcf1403 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1063,7 +1063,12 @@ do_transfer()
>  	local retc=$?
>  	wait $spid
>  	local rets=$?
> -	kill $timeout_pid 2>/dev/null && timeout_pid=0
> +
> +	if kill -0 $timeout_pid; then
> +		# Finished before the timeout: kill the background
> job
> +		mptcp_lib_kill_group_wait $timeout_pid
> +		timeout_pid=0
> +	fi
>  
>  	cond_stop_capture
>  
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> index 326466f2f6eb..ab8bce06b262 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> @@ -193,7 +193,12 @@ do_transfer()
>  	local retc=$?
>  	wait $spid
>  	local rets=$?
> -	kill $timeout_pid 2>/dev/null && timeout_pid=0
> +
> +	if kill -0 $timeout_pid; then
> +		# Finished before the timeout: kill the background
> job
> +		mptcp_lib_kill_group_wait $timeout_pid
> +		timeout_pid=0
> +	fi
>  
>  	mptcp_lib_nstat_get "${listener_ns}"
>  	mptcp_lib_nstat_get "${connector_ns}"
> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh
> b/tools/testing/selftests/net/mptcp/simult_flows.sh
> index cc4d40d149e2..806aaa7d2d61 100755
> --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
> +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
> @@ -178,7 +178,12 @@ do_transfer()
>  	local retc=$?
>  	wait $spid
>  	local rets=$?
> -	kill $timeout_pid 2>/dev/null && timeout_pid=0
> +
> +	if kill -0 $timeout_pid; then
> +		# Finished before the timeout: kill the background
> job
> +		mptcp_lib_kill_group_wait $timeout_pid
> +		timeout_pid=0
> +	fi
>  
>  	if $capture; then
>  		sleep 1
> 
> ---
> base-commit: 6861f291b7a3bc40235e996f5605c477f55ce9e0
> change-id: 20251113-slft-timeout-stats-kill-444931425af7
> 
> Best regards,
