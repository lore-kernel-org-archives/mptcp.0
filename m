Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA3D2C9D
	for <mptcp@lists.linux.dev>; Thu, 27 Jan 2022 00:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643242065; x=1674778065;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PV0sru/X2oFtgVO7fUK4FCHKEZ38NJVfpJIy8nqaU6k=;
  b=aH0AJUNS0JlbVJL5qXH65BnebmFYVgHZ78oEWei4NUoO2oC+VqNkz9E4
   yv8FKucrFSVV+4mhya0rl3tKhSKQoHWleg16O9oMy87xOVgeMkGx+tQ+d
   88FgfWKB7zTrxxHrsLs7gXzWXdSMutiD9SuoI5is7mv47s2yrjPBSfauW
   MMJTS8uF1HPFRA5kq8EBtmrjR3PXLrkfhJPTveM4jXLiaQVehvIX7GdyY
   ZQqyYA4dlDf5xLYwJq355Hi7oSo7HDgSI9PW0cqaY4mX8eVedGcHt/PXf
   UDzwiIpgXKrbO0IHabV/OdkXWzAKHW2YVmunKI+ZydfO+LoBKcUQJs4Gx
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="271148195"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="271148195"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 16:07:44 -0800
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="769541423"
Received: from dhurwitz-mobl.amr.corp.intel.com ([10.209.79.89])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 16:07:44 -0800
Date: Wed, 26 Jan 2022 16:07:44 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-next 3/3] selftests: mptcp: add mp_fail testcases
In-Reply-To: <064cfe306debc535413c1d39fcf3b8d24a959eeb.1643110285.git.geliang.tang@suse.com>
Message-ID: <b4708d63-29aa-da51-f536-3b5bf5399221@linux.intel.com>
References: <cover.1643110285.git.geliang.tang@suse.com> <064cfe306debc535413c1d39fcf3b8d24a959eeb.1643110285.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 25 Jan 2022, Geliang Tang wrote:

> Added the test cases for MP_FAIL, use 'tc' commands to trigger the
> checksum failures.
>

This patch is working well with the inverted byte detection, thanks!

-Mat

