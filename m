Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7E01164
	for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 01:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644889315; x=1676425315;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=AlStT0fC4X5xVzpL0QdYk/Cxsp7Y9xDSphdmrzsvrkA=;
  b=jl8MGNjGbYZ8XnxIub0LfNpFEuWtMADbVlt7Zo2dMU3JPk7a0S6eul/6
   U8p2hrSSW5iddzcq9XkvNiPi+I4z2n9rAcbWr+Eo6k/8+kTTSRW8CBtEe
   RhLAIyD8Ox4sXTCroUGusSNx7s9lVAYTnwS8KV4vu1/zpmr7EtyCJm+6J
   psI0X952dBMYH11hYVYX2BExUBFotECNtE4NF5zuo3JClsWf+451xskXK
   aktFruqNwSR2csYRIJOyY9zFaxjuS870SmIo9n/D6QkCCj0aPYc5r9x2n
   yckfzzgKlHw3OV0zuNriZMTSZEvRHZdQOh79VYhYu4yWw4cuU78AROk3+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="250173054"
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="250173054"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 17:41:55 -0800
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="528547647"
Received: from mdogangu-mobl.amr.corp.intel.com ([10.212.199.167])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 17:41:54 -0800
Date: Mon, 14 Feb 2022 17:41:54 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2] selftests: mptcp: add csum mib check for
 mptcp_connect
In-Reply-To: <068c6ecb38fae8a5c0a67097b6a8c86896a27675.1644763024.git.geliang.tang@suse.com>
Message-ID: <2f3426e7-73e9-f8db-f75d-66eac0de7f64@linux.intel.com>
References: <068c6ecb38fae8a5c0a67097b6a8c86896a27675.1644763024.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Sun, 13 Feb 2022, Geliang Tang wrote:

> This patch added the data checksum error mib counters check for the
> script mptcp_connect.sh when the data checksum is enabled.
>
> In do_transfer(), got the mib counters twice, before and after running
> the mptcp_connect commands. The latter minus the former is the actual
> number of the data checksum mib counter.
>
> The output looks like this:
>
> ns1 MPTCP -> ns2 (dead:beef:1::2:10007) MPTCP   (duration    86ms) [ OK ]
> ns1 MPTCP -> ns2 (10.0.2.1:10008      ) MPTCP   (duration    66ms) [ FAIL ]
> server got 1 data checksum error[s]
>
> Fixes: 94d66ba1d8e48 ("selftests: mptcp: enable checksum in mptcp_connect.sh")
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> v2:
> - get mib counters twice.
> - Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/255

Looks good to me.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> ---
> .../selftests/net/mptcp/mptcp_connect.sh      | 19 +++++++++++++++++++
> 1 file changed, 19 insertions(+)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index cb5809b89081..5b7a40d73253 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -432,6 +432,8 @@ do_transfer()
> 	local stat_ackrx_last_l=$(get_mib_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
> 	local stat_cookietx_last=$(get_mib_counter "${listener_ns}" "TcpExtSyncookiesSent")
> 	local stat_cookierx_last=$(get_mib_counter "${listener_ns}" "TcpExtSyncookiesRecv")
> +	local stat_csum_err_s=$(get_mib_counter "${listener_ns}" "MPTcpExtDataCsumErr")
> +	local stat_csum_err_c=$(get_mib_counter "${connector_ns}" "MPTcpExtDataCsumErr")
>
> 	timeout ${timeout_test} \
> 		ip netns exec ${listener_ns} \
> @@ -524,6 +526,23 @@ do_transfer()
> 		fi
> 	fi
>
> +	if $checksum; then
> +		local csum_err_s=$(get_mib_counter "${listener_ns}" "MPTcpExtDataCsumErr")
> +		local csum_err_c=$(get_mib_counter "${connector_ns}" "MPTcpExtDataCsumErr")
> +
> +		local csum_err_s_nr=$((csum_err_s - stat_csum_err_s))
> +		if [ $csum_err_s_nr -gt 0 ]; then
> +			printf "[ FAIL ]\nserver got $csum_err_s_nr data checksum error[s]"
> +			rets=1
> +		fi
> +
> +		local csum_err_c_nr=$((csum_err_c - stat_csum_err_c))
> +		if [ $csum_err_c_nr -gt 0 ]; then
> +			printf "[ FAIL ]\nclient got $csum_err_c_nr data checksum error[s]"
> +			retc=1
> +		fi
> +	fi
> +
> 	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
> 		printf "[ OK ]"
> 	fi
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
