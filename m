Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A147F470
	for <mptcp@lists.linux.dev>; Mon, 26 Feb 2024 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951301; cv=none; b=HFDzOc497vPP3qXAql9Oy2C/i0cXIT6YohAwQcVqUqs6N9U07Si6H7t7r0vvzC7NgXHQ9y0W3CC8UDodeIbApNy3Z52G5DaA+gjRbOOoQ5+aN5ENOW9sBe/fmDbrfNakJSI0cZzGAcY317K2aSW7yopz1z2nN0yS3xwXe78YJvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951301; c=relaxed/simple;
	bh=asoaMzRJybuB20ajzWcNzHHYUPAKxpVTXnKp8aw9gnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CxtBYBbhASlnGkQ97R1RvZtbGlaRRqAqOo+wfaGQ2lmbSHtg1rJp1fiZ1FdErwvXMzpqlxxKBNdAqGW/UsM0+gaTc7MazfACjoAoBYex0t8ZIDT+hDDEklWhJKeUF0x9vzjN4LQrhkqy77Dsw55tPvc0KCqaPsuFIZi3BtSUzzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCT4ahB3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCT4ahB3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39C6C433F1;
	Mon, 26 Feb 2024 12:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708951301;
	bh=asoaMzRJybuB20ajzWcNzHHYUPAKxpVTXnKp8aw9gnE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uCT4ahB3eqOUAioLiizdtrBvRwkKWAeC+LE8gKbdMiu/Zqned7btUBMaag9xZGVs6
	 kN/g519UYo9RrQeLHYorXSV3PiNtzNbcWjgo3wqSqq22+UXIV4+WZtLwGoYJfjAvwc
	 R5NI46BufH/SExKIXrGUD7//IBa1VEKz+99wMp9S4yCk2Gt1bVfp36lL9YfRC3Z9Ts
	 tfQCwRy7ekbSarwhvLPwiiwSlv6ESQmpI5CmYzXqhB2F1p4GYph/tNGoPcoD8SwT2q
	 3jqSBueqNeZrGnfCqhh+p+50gqz3KiqbNWsTFDUr4a19zM4H2O+X90Qzpme/NQ7/r3
	 bd1ZDluAY7/8Q==
Message-ID: <e898766d-8116-4d04-9d9f-56245ef0f56d@kernel.org>
Date: Mon, 26 Feb 2024 13:41:40 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v5 07/12] selftests: mptcp: print test results
 with counters
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1708939962.git.tanggeliang@kylinos.cn>
 <ceb85fa70bc1c314fc7bab4e29b4e1b30e38dae4.1708939962.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ceb85fa70bc1c314fc7bab4e29b4e1b30e38dae4.1708939962.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 26/02/2024 10:43, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds a new helper mptcp_lib_print_test_counter() to print
