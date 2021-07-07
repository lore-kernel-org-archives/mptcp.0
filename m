Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD30B70
	for <mptcp@lists.linux.dev>; Wed,  7 Jul 2021 23:51:44 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="273252314"
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="273252314"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 16:51:35 -0700
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="487188775"
Received: from wilesamy-mobl.amr.corp.intel.com ([10.212.141.74])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 16:51:34 -0700
Date: Wed, 7 Jul 2021 16:51:33 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: send out MP_FAIL
 when data checksum fail"
In-Reply-To: <8f13271510c7d2289e34e4a72deee2e291a5da2a.1625057469.git.geliangtang@gmail.com>
Message-ID: <4b6f69c6-8dd-5dfd-481-f2d775fb958e@linux.intel.com>
References: <8f13271510c7d2289e34e4a72deee2e291a5da2a.1625057469.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 30 Jun 2021, Geliang Tang wrote:

> Just set the sk_state of the subsocket to TCP_CLOSE, then the flag
> MPTCP_WORK_CLOSE_SUBFLOW will be set in subflow_sched_work_if_closed,
> and the subflow will be closed.
>
> mptcp_subflow_reset is somehow duplicate here.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> net/mptcp/subflow.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>

Thanks for updating the v3 patch set with this. Please squash this in v4.

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index d297b941586d..cbf91e22574c 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1159,7 +1159,11 @@ static bool subflow_check_data_avail(struct sock *ssk)
> 	/* RFC 8684 section 3.7. */
> 	if (subflow->send_mp_fail) {
> 		if (mptcp_has_another_subflow_established(ssk)) {
> -			mptcp_subflow_reset(ssk);
> +			ssk->sk_err = EBADMSG;
> +			tcp_set_state(ssk, TCP_CLOSE);
> +			subflow->reset_transient = 0;
> +			subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
> +			tcp_send_active_reset(ssk, GFP_ATOMIC);
> 			while ((skb = skb_peek(&ssk->sk_receive_queue)))
> 				sk_eat_skb(ssk, skb);
> 			WRITE_ONCE(subflow->data_avail, 0);
> -- 
> 2.31.1

--
Mat Martineau
Intel
