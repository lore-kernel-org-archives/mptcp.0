Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7499D2F28
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 02:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644372623; x=1675908623;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zcPKwM4uN5EjVUBzD/21EeBQdeoHosm24kgmSAWk0oU=;
  b=l7LxK9ERV/5zs9w6mCOvXI3su6jaLBNkie8IVPd9q2iSRq4v0b7BpnVQ
   7W1zkymuS/HqknGc4fA5g6Ut7EZEAOLlDM2YuAkIo40WattF7mnkBMN8X
   F5A9YYEkkID93zKJJgR+t5fTmGt6dQ6WmdCcttbP6qZ5OZMdky9FmXuCl
   U9Yk/hWEg8h3dX0yX9th6BbJOF+YV6/Ru2RonvMTjxcHfVZ2eyP9kUlqa
   1ERP7OBqFYIQT4j1PPiBzINbwSzs1DfWv0OOTuEa3MQwEvXvY3SCOtZvh
   pi5KdrzCZ7MYByiFFfOoVRphpATUvoRiS+Ac404wnv6T44wO3u26EERsv
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="247934609"
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="247934609"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 18:10:21 -0800
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="540884101"
Received: from tonysun-mobl.amr.corp.intel.com ([10.212.141.113])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 18:10:21 -0800
Date: Tue, 8 Feb 2022 18:10:20 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-next v2 2/2] selftests: mptcp: add mp_fail
 testcases
In-Reply-To: <846d7cac1f134fe9d3b6e8ac2b0c0ab47defc341.1644364562.git.geliang.tang@suse.com>
Message-ID: <358eb7b4-84fe-d8e5-c0fa-e172c8deb7@linux.intel.com>
References: <cover.1644364562.git.geliang.tang@suse.com> <846d7cac1f134fe9d3b6e8ac2b0c0ab47defc341.1644364562.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 9 Feb 2022, Geliang Tang wrote:

> Added the test cases for MP_FAIL, the multiple subflows test for MP_RST
> and the single subflow test for the infinite mapping, use 'tc' commands
> to trigger the checksum failures.
>
> Suggested-by: Davide Caratti <dcaratti@redhat.com>
> Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

Once I built a correctly configured kernel, this worked great! Thanks 
Geliang and Matthieu.

Before I fixed my configuration, I ran in to a couple of issues, see 
below.

