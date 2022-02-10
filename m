Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C922F24
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 00:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644453390; x=1675989390;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=c1sxDZwfcU7+acJoWAplNyqxr9qWi6kwIn8eCiAdfRQ=;
  b=U7WOqkyNBxsxDZOYWos1dsZR4z2iChlW1IdFWlW75eJTjorRCauAoNn/
   7Gk5YiN8q3rjHvdG0PzIiRIeXoVJjMYGBbajGP5/f6pxWMtX8LtPgi6y2
   fNm6DaZ2eUdPCc16G5rgGdqshELnxX5nS06FsULToOFnIClPrGQIcUexK
   vxwK84u19WMzE3V4tzT50OFwpZywFzHlIelubER95bjDkcXOnDSPvQoQd
   dSL3GWEvFB474jvqr8Jf/fNa42VwoDvliXPowvoBKGWhY1ebilPbL15Yt
   4LBXNWHhL7771E12SSv9V0c8GprUVcneRaj8N3pIMFFv7vgTS1CirHzsB
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="248208788"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="248208788"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 16:36:23 -0800
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="500191785"
Received: from halucas-mobl3.amr.corp.intel.com ([10.212.241.159])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 16:36:23 -0800
Date: Wed, 9 Feb 2022 16:36:22 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next 3/9] selftests: mptcp: join: option to execute
 specific tests
In-Reply-To: <20220209212520.2989291-4-matthieu.baerts@tessares.net>
Message-ID: <199e2a26-da9-e79f-53c-50498fda97c@linux.intel.com>
References: <20220209212520.2989291-1-matthieu.baerts@tessares.net> <20220209212520.2989291-4-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 9 Feb 2022, Matthieu Baerts wrote:

> Often, it is needed to run one specific test.
>
> There are options to run subgroups of tests but when only one fails, no
> need to run all the subgroup. So far, the solution was to edit the
> script to comment the tests that are not needed but that's not ideal.
>
> Now, it is possible to run one specific test by giving the ID of the
> tests that are going to be validated, e.g.
>
>  ./mptcp_join.sh 36 37
>
> This is cleaner and saves time.
>
> Technically, the reset* functions now return 0 if the test can be
> executed. This naturally creates sections per test in the code which is
> also helpful to understand what a test is exactly doing.
>

My sense is that this is primarily for development purposes since the test 
numbers may shift as tests are added or modified. Is it worth the churn 
when we have the subgroup functionality and could comment out chunks of 
the test script that are not useful for running specific tests in a loop?

I'm not set against this change, but hoping to discuss it some more to 
both understand the benefits (I assume for running CI in a loop?) and to 
see if anyone has bright ideas for avoiding the whitespace churn.

("Include a bash fork in our selftest code that implements 'goto'" seems 
like overkill :) )


-Mat


> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> .../testing/selftests/net/mptcp/mptcp_join.sh | 1676 +++++++++--------
> 1 file changed, 900 insertions(+), 776 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 327f4ace5153..2dc81646e326 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -20,6 +20,7 @@ check_invert=0
> do_all_tests=1
>
> TEST_COUNT=0
> +ONLY_TESTS=()
> nr_blank=40
>
> # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
> @@ -110,15 +111,40 @@ cleanup()
> 	cleanup_partial
> }
>
> +skip_test()
> +{
> +	local i
> +
> +	if [ "${#ONLY_TESTS[@]}" -eq 0 ]; then
> +		return 1
> +	fi
> +
> +	for i in "${ONLY_TESTS[@]}"; do
> +		if [ "${TEST_COUNT}" -eq "${i}" ]; then
> +			return 1
> +		fi
> +	done
> +
> +	return 0
> +}
> +
> reset()
> {
> +	TEST_COUNT=$((TEST_COUNT+1))
> +
> +	if skip_test; then
> +		return 1
> +	fi
> +
> 	cleanup_partial
> 	init
> +
> +	return 0
> }
>
> reset_with_cookies()
> {
> -	reset
> +	reset || return 1
>
> 	for netns in "$ns1" "$ns2";do
> 		ip netns exec $netns sysctl -q net.ipv4.tcp_syncookies=2
> @@ -135,7 +161,7 @@ reset_with_add_addr_timeout()
> 		tables="ip6tables"
> 	fi
>
> -	reset
> +	reset || return 1
>
> 	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
> 	ip netns exec $ns2 $tables -A OUTPUT -p tcp \
> @@ -150,7 +176,7 @@ reset_with_checksum()
> 	local ns1_enable=$1
> 	local ns2_enable=$2
>
> -	reset
> +	reset || return 1
>
> 	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=$ns1_enable
> 	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=$ns2_enable
> @@ -161,7 +187,7 @@ reset_with_allow_join_id0()
> 	local ns1_enable=$1
> 	local ns2_enable=$2
>
> -	reset
> +	reset || return 1
>
> 	ip netns exec $ns1 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns1_enable
> 	ip netns exec $ns2 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns2_enable
> @@ -403,8 +429,7 @@ do_transfer()
> 	speed="$9"
> 	sflags="${10}"
>
> -	port=$((10000+$TEST_COUNT))
> -	TEST_COUNT=$((TEST_COUNT+1))
> +	port=$((10000+$TEST_COUNT-1))
>
> 	:> "$cout"
> 	:> "$sout"
> @@ -1141,888 +1166,967 @@ wait_attempt_fail()
>
> subflows_tests()
> {
> -	reset
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "no JOIN" "0" "0" "0"
> +	if reset; then
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "no JOIN" "0" "0" "0"
> +	fi
>
> 	# subflow limited by client
> -	reset
> -	pm_nl_set_limits $ns1 0 0
> -	pm_nl_set_limits $ns2 0 0
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "single subflow, limited by client" 0 0 0
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 0
> +		pm_nl_set_limits $ns2 0 0
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "single subflow, limited by client" 0 0 0
> +	fi
>
> 	# subflow limited by server
> -	reset
> -	pm_nl_set_limits $ns1 0 0
> -	pm_nl_set_limits $ns2 0 1
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "single subflow, limited by server" 1 1 0
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 0
> +		pm_nl_set_limits $ns2 0 1
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "single subflow, limited by server" 1 1 0
> +	fi
>
> 	# subflow
> -	reset
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 0 1
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "single subflow" 1 1 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 0 1
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "single subflow" 1 1 1
> +	fi
>
> 	# multiple subflows
> -	reset
> -	pm_nl_set_limits $ns1 0 2
> -	pm_nl_set_limits $ns2 0 2
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "multiple subflows" 2 2 2
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_set_limits $ns2 0 2
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "multiple subflows" 2 2 2
> +	fi
>
> 	# multiple subflows limited by server
> -	reset
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 0 2
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "multiple subflows, limited by server" 2 2 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 0 2
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "multiple subflows, limited by server" 2 2 1
> +	fi
>
> 	# single subflow, dev
> -	reset
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 0 1
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow dev ns2eth3
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "single subflow, dev" 1 1 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 0 1
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow dev ns2eth3
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "single subflow, dev" 1 1 1
> +	fi
> }
>
> subflows_error_tests()
> {
> 	# If a single subflow is configured, and matches the MPC src
> 	# address, no additional subflow should be created
> -	reset
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 0 1
> -	pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> -	chk_join_nr "no MPC reuse with single endpoint" 0 0 0
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 0 1
> +		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> +		chk_join_nr "no MPC reuse with single endpoint" 0 0 0
> +	fi
>
> 	# multiple subflows, with subflow creation error
> -	reset
> -	pm_nl_set_limits $ns1 0 2
> -	pm_nl_set_limits $ns2 0 2
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
> -	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
> -	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> -	chk_join_nr "multi subflows, with failing subflow" 1 1 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_set_limits $ns2 0 2
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
> +		ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> +		chk_join_nr "multi subflows, with failing subflow" 1 1 1
> +	fi
>
> 	# multiple subflows, with subflow timeout on MPJ
> -	reset
> -	pm_nl_set_limits $ns1 0 2
> -	pm_nl_set_limits $ns2 0 2
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
> -	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j DROP
> -	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> -	chk_join_nr "multi subflows, with subflow timeout" 1 1 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_set_limits $ns2 0 2
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
> +		ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j DROP
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> +		chk_join_nr "multi subflows, with subflow timeout" 1 1 1
> +	fi
>
> 	# multiple subflows, check that the endpoint corresponding to
> 	# closed subflow (due to reset) is not reused if additional
> 	# subflows are added later
> -	reset
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 0 1
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
> -	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
> -
> -	# updates in the child shell do not have any effect here, we
> -	# need to bump the test counter for the above case
> -	TEST_COUNT=$((TEST_COUNT+1))
> -
> -	# mpj subflow will be in TW after the reset
> -	wait_attempt_fail $ns2
> -	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
> -	wait
> -
> -	# additional subflow could be created only if the PM select
> -	# the later endpoint, skipping the already used one
> -	chk_join_nr "multi subflows, fair usage on close" 1 1 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 0 1
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
> +
> +		# mpj subflow will be in TW after the reset
> +		wait_attempt_fail $ns2
> +		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
> +		wait
> +
> +		# additional subflow could be created only if the PM select
> +		# the later endpoint, skipping the already used one
> +		chk_join_nr "multi subflows, fair usage on close" 1 1 1
> +	fi
> }
>
> signal_address_tests()
> {
> 	# add_address, unused
> -	reset
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "unused signal address" 0 0 0
> -	chk_add_nr 1 1
> +	if reset; then
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "unused signal address" 0 0 0
> +		chk_add_nr 1 1
> +	fi
>
> 	# accept and use add_addr
> -	reset
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 1 1
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "signal address" 1 1 1
> -	chk_add_nr 1 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 1 1
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "signal address" 1 1 1
> +		chk_add_nr 1 1
> +	fi
>
> 	# accept and use add_addr with an additional subflow
> 	# note: signal address in server ns and local addresses in client ns must
> 	# belong to different subnets or one of the listed local address could be
> 	# used for 'add_addr' subflow
> -	reset
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> -	pm_nl_set_limits $ns1 0 2
> -	pm_nl_set_limits $ns2 1 2
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "subflow and signal" 2 2 2
> -	chk_add_nr 1 1
> +	if reset; then
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_set_limits $ns2 1 2
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "subflow and signal" 2 2 2
> +		chk_add_nr 1 1
> +	fi
>
> 	# accept and use add_addr with additional subflows
> -	reset
> -	pm_nl_set_limits $ns1 0 3
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> -	pm_nl_set_limits $ns2 1 3
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "multiple subflows and signal" 3 3 3
> -	chk_add_nr 1 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 3
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		pm_nl_set_limits $ns2 1 3
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "multiple subflows and signal" 3 3 3
> +		chk_add_nr 1 1
> +	fi
>
> 	# signal addresses
> -	reset
> -	pm_nl_set_limits $ns1 3 3
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> -	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> -	pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
> -	pm_nl_set_limits $ns2 3 3
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "signal addresses" 3 3 3
> -	chk_add_nr 3 3
> +	if reset; then
> +		pm_nl_set_limits $ns1 3 3
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> +		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
> +		pm_nl_set_limits $ns2 3 3
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "signal addresses" 3 3 3
> +		chk_add_nr 3 3
> +	fi
>
> 	# signal invalid addresses
> -	reset
> -	pm_nl_set_limits $ns1 3 3
> -	pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
> -	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> -	pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
> -	pm_nl_set_limits $ns2 3 3
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "signal invalid addresses" 1 1 1
> -	chk_add_nr 3 3
> +	if reset; then
> +		pm_nl_set_limits $ns1 3 3
> +		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
> +		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> +		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
> +		pm_nl_set_limits $ns2 3 3
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "signal invalid addresses" 1 1 1
> +		chk_add_nr 3 3
> +	fi
>
> 	# signal addresses race test
> -	reset
> -
> -	pm_nl_set_limits $ns1 4 4
> -	pm_nl_set_limits $ns2 4 4
> -	pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> -	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> -	pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
> -	pm_nl_add_endpoint $ns2 10.0.1.2 flags signal
> -	pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags signal
> -	pm_nl_add_endpoint $ns2 10.0.4.2 flags signal
> -
> -	# the peer could possibly miss some addr notification, allow retransmission
> -	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
> -	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> -	chk_join_nr "signal addresses race test" 3 3 3
> -
> -	# the server will not signal the address terminating
> -	# the MPC subflow
> -	chk_add_nr 3 3
> +	if reset; then
> +		pm_nl_set_limits $ns1 4 4
> +		pm_nl_set_limits $ns2 4 4
> +		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> +		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
> +		pm_nl_add_endpoint $ns2 10.0.1.2 flags signal
> +		pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags signal
> +		pm_nl_add_endpoint $ns2 10.0.4.2 flags signal
> +
> +		# the peer could possibly miss some addr notification, allow retransmission
> +		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> +		chk_join_nr "signal addresses race test" 3 3 3
> +
> +		# the server will not signal the address terminating
> +		# the MPC subflow
> +		chk_add_nr 3 3
> +	fi
> }
>
> link_failure_tests()
> {
> 	# accept and use add_addr with additional subflows and link loss
> -	reset
> -
> -	# without any b/w limit each veth could spool the packets and get
> -	# them acked at xmit time, so that the corresponding subflow will
> -	# have almost always no outstanding pkts, the scheduler will pick
> -	# always the first subflow and we will have hard time testing
> -	# active backup and link switch-over.
> -	# Let's set some arbitrary (low) virtual link limits.
> -	init_shapers
> -	pm_nl_set_limits $ns1 0 3
> -	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
> -	pm_nl_set_limits $ns2 1 3
> -	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
> -	pm_nl_add_endpoint $ns2 10.0.4.2 dev ns2eth4 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1 1
> -	chk_join_nr "multiple flows, signal, link failure" 3 3 3
> -	chk_add_nr 1 1
> -	chk_stale_nr $ns2 1 5 1
> +	if reset; then
> +		# without any b/w limit each veth could spool the packets and get
> +		# them acked at xmit time, so that the corresponding subflow will
> +		# have almost always no outstanding pkts, the scheduler will pick
> +		# always the first subflow and we will have hard time testing
> +		# active backup and link switch-over.
> +		# Let's set some arbitrary (low) virtual link limits.
> +		init_shapers
> +		pm_nl_set_limits $ns1 0 3
> +		pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
> +		pm_nl_set_limits $ns2 1 3
> +		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
> +		pm_nl_add_endpoint $ns2 10.0.4.2 dev ns2eth4 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1 1
> +		chk_join_nr "multiple flows, signal, link failure" 3 3 3
> +		chk_add_nr 1 1
> +		chk_stale_nr $ns2 1 5 1
> +	fi
>
> 	# accept and use add_addr with additional subflows and link loss
> 	# for bidirectional transfer
> -	reset
> -	init_shapers
> -	pm_nl_set_limits $ns1 0 3
> -	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
> -	pm_nl_set_limits $ns2 1 3
> -	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
> -	pm_nl_add_endpoint $ns2 10.0.4.2 dev ns2eth4 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1 2
> -	chk_join_nr "multi flows, signal, bidi, link fail" 3 3 3
> -	chk_add_nr 1 1
> -	chk_stale_nr $ns2 1 -1 1
> +	if reset; then
> +		init_shapers
> +		pm_nl_set_limits $ns1 0 3
> +		pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
> +		pm_nl_set_limits $ns2 1 3
> +		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
> +		pm_nl_add_endpoint $ns2 10.0.4.2 dev ns2eth4 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1 2
> +		chk_join_nr "multi flows, signal, bidi, link fail" 3 3 3
> +		chk_add_nr 1 1
> +		chk_stale_nr $ns2 1 -1 1
> +	fi
>
> 	# 2 subflows plus 1 backup subflow with a lossy link, backup
> 	# will never be used
> -	reset
> -	init_shapers
> -	pm_nl_set_limits $ns1 0 2
> -	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
> -	pm_nl_set_limits $ns2 1 2
> -	export FAILING_LINKS="1"
> -	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
> -	run_tests $ns1 $ns2 10.0.1.1 1
> -	chk_join_nr "backup subflow unused, link failure" 2 2 2
> -	chk_add_nr 1 1
> -	chk_link_usage $ns2 ns2eth3 $cinsent 0
> +	if reset; then
> +		init_shapers
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
> +		pm_nl_set_limits $ns2 1 2
> +		export FAILING_LINKS="1"
> +		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
> +		run_tests $ns1 $ns2 10.0.1.1 1
> +		chk_join_nr "backup subflow unused, link failure" 2 2 2
> +		chk_add_nr 1 1
> +		chk_link_usage $ns2 ns2eth3 $cinsent 0
> +	fi
>
> 	# 2 lossy links after half transfer, backup will get half of
> 	# the traffic
> -	reset
> -	init_shapers
> -	pm_nl_set_limits $ns1 0 2
> -	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
> -	pm_nl_set_limits $ns2 1 2
> -	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
> -	export FAILING_LINKS="1 2"
> -	run_tests $ns1 $ns2 10.0.1.1 1
> -	chk_join_nr "backup flow used, multi links fail" 2 2 2
> -	chk_add_nr 1 1
> -	chk_stale_nr $ns2 2 4 2
> -	chk_link_usage $ns2 ns2eth3 $cinsent 50
> +	if reset; then
> +		init_shapers
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
> +		pm_nl_set_limits $ns2 1 2
> +		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
> +		export FAILING_LINKS="1 2"
> +		run_tests $ns1 $ns2 10.0.1.1 1
> +		chk_join_nr "backup flow used, multi links fail" 2 2 2
> +		chk_add_nr 1 1
> +		chk_stale_nr $ns2 2 4 2
> +		chk_link_usage $ns2 ns2eth3 $cinsent 50
> +	fi
>
> 	# use a backup subflow with the first subflow on a lossy link
> 	# for bidirectional transfer
> -	reset
> -	init_shapers
> -	pm_nl_set_limits $ns1 0 2
> -	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
> -	pm_nl_set_limits $ns2 1 3
> -	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
> -	run_tests $ns1 $ns2 10.0.1.1 2
> -	chk_join_nr "backup flow used, bidi, link failure" 2 2 2
> -	chk_add_nr 1 1
> -	chk_stale_nr $ns2 1 -1 2
> -	chk_link_usage $ns2 ns2eth3 $cinsent 50
> +	if reset; then
> +		init_shapers
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
> +		pm_nl_set_limits $ns2 1 3
> +		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
> +		run_tests $ns1 $ns2 10.0.1.1 2
> +		chk_join_nr "backup flow used, bidi, link failure" 2 2 2
> +		chk_add_nr 1 1
> +		chk_stale_nr $ns2 1 -1 2
> +		chk_link_usage $ns2 ns2eth3 $cinsent 50
> +	fi
> }
>
> add_addr_timeout_tests()
> {
> 	# add_addr timeout
> -	reset_with_add_addr_timeout
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 1 1
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> -	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> -	chk_join_nr "signal address, ADD_ADDR timeout" 1 1 1
> -	chk_add_nr 4 0
> +	if reset_with_add_addr_timeout; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 1 1
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> +		chk_join_nr "signal address, ADD_ADDR timeout" 1 1 1
> +		chk_add_nr 4 0
> +	fi
>
> 	# add_addr timeout IPv6
> -	reset_with_add_addr_timeout 6
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 1 1
> -	pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
> -	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
> -	chk_join_nr "signal address, ADD_ADDR6 timeout" 1 1 1
> -	chk_add_nr 4 0
> +	if reset_with_add_addr_timeout 6; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 1 1
> +		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
> +		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
> +		chk_join_nr "signal address, ADD_ADDR6 timeout" 1 1 1
> +		chk_add_nr 4 0
> +	fi
>
> 	# signal addresses timeout
> -	reset_with_add_addr_timeout
> -	pm_nl_set_limits $ns1 2 2
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> -	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> -	pm_nl_set_limits $ns2 2 2
> -	run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
> -	chk_join_nr "signal addresses, ADD_ADDR timeout" 2 2 2
> -	chk_add_nr 8 0
> +	if reset_with_add_addr_timeout; then
> +		pm_nl_set_limits $ns1 2 2
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> +		pm_nl_set_limits $ns2 2 2
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
> +		chk_join_nr "signal addresses, ADD_ADDR timeout" 2 2 2
> +		chk_add_nr 8 0
> +	fi
>
> 	# signal invalid addresses timeout
> -	reset_with_add_addr_timeout
> -	pm_nl_set_limits $ns1 2 2
> -	pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
> -	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> -	pm_nl_set_limits $ns2 2 2
> -	run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
> -	chk_join_nr "invalid address, ADD_ADDR timeout" 1 1 1
> -	chk_add_nr 8 0
> +	if reset_with_add_addr_timeout; then
> +		pm_nl_set_limits $ns1 2 2
> +		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
> +		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> +		pm_nl_set_limits $ns2 2 2
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
> +		chk_join_nr "invalid address, ADD_ADDR timeout" 1 1 1
> +		chk_add_nr 8 0
> +	fi
> }
>
> remove_tests()
> {
> 	# single subflow, remove
> -	reset
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 0 1
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
> -	chk_join_nr "remove single subflow" 1 1 1
> -	chk_rm_nr 1 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 0 1
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
> +		chk_join_nr "remove single subflow" 1 1 1
> +		chk_rm_nr 1 1
> +	fi
>
> 	# multiple subflows, remove
> -	reset
> -	pm_nl_set_limits $ns1 0 2
> -	pm_nl_set_limits $ns2 0 2
> -	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1 0 0 -2 slow
> -	chk_join_nr "remove multiple subflows" 2 2 2
> -	chk_rm_nr 2 2
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_set_limits $ns2 0 2
> +		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 -2 slow
> +		chk_join_nr "remove multiple subflows" 2 2 2
> +		chk_rm_nr 2 2
> +	fi
>
> 	# single address, remove
> -	reset
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> -	pm_nl_set_limits $ns2 1 1
> -	run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
> -	chk_join_nr "remove single address" 1 1 1
> -	chk_add_nr 1 1
> -	chk_rm_nr 1 1 invert
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		pm_nl_set_limits $ns2 1 1
> +		run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
> +		chk_join_nr "remove single address" 1 1 1
> +		chk_add_nr 1 1
> +		chk_rm_nr 1 1 invert
> +	fi
>
> 	# subflow and signal, remove
> -	reset
> -	pm_nl_set_limits $ns1 0 2
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> -	pm_nl_set_limits $ns2 1 2
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
> -	chk_join_nr "remove subflow and signal" 2 2 2
> -	chk_add_nr 1 1
> -	chk_rm_nr 1 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		pm_nl_set_limits $ns2 1 2
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
> +		chk_join_nr "remove subflow and signal" 2 2 2
> +		chk_add_nr 1 1
> +		chk_rm_nr 1 1
> +	fi
>
> 	# subflows and signal, remove
> -	reset
> -	pm_nl_set_limits $ns1 0 3
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> -	pm_nl_set_limits $ns2 1 3
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 slow
> -	chk_join_nr "remove subflows and signal" 3 3 3
> -	chk_add_nr 1 1
> -	chk_rm_nr 2 2
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 3
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		pm_nl_set_limits $ns2 1 3
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 slow
> +		chk_join_nr "remove subflows and signal" 3 3 3
> +		chk_add_nr 1 1
> +		chk_rm_nr 2 2
> +	fi
>
> 	# addresses remove
> -	reset
> -	pm_nl_set_limits $ns1 3 3
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal id 250
> -	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> -	pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
> -	pm_nl_set_limits $ns2 3 3
> -	run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
> -	chk_join_nr "remove addresses" 3 3 3
> -	chk_add_nr 3 3
> -	chk_rm_nr 3 3 invert
> +	if reset; then
> +		pm_nl_set_limits $ns1 3 3
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal id 250
> +		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> +		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
> +		pm_nl_set_limits $ns2 3 3
> +		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
> +		chk_join_nr "remove addresses" 3 3 3
> +		chk_add_nr 3 3
> +		chk_rm_nr 3 3 invert
> +	fi
>
> 	# invalid addresses remove
> -	reset
> -	pm_nl_set_limits $ns1 3 3
> -	pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
> -	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> -	pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
> -	pm_nl_set_limits $ns2 3 3
> -	run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
> -	chk_join_nr "remove invalid addresses" 1 1 1
> -	chk_add_nr 3 3
> -	chk_rm_nr 3 1 invert
> +	if reset; then
> +		pm_nl_set_limits $ns1 3 3
> +		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
> +		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> +		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
> +		pm_nl_set_limits $ns2 3 3
> +		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
> +		chk_join_nr "remove invalid addresses" 1 1 1
> +		chk_add_nr 3 3
> +		chk_rm_nr 3 1 invert
> +	fi
>
> 	# subflows and signal, flush
> -	reset
> -	pm_nl_set_limits $ns1 0 3
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> -	pm_nl_set_limits $ns2 1 3
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
> -	chk_join_nr "flush subflows and signal" 3 3 3
> -	chk_add_nr 1 1
> -	chk_rm_nr 2 2
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 3
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		pm_nl_set_limits $ns2 1 3
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
> +		chk_join_nr "flush subflows and signal" 3 3 3
> +		chk_add_nr 1 1
> +		chk_rm_nr 2 2
> +	fi
>
> 	# subflows flush
> -	reset
> -	pm_nl_set_limits $ns1 3 3
> -	pm_nl_set_limits $ns2 3 3
> -	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow id 150
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
> -	chk_join_nr "flush subflows" 3 3 3
> -	chk_rm_nr 3 3
> +	if reset; then
> +		pm_nl_set_limits $ns1 3 3
> +		pm_nl_set_limits $ns2 3 3
> +		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow id 150
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
> +		chk_join_nr "flush subflows" 3 3 3
> +		chk_rm_nr 3 3
> +	fi
>
> 	# addresses flush
> -	reset
> -	pm_nl_set_limits $ns1 3 3
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal id 250
> -	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> -	pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
> -	pm_nl_set_limits $ns2 3 3
> -	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
> -	chk_join_nr "flush addresses" 3 3 3
> -	chk_add_nr 3 3
> -	chk_rm_nr 3 3 invert
> +	if reset; then
> +		pm_nl_set_limits $ns1 3 3
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal id 250
> +		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> +		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
> +		pm_nl_set_limits $ns2 3 3
> +		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
> +		chk_join_nr "flush addresses" 3 3 3
> +		chk_add_nr 3 3
> +		chk_rm_nr 3 3 invert
> +	fi
>
> 	# invalid addresses flush
> -	reset
> -	pm_nl_set_limits $ns1 3 3
> -	pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
> -	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> -	pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
> -	pm_nl_set_limits $ns2 3 3
> -	run_tests $ns1 $ns2 10.0.1.1 0 -8 0 slow
> -	chk_join_nr "flush invalid addresses" 1 1 1
> -	chk_add_nr 3 3
> -	chk_rm_nr 3 1 invert
> +	if reset; then
> +		pm_nl_set_limits $ns1 3 3
> +		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
> +		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> +		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
> +		pm_nl_set_limits $ns2 3 3
> +		run_tests $ns1 $ns2 10.0.1.1 0 -8 0 slow
> +		chk_join_nr "flush invalid addresses" 1 1 1
> +		chk_add_nr 3 3
> +		chk_rm_nr 3 1 invert
> +	fi
>
> 	# remove id 0 subflow
> -	reset
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 0 1
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1 0 0 -9 slow
> -	chk_join_nr "remove id 0 subflow" 1 1 1
> -	chk_rm_nr 1 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 0 1
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 -9 slow
> +		chk_join_nr "remove id 0 subflow" 1 1 1
> +		chk_rm_nr 1 1
> +	fi
>
> 	# remove id 0 address
> -	reset
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> -	pm_nl_set_limits $ns2 1 1
> -	run_tests $ns1 $ns2 10.0.1.1 0 -9 0 slow
> -	chk_join_nr "remove id 0 address" 1 1 1
> -	chk_add_nr 1 1
> -	chk_rm_nr 1 1 invert
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		pm_nl_set_limits $ns2 1 1
> +		run_tests $ns1 $ns2 10.0.1.1 0 -9 0 slow
> +		chk_join_nr "remove id 0 address" 1 1 1
> +		chk_add_nr 1 1
> +		chk_rm_nr 1 1 invert
> +	fi
> }
>
> add_tests()
> {
> 	# add single subflow
> -	reset
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 0 1
> -	run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow
> -	chk_join_nr "add single subflow" 1 1 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 0 1
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow
> +		chk_join_nr "add single subflow" 1 1 1
> +	fi
>
> 	# add signal address
> -	reset
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 1 1
> -	run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
> -	chk_join_nr "add signal address" 1 1 1
> -	chk_add_nr 1 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 1 1
> +		run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
> +		chk_join_nr "add signal address" 1 1 1
> +		chk_add_nr 1 1
> +	fi
>
> 	# add multiple subflows
> -	reset
> -	pm_nl_set_limits $ns1 0 2
> -	pm_nl_set_limits $ns2 0 2
> -	run_tests $ns1 $ns2 10.0.1.1 0 0 2 slow
> -	chk_join_nr "add multiple subflows" 2 2 2
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_set_limits $ns2 0 2
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 2 slow
> +		chk_join_nr "add multiple subflows" 2 2 2
> +	fi
>
> 	# add multiple subflows IPv6
> -	reset
> -	pm_nl_set_limits $ns1 0 2
> -	pm_nl_set_limits $ns2 0 2
> -	run_tests $ns1 $ns2 dead:beef:1::1 0 0 2 slow
> -	chk_join_nr "add multiple subflows IPv6" 2 2 2
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_set_limits $ns2 0 2
> +		run_tests $ns1 $ns2 dead:beef:1::1 0 0 2 slow
> +		chk_join_nr "add multiple subflows IPv6" 2 2 2
> +	fi
>
> 	# add multiple addresses IPv6
> -	reset
> -	pm_nl_set_limits $ns1 0 2
> -	pm_nl_set_limits $ns2 2 2
> -	run_tests $ns1 $ns2 dead:beef:1::1 0 2 0 slow
> -	chk_join_nr "add multiple addresses IPv6" 2 2 2
> -	chk_add_nr 2 2
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_set_limits $ns2 2 2
> +		run_tests $ns1 $ns2 dead:beef:1::1 0 2 0 slow
> +		chk_join_nr "add multiple addresses IPv6" 2 2 2
> +		chk_add_nr 2 2
> +	fi
> }
>
> ipv6_tests()
> {
> 	# subflow IPv6
> -	reset
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 0 1
> -	pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
> -	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
> -	chk_join_nr "single subflow IPv6" 1 1 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 0 1
> +		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
> +		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
> +		chk_join_nr "single subflow IPv6" 1 1 1
> +	fi
>
> 	# add_address, unused IPv6
> -	reset
> -	pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
> -	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
> -	chk_join_nr "unused signal address IPv6" 0 0 0
> -	chk_add_nr 1 1
> +	if reset; then
> +		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
> +		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
> +		chk_join_nr "unused signal address IPv6" 0 0 0
> +		chk_add_nr 1 1
> +	fi
>
> 	# signal address IPv6
> -	reset
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
> -	pm_nl_set_limits $ns2 1 1
> -	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
> -	chk_join_nr "single address IPv6" 1 1 1
> -	chk_add_nr 1 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
> +		pm_nl_set_limits $ns2 1 1
> +		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
> +		chk_join_nr "single address IPv6" 1 1 1
> +		chk_add_nr 1 1
> +	fi
>
> 	# single address IPv6, remove
> -	reset
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
> -	pm_nl_set_limits $ns2 1 1
> -	run_tests $ns1 $ns2 dead:beef:1::1 0 -1 0 slow
> -	chk_join_nr "remove single address IPv6" 1 1 1
> -	chk_add_nr 1 1
> -	chk_rm_nr 1 1 invert
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
> +		pm_nl_set_limits $ns2 1 1
> +		run_tests $ns1 $ns2 dead:beef:1::1 0 -1 0 slow
> +		chk_join_nr "remove single address IPv6" 1 1 1
> +		chk_add_nr 1 1
> +		chk_rm_nr 1 1 invert
> +	fi
>
> 	# subflow and signal IPv6, remove
> -	reset
> -	pm_nl_set_limits $ns1 0 2
> -	pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
> -	pm_nl_set_limits $ns2 1 2
> -	pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
> -	run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
> -	chk_join_nr "remove subflow and signal IPv6" 2 2 2
> -	chk_add_nr 1 1
> -	chk_rm_nr 1 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
> +		pm_nl_set_limits $ns2 1 2
> +		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
> +		run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
> +		chk_join_nr "remove subflow and signal IPv6" 2 2 2
> +		chk_add_nr 1 1
> +		chk_rm_nr 1 1
> +	fi
> }
>
> v4mapped_tests()
> {
> 	# subflow IPv4-mapped to IPv4-mapped
> -	reset
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 0 1
> -	pm_nl_add_endpoint $ns2 "::ffff:10.0.3.2" flags subflow
> -	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
> -	chk_join_nr "single subflow IPv4-mapped" 1 1 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 0 1
> +		pm_nl_add_endpoint $ns2 "::ffff:10.0.3.2" flags subflow
> +		run_tests $ns1 $ns2 "::ffff:10.0.1.1"
> +		chk_join_nr "single subflow IPv4-mapped" 1 1 1
> +	fi
>
> 	# signal address IPv4-mapped with IPv4-mapped sk
> -	reset
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 1 1
> -	pm_nl_add_endpoint $ns1 "::ffff:10.0.2.1" flags signal
> -	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
> -	chk_join_nr "signal address IPv4-mapped" 1 1 1
> -	chk_add_nr 1 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 1 1
> +		pm_nl_add_endpoint $ns1 "::ffff:10.0.2.1" flags signal
> +		run_tests $ns1 $ns2 "::ffff:10.0.1.1"
> +		chk_join_nr "signal address IPv4-mapped" 1 1 1
> +		chk_add_nr 1 1
> +	fi
>
> 	# subflow v4-map-v6
> -	reset
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 0 1
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
> -	chk_join_nr "single subflow v4-map-v6" 1 1 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 0 1
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		run_tests $ns1 $ns2 "::ffff:10.0.1.1"
> +		chk_join_nr "single subflow v4-map-v6" 1 1 1
> +	fi
>
> 	# signal address v4-map-v6
> -	reset
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 1 1
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> -	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
> -	chk_join_nr "signal address v4-map-v6" 1 1 1
> -	chk_add_nr 1 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 1 1
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		run_tests $ns1 $ns2 "::ffff:10.0.1.1"
> +		chk_join_nr "signal address v4-map-v6" 1 1 1
> +		chk_add_nr 1 1
> +	fi
>
> 	# subflow v6-map-v4
> -	reset
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 0 1
> -	pm_nl_add_endpoint $ns2 "::ffff:10.0.3.2" flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "single subflow v6-map-v4" 1 1 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 0 1
> +		pm_nl_add_endpoint $ns2 "::ffff:10.0.3.2" flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "single subflow v6-map-v4" 1 1 1
> +	fi
>
> 	# signal address v6-map-v4
> -	reset
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 1 1
> -	pm_nl_add_endpoint $ns1 "::ffff:10.0.2.1" flags signal
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "signal address v6-map-v4" 1 1 1
> -	chk_add_nr 1 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 1 1
> +		pm_nl_add_endpoint $ns1 "::ffff:10.0.2.1" flags signal
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "signal address v6-map-v4" 1 1 1
> +		chk_add_nr 1 1
> +	fi
>
> 	# no subflow IPv6 to v4 address
> -	reset
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 0 1
> -	pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "no JOIN with diff families v4-v6" 0 0 0
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 0 1
> +		pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "no JOIN with diff families v4-v6" 0 0 0
> +	fi
>
> 	# no subflow IPv6 to v4 address even if v6 has a valid v4 at the end
> -	reset
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 0 1
> -	pm_nl_add_endpoint $ns2 dead:beef:2::10.0.3.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "no JOIN with diff families v4-v6-2" 0 0 0
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 0 1
> +		pm_nl_add_endpoint $ns2 dead:beef:2::10.0.3.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "no JOIN with diff families v4-v6-2" 0 0 0
> +	fi
>
> 	# no subflow IPv4 to v6 address, no need to slow down too then
> -	reset
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 0 1
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	run_tests $ns1 $ns2 dead:beef:1::1
> -	chk_join_nr "no JOIN with diff families v6-v4" 0 0 0
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 0 1
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		run_tests $ns1 $ns2 dead:beef:1::1
> +		chk_join_nr "no JOIN with diff families v6-v4" 0 0 0
> +	fi
> }
>
> backup_tests()
> {
> 	# single subflow, backup
> -	reset
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 0 1
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
> -	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
> -	chk_join_nr "single subflow, backup" 1 1 1
> -	chk_prio_nr 0 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 0 1
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
> +		chk_join_nr "single subflow, backup" 1 1 1
> +		chk_prio_nr 0 1
> +	fi
>
> 	# single address, backup
> -	reset
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> -	pm_nl_set_limits $ns2 1 1
> -	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
> -	chk_join_nr "single address, backup" 1 1 1
> -	chk_add_nr 1 1
> -	chk_prio_nr 1 0
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		pm_nl_set_limits $ns2 1 1
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
> +		chk_join_nr "single address, backup" 1 1 1
> +		chk_add_nr 1 1
> +		chk_prio_nr 1 0
> +	fi
>
> 	# single address with port, backup
> -	reset
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
> -	pm_nl_set_limits $ns2 1 1
> -	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
> -	chk_join_nr "single address with port, backup" 1 1 1
> -	chk_add_nr 1 1
> -	chk_prio_nr 1 0
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
> +		pm_nl_set_limits $ns2 1 1
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
> +		chk_join_nr "single address with port, backup" 1 1 1
> +		chk_add_nr 1 1
> +		chk_prio_nr 1 0
> +	fi
> }
>
> add_addr_ports_tests()
> {
> 	# signal address with port
> -	reset
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 1 1
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "signal address with port" 1 1 1
> -	chk_add_nr 1 1 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 1 1
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "signal address with port" 1 1 1
> +		chk_add_nr 1 1 1
> +	fi
>
> 	# subflow and signal with port
> -	reset
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
> -	pm_nl_set_limits $ns1 0 2
> -	pm_nl_set_limits $ns2 1 2
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "subflow and signal with port" 2 2 2
> -	chk_add_nr 1 1 1
> +	if reset; then
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_set_limits $ns2 1 2
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "subflow and signal with port" 2 2 2
> +		chk_add_nr 1 1 1
> +	fi
>
> 	# single address with port, remove
> -	reset
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
> -	pm_nl_set_limits $ns2 1 1
> -	run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
> -	chk_join_nr "remove single address with port" 1 1 1
> -	chk_add_nr 1 1 1
> -	chk_rm_nr 1 1 invert
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
> +		pm_nl_set_limits $ns2 1 1
> +		run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
> +		chk_join_nr "remove single address with port" 1 1 1
> +		chk_add_nr 1 1 1
> +		chk_rm_nr 1 1 invert
> +	fi
>
> 	# subflow and signal with port, remove
> -	reset
> -	pm_nl_set_limits $ns1 0 2
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
> -	pm_nl_set_limits $ns2 1 2
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
> -	chk_join_nr "remove subflow and signal with port" 2 2 2
> -	chk_add_nr 1 1 1
> -	chk_rm_nr 1 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
> +		pm_nl_set_limits $ns2 1 2
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
> +		chk_join_nr "remove subflow and signal with port" 2 2 2
> +		chk_add_nr 1 1 1
> +		chk_rm_nr 1 1
> +	fi
>
> 	# subflows and signal with port, flush
> -	reset
> -	pm_nl_set_limits $ns1 0 3
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
> -	pm_nl_set_limits $ns2 1 3
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1 0 -8 -2 slow
> -	chk_join_nr "flush subflows and signal with port" 3 3 3
> -	chk_add_nr 1 1
> -	chk_rm_nr 2 2
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 3
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
> +		pm_nl_set_limits $ns2 1 3
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1 0 -8 -2 slow
> +		chk_join_nr "flush subflows and signal with port" 3 3 3
> +		chk_add_nr 1 1
> +		chk_rm_nr 2 2
> +	fi
>
> 	# multiple addresses with port
> -	reset
> -	pm_nl_set_limits $ns1 2 2
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
> -	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal port 10100
> -	pm_nl_set_limits $ns2 2 2
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "multiple addresses with port" 2 2 2
> -	chk_add_nr 2 2 2
> +	if reset; then
> +		pm_nl_set_limits $ns1 2 2
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
> +		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal port 10100
> +		pm_nl_set_limits $ns2 2 2
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "multiple addresses with port" 2 2 2
> +		chk_add_nr 2 2 2
> +	fi
>
> 	# multiple addresses with ports
> -	reset
> -	pm_nl_set_limits $ns1 2 2
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
> -	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal port 10101
> -	pm_nl_set_limits $ns2 2 2
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "multiple addresses with ports" 2 2 2
> -	chk_add_nr 2 2 2
> +	if reset; then
> +		pm_nl_set_limits $ns1 2 2
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
> +		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal port 10101
> +		pm_nl_set_limits $ns2 2 2
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "multiple addresses with ports" 2 2 2
> +		chk_add_nr 2 2 2
> +	fi
> }
>
> syncookies_tests()
> {
> 	# single subflow, syncookies
> -	reset_with_cookies
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 0 1
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "single subflow with syn cookies" 1 1 1
> +	if reset_with_cookies; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 0 1
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "single subflow with syn cookies" 1 1 1
> +	fi
>
> 	# multiple subflows with syn cookies
> -	reset_with_cookies
> -	pm_nl_set_limits $ns1 0 2
> -	pm_nl_set_limits $ns2 0 2
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "multiple subflows with syn cookies" 2 2 2
> +	if reset_with_cookies; then
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_set_limits $ns2 0 2
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "multiple subflows with syn cookies" 2 2 2
> +	fi
>
> 	# multiple subflows limited by server
> -	reset_with_cookies
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 0 2
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "subflows limited by server w cookies" 2 1 1
> +	if reset_with_cookies; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 0 2
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "subflows limited by server w cookies" 2 1 1
> +	fi
>
> 	# test signal address with cookies
> -	reset_with_cookies
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 1 1
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "signal address with syn cookies" 1 1 1
> -	chk_add_nr 1 1
> +	if reset_with_cookies; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 1 1
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "signal address with syn cookies" 1 1 1
> +		chk_add_nr 1 1
> +	fi
>
> 	# test cookie with subflow and signal
> -	reset_with_cookies
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> -	pm_nl_set_limits $ns1 0 2
> -	pm_nl_set_limits $ns2 1 2
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "subflow and signal w cookies" 2 2 2
> -	chk_add_nr 1 1
> +	if reset_with_cookies; then
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_set_limits $ns2 1 2
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "subflow and signal w cookies" 2 2 2
> +		chk_add_nr 1 1
> +	fi
>
> 	# accept and use add_addr with additional subflows
> -	reset_with_cookies
> -	pm_nl_set_limits $ns1 0 3
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> -	pm_nl_set_limits $ns2 1 3
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "subflows and signal w. cookies" 3 3 3
> -	chk_add_nr 1 1
> +	if reset_with_cookies; then
> +		pm_nl_set_limits $ns1 0 3
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		pm_nl_set_limits $ns2 1 3
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "subflows and signal w. cookies" 3 3 3
> +		chk_add_nr 1 1
> +	fi
> }
>
> checksum_tests()
> {
> 	# checksum test 0 0
> -	reset_with_checksum 0 0
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 0 1
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_csum_nr "checksum test 0 0"
> +	if reset_with_checksum 0 0; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 0 1
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_csum_nr "checksum test 0 0"
> +	fi
>
> 	# checksum test 1 1
> -	reset_with_checksum 1 1
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 0 1
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_csum_nr "checksum test 1 1"
> +	if reset_with_checksum 1 1; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 0 1
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_csum_nr "checksum test 1 1"
> +	fi
>
> 	# checksum test 0 1
> -	reset_with_checksum 0 1
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 0 1
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_csum_nr "checksum test 0 1"
> +	if reset_with_checksum 0 1; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 0 1
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_csum_nr "checksum test 0 1"
> +	fi
>
> 	# checksum test 1 0
> -	reset_with_checksum 1 0
> -	pm_nl_set_limits $ns1 0 1
> -	pm_nl_set_limits $ns2 0 1
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_csum_nr "checksum test 1 0"
> +	if reset_with_checksum 1 0; then
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_set_limits $ns2 0 1
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_csum_nr "checksum test 1 0"
> +	fi
> }
>
> deny_join_id0_tests()
> {
> 	# subflow allow join id0 ns1
> -	reset_with_allow_join_id0 1 0
> -	pm_nl_set_limits $ns1 1 1
> -	pm_nl_set_limits $ns2 1 1
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "single subflow allow join id0 ns1" 1 1 1
> +	if reset_with_allow_join_id0 1 0; then
> +		pm_nl_set_limits $ns1 1 1
> +		pm_nl_set_limits $ns2 1 1
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "single subflow allow join id0 ns1" 1 1 1
> +	fi
>
> 	# subflow allow join id0 ns2
> -	reset_with_allow_join_id0 0 1
> -	pm_nl_set_limits $ns1 1 1
> -	pm_nl_set_limits $ns2 1 1
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "single subflow allow join id0 ns2" 0 0 0
> +	if reset_with_allow_join_id0 0 1; then
> +		pm_nl_set_limits $ns1 1 1
> +		pm_nl_set_limits $ns2 1 1
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "single subflow allow join id0 ns2" 0 0 0
> +	fi
>
> 	# signal address allow join id0 ns1
> 	# ADD_ADDRs are not affected by allow_join_id0 value.
> -	reset_with_allow_join_id0 1 0
> -	pm_nl_set_limits $ns1 1 1
> -	pm_nl_set_limits $ns2 1 1
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "signal address allow join id0 ns1" 1 1 1
> -	chk_add_nr 1 1
> +	if reset_with_allow_join_id0 1 0; then
> +		pm_nl_set_limits $ns1 1 1
> +		pm_nl_set_limits $ns2 1 1
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "signal address allow join id0 ns1" 1 1 1
> +		chk_add_nr 1 1
> +	fi
>
> 	# signal address allow join id0 ns2
> 	# ADD_ADDRs are not affected by allow_join_id0 value.
> -	reset_with_allow_join_id0 0 1
> -	pm_nl_set_limits $ns1 1 1
> -	pm_nl_set_limits $ns2 1 1
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "signal address allow join id0 ns2" 1 1 1
> -	chk_add_nr 1 1
> +	if reset_with_allow_join_id0 0 1; then
> +		pm_nl_set_limits $ns1 1 1
> +		pm_nl_set_limits $ns2 1 1
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "signal address allow join id0 ns2" 1 1 1
> +		chk_add_nr 1 1
> +	fi
>
> 	# subflow and address allow join id0 ns1
> -	reset_with_allow_join_id0 1 0
> -	pm_nl_set_limits $ns1 2 2
> -	pm_nl_set_limits $ns2 2 2
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "subflow and address allow join id0 1" 2 2 2
> +	if reset_with_allow_join_id0 1 0; then
> +		pm_nl_set_limits $ns1 2 2
> +		pm_nl_set_limits $ns2 2 2
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "subflow and address allow join id0 1" 2 2 2
> +	fi
>
> 	# subflow and address allow join id0 ns2
> -	reset_with_allow_join_id0 0 1
> -	pm_nl_set_limits $ns1 2 2
> -	pm_nl_set_limits $ns2 2 2
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "subflow and address allow join id0 2" 1 1 1
> +	if reset_with_allow_join_id0 0 1; then
> +		pm_nl_set_limits $ns1 2 2
> +		pm_nl_set_limits $ns2 2 2
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "subflow and address allow join id0 2" 1 1 1
> +	fi
> }
>
> fullmesh_tests()
> @@ -2030,148 +2134,162 @@ fullmesh_tests()
> 	# fullmesh 1
> 	# 2 fullmesh addrs in ns2, added before the connection,
> 	# 1 non-fullmesh addr in ns1, added during the connection.
> -	reset
> -	pm_nl_set_limits $ns1 0 4
> -	pm_nl_set_limits $ns2 1 4
> -	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,fullmesh
> -	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,fullmesh
> -	run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
> -	chk_join_nr "fullmesh test 2x1" 4 4 4
> -	chk_add_nr 1 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 0 4
> +		pm_nl_set_limits $ns2 1 4
> +		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,fullmesh
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,fullmesh
> +		run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
> +		chk_join_nr "fullmesh test 2x1" 4 4 4
> +		chk_add_nr 1 1
> +	fi
>
> 	# fullmesh 2
> 	# 1 non-fullmesh addr in ns1, added before the connection,
> 	# 1 fullmesh addr in ns2, added during the connection.
> -	reset
> -	pm_nl_set_limits $ns1 1 3
> -	pm_nl_set_limits $ns2 1 3
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> -	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow
> -	chk_join_nr "fullmesh test 1x1" 3 3 3
> -	chk_add_nr 1 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 1 3
> +		pm_nl_set_limits $ns2 1 3
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow
> +		chk_join_nr "fullmesh test 1x1" 3 3 3
> +		chk_add_nr 1 1
> +	fi
>
> 	# fullmesh 3
> 	# 1 non-fullmesh addr in ns1, added before the connection,
> 	# 2 fullmesh addrs in ns2, added during the connection.
> -	reset
> -	pm_nl_set_limits $ns1 2 5
> -	pm_nl_set_limits $ns2 1 5
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> -	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
> -	chk_join_nr "fullmesh test 1x2" 5 5 5
> -	chk_add_nr 1 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 2 5
> +		pm_nl_set_limits $ns2 1 5
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
> +		chk_join_nr "fullmesh test 1x2" 5 5 5
> +		chk_add_nr 1 1
> +	fi
>
> 	# fullmesh 4
> 	# 1 non-fullmesh addr in ns1, added before the connection,
> 	# 2 fullmesh addrs in ns2, added during the connection,
> 	# limit max_subflows to 4.
> -	reset
> -	pm_nl_set_limits $ns1 2 4
> -	pm_nl_set_limits $ns2 1 4
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> -	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
> -	chk_join_nr "fullmesh test 1x2, limited" 4 4 4
> -	chk_add_nr 1 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 2 4
> +		pm_nl_set_limits $ns2 1 4
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
> +		chk_join_nr "fullmesh test 1x2, limited" 4 4 4
> +		chk_add_nr 1 1
> +	fi
>
> 	# set fullmesh flag
> -	reset
> -	pm_nl_set_limits $ns1 4 4
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
> -	pm_nl_set_limits $ns2 4 4
> -	run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow fullmesh
> -	chk_join_nr "set fullmesh flag test" 2 2 2
> -	chk_rm_nr 0 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 4 4
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
> +		pm_nl_set_limits $ns2 4 4
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow fullmesh
> +		chk_join_nr "set fullmesh flag test" 2 2 2
> +		chk_rm_nr 0 1
> +	fi
>
> 	# set nofullmesh flag
> -	reset
> -	pm_nl_set_limits $ns1 4 4
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
> -	pm_nl_set_limits $ns2 4 4
> -	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow nofullmesh
> -	chk_join_nr "set nofullmesh flag test" 2 2 2
> -	chk_rm_nr 0 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 4 4
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
> +		pm_nl_set_limits $ns2 4 4
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow nofullmesh
> +		chk_join_nr "set nofullmesh flag test" 2 2 2
> +		chk_rm_nr 0 1
> +	fi
>
> 	# set backup,fullmesh flags
> -	reset
> -	pm_nl_set_limits $ns1 4 4
> -	pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
> -	pm_nl_set_limits $ns2 4 4
> -	run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow backup,fullmesh
> -	chk_join_nr "set backup,fullmesh flags test" 2 2 2
> -	chk_prio_nr 0 1
> -	chk_rm_nr 0 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 4 4
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
> +		pm_nl_set_limits $ns2 4 4
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow backup,fullmesh
> +		chk_join_nr "set backup,fullmesh flags test" 2 2 2
> +		chk_prio_nr 0 1
> +		chk_rm_nr 0 1
> +	fi
>
> 	# set nobackup,nofullmesh flags
> -	reset
> -	pm_nl_set_limits $ns1 4 4
> -	pm_nl_set_limits $ns2 4 4
> -	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh
> -	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup,nofullmesh
> -	chk_join_nr "set nobackup,nofullmesh flags test" 2 2 2
> -	chk_prio_nr 0 1
> -	chk_rm_nr 0 1
> +	if reset; then
> +		pm_nl_set_limits $ns1 4 4
> +		pm_nl_set_limits $ns2 4 4
> +		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup,nofullmesh
> +		chk_join_nr "set nobackup,nofullmesh flags test" 2 2 2
> +		chk_prio_nr 0 1
> +		chk_rm_nr 0 1
> +	fi
> }
>
> userspace_tests()
> {
> 	# userspace pm type prevents add_addr
> -	reset
> -	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=1
> -	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> -	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> -	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "userspace pm type prevents add_addr" 0 0 0
> -	chk_add_nr 0 0
> +	if reset; then
> +		ip netns exec $ns1 sysctl -q net.mptcp.pm_type=1
> +		ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> +		ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> +		ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "userspace pm type prevents add_addr" 0 0 0
> +		chk_add_nr 0 0
> +	fi
>
> 	# userspace pm type echoes add_addr
> -	reset
> -	ip netns exec $ns2 sysctl -q net.mptcp.pm_type=1
> -	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> -	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> -	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "userspace pm type echoes add_addr" 0 0 0
> -	chk_add_nr 1 1
> +	if reset; then
> +		ip netns exec $ns2 sysctl -q net.mptcp.pm_type=1
> +		ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> +		ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> +		ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "userspace pm type echoes add_addr" 0 0 0
> +		chk_add_nr 1 1
> +	fi
>
> 	# userspace pm type rejects join
> -	reset
> -	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=1
> -	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
> -	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> -	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "userspace pm type rejects join" 1 1 0
> +	if reset; then
> +		ip netns exec $ns1 sysctl -q net.mptcp.pm_type=1
> +		ip netns exec $ns1 ./pm_nl_ctl limits 1 1
> +		ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> +		ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "userspace pm type rejects join" 1 1 0
> +	fi
>
> 	# userspace pm type does not send join
> -	reset
> -	ip netns exec $ns2 sysctl -q net.mptcp.pm_type=1
> -	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
> -	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> -	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "userspace pm type does not send join" 0 0 0
> +	if reset; then
> +		ip netns exec $ns2 sysctl -q net.mptcp.pm_type=1
> +		ip netns exec $ns1 ./pm_nl_ctl limits 1 1
> +		ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> +		ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr "userspace pm type does not send join" 0 0 0
> +	fi
>
> 	# userspace pm type prevents mp_prio
> -	reset
> -	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=1
> -	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
> -	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> -	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
> -	chk_join_nr "userspace pm type prevents mp_prio" 1 1 0
> -	chk_prio_nr 0 0
> +	if reset; then
> +		ip netns exec $ns1 sysctl -q net.mptcp.pm_type=1
> +		ip netns exec $ns1 ./pm_nl_ctl limits 1 1
> +		ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> +		ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
> +		chk_join_nr "userspace pm type prevents mp_prio" 1 1 0
> +		chk_prio_nr 0 0
> +	fi
>
> 	# userspace pm type prevents rm_addr
> -	reset
> -	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=1
> -	ip netns exec $ns2 sysctl -q net.mptcp.pm_type=1
> -	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> -	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> -	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
> -	chk_join_nr "userspace pm type prevents rm_addr" 0 0 0
> -	chk_rm_nr 0 0
> +	if reset; then
> +		ip netns exec $ns1 sysctl -q net.mptcp.pm_type=1
> +		ip netns exec $ns2 sysctl -q net.mptcp.pm_type=1
> +		ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> +		ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> +		ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
> +		chk_join_nr "userspace pm type prevents rm_addr" 0 0 0
> +		chk_rm_nr 0 0
> +	fi
> }
>
> all_tests()
> @@ -2250,7 +2368,13 @@ for arg in "$@"; do
> 	fi
>
> 	# exception for the capture/checksum/ip_mptcp options, the rest means: a part of the tests
> -	if ! [[ "${arg}" =~ ^"-"[cCi]+$ ]]; then
> +	if ! [[ "${arg}" =~ ^"-" ]]; then
> +		if [[ "${arg}" =~ ^[0-9]+$ ]]; then
> +			ONLY_TESTS+=("${arg}")
> +		else
> +			usage "Unknown option: ${arg}"
> +		fi
> +	elif ! [[ "${arg}" =~ ^"-"[cCi]+$ ]]; then
> 		do_all_tests=0
> 	fi
> done
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
