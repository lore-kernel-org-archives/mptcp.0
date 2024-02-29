Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ADE76F03
	for <mptcp@lists.linux.dev>; Thu, 29 Feb 2024 12:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709210702; cv=none; b=B3PS7rNX+L22deaCjbCv52vBHaYSCbvSoZwbV9ftKtgWnWPTzNirvgkp4sV6xcXlfQeeC0ttjW4/6m0Gmzgc33goCf2G5oMTi9UHj1kT8lcmQWNbeqoc/YlkeORd4Zqh5nqnM01Yijbimt3jQwxfSQUZ1TZiE0yQwLoBA9aOHqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709210702; c=relaxed/simple;
	bh=zowJI6fnC5/Io8gZVk6hp9v+Ievd9NRzQVkwFp0Aizo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hvppm1ReIuwlw7dKFISBqJnG073mUpzRv4ueunA8wNmFKf+xMN+fO5r5u2foFjlWg8PEN62HsN15AunfPtLUGT5fod6oEbko8uSW3fAtfw7ch+eDDHeaKX6gH+SfHOQNLHwJvFDD5LG4ehygXQc2rd1p+qaRE4I/skGXh65Ha4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnxnP+RD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnxnP+RD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E52C433F1;
	Thu, 29 Feb 2024 12:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709210701;
	bh=zowJI6fnC5/Io8gZVk6hp9v+Ievd9NRzQVkwFp0Aizo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lnxnP+RDi2frF8TIccWz1Hc9Eyus3UtAhSWag+FDB2SKLhZChXNasTuh/mq3gyJY4
	 3bbfW0rG1MkRSNtEt3T6SH8LudbU3G0P+rulgr157rOPcOb4K9351rmHxTtl2Wvtk6
	 Q7/PmE37RCA3MTAIUJ4d3GAmKdz024wt+RnYA9mks1Mvi3NgZnWPPOd40Wu58rXQsJ
	 zTyI6cGIyKUA/7xR0Pm9zasqrkTQQlT+XD7Zh7XeSwGwL/Ky2wBJ0liKd0VIrkKLLJ
	 HmSluO201g4+cX9ZjE+jJPGPR3OkR3DYrKvhuQE/JnyzchdHSnlflMdLy+NwQTfQNF
	 uuRelrjISWV0A==
Message-ID: <b40889a0-9739-4785-93aa-768ee2c25bc1@kernel.org>
Date: Thu, 29 Feb 2024 13:44:58 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v7 7/8] selftests: mptcp: print test results
 with counters
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1709200070.git.tanggeliang@kylinos.cn>
 <2328092277b37a0b02084860109840f91f128137.1709200070.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2328092277b37a0b02084860109840f91f128137.1709200070.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 29/02/2024 10:51, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds a new helper mptcp_lib_print_title(), a wrapper of
> mptcp_lib_inc_test_counter() and mptcp_lib_pr_title_counter(), to
> print out test counter in each test result and increase the counter.
> Use this helper to print out test counters for every tests in diag.sh,
> mptcp_connect.sh, mptcp_sockopt.sh, pm_netlink.sh, simult_flows.sh,
> and userspace_pm.sh.

(...)

> Having test counters helps to quickly identify issues when looking at a
> long list of output logs and results.

Nice!

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index 77b0b9d5aca0..096ff8941c5b 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -131,7 +131,6 @@ ns2=""
>  ns3=""
>  ns4=""
>  
> -TEST_COUNT=0
>  TEST_GROUP=""
>  
>  # This function is used in the cleanup trap
> @@ -253,6 +252,7 @@ check_mptcp_disabled()
>  	local disabled_ns
>  	mptcp_lib_ns_init disabled_ns
>  
> +	mptcp_lib_print_title "New MPTCP socket can be blocked via sysctl"

Because you have 2 exceptions (larger titles), maybe best to use a helper:

  print_larger_title() {
      # here we don't have the time, a bit longer for the alignment
      MPTCP_LIB_TEST_FORMAT="%02u %-69s" \
          mptcp_lib_print_title "${@}"
  }

>  	# net.mptcp.enabled should be enabled by default
>  	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
>  		echo -e "net.mptcp.enabled sysctl is not 1 by default\t\t[ FAIL ]"

(...)

> @@ -830,6 +828,7 @@ stop_if_error()
>  	fi
>  }
>  
> +MPTCP_LIB_TEST_FORMAT="%02u %-69s"

... so you don't have to set it here ...

