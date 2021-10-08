Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1C32C80
	for <mptcp@lists.linux.dev>; Fri,  8 Oct 2021 22:00:20 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10131"; a="226885406"
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="226885406"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 15:00:16 -0700
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="713930100"
Received: from heechulk-mobl1.amr.corp.intel.com ([10.212.210.175])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 15:00:14 -0700
Date: Fri, 8 Oct 2021 15:00:14 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: increase default max additional subflows
 to 2
In-Reply-To: <b7e5c73d59113afe32eec831b620997c86b56460.1633712415.git.pabeni@redhat.com>
Message-ID: <3d2f774c-7aff-41bb-72fb-8b6838259973@linux.intel.com>
References: <b7e5c73d59113afe32eec831b620997c86b56460.1633712415.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 8 Oct 2021, Paolo Abeni wrote:

> The current default does not allowing additional subflows, mostly
> as a safety restriction to avoid uncontrolled resource consumption
> on busy servers.
>
> Still the system admin and/or the application have to opt-in to
> MPTCP explicitly. After that, they need to change (increase) the
> default maximum number of additional subflows.
>
> Let set that to reasonable default, and make end-users life easier.
>
> Additionally we need to update some self-tests accordingly.
>

Seems like a sensible default to me, one less step for end users to opt-in 
to MPTCP.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/pm_netlink.c                          | 3 +++
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 ++++-
> tools/testing/selftests/net/mptcp/pm_netlink.sh | 6 +++---
> 3 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 050eea231528..f7d33a9abd57 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -2052,6 +2052,9 @@ static int __net_init pm_nl_init_net(struct net *net)
> 	struct pm_nl_pernet *pernet = net_generic(net, pm_nl_pernet_id);
>
> 	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
> +
> +	/* Cit. 2 subflows ought to be enough for anybody. */

I had to google 'Cit.', and now know one more Italian word :)
(no need to change it!)

> +	pernet->subflows_max = 2;
> 	pernet->next_id = 1;
> 	pernet->stale_loss_cnt = 4;
> 	spin_lock_init(&pernet->lock);
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 255793c5ac4f..293d349e21fe 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -945,12 +945,15 @@ subflows_tests()
>
> 	# subflow limited by client
> 	reset
> +	ip netns exec $ns1 ./pm_nl_ctl limits 0 0
> +	ip netns exec $ns2 ./pm_nl_ctl limits 0 0
> 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> 	run_tests $ns1 $ns2 10.0.1.1
> 	chk_join_nr "single subflow, limited by client" 0 0 0
>
> 	# subflow limited by server
> 	reset
> +	ip netns exec $ns1 ./pm_nl_ctl limits 0 0
> 	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> 	run_tests $ns1 $ns2 10.0.1.1
> @@ -973,7 +976,7 @@ subflows_tests()
> 	run_tests $ns1 $ns2 10.0.1.1
> 	chk_join_nr "multiple subflows" 2 2 2
>
> -	# multiple subflows limited by serverf
> +	# multiple subflows limited by server
> 	reset
> 	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> 	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> index 3c741abe034e..cbacf9f6538b 100755
> --- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
> +++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> @@ -70,7 +70,7 @@ check()
>
> check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "defaults addr list"
> check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
> -subflows 0" "defaults limits"
> +subflows 2" "defaults limits"
>
> ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
> ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2 flags subflow dev lo
> @@ -118,11 +118,11 @@ check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
>
> ip netns exec $ns1 ./pm_nl_ctl limits 9 1
> check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
> -subflows 0" "rcv addrs above hard limit"
> +subflows 2" "rcv addrs above hard limit"
>
> ip netns exec $ns1 ./pm_nl_ctl limits 1 9
> check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
> -subflows 0" "subflows above hard limit"
> +subflows 2" "subflows above hard limit"
>
> ip netns exec $ns1 ./pm_nl_ctl limits 8 8
> check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 8
> -- 
> 2.26.3
>
>
>

--
Mat Martineau
Intel
