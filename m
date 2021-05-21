Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F69E70
	for <mptcp@lists.linux.dev>; Fri, 21 May 2021 00:22:19 +0000 (UTC)
IronPort-SDR: CWlnbxY1IbS1KeqxYti4TlgJ2oLe5Kq92ctUZY9UG4xghQHbyLfe6EQ1P+dtmkwdBR6+RKdWLw
 GAaa/u/1A8eA==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="188770454"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="188770454"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 17:22:18 -0700
IronPort-SDR: LGd7vm/wP+UWrsa71fi1qYdYnDZ9JwV4nmtJGKhHBr4OfnPrmHDa5/dDOQGwflJK+d/J5fIgD+
 Yf9/CBoeP0GA==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="631607199"
Received: from srfejes-mobl4.amr.corp.intel.com ([10.209.82.208])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 17:22:17 -0700
Date: Thu, 20 May 2021 17:22:17 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v3 mptcp-net 2/3] mptcp: do not reset MP_CAPABLE subflow
 on mapping errors
In-Reply-To: <d1935d23fff36674a64477cbf4f9b205a301624c.1621521884.git.pabeni@redhat.com>
Message-ID: <13f2962-d22b-ef6a-7f40-bb11fa9c6873@linux.intel.com>
References: <7e97e8e3c7d9265dcbf098b57f12da11d0b383b1.1621521884.git.pabeni@redhat.com> <d1935d23fff36674a64477cbf4f9b205a301624c.1621521884.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 20 May 2021, Paolo Abeni wrote:

> When some mapping related errors occours we close the main
> MPC subflow with a RST. We should instead fallback gracefully
> to TCP, and do the reset only for MPJ subflows.
>
> Fixes: d22f4988ffec ("mptcp: process MP_CAPABLE data option")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/192
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v2 -> v3:
> - change the fallback/rst test to better suite the RFC
> ---
> net/mptcp/subflow.c | 40 ++++++++++++++++++++--------------------
> 1 file changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 278986585088..a39d99d96900 100644
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
> @@ -1160,19 +1157,22 @@ static bool subflow_check_data_avail(struct sock *ssk)
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
> +	/* RFC 8684 section 3.7. */
> +	if (subflow->mp_join || subflow->fully_established) {

I think this is sufficient to prevent bad fallbacks, thanks for the 
revision. Looks good for the export branch. Packetdrill tests (including 
https://github.com/multipath-tcp/packetdrill/pull/58) pass for me.

For the series:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> +		/* fatal protocol error, close the socket.
> +		 * subflow_error_report() will introduce the apprpriate barriers

Minor tweak for Matthieu when applying - "appropriate"       ^^^^^^^^^^

> +		*/
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
