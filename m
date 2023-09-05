Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4DA101CF
	for <mptcp@lists.linux.dev>; Tue,  5 Sep 2023 22:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A583C433C7;
	Tue,  5 Sep 2023 22:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693951203;
	bh=SFWAJCNBlK7m6BaMeLt4uxt8vu4vJE80/SExcNWGVgg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ozjNZYiuPfBgzNhooA12KKNbkHOV4zVcJHM8DUV/hz2AAMdrw/Ux0LfcGiZISeGMs
	 vvFfiDuVzeQXeqEkTur1oXBMlY0l7qcRS+CBtUw1j0gGaouVkMARNkXGD9NcTWAmFp
	 jJq2j4fhpKvOlvOvAC24Hz6UO26QCwJ5zjcJ7QwrZ5vLPU1i2iCIVG0asuZqjk1bHA
	 R4IIc2H2JA7rO8Xy++UupHiHISfA/BUXVzT1tkYkgX36zTD2zwhPd4Z21BREJmU/f+
	 hs1+bQjFahtATxo5AzmASBOy0WH2k8hvGk8QVAHNSvU6o+mvgDysibgqsDP85oF/r1
	 iO1sTdsDehuWw==
Date: Tue, 5 Sep 2023 14:59:57 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 2/2] mptcp: implement connection level
 timeout.
In-Reply-To: <382adc94e31c46ade28566d5787dd9d531329c51.1693565414.git.pabeni@redhat.com>
Message-ID: <c06fc4bd-f74b-e458-f188-8f5a84f9cb34@kernel.org>
References: <cover.1693565414.git.pabeni@redhat.com> <382adc94e31c46ade28566d5787dd9d531329c51.1693565414.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 1 Sep 2023, Paolo Abeni wrote:

> According to RFC 8684 section 3.3:
>
>  A connection is not closed unless [...] or an implementation-specific
>  connection-level send timeout.
>
> Currently the MPTCP protocol does not implement such timeout, and
> connection timing-out at the TCP-level never move to close state.
>
> Introduces a catch-up condition at subflow close time to move the
> MPTCP socket to close, too.
>
> That additionally allow removing similar existing inside the worker.
>
> Finally, allow some additional timeout for plain ESTABLISHED mptcp
> sockets, as the protocol allows creating new subflows even at that
> point and making the connection functional again.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/430
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thanks for the reply to my first review - adding the sysctl as a follow-on 
commit is a good idea.

New comment below:

