Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFFA2E620
	for <mptcp@lists.linux.dev>; Mon, 19 Feb 2024 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345321; cv=none; b=Qv0UIYt8lkMkPLFU9kcafVjLETzllsUTmjpa+BYAEzaMD6E1j79ZsIMGvnuahEk/rN6l+xtgV83LYuF9cDCOIyUUzG7uqf7of8F9VD3sm/ouhN+VKHpTAgRiubNtyjwHyJfz5UInkkwfrdBRJCfIOFuoDP8VYpsTfe4HFKd/6Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345321; c=relaxed/simple;
	bh=qUMOQCmKsWFA7GUotR6lIWzNQ8NeDO5mUlp2L7XpTmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yqsb0ZxqQjfhhnBJPp9UIGRWYGf1uTjsUUVWPoUEQqlLHiY1qvTb0gv1qecwiqrBngZfu+JTHFFkZZDpeOaXMa3pQNYP165ZKk46fHOHA8LIl9Zz4rDek0eBlu41Ppev/cnOBDd8dAtR9Cw0Jxs+gJ7VZ+D3lNMn6+/v/G0vhjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCFaqzcN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCFaqzcN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBCFC433F1;
	Mon, 19 Feb 2024 12:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708345321;
	bh=qUMOQCmKsWFA7GUotR6lIWzNQ8NeDO5mUlp2L7XpTmk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cCFaqzcN+sw7qQXY1v2IvlIrjtSRXRxnZK/5eoEY85Ldh/hw26vLyCfYu3V4L1vPa
	 19mkfv8A55vzLbIr2p5z2wDmP3eOJ4Vj/3/79qfO/FyWYFoailGcEzcR4FfyQCKcMq
	 N4RmPcLWAKVW+7VhIcxpE+Yr+h2Sgdc0zA3YuT23uR2Xl5wxR2CQgXxJcfMNwBbhKY
	 3fd7z5ZUFxYgtUPb9XW9PswluywPuOqwvLpFBVeqzxV0IaSEs4pIllTFA3iOwbY0ef
	 cdAALzFYY9eWoF+4g0SKM/x8p4x1CR8MPKZYJXa0AxDqCh+YJK1H5LTMsxreRHQNIO
	 xUcX+GrtlEXZg==
Message-ID: <50e682b4-5379-41ca-922c-2e47b2c9dc84@kernel.org>
Date: Mon, 19 Feb 2024 13:21:59 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 4/5] selftests: mptcp: add
 mptcp_lib_check_output helper
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1708334850.git.tanggeliang@kylinos.cn>
 <c81e0a2cc5cc6bf7e717fde333adf3c3b2180c6e.1708334850.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <c81e0a2cc5cc6bf7e717fde333adf3c3b2180c6e.1708334850.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/02/2024 10:29, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Unify check_output() in mptcp_join.sh and check() in pm_netlink.sh into
> a new public function mptcp_lib_check_output() in mptcp_lib.sh. And use
> mptcp_lib_print_ok() and _err() in it to print test results with colors.
> 
> Use this new helper instead of check_output() and check().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 21 +-----------
>  .../testing/selftests/net/mptcp/mptcp_lib.sh  | 32 +++++++++++++++++++
>  .../testing/selftests/net/mptcp/pm_netlink.sh | 24 ++++----------
>  3 files changed, 40 insertions(+), 37 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index ceaaf155cc32..f75d22dbb28d 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -21,7 +21,6 @@ cinfail=""
>  cinsent=""
>  tmpfile=""
>  cout=""
> -check_output_err=""

Same as in a previous patch: to avoid some confusions, I think we should
keep global variables declared here and not in mptcp_lib.sh (or they
need to be prefixed).

(same in userspace_pm.sh)

