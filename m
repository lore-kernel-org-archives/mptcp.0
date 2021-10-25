Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D922C8B
	for <mptcp@lists.linux.dev>; Mon, 25 Oct 2021 21:55:18 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="216942582"
X-IronPort-AV: E=Sophos;i="5.87,181,1631602800"; 
   d="scan'208";a="216942582"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 14:55:17 -0700
X-IronPort-AV: E=Sophos;i="5.87,181,1631602800"; 
   d="scan'208";a="497008819"
Received: from relbaz1-mobl.amr.corp.intel.com ([10.251.7.61])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 14:55:17 -0700
Date: Mon, 25 Oct 2021 14:55:17 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Poorva Sonparote <psonparo@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp net-next] Support for SOL_IP for MPTCP setsockopt
In-Reply-To: <51fa50ca9158e5b72a8f41ba9fcd1e449638dbc5.1635194315.git.psonparo@redhat.com>
Message-ID: <8030848c-ca15-ea6e-779f-bf8a1602f39@linux.intel.com>
References: <51fa50ca9158e5b72a8f41ba9fcd1e449638dbc5.1635194315.git.psonparo@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 25 Oct 2021, Poorva Sonparote wrote:

> This patch adds support for IP_TOS for setsockopt(.. ,SOL_IP, ..)
> https://github.com/multipath-tcp/mptcp_net-next/issues/220
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/220
>
> Signed-off-by: Poorva Sonparote <psonparo@redhat.com>
> ---
>
> Notes:
>    - This patch addresses previous suggestions.
>    - The TOS value is now being set successfully for subflows
>      created after setsockopt().
>

Hi Poorva -

Thanks for the update. A few notes below.

> include/net/ip.h       |  3 +--
> net/ipv4/ip_sockglue.c |  2 +-
> net/mptcp/sockopt.c    | 41 +++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 43 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/ip.h b/include/net/ip.h
> index cf229a531194..a40501fe89de 100644
> --- a/include/net/ip.h
> +++ b/include/net/ip.h
> @@ -762,7 +762,6 @@ void ip_icmp_error(struct sock *sk, struct sk_buff *skb, int err, __be16 port,
> 		   u32 info, u8 *payload);
> void ip_local_error(struct sock *sk, int err, __be32 daddr, __be16 dport,
> 		    u32 info);
> -

Looks like an accidentally deleted line here.

When making changes to the networking core, it's best to split that out in 
a separate commit (with a subject like "net: Expose __ip_sock_set_tos()"). 
MPTCP maintainers can accept changes to MPTCP files, but other maintainers 
are responsible for ip.h and ip_sockglue.c

> static inline void ip_cmsg_recv(struct msghdr *msg, struct sk_buff *skb)
> {
> 	ip_cmsg_recv_offset(msg, skb->sk, skb, 0, 0);
> @@ -789,5 +788,5 @@ int ip_sock_set_mtu_discover(struct sock *sk, int val);
> void ip_sock_set_pktinfo(struct sock *sk);
> void ip_sock_set_recverr(struct sock *sk);
> void ip_sock_set_tos(struct sock *sk, int val);
> -
> +void  __ip_sock_set_tos(struct sock *sk, int val);

Keep the empty line before the #endif

> #endif	/* _IP_H */
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index b297bb28556e..7fd83f14daae 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -576,7 +576,7 @@ int ip_recv_error(struct sock *sk, struct msghdr *msg, int len, int *addr_len)
> 	return err;
> }
>
> -static void __ip_sock_set_tos(struct sock *sk, int val)
> +void __ip_sock_set_tos(struct sock *sk, int val)
> {
> 	if (sk->sk_type == SOCK_STREAM) {
> 		val &= ~INET_ECN_MASK;
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 8137cc3a4296..3967e1b8455c 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -598,6 +598,43 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
> 	return ret;
> }
>
> +static int mptcp_setsockopt_sol_ip_set_tos(struct mptcp_sock *msk, int optname,
> +					   sockptr_t optval, unsigned int optlen)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *sk = (struct sock *)msk;
> +	int ret, val = 0;

No need to initialize 'val' here, there's no code path where it will get 
used uninitialized.

> +	int err;
> +
> +	err = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
> +	val = inet_sk(sk)->tos;

This assignment should be done after the lock_sock() but before the loop.


The patch is close to being ready, thanks again.

Mat


> +
> +	if (err != 0)
> +		return err;
> +
> +	lock_sock(sk);
> +	sockopt_seq_inc(msk);
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +		__ip_sock_set_tos(ssk, val);
> +	}
> +	release_sock(sk);
> +
> +	return ret;
> +}
> +
> +static int mptcp_setsockopt_sol_ip(struct mptcp_sock *msk, int optname,
> +				   sockptr_t optval, unsigned int optlen)
> +{
> +	switch (optname) {
> +	case IP_TOS:
> +		return  mptcp_setsockopt_sol_ip_set_tos(msk, optname, optval, optlen);
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
> 				    sockptr_t optval, unsigned int optlen)
> {
> @@ -637,6 +674,9 @@ int mptcp_setsockopt(struct sock *sk, int level, int optname,
> 	if (ssk)
> 		return tcp_setsockopt(ssk, level, optname, optval, optlen);
>
> +	if (level == SOL_IP)
> +		return mptcp_setsockopt_sol_ip(msk, optname, optval, optlen);
> +
> 	if (level == SOL_IPV6)
> 		return mptcp_setsockopt_v6(msk, optname, optval, optlen);
>
> @@ -1000,6 +1040,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
> 	ssk->sk_priority = sk->sk_priority;
> 	ssk->sk_bound_dev_if = sk->sk_bound_dev_if;
> 	ssk->sk_incoming_cpu = sk->sk_incoming_cpu;
> +	__ip_sock_set_tos(ssk, inet_sk(sk)->tos);
>
> 	if (sk->sk_userlocks & tx_rx_locks) {
> 		ssk->sk_userlocks |= sk->sk_userlocks & tx_rx_locks;
> -- 
> 2.18.2
>
>

--
Mat Martineau
Intel
