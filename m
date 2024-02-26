Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7A17FBAA
	for <mptcp@lists.linux.dev>; Mon, 26 Feb 2024 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951239; cv=none; b=t79UqfbuPGo/0/IRaj0xysV1HVx3T2NgngH4i5ExQv5uVXtSK1XMVgTuEkEASya0nmi/+KveADzUzMVffVlsg5TSsEDnr2lufrwWEFZBM+07Kj9gpNM8mU/2spuhSR5f4dspY3xgKgAyks7KPgYyhodKBAefwOXYsIUeXcxnc04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951239; c=relaxed/simple;
	bh=xDuqlOMXc9QqkKWxeO1Hb7Qo1fy+TnYSpiwH1+owTHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cv41+hbExM27CpakiRZGh0B3+JSmtbmqZudNaSfb1iCNXnVEl4fA0e7lJS4OM4lO5UzPrpW8U9BmkF2r1OxQQOQ990Wv3u2pfZLQ4u7ewIZnRgFk7j8WMP91of7+DabkwgsBGJSlA5jVDwYdySfLXQMV+0IO0yQo+fmzO1WkGZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZ3NSQuQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZ3NSQuQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924D1C433F1;
	Mon, 26 Feb 2024 12:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708951239;
	bh=xDuqlOMXc9QqkKWxeO1Hb7Qo1fy+TnYSpiwH1+owTHA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FZ3NSQuQWMhSlZvfS3mKAy09MIRoPPjes1cPQ5NDdbG2Xnpo814fUqlOeuRaElQ59
	 vicD/KCw460emcxQ8uu8JuQ3qdhERq2/qpIcJ669uWZgIVBWEpnom0sdsGVl7XMnPg
	 hgG6lnIJBa/07LrZ4IuktL8PLkzHDlzsERpBnNx99RUiJrNsnp2uJDSeGnIHpuyVxI
	 I5dCuchlTk8SyeIaDLNSmmE15F8bt/xnn3K1mypZecZ7sVMSCGNrNA9LItS9Ngkx8W
	 wGiAv/Y6J3YYtXafvPyTuCroaGirLO+OvxiXmBl2F8zCwMsNWBOxihnq+mzBFkam32
	 xoA/BW0JOBmpg==
Message-ID: <405e2ab8-7483-4bf7-a9a5-a94c631af404@kernel.org>
Date: Mon, 26 Feb 2024 13:40:38 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v5 02/12] selftests: mptcp: sockopt: print
 every test result
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1708939962.git.tanggeliang@kylinos.cn>
 <1aa6a9af7ebd8690e595bfbbdde5f54f684f51e8.1708939962.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <1aa6a9af7ebd8690e595bfbbdde5f54f684f51e8.1708939962.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 26/02/2024 10:43, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Only total test results are printed out in mptcp_sockopt.sh:
> 
>  PASS: all packets had packet mark set
>  PASS: SOL_MPTCP getsockopt has expected information
>  PASS: TCP_INQ cmsg/ioctl -t tcp
>  PASS: TCP_INQ cmsg/ioctl -6 -t tcp
>  PASS: TCP_INQ cmsg/ioctl -r tcp
>  PASS: TCP_INQ cmsg/ioctl -6 -r tcp
> 
> This patch prints more info for every test result in each test
> group:
> 
>  transfer ipv4                                                [ OK ]
>  mark ipv4                                                    [ OK ]
>  transfer ipv6                                                [ OK ]
>  mark ipv6                                                    [ OK ]
>  PASS: all packets had packet mark set
>  sockopt v4                                                   [ OK ]
>  sockopt v6                                                   [ OK ]
>  PASS: SOL_MPTCP getsockopt has expected information
>  TCP_INQ: -t tcp                                              [ OK ]
>  PASS: TCP_INQ cmsg/ioctl -t tcp
>  TCP_INQ: -6 -t tcp                                           [ OK ]
>  PASS: TCP_INQ cmsg/ioctl -6 -t tcp
>  TCP_INQ: -r tcp                                              [ OK ]
>  PASS: TCP_INQ cmsg/ioctl -r tcp
>  TCP_INQ: -6 -r tcp                                           [ OK ]
>  PASS: TCP_INQ cmsg/ioctl -6 -r tcp
>  TCP_INQ: -r tcp -t tcp                                       [ OK ]

