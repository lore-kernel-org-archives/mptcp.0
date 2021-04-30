Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A307E71
	for <mptcp@lists.linux.dev>; Fri, 30 Apr 2021 01:41:30 +0000 (UTC)
IronPort-SDR: 9G2NVakTjU9Bedbf0mgv+bAyOw+sOTTMLxH4/3pdXL8ImgEWXRWRufrk/L6JKkasz/4N2aLhXy
 5Q4cAWQLpsng==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="197267535"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="197267535"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 18:41:29 -0700
IronPort-SDR: xtLY68sKMXQfIa7dEDRD/WVpGzkR7NC50qs3CBycPnNh5C92POGPeX8QlBFCOj72AxpCAjDeOb
 Bo+cGSobdZHw==
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="404396107"
Received: from rbidari-mobl1.amr.corp.intel.com ([10.254.72.16])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 18:41:29 -0700
Date: Thu, 29 Apr 2021 18:41:29 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH v3 mptcp-next 4/4] selftests: mptcp: add deny_join_id0
 testcases
In-Reply-To: <27fb0c4de87cc7e2c1d015538fa6bd5d95e9ac6b.1619623735.git.geliangtang@gmail.com>
Message-ID: <6f34c289-fba6-5be0-51cb-e41e5834157e@linux.intel.com>
References: <cover.1619623735.git.geliangtang@gmail.com> <952b920c38ab98adfdb77a0e941ff43c05461a0d.1619623735.git.geliangtang@gmail.com> <972a77ea8b999cd2e0f8e32912156d5ac4b9a17e.1619623735.git.geliangtang@gmail.com>
 <45fac7966d2bfeae3027a9105ba9a6a2f35d6029.1619623735.git.geliangtang@gmail.com> <27fb0c4de87cc7e2c1d015538fa6bd5d95e9ac6b.1619623735.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 28 Apr 2021, Geliang Tang wrote:

> This patch added a new argument '-d' for mptcp_join.sh script, to invoke
> the testcases for the MP_CAPABLE 'C' flag.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> .../testing/selftests/net/mptcp/mptcp_join.sh | 55 ++++++++++++++++++-
> 1 file changed, 54 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index fd99485cf2a4..feabc3ab88eb 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -124,6 +124,17 @@ reset_with_add_addr_timeout()
> 		-j DROP
> }
>
> +reset_with_allow_join_id0()
> +{
> +	local ns1_enable=$1
> +	local ns2_enable=$2
> +
> +	reset
> +
> +	ip netns exec $ns1 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns1_enable
> +	ip netns exec $ns2 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns2_enable
> +}
> +
> ip -Version > /dev/null 2>&1
> if [ $? -ne 0 ];then
> 	echo "SKIP: Could not run test without ip tool"
> @@ -1374,6 +1385,43 @@ syncookies_tests()
> 	chk_add_nr 1 1
> }
>
> +deny_join_id0_tests()
> +{
> +	# subflow allow join id0 ns1
> +	reset_with_allow_join_id0 1 0
> +	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
> +	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> +	run_tests $ns1 $ns2 10.0.1.1
> +	chk_join_nr "single subflow allow join id0 ns1" 1 1 1
> +
> +	# subflow allow join id0 ns2
> +	reset_with_allow_join_id0 0 1
> +	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
> +	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> +	run_tests $ns1 $ns2 10.0.1.1
> +	chk_join_nr "single subflow allow join id0 ns2" 0 0 0
> +
> +	# signal address allow join id0 ns1
> +	reset_with_allow_join_id0 1 0
> +	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
> +	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> +	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> +	run_tests $ns1 $ns2 10.0.1.1
> +	chk_join_nr "signal address allow join id0 ns1" 1 1 1
> +	chk_add_nr 1 1
> +
> +	# signal address allow join id0 ns2
> +	reset_with_allow_join_id0 0 1
> +	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
> +	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> +	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> +	run_tests $ns1 $ns2 10.0.1.1
> +	chk_join_nr "signal address allow join id0 ns2" 1 1 1
> +	chk_add_nr 1 1

Could you explain more what the last two tests are intended to check? They 
seem to have the same expected results.

I also experimented with adding a 5th test using 
"reset_with_allow_join_id0 1 1" and that had the same results - the only 
variation was the setting of the 'C' flag in the SYN / SYNACK packets when 
I looked at the pcaps. The different enable settings didn't seem to change 
anything for chk_join_nr or chk_add_nr.


- Mat


> +}
> +
> all_tests()
> {
> 	subflows_tests
> @@ -1387,6 +1435,7 @@ all_tests()
> 	backup_tests
> 	add_addr_ports_tests
> 	syncookies_tests
> +	deny_join_id0_tests
> }
>
> usage()
> @@ -1403,6 +1452,7 @@ usage()
> 	echo "  -b backup_tests"
> 	echo "  -p add_addr_ports_tests"
> 	echo "  -k syncookies_tests"
> +	echo "  -d deny_join_id0_tests"
> 	echo "  -c capture pcap files"
> 	echo "  -h help"
> }
> @@ -1434,7 +1484,7 @@ if [ $do_all_tests -eq 1 ]; then
> 	exit $ret
> fi
>
> -while getopts 'fsltra64bpkch' opt; do
> +while getopts 'fsltra64bpkdch' opt; do
> 	case $opt in
> 		f)
> 			subflows_tests
> @@ -1469,6 +1519,9 @@ while getopts 'fsltra64bpkch' opt; do
> 		k)
> 			syncookies_tests
> 			;;
> +		d)
> +			deny_join_id0_tests
> +			;;
> 		c)
> 			;;
> 		h | *)
> -- 
> 2.30.2
>
>
>

--
Mat Martineau
Intel