>  make_file "$cin" "client"
>  make_file "$sin" "server"
>  
> @@ -837,7 +836,7 @@ check_mptcp_disabled
>  
>  stop_if_error "The kernel configuration is not valid for MPTCP"
>  
> -printf "%-69s" "Validating network environment with pings"
> +mptcp_lib_print_title "Validating network environment with pings"

(print_larger_title → clearer)

>  for sender in "$ns1" "$ns2" "$ns3" "$ns4";do
>  	do_ping "$ns1" $sender 10.0.1.1
>  	do_ping "$ns1" $sender dead:beef:1::1
> @@ -860,6 +859,7 @@ mptcp_lib_result_code "${ret}" "ping tests"
>  
>  stop_if_error "Could not even run ping tests"
>  echo "[ OK ]"
> +MPTCP_LIB_TEST_FORMAT="%02u %-50s"

... and here, just to handle 2 exceptions, and it is not clear which
format will be used.

>  
>  [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay ${tc_delay}ms
>  echo -n "INFO: Using loss of $tc_loss "

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> index ae59136b5bb4..a797e13d3fe7 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> @@ -161,6 +161,7 @@ do_transfer()
>  	wait $spid
>  	local rets=$?
>  
> +	mptcp_lib_print_title "Transfer ${ip}"

Please add a note in the commit message explaining that
'mptcp_sockopt.sh' now display more detailed results + why (what you had
in a former patch from v6, merged here).

(Note: to replace patch 5/8, you can also use '${ip:2}' here, maybe
prettier? A detail...)

>  	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
>  		echo " client exit code $retc, server $rets" 1>&2
>  		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
> @@ -174,7 +175,9 @@ do_transfer()
>  		ret=1
>  		return 1
>  	fi
> +	echo "[ OK ]"
>  
> +	mptcp_lib_print_title "Mark ${ip}"

(same here for '${ip:2}' if you want to)

>  	if [ $local_addr = "::" ];then
>  		check_mark $listener_ns 6 || retc=1
>  		check_mark $connector_ns 6 || retc=1
> @@ -190,8 +193,10 @@ do_transfer()
>  	mptcp_lib_result_code "${rets}" "transfer ${ip}"
>  
>  	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
> +		echo "[ OK ]"
>  		return 0
>  	fi
> +	echo "FAIL: Mark ${ip}"

I don't think you need to repeat 'Mark ${ip}', it is already in the
title, no?

>  
>  	return 1
>  }

(...)

> @@ -314,15 +324,7 @@ trap cleanup EXIT
>  run_tests $ns1 $ns2 10.0.1.1
>  run_tests $ns1 $ns2 dead:beef:1::1
>  
> -if [ $ret -eq 0 ];then
> -	echo "PASS: all packets had packet mark set"
> -fi
> -
>  do_mptcp_sockopt_tests
> -if [ $ret -eq 0 ];then
> -	echo "PASS: SOL_MPTCP getsockopt has expected information"
> -fi

Please also mention in the commit message that it no longer displays
'PASS:', because it is duplicated info now that the detailed are displayed.

> -
>  do_tcpinq_tests
>  
>  mptcp_lib_result_print_all_tap

(...)

> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
> index d5f8521b88d5..212782301c6f 100755
> --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
> +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh

(...)

> @@ -205,6 +203,12 @@ do_transfer()
>  	return 1
>  }
>  
> +print_title()
> +{
> +	MPTCP_LIB_TEST_FORMAT="%02u %-55s"

Same here, can be set once above, at the beginning of the file (with a
small comment explaining why we need a bit more space: because we have
more to display :) )

> +	mptcp_lib_print_title "${*}"
> +}
> +
>  run_test()
>  {
>  	local rate1=$1
> @@ -239,7 +243,7 @@ run_test()
>  	# completion (see mptcp_connect): 200ms on each side, add some slack
>  	time=$((time + 400 + slack))
>  
> -	printf "%-60s" "$msg"
> +	print_title "$msg"
>  	do_transfer $small $large $time
>  	lret=$?
>  	mptcp_lib_result_code "${lret}" "${msg}"
> @@ -249,7 +253,7 @@ run_test()
>  	fi
>  
>  	msg+=" - reverse direction"
> -	printf "%-60s" "$(echo -n ${msg} | cut -c1-54)"
> +	print_title "$(echo -n ${msg} | cut -c1-54)"

As discussed on a previous patch, I think it is best not to cut the
title. (and if we had to, best to do that in the helper, not here)

>  	do_transfer $large $small $time
>  	lret=$?
>  	mptcp_lib_result_code "${lret}" "${msg}"

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