> out test counter in each test result and increase the counter. Use
> this helper to print out test counters for every tests in diag.sh,
> mptcp_connect.sh, mptcp_sockopt.sh, pm_netlink.sh, simult_flows.sh,
> and userspace_pm.sh.
> 
> Each output looks like:
> 
> diag.sh
>  01 no msk on netns creation                          [  OK  ]
>  02 listen match for dport 10000                      [  OK  ]
>  03 listen match for sport 10000                      [  OK  ]
>  04 listen match for saddr and sport                  [  OK  ]
>  05 all listen sockets                                [  OK  ]
> 
> mptcp_connect.sh
>  01 New MPTCP socket can be blocked via sysctl                      [ OK ]
>  INFO: validating network environment with pings
>  02 ping tests                                                      [ OK ]
>  INFO: Using loss of 0.16% delay 25 ms reorder .. with delay 6ms on ns3eth4
>  03 ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP  (duration 116ms) [ OK ]
>  04 ns1 MPTCP -> ns1 (10.0.1.1:10001      ) TCP    (duration  33ms) [ OK ]
>  05 ns1 TCP   -> ns1 (10.0.1.1:10002      ) MPTCP  (duration  25ms) [ OK ]
>  06 ns1 MPTCP -> ns1 (dead:beef:1::1:10003) MPTCP  (duration 128ms) [ OK ]
>  07 ns1 MPTCP -> ns1 (dead:beef:1::1:10004) TCP    (duration  31ms) [ OK ]
> 
> mptcp_sockopt.sh
>  01 transfer ipv4                                                [ OK ]
>  02 mark ipv4                                                    [ OK ]
>  03 transfer ipv6                                                [ OK ]
>  04 mark ipv6                                                    [ OK ]
>  PASS: all packets had packet mark set
>  05 sockopt v4                                                   [ OK ]
>  06 sockopt v6                                                   [ OK ]
>  PASS: SOL_MPTCP getsockopt has expected information
>  07 TCP_INQ: -t tcp                                              [ OK ]
>  PASS: TCP_INQ cmsg/ioctl -t tcp
>  08 TCP_INQ: -6 -t tcp                                           [ OK ]
>  PASS: TCP_INQ cmsg/ioctl -6 -t tcp
>  09 TCP_INQ: -r tcp                                              [ OK ]
>  PASS: TCP_INQ cmsg/ioctl -r tcp
>  10 TCP_INQ: -6 -r tcp                                           [ OK ]
> 
> pm_netlink.sh
>  01 defaults addr list                        [ OK ]
>  02 simple add/get addr                       [ OK ]
>  03 dump addrs                                [ OK ]
>  04 simple del addr                           [ OK ]
>  05 dump addrs after del                      [ OK ]
>  06 duplicate addr                            [ OK ]
>  07 id addr increment                         [ OK ]
>  08 hard addr limit                           [ OK ]
>  09 above hard addr limit                     [ OK ]
> 
> simult_flows.sh
>  01 balanced bwidth                          7411 max 8456       [ OK ]
>  02 balanced bwidth - reverse direction      7380 max 8456       [ OK ]
>  03 balanced bwidth with unbalanced delay    7434 max 8456       [ OK ]
> 
> userspace_pm.sh
>  INFO: Init
>  01 Created network namespaces ns1, ns2                       [ OK ]
>  INFO: Make connections
>  02 Established IPv4 MPTCP Connection ns2 => ns1              [ OK ]
>  03 Established IPv6 MPTCP Connection ns2 => ns1              [ OK ]
>  INFO: Announce tests
>  04 ADD_ADDR 10.0.2.2 (ns2) => ns1, invalid token             [ OK ]
>  05 ADD_ADDR id:14 10.0.2.2 (ns2) => ns1, reuse port          [ OK ]
> 
> Having test counters helps to quickly identify issues when looking at a
> long list of output logs and results.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/diag.sh     |  8 ++---
>  .../selftests/net/mptcp/mptcp_connect.sh      | 33 +++++++++++--------
>  .../testing/selftests/net/mptcp/mptcp_lib.sh  |  8 +++++
>  .../selftests/net/mptcp/mptcp_sockopt.sh      | 12 ++++---
>  .../testing/selftests/net/mptcp/pm_netlink.sh |  6 ++--
>  .../selftests/net/mptcp/simult_flows.sh       |  7 ++--
>  .../selftests/net/mptcp/userspace_pm.sh       |  3 +-
>  7 files changed, 47 insertions(+), 30 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
> index f9f62a8f41e3..01e9f11f1f47 100755
> --- a/tools/testing/selftests/net/mptcp/diag.sh
> +++ b/tools/testing/selftests/net/mptcp/diag.sh
> @@ -9,7 +9,7 @@
>  . "$(dirname "${0}")/mptcp_lib.sh"
>  
>  ns=""
> -test_cnt=1
> +test_cnt=0

Is it normal shellcheck doesn't complain about it not being used?

>  timeout_poll=30
>  timeout_test=$((timeout_poll * 2 + 1))
>  ret=0
> @@ -55,7 +55,7 @@ __chk_nr()
>  
>  	nr=$(eval $command)
>  
> -	printf "%-50s" "$msg"
> +	mptcp_lib_print_test_counter test_cnt "%-50s" "$msg"

Same here, probably best with a helper, to avoid repeating the long list
of arguments:

  # $1: test name
  print_test() {
      mptcp_lib_print_test_counter test_cnt "%-50s" "${1}"
  }

  (...)

  print_test "${msg}"

Same in the other files not using a helper already (like mptcp_join.sh
and userspace_pm.sh)

(see my comment in mptcp_lib.sh: maybe easier to remove params, and just
call 'mptcp_lib_print_test_counter "${msg}"')

>  	if [ "$nr" != "$expected" ]; then
>  		if [ "$nr" = "$skip" ] && ! mptcp_lib_expect_all_features; then
>  			mptcp_lib_print_warn "[SKIP] Feature probably not supported"

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index 06e945914ace..00bbe451e50d 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -131,6 +131,7 @@ ns2=""
>  ns3=""
>  ns4=""
>  
> +#shellcheck disable=SC2034

Please justify all disabled shellcheck checks, e.g.

#shellcheck disable=SC2034 # TEST_COUNT is used by mptcp_lib.sh

same below

(see my comment below: why not defining it in mptcp_lib.sh then?)

