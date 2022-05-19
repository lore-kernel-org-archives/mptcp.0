Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FF47B
	for <mptcp@lists.linux.dev>; Thu, 19 May 2022 00:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652920142; x=1684456142;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ysiogHjmumr8Kbc9Yp9xxVo6MaZQQbIGF1ZuAe68HRE=;
  b=QQtYPZx22EDMEpsjrSKdhX69KxG5KJw/j9ZNluBuyuefcNZY9QuqbTdy
   42zY61OT/rPx6zCudSaVun0whxrb3AoVgxSgvc8RH1IIZysVB0n6RgLCa
   QU4mVEOGWDONQg/udnbvtqFljyYwTq+xYN2xG44cqOiGNrOY3oQFGSPen
   Cj0uiMKXRewTe0okXebtXIba0HI7vlmCLMlfyIGpNIBqjy6Txm8VFpymR
   EPUjy53g8nu9v5bTWG2GF7A6zqipicYvB6+rftcSw4H5vAUUjEFqxjaFb
   dQfKGBZcq8TYF3Wu4a+7FfJTJacaflIMTIPUQlc0btrzJo1F+smzQipAj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="358360287"
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; 
   d="scan'208";a="358360287"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 17:29:01 -0700
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; 
   d="scan'208";a="569836000"
Received: from asova-mobl.amr.corp.intel.com ([10.209.69.6])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 17:29:01 -0700
Date: Wed, 18 May 2022 17:28:54 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 02/17] mptcp: move mptcp_subflow_context in
 net/mptcp.h
In-Reply-To: <b06c5cd73cb6f6bd8c57cd1b23c95ca365b30708.1652853898.git.geliang.tang@suse.com>
Message-ID: <8573a785-26d2-c69b-e18b-fc3a5220e4f3@linux.intel.com>
References: <cover.1652853898.git.geliang.tang@suse.com> <b06c5cd73cb6f6bd8c57cd1b23c95ca365b30708.1652853898.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 18 May 2022, Geliang Tang wrote:

> Move struct mptcp_subflow_context definition from net/mptcp/protocol.h
> to include/net/mptcp.h. And move the related struct mptcp_data_avail and
> function mptcp_subflow_ctx() too.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

I'm not sure I agree with moving all of this just because Martin asked 
about an inline function. I'll follow up on the netdev email thread.

- Mat

