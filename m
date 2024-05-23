Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C4946AF
	for <mptcp@lists.linux.dev>; Thu, 23 May 2024 08:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716453557; cv=none; b=dyG0MzC1ZlWZd7ASO5VbaPUhYovp9gXQw4MjwwaEqk41u7otxQ16Z4S5GIWaA46++e0/NlQKC0GgcszxfXy9tWj33O1Ii9PETTVjVlIYw1DFMl2y+o5D7x4WRBMGQt3OyaWuIPqvjaLSihLoCCKAofeP3Jowr8E+ewG0T4Urv5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716453557; c=relaxed/simple;
	bh=R5ajYMJSCcgInrx3WqsO5GeHVpSPlZgZMM1/r4XaRyY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VOFYDX/X54jXAoOtwwtumWCWoc9doxDmRtWUy8yIS2AGaYq/ErP/tej33eGVs/l6GVKUwjYm970L0FZ973omTKD/w373uHw0aeTG5qmaebEg2H5ykNf4KZzUBTk7HCDhFXrQoVQpkAMOB7GOwid+YnWgELz9zclhFVFxnNDNQ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWgwf4/x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWgwf4/x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C8CC2BD10;
	Thu, 23 May 2024 08:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716453557;
	bh=R5ajYMJSCcgInrx3WqsO5GeHVpSPlZgZMM1/r4XaRyY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=LWgwf4/xa5LY4NpCjGQRw+BHnqZh37HZBV2pWkTV9ppq6Z1JmaiV/uTzd9hfXgyoh
	 sUfZrgMt0MoOOoeYXKIYifUsbkfu+aZ/GK460hBnn+ltJ862+ef/XGFJmqueui1qgd
	 3VOABbn9vPU6K0Jj+dk6DxfQPyUMll+3G14s+zlH940IQh3zMaQN8SlbwNIbJa4ID8
	 ZpholpMI1/G34cTsUd237v6Uz03WNBMm0mbpL3ZDcjBrBbVZoYkRLjriSqmrq8lPmY
	 isJl7TiodRKW1/lsPnJOMMGF1B9D3KQZUyoL0zr8wmQJy1C0VryXwfdjnmH7eiSv5l
	 wViblES+qIfJQ==
Message-ID: <898c6f23907cccc2ab37147fbef5207e9bd0da1e.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 3/4] selftests: mptcp: use cleanup_all_ns
 helper in lib.sh
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Thu, 23 May 2024 16:39:12 +0800
In-Reply-To: <d341c904ef486b7e0039c3812ddd659ef7791f9f.1716451525.git.tanggeliang@kylinos.cn>
References: <cover.1716451525.git.tanggeliang@kylinos.cn>
	 <d341c904ef486b7e0039c3812ddd659ef7791f9f.1716451525.git.tanggeliang@kylinos.cn>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2024-05-23 at 16:08 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch uses cleanup_all_ns() helper defined in lib.sh instead of
> all mptcp_lib_ns_exit() in mptcp seltests. And drop this duplicate
> mptcp helper in mptcp_lib.sh.
> 
> In mptcp_connect.sh, drop mptcp_lib_ns_exit in check_mptcp_disabled()
> directly, this "disabled_ns" will be deleted by cleanup_all_ns() in
> cleanup(), together with "ns1 - ns4".
> 
> In mptcp_join.sh, drop mptcp_lib_ns_exit in cleanup_partial()
> directly,
> each existing namespace will delete automaticly in setup_ns(), only

Sorry, should be "automatically", CI complain about it.

-Geliang