> ---
> v2 -> v3:
> - fix integer overflow in mptcp_close_tout_expired()
> v1 -> v2:
> - really set the close timeout as need.
> ---
> net/mptcp/protocol.c | 84 +++++++++++++++++++++-----------------------
> net/mptcp/protocol.h | 20 +++++++++++
> net/mptcp/subflow.c  |  1 +
> 3 files changed, 62 insertions(+), 43 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 33093ed87077..80d06cab8bc7 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -886,6 +886,7 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
> 	mptcp_subflow_ctx(ssk)->subflow_id = msk->subflow_id++;
> 	mptcp_sockopt_sync_locked(msk, ssk);
> 	mptcp_subflow_joined(msk, ssk);
> +	mptcp_stop_tout_timer(sk);
> 	return true;
> }
>
> @@ -2363,18 +2364,15 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> 	bool dispose_it, need_push = false;
>
> 	/* If the first subflow moved to a close state before accept, e.g. due
> -	 * to an incoming reset, mptcp either:
> -	 * - if either the subflow or the msk are dead, destroy the context
> -	 *   (the subflow socket is deleted by inet_child_forget) and the msk
> -	 * - otherwise do nothing at the moment and take action at accept and/or
> -	 *   listener shutdown - user-space must be able to accept() the closed
> -	 *   socket.
> +	 * to an incoming reset or listener shoutdown, the subflow socket is
> +	 * already deleted by inet_child_forget() the mptcp socket can't survive
> +	 * too.
> 	 */
> -	if (msk->in_accept_queue && msk->first == ssk) {
> -		if (!sock_flag(sk, SOCK_DEAD) && !sock_flag(ssk, SOCK_DEAD))
> -			return;
> -
> +	if (msk->in_accept_queue && msk->first == ssk &&
> +	    (sock_flag(sk, SOCK_DEAD) || sock_flag(ssk, SOCK_DEAD))) {
> 		/* ensure later check in mptcp_worker() will dispose the msk */
> +		inet_csk(sk)->icsk_mtup.probe_timestamp = tcp_jiffies32 -
> +							  (TCP_TIMEWAIT_LEN + 1);

Should make sure this is a non-zero value, to avoid the very tiny chance 
that the socket gets stuck forever if tcp_jiffies32 wrapped around at 
exactly the wrong time. (like the check in mptcp_start_tout_timer() 
below)

Can also fix the 'shoutdown' typo above in v5 :)


- Mat

> 		sock_set_flag(sk, SOCK_DEAD);
> 		lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
> 		mptcp_subflow_drop_ctx(ssk);
> @@ -2437,6 +2435,22 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> out:
> 	if (need_push)
> 		__mptcp_push_pending(sk, 0);
> +
> +	/* Catch every 'all subflows closed' scenario, including peers silently
> +	 * closing them, e.g. due to timeout.
> +	 * For established sockets, allow an additional timeout before closing,
> +	 * as the protocol can still create more subflows.
> +	 */
> +	if (list_is_singular(&msk->conn_list) && msk->first &&
> +	    inet_sk_state_load(msk->first) == TCP_CLOSE) {
> +		if (sk->sk_state != TCP_ESTABLISHED ||
> +		    msk->in_accept_queue || sock_flag(sk, SOCK_DEAD)) {
> +			inet_sk_state_store(sk, TCP_CLOSE);
> +			mptcp_close_wake_up(sk);
> +		} else {
> +			mptcp_start_tout_timer(sk);
> +		}
> +	}
> }
>
> void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> @@ -2480,23 +2494,14 @@ static void __mptcp_close_subflow(struct sock *sk)
>
> }
>
> -static bool mptcp_should_close(const struct sock *sk)
> +static bool mptcp_close_tout_expired(const struct sock *sk)
> {
> -	s32 delta = tcp_jiffies32 - inet_csk(sk)->icsk_mtup.probe_timestamp;
> -	struct mptcp_subflow_context *subflow;
> -
> -	if (delta >= TCP_TIMEWAIT_LEN || mptcp_sk(sk)->in_accept_queue)
> -		return true;
> +	if (!inet_csk(sk)->icsk_mtup.probe_timestamp ||
> +	    sk->sk_state == TCP_CLOSE)
> +		return false;
>
> -	/* if all subflows are in closed status don't bother with additional
> -	 * timeout
> -	 */
> -	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
> -		if (inet_sk_state_load(mptcp_subflow_tcp_sock(subflow)) !=
> -		    TCP_CLOSE)
> -			return false;
> -	}
> -	return true;
> +	return time_after32(tcp_jiffies32,
> +		  inet_csk(sk)->icsk_mtup.probe_timestamp + TCP_TIMEWAIT_LEN);
> }
>
> static void mptcp_check_fastclose(struct mptcp_sock *msk)
> @@ -2635,7 +2640,7 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
> 	struct sock *sk = (struct sock *)msk;
> 	unsigned long timeout, close_timeout;
>
> -	if (!fail_tout && !sock_flag(sk, SOCK_DEAD))
> +	if (!fail_tout && !inet_csk(sk)->icsk_mtup.probe_timestamp)
> 		return;
>
> 	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies + TCP_TIMEWAIT_LEN;
> @@ -2643,7 +2648,7 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
> 	/* the close timeout takes precedence on the fail one, and here at least one of
> 	 * them is active
> 	 */
> -	timeout = sock_flag(sk, SOCK_DEAD) ? close_timeout : fail_tout;
> +	timeout = inet_csk(sk)->icsk_mtup.probe_timestamp ? close_timeout : fail_tout;
>
> 	sk_reset_timer(sk, &sk->sk_timer, timeout);
> }
> @@ -2662,8 +2667,6 @@ static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
> 	mptcp_subflow_reset(ssk);
> 	WRITE_ONCE(mptcp_subflow_ctx(ssk)->fail_tout, 0);
> 	unlock_sock_fast(ssk, slow);
> -
> -	mptcp_reset_tout_timer(msk, 0);
> }
>
> static void mptcp_do_fastclose(struct sock *sk)
> @@ -2700,18 +2703,14 @@ static void mptcp_worker(struct work_struct *work)
> 	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
> 		__mptcp_close_subflow(sk);
>
> -	/* There is no point in keeping around an orphaned sk timedout or
> -	 * closed, but we need the msk around to reply to incoming DATA_FIN,
> -	 * even if it is orphaned and in FIN_WAIT2 state
> -	 */
> -	if (sock_flag(sk, SOCK_DEAD)) {
> -		if (mptcp_should_close(sk))
> -			mptcp_do_fastclose(sk);
> +	if (mptcp_close_tout_expired(sk)) {
> +		mptcp_do_fastclose(sk);
> +		mptcp_close_wake_up(sk);
> +	}
>
> -		if (sk->sk_state == TCP_CLOSE) {
> -			__mptcp_destroy_sock(sk);
> -			goto unlock;
> -		}
> +	if (sock_flag(sk, SOCK_DEAD) && sk->sk_state == TCP_CLOSE) {
> +		__mptcp_destroy_sock(sk);
> +		goto unlock;
> 	}
>
> 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
> @@ -3010,7 +3009,6 @@ bool __mptcp_close(struct sock *sk, long timeout)
>
> cleanup:
> 	/* orphan all the subflows */
> -	inet_csk(sk)->icsk_mtup.probe_timestamp = tcp_jiffies32;
> 	mptcp_for_each_subflow(msk, subflow) {
> 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> 		bool slow = lock_sock_fast_nested(ssk);
> @@ -3047,7 +3045,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
> 		__mptcp_destroy_sock(sk);
> 		do_cancel_work = true;
> 	} else {
> -		mptcp_reset_tout_timer(msk, 0);
> +		mptcp_start_tout_timer(sk);
> 	}
>
> 	return do_cancel_work;
> @@ -3111,7 +3109,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
> 	inet_sk_state_store(sk, TCP_CLOSE);
>
> 	mptcp_stop_rtx_timer(sk);
> -	sk_stop_timer(sk, &sk->sk_timer);
> +	mptcp_stop_tout_timer(sk);
>
> 	if (msk->token)
> 		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 4fcce9ad7d04..392c2f247034 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -726,6 +726,26 @@ void mptcp_get_options(const struct sk_buff *skb,
> void mptcp_finish_connect(struct sock *sk);
> void __mptcp_set_connected(struct sock *sk);
> void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout);
> +
> +static inline void mptcp_stop_tout_timer(struct sock *sk)
> +{
> +	if (!inet_csk(sk)->icsk_mtup.probe_timestamp)
> +		return;
> +
> +	sk_stop_timer(sk, &sk->sk_timer);
> +	inet_csk(sk)->icsk_mtup.probe_timestamp = 0;
> +}
> +
> +static inline void mptcp_start_tout_timer(struct sock *sk)
> +{
> +	/* avoid 0 timestamp, at that means no close timeout */
> +	inet_csk(sk)->icsk_mtup.probe_timestamp = tcp_jiffies32;
> +	if (!inet_csk(sk)->icsk_mtup.probe_timestamp)
> +		inet_csk(sk)->icsk_mtup.probe_timestamp = 1;
> +
> +	mptcp_reset_tout_timer(mptcp_sk(sk), 0);
> +}
> +
> static inline bool mptcp_is_fully_established(struct sock *sk)
> {
> 	return inet_sk_state_load(sk) == TCP_ESTABLISHED &&
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 433f290984c8..918c1a235790 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1552,6 +1552,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
> 	mptcp_sock_graft(ssk, sk->sk_socket);
> 	iput(SOCK_INODE(sf));
> 	WRITE_ONCE(msk->allow_infinite_fallback, false);
> +	mptcp_stop_tout_timer(sk);
> 	return 0;
>
> failed_unlink:
> -- 
> 2.41.0
>
>
>
