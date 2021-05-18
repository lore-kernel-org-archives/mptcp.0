Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33052FBF
	for <mptcp@lists.linux.dev>; Tue, 18 May 2021 00:16:59 +0000 (UTC)
IronPort-SDR: pHss56FMHMSoEZ6YjOAUCWyqQQ5DpT+qaoAGvFbuPVqektPXCl4/1gVLQ5EdKnwMSvXFNGll+N
 XAgOfiBW+Brw==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="221639438"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="221639438"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 17:16:58 -0700
IronPort-SDR: 1XRIAarjoUZa+HeBE8rM2NVO5dY++nNB01+KA+dY5msQkAbXZfcxfrEVc0mCJQKD6zfzYVEMYK
 QHAy8NolRxgA==
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="393733334"
Received: from kpporrit-mobl.amr.corp.intel.com ([10.212.243.76])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 17:16:58 -0700
Date: Mon, 17 May 2021 17:16:58 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-net 2/2] mptcp: do not reset MP_CAPABLE subflow
 on mapping errors
In-Reply-To: <99f56765d4939e6f21c3950ed2ee3b54369e6d5b.1621270518.git.pabeni@redhat.com>
Message-ID: <2651afa0-d371-8730-a685-def56669d6e@linux.intel.com>
References: <18ddcf2f53d732eb9b41a485ce7da23329aaa81e.1621270518.git.pabeni@redhat.com> <99f56765d4939e6f21c3950ed2ee3b54369e6d5b.1621270518.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 17 May 2021, Paolo Abeni wrote:

> When some mapping related errors occours we close the main
> MPC subflow with a RST. We should instead fallback gracefully
> to TCP, and do the reset only for MPJ subflows.
>
> Fixes: d22f4988ffec ("mptcp: process MP_CAPABLE data option")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/192
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/subflow.c | 39 +++++++++++++++++++--------------------
> 1 file changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 278986585088..9befe9fe7bca 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1110,10 +1110,9 @@ static bool subflow_check_data_avail(struct sock *ssk)
>
> 		status = get_mapping_status(ssk, msk);
> 		trace_subflow_check_data_avail(status, skb_peek(&ssk->sk_receive_queue));
> -		if (unlikely(status == MAPPING_INVALID)) {
> -			ssk->sk_err = EBADMSG;
> -			goto fatal;
> -		}
> +		if (unlikely(status == MAPPING_INVALID))
> +			goto fallback;
> +

There are a bunch of other ways to get MAPPING_INVALID during the life of 
a connection, including when there are multiple subflows active and 
fallback is not a valid option. Can the new fallback condition be more 
targeted to this "out of order / packet loss at connection time" issue so 
truly fatal MAPPING_INVALID cases still reset the connection?

-Mat


> 		if (unlikely(status == MAPPING_DUMMY))
> 			goto fallback;
>
> @@ -1128,10 +1127,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
> 		 * MP_CAPABLE-based mapping
> 		 */
> 		if (unlikely(!READ_ONCE(msk->can_ack))) {
> -			if (!subflow->mpc_map) {
> -				ssk->sk_err = EBADMSG;
> -				goto fatal;
> -			}
> +			if (!subflow->mpc_map)
> +				goto fallback;
> 			WRITE_ONCE(msk->remote_key, subflow->remote_key);
> 			WRITE_ONCE(msk->ack_seq, subflow->map_seq);
> 			WRITE_ONCE(msk->can_ack, true);
> @@ -1160,19 +1157,21 @@ static bool subflow_check_data_avail(struct sock *ssk)
> 	subflow_sched_work_if_closed(msk, ssk);
> 	return false;
>
> -fatal:
> -	/* fatal protocol error, close the socket */
> -	/* This barrier is coupled with smp_rmb() in tcp_poll() */
> -	smp_wmb();
> -	ssk->sk_error_report(ssk);
> -	tcp_set_state(ssk, TCP_CLOSE);
> -	subflow->reset_transient = 0;
> -	subflow->reset_reason = MPTCP_RST_EMPTCP;
> -	tcp_send_active_reset(ssk, GFP_ATOMIC);
> -	subflow->data_avail = 0;
> -	return false;
> -
> fallback:
> +	if (subflow->mp_join) {
> +		/* fatal protocol error, close the socket */
> +		/* This barrier is coupled with smp_rmb() in tcp_poll() */
> +		smp_wmb();
> +		ssk->sk_err = EBADMSG;
> +		ssk->sk_error_report(ssk);
> +		tcp_set_state(ssk, TCP_CLOSE);
> +		subflow->reset_transient = 0;
> +		subflow->reset_reason = MPTCP_RST_EMPTCP;
> +		tcp_send_active_reset(ssk, GFP_ATOMIC);
> +		subflow->data_avail = 0;
> +		return false;
> +	}
> +
> 	__mptcp_do_fallback(msk);
> 	skb = skb_peek(&ssk->sk_receive_queue);
> 	subflow->map_valid = 1;
> -- 
> 2.26.3
>
>
>

--
Mat Martineau
Intel
