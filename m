Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3F91C1AAA
	for <mptcp@lists.linux.dev>; Mon,  7 Oct 2024 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325339; cv=none; b=lAsTWfh4PZQ5wuk7jgSD6LCHZbvb8x727AbivAPd54mwOfn0kee3ES4DPevIFdQ4RVs2G7sQZIQmKsZJ2TrgCROe97aTnfQsxoAZ9Ou4aWHytlVzHyd0JxqLu9lIRpdk30TJGdAhdiCasofassoxpVVOGF2EXq3jbB0S8ckXyfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325339; c=relaxed/simple;
	bh=+PDkwdfB/rIAkhplfqoAuHSE665gwjecZfyvAZTK3Uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fns+ye2AZq5TzrUBAIoTNyCcSFSdz+t/XdKiwNVs5ewGytzcPdOhtXvD6ayMq1mrfyc31GDvY+CFYEwwIy7hyxtMPyd92q6hniE9jpayOnLHt3OwJLgePFhZKeI3wkrgVxFFdI1qwwDgGJGp9YORfIhzudTWFmkWEh6IG1d9m4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mroi6WDU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mroi6WDU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54715C4CEC6;
	Mon,  7 Oct 2024 18:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728325338;
	bh=+PDkwdfB/rIAkhplfqoAuHSE665gwjecZfyvAZTK3Uo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mroi6WDUuQ1Q2jjj4+sVdkiZ6q25V2jIOZ/0G8jD3awIfN5bSER/WdA3S6KNvNkWh
	 c3/9caxvZjs9ibSjsj9HCnsRF4ZqZ6DETCQCSWfAJhsnh16AHNxsqu69mV+3XWU9D/
	 Lczk72dtJzuQDqgL2isEbFRysF8ldalWB/HnlGSeJ8jSW0f+hQbnwVqxFey/+MaYaF
	 st1jtutbI69FKjuSvgvjQ3YeB4nJa1dFO39zQmX60wcFgLC6qeL37Zxd6X+8KOTdgu
	 JH0EtO5obyJbrkJ19KyNt3eNGA+zFe0fKNvC+PHZSl868s8oHWz7TcBfM+kNdYQX5u
	 x0erFDGZVvsPw==
Message-ID: <35a0cbbe-4b64-49e1-bc65-4a68cfd99485@kernel.org>
Date: Mon, 7 Oct 2024 20:22:16 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 2/2] selftests: mptcp: join: add test-case for
 MPC attempt towards signl ep
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Cong Wang <xiyou.wangcong@gmail.com>
References: <833cae5982ac5d5b3236845c6db4315e634f5705.1727974826.git.pabeni@redhat.com>
 <66cfbfdf241fb43c51bf3c7d35c92f79a92b025d.1727974826.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <66cfbfdf241fb43c51bf3c7d35c92f79a92b025d.1727974826.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 03/10/2024 19:02, Paolo Abeni wrote:
> Explicitly verify that MPC connection attempts towards a port-based
> signal endpoint fail with a reset.

Thank you for this fix!

Same here, the code looks good to me, but I have some small suggestions,
and I can send them in a v2.

> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 80 ++++++++++++++-----
>  1 file changed, 58 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index e8d0a01b4144..5e2ab7dfb182 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -41,6 +41,7 @@ evts_ns2_pid=0
>  last_test_failed=0
>  last_test_skipped=0
>  last_test_ignored=1
> +cappid=""
>  
>  declare -A all_tests
>  declare -a only_tests_ids
> @@ -887,6 +888,34 @@ check_cestab()
>  	fi
>  }
>  
> +cond_start_capture()
> +{
> +	if $capture; then
> +		local capuser
> +		if [ -z $SUDO_USER ] ; then
> +			capuser=""
> +		else
> +			capuser="-Z $SUDO_USER"
> +		fi
> +
> +		local capfile=$(printf "mp_join-%02u-%s.pcap" "$MPTCP_LIB_TEST_COUNTER" "${listener_ns}")

Shellcheck is complaining here:
  > SC2155 (warning): Declare and assign separately to avoid masking
return values.

So 'local capfile' should be declared before.

> +
> +		echo "Capturing traffic for test $MPTCP_LIB_TEST_COUNTER into $capfile"
> +		ip netns exec $1 tcpdump -i any -s 65535 -B 32768 $capuser -w $capfile > "$capout" 2>&1 &
> +		cappid=$!
> +
> +		sleep 1
> +	fi
> +}
> +
> +cond_stop_capture()
> +{
> +	if $capture; then
> +	    sleep 1
> +	    kill $cappid

(while at it, we can fix the indentation using tabs)

> +	fi
> +}
> +
>  do_transfer()
>  {
>  	local listener_ns="$1"
> @@ -896,7 +925,6 @@ do_transfer()
>  	local connect_addr="$5"
>  
>  	local port=$((10000 + MPTCP_LIB_TEST_COUNTER - 1))
> -	local cappid
>  	local FAILING_LINKS=${FAILING_LINKS:-""}
>  	local fastclose=${fastclose:-""}
>  	local speed=${speed:-"fast"}
> @@ -905,22 +933,7 @@ do_transfer()
>  	:> "$sout"
>  	:> "$capout"

This line should be moved too I suppose, and the 'cat' should be done at
the end.

>  
> -	if $capture; then
> -		local capuser
> -		if [ -z $SUDO_USER ] ; then
> -			capuser=""
> -		else
> -			capuser="-Z $SUDO_USER"
> -		fi
> -
> -		capfile=$(printf "mp_join-%02u-%s.pcap" "$MPTCP_LIB_TEST_COUNTER" "${listener_ns}")
> -
> -		echo "Capturing traffic for test $MPTCP_LIB_TEST_COUNTER into $capfile"
> -		ip netns exec ${listener_ns} tcpdump -i any -s 65535 -B 32768 $capuser -w $capfile > "$capout" 2>&1 &
> -		cappid=$!
> -
> -		sleep 1
> -	fi
> +	cond_start_capture ${listener_ns}
>  
>  	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
>  		nstat -n
> @@ -1007,11 +1020,6 @@ do_transfer()
>  	wait $spid
>  	local rets=$?
>  
> -	if $capture; then
> -	    sleep 1
> -	    kill $cappid
> -	fi

I guess you still want to stop the capture here.

  cond_stop_capture

> -
>  	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
>  		nstat | grep Tcp > /tmp/${listener_ns}.out
>  	NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
> @@ -2160,6 +2168,34 @@ signal_address_tests()
>  			chk_add_nr 3 3
>  		fi
>  	fi
> +
> +	if reset "port-based signal endpoint must not accept mpc"; then

Can we move this test at the end of the add_addr_ports_tests section?

> +		local port=$((10000 + MPTCP_LIB_TEST_COUNTER - 1))

(detail: maybe we can have a helper for this, just to show we use the
same one as in do_transfer())

> +
> +		cond_start_capture ${ns1}
> +
> +		pm_nl_add_endpoint ${ns1} 10.0.2.1 flags signal port ${port}
> +		mptcp_lib_wait_local_port_listen ${ns1} ${port}
> +
> +		timeout 1 ip netns exec ${ns2} \
> +			./mptcp_connect -t ${timeout_poll} -p $port -s MPTCP 10.0.2.1 >/dev/null 2>&1
> +		local ret=$?
> +
> +		cond_stop_capture
> +
> +		if [ ${ret} = 124 ]; then
> +			fail_test "timeout on connect"

A check name is missing here (print_check()) like in the other validations.

> +		elif [ ! ${ret} ]; then
> +			fail_test "unexpected successful connect"
> +		else
> +			local count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPCAttemptOnEndpoint")

(shellcheck is complaining about the same error here)

> +			if [ "${count}" != 1 ]; then
> +				fail_test "got ${count} MPC attempts on port-based enpoint, expected 1"

We should skip the test if the counter is not available, like in the
other validations.

> +			else
> +				print_ok
> +			fi
> +		fi

Maybe we should move the validation to another helper, just to keep only
the declaration here, and the validation elsewhere, just like other
tests (even here it is not going to be used by other tests)?

> +	fi
>  }
>  
>  link_failure_tests()

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

