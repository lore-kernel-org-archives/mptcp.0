Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDA872
	for <mptcp@lists.linux.dev>; Fri,  7 May 2021 00:46:24 +0000 (UTC)
IronPort-SDR: 4J6+9Szk+GVU60FD+p0uhE3wYuoj7zqbnzBn9NZ3DHzJ3cPk+8OlpStFutvE8yCFfs8ZHWF51U
 Z88y3zcxNKWg==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="185744387"
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="185744387"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 17:46:24 -0700
IronPort-SDR: 7AmVCvhD5bYRD3Lkq9L9ltRtOF9EOWqJuNwb7HFKH1lVNHzfhgGbu+q0/shkmNgPLACCuEP3sD
 Z2WBto4HilrQ==
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="407229066"
Received: from rjhaveri-mobl2.amr.corp.intel.com ([10.251.15.235])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 17:46:23 -0700
Date: Thu, 6 May 2021 17:46:22 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Christoph Paasch <cpaasch@apple.com>, 
    Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH mptcp-net] mptcp: avoid OOB access in setsockopt()
In-Reply-To: <79b377c2cb932a86f0fd1a17f814064dd1ad7015.1620321074.git.pabeni@redhat.com>
Message-ID: <8a188d76-6fa6-7a97-5045-a77969c8018@linux.intel.com>
References: <79b377c2cb932a86f0fd1a17f814064dd1ad7015.1620321074.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Thu, 6 May 2021, Paolo Abeni wrote:

> We can't use tcp_set_congestion_control() on an mptcp socket, as
> such function can end-up accessing a tcp-specific field -
> prior_ssthresh - causing an OOB access.
>
> To allow propagating the correct ca algo on subflow, cache the ca
> name at initialization time.
>
> Additionally avoid overriding the user-selected CA (if any) at
> clone time.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/182
> Fixes: aa1fbd94e5c7 ("mptcp: sockopt: add TCP_CONGESTION and TCP_INFO")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> @Christoph: could u please give this a spin?
> ---
> net/mptcp/protocol.c | 14 +++++++++++---
> net/mptcp/protocol.h |  1 +
> net/mptcp/sockopt.c  |  4 ++--
> 3 files changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 32a39774075b..627352c59416 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2437,8 +2437,6 @@ static int __mptcp_init_sock(struct sock *sk)
> 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
> 	timer_setup(&sk->sk_timer, mptcp_timeout_timer, 0);
>
> -	tcp_assign_congestion_control(sk);
> -
> #if IS_ENABLED(CONFIG_KASAN)
> 	sock_set_flag(sk, SOCK_RCU_FREE);
> #endif
> @@ -2448,6 +2446,7 @@ static int __mptcp_init_sock(struct sock *sk)
>
> static int mptcp_init_sock(struct sock *sk)
> {
> +	struct inet_connection_sock *icsk = inet_csk(sk);
> 	struct net *net = sock_net(sk);
> 	int ret;
>
> @@ -2465,6 +2464,16 @@ static int mptcp_init_sock(struct sock *sk)
> 	if (ret)
> 		return ret;
>
> +	/* fetch the ca name; do it outside __mptcp_init_sock(), so that clone will
> +	 * propagate the correct value
> +	 */
> +	tcp_assign_congestion_control(sk);
> +	strcpy(mptcp_sk(sk)->ca_name, icsk->icsk_ca_ops->name);
> +
> +	/* no need to keep a reference to the oops, the name will suffice */

Given that "oops" is a loaded word in the kernel world, I think this typo 
is worth fixing!

I will also run this in syzkaller in case Christoph can't get to it.


Mat


> +	tcp_cleanup_congestion_control(sk);
> +	icsk->icsk_ca_ops = NULL;
> +
> 	sk_sockets_allocated_inc(sk);
> 	sk->sk_rcvbuf = sock_net(sk)->ipv4.sysctl_tcp_rmem[1];
> 	sk->sk_sndbuf = sock_net(sk)->ipv4.sysctl_tcp_wmem[1];
> @@ -2639,7 +2648,6 @@ static void __mptcp_destroy_sock(struct sock *sk)
> 	sk_stream_kill_queues(sk);
> 	xfrm_sk_free_policy(sk);
>
> -	tcp_cleanup_congestion_control(sk);
> 	sk_refcnt_debug_release(sk);
> 	mptcp_dispose_initial_subflow(msk);
> 	sock_put(sk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 98c735f237b4..868e878af526 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -263,6 +263,7 @@ struct mptcp_sock {
> 	} rcvq_space;
>
> 	u32 setsockopt_seq;
> +	char		ca_name[TCP_CA_NAME_MAX];
> };
>
> #define mptcp_lock_sock(___sk, cb) do {					\
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 00d941b66c1e..a79798189599 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -547,7 +547,7 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
> 	}
>
> 	if (ret == 0)
> -		tcp_set_congestion_control(sk, name, false, cap_net_admin);
> +		strcpy(msk->ca_name, name);
>
> 	release_sock(sk);
> 	return ret;
> @@ -705,7 +705,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
> 	sock_valbool_flag(ssk, SOCK_DBG, sock_flag(sk, SOCK_DBG));
>
> 	if (inet_csk(sk)->icsk_ca_ops != inet_csk(ssk)->icsk_ca_ops)
> -		tcp_set_congestion_control(ssk, inet_csk(sk)->icsk_ca_ops->name, false, true);
> +		tcp_set_congestion_control(ssk, msk->ca_name, false, true);
> }
>
> static void __mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)
> -- 
> 2.26.2
>
>
>

--
Mat Martineau
Intel
