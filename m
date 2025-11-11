Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31912F83B3
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 02:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762829166; cv=none; b=OwbZxMiPzhM84Ovz0oX7meRFPuF1z6vXAjANC8iTk2m5PP8HvFMBUPE9ERFMYciOombD636YoZ/c5E2uVGdr8bwZzxSQkbIiG8ZDgaSOyxFPLLgWziWoTC0wA8A26Q62W4EVUnx6ANf7zGWAduwwtUanLUyEYUpkW+lm5og5YHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762829166; c=relaxed/simple;
	bh=dn3nZlbHFMCJ/tlMjtTLSZjHAABl1jo8yUs19HSRLPw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uw6VoydwGCL9Olv+pOuOEO20RVsfGGTg/tXUEyuKRURgt190Z4BvFK8/G3/EcaDZy7axmHLWuxCbgc7EYk/5rsrP1zNHfflIVaGnqrBguy2lg3vsnHxP4+12xg2xC5qVkn2gAvJioDJ/sh+ZB1t5roQakECM4F9A9N4uXuH2ofU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYJAjP9A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYJAjP9A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77896C113D0;
	Tue, 11 Nov 2025 02:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762829166;
	bh=dn3nZlbHFMCJ/tlMjtTLSZjHAABl1jo8yUs19HSRLPw=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=UYJAjP9Ai46rWNg+ysFgzH5GkM1Y/lvH54ByON9QFwRCWVa8gajWC8vmUaGRS6HuO
	 Wpt999oBU2cXW0TvuI3OESSq8g/2C51A6fNJ1I0E0dH6NMaNW8qazHhjkLeEZKTMy5
	 LUylyVWA4Ih60Cp4+o3ntRSG3ShEnsGG5SHYm5BfpTQbr+aMdbZbMAa7GWAnn3mz+z
	 nJ6XGLVtdGT4gLohQjBkf2RDvqJ/RVBURetPRfITZjmkbzQMdKE5/Pr13N2s94MZRZ
	 Gps50azzRAzgKeyyRPk87U3PJiRvNZV1CoI6p+pQInjQBb3MvB4NNkAgmssZNag8Vm
	 nBiYINI55qvaw==
Message-ID: <d5ef4083df02cc56e51170ec906eeaea78443c84.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 1/4] selftests: mptcp: join: properly kill
 background tasks
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Tue, 11 Nov 2025 10:46:01 +0800
In-Reply-To: <20251108-slft-timeout-stats-v1-1-c2234d277318@kernel.org>
References: <20251108-slft-timeout-stats-v1-0-c2234d277318@kernel.org>
	 <20251108-slft-timeout-stats-v1-1-c2234d277318@kernel.org>
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

This for this fix.

