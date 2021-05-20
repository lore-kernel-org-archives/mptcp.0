Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB61D70
	for <mptcp@lists.linux.dev>; Thu, 20 May 2021 22:59:52 +0000 (UTC)
IronPort-SDR: FRIbuSIYJT8MuXXGvT08kzlw7OkO7w4nqqzzR3C2TGCXF8pAwYyjZEi5yAhL9WtRiCJK+WqvqM
 p13XNkSG0ulA==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="262579866"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="262579866"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 15:59:52 -0700
IronPort-SDR: j5O0wqLivTDejhAUftc/bb87ENpkfaO+8SSoHe+qLfg4P3MFQ/eeAowsbbs/jPXctkjfOuBa4I
 X4t+Wqx//IAQ==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="631582655"
Received: from srfejes-mobl4.amr.corp.intel.com ([10.209.82.208])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 15:59:50 -0700
Date: Thu, 20 May 2021 15:59:49 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "selftests: mptcp: add
 deny_join_id0 testcases"
In-Reply-To: <192d32dcf9dc61f93efb4d31c46a4a509f3a9f0f.1621332213.git.geliangtang@gmail.com>
Message-ID: <5ed75887-65b1-3333-dcef-b3f48a93eaca@linux.intel.com>
References: <b49f8eb27abe177f54ea8d7b746ba02003d49682.1621332197.git.geliangtang@gmail.com> <192d32dcf9dc61f93efb4d31c46a4a509f3a9f0f.1621332213.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 18 May 2021, Geliang Tang wrote:

> Update the testcases.
>

Since there are now other changes to v6, please include the selftest 
updates in v7 of the 'c' bit patchset. Thanks.

Mat


> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> .../testing/selftests/net/mptcp/mptcp_join.sh | 35 ++++++++++++++-----
> 1 file changed, 26 insertions(+), 9 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 17b385f011d2..fe46d666b18c 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1491,24 +1491,41 @@ deny_join_id0_tests()
> 	run_tests $ns1 $ns2 10.0.1.1
> 	chk_join_nr "single subflow allow join id0 ns2" 0 0 0
>
> -	# subflow and address allow join id0
> +	# signal address allow join id0 ns1
> +	reset_with_allow_join_id0 1 0
> +	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
> +	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> +	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> +	run_tests $ns1 $ns2 10.0.1.1
> +	chk_join_nr "signal address allow join id0 ns1" 1 1 0
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
> +
> +	# subflow and address allow join id0 ns1
> 	reset_with_allow_join_id0 0 1
> 	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
> 	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
> 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> 	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "subflow and address allow join id0" 2 2 2
> +	chk_join_nr "subflow and address allow join id0 1" 2 2 2
>
> -	# signal address allow join id0
> -	# ADD_ADDRs are not affected by allow_join_id0 value.
> -	reset_with_allow_join_id0 0 0
> -	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
> -	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> +	# subflow and address allow join id0 ns2
> +	reset_with_allow_join_id0 1 0
> +	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
> +	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
> 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> 	run_tests $ns1 $ns2 10.0.1.1
> -	chk_join_nr "signal address allow join id0" 1 1 1
> -	chk_add_nr 1 1
> +	chk_join_nr "subflow and address allow join id0 2" 2 2 1
> }
>
> all_tests()
>

--
Mat Martineau
Intel