> ---
> tools/testing/selftests/net/mptcp/config      |   8 +
> .../testing/selftests/net/mptcp/mptcp_join.sh | 142 ++++++++++++++++--
> 2 files changed, 136 insertions(+), 14 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
> index d36b7da5082a..38021a0dd527 100644
> --- a/tools/testing/selftests/net/mptcp/config
> +++ b/tools/testing/selftests/net/mptcp/config
> @@ -12,6 +12,9 @@ CONFIG_NF_TABLES=m
> CONFIG_NFT_COMPAT=m
> CONFIG_NETFILTER_XTABLES=m
> CONFIG_NETFILTER_XT_MATCH_BPF=m
> +CONFIG_NETFILTER_XT_MATCH_LENGTH=m
> +CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
> +CONFIG_NETFILTER_XT_TARGET_MARK=m
> CONFIG_NF_TABLES_INET=y
> CONFIG_NFT_TPROXY=m
> CONFIG_NFT_SOCKET=m
> @@ -19,3 +22,8 @@ CONFIG_IP_ADVANCED_ROUTER=y
> CONFIG_IP_MULTIPLE_TABLES=y
> CONFIG_IP_NF_TARGET_REJECT=m
> CONFIG_IPV6_MULTIPLE_TABLES=y
> +CONFIG_NET_ACT_CSUM=m
> +CONFIG_NET_ACT_PEDIT=m
> +CONFIG_NET_CLS_ACT=y
> +CONFIG_NET_CLS_FW=m
> +CONFIG_NET_SCH_INGRESS=m
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 90a6adc36490..686c54276ea9 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -17,6 +17,8 @@ capture=0
> checksum=0
> ip_mptcp=0
> check_invert=0
> +validate_checksum=0
> +nr_mp_fail=0
> do_all_tests=1
>
> TEST_COUNT=0
> @@ -62,6 +64,7 @@ init()
> 	done
>
> 	check_invert=0
> +	validate_checksum=$checksum
>
> 	#  ns1              ns2
> 	# ns1eth1    ns2eth1
> @@ -167,6 +170,52 @@ reset_with_allow_join_id0()
> 	ip netns exec $ns2 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns2_enable
> }
>
> +# Modify TCP payload without corrupting the TCP packet
> +#
> +# This rule inverts a 8-bit word at byte offset 148 for the 2nd TCP ACK packets
> +# carrying enough data.
> +# Once it is done, the TCP Checksum field is updated so the packet is still
> +# considered as valid at the TCP level.
> +# Because the MPTCP checksum, covering the TCP options and data, has not been
> +# updated, the modification will be detected and an MP_FAIL will be emitted:
> +# what we want to validate here without corrupting "random" MPTCP options.
> +#
> +# To avoid having tc producing this pr_info() message for each TCP ACK packets
> +# not carrying enough data:
> +#
> +#     tc action pedit offset 162 out of bounds
> +#
> +# Netfilter is used to mark packets with enough data.
> +reset_with_fail()
> +{
> +	reset
> +
> +	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=1
> +	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=1
> +
> +	check_invert=1
> +	validate_checksum=1
> +	nr_mp_fail=0
> +	local i="$1"
> +
> +	ip netns exec $ns2 iptables \
> +		-t mangle \
> +		-A OUTPUT \
> +		-o ns2eth$i \
> +		-p tcp \
> +		-m length --length 150:9999 \
> +		-m statistic --mode nth --packet 1 --every 99999 \
> +		-j MARK --set-mark 42
> +

I think it would help to check the exit code of iptables here, my first 
attempt was with a misconfigured kernel and it would help to fail in a 
more informative way:

$ sudo ./mptcp_join.sh -F
Created /tmp/tmp.P4AWbNYGQ5 (size 1 KB) containing data sent by client
Created /tmp/tmp.ny1Q9MWo85 (size 1 KB) containing data sent by server
iptables v1.8.7 (legacy): Couldn't load match `length':No such file or directory
Try `iptables -h' or 'iptables --help' for more information.
Error: TC classifier not found.
We have an error talking to the kernel


> +	tc -n $ns2 qdisc add dev ns2eth$i clsact
> +	tc -n $ns2 filter add dev ns2eth$i egress \
> +		protocol ip prio 1000 \
> +		handle 42 fw \
> +		action pedit munge offset 148 u8 invert \
> +		pipe csum tcp \
> +		index 100
> +}
> +
> ip -Version > /dev/null 2>&1
> if [ $? -ne 0 ];then
> 	echo "SKIP: Could not run test without ip tool"
> @@ -185,6 +234,12 @@ if [ $? -ne 0 ];then
> 	exit $ksft_skip
> fi
>
> +jq -V > /dev/null 2>&1
> +if [ $? -ne 0 ];then
> +	echo "SKIP: Could not run all tests without jq tool"
> +	exit $ksft_skip
> +fi
> +
> print_file_err()
> {
> 	ls -l "$1" 1>&2
> @@ -245,6 +300,19 @@ link_failure()
> 	done
> }
>
> +get_nr_mp_fail()
> +{
> +	i="$1"
> +
> +	local action=$(tc -n $ns2 -j -s action show action pedit index 100)
> +	local packets=$(echo $action | jq '.[1].actions[0].stats.packets')
> +
> +	if [ $packets -gt 0 ]; then

This triggered a bash parsing error when I did not have the added 
netfilter kernel config options:

$ sudo ./mptcp_join.sh -F
Created /tmp/tmp.P4AWbNYGQ5 (size 1 KB) containing data sent by client
Created /tmp/tmp.ny1Q9MWo85 (size 1 KB) containing data sent by server
iptables v1.8.7 (legacy): Couldn't load match `length':No such file or directory
Try `iptables -h' or 'iptables --help' for more information.
Error: TC classifier not found.
We have an error talking to the kernel
Created /tmp/tmp.CvX8qnG1gC (size 512 KB) containing data sent by client
Created /tmp/tmp.wenxUAgsj8 (size 512 KB) containing data sent by server
./mptcp_join.sh: line 310: [: null: integer expression expected
001 0 MP_FAIL, multiple subflows, MP_RST syn[ ok ] - synack[ ok ] - ack[ ok ]
                                          sum[ ok ] - csum  [ ok ]
                                          ftx[ ok ] - frx   [ ok ]
                                          itx[ ok ] - irx   [ ok ]



> +		nr_mp_fail=1
> +	fi
> +	tc -n $ns2 qdisc del dev ns2eth$i clsact
> +}
> +
> # $1: IP address
> is_v6()
> {
> @@ -446,7 +514,7 @@ do_transfer()
> 		local_addr="0.0.0.0"
> 	fi
>
> -	if [ "$test_link_fail" -eq 2 ];then
> +	if [ "$test_link_fail" -gt 1 ];then
> 		timeout ${timeout_test} \
> 			ip netns exec ${listener_ns} \
> 				$mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
> @@ -466,13 +534,19 @@ do_transfer()
> 			ip netns exec ${connector_ns} \
> 				$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
> 					$connect_addr < "$cin" > "$cout" &
> -	else
> +	elif [ "$test_link_fail" -eq 1 ] || [ "$test_link_fail" -eq 2 ];then
> 		( cat "$cinfail" ; sleep 2; link_failure $listener_ns ; cat "$cinfail" ) | \
> 			tee "$cinsent" | \
> 			timeout ${timeout_test} \
> 				ip netns exec ${connector_ns} \
> 					$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
> 						$connect_addr > "$cout" &
> +	else
> +		cat "$cinfail" | tee "$cinsent" | \
> +		timeout ${timeout_test} \
> +			ip netns exec ${connector_ns} \
> +				$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
> +					$connect_addr > "$cout" &
> 	fi
> 	cpid=$!
>
> @@ -632,7 +706,7 @@ do_transfer()
> 		return 1
> 	fi
>
> -	if [ "$test_link_fail" -eq 2 ];then
> +	if [ "$test_link_fail" -gt 1 ];then
> 		check_transfer $sinfail $cout "file received by client"
> 	else
> 		check_transfer $sin $cout "file received by client"
> @@ -681,7 +755,12 @@ run_tests()
>
> 	# create the input file for the failure test when
> 	# the first failure test run
> -	if [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
> +	if [ "$test_linkfail" -eq 3 ]; then
> +		if [ -z "$cinfail" ]; then
> +			cinfail=$(mktemp)
> +		fi
> +		make_file "$cinfail" "client" 512
> +	elif [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
> 		# the client file must be considerably larger
> 		# of the maximum expected cwin value, or the
> 		# link utilization will be not predicable
> @@ -694,7 +773,12 @@ run_tests()
> 		make_file "$cinfail" "client" $size
> 	fi
>
> -	if [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
> +	if [ "$test_linkfail" -eq 3 ]; then
> +		if [ -z "$sinfail" ]; then
> +			sinfail=$(mktemp)
> +		fi
> +		make_file "$sinfail" "server" 512
> +	elif [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
> 		size=$((RANDOM%16))
> 		size=$((size+1))
> 		size=$((size*2048))
> @@ -719,6 +803,8 @@ dump_stats()
> chk_csum_nr()
> {
> 	local msg=${1:-""}
> +	local csum_ns1=${2:-0}
> +	local csum_ns2=${3:-0}
> 	local count
> 	local dump_stats
>
> @@ -730,8 +816,8 @@ chk_csum_nr()
> 	printf " %-36s %s" "$msg" "sum"
> 	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
> 	[ -z "$count" ] && count=0
> -	if [ "$count" != 0 ]; then
> -		echo "[fail] got $count data checksum error[s] expected 0"
> +	if [ "$count" != $csum_ns1 ]; then
> +		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
> 		ret=1
> 		dump_stats=1
> 	else
> @@ -740,8 +826,8 @@ chk_csum_nr()
> 	echo -n " - csum  "
> 	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
> 	[ -z "$count" ] && count=0
> -	if [ "$count" != 0 ]; then
> -		echo "[fail] got $count data checksum error[s] expected 0"
> +	if [ "$count" != $csum_ns2 ]; then
> +		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
> 		ret=1
> 		dump_stats=1
> 	else
> @@ -820,6 +906,8 @@ chk_join_nr()
> 	local syn_nr=$2
> 	local syn_ack_nr=$3
> 	local ack_nr=$4
> +	local fail_nr=${5:-0}
> +	local infi_nr=${6:-0}
> 	local count
> 	local dump_stats
>
> @@ -856,10 +944,10 @@ chk_join_nr()
> 		echo "[ ok ]"
> 	fi
> 	[ "${dump_stats}" = 1 ] && dump_stats
> -	if [ $checksum -eq 1 ]; then
> -		chk_csum_nr
> -		chk_fail_nr 0 0
> -		chk_infi_nr 0 0
> +	if [ $validate_checksum -eq 1 ]; then
> +		chk_csum_nr "" $fail_nr
> +		chk_fail_nr $fail_nr $fail_nr
> +		chk_infi_nr $infi_nr $infi_nr
> 	fi
> }
>
> @@ -2164,6 +2252,27 @@ userspace_tests()
> 	chk_rm_nr 0 0
> }
>
> +fail_tests()
> +{
> +	# multiple subflows
> +	reset_with_fail 2
> +	pm_nl_set_limits $ns1 0 2
> +	pm_nl_set_limits $ns2 0 2
> +	pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
> +	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
> +	run_tests $ns1 $ns2 10.0.1.1 3
> +	get_nr_mp_fail 2
> +	chk_join_nr "$nr_mp_fail MP_FAIL, multiple subflows, MP_RST" 2 2 2 $nr_mp_fail

Is the first $nr_mp_fail supposed to be in the test description? It's not 
clear what it means in the test output.

> +
> +	# single subflow
> +	reset_with_fail 1
> +	pm_nl_set_limits $ns1 0 2
> +	pm_nl_set_limits $ns2 0 2
> +	run_tests $ns1 $ns2 10.0.1.1 3
> +	get_nr_mp_fail 1
> +	chk_join_nr "$nr_mp_fail MP_FAIL, single subflow, infinite" 0 0 0 $nr_mp_fail $nr_mp_fail

                      ^^^^^^^^^^^ same question

> +}
> +
> all_tests()
> {
> 	subflows_tests
> @@ -2182,6 +2291,7 @@ all_tests()
> 	deny_join_id0_tests
> 	fullmesh_tests
> 	userspace_tests
> +	fail_tests
> }
>
> usage()
> @@ -2203,6 +2313,7 @@ usage()
> 	echo "  -d deny_join_id0_tests"
> 	echo "  -m fullmesh_tests"
> 	echo "  -u userspace_tests"
> +	echo "  -F fail_tests"
> 	echo "  -c capture pcap files"
> 	echo "  -C enable data checksum"
> 	echo "  -i use ip mptcp"
> @@ -2242,7 +2353,7 @@ if [ $do_all_tests -eq 1 ]; then
> 	exit $ret
> fi
>
> -while getopts 'fesltra64bpkdmuchCSi' opt; do
> +while getopts 'fesltra64bpkdmuchCSFi' opt; do
> 	case $opt in
> 		f)
> 			subflows_tests
> @@ -2292,6 +2403,9 @@ while getopts 'fesltra64bpkdmuchCSi' opt; do
> 		u)
> 			userspace_tests
> 			;;
> +		F)
> +			fail_tests
> +			;;
> 		c)
> 			;;
> 		C)
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
