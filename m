Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE8E2C9D
	for <mptcp@lists.linux.dev>; Fri, 17 Dec 2021 23:54:49 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="239668574"
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="239668574"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 15:54:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="465293585"
Received: from jasanch5-mobl1.amr.corp.intel.com ([10.212.247.3])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 15:54:48 -0800
Date: Fri, 17 Dec 2021 15:54:48 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add tests for
 subflow creation failure"
In-Reply-To: <82bd312f4f8ada4709d1a0d8525f1491006ec866.1639723286.git.geliang.tang@suse.com>
Message-ID: <0a31271-11c8-1218-9ad-a578b2a2cf33@linux.intel.com>
References: <82bd312f4f8ada4709d1a0d8525f1491006ec866.1639723286.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 17 Dec 2021, Geliang Tang wrote:

> Align the output logs with others.
>
> 01 no MPC address reuse with single endpoint syn[ ok ] - synack[ ok ] - ack[ ok ]
> 02 multiple subflows, with failing subflow syn[ ok ] - synack[ ok ] - ack[ ok ]
> 03 multiple subflows, with subflow timeout syn[ ok ] - synack[ ok ] - ack[ ok ]
> 04 multiple subflows, fair usage on close syn[ ok ] - synack[ ok ] - ack[ ok ]
> 05 no JOIN                              syn[ ok ] - synack[ ok ] - ack[ ok ]
> 06 single subflow, limited by client    syn[ ok ] - synack[ ok ] - ack[ ok ]
> 07 single subflow, limited by server    syn[ ok ] - synack[ ok ] - ack[ ok ]
> 08 single subflow                       syn[ ok ] - synack[ ok ] - ack[ ok ]
> 09 multiple subflows                    syn[ ok ] - synack[ ok ] - ack[ ok ]
> 10 multiple subflows, limited by server syn[ ok ] - synack[ ok ] - ack[ ok ]
> 11 single subflow, dev                  syn[ ok ] - synack[ ok ] - ack[ ok ]
>
> ->
>
> 01 no MPC reuse with single endpoint    syn[ ok ] - synack[ ok ] - ack[ ok ]
> 02 multi subflows, with failing subflow syn[ ok ] - synack[ ok ] - ack[ ok ]
> 03 multi subflows, with subflow timeout syn[ ok ] - synack[ ok ] - ack[ ok ]
> 04 multi subflows, fair usage on close  syn[ ok ] - synack[ ok ] - ack[ ok ]
> 05 no JOIN                              syn[ ok ] - synack[ ok ] - ack[ ok ]
> 06 single subflow, limited by client    syn[ ok ] - synack[ ok ] - ack[ ok ]
> 07 single subflow, limited by server    syn[ ok ] - synack[ ok ] - ack[ ok ]
> 08 single subflow                       syn[ ok ] - synack[ ok ] - ack[ ok ]
> 09 multiple subflows                    syn[ ok ] - synack[ ok ] - ack[ ok ]
> 10 multiple subflows, limited by server syn[ ok ] - synack[ ok ] - ack[ ok ]
> 11 single subflow, dev                  syn[ ok ] - synack[ ok ] - ack[ ok ]
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

Looks good to me, thanks:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index d70621700281..e48ce23d2386 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1069,7 +1069,7 @@ subflows_error_tests()
> 	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.1.2 flags subflow
> 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> -	chk_join_nr "no MPC address reuse with single endpoint" 0 0 0
> +	chk_join_nr "no MPC reuse with single endpoint" 0 0 0
>
> 	# multiple subflows, with subflow creation error
> 	reset
> @@ -1079,7 +1079,7 @@ subflows_error_tests()
> 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
> 	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
> 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> -	chk_join_nr "multiple subflows, with failing subflow" 1 1 1
> +	chk_join_nr "multi subflows, with failing subflow" 1 1 1
>
> 	# multiple subflows, with subflow timeout on MPJ
> 	reset
> @@ -1089,7 +1089,7 @@ subflows_error_tests()
> 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
> 	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j DROP
> 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> -	chk_join_nr "multiple subflows, with subflow timeout" 1 1 1
> +	chk_join_nr "multi subflows, with subflow timeout" 1 1 1
>
> 	# multiple subflows, check that the endpoint corresponding to
> 	# closed subflow (due to reset) is not reused if additional
> @@ -1112,7 +1112,7 @@ subflows_error_tests()
>
> 	# additional subflow could be created only if the PM select
> 	# the later endpoint, skipping the already used one
> -	chk_join_nr "multiple subflows, fair usage on close" 1 1 1
> +	chk_join_nr "multi subflows, fair usage on close" 1 1 1
> }
>
> signal_address_tests()
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
