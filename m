Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE0C2C9E
	for <mptcp@lists.linux.dev>; Fri,  3 Dec 2021 01:20:17 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="297682362"
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="297682362"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 17:20:16 -0800
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="478137203"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2) ([10.209.65.201])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 17:20:16 -0800
Date: Thu, 2 Dec 2021 17:20:16 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-next v3] selftests: mptcp: add mp_fail testcases
In-Reply-To: <4dd1a9febb11730329ef3486c6dcb1eac3b68d9c.1638443671.git.geliang.tang@suse.com>
Message-ID: <eb9275dc-b9bd-2299-c4aa-1b537a82b57@linux.intel.com>
References: <4dd1a9febb11730329ef3486c6dcb1eac3b68d9c.1638443671.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 2 Dec 2021, Geliang Tang wrote:

> Added the test cases for MP_FAIL, use 'tc' command to trigger the
> checksum failure.
>
> Suggested-by: Davide Caratti <dcaratti@redhat.com>
> Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> v3:
>  - "file received by server does not match" still there.

Other than the "does not match" errors in the files, the tests are passing 
for me and the wireshark captures show a single MP_FAIL in each test.

I would expect the file mismatch on the single subflow test, since it 
falls back to TCP and the packets are still altered after fallback. For 
this test, the script could just confirm the file lengths match. Or, 
better yet, have a custom check that confirms that the bytes in each file 
either match or are inverses.

But with the multiple subflow test, I would expect the checksum mismatch 
on one subflow to reset that subflow and throw away the data with the bad 
checksum. Then the remaining subflow would have unaltered data, so the 
files should match. (And if the remaining subflow had a checksum error, 
the data would be discarded and that subflow would be reset). Seems like 
the file mismatch here is indicating that corrupted data is not being 
discarded as it should be - do you agree?



> ---
> tools/testing/selftests/net/mptcp/config      |   5 +
> .../testing/selftests/net/mptcp/mptcp_join.sh | 108 ++++++++++++++++--
> 2 files changed, 105 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
> index 419e71560fd1..37124a6891b7 100644
> --- a/tools/testing/selftests/net/mptcp/config
> +++ b/tools/testing/selftests/net/mptcp/config
> @@ -19,3 +19,8 @@ CONFIG_NFT_SOCKET=m
> CONFIG_IP_ADVANCED_ROUTER=y
> CONFIG_IP_MULTIPLE_TABLES=y
> CONFIG_IPV6_MULTIPLE_TABLES=y
> +CONFIG_NET_ACT_CSUM=m
> +CONFIG_NET_ACT_PEDIT=m
> +CONFIG_NET_CLS_ACT=y
> +CONFIG_NET_CLS_FLOWER=m
> +CONFIG_NET_SCH_INGRESS=m
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 2684ef9c0d42..6de026689eff 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -160,6 +160,43 @@ reset_with_allow_join_id0()
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
> +	make_file "$cin" "client" 20480
> +	make_file "$sin" "server" 20480
> +
> +	i="$1"
> +

Suggest adding:

ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=1

here so these fail tests always run with checksums enabled. Since MP_FAIL 
is not sent when checksums are off, it doesn't make sense to run without 
checksums.

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
> @@ -178,6 +215,12 @@ if [ $? -ne 0 ];then
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
> @@ -232,6 +275,24 @@ link_failure()
> 	done
> }
>
> +mp_fail_del_dev()
> +{
> +	i="$1"
> +
> +	for n in `seq 1 100`; do
> +		local action=$(tc -n $ns2 -j -s action show action pedit index 100)
> +		local packets=$(echo $action | jq '.[1].actions[0].stats.packets')
> +		local overlimits=$(echo $action | jq '.[1].actions[0].stats.overlimits')
> +
> +		let pkt=$packets-$overlimits
> +		if [ $pkt -gt 0 ]; then
> +			sleep .1
> +			tc -n $ns2 qdisc del dev ns2eth$i clsact
> +			break
> +		fi
> +	done
> +}
> +
> # $1: IP address
> is_v6()
> {
> @@ -371,6 +432,9 @@ do_transfer()
> 	if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
> 		flags="${flags},fullmesh"
> 		addr_nr_ns2=${addr_nr_ns2:9}
> +	elif [[ "${addr_nr_ns2}" = "fail_"* ]]; then
> +		mp_fail_del_dev ${addr_nr_ns2:5}
> +		addr_nr_ns2=0
> 	fi
>
> 	if [ $addr_nr_ns2 -gt 0 ]; then
> @@ -542,6 +606,8 @@ run_tests()
> chk_csum_nr()
> {
> 	local msg=${1:-""}
> +	local csum_ns1=${2:-0}
> +	local csum_ns2=${3:-0}
> 	local count
> 	local dump_stats
>
> @@ -553,8 +619,8 @@ chk_csum_nr()
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
> @@ -563,8 +629,8 @@ chk_csum_nr()
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
> @@ -658,6 +724,8 @@ chk_join_nr()
> 	local syn_nr=$2
> 	local syn_ack_nr=$3
> 	local ack_nr=$4
> +	local fail_nr=${5:-0}
> +	local infi_nr=${6:-0}
> 	local count
> 	local dump_stats
>
> @@ -700,9 +768,9 @@ chk_join_nr()
> 		ip netns exec $ns2 nstat -as | grep MPTcp
> 	fi
> 	if [ $checksum -eq 1 ]; then
> -		chk_csum_nr
> -		chk_fail_nr 0 0
> -		chk_infi_nr 0 0
> +		chk_csum_nr "" $fail_nr
> +		chk_fail_nr $fail_nr $fail_nr
> +		chk_infi_nr $infi_nr $infi_nr

My suggested change in reset_with_fail would break this, so the 
conditional here would need to be updated.

> 	fi
> }
>
> @@ -1837,6 +1905,25 @@ fullmesh_tests()
> 	chk_add_nr 1 1
> }
>
> +fail_tests()
> +{
> +	# multiple subflows
> +	reset_with_fail 2
> +	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> +	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow
> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 dev ns2eth2 flags subflow
> +	run_tests $ns1 $ns2 10.0.1.1 0 0 "fail_2"
> +	chk_join_nr "MP_FAIL test, multiple subflows" 2 2 2 1
> +
> +	# single subflow
> +	reset_with_fail 1
> +	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> +	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> +	run_tests $ns1 $ns2 10.0.1.1 0 0 "fail_1"
> +	chk_join_nr "MP_FAIL test, single subflow" 0 0 0 1 1
> +}
> +
> all_tests()
> {
> 	subflows_tests
> @@ -1853,6 +1940,7 @@ all_tests()
> 	checksum_tests
> 	deny_join_id0_tests
> 	fullmesh_tests
> +	fail_tests
> }
>
> usage()
> @@ -1872,6 +1960,7 @@ usage()
> 	echo "  -S checksum_tests"
> 	echo "  -d deny_join_id0_tests"
> 	echo "  -m fullmesh_tests"
> +	echo "  -F fail_tests"
> 	echo "  -c capture pcap files"
> 	echo "  -C enable data checksum"
> 	echo "  -h help"
> @@ -1907,7 +1996,7 @@ if [ $do_all_tests -eq 1 ]; then
> 	exit $ret
> fi
>
> -while getopts 'fsltra64bpkdmchCS' opt; do
> +while getopts 'fsltra64bpkdmchCSF' opt; do
> 	case $opt in
> 		f)
> 			subflows_tests
> @@ -1951,6 +2040,9 @@ while getopts 'fsltra64bpkdmchCS' opt; do
> 		m)
> 			fullmesh_tests
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
