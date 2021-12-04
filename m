Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFD32CA2
	for <mptcp@lists.linux.dev>; Sat,  4 Dec 2021 01:13:06 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="217105506"
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="217105506"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 17:13:05 -0800
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="746876688"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2) ([10.251.18.88])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 17:13:05 -0800
Date: Fri, 3 Dec 2021 17:13:05 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 5/5] selftests: mptcp: add tests for subflow
 creation failure
In-Reply-To: <bd0c8b9c4ac5e667889f0c0a5f99da295a574cd8.1638544716.git.pabeni@redhat.com>
Message-ID: <1d52a2f6-8087-421-1fb3-572ee97041e2@linux.intel.com>
References: <cover.1638544716.git.pabeni@redhat.com> <bd0c8b9c4ac5e667889f0c0a5f99da295a574cd8.1638544716.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 3 Dec 2021, Paolo Abeni wrote:

> Verify that, when multiple endpoints are available, subflows
> creation proceed even when the first additional subflow creation
> fails - due to packet drop on the relevant link
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v3 -> v4:
> - use $() where applicable - Matt
> - fix typo in help() - Matt
>
> v1 -> v2:
> - add missing NF kconfig
> - add more test-cases (drop, later subflow creation)
> ---
> tools/testing/selftests/net/mptcp/config      |  1 +
> .../testing/selftests/net/mptcp/mptcp_join.sh | 65 ++++++++++++++++++-
> 2 files changed, 65 insertions(+), 1 deletion(-)
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
> index 2684ef9c0d42..54a826ae984b 100755
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
> @@ -1032,6 +1048,48 @@ subflows_tests()
> 	chk_join_nr "single subflow, dev" 1 1 1
> }
>
> +subflows_error_tests()
> +{
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
> +	# mpj subflow will be in TW after the reset
> +	wait_for_tw $ns2
> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
> +	wait
> +
> +	# additional subflow could be created only if the PM select
> +	# the later endpoint, skipping the already used one
> +	chk_join_nr "multiple subflows, fair usage on close" 1 1 1
> +}

The results are printed like this for me:

01 multiple subflows, with failing subflow syn[ ok ] - synack[ ok ] - ack[ ok ]
02 multiple subflows, with subflow timeout syn[ ok ] - synack[ ok ] - ack[ ok ]
02 multiple subflows, fair usage on close syn[ ok ] - synack[ ok ] - ack[ ok ]
^^ not 03

With test 3 running in the background, I guess $TEST_COUNT doesn't get 
updated. Hopefully there aren't other globals doing unexpected things...


-Mat

> +
> signal_address_tests()
> {
> 	# add_address, unused
> @@ -1840,6 +1898,7 @@ fullmesh_tests()
> all_tests()
> {
> 	subflows_tests
> +	subflows_error_tests
> 	signal_address_tests
> 	link_failure_tests
> 	add_addr_timeout_tests
> @@ -1859,6 +1918,7 @@ usage()
> {
> 	echo "mptcp_join usage:"
> 	echo "  -f subflows_tests"
> +	echo "  -e subflows_error_tests"
> 	echo "  -s signal_address_tests"
> 	echo "  -l link_failure_tests"
> 	echo "  -t add_addr_timeout_tests"
> @@ -1907,11 +1967,14 @@ if [ $do_all_tests -eq 1 ]; then
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