>  capout=""
>  ksft_skip=4
>  iptables="iptables"
> @@ -151,7 +150,6 @@ init() {
>  	cout=$(mktemp)
>  	evts_ns1=$(mktemp)
>  	evts_ns2=$(mktemp)
> -	check_output_err=$(mktemp)
>  
>  	trap cleanup EXIT
>  
> @@ -165,7 +163,6 @@ cleanup()
>  	rm -f "$sin" "$sout" "$cinsent" "$cinfail"
>  	rm -f "$tmpfile"
>  	rm -rf $evts_ns1 $evts_ns2
> -	rm -f $check_output_err
>  	mptcp_lib_cleanup
>  	cleanup_partial
>  }

I think it is clearer to keep the assignment and cleanup here, than
hiding it in mptcp_lib.sh and doing that everywhere, even when not required.

(same in userspace_pm.sh)

> @@ -3345,26 +3342,10 @@ userspace_pm_get_addr()
>  
>  check_output()
>  {
> -	local cmd="$1"
> -	local expected="$2"

Best to keep that, it is useful to act as a doc. Otherwise, we have to
look at mptcp_lib.sh to find out what is $1 and $2.

(same in userspace_pm.sh)

>  	local msg="$3"
> -	local out=`$cmd 2>$check_output_err`
> -	local cmd_ret=$?
>  
>  	printf "%-42s" "$msg"
> -	if [ $cmd_ret -ne 0 ]; then
> -		mptcp_lib_print_err "[FAIL] command execution '$cmd' stderr "
> -		cat $check_output_err
> -		ret=${KSFT_FAIL}
> -		return $cmd_ret
> -	elif [ "$out" = "$expected" ]; then
> -		mptcp_lib_print_ok "[ OK ]"
> -		return 0
> -	else
> -		mptcp_lib_print_err "[FAIL] expected '$expected' got '$out'"
> -		ret=${KSFT_FAIL}
> -		return 1
> -	fi
> +	mptcp_lib_check_output "${1}" "${2}"

(see above: best to pass "${check_output_err}" to mptcp_lib_check_output)

(same in userspace_pm.sh)

>  }
>  
>  userspace_tests()
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index 01b0e43eaa80..fd2ed3b5137c 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -410,6 +410,38 @@ mptcp_lib_ns_exit() {
>  	done
>  }
>  
> +check_output_err=$(mktemp)
> +
> +mptcp_lib_check_output() {
> +	: "${check_output_err:?}"
> +	: "${ret:?}"
> +
> +	local cmd="$1"

In mptcp_lib.sh, please always use {} as in the rest of the file. (same
below).

> +	local expected="$2"

(see above: "check_output_err" will not be passed as argument)

> +	local out
> +	local cmd_ret
> +
> +	out=$($cmd 2>"$check_output_err")
> +	cmd_ret=$?
> +
> +	if [ $cmd_ret -ne 0 ]; then
> +		mptcp_lib_print_err "[FAIL] command execution '$cmd' stderr "
> +		cat "$check_output_err"
> +		ret=${KSFT_FAIL}

Mmh, I don't think it is a good idea to assign a global variable
declared in another file from here.

Can you not return ${ret} instead? So we would do something like:

  mptcp_lib_check_output (...) || ret=${?}

or:

  if mptcp_lib_check_output (...); then
      # OK (...)
  else
      ret=1
      (...)
  fi

(do you need the value of "${cmd_ret}" later? I think just having 0 or
${KSFT_FAIL} is enough, no?)

> +		return $cmd_ret
> +	elif [ "$out" = "$expected" ]; then
> +		mptcp_lib_print_ok "[ OK ]"
> +		return 0
> +	else
> +		mptcp_lib_print_err "[FAIL] expected '$expected' got '$out'"
> +		ret=${KSFT_FAIL}
> +		return 1
> +	fi
> +}
> +
>  mptcp_lib_cleanup() {
> +	: "${check_output_err:?}"
> +
>  	echo "cleanup"
> +	rm -f "$check_output_err"
>  }

As mentioned above, I don't think we should do that here. Maybe we don't
need patch 3/5 then?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
