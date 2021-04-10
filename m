Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B4D70
	for <mptcp@lists.linux.dev>; Sat, 10 Apr 2021 00:12:05 +0000 (UTC)
IronPort-SDR: dLnFALlpXZ+3SmpRg15Vf1qeXQ1zgvPb0l3es3vsviMx/C80n0fZXlFDcta15QtMHYE0OCLLGJ
 beTRYY+KUn4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="193975894"
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="193975894"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 17:12:04 -0700
IronPort-SDR: Kv6n4mIh0oUEslMT+uscGToRJ1MDD8uv1BKXfkc/KaQxATEqjfazOH/VncMOQTOBPMraJ6xpL6
 pp04p3en7G3A==
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="419708553"
Received: from gbean-mobl.amr.corp.intel.com ([10.254.114.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 17:12:04 -0700
Date: Fri, 9 Apr 2021 17:12:03 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp 02/10] mptcp: tag sequence_seq with socket state
In-Reply-To: <20210408184936.6245-3-fw@strlen.de>
Message-ID: <9f60e0e9-a44f-b659-14f6-f91161cf6569@linux.intel.com>
References: <20210408184936.6245-1-fw@strlen.de> <20210408184936.6245-3-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 8 Apr 2021, Florian Westphal wrote:

> Paolo Abeni suggested to avoid re-syncing new subflows because
> they inherit options from listener. In case options were set on
> listener but are not set on mptcp-socket there is no need to
> do any synchronisation for new subflows.
>
> This change sets sockopt_seq of new mptcp sockets to the seq of
> the mptcp listener sock.
>
> Subflow sequence is set to the embedded tcp listener sk.
> Add a comment explaing why sk_state is involved in sockopt_seq
> generation.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
> net/mptcp/protocol.c | 16 ++++++++++-----
> net/mptcp/protocol.h |  4 ++++
> net/mptcp/sockopt.c  | 47 ++++++++++++++++++++++++++++++++++++++++++--
> net/mptcp/subflow.c  |  4 ++++
> 4 files changed, 64 insertions(+), 7 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2233baf03c3a..26e3ffe8840e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -729,11 +729,14 @@ static bool mptcp_do_flush_join_list(struct mptcp_sock *msk)
> 	if (likely(list_empty(&msk->join_list)))
> 		return false;
>
> -	ret = true;
> 	spin_lock_bh(&msk->join_list_lock);
> -	list_for_each_entry(subflow, &msk->join_list, node)
> -		mptcp_propagate_sndbuf((struct sock *)msk, mptcp_subflow_tcp_sock(subflow));
> +	list_for_each_entry(subflow, &msk->join_list, node) {
> +		u32 sseq = READ_ONCE(subflow->setsockopt_seq);
>
> +		mptcp_propagate_sndbuf((struct sock *)msk, mptcp_subflow_tcp_sock(subflow));
> +		if (READ_ONCE(msk->setsockopt_seq) != sseq)
> +			ret = true;
> +	}
> 	list_splice_tail_init(&msk->join_list, &msk->conn_list);
> 	spin_unlock_bh(&msk->join_list_lock);
>
> @@ -745,7 +748,8 @@ void __mptcp_flush_join_list(struct mptcp_sock *msk)
> 	if (likely(!mptcp_do_flush_join_list(msk)))
> 		return;
>
> -	if (!test_and_set_bit(MPTCP_WORK_SYNC_SETSOCKOPT, &msk->flags))
> +	if (msk->setsockopt_seq &&
> +	    !test_and_set_bit(MPTCP_WORK_SYNC_SETSOCKOPT, &msk->flags))
> 		mptcp_schedule_work((struct sock *)msk);
> }
>
> @@ -758,7 +762,8 @@ static void mptcp_flush_join_list(struct mptcp_sock *msk)
> 	if (!mptcp_do_flush_join_list(msk) && !sync_needed)
> 		return;
>
> -	mptcp_sockopt_sync_all(msk);
> +	if (msk->setsockopt_seq)
> +		mptcp_sockopt_sync_all(msk);
> }
>
> static bool mptcp_timer_pending(struct sock *sk)
> @@ -2712,6 +2717,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
> 	msk->snd_nxt = msk->write_seq;
> 	msk->snd_una = msk->write_seq;
> 	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
> +	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
>
> 	if (mp_opt->mp_capable) {
> 		msk->can_ack = true;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 55fe05a40216..edc0128730df 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -256,6 +256,8 @@ struct mptcp_sock {
> 		u64	time;	/* start time of measurement window */
> 		u64	rtt_us; /* last maximum rtt of subflows */
> 	} rcvq_space;
> +
> +	u32 setsockopt_seq;
> };
>
> #define mptcp_lock_sock(___sk, cb) do {					\
> @@ -414,6 +416,8 @@ struct mptcp_subflow_context {
> 	long	delegated_status;
> 	struct	list_head delegated_node;   /* link into delegated_action, protected by local BH */
>
> +	u32 setsockopt_seq;
> +
> 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
> 	struct	sock *conn;	    /* parent mptcp_sock */
> 	const	struct inet_connection_sock_af_ops *icsk_af_ops;
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 4fdc0ad6acf7..b1950be15abe 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -24,6 +24,27 @@ static struct sock *__mptcp_tcp_fallback(struct mptcp_sock *msk)
> 	return msk->first;
> }
>
> +static u32 sockopt_seq_reset(const struct sock *sk)
> +{
> +	sock_owned_by_me(sk);
> +
> +	/* Highbits contain state.  Allows to distinguish sockopt_seq
> +	 * of listener and established:
> +	 * s0 = new_listener()
> +	 * sockopt(s0) - seq is 1
> +	 * s1 = accept(s0) - s1 inherits seq 1 if listener sk (s0)
> +	 * sockopt(s0) - seq increments to 2 on s0
> +	 * sockopt(s1) // seq increments to 2 on s1 (different option)
> +	 * new ssk completes join, inherits options from s0 // seq 2
> +	 * Needs sync from mptcp join logic, but ssk->seq == msk->seq
> +	 *
> +	 * Set High order bits to sk_state so ssk->seq == msk->seq test
> +	 * will fail.
> +	 */
> +
> +	return sk->sk_state << 24u;

I think this works because sk->sk_state gets automatically promoted to an 
int, but maybe "(u32)sk->sk_state << 24" is the intent?

> +}
> +
> static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
> 				       sockptr_t optval, unsigned int optlen)
> {
> @@ -350,22 +371,44 @@ int mptcp_getsockopt(struct sock *sk, int level, int optname,
> 	return -EOPNOTSUPP;
> }
>
> +static void __mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)
> +{
> +}
> +
> void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)
> {
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> +
> 	msk_owned_by_me(msk);
> +
> +	if (READ_ONCE(subflow->setsockopt_seq) != msk->setsockopt_seq) {
> +		__mptcp_sockopt_sync(msk, ssk);
> +
> +		subflow->setsockopt_seq = msk->setsockopt_seq;
> +	}
> }
>
> void mptcp_sockopt_sync_all(struct mptcp_sock *msk)
> {
> 	struct mptcp_subflow_context *subflow;
> +	struct sock *sk = (struct sock *)msk;
> +	u32 seq;
>
> -	msk_owned_by_me(msk);
> +	seq = sockopt_seq_reset(sk);
>
> 	mptcp_for_each_subflow(msk, subflow) {
> 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +		u32 sseq = READ_ONCE(subflow->setsockopt_seq);
>
> -		mptcp_sockopt_sync(msk, ssk);
> +		if (sseq != msk->setsockopt_seq) {
> +			__mptcp_sockopt_sync(msk, ssk);
> +			WRITE_ONCE(subflow->setsockopt_seq, seq);
> +		} else if (sseq != seq) {
> +			WRITE_ONCE(subflow->setsockopt_seq, seq);
> +		}
>
> 		cond_resched();
> 	}
> +
> +	msk->setsockopt_seq = seq;

One of my comments on the first RFC of this series was a a suggestion to 
avoid setsockopt_seq overflow by resetting it in mptcp_sockopt_sync_all() 
- which this code does!

What I didn't realize at that time was that mptcp_sockopt_sync_all() might 
not be called for a very long time (or at all?) if there are no joins to 
trigger it. To really protect against overflow, mptcp_setsockopt() can 
call (or schedule) mptcp_sockopt_sync_all() if the non-sk_state bits of 
msk->setsockopt_seq exceed a threshold.

> }
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index fc7107f8d81b..82e91b00ad39 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -681,6 +681,9 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
> 			goto out;
> 		}
>
> +		/* ssk inherits options of listener sk */
> +		ctx->setsockopt_seq = listener->setsockopt_seq;
> +
> 		if (ctx->mp_capable) {
> 			/* this can't race with mptcp_close(), as the msk is
> 			 * not yet exposted to user-space
> @@ -696,6 +699,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
> 			 * created mptcp socket
> 			 */
> 			new_msk->sk_destruct = mptcp_sock_destruct;
> +			mptcp_sk(new_msk)->setsockopt_seq = ctx->setsockopt_seq;
> 			mptcp_pm_new_connection(mptcp_sk(new_msk), child, 1);
> 			mptcp_token_accept(subflow_req, mptcp_sk(new_msk));
> 			ctx->conn = new_msk;
> -- 
> 2.26.3
>
>
>

--
Mat Martineau
Intel
