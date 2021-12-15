Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA2068
	for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 01:16:11 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="219804887"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="219804887"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 17:16:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="465329825"
Received: from gchandra-mobl.amr.corp.intel.com ([10.209.52.30])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 17:16:10 -0800
Date: Tue, 14 Dec 2021 17:16:10 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v6 mptcp-next 5/7] selftests: mptcp: add tests for subflow
 creation failure
In-Reply-To: <e28be5ca46a0974b89e321e87e4fb654fcdd9b99.1639500873.git.pabeni@redhat.com>
Message-ID: <82688995-78b1-a1c7-3cab-b719f767951f@linux.intel.com>
References: <cover.1639500873.git.pabeni@redhat.com> <e28be5ca46a0974b89e321e87e4fb654fcdd9b99.1639500873.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 14 Dec 2021, Paolo Abeni wrote:

> Verify that, when multiple endpoints are available, subflows
> creation proceed even when the first additional subflow creation
> fails - due to packet drop on the relevant link
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v5 -> v6:
> - fix test cnt update
>
> v4 -> v5:
> - new test checking for wrong MPC reuse
>
> v3 -> v4:
> - use $() where applicable - Matt
> - fix typo in help() - Matt
>
> v1 -> v2:
> - add missing NF kconfig
> - add more test-cases (drop, later subflow creation)
> ---
> tools/testing/selftests/net/mptcp/config      |  1 +
> .../testing/selftests/net/mptcp/mptcp_join.sh | 78 ++++++++++++++++++-
> 2 files changed, 78 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
> index 419e71560fd1..41e94e004bdc 100644
> --- a/tools/testing/selftests/net/mptcp/config
> +++ b/tools/testing/selftests/net/mptcp/config
> @@ -18,4 +18,5 @@ CONFIG_NFT_TPROXY=m
> CONFIG_NFT_SOCKET=m
> CONFIG_IP_ADVANCED_ROUTER=y
> CONFIG_IP_MULTIPLE_TABLES=y
> +CONFIG_IP_NF_TARGET_REJECT=m
> CONFIG_IPV6_MULTIPLE_TABLES=y
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 526b05771d08..56fcc8b412fc 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -975,6 +975,22 @@ chk_link_usage()
> 	fi
> }
>
> +wait_for_tw()
> +{
> +	local timeout_ms=$((timeout_poll * 1000))
> +	local time=0
> +	local ns=$1
> +
> +	while [ $time -lt $timeout_ms ]; do
> +		local cnt=$(ip netns exec $ns ss -t state time-wait |wc -l)
> +
> +		[ "$cnt" = 1 ] && return 1
> +		time=$((time + 100))
> +		sleep 0.1
> +	done
> +	return 1
> +}
> +
> subflows_tests()
> {
> 	reset
> @@ -1032,6 +1048,61 @@ subflows_tests()
> 	chk_join_nr "single subflow, dev" 1 1 1
> }
>
> +subflows_error_tests()
> +{
> +	# If a single subflow is configured, and matches the MPC src
> +	# address, no additional subflow should be created
> +	reset
> +	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> +	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.1.2 flags subflow
> +	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> +	chk_join_nr "no MPC address reuse with single endpoint" 0 0 0
> +
> +	# multiple subflows, with subflow creation error
> +	reset
> +	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> +	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
> +	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
> +	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> +	chk_join_nr "multiple subflows, with failing subflow" 1 1 1
> +
> +	# multiple subflows, with subflow timeout on MPJ
> +	reset
> +	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> +	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
> +	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j DROP
> +	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> +	chk_join_nr "multiple subflows, with subflow timeout" 1 1 1
> +
> +	# multiple subflows, check that the endpoint corresponding to
> +	# closed subflow (due to reset) is not reused if additional
> +	# subflows are added later
> +	reset
> +	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> +	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> +	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
> +	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
> +
> +	# updates in the child shell do not have any effect here, we
> +	# need to bump the test counter for the above case
> +	TEST_COUNT=$((TEST_COUNT))

Missing the "+1"... maybe Matthieu can adjust when applying?


-Mat

> +
> +	# mpj subflow will be in TW after the reset
> +	wait_for_tw $ns2
> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
> +	wait
> +
> +	# additional subflow could be created only if the PM select
> +	# the later endpoint, skipping the already used one
> +	chk_join_nr "multiple subflows, fair usage on close" 1 1 1
> +}
> +
> signal_address_tests()
> {
> 	# add_address, unused
> @@ -1843,6 +1914,7 @@ fullmesh_tests()
> all_tests()
> {
> 	subflows_tests
> +	subflows_error_tests
> 	signal_address_tests
> 	link_failure_tests
> 	add_addr_timeout_tests
> @@ -1862,6 +1934,7 @@ usage()
> {
> 	echo "mptcp_join usage:"
> 	echo "  -f subflows_tests"
> +	echo "  -e subflows_error_tests"
> 	echo "  -s signal_address_tests"
> 	echo "  -l link_failure_tests"
> 	echo "  -t add_addr_timeout_tests"
> @@ -1910,11 +1983,14 @@ if [ $do_all_tests -eq 1 ]; then
> 	exit $ret
> fi
>
> -while getopts 'fsltra64bpkdmchCS' opt; do
> +while getopts 'fesltra64bpkdmchCS' opt; do
> 	case $opt in
> 		f)
> 			subflows_tests
> 			;;
> +		e)
> +			subflows_error_tests
> +			;;
> 		s)
> 			signal_address_tests
> 			;;
> -- 
> 2.33.1
>
>
>

--
Mat Martineau
Intel
