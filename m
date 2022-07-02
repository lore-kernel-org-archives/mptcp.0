Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00319110C
	for <mptcp@lists.linux.dev>; Sat,  2 Jul 2022 00:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656720802; x=1688256802;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7oAktyJ4xTFdCmcXVJauRHFLOiulC3qanFHvSb8/RF0=;
  b=nmP93T7EgaSJiHQD10eynEDD/ofHbjIu9M+svBQpgJOBS45+Sx4fVyEJ
   G2cAk6eLcA4jBJYZAXr4Ft5DRxYnq8uP+3ZtMxrJkEJ3oF8lv7+n8TBex
   erIKM3oFIxuFo4wpE/fibkTrLRWdQNFarmX5MlJ5dXH9nLMu1RKDwLBff
   ZSWEfaoOV6pa6XpN1gJ5+HR1IuZpsS+U08wqLzcYgdFxxKiGrEH3/zL/5
   BLZtNEKeGoDsyBRni5GOs99cFqRP/+DTfBol42gqWbsGVcXYe0e6zoT97
   3o2KNUDL/Y7YGhar0mLJEYQ01dnkK+WCj+azSddfX08VO7bpfBmOAYVxj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="265801065"
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="265801065"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 17:13:22 -0700
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="659603314"
Received: from shubhaml-mobl.amr.corp.intel.com ([10.255.229.171])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 17:13:21 -0700
Date: Fri, 1 Jul 2022 17:13:21 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 2/6]  mptcp: introduce and use
 mptcp_pm_send_ack()
In-Reply-To: <6de116ad2229ddd1c557fca592b9c56fd2836823.1656669391.git.pabeni@redhat.com>
Message-ID: <e12db843-9a-64d2-4d4e-ef14655354ab@linux.intel.com>
References: <cover.1656669391.git.pabeni@redhat.com> <6de116ad2229ddd1c557fca592b9c56fd2836823.1656669391.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 1 Jul 2022, Paolo Abeni wrote:

> The in-kernel PM has a bit of duplicate code related to ack
> generation. Create a new helper factoring out the PM-specific
> needs and use it in a couple of places.
>
> As a bonus, mptcp_subflow_send_ack() is not used anymore
> outside its own compilation unit and can become static.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

The rest of the series looks good, I ran the new tests and checked the 
pcaps too.

However, there's a conflict in this patch with the export branch. Can you 
rebase and repost?


Something else I noticed that is out of scope for this series, but 
something we should think about addressing:

The RFC says about MP_PRIO that "this signal applies to a single 
direction, and so the sender of this option could choose to continue using 
the subflow to send data even if it has signaled B=1 to the other host.".

However, we only have a single 'backup' value stored per subflow. If 
there's a netlink request to change the backup bit, it affects both 
outgoing scheduling and sends MP_PRIO to the peer to affect incoming 
traffic. A received MP_PRIO would affect outgoing packet scheduling on 
that subflow, but the peer may choose to schedule differently (and we do 
handle this ok). Would it be worth it to separate "incoming priority" and 
"outgoing priority"?

- Mat


> ---
> net/mptcp/pm_netlink.c | 56 +++++++++++++++++++++++++-----------------
> net/mptcp/protocol.c   |  2 +-
> net/mptcp/protocol.h   |  1 -
> 3 files changed, 35 insertions(+), 24 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index f1909006a859..8dc7ff9953b9 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -463,6 +463,37 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullm
> 	return i;
> }
>
> +static void __mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
> +			        bool prio, bool backup)
> +{
> +	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +	bool slow;
> +
> +	pr_debug("send ack for %s",
> +		 prio ? "mp_prio" : (mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr"));
> +
> +	slow = lock_sock_fast(ssk);
> +	if (prio) {
> +		if (subflow->backup != backup)
> +			msk->last_snd = NULL;
> +
> +		subflow->send_mp_prio = 1;
> +		subflow->backup = backup;
> +		subflow->request_bkup = backup;
> +	}
> +
> +	__mptcp_subflow_send_ack(ssk);
> +	unlock_sock_fast(ssk, slow);
> +}
> +
> +static void mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
> +			      bool prio, bool backup)
> +{
> +	spin_unlock_bh(&msk->pm.lock);
> +	__mptcp_pm_send_ack(msk, subflow, prio, backup);
> +	spin_lock_bh(&msk->pm.lock);
> +}
> +
> static struct mptcp_pm_addr_entry *
> __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
> {
> @@ -705,16 +736,8 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
> 		return;
>
> 	subflow = list_first_entry_or_null(&msk->conn_list, typeof(*subflow), node);
> -	if (subflow) {
> -		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> -
> -		spin_unlock_bh(&msk->pm.lock);
> -		pr_debug("send ack for %s",
> -			 mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr");
> -
> -		mptcp_subflow_send_ack(ssk);
> -		spin_lock_bh(&msk->pm.lock);
> -	}
> +	if (subflow)
> +		mptcp_pm_send_ack(msk, subflow, false, false);
> }
>
> static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
> @@ -728,23 +751,12 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
> 	mptcp_for_each_subflow(msk, subflow) {
> 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> 		struct mptcp_addr_info local;
> -		bool slow;
>
> 		local_address((struct sock_common *)ssk, &local);
> 		if (!mptcp_addresses_equal(&local, addr, addr->port))
> 			continue;
>
> -		slow = lock_sock_fast(ssk);
> -		if (subflow->backup != bkup)
> -			msk->last_snd = NULL;
> -		subflow->backup = bkup;
> -		subflow->send_mp_prio = 1;
> -		subflow->request_bkup = bkup;
> -
> -		pr_debug("send ack for mp_prio");
> -		__mptcp_subflow_send_ack(ssk);
> -		unlock_sock_fast(ssk, slow);
> -
> +		__mptcp_pm_send_ack(msk, subflow, true, bkup);
> 		return 0;
> 	}
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 10bfa2b78206..874344f7e0fa 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -508,7 +508,7 @@ void __mptcp_subflow_send_ack(struct sock *ssk)
> 		tcp_send_ack(ssk);
> }
>
> -void mptcp_subflow_send_ack(struct sock *ssk)
> +static void mptcp_subflow_send_ack(struct sock *ssk)
> {
> 	bool slow;
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 9a7ec7773e8c..a92b6276a03c 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -610,7 +610,6 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how);
> void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> 		     struct mptcp_subflow_context *subflow);
> void __mptcp_subflow_send_ack(struct sock *ssk);
> -void mptcp_subflow_send_ack(struct sock *ssk);
> void mptcp_subflow_reset(struct sock *ssk);
> void mptcp_subflow_queue_clean(struct sock *ssk);
> void mptcp_sock_graft(struct sock *sk, struct socket *parent);
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