On Sat, 2025-11-08 at 15:20 +0100, Matthieu Baerts (NGI0) wrote:
> The 'run_tests' function is executed in the background, but killing
> its
> associated PID would not kill the children tasks running in the
> background.
> 
> To properly kill all background tasks, 'kill -- -PID' could be used,
> but
> this requires kill from procps-ng. Instead, all children tasks are
> listed using 'ps', and 'kill' is called with all PIDs of this group.
> 
> Fixes: 31ee4ad86afd ("selftests: mptcp: join: stop transfer when
> check is done (part 1)")
> Fixes: 04b57c9e096a ("selftests: mptcp: join: stop transfer when
> check is done (part 2)")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 18 +++++++++------
> ---
>  tools/testing/selftests/net/mptcp/mptcp_lib.sh  | 21
> +++++++++++++++++++++
>  2 files changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 6afcf6ad2788..8be8bfa71946 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -3995,7 +3995,7 @@ userspace_tests()
>  		chk_mptcp_info subflows 0 subflows 0
>  		chk_subflows_total 1 1
>  		kill_events_pids
> -		mptcp_lib_kill_wait $tests_pid
> +		mptcp_lib_kill_group_wait $tests_pid
>  	fi
>  
>  	# userspace pm create destroy subflow
> @@ -4023,7 +4023,7 @@ userspace_tests()
>  		chk_mptcp_info subflows 0 subflows 0
>  		chk_subflows_total 1 1
>  		kill_events_pids
> -		mptcp_lib_kill_wait $tests_pid
> +		mptcp_lib_kill_group_wait $tests_pid
>  	fi
>  
>  	# userspace pm create id 0 subflow
> @@ -4044,7 +4044,7 @@ userspace_tests()
>  		chk_mptcp_info subflows 1 subflows 1
>  		chk_subflows_total 2 2
>  		kill_events_pids
> -		mptcp_lib_kill_wait $tests_pid
> +		mptcp_lib_kill_group_wait $tests_pid
>  	fi
>  
>  	# userspace pm remove initial subflow
> @@ -4068,7 +4068,7 @@ userspace_tests()
>  		chk_mptcp_info subflows 1 subflows 1
>  		chk_subflows_total 1 1
>  		kill_events_pids
> -		mptcp_lib_kill_wait $tests_pid
> +		mptcp_lib_kill_group_wait $tests_pid
>  	fi
>  
>  	# userspace pm send RM_ADDR for ID 0
> @@ -4094,7 +4094,7 @@ userspace_tests()
>  		chk_mptcp_info subflows 1 subflows 1
>  		chk_subflows_total 1 1
>  		kill_events_pids
> -		mptcp_lib_kill_wait $tests_pid
> +		mptcp_lib_kill_group_wait $tests_pid
>  	fi
>  }
>  
> @@ -4124,7 +4124,7 @@ endpoint_tests()
>  		pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
>  		pm_nl_check_endpoint "modif is allowed" \
>  			$ns2 10.0.2.2 id 1 flags signal
> -		mptcp_lib_kill_wait $tests_pid
> +		mptcp_lib_kill_group_wait $tests_pid
>  	fi
>  
>  	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2
> REJECT OUTPUT &&
> @@ -4179,7 +4179,7 @@ endpoint_tests()
>  			chk_mptcp_info subflows 3 subflows 3
>  		done
>  
> -		mptcp_lib_kill_wait $tests_pid
> +		mptcp_lib_kill_group_wait $tests_pid
>  
>  		kill_events_pids
>  		chk_evt_nr ns1 MPTCP_LIB_EVENT_LISTENER_CREATED 1
> @@ -4253,7 +4253,7 @@ endpoint_tests()
>  		wait_mpj $ns2
>  		chk_subflow_nr "after re-re-add ID 0" 3
>  		chk_mptcp_info subflows 3 subflows 3
> -		mptcp_lib_kill_wait $tests_pid
> +		mptcp_lib_kill_group_wait $tests_pid
>  
>  		kill_events_pids
>  		chk_evt_nr ns1 MPTCP_LIB_EVENT_LISTENER_CREATED 1
> @@ -4301,7 +4301,7 @@ endpoint_tests()
>  		wait_mpj $ns2
>  		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
>  		wait_mpj $ns2
> -		mptcp_lib_kill_wait $tests_pid
> +		mptcp_lib_kill_group_wait $tests_pid
>  
>  		join_syn_tx=3 join_connect_err=1 \
>  			chk_join_nr 2 2 2
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index ce6c92826be7..91ec75ddcb96 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -359,6 +359,27 @@ mptcp_lib_kill_wait() {
>  	wait "${1}" 2>/dev/null
>  }
>  
> +# $1: PID
> +mptcp_lib_pid_list_children() {
> +	local curr="${1}"
> +	# evoke 'ps' only once
> +	local pids="${2:-"$(ps o pid,ppid)"}"
> +
> +	echo "${curr}"
> +
> +	local pid
> +	for pid in $(echo "${pids}" | awk "\$2 == ${curr} { print
> \$1 }"); do
> +		mptcp_lib_pid_list_children "${pid}" "${pids}"

To be honest, I don't understand why this mptcp_lib_pid_list_children
function is calling itself here. Is this recursion?

The other three patches all look good to me.

    Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> +	done
> +}
> +
> +# $1: PID
> +mptcp_lib_kill_group_wait() {
> +	# Some users might not have procps-ng: cannot use "kill -- -
> PID"
> +	mptcp_lib_pid_list_children "${1}" | xargs -r kill
> &>/dev/null
> +	wait "${1}" 2>/dev/null
> +}
> +
>  # $1: IP address
>  mptcp_lib_is_v6() {
>  	[ -z "${1##*:*}" ]
> 

