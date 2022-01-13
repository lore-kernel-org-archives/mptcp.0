Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892812C80
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 23:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642118266; x=1673654266;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kkGoGZDy0NyGGxuuTTAy4XTJyoTX4cH6EOyNi5TofNk=;
  b=FAalMzrOJqdY1zhJFRj5OpZBi+/hfoQ32ZmzyMpV19g4Os9PeoY1y5mh
   wg3Z9D0nQxz4x6w24zP/5JfuxgTRP80nWpw5MPoWhCmeFuuYfHUy7bg9h
   29ldvyPNH5t84rj3BehyIW5QUQg1DPvIRDRTzsJCEa1AvYoZTXAFFuZQg
   Q+X+O8MRAH94ecFPDV5eTPzCueE7eFRQ+tV5xxpk0s56vapRF0WMQFajV
   8Irlcvk1O7UpB1AIk/C/0dgp9Y1fdNiODRszGSlwQuOyiCfDTbiTWEFyo
   m2D76x6Mp9Y4fgriHxCa3lxELTvuzJ+/mpk3OR9h3ooGSRWXEmxfG4FDy
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="231490827"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="231490827"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 15:57:45 -0800
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="691994489"
Received: from pialybar-mobl.amr.corp.intel.com ([10.212.252.249])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 15:57:45 -0800
Date: Thu, 13 Jan 2022 15:57:45 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] selftests: mptcp: fix ipv6 routing setup
In-Reply-To: <059912660c7f5973da40413a9384bad542047013.1642098123.git.pabeni@redhat.com>
Message-ID: <cfb899a0-96b8-4875-2556-c193d2d3f028@linux.intel.com>
References: <059912660c7f5973da40413a9384bad542047013.1642098123.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 13 Jan 2022, Paolo Abeni wrote:

> MPJ ipv6 selftests currently lack per link route to the server
> net. Additionally, ipv6 subflows endpoints are created without any
> interface specified. The end-result is that in ipv6 self-tests
> subflows are created all on the same link, leading to expected delays
> and sporadic self-tests failures.
>
> Fix the issue by adding the missing setup bits.
>
> Fixes: 523514ed0a99 ("selftests: mptcp: add ADD_ADDR IPv6 test cases")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thanks Paolo, looks good to me:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index e48ce23d2386..2be3cad4b52b 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -76,6 +76,7 @@ init()
>
> 		# let $ns2 reach any $ns1 address from any interface
> 		ip -net "$ns2" route add default via 10.0.$i.1 dev ns2eth$i metric 10$i
> +		ip -net "$ns2" route add default via dead:beef:$i::1 dev ns2eth$i metric 10$i
> 	done
> }
>
> @@ -1510,7 +1511,7 @@ ipv6_tests()
> 	reset
> 	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> 	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> -	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
> +	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 dev ns2eth3 flags subflow
> 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
> 	chk_join_nr "single subflow IPv6" 1 1 1
>
> @@ -1545,7 +1546,7 @@ ipv6_tests()
> 	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> 	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
> 	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
> -	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
> +	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 dev ns2eth3 flags subflow
> 	run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
> 	chk_join_nr "remove subflow and signal IPv6" 2 2 2
> 	chk_add_nr 1 1
> -- 
> 2.33.1
>
>
>

--
Mat Martineau
Intel
