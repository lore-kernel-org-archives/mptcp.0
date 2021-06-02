Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D6B71
	for <mptcp@lists.linux.dev>; Wed,  2 Jun 2021 00:22:17 +0000 (UTC)
IronPort-SDR: QHkNaFimAj5oAIZZ35xbDHogXzcfzvKqhEl+VDry/EOPQxbimmJpKTqgvCPGxPrniPTqFaZnA8
 8sA+ktoi12eQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="200658716"
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="200658716"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 17:22:16 -0700
IronPort-SDR: Q8umvBhSlZtbf/s7ZiH5f25ZpjIYSsuvTrHn7jKJU85uTTpGdvzgcHp/V6y61yD7ZCEXid5iBF
 HE7t39a+gcYA==
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="549934054"
Received: from ipiacent-mobl1.amr.corp.intel.com ([10.209.119.149])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 17:22:16 -0700
Date: Tue, 1 Jun 2021 17:22:15 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, max@internet.ru
Subject: Re: [PATCH v2 mptcp-net] mptcp: fix soft lookup in
 subflow_error_report().
In-Reply-To: <1ff9487ec87d1ca5cbd32ea40b079099bfeedc06.1622569473.git.pabeni@redhat.com>
Message-ID: <bc541ab2-bd17-b6b8-cb0-a0582662d61a@linux.intel.com>
References: <1ff9487ec87d1ca5cbd32ea40b079099bfeedc06.1622569473.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 1 Jun 2021, Paolo Abeni wrote:

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
> v1 -> v2:
> - added missing unlikely() annotation
>
> Note: the diffstat is lager than expected because I had to move
> some functions upwards. Could be reduced [ab-]using forward declaration.
> ---
> net/mptcp/protocol.c |  9 ++++++
> net/mptcp/subflow.c  | 75 +++++++++++++++++++++++---------------------
> 2 files changed, 48 insertions(+), 36 deletions(-)
>

...

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 6b1cd4257edf..c4ca37dd4be2 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c

...

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

I was wondering if the 'else if' was the way to go here, but then I saw 
that if there are errors encountered down the mptcp_data_ready() execution 
path, those will get reported before mptcp_data_ready() returns. So the 
patch looks good to me.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

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

--
Mat Martineau
Intel