> Suggested-by: Davide Caratti <dcaratti@redhat.com>
> Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> tools/testing/selftests/net/mptcp/config      |   5 +
> .../testing/selftests/net/mptcp/mptcp_join.sh | 148 +++++++++++++++---
> 2 files changed, 135 insertions(+), 18 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
> index d36b7da5082a..26955abe49f0 100644
> --- a/tools/testing/selftests/net/mptcp/config
> +++ b/tools/testing/selftests/net/mptcp/config
> @@ -19,3 +19,8 @@ CONFIG_IP_ADVANCED_ROUTER=y
> CONFIG_IP_MULTIPLE_TABLES=y
> CONFIG_IP_NF_TARGET_REJECT=m
> CONFIG_IPV6_MULTIPLE_TABLES=y
> +CONFIG_NET_ACT_CSUM=m
> +CONFIG_NET_ACT_PEDIT=m
> +CONFIG_NET_CLS_ACT=y
> +CONFIG_NET_CLS_FLOWER=m
> +CONFIG_NET_SCH_INGRESS=m
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 76c45c845d3b..44176419ff1d 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -17,6 +17,8 @@ capture=0
> checksum=0
> ip_mptcp=0
> check_invert=0
> +validate_checksum=0
> +nr_fail=0
> do_all_tests=1
>
> TEST_COUNT=0
> @@ -61,6 +63,7 @@ init()
> 	done
>
> 	check_invert=0
> +	validate_checksum=$checksum
>
> 	#  ns1              ns2
> 	# ns1eth1    ns2eth1
> @@ -166,6 +169,46 @@ reset_with_allow_join_id0()
> 	ip netns exec $ns2 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns2_enable
> }
>
> +# Modify TCP payload without corrupting the TCP packet
> +#
> +# This rule inverts a 32-bit word at byte offset 148 for all TCP ACK
> +# packets carrying enough data.
> +# Once it is done, the TCP Checksum field is updated so the packet
> +# is still considered as valid at the TCP level.
> +# But because the MPTCP checksum, covering the TCP options and data,
> +# has not been updated, we will detect the modification and emit an
> +# MP_FAIL: what we want to validate here.
> +#
> +# Please note that this rule will produce this pr_info() message for
> +# each TCP ACK packets not carrying enough data:
> +#
> +#     tc action pedit offset 162 out of bounds
> +#
> +# But this should be limited to a very few numbers of packets as we
> +# restrict this rule to outgoing TCP traffic with only the ACK flag
> +# + except the 3rd ACK, only packets carrying data should be seen in
> +# this direction.
> +reset_with_fail()
> +{
> +	reset
> +
> +	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=1
> +	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=1
> +
> +	check_invert=1
> +	validate_checksum=1
> +	nr_fail=0
> +	i="$1"
> +
> +	tc -n $ns2 qdisc add dev ns2eth$i clsact
> +	tc -n $ns2 filter add dev ns2eth$i egress \
> +		protocol ip prio 1000 \
> +		flower ip_proto tcp tcp_flags 0x10/0xff \
> +		action pedit munge offset 148 u32 invert \
> +		pipe csum tcp \
> +		index 100
> +}
> +
> ip -Version > /dev/null 2>&1
> if [ $? -ne 0 ];then
> 	echo "SKIP: Could not run test without ip tool"
> @@ -184,6 +227,12 @@ if [ $? -ne 0 ];then
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
> @@ -244,6 +293,21 @@ link_failure()
> 	done
> }
>
> +get_nr_fail()
> +{
> +	i="$1"
> +
> +	local action=$(tc -n $ns2 -j -s action show action pedit index 100)
> +	local packets=$(echo $action | jq '.[1].actions[0].stats.packets')
> +	local overlimits=$(echo $action | jq '.[1].actions[0].stats.overlimits')
> +
> +	let pkt=$packets-$overlimits
> +	if [ $pkt -gt 0 ]; then
> +		nr_fail=1
> +	fi
> +	tc -n $ns2 qdisc del dev ns2eth$i clsact
> +}
> +
> # $1: IP address
> is_v6()
> {
> @@ -458,7 +522,7 @@ do_transfer()
> 		local_addr="0.0.0.0"
> 	fi
>
> -	if [ "$test_link_fail" -eq 2 ];then
> +	if [ "$test_link_fail" -gt 1 ];then
> 		timeout ${timeout_test} \
> 			ip netns exec ${listener_ns} \
> 				$mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
> @@ -478,13 +542,19 @@ do_transfer()
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
> @@ -652,7 +722,7 @@ do_transfer()
> 		return 1
> 	fi
>
> -	if [ "$test_link_fail" -eq 2 ];then
> +	if [ "$test_link_fail" -gt 1 ];then
> 		check_transfer $sinfail $cout "file received by client"
> 	else
> 		check_transfer $sin $cout "file received by client"
> @@ -701,7 +771,13 @@ run_tests()
>
> 	# create the input file for the failure test when
> 	# the first failure test run
> -	if [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
> +	if [ "$test_linkfail" -eq 3 ]; then
> +		cinfail=$(mktemp)
> +		make_file "$cinfail" "client" 10240
> +	elif [ "$test_linkfail" -eq 4 ]; then
> +		cinfail=$(mktemp)
> +		make_file "$cinfail" "client" 512
> +	elif [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
> 		# the client file must be considerably larger
> 		# of the maximum expected cwin value, or the
> 		# link utilization will be not predicable
> @@ -714,7 +790,13 @@ run_tests()
> 		make_file "$cinfail" "client" $size
> 	fi
>
> -	if [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
> +	if [ "$test_linkfail" -eq 3 ]; then
> +		sinfail=$(mktemp)
> +		make_file "$sinfail" "server" 10240
> +	elif [ "$test_linkfail" -eq 4 ]; then
> +		sinfail=$(mktemp)
> +		make_file "$sinfail" "server" 512
> +	elif [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
> 		size=$((RANDOM%16))
> 		size=$((size+1))
> 		size=$((size*2048))
> @@ -739,6 +821,8 @@ dump_stats()
> chk_csum_nr()
> {
> 	local msg=${1:-""}
> +	local csum_ns1=${2:-0}
> +	local csum_ns2=${3:-0}
> 	local count
> 	local dump_stats
>
> @@ -750,8 +834,8 @@ chk_csum_nr()
> 	printf " %-36s %s" "$msg" "sum"
> 	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
> 	[ -z "$count" ] && count=0
> -	if [ "$count" != 0 ]; then
> -		echo "[fail] got $count data checksum error[s] expected 0"
> +	if [ "$count" -lt $csum_ns1 ]; then
> +		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
> 		ret=1
> 		dump_stats=1
> 	else
> @@ -760,8 +844,8 @@ chk_csum_nr()
> 	echo -n " - csum  "
> 	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
> 	[ -z "$count" ] && count=0
> -	if [ "$count" != 0 ]; then
> -		echo "[fail] got $count data checksum error[s] expected 0"
> +	if [ "$count" -lt $csum_ns2 ]; then
> +		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
> 		ret=1
> 		dump_stats=1
> 	else
> @@ -780,7 +864,7 @@ chk_fail_nr()
> 	printf "%-39s %s" " " "ftx"
> 	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailTx | awk '{print $2}'`
> 	[ -z "$count" ] && count=0
> -	if [ "$count" != "$mp_fail_nr_tx" ]; then
> +	if [ "$count" -lt "$mp_fail_nr_tx" ]; then
> 		echo "[fail] got $count MP_FAIL[s] TX expected $mp_fail_nr_tx"
> 		ret=1
> 		dump_stats=1
> @@ -791,7 +875,7 @@ chk_fail_nr()
> 	echo -n " - frx   "
> 	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtMPFailRx | awk '{print $2}'`
> 	[ -z "$count" ] && count=0
> -	if [ "$count" != "$mp_fail_nr_rx" ]; then
> +	if [ "$count" -lt "$mp_fail_nr_rx" ]; then
> 		echo "[fail] got $count MP_FAIL[s] RX expected $mp_fail_nr_rx"
> 		ret=1
> 		dump_stats=1
> @@ -812,7 +896,7 @@ chk_infi_nr()
> 	printf "%-39s %s" " " "itx"
> 	count=`ip netns exec $ns2 nstat -as | grep InfiniteMapTx | awk '{print $2}'`
> 	[ -z "$count" ] && count=0
> -	if [ "$count" != "$mp_infi_nr_tx" ]; then
> +	if [ "$count" -lt "$mp_infi_nr_tx" ]; then
> 		echo "[fail] got $count infinite map[s] TX expected $mp_infi_nr_tx"
> 		ret=1
> 		dump_stats=1
> @@ -823,7 +907,7 @@ chk_infi_nr()
> 	echo -n " - irx   "
> 	count=`ip netns exec $ns1 nstat -as | grep InfiniteMapRx | awk '{print $2}'`
> 	[ -z "$count" ] && count=0
> -	if [ "$count" != "$mp_infi_nr_rx" ]; then
> +	if [ "$count" -lt "$mp_infi_nr_rx" ]; then
> 		echo "[fail] got $count infinite map[s] RX expected $mp_infi_nr_rx"
> 		ret=1
> 		dump_stats=1
> @@ -840,6 +924,8 @@ chk_join_nr()
> 	local syn_nr=$2
> 	local syn_ack_nr=$3
> 	local ack_nr=$4
> +	local fail_nr=${5:-0}
> +	local infi_nr=${6:-0}
> 	local count
> 	local dump_stats
>
> @@ -876,10 +962,10 @@ chk_join_nr()
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
> @@ -2183,6 +2269,27 @@ userspace_tests()
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
> +	get_nr_fail 2
> +	chk_join_nr "$nr_fail MP_FAIL, multiple subflows" 2 2 2 $nr_fail
> +
> +	# single subflow
> +	reset_with_fail 1
> +	pm_nl_set_limits $ns1 0 2
> +	pm_nl_set_limits $ns2 0 2
> +	run_tests $ns1 $ns2 10.0.1.1 4
> +	get_nr_fail 1
> +	chk_join_nr "$nr_fail MP_FAIL, single subflow" 0 0 0 $nr_fail 0
> +}
> +
> all_tests()
> {
> 	subflows_tests
> @@ -2201,6 +2308,7 @@ all_tests()
> 	deny_join_id0_tests
> 	fullmesh_tests
> 	userspace_tests
> +	fail_tests
> }
>
> usage()
> @@ -2222,6 +2330,7 @@ usage()
> 	echo "  -d deny_join_id0_tests"
> 	echo "  -m fullmesh_tests"
> 	echo "  -u userspace_tests"
> +	echo "  -F fail_tests"
> 	echo "  -c capture pcap files"
> 	echo "  -C enable data checksum"
> 	echo "  -i use ip mptcp"
> @@ -2261,7 +2370,7 @@ if [ $do_all_tests -eq 1 ]; then
> 	exit $ret
> fi
>
> -while getopts 'fesltra64bpkdmuchCSi' opt; do
> +while getopts 'fesltra64bpkdmuchCSFi' opt; do
> 	case $opt in
> 		f)
> 			subflows_tests
> @@ -2311,6 +2420,9 @@ while getopts 'fesltra64bpkdmuchCSi' opt; do
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
> 2.31.1
>
>
>

--
Mat Martineau
Intel
