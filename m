Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9A52F39
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 23:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644448704; x=1675984704;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FEaldsnhS0/49p7i9NjYxhoC6xIQFqbuAwZIByXG+0Y=;
  b=YWv/NZWRPOVCAQZRaC6OXLwaXiEnxzjvyXkD31niy7lU9nL3YoTHCe5s
   HuttBjZnFbJzl/bZHzLLRCN2GjVq3x7/H7s3w5vjS0MTsqL/uQg7Hyxkj
   ckFu7pkroNvvU4cx2ojAuZH/PFnm8fRLgyzkWUKZHjzK+lUVjnNWRP/te
   Eg9ZnnfN76I04RdTviUibCCS+iaga9OEKrr7cxfiD8hHs/bl7B9EEIkq3
   ItG7vpu+ziKeYyDmjxEm4Hn69y/1c5p56m8FKS1Ppi4HfxIJovERSO4vY
   6/C/r6+Y8wPZTRPtJ5fYepQARtzkwpCDxRmerigcxKJk4S6Lj5gSk/Vl/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="246947836"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="246947836"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 15:18:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="701453206"
Received: from halucas-mobl3.amr.corp.intel.com ([10.212.241.159])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 15:18:19 -0800
Date: Wed, 9 Feb 2022 15:18:19 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: don't save tcp data_ready and write
 space callbacks
In-Reply-To: <20220209101133.19514-1-fw@strlen.de>
Message-ID: <28823aca-ba8-8d18-629b-a95e18643889@linux.intel.com>
References: <20220209101133.19514-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 9 Feb 2022, Florian Westphal wrote:

> Assign the helpers directly rather than save/restore in the context
> structure.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
> net/mptcp/protocol.h | 6 ++----
> net/mptcp/subflow.c  | 4 ----
> 2 files changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index f37f087caab3..202004473292 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -479,9 +479,7 @@ struct mptcp_subflow_context {
> 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
> 	struct	sock *conn;	    /* parent mptcp_sock */
> 	const	struct inet_connection_sock_af_ops *icsk_af_ops;
> -	void	(*tcp_data_ready)(struct sock *sk);
> 	void	(*tcp_state_change)(struct sock *sk);
> -	void	(*tcp_write_space)(struct sock *sk);
> 	void	(*tcp_error_report)(struct sock *sk);
>
> 	struct	rcu_head rcu;
> @@ -626,9 +624,9 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow);
> static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
> 					      struct mptcp_subflow_context *ctx)
> {
> -	sk->sk_data_ready = ctx->tcp_data_ready;
> +	sk->sk_data_ready = sock_def_readable;
> 	sk->sk_state_change = ctx->tcp_state_change;
> -	sk->sk_write_space = ctx->tcp_write_space;
> +	sk->sk_write_space = sk_stream_write_space;
> 	sk->sk_error_report = ctx->tcp_error_report;
>
> 	inet_csk(sk)->icsk_af_ops = ctx->icsk_af_ops;
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 485f00dcaf84..d4b4d285ffc1 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1661,9 +1661,7 @@ static int subflow_ulp_init(struct sock *sk)
> 	tp->is_mptcp = 1;
> 	ctx->icsk_af_ops = icsk->icsk_af_ops;
> 	icsk->icsk_af_ops = subflow_default_af_ops(sk);
> -	ctx->tcp_data_ready = sk->sk_data_ready;
> 	ctx->tcp_state_change = sk->sk_state_change;
> -	ctx->tcp_write_space = sk->sk_write_space;
> 	ctx->tcp_error_report = sk->sk_error_report;
> 	sk->sk_data_ready = subflow_data_ready;
> 	sk->sk_write_space = subflow_write_space;


Should we add any paranoid BUG_ON() checks to confirm that these sk 
members are still set to sock_def_readable/sk_stream_write_space by TCP?

I don't expect those to ever change... but it seems better to not assume.

-Mat


> @@ -1719,9 +1717,7 @@ static void subflow_ulp_clone(const struct request_sock *req,
>
> 	new_ctx->conn_finished = 1;
> 	new_ctx->icsk_af_ops = old_ctx->icsk_af_ops;
> -	new_ctx->tcp_data_ready = old_ctx->tcp_data_ready;
> 	new_ctx->tcp_state_change = old_ctx->tcp_state_change;
> -	new_ctx->tcp_write_space = old_ctx->tcp_write_space;
> 	new_ctx->tcp_error_report = old_ctx->tcp_error_report;
> 	new_ctx->rel_write_seq = 1;
> 	new_ctx->tcp_sock = newsk;
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
