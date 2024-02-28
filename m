Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3DB12C55B
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119033; cv=none; b=R2uQTOkgUIB8fHPmd3bxpJeYipj3ZptHJ3GaeObiHE4r45slbgCwumi0ltI8OmMjhzMvXJJFrdGQ1/s58W6MtsrVN43gqMw58a+p/CLJqhs+3jug5te+YLWO5lC53uLmC0XcMcRc8D4pL1KgUoatm+d7KfYrW/LkM0DDRGYf6Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119033; c=relaxed/simple;
	bh=WZuPpk7WOK1WfIP/XQgcInJ012CdcBzqlZgrfoIXPaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+n+jh5aUs989csw04BLq8mvpOMts0ZMF+dEflO2jMS+MjsNKmf45Un5/ABWTP7x1CLo29v4UX2DPpUwRweDPmTuzb579lBNaM65n/we9vNiFtQcAAEhNMG/HYmgAgLkK+7fvy2gTWOyY9gAp96auyNGEt5ZxByUBwNXE1HG/Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDNCv93z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDNCv93z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B960AC433C7;
	Wed, 28 Feb 2024 11:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709119032;
	bh=WZuPpk7WOK1WfIP/XQgcInJ012CdcBzqlZgrfoIXPaA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aDNCv93zIKfv2wlwjTIRzSBE0qvVwhEcf5Hy6sPbyF5VIzrNvOy+CfVNuC7HLVYqq
	 LicA4rER9s4LK3AFo8TgPrHFCSuZoDel71cKgYOrH45lv8/ui+Ulk3EQ3kYOORxfhg
	 2bN8GtrYUe8c6lCpKZ6bqKJ/Kp0KruCMLtsUUvQ4SjniGCUF+R1OIIiPeSWT9RwLUl
	 /5Z2esNq3loH7etVkgDcDTT6tkBtdTYrGbO5DNqR5UgIi3PVw//cfkKUjzXGyyMUfM
	 aEIlk+p4VJF6/DeY3hfO3DfZmA9nEyLoLuwmpAKU+zhac4JbGlW/d2fF56crFu6ZSt
	 AyYq91wfq9fcg==
Message-ID: <ea3c57b8-c119-494e-b659-69a574a6297d@kernel.org>
Date: Wed, 28 Feb 2024 12:17:09 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v6 2/9] selftests: mptcp: print test results
 with colors
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1709105922.git.tanggeliang@kylinos.cn>
 <eacc57e0d627d22cdaf68fd08b430eb5e381ecc0.1709105922.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <eacc57e0d627d22cdaf68fd08b430eb5e381ecc0.1709105922.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 28/02/2024 08:43, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch uses mptcp_lib_pr_ok(), mptcp_lib_pr_skip(), mptcp_lib_pr_fail()
> and mptcp_lib_pr_info() helpers in all scripts to print test results with
> colors.
> 
> Having colors helps to quickly identify issues when looking at a long list
> of output logs and results.

Please also mention that now we will print the "ok/skip/fail' using the
same 'format' in all tests.

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index 0ca2960c9099..ffc063a58149 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -218,7 +218,7 @@ set_ethtool_flags() {
>  	local flags="$3"
>  
>  	if ip netns exec $ns ethtool -K $dev $flags 2>/dev/null; then
> -		echo "INFO: set $ns dev $dev: ethtool -K $flags"
> +		mptcp_lib_pr_info "set $ns dev $dev: ethtool -K $flags"
>  	fi
>  }
>  
> @@ -254,7 +254,7 @@ check_mptcp_disabled()
>  
>  	# net.mptcp.enabled should be enabled by default
>  	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
> -		echo -e "net.mptcp.enabled sysctl is not 1 by default\t\t[ FAIL ]"
> +		mptcp_lib_pr_fail "net.mptcp.enabled sysctl is not 1 by default"

That looks strange here not to have a title before. Is it because you
are going to add one later?

With this commit here, you will print '[FAIL] <title>' instead of
'<title> [FAIL]'.

