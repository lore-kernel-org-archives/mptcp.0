Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DB768
	for <mptcp@lists.linux.dev>; Thu,  4 Nov 2021 00:43:35 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="231876228"
X-IronPort-AV: E=Sophos;i="5.87,207,1631602800"; 
   d="scan'208";a="231876228"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 17:43:33 -0700
X-IronPort-AV: E=Sophos;i="5.87,207,1631602800"; 
   d="scan'208";a="639110554"
Received: from crschrol-desk6.amr.corp.intel.com ([10.251.25.129])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 17:43:33 -0700
Date: Wed, 3 Nov 2021 17:43:32 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-next v8 8/8] selftests: mptcp: add mp_fail
 testcases
In-Reply-To: <ff613391540609e31cf4aff5abefaa03fbd63278.1635481641.git.geliang.tang@suse.com>
Message-ID: <32bda041-3193-ac47-3d4e-5a7a7e5371c0@linux.intel.com>
References: <cover.1635481641.git.geliang.tang@suse.com> <ff613391540609e31cf4aff5abefaa03fbd63278.1635481641.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 29 Oct 2021, Geliang Tang wrote:

> Added the test cases for MP_FAIL, use 'tc' command to trigger the
> checksum failure.
>
> Suggested-by: Davide Caratti <dcaratti@redhat.com>
> Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> tools/testing/selftests/net/mptcp/config      |  5 ++
> .../testing/selftests/net/mptcp/mptcp_join.sh | 75 +++++++++++++++++--
> 2 files changed, 72 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
> index 0faaccd21447..f522288b2204 100644
> --- a/tools/testing/selftests/net/mptcp/config
> +++ b/tools/testing/selftests/net/mptcp/config
> @@ -15,3 +15,8 @@ CONFIG_NETFILTER_XTABLES=m
> CONFIG_NETFILTER_XT_MATCH_BPF=m
> CONFIG_NF_TABLES_IPV4=y
> CONFIG_NF_TABLES_IPV6=y
> +CONFIG_NET_ACT_CSUM=m
> +CONFIG_NET_ACT_PEDIT=m
> +CONFIG_NET_CLS_ACT=m
> +CONFIG_NET_CLS_FLOWER=m
> +CONFIG_NET_SCH_INGRESS=m
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 2684ef9c0d42..d33cb5ce0ff3 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -178,6 +178,12 @@ if [ $? -ne 0 ];then
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
> @@ -232,6 +238,28 @@ link_failure()
> 	done
> }
>
> +checksum_failure()
> +{
> +	i="$1"
> +
> +	tc -n $ns2 qdisc add dev ns2eth$i clsact
> +	tc -n $ns2 filter add dev ns2eth$i egress \
> +		protocol ip prio 1000 \
> +		flower ip_proto tcp \
> +		action pedit munge offset 148 u32 invert \
> +		pipe csum tcp \
> +		index 100

Could you add a comment explaining what the filter is doing? While it 
looks like the idea is to invert the 32-bit word at byte offset 148, I'm 
not tc-literate enough to know if there are other effects (and I didn't 
watch the email threads closely on this).

> +
> +	while true; do
> +		local pkt=$(tc -n $ns2 -j -s action show action csum index 100 |
> +				jq '.[1].actions[0].stats.packets')
> +		if [ $pkt -gt 0 ]; then
> +			tc -n $ns2 qdisc del dev ns2eth$i clsact
> +			break
> +		fi
> +	done
> +}
> +
> # $1: IP address
> is_v6()
> {
> @@ -371,6 +399,9 @@ do_transfer()
> 	if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
> 		flags="${flags},fullmesh"
> 		addr_nr_ns2=${addr_nr_ns2:9}
> +	elif [[ "${addr_nr_ns2}" = "fail_"* ]]; then
> +		checksum_failure ${addr_nr_ns2:5}
> +		addr_nr_ns2=0
> 	fi
>
> 	if [ $addr_nr_ns2 -gt 0 ]; then
> @@ -542,6 +573,8 @@ run_tests()
> chk_csum_nr()
> {
> 	local msg=${1:-""}
> +	local csum_ns1=${2:-0}
> +	local csum_ns2=${3:-0}
> 	local count
> 	local dump_stats
>
> @@ -553,8 +586,8 @@ chk_csum_nr()
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
> @@ -563,8 +596,8 @@ chk_csum_nr()
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
> @@ -658,6 +691,8 @@ chk_join_nr()
> 	local syn_nr=$2
> 	local syn_ack_nr=$3
> 	local ack_nr=$4
> +	local fail_nr=${5:-0}
> +	local infi_nr=${6:-0}
> 	local count
> 	local dump_stats
>
> @@ -700,9 +735,9 @@ chk_join_nr()
> 		ip netns exec $ns2 nstat -as | grep MPTcp
> 	fi
> 	if [ $checksum -eq 1 ]; then
> -		chk_csum_nr
> -		chk_fail_nr 0 0
> -		chk_infi_nr 0 0
> +		chk_csum_nr "" $fail_nr
> +		chk_fail_nr $fail_nr $fail_nr
> +		chk_infi_nr $infi_nr $infi_nr
> 	fi
> }
>
> @@ -1837,6 +1872,25 @@ fullmesh_tests()
> 	chk_add_nr 1 1
> }
>
> +fail_tests()
> +{

Since MP_FAIL is only relevent with checksums enabled, I think it would be 
good to set $checksum=1 here and restore its previous value before 
returning (in case other tests run after this).

> +	# 1 subflow
> +	reset
> +	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> +	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> +	run_tests $ns1 $ns2 10.0.1.1 2 0 "fail_1" fast
> +	chk_join_nr "MP_FAIL test, 1 subflow" 0 0 0 1 1
> +
> +	# multiple subflows
> +	reset
> +	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> +	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow
> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 dev ns2eth2 flags subflow
> +	run_tests $ns1 $ns2 10.0.1.1 2 0 "fail_2" fast
> +	chk_join_nr "MP_FAIL test, multiple subflows" 2 2 2 1
> +}
> +
> all_tests()
> {
> 	subflows_tests
> @@ -1853,6 +1907,7 @@ all_tests()
> 	checksum_tests
> 	deny_join_id0_tests
> 	fullmesh_tests
> +	fail_tests
> }
>
> usage()
> @@ -1872,6 +1927,7 @@ usage()
> 	echo "  -S checksum_tests"
> 	echo "  -d deny_join_id0_tests"
> 	echo "  -m fullmesh_tests"
> +	echo "  -F fail_tests"
> 	echo "  -c capture pcap files"
> 	echo "  -C enable data checksum"
> 	echo "  -h help"
> @@ -1907,7 +1963,7 @@ if [ $do_all_tests -eq 1 ]; then
> 	exit $ret
> fi
>
> -while getopts 'fsltra64bpkdmchCS' opt; do
> +while getopts 'fsltra64bpkdmchCSF' opt; do
> 	case $opt in
> 		f)
> 			subflows_tests
> @@ -1951,6 +2007,9 @@ while getopts 'fsltra64bpkdmchCS' opt; do
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
> 2.26.2

