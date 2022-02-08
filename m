Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7872F23
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 01:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644282095; x=1675818095;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=8T9LYYQ0qN4priGncctv/rH20y6utCLQSrVi4PDQL+c=;
  b=MvJDpkGG9s9OMlFSaegriwSdNwuiEYDNCP4NQTlWdIrfswpI+jYmhshw
   AKFbEzdXj3kSkhwXTzLxGtJ6w4onkd+hLhDxysiejVz1UJ9/IEIrzIdnZ
   kwRUKZUFQmi8ZH2yQ7kcEFN4U/x3VzqZ4qXJYiZ9RZmxvKBIc+GuaDO05
   AtX4g3GME4xHI8MMTUCQQt8fuGH6YmeTVEM1wXTimW/F9aBWFIvcAQEk/
   Pkfa4ohX4/QCSa+WuO/tdFZ3hPb8ZXFQmB7hIZ7cS5K6a/eQVX7NyM9DI
   lCNo+jhjg1ppeH4cD+TKzZk05aWqGLi4jrQ8WNVWNtf9OSUKh7vfmQeU/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="248791950"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="248791950"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 17:01:35 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="677943165"
Received: from ngoyal-mobl1.amr.corp.intel.com ([10.251.4.190])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 17:01:34 -0800
Date: Mon, 7 Feb 2022 17:01:34 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] selftests: mptcp: adjust output alignment
 for more tests
In-Reply-To: <9ecd5de1df130bc1d5cc65de7c940ea546cf4eaf.1644214533.git.geliang.tang@suse.com>
Message-ID: <4c231d6b-5a77-1027-b8e2-40caf152ab8d@linux.intel.com>
References: <9ecd5de1df130bc1d5cc65de7c940ea546cf4eaf.1644214533.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 7 Feb 2022, Geliang Tang wrote:

> The number of self tests in mptcp_join.sh will soon be more than 100, the
> output alignment is no longer OK. This patch adjusted it.
>

Good idea, thanks.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> .../testing/selftests/net/mptcp/mptcp_join.sh | 25 ++++++++++---------
> 1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 007223364718..2ddb373b7c1d 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -20,6 +20,7 @@ check_invert=0
> do_all_tests=1
>
> TEST_COUNT=0
> +nr_blank=40
>
> # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
> #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
> @@ -743,9 +744,9 @@ chk_csum_nr()
> 	local dump_stats
>
> 	if [ ! -z "$msg" ]; then
> -		printf "%02u" "$TEST_COUNT"
> +		printf "%03u" "$TEST_COUNT"
> 	else
> -		echo -n "  "
> +		echo -n "   "
> 	fi
> 	printf " %-36s %s" "$msg" "sum"
> 	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
> @@ -777,7 +778,7 @@ chk_fail_nr()
> 	local count
> 	local dump_stats
>
> -	printf "%-39s %s" " " "ftx"
> +	printf "%-${nr_blank}s %s" " " "ftx"
> 	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailTx | awk '{print $2}'`
> 	[ -z "$count" ] && count=0
> 	if [ "$count" != "$mp_fail_nr_tx" ]; then
> @@ -809,7 +810,7 @@ chk_infi_nr()
> 	local count
> 	local dump_stats
>
> -	printf "%-39s %s" " " "itx"
> +	printf "%-${nr_blank}s %s" " " "itx"
> 	count=`ip netns exec $ns2 nstat -as | grep InfiniteMapTx | awk '{print $2}'`
> 	[ -z "$count" ] && count=0
> 	if [ "$count" != "$mp_infi_nr_tx" ]; then
> @@ -843,7 +844,7 @@ chk_join_nr()
> 	local count
> 	local dump_stats
>
> -	printf "%02u %-36s %s" "$TEST_COUNT" "$msg" "syn"
> +	printf "%03u %-36s %s" "$TEST_COUNT" "$msg" "syn"
> 	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinSynRx | awk '{print $2}'`
> 	[ -z "$count" ] && count=0
> 	if [ "$count" != "$syn_nr" ]; then
> @@ -898,7 +899,7 @@ chk_stale_nr()
> 	local stale_nr
> 	local recover_nr
>
> -	printf "%-39s %-18s" " " "stale"
> +	printf "%-${nr_blank}s %-18s" " " "stale"
> 	stale_nr=`ip netns exec $ns nstat -as | grep MPTcpExtSubflowStale | awk '{print $2}'`
> 	[ -z "$stale_nr" ] && stale_nr=0
> 	recover_nr=`ip netns exec $ns nstat -as | grep MPTcpExtSubflowRecover | awk '{print $2}'`
> @@ -936,7 +937,7 @@ chk_add_nr()
> 	local count
> 	local dump_stats
>
> -	printf "%-39s %s" " " "add"
> +	printf "%-${nr_blank}s %s" " " "add"
> 	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtAddAddr | awk '{print $2}'`
> 	[ -z "$count" ] && count=0
> 	if [ "$count" != "$add_nr" ]; then
> @@ -970,7 +971,7 @@ chk_add_nr()
> 			echo "[ ok ]"
> 		fi
>
> -		printf "%-39s %s" " " "syn"
> +		printf "%-${nr_blank}s %s" " " "syn"
> 		count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortSynRx |
> 			awk '{print $2}'`
> 		[ -z "$count" ] && count=0
> @@ -1009,7 +1010,7 @@ chk_add_nr()
> 			echo "[ ok ]"
> 		fi
>
> -		printf "%-39s %s" " " "syn"
> +		printf "%-${nr_blank}s %s" " " "syn"
> 		count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortSynRx |
> 			awk '{print $2}'`
> 		[ -z "$count" ] && count=0
> @@ -1059,7 +1060,7 @@ chk_rm_nr()
> 		subflow_ns=$ns1
> 	fi
>
> -	printf "%-39s %s" " " "rm "
> +	printf "%-${nr_blank}s %s" " " "rm "
> 	count=`ip netns exec $addr_ns nstat -as | grep MPTcpExtRmAddr | awk '{print $2}'`
> 	[ -z "$count" ] && count=0
> 	if [ "$count" != "$rm_addr_nr" ]; then
> @@ -1091,7 +1092,7 @@ chk_prio_nr()
> 	local count
> 	local dump_stats
>
> -	printf "%-39s %s" " " "ptx"
> +	printf "%-${nr_blank}s %s" " " "ptx"
> 	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioTx | awk '{print $2}'`
> 	[ -z "$count" ] && count=0
> 	if [ "$count" != "$mp_prio_nr_tx" ]; then
> @@ -1127,7 +1128,7 @@ chk_link_usage()
> 	local tx_rate=$((tx_link * 100 / $tx_total))
> 	local tolerance=5
>
> -	printf "%-39s %-18s" " " "link usage"
> +	printf "%-${nr_blank}s %-18s" " " "link usage"
> 	if [ $tx_rate -lt $((expected_rate - $tolerance)) -o \
> 	     $tx_rate -gt $((expected_rate + $tolerance)) ]; then
> 		echo "[fail] got $tx_rate% usage, expected $expected_rate%"
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