In most tests, we do something like:

  print_title "net.mptcp.enabled sysctl is set to 1 by default
  if (...)
    mptcp_lib_pr_ok
  else
    mptcp_lib_pr_fail
  fi

or maybe:

  print_title "net.mptcp.enabled sysctl"
  if (...)
    mptcp_lib_pr_fail "not enabled by default"
  elif (...)
    mptcp_lib_pr_fail "not blocking MPTCP sockets"
  else
    mptcp_lib_pr_ok
  fi


So with a title before, and only pass argument to mptcp_lib_pr_ok/fail
if we need to add more details, but not putting the whole test name
after "[FAIL]", no?

Or maybe you do that in a following commit?

Same below

>  		mptcp_lib_result_fail "net.mptcp.enabled sysctl is not 1 by default"
>  		ret=1
>  		return 1
> @@ -267,13 +267,14 @@ check_mptcp_disabled()
>  	mptcp_lib_ns_exit "${disabled_ns}"
>  
>  	if [ ${err} -eq 0 ]; then
> -		echo -e "New MPTCP socket cannot be blocked via sysctl\t\t[ FAIL ]"
> +		mptcp_lib_pr_fail "New MPTCP socket cannot be blocked via sysctl"
>  		mptcp_lib_result_fail "New MPTCP socket cannot be blocked via sysctl"
>  		ret=1
>  		return 1
>  	fi
>  
> -	echo -e "New MPTCP socket can be blocked via sysctl\t\t[ OK ]"
> +	echo -n -e "New MPTCP socket can be blocked via sysctl\t\t"
> +	mptcp_lib_pr_ok

And here you print the OK after, confusing :)

>  	mptcp_lib_result_pass "New MPTCP socket can be blocked via sysctl"
>  	return 0
>  }
> @@ -294,7 +295,7 @@ do_ping()
>  	ip netns exec ${connector_ns} ping ${ping_args} $connect_addr >/dev/null || rc=1
>  
>  	if [ $rc -ne 0 ] ; then
> -		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]" 1>&2
> +		mptcp_lib_pr_fail "$listener_ns -> $connect_addr connectivity" 1>&2

