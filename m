Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7B6365
	for <mptcp@lists.linux.dev>; Tue, 22 Mar 2022 00:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647908510; x=1679444510;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iUuUEAE00RjRAp2129YpqAderpRf4hnsEPGbNC4VF+o=;
  b=D5T1PbN1afcR+zzdgbL7iXNDDpJmdzZm13vj+HhkYM5jmPYgyNIEp0h+
   t482Ajihg6tgDvvZIuIp43+xafVdRMB9KBVPxkzN/5PvS1LXjH4s7J3GC
   +xtrGsvLTUx6U/N4fm017hsPvq95bD3ha2K5VCzSiJo7yL1SYEbC5ywVT
   FK0eVqlCMEejCTGrd9LLnKI85rBYrP+DcF/YsxkXsRbbM/R9byOj5/tYo
   iuwUksP197JeMfojyDyJffFGhTocV31SDsN1ZEjw4UKLHfThkW2/VUbgO
   P22AyFI8nGthlQDmx0HKTtZ+aeXcYY68Jc03F0VTDrMTWsGVVGkA6o1TT
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="245155614"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="245155614"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 17:21:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="560112218"
Received: from danieljm-mobl.amr.corp.intel.com ([10.252.129.122])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 17:21:49 -0700
Date: Mon, 21 Mar 2022 17:21:49 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 2/3] mptcp: reset the packet scheduler on
 incoming MP_PRIO.
In-Reply-To: <4982f05aedd915cdc486399696d8c5b492fd2d9a.1647601548.git.pabeni@redhat.com>
Message-ID: <8e593068-fb24-252-6980-19aa9c4fe577@linux.intel.com>
References: <6fc1ea29ae85074d626ad1cef3fea34055de37f1.1647601548.git.pabeni@redhat.com> <4982f05aedd915cdc486399696d8c5b492fd2d9a.1647601548.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 18 Mar 2022, Paolo Abeni wrote:

> When an incoming MP_PRIO option changes the backup
> status of any subflow, we need to reset the packet
> scheduler status, or the next send could keep using
> the previously selected subflow, without taking in account
> the new priorities.
>
> Reported-by: Davide Caratti <dcaratti@redhat.com>
> Fixes: 40453a5c61f4 ("mptcp: add the incoming MP_PRIO support")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/pm.c       | 19 +++++++++++++++----
> net/mptcp/protocol.c |  2 ++
> net/mptcp/protocol.h |  1 +
> 3 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index d0d31d5c198a..2f6ee422c6df 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -262,14 +262,25 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
> 	spin_unlock_bh(&pm->lock);
> }
>
> -void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
> +void mptcp_pm_mp_prio_received(struct sock *ssk, u8 bkup)
> {
> -	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> +	struct sock *sk = subflow->conn;
> +	struct mptcp_sock *msk;
>
> 	pr_debug("subflow->backup=%d, bkup=%d\n", subflow->backup, bkup);
> -	subflow->backup = bkup;
> +	msk = mptcp_sk(sk);
> +	if (subflow->backup == bkup) {

Above should be "if (subflow->backup != bkup)"?

> +		subflow->backup = bkup;
> +		mptcp_data_lock(sk);
> +		if (!sock_owned_by_user(sk))
> +			msk->last_snd = NULL;
> +		else
> +			__set_bit(MPTCP_RESET_SCHEDULER,  &msk->cb_flags);
> +		mptcp_data_unlock(sk);
> +	}
>
> -	mptcp_event(MPTCP_EVENT_SUB_PRIORITY, mptcp_sk(subflow->conn), sk, GFP_ATOMIC);
> +	mptcp_event(MPTCP_EVENT_SUB_PRIORITY, msk, ssk, GFP_ATOMIC);
> }
>
> void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index bdba1ddee2a7..cec42bc16d12 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3128,6 +3128,8 @@ static void mptcp_release_cb(struct sock *sk)
> 			__mptcp_set_connected(sk);
> 		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
> 			__mptcp_error_report(sk);
> +		if (__test_and_clear_bit(MPTCP_RESET_SCHEDULER, &msk->cb_flags))
> +			msk->last_snd = NULL;
> 	}
>
> 	__mptcp_update_rmem(sk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index c8bada4537e2..d59c16d248a4 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -124,6 +124,7 @@
> #define MPTCP_RETRANSMIT	4
> #define MPTCP_FLUSH_JOIN_LIST	5
> #define MPTCP_CONNECTED		6
> +#define MPTCP_RESET_SCHEDULER	7
>
> static inline bool before64(__u64 seq1, __u64 seq2)
> {
> -- 
> 2.35.1



--
Mat Martineau
Intel
