Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968502C80
	for <mptcp@lists.linux.dev>; Tue, 19 Oct 2021 00:50:34 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="215561689"
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="scan'208";a="215561689"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 17:50:33 -0700
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="scan'208";a="629404760"
Received: from phamal-mobl.amr.corp.intel.com ([10.252.131.17])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 17:50:33 -0700
Date: Mon, 18 Oct 2021 17:50:32 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v7 8/8] DO-NOT-MERGE: mptcp: mp_fail test
In-Reply-To: <2e9a15d32cd39483dd1e18174d6c73b33e0566b5.1634531093.git.geliang.tang@suse.com>
Message-ID: <7e1c37e5-a636-68f1-aaa-329f951b2c55@linux.intel.com>
References: <cover.1634531093.git.geliang.tang@suse.com> <2e9a15d32cd39483dd1e18174d6c73b33e0566b5.1634531093.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 18 Oct 2021, Geliang Tang wrote:

> ./mptcp_join.sh -Cf

When I tried running this as './mptcp_join.sh -Cfc', I'm not seeing 
fallback in the packet trace (no data level len == 0, and the packets all 
have DSS headers until disconnect). Is the test working on your system?

Also, I know that you had asked about other ways to intentionally corrupt 
the checksum that would be ok to merge. Do you still need more information 
on that?

Mat

>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c                           |  9 +++++++++
> .../testing/selftests/net/mptcp/mptcp_join.sh  | 18 ++++++++++++++++++
> 2 files changed, 27 insertions(+)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2283efda1bc9..fc3a4fb81fbb 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1243,6 +1243,8 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk,
> 	__mptcp_do_fallback(msk);
> }
>
> +static int j;
> +
> static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> 			      struct mptcp_data_frag *dfrag,
> 			      struct mptcp_sendmsg_info *info)
> @@ -1377,6 +1379,13 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> 		mptcp_update_data_checksum(skb, copy);
> 	if (mptcp_subflow_ctx(ssk)->send_infinite_map)
> 		mptcp_update_infinite_map(msk, ssk, mpext);
> +
> +	pr_debug("%s j=%d", __func__, j++);
> +	if (j == 20)
> +		skb->data_len = 1;
> +	if (j > 40)
> +		j = 0;
> +
> 	mptcp_subflow_ctx(ssk)->rel_write_seq += copy;
> 	return copy;
> }
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index b3b351b868f9..3339633e87d4 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -977,6 +977,24 @@ chk_link_usage()
>
> subflows_tests()
> {
> +	# 1 subflow
> +	reset
> +	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> +	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> +	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> +	chk_join_nr "1 subflow" 0 0 0
> +
> +	exit
> +
> +	# multiple subflows
> +	reset
> +	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> +	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
> +	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> +	chk_join_nr "multiple subflows" 2 2 2
> +
> 	reset
> 	run_tests $ns1 $ns2 10.0.1.1
> 	chk_join_nr "no JOIN" "0" "0" "0"
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
