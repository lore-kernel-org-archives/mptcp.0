Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102793DB626
	for <mptcp@lists.linux.dev>; Thu, 18 Jun 2026 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781775062; cv=none; b=r/Ue/3qq2SXh481+42pmnIgIc9M8E+GXbN+Df0qbsiY/qa4vlddVpo2rUWQnzUoYgRKh8BxWhkiWFoXSCGW9yFyIG06Oo5yWSslGY1CSb9XD8AJGcdpLAGOEoFJAbAGf1cikwLHSTPb6FeuEm+E5qMEKK3VeDJUx+WidEYOEelY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781775062; c=relaxed/simple;
	bh=+GObux1eVv2EEJTrKAozKjqiI8LAKPC/RBuHGnduABE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqkxtjZ6KZZDgP5uYvD1tFoU+dllJjGL5gbwUs3bMHDUTsNn7/anzdhkD/q9W04sB/A8kAXTj+YrSU3tJaZ5PQPlb5BfYlN/C5AvbzVY5xscbt/2JijtBrORCoCG2hMUbzMr47SdKXLDkus4VPEpJNSiskb7lwR06JmVfOCVwYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFIVQfUV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFIVQfUV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58A71F00A3F;
	Thu, 18 Jun 2026 09:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781775060;
	bh=Ak3X6PIRfGNFMWczfAX04bCNYWAn3/RTsG/YAKYb00E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cFIVQfUVJt/e61ciRjwP3ME6hfIK9T8Q6mPHEW4yvsnNP5/9/aKjZ5Tn7RP4NyDVh
	 tpTafUdVAnijFKeGR7EPH7F+EW3rWXQIIGnFx5aMcbpj8+mBJiskz8RZ+XFoHRQfME
	 p7SLXSBGXuo/J3LyaLteS8/jpt+L5ICrobS024f6cvzUv0WLgVbdAPuPzKEnDnhKyk
	 hBIec3LhzazOPtqwRZ6+C9YcyaEvYrHX0+WD5HU/9CCpoabNwaY8DVSiTRLwc+VMrh
	 824LSLX2Ge7AAxSGx+PzJbfbvQ15UYKIsFbAG3a1lSk1L0m2tZij0DDAcpvFoY2Zuf
	 ZenlG2mKkCLOA==
Message-ID: <f153357a-1c0c-4cfd-a2e0-44666a1e4f87@kernel.org>
Date: Thu, 18 Jun 2026 11:30:59 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 5/9] selftests: mptcp: mptcp_sockopt.sh
 skips v6 paths when MPTCP IPv6 is missing
Content-Language: fr
To: Gang Yan <gang.yan@linux.dev>, mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
References: <cover.1781707101.git.yangang@kylinos.cn>
 <b65affe40258762c96d6d6e48d3b3d35d72ad8c8.1781707101.git.yangang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <b65affe40258762c96d6d6e48d3b3d35d72ad8c8.1781707101.git.yangang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/06/2026 16:46, Gang Yan wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> Confine all of ipv6-related commands to mptcp_lib_is_v6_enabled:
>   - call mptcp_lib_check_ipv6() once after the existing init-time
>     mptcp_lib_check_*() calls to populate the cached flag;
>   - guard the ip6tables loop in add_mark_rules() and every v6
>     "ip addr add" / mptcp_lib_pm_nl_add_endpoint() in init();
>   - in do_mptcp_sockopt_tests(), do_tcpinq_tests() and the top-level
>     run_tests dispatcher, emit a SKIP TAP line for each v6 subtest
>     instead of running it.
> 
> v4 transfers, v4 mark checks and the AF_INET sockopt / TCP_INQ tests
> are untouched. In a full-featured kernel the new guards always take
> their v6 branch and the test set runs as before.
> 
> Assisted-by: GLM:5.1 Z.ai
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  .../selftests/net/mptcp/mptcp_sockopt.sh      | 94 +++++++++++++++----
>  1 file changed, 75 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> index e850a87429b6..ae7776b17c33 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> @@ -50,7 +50,7 @@ add_mark_rules()
>  	local m=$2
>  
>  	local t
> -	for t in ${iptables} ${ip6tables}; do
> +	for t in ${iptables}; do

