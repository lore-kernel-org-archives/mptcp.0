Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE4770
	for <mptcp@lists.linux.dev>; Fri,  4 Jun 2021 00:09:03 +0000 (UTC)
IronPort-SDR: bRrkBIL09fkN08WjUk9StpaERyt3nFki07mpvStJU/lcX+oewWHkBipVf+dBR5tKu7W38Ybfrw
 NsgdHZJb1jOQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="202327280"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="202327280"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 17:09:02 -0700
IronPort-SDR: 2xGe8MJh0pLqMZUu3JY96SDwKdPWmUL3Q1CzD6sk1Qafko1eRQ96h6Srb9Er4OhcqmzBOGWdz7
 lOy9U7j2kXtg==
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="417575113"
Received: from jhe12-mobl.amr.corp.intel.com ([10.212.229.108])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 17:08:56 -0700
Date: Thu, 3 Jun 2021 17:08:56 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Maxim Galaganov <max@internet.ru>
Subject: Re: [PATCH v3 mptcp-net] mptcp: fix soft lookup in
 subflow_error_report().
In-Reply-To: <392efcf1d0b83807fd888c2a33be75aa54dbb472.1622734919.git.pabeni@redhat.com>
Message-ID: <ec868bce-324b-5411-8639-233bb4279285@linux.intel.com>
References: <392efcf1d0b83807fd888c2a33be75aa54dbb472.1622734919.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 3 Jun 2021, Paolo Abeni wrote:

> Maxim reported a soft lookup in subflow_error_report():
>
> watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [swapper/0:0]
> RIP: 0010:native_queued_spin_lock_slowpath
> RSP: 0018:ffffa859c0003bc0 EFLAGS: 00000202
> RAX: 0000000000000101 RBX: 0000000000000001 RCX: 0000000000000000
> RDX: ffff9195c2772d88 RSI: 0000000000000000 RDI: ffff9195c2772d88
> RBP: ffff9195c2772d00 R08: 00000000000067b0 R09: c6e31da9eb1e44f4
> R10: ffff9195ef379700 R11: ffff9195edb50710 R12: ffff9195c2772d88
> R13: ffff9195f500e3d0 R14: ffff9195ef379700 R15: ffff9195ef379700
> FS:  0000000000000000(0000) GS:ffff91961f400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000c000407000 CR3: 0000000002988000 CR4: 00000000000006f0
> Call Trace:
>  <IRQ>
> _raw_spin_lock_bh
> subflow_error_report
> mptcp_subflow_data_available
> __mptcp_move_skbs_from_subflow
> mptcp_data_ready
> tcp_data_queue
> tcp_rcv_established
> tcp_v4_do_rcv
> tcp_v4_rcv
> ip_protocol_deliver_rcu
> ip_local_deliver_finish
> __netif_receive_skb_one_core
> netif_receive_skb
> rtl8139_poll 8139too
> __napi_poll
> net_rx_action
> __do_softirq
> __irq_exit_rcu
> common_interrupt
>  </IRQ>
>
> The calling function - mptcp_subflow_data_available() - can be invoked
> from different contexts:
> - plain ssk socket lock
> - ssk socket lock + mptcp_data_lock
> - ssk socket lock + mptcp_data_lock + msk socket lock.
>
> Since subflow_error_report() tries to acquire the mptcp_data_lock, the
> latter two call chains will cause soft lookup.
>
> This change addresses the issue moving the error reporting call to
> outer functions, where the held locks list is known and the we can
> acquire only the needed one.
>
> Reported-by: Maxim Galaganov <max@internet.ru>
> Fixes: 15cc10453398 ("mptcp: deliver ssk errors to msk")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/199
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Note: the diffstat is lager than expected because I had to move
> some functions upwards. Could be reduced [ab-]using forward declaration.
>
> v2 -> v3:
> - really add the mentioned unlikely() annotation

