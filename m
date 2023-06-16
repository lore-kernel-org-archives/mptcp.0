Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE816139
	for <mptcp@lists.linux.dev>; Fri, 16 Jun 2023 22:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14A2C433C0;
	Fri, 16 Jun 2023 22:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686955937;
	bh=6Qx7HDyJVY/86JXoOMRquoooLyHObHpwslv1+otu+Sk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=FxnrlxjYzhlHFy436WQs5lmbMjExK3IgKxIsTCi5btDAv4vkEqORcarNgOqfLTDZS
	 nWbQHnN6QEmRradtS+yRz6E3JKdNQnWsTNMFIOnHOvRaoyQ+1M6tSP/Dr/7MX9S/bi
	 qJsFE0nWZis/ALgVpPR342+PwiBR+tqX5OVkBgGlFE2KIhdIV/Y9jC5GsM4T04HdN4
	 fSIYJnf3YFoMeNvEHkiOSrixgG9QC6NQbrnH6kj17XiVAOCY+axji1Z//oxkgC59H0
	 aP9uqORdAUWs5e8qaqxgjQDIiMA+seguYlC5h2l3Y/BPtz2N0vGC7zjk6TQrbn9toJ
	 IIkmfpKym/ZAA==
Date: Fri, 16 Jun 2023 15:52:16 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: consolidate fallback and non fallback
 state machine
In-Reply-To: <f684967fa27c0d051ba3668c45f89ba1ba97a03d.1686584384.git.pabeni@redhat.com>
Message-ID: <64e59a12-9f35-4689-48d1-d3bb6e8bbfee@kernel.org>
References: <f684967fa27c0d051ba3668c45f89ba1ba97a03d.1686584384.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


Hi Paolo -

On Mon, 12 Jun 2023, Paolo Abeni wrote:

> An orphaned msk releases the used resources via the worker,
> when the latter first see the msk in CLOSED status.
>
> If the msk status transitions to TCP_CLOSE in the release callback
> invoked by the worker's final release_sock(), such instance of the
> workqueue will not take any action.
>
> Additionally the MPTCP code prevents scheduling the worker once the
> socket reaches the CLOSE status: such msk resources will be leaked.
>
> The only code path that can trigger the above scenario is the
> __mptcp_check_send_data_fin() in fallback mode.
>
> Address the issue removing the special handling of fallback socket
> in __mptcp_check_send_data_fin(), consolidating the state machine
> for fallback and non fallback socket.
>
> Since non-fallback sockets do not send not receive data_fin, the

Is this intended to read "do not send and do not receive data_fin"? Maybe 
Matthieu can adjust when applying.

> mptcp code can update the msk internal status to match the next
> step in the SM every time data fin (ack) should be generated or
> received.
>
> As a consequence we can remove a bunch of checks for fallback from
> the fastpath.
>
> Fixes: 6e628cd3a8f7 ("mptcp: use mptcp release_cb for delayed tasks")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

I agree, this is a better approach for handling the state machine and 
socket state transitions in fallback. Looks good to me:

Reviewed-by: Mat Martineau <martineau@kernel.org>

