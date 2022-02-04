Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934892C9C
	for <mptcp@lists.linux.dev>; Fri,  4 Feb 2022 23:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644016978; x=1675552978;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yiGyCK8Y169ZZarfVYZuvtzSuwLMsHd4t7mDPNyYEY8=;
  b=FzKyRUoxj4zvEvsIgdh3E60o/Sv4ojMZ8oirdmSqTX2gaf3RyjivxlBx
   fxYuZ7oTPZSVGX/PmRAj2Ojmt6LdLsbUDEomUg6VtGkP07+P/Zxl/nmEW
   pdnq7q9f+64PcoD6SARNs+E8odl+OUk9lga3y4Hs+1p56warxgXs0spE4
   cF2eh3puE35j1bK4S3RtHxuGxlhcJeLd3q0CBPtNv007AS+mIq1L2nvUQ
   g9wpVFizYbGMrKoj7eykdQGtvVRFhvzx21eBsDH7d70Cgd8xVeFkSV/We
   uUUuKQ6q+G1t3/A2QaRZ7ducpHYyAg62Kc/YOopVdU0frYFmwICHUnIn9
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="311760514"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="311760514"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 15:22:58 -0800
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="627923135"
Received: from ktahomi-mobl3.amr.corp.intel.com ([10.209.88.47])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 15:22:57 -0800
Date: Fri, 4 Feb 2022 15:22:57 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] selftests: mptcp: improve 'fair usage on
 close' stability
In-Reply-To: <eb310fd3bdfe3315ff17ebb865fd2f1e2957fd02.1643999595.git.pabeni@redhat.com>
Message-ID: <bc26deac-c754-77fa-f591-5ba39ff3983@linux.intel.com>
References: <eb310fd3bdfe3315ff17ebb865fd2f1e2957fd02.1643999595.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 4 Feb 2022, Paolo Abeni wrote:

> The mentioned tests has to wait for a subflow creation failure.
> The current code looks for TCP sockets in TW state and sometimes
> misses the relevant event. Switch to a more stable check, looking
> for the associated mib counter.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/257
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>

Looks good for the export branch, test passes consistenly on my vm with 
this change (although I was not seeing the failure frequently).

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 67be3e1215d7..556da9481730 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1137,14 +1137,14 @@ chk_link_usage()
> 	fi
> }
>
> -wait_for_tw()
> +wait_attempt_fail()
> {
> 	local timeout_ms=$((timeout_poll * 1000))
> 	local time=0
> 	local ns=$1
>
> 	while [ $time -lt $timeout_ms ]; do
> -		local cnt=$(ip netns exec $ns ss -t state time-wait |wc -l)
> +		local cnt=$(ip netns exec $ns nstat -as TcpAttemptFails | grep TcpAttemptFails | awk '{print $2}')
>
> 		[ "$cnt" = 1 ] && return 1
> 		time=$((time + 100))
> @@ -1256,7 +1256,7 @@ subflows_error_tests()
> 	TEST_COUNT=$((TEST_COUNT+1))
>
> 	# mpj subflow will be in TW after the reset
> -	wait_for_tw $ns2
> +	wait_attempt_fail $ns2
> 	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
> 	wait
>
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