>  TEST_COUNT=0
>  TEST_GROUP=""
>  
> @@ -255,8 +256,9 @@ check_mptcp_disabled()
>  
>  	# net.mptcp.enabled should be enabled by default
>  	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
> -		echo -n -e "net.mptcp.enabled sysctl is not 1 by default"
> -		mptcp_lib_print_err "\t\t\t   [FAIL]"
> +		mptcp_lib_print_test_counter TEST_COUNT "%s" \
> +			"net.mptcp.enabled sysctl is not 1 by default"

The test name should be printed before the test: so the counter will be
incremented in case of issue or not:

  mptcp_lib_print_test_counter "MPTCP socket can be blocked via sysctl"
  if [ ... ]; then
       mptcp_lib_print_fail "net.mptcp.enabled sysctl is not (...)"
       (...)
  fi

  if [ ... ]; then
       mptcp_lib_print_fail "MPTCP socket cannot be blocked via sysctl"
       (...)
  fi

  mptcp_lib_print_success


> +		mptcp_lib_print_err "\t\t\t\t   [FAIL]"
>  		mptcp_lib_result_fail "net.mptcp.enabled sysctl is not 1 by default"
>  		ret=1
>  		return 1
> @@ -269,15 +271,17 @@ check_mptcp_disabled()
>  	mptcp_lib_ns_exit "${disabled_ns}"
>  
>  	if [ ${err} -eq 0 ]; then
> -		echo -n -e "New MPTCP socket cannot be blocked via sysctl"
> -		mptcp_lib_print_err "\t\t\t   [FAIL]"
> +		mptcp_lib_print_test_counter TEST_COUNT "%s" \
> +			"New MPTCP socket cannot be blocked via sysctl"
> +		mptcp_lib_print_err "\t\t\t\t   [FAIL]"
>  		mptcp_lib_result_fail "New MPTCP socket cannot be blocked via sysctl"
>  		ret=1
>  		return 1
>  	fi
>  
> -	echo -n -e "New MPTCP socket can be blocked via sysctl"
> -	mptcp_lib_print_ok "\t\t\t   [ OK ]"
> +	mptcp_lib_print_test_counter TEST_COUNT "%s" \
> +		"New MPTCP socket can be blocked via sysctl"
> +	mptcp_lib_print_ok "\t\t\t\t   [ OK ]"
>  	mptcp_lib_result_pass "New MPTCP socket can be blocked via sysctl"
>  	return 0
>  }
> @@ -319,7 +323,6 @@ do_transfer()
>  
>  	local port
>  	port=$((10000+PORT++))
> -	TEST_COUNT=$((TEST_COUNT+1))
>  
>  	if [ "$rcvbuf" -gt 0 ]; then
>  		extra_args="$extra_args -R $rcvbuf"
> @@ -346,7 +349,7 @@ do_transfer()
>  	addr_port=$(printf "%s:%d" ${connect_addr} ${port})
>  	local result_msg
>  	result_msg="$(printf "%.3s %-5s -> %.3s (%-20s) %-5s" ${connector_ns} ${cl_proto} ${listener_ns} ${addr_port} ${srv_proto})"
> -	printf "%s\t" "${result_msg}"
> +	mptcp_lib_print_test_counter TEST_COUNT "%s\t" "${result_msg}"
>  
>  	if $capture; then
>  		local capuser
> @@ -663,7 +666,8 @@ run_test_transparent()
>  	# following function has been exported (T). Not great but better than
>  	# checking for a specific kernel version.
>  	if ! mptcp_lib_kallsyms_has "T __ip_sock_set_tos$"; then
> -		echo "INFO: ${msg} not supported by the kernel: SKIP"
> +		mptcp_lib_print_test_counter TEST_COUNT "%s\n" \
> +			"INFO: ${msg} not supported by the kernel: SKIP"

Same here, the test name and counter should be handled before the 'if',
not just for the SKIP if possible.

>  		mptcp_lib_result_skip "${TEST_GROUP}"
>  		return
>  	fi
> @@ -680,7 +684,8 @@ table inet mangle {
>  }
>  EOF
>  	then
> -		echo "SKIP: $msg, could not load nft ruleset"
> +		mptcp_lib_print_test_counter TEST_COUNT "%s\n" \
> +			"SKIP: $msg, could not load nft ruleset"

Same here, the test name and counter should be handled before the 'if',
not just for the SKIP if possible.

>  		mptcp_lib_fail_if_expected_feature "nft rules"
>  		mptcp_lib_result_skip "${TEST_GROUP}"
>  		return
> @@ -696,7 +701,8 @@ EOF
>  
>  	if ! ip -net "$listener_ns" $r6flag rule add fwmark 1 lookup 100; then
>  		ip netns exec "$listener_ns" nft flush ruleset
> -		echo "SKIP: $msg, ip $r6flag rule failed"
> +		mptcp_lib_print_test_counter TEST_COUNT "%s\n" \
> +			"SKIP: $msg, ip $r6flag rule failed"