> ---
> include/net/mptcp.h  | 91 ++++++++++++++++++++++++++++++++++++++++++++
> net/mptcp/protocol.h | 88 ------------------------------------------
> 2 files changed, 91 insertions(+), 88 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 4713757e36c1..9422b6d2a268 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -40,6 +40,86 @@ struct mptcp_ext {
> };
>
> #define MPTCPOPT_HMAC_LEN	20
> +
> +enum mptcp_data_avail {
> +	MPTCP_SUBFLOW_NODATA,
> +	MPTCP_SUBFLOW_DATA_AVAIL,
> +};
> +
> +/* MPTCP subflow context */
> +struct mptcp_subflow_context {
> +	struct	list_head node;/* conn_list of subflows */
> +
> +	struct_group(reset,
> +
> +	unsigned long avg_pacing_rate; /* protected by msk socket lock */
> +	u64	local_key;
> +	u64	remote_key;
> +	u64	idsn;
> +	u64	map_seq;
> +	u32	snd_isn;
> +	u32	token;
> +	u32	rel_write_seq;
> +	u32	map_subflow_seq;
> +	u32	ssn_offset;
> +	u32	map_data_len;
> +	__wsum	map_data_csum;
> +	u32	map_csum_len;
> +	u32	request_mptcp : 1,  /* send MP_CAPABLE */
> +		request_join : 1,   /* send MP_JOIN */
> +		request_bkup : 1,
> +		mp_capable : 1,	    /* remote is MPTCP capable */
> +		mp_join : 1,	    /* remote is JOINing */
> +		fully_established : 1,	    /* path validated */
> +		pm_notified : 1,    /* PM hook called for established status */
> +		conn_finished : 1,
> +		map_valid : 1,
> +		map_csum_reqd : 1,
> +		map_data_fin : 1,
> +		mpc_map : 1,
> +		backup : 1,
> +		send_mp_prio : 1,
> +		send_mp_fail : 1,
> +		send_fastclose : 1,
> +		send_infinite_map : 1,
> +		rx_eof : 1,
> +		can_ack : 1,        /* only after processing the remote a key */
> +		disposable : 1,	    /* ctx can be free at ulp release time */
> +		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
> +		local_id_valid : 1, /* local_id is correctly initialized */
> +		valid_csum_seen : 1;        /* at least one csum validated */
> +	enum mptcp_data_avail data_avail;
> +	bool	mp_fail_response_expect;
> +	u32	remote_nonce;
> +	u64	thmac;
> +	u32	local_nonce;
> +	u32	remote_token;
> +	u8	hmac[MPTCPOPT_HMAC_LEN];
> +	u8	local_id;
> +	u8	remote_id;
> +	u8	reset_seen:1;
> +	u8	reset_transient:1;
> +	u8	reset_reason:4;
> +	u8	stale_count;
> +
> +	long	delegated_status;
> +
> +	);
> +
> +	struct	list_head delegated_node;   /* link into delegated_action, protected by local BH */
> +
> +	u32	setsockopt_seq;
> +	u32	stale_rcv_tstamp;
> +
> +	struct	sock *tcp_sock;	    /* tcp sk backpointer */
> +	struct	sock *conn;	    /* parent mptcp_sock */
> +	const	struct inet_connection_sock_af_ops *icsk_af_ops;
> +	void	(*tcp_state_change)(struct sock *sk);
> +	void	(*tcp_error_report)(struct sock *sk);
> +
> +	struct	rcu_head rcu;
> +};
> +
> #define MPTCP_RM_IDS_MAX	8
>
> struct mptcp_rm_list {
> @@ -198,6 +278,15 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
>
> 	return htonl(0u);
> }
> +
> +static inline struct mptcp_subflow_context *
> +mptcp_subflow_ctx(const struct sock *sk)
> +{
> +	struct inet_connection_sock *icsk = inet_csk(sk);
> +
> +	/* Use RCU on icsk_ulp_data only for sock diag code */
> +	return (__force struct mptcp_subflow_context *)icsk->icsk_ulp_data;
> +}
> #else
>
> static inline void mptcp_init(void)
> @@ -275,6 +364,8 @@ static inline int mptcp_subflow_init_cookie_req(struct request_sock *req,
> }
>
> static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
> +static inline struct mptcp_subflow_context *
> +mptcp_subflow_ctx(const struct sock *sk) { return NULL; }
> #endif /* CONFIG_MPTCP */
>
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 8f03775a2f22..cc24756cedfe 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -409,11 +409,6 @@ mptcp_subflow_rsk(const struct request_sock *rsk)
> 	return (struct mptcp_subflow_request_sock *)rsk;
> }
>
> -enum mptcp_data_avail {
> -	MPTCP_SUBFLOW_NODATA,
> -	MPTCP_SUBFLOW_DATA_AVAIL,
> -};
> -
> struct mptcp_delegated_action {
> 	struct napi_struct napi;
> 	struct list_head head;
> @@ -424,89 +419,6 @@ DECLARE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
> #define MPTCP_DELEGATE_SEND		0
> #define MPTCP_DELEGATE_ACK		1
>
> -/* MPTCP subflow context */
> -struct mptcp_subflow_context {
> -	struct	list_head node;/* conn_list of subflows */
> -
> -	struct_group(reset,
> -
> -	unsigned long avg_pacing_rate; /* protected by msk socket lock */
> -	u64	local_key;
> -	u64	remote_key;
> -	u64	idsn;
> -	u64	map_seq;
> -	u32	snd_isn;
> -	u32	token;
> -	u32	rel_write_seq;
> -	u32	map_subflow_seq;
> -	u32	ssn_offset;
> -	u32	map_data_len;
> -	__wsum	map_data_csum;
> -	u32	map_csum_len;
> -	u32	request_mptcp : 1,  /* send MP_CAPABLE */
> -		request_join : 1,   /* send MP_JOIN */
> -		request_bkup : 1,
> -		mp_capable : 1,	    /* remote is MPTCP capable */
> -		mp_join : 1,	    /* remote is JOINing */
> -		fully_established : 1,	    /* path validated */
> -		pm_notified : 1,    /* PM hook called for established status */
> -		conn_finished : 1,
> -		map_valid : 1,
> -		map_csum_reqd : 1,
> -		map_data_fin : 1,
> -		mpc_map : 1,
> -		backup : 1,
> -		send_mp_prio : 1,
> -		send_mp_fail : 1,
> -		send_fastclose : 1,
> -		send_infinite_map : 1,
> -		rx_eof : 1,
> -		can_ack : 1,        /* only after processing the remote a key */
> -		disposable : 1,	    /* ctx can be free at ulp release time */
> -		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
> -		local_id_valid : 1, /* local_id is correctly initialized */
> -		valid_csum_seen : 1;        /* at least one csum validated */
> -	enum mptcp_data_avail data_avail;
> -	bool	mp_fail_response_expect;
> -	u32	remote_nonce;
> -	u64	thmac;
> -	u32	local_nonce;
> -	u32	remote_token;
> -	u8	hmac[MPTCPOPT_HMAC_LEN];
> -	u8	local_id;
> -	u8	remote_id;
> -	u8	reset_seen:1;
> -	u8	reset_transient:1;
> -	u8	reset_reason:4;
> -	u8	stale_count;
> -
> -	long	delegated_status;
> -
> -	);
> -
> -	struct	list_head delegated_node;   /* link into delegated_action, protected by local BH */
> -
> -	u32	setsockopt_seq;
> -	u32	stale_rcv_tstamp;
> -
> -	struct	sock *tcp_sock;	    /* tcp sk backpointer */
> -	struct	sock *conn;	    /* parent mptcp_sock */
> -	const	struct inet_connection_sock_af_ops *icsk_af_ops;
> -	void	(*tcp_state_change)(struct sock *sk);
> -	void	(*tcp_error_report)(struct sock *sk);
> -
> -	struct	rcu_head rcu;
> -};
> -
> -static inline struct mptcp_subflow_context *
> -mptcp_subflow_ctx(const struct sock *sk)
> -{
> -	struct inet_connection_sock *icsk = inet_csk(sk);
> -
> -	/* Use RCU on icsk_ulp_data only for sock diag code */
> -	return (__force struct mptcp_subflow_context *)icsk->icsk_ulp_data;
> -}
> -
> static inline struct sock *
> mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
> {
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