All unlikely()s confirmed, thanks for revising.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> ---
> net/mptcp/protocol.c |  9 ++++++
> net/mptcp/subflow.c  | 75 +++++++++++++++++++++++---------------------
> 2 files changed, 48 insertions(+), 36 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 44fd8c8c759b..4c0232067bf3 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -689,6 +689,12 @@ static void move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
>
> 	__mptcp_move_skbs_from_subflow(msk, ssk, &moved);
> 	__mptcp_ofo_queue(msk);
> +	if (unlikely(ssk->sk_err)) {
> +		if (!sock_owned_by_user(sk))
> +			__mptcp_error_report(sk);
> +		else
> +			set_bit(MPTCP_ERROR_REPORT,  &msk->flags);
> +	}
>
> 	/* If the moves have caught up with the DATA_FIN sequence number
> 	 * it's time to ack the DATA_FIN and change socket state, but
> @@ -1987,6 +1993,9 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
> 		done = __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
> 		mptcp_data_unlock(sk);
> 		tcp_cleanup_rbuf(ssk, moved);
> +
> +		if (unlikely(ssk->sk_err))
> +			__mptcp_error_report(sk);
> 		unlock_sock_fast(ssk, slowpath);
> 	} while (!done);
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 6b1cd4257edf..5ef31aa16cc1 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1163,7 +1163,6 @@ static bool subflow_check_data_avail(struct sock *ssk)
> 		 * subflow_error_report() will introduce the appropriate barriers
> 		 */
> 		ssk->sk_err = EBADMSG;
> -		ssk->sk_error_report(ssk);
> 		tcp_set_state(ssk, TCP_CLOSE);
> 		subflow->reset_transient = 0;
> 		subflow->reset_reason = MPTCP_RST_EMPTCP;
> @@ -1218,41 +1217,6 @@ void mptcp_space(const struct sock *ssk, int *space, int *full_space)
> 	*full_space = tcp_full_space(sk);
> }
>
> -static void subflow_data_ready(struct sock *sk)
> -{
> -	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> -	u16 state = 1 << inet_sk_state_load(sk);
> -	struct sock *parent = subflow->conn;
> -	struct mptcp_sock *msk;
> -
> -	msk = mptcp_sk(parent);
> -	if (state & TCPF_LISTEN) {
> -		/* MPJ subflow are removed from accept queue before reaching here,
> -		 * avoid stray wakeups
> -		 */
> -		if (reqsk_queue_empty(&inet_csk(sk)->icsk_accept_queue))
> -			return;
> -
> -		set_bit(MPTCP_DATA_READY, &msk->flags);
> -		parent->sk_data_ready(parent);
> -		return;
> -	}
> -
> -	WARN_ON_ONCE(!__mptcp_check_fallback(msk) && !subflow->mp_capable &&
> -		     !subflow->mp_join && !(state & TCPF_CLOSE));
> -
> -	if (mptcp_subflow_data_available(sk))
> -		mptcp_data_ready(parent, sk);
> -}
> -
> -static void subflow_write_space(struct sock *ssk)
> -{
> -	struct sock *sk = mptcp_subflow_ctx(ssk)->conn;
> -
> -	mptcp_propagate_sndbuf(sk, ssk);
> -	mptcp_write_space(sk);
> -}
> -
> void __mptcp_error_report(struct sock *sk)
> {
> 	struct mptcp_subflow_context *subflow;
> @@ -1293,6 +1257,43 @@ static void subflow_error_report(struct sock *ssk)
> 	mptcp_data_unlock(sk);
> }
>
> +static void subflow_data_ready(struct sock *sk)
> +{
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> +	u16 state = 1 << inet_sk_state_load(sk);
> +	struct sock *parent = subflow->conn;
> +	struct mptcp_sock *msk;
> +
> +	msk = mptcp_sk(parent);
> +	if (state & TCPF_LISTEN) {
> +		/* MPJ subflow are removed from accept queue before reaching here,
> +		 * avoid stray wakeups
> +		 */
> +		if (reqsk_queue_empty(&inet_csk(sk)->icsk_accept_queue))
> +			return;
> +
> +		set_bit(MPTCP_DATA_READY, &msk->flags);
> +		parent->sk_data_ready(parent);
> +		return;
> +	}
> +
> +	WARN_ON_ONCE(!__mptcp_check_fallback(msk) && !subflow->mp_capable &&
> +		     !subflow->mp_join && !(state & TCPF_CLOSE));
> +
> +	if (mptcp_subflow_data_available(sk))
> +		mptcp_data_ready(parent, sk);
> +	else if (unlikely(sk->sk_err))
> +		subflow_error_report(sk);
> +}
> +
> +static void subflow_write_space(struct sock *ssk)
> +{
> +	struct sock *sk = mptcp_subflow_ctx(ssk)->conn;
> +
> +	mptcp_propagate_sndbuf(sk, ssk);
> +	mptcp_write_space(sk);
> +}
> +
> static struct inet_connection_sock_af_ops *
> subflow_default_af_ops(struct sock *sk)
> {
> @@ -1603,6 +1604,8 @@ static void subflow_state_change(struct sock *sk)
> 	 */
> 	if (mptcp_subflow_data_available(sk))
> 		mptcp_data_ready(parent, sk);
> +	else if (unlikely(sk->sk_err))
> +		subflow_error_report(sk);
>
> 	subflow_sched_work_if_closed(mptcp_sk(parent), sk);
>
> -- 
> 2.26.3
>
>
>

--
Mat Martineau
Intel
