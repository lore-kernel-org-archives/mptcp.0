Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BC27F487
	for <mptcp@lists.linux.dev>; Mon, 26 Feb 2024 12:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951266; cv=none; b=o6Xs51XsvbOa4rH/t+ijhmy2dUGtZht0uKG5cbzAKMJSxrSgAhbimHi852fKTCEDk10Y2tLHNxdqSwZ6kXsfG7yH0RBgLXiSv7PkgKKth6VkvNBuWLnYj4QKKiLsu/OsKkBlIianoQN5LyyxR17f5Qp6X5pP/HzsF5CNm+vVhjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951266; c=relaxed/simple;
	bh=hshLhadZKjpF2SQyKsG/+OYMBSMNvRaV6cQc1gUd0Ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prGX4VJgrxu0Wis+5DMMLtJMjRe1l10Z/mt+QNCgHeQH/rixfnNdVoANxfpvO8V/k7SooJNPu+rmcfmnzxc8jlQmLJxQp/aaROS4nMA/NLLLXbrKe+EpgNZXYvOQ4vMSjrXLy/z6WqF4LvFRNntL9sY9vtMlWHGdYaPIJ0EsNGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sewq/CEk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sewq/CEk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A35FC433C7;
	Mon, 26 Feb 2024 12:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708951266;
	bh=hshLhadZKjpF2SQyKsG/+OYMBSMNvRaV6cQc1gUd0Ug=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sewq/CEkZJkjs32NJarMm5FR70ljy7UJiYFOKKJC2U62fj1SOfsKVlKSN8NojORAw
	 v0T+Kc+BMpOVfraEbB/PAPYWhTGzQdSru2FIdhhWXZNCfk1rcTbM01tDQRCtGZ0hR6
	 Ezkklh64jtxSgWINu0/PG6i+5LOgmWYnLVwyurSmjTN875lhB2WCucuET/p9ge4i7B
	 6K0K18Ugum9RM6HLH9N0o3qa2uEvtP9IRa8hPZD+k2LaXb0jUbMCCVMskyrepH2Dae
	 Dfxe6CFW8AWniblqZuljw+toL0iPZQLC+XUVRurk9WTRSLJwLqXTz4Q63kCkxXAU58
	 +eJ/q1tbZwO+Q==
Message-ID: <b6d67726-0633-48d0-981e-793cc6902052@kernel.org>
Date: Mon, 26 Feb 2024 13:41:05 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v5 04/12] selftests: mptcp: print test results
 with colors
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1708939962.git.tanggeliang@kylinos.cn>
 <b1013ed7936552b2fe1a3c9cd1f5065a19931b16.1708939962.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <b1013ed7936552b2fe1a3c9cd1f5065a19931b16.1708939962.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 26/02/2024 10:43, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The helper mptcp_lib_verify_listener_events() will be added latter in
> mptcp_lib.sh, and be used by mptcp_join.sh and userspace_pm.sh. The
> former prints colored output while the latter is not. It makes sense
> to unify them.

(not sure if we need this explanation about
mptcp_lib_verify_listener_events)
> 
> This patch uses mptcp_lib_print_ok(), _warn(), _err() and _info() helpers
> in scripts diag.sh, mptcp_connect.sh, mptcp_sockopt.sh, pm_netlink.sh,
> simult_flows.sh and userspace_pm.sh to print test results with colors.
> 
> Having colors helps to quickly identify issues when looking at a long
> list of output logs and results.

I think this patch will look better if mptcp_lib_print_success/fail/skip
helpers are used.

In this case, you should not need to use mptcp_lib_print_ok/err/warn,
only _info, right?

If you still need to use '_ok/err/warn' in the new version, please
justify it. But I think these should be "internal" functions, or for
specific need.

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index 72be905bab1f..c7483902026b 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -254,7 +254,8 @@ check_mptcp_disabled()
>  
>  	# net.mptcp.enabled should be enabled by default
>  	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
> -		echo -e "net.mptcp.enabled sysctl is not 1 by default\t\t\t   [FAIL]"
> +		echo -n -e "net.mptcp.enabled sysctl is not 1 by default"

See the comments on previous patches, would be better with a helper to
print ↑ without 'echo -n -e', and ↓, we would just have
'mptcp_lib_print_fail'.

Same below

