Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F09F2C81
	for <mptcp@lists.linux.dev>; Fri, 29 Oct 2021 23:36:41 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="294234112"
X-IronPort-AV: E=Sophos;i="5.87,194,1631602800"; 
   d="scan'208";a="294234112"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 16:36:40 -0700
X-IronPort-AV: E=Sophos;i="5.87,194,1631602800"; 
   d="scan'208";a="499110629"
Received: from feiyang2-mobl.amr.corp.intel.com ([10.209.25.152])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 16:36:40 -0700
Date: Fri, 29 Oct 2021 16:36:40 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net 2/2] mptcp: use delegate action to schedule
 3rd ack retrans
In-Reply-To: <2a28807616445b389496dc0f172e206180f5a099.1635426465.git.pabeni@redhat.com>
Message-ID: <b3ce1954-ad3-71b6-92af-870e63f40c3@linux.intel.com>
References: <cover.1635426465.git.pabeni@redhat.com> <2a28807616445b389496dc0f172e206180f5a099.1635426465.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 28 Oct 2021, Paolo Abeni wrote:

> Scheduling a delack in mptcp_established_options_mp() is
> not a good idea: such function is called by tcp_send_ack() and
> the pending delayed ack will be cleared shortly after by the
> tcp_event_ack_sent() call in __tcp_transmit_skb().
>
> Instead use the mptcp delegated action infrastructure to
> schedule the delayed ack after the current bh processing completes.
>
> Additionally moves the schedule_3rdack_retransmission() helper
> into protocol.c to avoid making it visible in a different compilation
> unit.
>
> Fixes: ec3edaa7ca6ce02f ("mptcp: Add handling of outgoing MP_JOIN requests")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> side note:
> Why we already see 3rd ack retransimssion in pcap traces even if the delack timer
> was broken sice the beginning?!? I guess that is due to pure ack generated
> by mptcp_recvmsg() and pushed on all the subflow. mptcp_send_ack() only
> checks for the TCP status and not the MPTCP one. When landing on MPJ
> subflows not already fully established, such data-ack will be converted in MPJ
> 3rd ack by the MPTCP output path/out options building, as the MPJ option
> has higher priority than DSS
> ---
> net/mptcp/options.c  | 33 ++++++++---------------------
> net/mptcp/protocol.c | 50 ++++++++++++++++++++++++++++++++++++--------
> net/mptcp/protocol.h | 17 ++++++++-------
> 3 files changed, 59 insertions(+), 41 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 465d4143d555..12ffee025373 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -422,29 +422,6 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
> 	return false;
> }
>
> -/* MP_JOIN client subflow must wait for 4th ack before sending any data:
> - * TCP can't schedule delack timer before the subflow is fully established.
> - * MPTCP uses the delack timer to do 3rd ack retransmissions
> - */
> -static void schedule_3rdack_retransmission(struct sock *sk)
> -{
> -	struct inet_connection_sock *icsk = inet_csk(sk);
> -	struct tcp_sock *tp = tcp_sk(sk);
> -	unsigned long timeout;
> -
> -	/* reschedule with a timeout above RTT, as we must look only for drop */
> -	if (tp->srtt_us)
> -		timeout = usecs_to_jiffies(tp->srtt_us >> (3-1));
> -	else
> -		timeout = TCP_TIMEOUT_INIT;
> -	timeout += jiffies;
> -
> -	WARN_ON_ONCE(icsk->icsk_ack.pending & ICSK_ACK_TIMER);
> -	icsk->icsk_ack.pending |= ICSK_ACK_SCHED | ICSK_ACK_TIMER;
> -	icsk->icsk_ack.timeout = timeout;
> -	sk_reset_timer(sk, &icsk->icsk_delack_timer, timeout);
> -}
> -
> static void clear_3rdack_retransmission(struct sock *sk)
> {
> 	struct inet_connection_sock *icsk = inet_csk(sk);
> @@ -527,7 +504,15 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
> 		*size = TCPOLEN_MPTCP_MPJ_ACK;
> 		pr_debug("subflow=%p", subflow);
>
> -		schedule_3rdack_retransmission(sk);
> +		/* we can use the full delegate action helper only from BH context
> +		 * If we are in process context - sk is flushing the backlog at
> +		 * socket lock release time - just set the appropriate flag, will
> +		 * be handled by the release callback
> +		 */
> +		if (sock_owned_by_user(sk))
> +			set_bit(MPTCP_DELEGATE_SEND, &subflow->delegated_status);

I believe you intended MPTCP_DELEGATE_ACK here

> +		else
> +			mptcp_subflow_delegate(subflow, MPTCP_DELEGATE_ACK);
> 		return true;
> 	}
> 	return false;

The rest looks good.

--
Mat Martineau
Intel
