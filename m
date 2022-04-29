Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5271851
	for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 17:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651254045; x=1682790045;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=P8JyNkPop4yzFDpQZpjdwW574ONMyJGg7grIq8pRkHU=;
  b=S3sJ2g5We/V2Pfv6aolPL0WB5uOtNHCcjM20UtFKpZZhV7+zow6N3hzU
   9lwEiXfDapsMKr8mkgsn5QlS5KFPQEgUoPYLCTXvij47PofaSceK5agMg
   AvnFhbluONvcqRBcrzsWy8RN0QiE4Tmb4Jl94De4pOb+g9KNfs0S0Ez4J
   MJiggMHSKJnwBzABQl+yoDpb162DVA2FLqHSGAnPLzPCDic5XrFXpYY64
   sT4y24SgU66CcdgeZ/7NzpAW7jx9mw3VQQrRY007+yZs1pMp0cfzGTWlR
   Z/AYyWe8U/jxJ7b45j7tkR3CmK4uZSwaoWQ3KF/UdlFbYzq4KlydVk4eA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="266257138"
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="266257138"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 10:34:53 -0700
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="542712630"
Received: from mdbellow-mobl.amr.corp.intel.com ([10.209.122.4])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 10:34:53 -0700
Date: Fri, 29 Apr 2022 10:34:52 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] selftests: mptcp: fix MP_FAIL test-case
In-Reply-To: <a4e7a052279a027da6721d59dbd293b0bb7e08cf.1651248223.git.pabeni@redhat.com>
Message-ID: <ba957191-f8e9-6dcb-ce1f-c821b135bf9@linux.intel.com>
References: <a4e7a052279a027da6721d59dbd293b0bb7e08cf.1651248223.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 29 Apr 2022, Paolo Abeni wrote:

> The mentioned tests sometimes fails because the data
> transfer completes before any packet is sent on the 2nd
> link (the failing one).
>
> Address the issue reducing the "virtual" b/w available
> on the primary link.
>
> Fixes: bfd4cdbe7032 ("selftests: mptcp: add MP_FAIL reset testcase")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> together with the previous patch this fixes issues/265 for
> good here. I'm not adding the Close tag due to the mentioned
> dep, which may take a different/longer route
> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index a98fee834950..0d65295c1b33 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2734,7 +2734,7 @@ fail_tests()
>
> 	# multiple subflows
> 	if reset_with_fail "MP_FAIL MP_RST" 2; then
> -		tc -n $ns2 qdisc add dev ns2eth1 root netem rate 20mbit delay 1
> +		tc -n $ns2 qdisc add dev ns2eth1 root netem rate 10mbit delay 5
> 		pm_nl_set_limits $ns1 0 1
> 		pm_nl_set_limits $ns2 0 1
> 		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
> -- 
> 2.35.1
>
>
>

I'm assuming this patch is supposed to be tagged for mptcp-next, since 
fail_tests() is not in the net branch?


--
Mat Martineau
Intel