Please clearly explain why this is interesting, even if it looks obvious.

Here, I don't know if this patch makes sense or not: to me, the output
is now confusing because there is a mix of '[ OK ]' and 'PASS'. Maybe:

- remove all the "PASS: xxx"? → I don't see what it brings more
- (or convert existing "PASS: xxx" and "FAIL: xxx" to use "[ OK ]"? But
there are fewer details)

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> index 6ed4aa32222f..f84185b5dc9f 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> @@ -161,6 +161,7 @@ do_transfer()
>  	wait $spid
>  	local rets=$?
>  
> +	printf "%-50s" "transfer ${ip}"

Best to use a helper to avoid repeating '"%-50s"', and to be able to
change how the titles are displayed from a single place. (same below of
course)

Also, probably looking better if you use 'Transfer' instead of 'transfer'.

>  	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
>  		echo " client exit code $retc, server $rets" 1>&2
>  		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
> @@ -169,12 +170,15 @@ do_transfer()
>  		echo -e "\nnetns ${connector_ns} socket stat for ${port}:" 1>&2
>  		ip netns exec ${connector_ns} ss -Menita 1>&2 -o "dport = :$port"
>  
> +		mptcp_lib_print_err "[FAIL]"
>  		mptcp_lib_result_fail "transfer ${ip}"
>  
>  		ret=1
>  		return 1
>  	fi
> +	mptcp_lib_print_ok "[ OK ]"

(here as well, we could use 'mptcp_lib_print_success/fail/skip'
suggested in patch 1/12)

>  
> +	printf "%-50s" "mark ${ip}"

Same here: 'Mark' vs 'mark'.

>  	if [ $local_addr = "::" ];then
>  		check_mark $listener_ns 6 || retc=1
>  		check_mark $connector_ns 6 || retc=1
> @@ -190,8 +194,10 @@ do_transfer()
>  	mptcp_lib_result_code "${rets}" "transfer ${ip}"
>  
>  	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
> +		mptcp_lib_print_ok "[ OK ]"
>  		return 0
>  	fi
> +	mptcp_lib_print_err "[FAIL]"
>  
>  	return 1
>  }
> @@ -220,23 +226,27 @@ do_mptcp_sockopt_tests()
>  	ip netns exec "$ns_sbox" ./mptcp_sockopt
>  	lret=$?
>  
> +	printf "%-50s" "sockopt v4"

Maybe 'SOL_MPTCP getsockopt v4'?

>  	if [ $lret -ne 0 ]; then
>  		echo "FAIL: SOL_MPTCP getsockopt" 1>&2
>  		mptcp_lib_result_fail "sockopt v4"
>  		ret=$lret
>  		return
>  	fi
> +	mptcp_lib_print_ok "[ OK ]"
>  	mptcp_lib_result_pass "sockopt v4"
>  
>  	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
>  	lret=$?
>  
> +	printf "%-50s" "sockopt v6"
>  	if [ $lret -ne 0 ]; then
>  		echo "FAIL: SOL_MPTCP getsockopt (ipv6)" 1>&2
>  		mptcp_lib_result_fail "sockopt v6"
>  		ret=$lret
>  		return
>  	fi
> +	mptcp_lib_print_ok "[ OK ]"
>  	mptcp_lib_result_pass "sockopt v6"
>  }
>  
> @@ -259,6 +269,7 @@ run_tests()
>  
>  do_tcpinq_test()
>  {
> +	printf "%-50s" "TCP_INQ: $*"
>  	ip netns exec "$ns_sbox" ./mptcp_inq "$@"
>  	local lret=$?
>  	if [ $lret -ne 0 ];then
> @@ -267,6 +278,7 @@ do_tcpinq_test()
>  		mptcp_lib_result_fail "TCP_INQ: $*"
>  		return $lret
>  	fi
> +	mptcp_lib_print_ok "[ OK ]"
>  
>  	echo "PASS: TCP_INQ cmsg/ioctl $*"
>  	mptcp_lib_result_pass "TCP_INQ: $*"

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