> ---
> net/mptcp/protocol.c | 41 +++++++++++++++--------------------------
> net/mptcp/subflow.c  | 17 ++++++++++-------
> 2 files changed, 25 insertions(+), 33 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 7ffb6709cacd..8f3e50065c13 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -44,7 +44,7 @@ enum {
> static struct percpu_counter mptcp_sockets_allocated ____cacheline_aligned_in_smp;
>
> static void __mptcp_destroy_sock(struct sock *sk);
> -static void __mptcp_check_send_data_fin(struct sock *sk);
> +static void mptcp_check_send_data_fin(struct sock *sk);
>
> DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
> static struct net_device mptcp_napi_dev;
> @@ -426,8 +426,7 @@ static bool mptcp_pending_data_fin_ack(struct sock *sk)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
>
> -	return !__mptcp_check_fallback(msk) &&
> -	       ((1 << sk->sk_state) &
> +	return ((1 << sk->sk_state) &
> 		(TCPF_FIN_WAIT1 | TCPF_CLOSING | TCPF_LAST_ACK)) &&
> 	       msk->write_seq == READ_ONCE(msk->snd_una);
> }
> @@ -585,9 +584,6 @@ static bool mptcp_check_data_fin(struct sock *sk)
> 	u64 rcv_data_fin_seq;
> 	bool ret = false;
>
> -	if (__mptcp_check_fallback(msk))
> -		return ret;
> -
> 	/* Need to ack a DATA_FIN received from a peer while this side
> 	 * of the connection is in ESTABLISHED, FIN_WAIT1, or FIN_WAIT2.
> 	 * msk->rcv_data_fin was set when parsing the incoming options
> @@ -625,7 +621,8 @@ static bool mptcp_check_data_fin(struct sock *sk)
> 		}
>
> 		ret = true;
> -		mptcp_send_ack(msk);
> +		if (!__mptcp_check_fallback(msk))
> +			mptcp_send_ack(msk);
> 		mptcp_close_wake_up(sk);
> 	}
> 	return ret;
> @@ -1632,7 +1629,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 	if (!mptcp_timer_pending(sk))
> 		mptcp_reset_timer(sk);
> 	if (do_check_data_fin)
> -		__mptcp_check_send_data_fin(sk);
> +		mptcp_check_send_data_fin(sk);
> }
>
> static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
> @@ -2725,8 +2722,6 @@ static void mptcp_worker(struct work_struct *work)
> 	if (unlikely((1 << state) & (TCPF_CLOSE | TCPF_LISTEN)))
> 		goto unlock;
>
> -	mptcp_check_data_fin_ack(sk);
> -
> 	mptcp_check_fastclose(msk);
>
> 	mptcp_pm_nl_work(msk);
> @@ -2734,7 +2729,8 @@ static void mptcp_worker(struct work_struct *work)
> 	if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
> 		mptcp_check_for_eof(msk);
>
> -	__mptcp_check_send_data_fin(sk);
> +	mptcp_check_send_data_fin(sk);
> +	mptcp_check_data_fin_ack(sk);
> 	mptcp_check_data_fin(sk);
>
> 	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
> @@ -2878,6 +2874,12 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
> 			pr_debug("Fallback");
> 			ssk->sk_shutdown |= how;
> 			tcp_shutdown(ssk, how);
> +
> +			/* simulate the data_fin ack reception to let the state
> +			 * machine move forward
> +			 */
> +			WRITE_ONCE(mptcp_sk(sk)->snd_una, mptcp_sk(sk)->snd_nxt);
> +			mptcp_schedule_work(sk);
> 		} else {
> 			pr_debug("Sending DATA_FIN on subflow %p", ssk);
> 			tcp_send_ack(ssk);
> @@ -2917,7 +2919,7 @@ static int mptcp_close_state(struct sock *sk)
> 	return next & TCP_ACTION_FIN;
> }
>
> -static void __mptcp_check_send_data_fin(struct sock *sk)
> +static void mptcp_check_send_data_fin(struct sock *sk)
> {
> 	struct mptcp_subflow_context *subflow;
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> @@ -2935,19 +2937,6 @@ static void __mptcp_check_send_data_fin(struct sock *sk)
>
> 	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
>
> -	/* fallback socket will not get data_fin/ack, can move to the next
> -	 * state now
> -	 */
> -	if (__mptcp_check_fallback(msk)) {
> -		WRITE_ONCE(msk->snd_una, msk->write_seq);
> -		if ((1 << sk->sk_state) & (TCPF_CLOSING | TCPF_LAST_ACK)) {
> -			inet_sk_state_store(sk, TCP_CLOSE);
> -			mptcp_close_wake_up(sk);
> -		} else if (sk->sk_state == TCP_FIN_WAIT1) {
> -			inet_sk_state_store(sk, TCP_FIN_WAIT2);
> -		}
> -	}
> -
> 	mptcp_for_each_subflow(msk, subflow) {
> 		struct sock *tcp_sk = mptcp_subflow_tcp_sock(subflow);
>
> @@ -2967,7 +2956,7 @@ static void __mptcp_wr_shutdown(struct sock *sk)
> 	WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
> 	WRITE_ONCE(msk->snd_data_fin_enable, 1);
>
> -	__mptcp_check_send_data_fin(sk);
> +	mptcp_check_send_data_fin(sk);
> }
>
> static void __mptcp_destroy_sock(struct sock *sk)
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index c7001a23550a..9ee3b7abbaf6 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1757,14 +1757,16 @@ static void subflow_state_change(struct sock *sk)
> {
> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> 	struct sock *parent = subflow->conn;
> +	struct mptcp_sock *msk;
>
> 	__subflow_state_change(sk);
>
> +	msk = mptcp_sk(parent);
> 	if (subflow_simultaneous_connect(sk)) {
> 		mptcp_propagate_sndbuf(parent, sk);
> 		mptcp_do_fallback(sk);
> -		mptcp_rcv_space_init(mptcp_sk(parent), sk);
> -		pr_fallback(mptcp_sk(parent));
> +		mptcp_rcv_space_init(msk, sk);
> +		pr_fallback(msk);
> 		subflow->conn_finished = 1;
> 		mptcp_set_connected(parent);
> 	}
> @@ -1780,11 +1782,12 @@ static void subflow_state_change(struct sock *sk)
>
> 	subflow_sched_work_if_closed(mptcp_sk(parent), sk);
>
> -	if (__mptcp_check_fallback(mptcp_sk(parent)) &&
> -	    !subflow->rx_eof && subflow_is_done(sk)) {
> -		subflow->rx_eof = 1;
> -		mptcp_subflow_eof(parent);
> -	}
> +	/* when the fallback subflow closes the rx side, trigger a 'dummy'
> +	 * ingress data fin, so that the msk state will follow along
> +	 */
> +	if (__mptcp_check_fallback(msk) && subflow_is_done(sk) && msk->first == sk &&
> +	    mptcp_update_rcv_data_fin(msk, READ_ONCE(msk->ack_seq), true))
> +		mptcp_schedule_work(parent);
> }
>
> void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_ssk)
> -- 
> 2.40.1
>
>
>