When I run:

$ sudo ./mptcp_join.sh -FC

I get:

"""
Created /tmp/tmp.UTIlkuhfRW (size 1 KB) containing data sent by client
Created /tmp/tmp.pMPhJddNfQ (size 1 KB) containing data sent by server
Created /tmp/tmp.OEx5cmVqbp (size 10075 KB) containing data sent by client
Created /tmp/tmp.RAtBQXOXtR (size 6144 KB) containing data sent by server
[ FAIL ] file received by server does not match (in, out):
-rw-------. 1 root root 20633656 Nov  3 17:32 /tmp/tmp.HtyoJjpCOe
Trailing bytes are:
MPTCP_TEST_FILE_END_MARKER
-rw-------. 1 root root 20633656 Nov  3 17:32 /tmp/tmp.j8HYN1PUVh
Trailing bytes are:
MPTCP_TEST_FILE_END_MARKER
01 MP_FAIL test, 1 subflow              syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - frx   [ ok ]
                                         itx[ ok ] - irx   [ ok ]
[ FAIL ] file received by server does not match (in, out):
-rw-------. 1 root root 20633656 Nov  3 17:32 /tmp/tmp.HtyoJjpCOe
Trailing bytes are:
MPTCP_TEST_FILE_END_MARKER
-rw-------. 1 root root 20633656 Nov  3 17:32 /tmp/tmp.j8HYN1PUVh
Trailing bytes are:
MPTCP_TEST_FILE_END_MARKER
02 MP_FAIL test, multiple subflows      syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - frx   [ ok ]
                                         itx[ ok ] - irx   [ ok ]
"""

The chk_join_nr output shows all [ ok ], which is good. But the file 
mismatches (I assume due to the inverted data) are failures because the 
checksums are intended to reject the bad data. Am I understanding the file 
mismatches correctly?

If MP_FAIL is working, the files should match.

Thanks,

--
Mat Martineau
Intel
