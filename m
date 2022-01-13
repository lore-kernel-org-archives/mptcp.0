Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DBC2C82
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 01:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642035993; x=1673571993;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OoKGgwRxQJ2Ft/9Fln7RNVkcf5+PXgYR1fLaMIfI/EM=;
  b=G1H6O3LDvhOOjK7Updgq6kVOM8Vfb9bI5m9WazippsD/hm4A3tJrVnQJ
   FK1Ka/45WbNgb6br6dDLLQsup51zNCTvmWxVDOhkonbQ3JVv92SDLyxD+
   RejSUzF5r/k2d3Tx9ZaPtoJ38c5lJGVYTSeKNIVg/hIML5UNsrs9jnABn
   dcgoXmMbXQv/Ew8VH5Hr22mj1md/1Hfxq1XcFun/umHFIVgOa4JTdMEYQ
   txP/YcikM6a03qMH6/j9qeDJV7c2Boz15PpJqPd+IkUPsB2d9oCfrcZdW
   fjwYWGI1hsqixSXOXmMzwMdos9beU8/iIGJ0/1lovgtPgKhSLQyRDGids
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="231238575"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="231238575"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 17:06:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="670345326"
Received: from peterwri-mobl.amr.corp.intel.com ([10.209.106.113])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 17:06:32 -0800
Date: Wed, 12 Jan 2022 17:06:31 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-next v9 5/5] selftests: mptcp: add mp_fail
 testcases
In-Reply-To: <a0f7ec766ca99a5f2e2aa27a358f45fc06f6cc78.1641804767.git.geliang.tang@suse.com>
Message-ID: <ea44a519-11b9-175-cceb-abb69232abbd@linux.intel.com>
References: <cover.1641804767.git.geliang.tang@suse.com> <a0f7ec766ca99a5f2e2aa27a358f45fc06f6cc78.1641804767.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 10 Jan 2022, Geliang Tang wrote:

> Added the test cases for MP_FAIL, use 'tc' command to trigger the
> checksum failure.
>
> Suggested-by: Davide Caratti <dcaratti@redhat.com>
> Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> tools/testing/selftests/net/mptcp/config      |   5 +
> .../testing/selftests/net/mptcp/mptcp_join.sh | 111 ++++++++++++++++--
> 2 files changed, 107 insertions(+), 9 deletions(-)
>

Does anyone else see the "leaked reference" errors when running these fail 
tests with the latest export branch? Looks like the reference tracker 
finds a tc-related error:

[  238.871372] leaked reference.
[  238.872393]  fl_change+0x2db/0x2520
[  238.873148]  tc_new_tfilter+0x6c4/0x11f0
[  238.873959]  rtnetlink_rcv_msg+0x49f/0x640
[  238.874798]  netlink_rcv_skb+0xc4/0x1f0
[  238.875570]  netlink_unicast+0x2d5/0x410
[  238.876364]  netlink_sendmsg+0x3b3/0x6c0
[  238.877155]  sock_sendmsg+0x91/0xa0
[  238.877890]  ____sys_sendmsg+0x3ad/0x3f0
[  238.878684]  ___sys_sendmsg+0xdb/0x140
[  238.879354]  __sys_sendmsg+0xae/0x120
[  238.879947]  do_syscall_64+0x3b/0x90
[  238.880683]  entry_SYSCALL_64_after_hwframe+0x44/0xae

It doesn't look like MPTCP is to blame, but I'm curious if others see the 
same.

Since this test till has the file mismatch error, I don't think it's ready 
for the export branch yet. But I think fixing this will involve two 
things:

1. (Likely) A fix to the code that flushes the received data from the 
subflow rx buffer, so corrupt data is dropped before it gets copied to the 
MPTCP-level buffer. Still trying to narrow this down, and it will likely 
involve a separate patch (maybe to squash to an existing patch in the 
export branch, maybe not).

2. A way to accept the expected bit flips in the "infinite fallback" case, 
where the checksum failure causes fallback and the data is not rejected. 
check_transfer just uses 'cmp' right now to make sure the temp files are 
identical. Another tool (maybe awk, maybe a small c program in our test 
directory) could compare bytes in each file allowing either identical 
bytes or inverted bytes:

// assuming files already mmap'd

for (i = 0; i < length; i++) {
     if ((file1[i] != file2[i]) && (file1[i] != ~file2[i]))
         return 1;
}

return 0;

For the case where inverted bytes are valid, use the alternate comparison 
tool.

- Mat

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
> index e48ce23d2386..535baa3c01e7 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -16,6 +16,7 @@ mptcp_connect=""
> capture=0
> checksum=0
> do_all_tests=1
> +nr_fail=0
>
> TEST_COUNT=0
>
> @@ -58,6 +59,8 @@ init()
> 		fi
> 	done
>
> +	validate_checksum=$checksum
> +
> 	#  ns1              ns2
> 	# ns1eth1    ns2eth1
> 	# ns1eth2    ns2eth2
> @@ -161,6 +164,45 @@ reset_with_allow_join_id0()
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
> @@ -179,6 +221,12 @@ if [ $? -ne 0 ];then
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
> @@ -233,6 +281,21 @@ link_failure()
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
> @@ -589,6 +652,8 @@ dump_stats()
> chk_csum_nr()
> {
> 	local msg=${1:-""}
> +	local csum_ns1=${2:-0}
> +	local csum_ns2=${3:-0}
> 	local count
> 	local dump_stats
>
> @@ -600,8 +665,8 @@ chk_csum_nr()
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
> @@ -610,8 +675,8 @@ chk_csum_nr()
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
> @@ -690,6 +755,8 @@ chk_join_nr()
> 	local syn_nr=$2
> 	local syn_ack_nr=$3
> 	local ack_nr=$4
> +	local fail_nr=${5:-0}
> +	local infi_nr=${6:-0}
> 	local count
> 	local dump_stats
>
> @@ -726,10 +793,10 @@ chk_join_nr()
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
> @@ -1985,6 +2052,27 @@ userspace_tests()
> 	chk_rm_nr 0 0
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
> +	run_tests $ns1 $ns2 10.0.1.1 2
> +	get_nr_fail 2
> +	chk_join_nr "$nr_fail MP_FAIL, multiple subflows" 2 2 2 $nr_fail
> +
> +	# single subflow
> +	reset_with_fail 1
> +	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> +	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> +	run_tests $ns1 $ns2 10.0.1.1 2
> +	get_nr_fail 1
> +	chk_join_nr "$nr_fail MP_FAIL, single subflow" 0 0 0 $nr_fail $nr_fail
> +}
> +
> all_tests()
> {
> 	subflows_tests
> @@ -2003,6 +2091,7 @@ all_tests()
> 	deny_join_id0_tests
> 	fullmesh_tests
> 	userspace_tests
> +	fail_tests
> }
>
> usage()
> @@ -2024,6 +2113,7 @@ usage()
> 	echo "  -d deny_join_id0_tests"
> 	echo "  -m fullmesh_tests"
> 	echo "  -u userspace_tests"
> +	echo "  -F fail_tests"
> 	echo "  -c capture pcap files"
> 	echo "  -C enable data checksum"
> 	echo "  -h help"
> @@ -2059,7 +2149,7 @@ if [ $do_all_tests -eq 1 ]; then
> 	exit $ret
> fi
>
> -while getopts 'fesltra64bpkdmuchCS' opt; do
> +while getopts 'fesltra64bpkdmuchCSF' opt; do
> 	case $opt in
> 		f)
> 			subflows_tests
> @@ -2109,6 +2199,9 @@ while getopts 'fesltra64bpkdmuchCS' opt; do
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