Instead, you could keep most of the code here, and have something like:

  if [ ${t} = ${ip6tables} ] && ! mptcp_lib_is_v6_enabled; then
      continue
  fi

>  		# just to debug: check we have multiple subflows connection requests
>  		ip netns exec $ns $t -A OUTPUT -p tcp --syn -m mark --mark $m -j ACCEPT
>  
> @@ -60,6 +60,21 @@ add_mark_rules()
>  		ip netns exec $ns $t -A OUTPUT -p tcp -m mark --mark $m -j ACCEPT
>  		ip netns exec $ns $t -A OUTPUT -p tcp -m mark --mark 0 -j DROP
>  	done
> +	# ip6tables rules require MPTCP IPv6 support in the kernel, otherwise
> +	# ip6tables will reject them (or, in some environments, the binary itself
> +	# may behave oddly without IPv6 available).

I'm not sure to understand here: what's the link between ip6tables and
MPTCP IPv6 support? Or only check if the binary is there. Still it looks
like this modification is not needed.

> +	if mptcp_lib_is_v6_enabled; then
> +		for t in ${ip6tables}; do
> +			# just to debug: check we have multiple subflows connection requests
> +			ip netns exec $ns $t -A OUTPUT -p tcp --syn -m mark --mark $m -j ACCEPT
> +
> +			# RST packets might be handled by a internal dummy socket
> +			ip netns exec $ns $t -A OUTPUT -p tcp --tcp-flags RST RST -m mark --mark 0 -j ACCEPT
> +
> +			ip netns exec $ns $t -A OUTPUT -p tcp -m mark --mark $m -j ACCEPT
> +			ip netns exec $ns $t -A OUTPUT -p tcp -m mark --mark 0 -j DROP
> +		done
> +	fi
>  }
>  
>  init()
> @@ -70,21 +85,29 @@ init()
>  	for i in $(seq 1 4); do
>  		ip link add ns1eth$i netns "$ns1" type veth peer name ns2eth$i netns "$ns2"
>  		ip -net "$ns1" addr add 10.0.$i.1/24 dev ns1eth$i
> -		ip -net "$ns1" addr add dead:beef:$i::1/64 dev ns1eth$i nodad
> +		if mptcp_lib_is_v6_enabled; then
> +			ip -net "$ns1" addr add dead:beef:$i::1/64 dev ns1eth$i nodad
> +		fi
>  		ip -net "$ns1" link set ns1eth$i up
>  
>  		ip -net "$ns2" addr add 10.0.$i.2/24 dev ns2eth$i
> -		ip -net "$ns2" addr add dead:beef:$i::2/64 dev ns2eth$i nodad
> +		if mptcp_lib_is_v6_enabled; then
> +			ip -net "$ns2" addr add dead:beef:$i::2/64 dev ns2eth$i nodad
> +		fi
>  		ip -net "$ns2" link set ns2eth$i up
>  
>  		# let $ns2 reach any $ns1 address from any interface
>  		ip -net "$ns2" route add default via 10.0.$i.1 dev ns2eth$i metric 10$i
>  
>  		mptcp_lib_pm_nl_add_endpoint "${ns1}" "10.0.${i}.1" flags signal
> -		mptcp_lib_pm_nl_add_endpoint "${ns1}" "dead:beef:${i}::1" flags signal
> +		if mptcp_lib_is_v6_enabled; then
> +			mptcp_lib_pm_nl_add_endpoint "${ns1}" "dead:beef:${i}::1" flags signal
> +		fi
>  
>  		mptcp_lib_pm_nl_add_endpoint "${ns2}" "10.0.${i}.2" flags signal
> -		mptcp_lib_pm_nl_add_endpoint "${ns2}" "dead:beef:${i}::2" flags signal
> +		if mptcp_lib_is_v6_enabled; then
> +			mptcp_lib_pm_nl_add_endpoint "${ns2}" "dead:beef:${i}::2" flags signal
> +		fi

Maybe better to regroup all commands under on "if v6".