> adding cleanup_all_ns in cleanup() is enough.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/diag.sh          | 2 +-
>  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 3 +--
>  tools/testing/selftests/net/mptcp/mptcp_join.sh    | 3 +--
>  tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 8 --------
>  tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 2 +-
>  tools/testing/selftests/net/mptcp/pm_netlink.sh    | 2 +-
>  tools/testing/selftests/net/mptcp/simult_flows.sh  | 2 +-
>  tools/testing/selftests/net/mptcp/userspace_pm.sh  | 2 +-
>  8 files changed, 7 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/diag.sh
> b/tools/testing/selftests/net/mptcp/diag.sh
> index eec1f04d231f..9e19e3e8d833 100755
> --- a/tools/testing/selftests/net/mptcp/diag.sh
> +++ b/tools/testing/selftests/net/mptcp/diag.sh
> @@ -33,7 +33,7 @@ cleanup()
>  {
>  	ip netns pids "${ns1}" | xargs --no-run-if-empty kill -
> SIGKILL &>/dev/null
>  
> -	mptcp_lib_ns_exit "${ns1}"
> +	cleanup_all_ns
>  }
>  
>  mptcp_lib_check_mptcp
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index b77fb7065bfb..4e2c5dd0de3c 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -142,7 +142,7 @@ cleanup()
>  	rm -f "$sin" "$sout"
>  	rm -f "$capout"
>  
> -	mptcp_lib_ns_exit "${ns1}" "${ns2}" "${ns3}" "${ns4}"
> +	cleanup_all_ns
>  }
>  
>  mptcp_lib_check_mptcp
> @@ -271,7 +271,6 @@ check_mptcp_disabled()
>  	local err=0
>  	LC_ALL=C ip netns exec ${disabled_ns} ./mptcp_connect -p
> 10000 -s MPTCP 127.0.0.1 < "$cin" 2>&1 | \
>  		grep -q "^socket: Protocol not available$" && err=1
> -	mptcp_lib_ns_exit "${disabled_ns}"
>  
>  	if [ ${err} -eq 0 ]; then
>  		mptcp_lib_pr_fail "New MPTCP socket cannot be
> blocked via sysctl"
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index fefa9173bdaa..87a518b8c19f 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -132,8 +132,6 @@ init_shapers()
>  cleanup_partial()
>  {
>  	rm -f "$capout"
> -
> -	mptcp_lib_ns_exit "${ns1}" "${ns2}"
>  }
>  
>  init() {
> @@ -166,6 +164,7 @@ cleanup()
>  	rm -rf $evts_ns1 $evts_ns2
>  	rm -f "$err"
>  	cleanup_partial
> +	cleanup_all_ns
>  }
>  
>  print_check()
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index 59eb77e7813d..bd7d78e4aa83 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -424,14 +424,6 @@ mptcp_lib_ns_init() {
>  	done
>  }
>  
> -mptcp_lib_ns_exit() {
> -	local netns
> -	for netns in "${@}"; do
> -		ip netns del "${netns}"
> -		rm -f /tmp/"${netns}".{nstat,out}
> -	done
> -}
> -
>  mptcp_lib_events() {
>  	local ns="${1}"
>  	local evts="${2}"
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> index 68899a303a1a..e1026b028739 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> @@ -98,7 +98,7 @@ init()
>  #shellcheck disable=SC2317
>  cleanup()
>  {
> -	mptcp_lib_ns_exit "${ns1}" "${ns2}" "${ns_sbox}"
> +	cleanup_all_ns
>  	rm -f "$cin" "$cout"
>  	rm -f "$sin" "$sout"
>  }
> diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh
> b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> index 2757378b1b13..5b4d83c2e280 100755
> --- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
> +++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> @@ -36,7 +36,7 @@ err=$(mktemp)
>  cleanup()
>  {
>  	rm -f "${err}"
> -	mptcp_lib_ns_exit "${ns1}"
> +	cleanup_all_ns
>  }
>  
>  mptcp_lib_check_mptcp
> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh
> b/tools/testing/selftests/net/mptcp/simult_flows.sh
> index d0b39c2e38a3..6eddb3bba2e8 100755
> --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
> +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
> @@ -42,7 +42,7 @@ cleanup()
>  	rm -f "$large" "$small"
>  	rm -f "$capout"
>  
> -	mptcp_lib_ns_exit "${ns1}" "${ns2}" "${ns3}"
> +	cleanup_all_ns
>  }
>  
>  mptcp_lib_check_mptcp
> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> index 9e2981f2d7f5..0c089e7f5f0a 100755
> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> @@ -107,7 +107,7 @@ cleanup()
>  		mptcp_lib_kill_wait $pid
>  	done
>  
> -	mptcp_lib_ns_exit "${ns1}" "${ns2}"
> +	cleanup_all_ns
>  
>  	rm -rf $file $client_evts $server_evts
>  

