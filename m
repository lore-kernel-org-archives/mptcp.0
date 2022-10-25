Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C8B7B
	for <mptcp@lists.linux.dev>; Tue, 25 Oct 2022 00:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666656710; x=1698192710;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bZpNM8Xv+GL11ycOohk3jO2krdAHuw6mmY6HJ95uI1g=;
  b=Ve9GtuTl1zGl9AfSOo4uhabuPuapMXFsbdpesqij9PioTDons07pDllx
   jOtzmUgbmKx/z/gf4oCogZDb63xzFFQ0oiwkI1+2eBI2s48x04WnveV6y
   d24OQy9WVcjrzNJARCb7YRBfbB/svtjLKjtdAjyVpnLF3kMObL0SOmNOH
   17b7EREO1QPaJiNci+84yKs4lQpI9gZZ3RtlS2vVYTlSlacI9umeBhh6w
   vjvtjrKBAYDmdfcyJc2OGeZEXrY4br2mWVqrSLdBm2pnzWnuMnD9TQUhM
   ox+P942LVRxoS3EiEb0TJXiDzHHB4BiSQ1GEoZaGONYYh9hPAu3esJfOd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="287948267"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="287948267"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 17:11:37 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="662610299"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="662610299"
Received: from mlotfi-mobl.amr.corp.intel.com ([10.212.254.208])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 17:11:36 -0700
Date: Mon, 24 Oct 2022 17:11:36 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] selftests: mptcp: gives slow test-case more
 time
In-Reply-To: <680973297b6995126f49732c0828ccfce8865c72.1666628806.git.pabeni@redhat.com>
Message-ID: <690a5b2d-6bb6-9d28-e2dc-6841021aaa70@linux.intel.com>
References: <680973297b6995126f49732c0828ccfce8865c72.1666628806.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 24 Oct 2022, Paolo Abeni wrote:

> On slow or busy VM, some test-cases still fail because the
> data transfer completes before the endpoint manipulation
> actually took effect.
>
> Address the issue by artificially increasing the runtime for
> the relevant test-cases.
>
> Fixes: ef360019db40 ("selftests: mptcp: signal addresses testcases")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/309
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index f3dd5f2a0272..2eeaf4aca644 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2152,7 +2152,7 @@ remove_tests()
> 		pm_nl_set_limits $ns2 1 3
> 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
> -		run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 slow
> +		run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 speed_10
> 		chk_join_nr 3 3 3
> 		chk_add_nr 1 1
> 		chk_rm_nr 2 2
> @@ -2165,7 +2165,7 @@ remove_tests()
> 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
> 		pm_nl_set_limits $ns2 3 3
> -		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
> +		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 speed_10
> 		chk_join_nr 3 3 3
> 		chk_add_nr 3 3
> 		chk_rm_nr 3 3 invert
> @@ -2178,7 +2178,7 @@ remove_tests()
> 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
> 		pm_nl_set_limits $ns2 3 3
> -		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
> +		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 speed_10
> 		chk_join_nr 1 1 1
> 		chk_add_nr 3 3
> 		chk_rm_nr 3 1 invert
> -- 
> 2.37.3

Looks good to me:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Do you want me to get this in to the export branch soon, or should we 
leave it queued for Matthieu?


--
Mat Martineau
Intel
