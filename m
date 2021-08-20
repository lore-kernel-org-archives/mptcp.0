Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27715168
	for <mptcp@lists.linux.dev>; Fri, 20 Aug 2021 00:24:33 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="238806803"
X-IronPort-AV: E=Sophos;i="5.84,336,1620716400"; 
   d="scan'208";a="238806803"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 17:24:32 -0700
X-IronPort-AV: E=Sophos;i="5.84,336,1620716400"; 
   d="scan'208";a="681965510"
Received: from seedmund-mobl.amr.corp.intel.com ([10.212.221.18])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 17:24:32 -0700
Date: Thu, 19 Aug 2021 17:24:31 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next 4/4] mptcp: optimize the input options
 processing.
In-Reply-To: <1eb5eb91a3cdb5d0f03e20120b1c5c109d690fc8.1629386016.git.pabeni@redhat.com>
Message-ID: <65cee750-5e3-aeb0-fd2-8342357b4ba7@linux.intel.com>
References: <cover.1629386016.git.pabeni@redhat.com> <1eb5eb91a3cdb5d0f03e20120b1c5c109d690fc8.1629386016.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 19 Aug 2021, Paolo Abeni wrote:

> Most MPTCP packets carries a single MPTCP subption: the
> DSS containing the mapping for the current packet.
>
> Check explicitly for the above, so that is such scenario we
> replace most conditional statements with a single likely() one.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/options.c | 70 +++++++++++++++++++++++----------------------
> 1 file changed, 36 insertions(+), 34 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 0d33c020062f..af22d76f1699 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1111,48 +1111,50 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
> 	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
> 		return sk->sk_state != TCP_CLOSE;
>
> -	if ((mp_opt.suboptions & OPTION_MPTCP_FASTCLOSE) &&
> -	    msk->local_key == mp_opt.rcvr_key) {
> -		WRITE_ONCE(msk->rcv_fastclose, true);
> -		mptcp_schedule_work((struct sock *)msk);
> -	}
> +	if (unlikely(mp_opt.suboptions != OPTION_MPTCP_DSS)) {

This diff is a lot shorter when ignoring whitespace :)

One question - is it worth optimizing for the mp_opt.suboptions = 0 case 
too? While our stack will send duplicate DSS mappings when the mapped data 
is split across multiple TCP packets, other stacks might send each mapping 
only once (hopefully not, since that will affect GRO/etc).

I think this series is good for the export branch now, though:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>



> +		if ((mp_opt.suboptions & OPTION_MPTCP_FASTCLOSE) &&
> +		    msk->local_key == mp_opt.rcvr_key) {
> +			WRITE_ONCE(msk->rcv_fastclose, true);
> +			mptcp_schedule_work((struct sock *)msk);
> +		}
>
> -	if ((mp_opt.suboptions & OPTION_MPTCP_ADD_ADDR) && add_addr_hmac_valid(msk, &mp_opt)) {
> -		if (!mp_opt.echo) {
> -			mptcp_pm_add_addr_received(msk, &mp_opt.addr);
> -			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
> -		} else {
> -			mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
> -			mptcp_pm_del_add_timer(msk, &mp_opt.addr, true);
> -			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
> +		if ((mp_opt.suboptions & OPTION_MPTCP_ADD_ADDR) && add_addr_hmac_valid(msk, &mp_opt)) {
> +			if (!mp_opt.echo) {
> +				mptcp_pm_add_addr_received(msk, &mp_opt.addr);
> +				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
> +			} else {
> +				mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
> +				mptcp_pm_del_add_timer(msk, &mp_opt.addr, true);
> +				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
> +			}
> +
> +			if (mp_opt.addr.port)
> +				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_PORTADD);
> 		}
>
> -		if (mp_opt.addr.port)
> -			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_PORTADD);
> -	}
> +		if (mp_opt.suboptions & OPTION_MPTCP_RM_ADDR)
> +			mptcp_pm_rm_addr_received(msk, &mp_opt.rm_list);
>
> -	if (mp_opt.suboptions & OPTION_MPTCP_RM_ADDR)
> -		mptcp_pm_rm_addr_received(msk, &mp_opt.rm_list);
> +		if (mp_opt.suboptions & OPTION_MPTCP_PRIO) {
> +			mptcp_pm_mp_prio_received(sk, mp_opt.backup);
> +			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIORX);
> +		}
>
> -	if (mp_opt.suboptions & OPTION_MPTCP_PRIO) {
> -		mptcp_pm_mp_prio_received(sk, mp_opt.backup);
> -		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIORX);
> -	}
> +		if (mp_opt.suboptions & OPTION_MPTCP_FAIL) {
> +			mptcp_pm_mp_fail_received(sk, mp_opt.fail_seq);
> +			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILRX);
> +		}
>
> -	if (mp_opt.suboptions & OPTION_MPTCP_FAIL) {
> -		mptcp_pm_mp_fail_received(sk, mp_opt.fail_seq);
> -		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILRX);
> -	}
> +		if (mp_opt.suboptions & OPTION_MPTCP_RST) {
> +			subflow->reset_seen = 1;
> +			subflow->reset_reason = mp_opt.reset_reason;
> +			subflow->reset_transient = mp_opt.reset_transient;
> +		}
>
> -	if (mp_opt.suboptions & OPTION_MPTCP_RST) {
> -		subflow->reset_seen = 1;
> -		subflow->reset_reason = mp_opt.reset_reason;
> -		subflow->reset_transient = mp_opt.reset_transient;
> +		if (!(mp_opt.suboptions & OPTION_MPTCP_DSS))
> +			return true;
> 	}
>
> -	if (!(mp_opt.suboptions & OPTION_MPTCP_DSS))
> -		return true;
> -
> 	/* we can't wait for recvmsg() to update the ack_seq, otherwise
> 	 * monodirectional flows will stuck
> 	 */
> @@ -1179,7 +1181,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>
> 	memset(mpext, 0, sizeof(*mpext));
>
> -	if (mp_opt.use_map) {
> +	if (likely(mp_opt.use_map)) {
> 		if (mp_opt.mpc_map) {
> 			/* this is an MP_CAPABLE carrying MPTCP data
> 			 * we know this map the first chunk of data
> -- 
> 2.26.3

--
Mat Martineau
Intel