>  	done
>  
>  	mptcp_lib_pm_nl_set_limits "${ns1}" 8 8
> @@ -106,6 +129,7 @@ cleanup()
>  mptcp_lib_check_mptcp
>  mptcp_lib_check_kallsyms
>  mptcp_lib_check_tools ip "${iptables}" "${ip6tables}"
> +mptcp_lib_check_ipv6
>  
>  check_mark()
>  {
> @@ -164,6 +188,20 @@ do_transfer()
>  		ip=ipv4
>  	fi
>  
> +	# Skip v6 subtests when the running kernel has no MPTCP IPv6 support.
> +	# Reuses the same ${ip}/${ip:2} naming as the normal path below so the
> +	# console counter (MPTCP_LIB_TEST_COUNTER, bumped by print_title) and
> +	# the TAP index (bumped by mptcp_lib_result_skip) stay in lock-step.
> +	if [ "${ip}" = "ipv6" ] && ! mptcp_lib_is_v6_enabled; then
> +		print_title "Transfer ${ip:2}"
> +		mptcp_lib_pr_skip "MPTCP IPv6 not available"
> +		mptcp_lib_result_skip "transfer ${ip}"
> +		print_title "Mark ${ip:2}"
> +		mptcp_lib_pr_skip "MPTCP IPv6 not available"
> +		mptcp_lib_result_skip "mark ${ip}"
> +		return 0
> +	fi
> +
>  	cmsg="TIMESTAMPNS"
>  	if mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
>  		cmsg+=",TCPINQ"
> @@ -274,18 +312,23 @@ do_mptcp_sockopt_tests()
>  	mptcp_lib_pr_ok
>  	mptcp_lib_result_pass "sockopt v4"
>  
> -	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
> -	lret=$?
> -
>  	print_title "SOL_MPTCP sockopt v6"
> -	if [ $lret -ne 0 ]; then
> -		mptcp_lib_pr_fail
> -		mptcp_lib_result_fail "sockopt v6"
> -		ret=$lret
> -		return
> +	if ! mptcp_lib_is_v6_enabled; then
> +		mptcp_lib_pr_skip "MPTCP IPv6 not available"
> +		mptcp_lib_result_skip "sockopt v6"
> +	else
> +		ip netns exec "$ns_sbox" ./mptcp_sockopt -6
> +		lret=$?
> +
> +		if [ $lret -ne 0 ]; then
> +			mptcp_lib_pr_fail
> +			mptcp_lib_result_fail "sockopt v6"
> +			ret=$lret
> +			return
> +		fi
> +		mptcp_lib_pr_ok
> +		mptcp_lib_result_pass "sockopt v6"
>  	fi
> -	mptcp_lib_pr_ok
> -	mptcp_lib_result_pass "sockopt v6"

Maybe this chunk can be reduced?

  if ! mptcp_lib_is_v6_enabled; then
     skip
     return
  fi

and the rest is not modified, no?
>  }
>  
>  run_tests()
> @@ -308,6 +351,13 @@ run_tests()
>  do_tcpinq_test()
>  {
>  	print_title "TCP_INQ cmsg/ioctl $*"
> +
> +	if [ "${1}" = "-6" ] && ! mptcp_lib_is_v6_enabled; then
> +		mptcp_lib_pr_skip "MPTCP IPv6 not available"
> +		mptcp_lib_result_skip "TCP_INQ: $*"
> +		return 0
> +	fi
> +
>  	ip netns exec "$ns_sbox" ./mptcp_inq "$@"
>  	local lret=$?
>  	if [ $lret -ne 0 ];then
> @@ -339,10 +389,16 @@ do_tcpinq_tests()
>  		if [ $lret -ne 0 ] ; then
>  			return $lret
>  		fi
> -		do_tcpinq_test -6 $args
> -		lret=$?
> -		if [ $lret -ne 0 ] ; then
> -			return $lret
> +		if mptcp_lib_is_v6_enabled; then
> +			do_tcpinq_test -6 $args
> +			lret=$?
> +			if [ $lret -ne 0 ] ; then
> +				return $lret
> +			fi
> +		else
> +			print_title "TCP_INQ cmsg/ioctl -6 $args"
> +			mptcp_lib_pr_skip "MPTCP IPv6 not available"
> +			mptcp_lib_result_skip "TCP_INQ: -6 $args"
>  		fi
>  	done
>  

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