Same here, the test name and counter should be handled before the 'if',
not just for the SKIP if possible.

>  		mptcp_lib_fail_if_expected_feature "ip rule"
>  		mptcp_lib_result_skip "${TEST_GROUP}"
>  		return
> @@ -705,7 +711,8 @@ EOF
>  	if ! ip -net "$listener_ns" route add local $local_addr/0 dev lo table 100; then
>  		ip netns exec "$listener_ns" nft flush ruleset
>  		ip -net "$listener_ns" $r6flag rule del fwmark 1 lookup 100
> -		echo "SKIP: $msg, ip route add local $local_addr failed"
> +		mptcp_lib_print_test_counter TEST_COUNT "%s\n" \
> +			"SKIP: $msg, ip route add local $local_addr failed"

Same here, the test name and counter should be handled before the 'if',
not just for the SKIP if possible.

>  		mptcp_lib_fail_if_expected_feature "ip route"
>  		mptcp_lib_result_skip "${TEST_GROUP}"
>  		return
> @@ -861,7 +868,7 @@ mptcp_lib_result_code "${ret}" "ping tests"
>  
>  stop_if_error "Could not even run ping tests"
>  
> -echo -e "ping tests"
> +mptcp_lib_print_test_counter TEST_COUNT "%s" "ping tests"
>  mptcp_lib_print_ok "\t\t\t\t\t\t\t\t   [ OK ]"
>  
>  [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay ${tc_delay}ms
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index 7e309493eda2..df495658f043 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -411,3 +411,11 @@ mptcp_lib_events() {
>  	ip netns exec "${ns}" ./pm_nl_ctl events >> "${evts}" 2>&1 &
>  	pid=$!
>  }
> +
> +mptcp_lib_print_test_counter() {

Maybe more "mptcp_lib_print_test_title" or "_name": it doesn't just
print the counter, mostly the "title" (including the counter, part of
the title)

> +	declare -n counter="${1}"
> +	local fmt="${2}"
> +	local msg="${3}"
> +
> +	printf "%02u ${fmt}" "$((++counter))" "${msg}"

Maybe having this:

  : "${MPTCP_LIB_PRINT_TEST_FORMAT:="%02u %-50s"}"
  MPTCP_LIB_TEST_COUNTER=0

  (...)

  # $1: test name
  mptcp_lib_print_test_counter() {
      printf "${MPTCP_LIB_PRINT_TEST_FORMAT}" \
             "$((++MPTCP_LIB_TEST_COUNTER))" "${1}"
  }

Would simplify stuff?

So tests can specify the format by setting MPTCP_LIB_PRINT_TEST_FORMAT,
e.g. to support more than 99 entries. And you don't need to define
TEST_COUNT and disable SC2034.

Would that work?

You could even use it in mptcp_join.sh: print_title() would call this
new helper.

> +}
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> index cfa0cfb918f4..a2a5049f22bb 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> @@ -17,6 +17,8 @@ timeout_poll=30
>  timeout_test=$((timeout_poll * 2 + 1))
>  iptables="iptables"
>  ip6tables="ip6tables"
> +#shellcheck disable=SC2034
> +test_cnt=0
>  
>  ns1=""
>  ns2=""
> @@ -161,7 +163,7 @@ do_transfer()
>  	wait $spid
>  	local rets=$?
>  
> -	printf "%-50s" "transfer ${ip}"
> +	mptcp_lib_print_test_counter test_cnt "%-50s" "transfer ${ip}"

Same my comments on previous patches: if here a helper is used to print
the test name, you would only need to change this helper, not doing the
same modification multiple times at the same places.

>  	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
>  		echo " client exit code $retc, server $rets" 1>&2
>  		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2

(...)

> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
> index 79cb377ee0bd..eb2eaa48035f 100755
> --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
> +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
> @@ -14,7 +14,7 @@ ns3=""
>  capture=false
>  timeout_poll=30
>  timeout_test=$((timeout_poll * 2 + 1))
> -test_cnt=1
> +test_cnt=0

Why ShellCheck is not complaining the variable is not used here?

>  ret=0
>  bail=0
>  slack=50

(...)

While at it, can you make sure all the results are aligned for
simult_flows by increasing the '%-XXs'?

> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> index 33bbb0d5807f..27f308601005 100755
> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> @@ -53,6 +53,7 @@ server_addr_id=${RANDOM:0:2}
>  ns1=""
>  ns2=""
>  ret=0

Why ShellCheck is not complaining the variable is not used here?

> +test_cnt=0
>  test_name=""
>  
>  _printf() {

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
