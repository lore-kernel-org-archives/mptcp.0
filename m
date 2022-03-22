Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5338A53
	for <mptcp@lists.linux.dev>; Tue, 22 Mar 2022 16:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647968074; x=1679504074;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/RoTTh3CHr4UPsYY7wWOTtmOMIq0oniaSbB/yWl4hCg=;
  b=O+QXDfAHAFHoVtetBh2292dMSCHJxh9/qeuVMABF6XnQwm1saosvVxMZ
   qi4mUXAzCoaGAbChLPSFDV1sjbPJ1VvNHruaV48SuOyQ6GBl/JDQkeP2a
   o1ZEwaatGFltLmDrIAQZEnQPWjdu2toJs3VV0B7q2aH1S5+06hQ8PrDJ+
   QEBITlHXSBiw7pegfB5XhAxxUd2rL0gTkXlfscSiR39ZBekgfTOno4Svj
   +HLrWnrwRkugOhYx9rKPTeEuSpE4RSVgO8Ei3LjAAfMKcIyJrEK/w/5VM
   XLlcI7fj9bMzggqdp1ZiYtzWIFw4iIMDv4SUWoo8GuN9GQVZm3q6eckWL
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="257590162"
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="257590162"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 09:54:34 -0700
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="692615740"
Received: from ticela-or-178.amr.corp.intel.com ([10.209.18.94])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 09:54:33 -0700
Date: Tue, 22 Mar 2022 09:54:32 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next 2/3] mptcp: reset the packet scheduler on
 incoming MP_PRIO.
In-Reply-To: <ed967b995918548f6abf8f2625b29bca770f132a.1647960598.git.pabeni@redhat.com>
Message-ID: <664e844-1d26-d3e3-fdd-5cb343645@linux.intel.com>
References: <53b59c780c15855fb57ec41e187a19272747c9d8.1647960598.git.pabeni@redhat.com> <ed967b995918548f6abf8f2625b29bca770f132a.1647960598.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 22 Mar 2022, Paolo Abeni wrote:

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
> v1 -> v2:
> - fix backup comparison - Mat

Thanks for the v2, series is ready for the export branch:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> ---
> net/mptcp/pm.c       | 19 +++++++++++++++----
> net/mptcp/protocol.c |  2 ++
> net/mptcp/protocol.h |  1 +
> 3 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index d0d31d5c198a..c87f8974a1a7 100644
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
> +	if (subflow->backup != bkup) {
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
>
>
>

--
Mat Martineau
Intel