> +		mptcp_lib_print_err "\t\t\t   [FAIL]"
>  		mptcp_lib_result_fail "net.mptcp.enabled sysctl is not 1 by default"
>  		ret=1
>  		return 1
> @@ -267,13 +268,15 @@ check_mptcp_disabled()
>  	mptcp_lib_ns_exit "${disabled_ns}"
>  
>  	if [ ${err} -eq 0 ]; then
> -		echo -e "New MPTCP socket cannot be blocked via sysctl\t\t\t   [FAIL]"
> +		echo -n -e "New MPTCP socket cannot be blocked via sysctl"
> +		mptcp_lib_print_err "\t\t\t   [FAIL]"
>  		mptcp_lib_result_fail "New MPTCP socket cannot be blocked via sysctl"
>  		ret=1
>  		return 1
>  	fi
>  
> -	echo -e "New MPTCP socket can be blocked via sysctl\t\t\t   [ OK ]"
> +	echo -n -e "New MPTCP socket can be blocked via sysctl"
> +	mptcp_lib_print_ok "\t\t\t   [ OK ]"
>  	mptcp_lib_result_pass "New MPTCP socket can be blocked via sysctl"
>  	return 0
>  }
> @@ -503,7 +506,7 @@ do_transfer()
>  	fi
>  
>  	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
> -		printf "[ OK ]"
> +		mptcp_lib_print_ok "[ OK ]"
>  		mptcp_lib_result_pass "${TEST_GROUP}: ${result_msg}"
>  	else

Maybe good to add a comment here, e.g.

  # "FAIL" message has been printed before.

>  		mptcp_lib_result_fail "${TEST_GROUP}: ${result_msg}"
> @@ -534,7 +537,6 @@ do_transfer()
>  			"${expect_ackrx}" "${stat_ackrx_now_l}"
>  	fi
>  
> -	echo
>  	cat "$capout"
>  	[ $retc -eq 0 ] && [ $rets -eq 0 ]
>  }
> @@ -708,7 +710,7 @@ EOF
>  		return
>  	fi
>  
> -	echo "INFO: test $msg"
> +	mptcp_lib_print_info "INFO: test $msg"
>  
>  	TEST_COUNT=10000
>  	local extra_args="-o TRANSPARENT"
> @@ -721,12 +723,12 @@ EOF
>  	ip -net "$listener_ns" route del local $local_addr/0 dev lo table 100
>  
>  	if [ $lret -ne 0 ]; then
> -		echo "FAIL: $msg, mptcp connection error" 1>&2
> +		mptcp_lib_print_err "FAIL: $msg, mptcp connection error" 1>&2

(I guess it is fine here to print this to stdout, like all the others,
that's part of the unification I think -- but as mentioned in patch
2/12, we can probably remove this FAIL message, and the PASS one here as
well)

>  		ret=$lret
>  		return 1
>  	fi
>  
> -	echo "PASS: $msg"
> +	mptcp_lib_print_ok "PASS: $msg"
>  	return 0
>  }
>  

(...)

> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
> index 58cfdaf1db25..79cb377ee0bd 100755
> --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
> +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
> @@ -187,12 +187,12 @@ do_transfer()
>  	printf "%-16s" " max $max_time "
>  	if [ $retc -eq 0 ] && [ $rets -eq 0 ] && \
>  	   [ $cmpc -eq 0 ] && [ $cmps -eq 0 ]; then
> -		echo "[ OK ]"
> +		mptcp_lib_print_ok "[ OK ]"
>  		cat "$capout"
>  		return 0
>  	fi
>  
> -	echo " [FAIL]"
> +	mptcp_lib_print_err " [FAIL]"

I guess we don't need the extra space before '[FAIL]', right?

>  	echo "client exit code $retc, server $rets" 1>&2
>  	echo -e "\nnetns ${ns3} socket stat for $port:" 1>&2
>  	ip netns exec ${ns3} ss -nita 1>&2 -o "sport = :$port"
> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> index b0cce8f065d8..33bbb0d5807f 100755
> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> @@ -61,7 +61,7 @@ _printf() {
>  
>  print_title()
>  {
> -	_printf "INFO: %s\n" "${1}"
> +	mptcp_lib_print_info "INFO: ${1}"
>  }
>  
>  # $1: test name
> @@ -72,27 +72,22 @@ print_test()
>  	_printf "%-68s" "${test_name}"
>  }
>  
> -print_results()
> -{
> -	_printf "[%s]\n" "${1}"
> -}
> -
>  test_pass()
>  {
> -	print_results " OK "
> +	mptcp_lib_print_ok "[ OK ]"
>  	mptcp_lib_result_pass "${test_name}"
>  }
>  
>  test_skip()
>  {
> -	print_results "SKIP"
> +	mptcp_lib_print_warn "[SKIP]"
>  	mptcp_lib_result_skip "${test_name}"
>  }
>  
>  # $1: msg
>  test_fail()
>  {
> -	print_results "FAIL"
> +	mptcp_lib_print_err "[FAIL]${1:+ ${*}}"

The error will be repeated twice then, no? ...

>  	ret=1
>  
>  	if [ -n "${1}" ]; then

... maybe you can remove this block?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
