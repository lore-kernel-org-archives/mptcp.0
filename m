Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551267B
	for <mptcp@lists.linux.dev>; Tue, 25 Oct 2022 00:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666656930; x=1698192930;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tHkAof8ZKv5edLODYoOllVQsnKFzOI2q49ceu1mXOuA=;
  b=nE+KlEtEL/h71ceJcblCNz6zIT+iKrN/1WXRlv6I/m95EVikaw/a8W0g
   4FIUWkE9mHzNKrgkbzT+lLWMIAiHT2KLi3Z1cX6gj1HmBI4cQBwRkhN0i
   4/kSXdesW2jNMngRA1BoT2ViLVHuYOSuXeHTHiJkt+wlNVSYJ/WJc3Zma
   B9BGEw5kPRuD5vjdbI9MY6knGQdOKBmwaONVUFjeS5w2nmz8OelaOXLuD
   0R/3N+jbl44ywcgvLnQWK1bDEI4ldBLy4Low+2IzAB0y0A86Sh4THNoSn
   bw0pzwr94BUdM0tWQuG+OxCS5i17spE+DNJbye9hqSzhX9/dN69tVkkJZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="306282246"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="306282246"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 17:15:29 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="633896102"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="633896102"
Received: from mlotfi-mobl.amr.corp.intel.com ([10.212.254.208])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 17:15:28 -0700
Date: Mon, 24 Oct 2022 17:15:27 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] selftests: mptcp: use max_time instead of
 time
In-Reply-To: <20221022133528.31996-1-geliang.tang@suse.com>
Message-ID: <2c99f83f-4e2a-9205-7690-2cdde6f2a335@linux.intel.com>
References: <20221022133528.31996-1-geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Sat, 22 Oct 2022, Geliang Tang wrote:

> 'time' is the local variable of run_test() function, while 'max_time' is
> the local variable of do_transfer() function. So in do_transfer(),
> $max_time should be used, not $time.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

Looks good to me, thanks Geliang:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> ---
> tools/testing/selftests/net/mptcp/simult_flows.sh | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
> index ffa13a957a36..af70c14e0bf9 100755
> --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
> +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
> @@ -173,7 +173,7 @@ do_transfer()
>
> 	timeout ${timeout_test} \
> 		ip netns exec ${ns3} \
> -			./mptcp_connect -jt ${timeout_poll} -l -p $port -T $time \
> +			./mptcp_connect -jt ${timeout_poll} -l -p $port -T $max_time \
> 				0.0.0.0 < "$sin" > "$sout" &
> 	local spid=$!
>
> @@ -181,7 +181,7 @@ do_transfer()
>
> 	timeout ${timeout_test} \
> 		ip netns exec ${ns1} \
> -			./mptcp_connect -jt ${timeout_poll} -p $port -T $time \
> +			./mptcp_connect -jt ${timeout_poll} -p $port -T $max_time \
> 				10.0.3.3 < "$cin" > "$cout" &
> 	local cpid=$!
>
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
