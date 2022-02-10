Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279FB2F26
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 20:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644525671; x=1676061671;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5N78OQpjRhq7VAOa3xxiScFmBTojXbY6xZrwbukk+GE=;
  b=WNaB+OPK6x7yAgaQI+teFrZiATE83Oe4CFs2ua+UdJwEQhVLR4iI8kqg
   Kzx7hleFdKp981VJTfObVEJ14um0aUHRxtRI41abIKh5Z2ZaqbYvTbsnN
   nncOM/VJuxMoNQn80Q507oIPf4FPUctuS9odnAbq0pbtFkEpUPKEM641r
   F4TXRaWbMYd7vixbzPmLf5SlqVhV7/Srld4GvsgCbHelkZzWHVq9EgEzJ
   3lQfrBwDIcA1cFakrXXIH/YAeKcNmBdIuXwMJOafDuehvXraeTX810wnM
   S7v8WgsYF0EJQuIfWlyO6p/TqQ1VNXJn3PP4xrddEg3XLWRfaLbiuggDT
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="274141710"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="274141710"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 12:41:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="500533663"
Received: from dbosneag-mobl1.amr.corp.intel.com ([10.212.211.192])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 12:41:10 -0800
Date: Thu, 10 Feb 2022 12:41:09 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next] mptcp: don't save tcp data_ready and write
 space callbacks
In-Reply-To: <20220210144839.26742-1-fw@strlen.de>
Message-ID: <e4b91f10-805e-4448-448a-df9753daebc5@linux.intel.com>
References: <20220210144839.26742-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 10 Feb 2022, Florian Westphal wrote:

> Assign the helpers directly rather than save/restore in the context
> structure.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>

Thanks for the v2.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> ---
> net/mptcp/protocol.h | 6 ++----
> net/mptcp/subflow.c  | 8 ++++----
> 2 files changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 0eebfc9f39bc..3937ea3f6759 100644
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
> index 485f00dcaf84..0e929aa71b18 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1661,10 +1661,12 @@ static int subflow_ulp_init(struct sock *sk)
> 	tp->is_mptcp = 1;
> 	ctx->icsk_af_ops = icsk->icsk_af_ops;
> 	icsk->icsk_af_ops = subflow_default_af_ops(sk);
> -	ctx->tcp_data_ready = sk->sk_data_ready;
> 	ctx->tcp_state_change = sk->sk_state_change;
> -	ctx->tcp_write_space = sk->sk_write_space;
> 	ctx->tcp_error_report = sk->sk_error_report;
> +
> +	WARN_ON_ONCE(sk->sk_data_ready != sock_def_readable);
> +	WARN_ON_ONCE(sk->sk_write_space != sk_stream_write_space);
> +
> 	sk->sk_data_ready = subflow_data_ready;
> 	sk->sk_write_space = subflow_write_space;
> 	sk->sk_state_change = subflow_state_change;
> @@ -1719,9 +1721,7 @@ static void subflow_ulp_clone(const struct request_sock *req,
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