(as part of the unification, we can print all errors to stdout (or all
to stderr, but best to have a consistensy here → I think most errors are
printed to stdout)

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index 3f5b16fe5220..58fe4dad9d9d 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -55,6 +55,9 @@ mptcp_lib_pr_ok() {
>  mptcp_lib_pr_skip() {
>  	local msg="[SKIP]"
>  
> +	if [ "${#}" -gt 0 ]; then
> +		msg+="${1:+ ${*}}"
> +	fi

(should be part of the previous commit, can be in one line, see my
previous comment)

>  	mptcp_lib_print_warn "${msg}"
>  }
>  
> @@ -101,14 +104,14 @@ mptcp_lib_has_file() {
>  
>  mptcp_lib_check_mptcp() {
>  	if ! mptcp_lib_has_file "/proc/sys/net/mptcp/enabled"; then
> -		echo "SKIP: MPTCP support is not available"
> +		mptcp_lib_pr_skip "MPTCP support is not available"
>  		exit ${KSFT_SKIP}

I was not thinking about modifying this one, just before the exit (and
not after a test name), but why not.

>  	fi
>  }
>  
>  mptcp_lib_check_kallsyms() {
>  	if ! mptcp_lib_has_file "/proc/kallsyms"; then
> -		echo "SKIP: CONFIG_KALLSYMS is missing"
> +		mptcp_lib_pr_skip "CONFIG_KALLSYMS is missing"
>  		exit ${KSFT_SKIP}
>  	fi
>  }
> @@ -315,7 +318,7 @@ mptcp_lib_check_transfer() {
>  	local what="${3}"
>  
>  	if ! cmp "$in" "$out" > /dev/null 2>&1; then
> -		echo "[ FAIL ] $what does not match (in, out):"
> +		mptcp_lib_pr_fail "$what does not match (in, out):"
>  		mptcp_lib_print_file_err "$in"
>  		mptcp_lib_print_file_err "$out"
>  
> @@ -350,24 +353,24 @@ mptcp_lib_check_tools() {
>  		case "${tool}" in
>  		"ip")
>  			if ! ip -Version &> /dev/null; then
> -				mptcp_lib_print_warn "SKIP: Could not run test without ip tool"
> +				mptcp_lib_pr_skip "Could not run test without ip tool"
>  				exit ${KSFT_SKIP}
>  			fi
>  			;;
>  		"ss")
>  			if ! ss -h | grep -q MPTCP; then
> -				mptcp_lib_print_warn "SKIP: ss tool does not support MPTCP"
> +				mptcp_lib_pr_skip "ss tool does not support MPTCP"
>  				exit ${KSFT_SKIP}
>  			fi
>  			;;
>  		"iptables"* | "ip6tables"*)
>  			if ! "${tool}" -V &> /dev/null; then
> -				mptcp_lib_print_warn "SKIP: Could not run all tests without ${tool}"
> +				mptcp_lib_pr_skip "Could not run all tests without ${tool}"
>  				exit ${KSFT_SKIP}
>  			fi
>  			;;
>  		*)
> -			mptcp_lib_print_err "Internal error: unsupported tool: ${tool}"
> +			mptcp_lib_pr_fail "Internal error: unsupported tool: ${tool}"
>  			exit ${KSFT_FAIL}
>  			;;
>  		esac
> @@ -386,13 +389,13 @@ mptcp_lib_check_output() {
>  	fi
>  
>  	if [ ${cmd_ret} -ne 0 ]; then
> -		mptcp_lib_print_err "[FAIL] command execution '${cmd}' stderr"
> +		mptcp_lib_pr_fail "command execution '${cmd}' stderr"
>  		cat "${err}"
>  		return 2
>  	elif [ "${out}" = "${expected}" ]; then
>  		return 0
>  	else
> -		mptcp_lib_print_err "[FAIL] expected '${expected}' got '${out}'"
> +		mptcp_lib_pr_fail "expected '${expected}' got '${out}'"
>  		return 1
>  	fi
>  }
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> index 6ed4aa32222f..ccc941e1e7bb 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> @@ -103,7 +103,8 @@ check_mark()
>  	local v
>  	for v in $values; do
>  		if [ $v -ne 0 ]; then
> -			echo "FAIL: got $tables $values in ns $ns , not 0 - not all expected packets marked" 1>&2
> +			mptcp_lib_pr_fail "got $tables $values in ns $ns, \
> +not 0 - not all expected packets marked" 1>&2

You can use multiple strings, probably prettyier:

  mptcp_lib_pr_fail "got $tables $values in ns $ns," \
                    "not 0 - not all expected packets marked"

>  			ret=1
>  			return 1
>  		fi
> @@ -212,7 +213,7 @@ do_mptcp_sockopt_tests()
>  	local lret=0
>  
>  	if ! mptcp_lib_kallsyms_has "mptcp_diag_fill_info$"; then
> -		echo "INFO: MPTCP sockopt not supported: SKIP"
> +		mptcp_lib_pr_skip "INFO: MPTCP sockopt not supported"

I guess you can remove the 'INFO: '. Or you print an info message.

>  		mptcp_lib_result_skip "sockopt"
>  		return
>  	fi
> @@ -221,7 +222,7 @@ do_mptcp_sockopt_tests()
>  	lret=$?
>  
>  	if [ $lret -ne 0 ]; then
> -		echo "FAIL: SOL_MPTCP getsockopt" 1>&2
> +		mptcp_lib_pr_fail "SOL_MPTCP getsockopt" 1>&2

I was thinking 'mptcp_lib_pr_skip()' and '_fail' and '_ok' were there to
be printed after a test title. I guess they can be use to print the
whole line but that's "strange". I didn't check but it sounds like a
"print_title()" is missing before, not to print the test name after
[FAIL], and not to repeat this for success and fail.

But I guess I'm maybe a bit lost before you will add the '[ OK ]' in a
later commit, no?

>  		mptcp_lib_result_fail "sockopt v4"
>  		ret=$lret
>  		return
> @@ -232,7 +233,7 @@ do_mptcp_sockopt_tests()
>  	lret=$?
>  
>  	if [ $lret -ne 0 ]; then
> -		echo "FAIL: SOL_MPTCP getsockopt (ipv6)" 1>&2
> +		mptcp_lib_pr_fail "SOL_MPTCP getsockopt (ipv6)" 1>&2
>  		mptcp_lib_result_fail "sockopt v6"
>  		ret=$lret
>  		return
> @@ -263,12 +264,12 @@ do_tcpinq_test()
>  	local lret=$?
>  	if [ $lret -ne 0 ];then
>  		ret=$lret
> -		echo "FAIL: mptcp_inq $*" 1>&2
> +		mptcp_lib_pr_fail "mptcp_inq $*" 1>&2
>  		mptcp_lib_result_fail "TCP_INQ: $*"
>  		return $lret
>  	fi
>  
> -	echo "PASS: TCP_INQ cmsg/ioctl $*"
> +	mptcp_lib_pr_info "PASS: TCP_INQ cmsg/ioctl $*"
>  	mptcp_lib_result_pass "TCP_INQ: $*"
>  	return $lret
>  }
> @@ -278,7 +279,7 @@ do_tcpinq_tests()
>  	local lret=0
>  
>  	if ! mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
> -		echo "INFO: TCP_INQ not supported: SKIP"
> +		mptcp_lib_pr_skip "INFO: TCP_INQ not supported"
>  		mptcp_lib_result_skip "TCP_INQ"
>  		return
>  	fi
> @@ -315,12 +316,12 @@ run_tests $ns1 $ns2 10.0.1.1
>  run_tests $ns1 $ns2 dead:beef:1::1
>  
>  if [ $ret -eq 0 ];then
> -	echo "PASS: all packets had packet mark set"
> +	mptcp_lib_pr_info "PASS: all packets had packet mark set"
>  fi
>  
>  do_mptcp_sockopt_tests
>  if [ $ret -eq 0 ];then
> -	echo "PASS: SOL_MPTCP getsockopt has expected information"
> +	mptcp_lib_pr_info "PASS: SOL_MPTCP getsockopt has expected information"
>  fi
>  
>  do_tcpinq_tests
> diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> index 427fc5c70b3c..ffa79df99d38 100755
> --- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
> +++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> @@ -189,7 +189,8 @@ subflow,backup,fullmesh 10.0.1.1" "          (backup,fullmesh)"
>  else
>  	for st in fullmesh nofullmesh backup,fullmesh; do
>  		st="          (${st})"
> -		printf "%-50s%s\n" "${st}" "[SKIP]"
> +		printf "%-50s" "${st}"
> +		mptcp_lib_pr_skip
>  		mptcp_lib_result_skip "${st}"
>  	done
>  fi
> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
> index 467feb17e07b..af6d9a81c317 100755
> --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
> +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
> @@ -187,12 +187,12 @@ do_transfer()
>  	printf "%-16s" " max $max_time "
>  	if [ $retc -eq 0 ] && [ $rets -eq 0 ] && \
>  	   [ $cmpc -eq 0 ] && [ $cmps -eq 0 ]; then
> -		echo "[ OK ]"
> +		mptcp_lib_pr_ok
>  		cat "$capout"
>  		return 0
>  	fi
>  
> -	echo " [ fail ]"
> +	mptcp_lib_pr_fail
>  	echo "client exit code $retc, server $rets" 1>&2
>  	echo -e "\nnetns ${ns3} socket stat for $port:" 1>&2
>  	ip netns exec ${ns3} ss -nita 1>&2 -o "sport = :$port"

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
