Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF7A2CA4
	for <mptcp@lists.linux.dev>; Tue, 26 Oct 2021 20:54:56 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="210794936"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="210794936"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 13:54:53 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="497533370"
Received: from gacramer-mobl2.amr.corp.intel.com ([10.209.53.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 13:54:52 -0700
Date: Tue, 26 Oct 2021 13:54:52 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Poorva Sonparote <psonparo@redhat.com>
cc: mptcp@lists.linux.dev, matthieu.baerts@tessares.net
Subject: Re: [PATCH mptcp net-next v2] Support for IP_TOS for MPTCP
 setsockopt()
In-Reply-To: <31da6aa5b0a0df7c10c5ad55312b5372c9f7ec6f.1635266103.git.psonparo@redhat.com>
Message-ID: <3cc945f8-7cf-4159-82cd-2b8bba2ccbd@linux.intel.com>
References: <31da6aa5b0a0df7c10c5ad55312b5372c9f7ec6f.1635266103.git.psonparo@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 26 Oct 2021, Poorva Sonparote wrote:

> SOL_IP provides a way to configure network layer attributes in a
> socket. This patch adds support for IP_TOS for setsockopt(.. ,SOL_IP, ..)
> https://github.com/multipath-tcp/mptcp_net-next/issues/220
>
> Support for SOL_IP is added in mptcp_setsockopt() and IP_TOS is handled in
> a private function. The idea here is to take in the value passed for IP_TOS
> and set it to the current subflow, open subflows as well new subflows that
> might be created after the initial call to setsockopt(). This sync is done
> using sync_socket_options(.., ssk) and setting the value of tos using
> __ip_sock_set_tos(ssk,..).
> To set the value for all subflows associated, __ip_sock_set_tos(ssk,..) is
> exposed in ip.h
>
> The patch has been tested using the packetdrill script here -
> https://github.com/multipath-tcp/mptcp_net-next/issues/220#issuecomment-947863717
> It has not been selftested because there's no support for IP_TOS in
> getsockopt() yet.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/220
> Signed-off-by: Poorva Sonparote <psonparo@redhat.com>
> ---
> Thanks Mat and Matthieu for the feedback! Kindly let me know if any changes
> are required.
>

Hi Poorva -

Thanks for the revision.

The main thing that still needs to be changed is that this should be two 
separate commits (and therefore multiple email messages): one commit for 
changes to expose __ip_sock_set_tos() and a separate commit for the 
changes in sockopt.c.

As with a lot of tasks in git, there are many ways to split a commit into 
multiple commits. I usually refer to the "SPLITTING COMMITS" section of 
the 'man git rebase' manual page. If you have more questions about this 
process, #mptcp on IRC is a good place to ask.


> Notes:
>    - Fixed formatting errors in ip.h and sockopt.c
>    - Edited the commit message to add in more details.
>    - The patch cannot be seltested because there's no
>      support for IP_TOS in getsockopt() yet.
>    - Changed the function name mptcp_setsockopt_sol_ip(..)
>     to mptcp_setsockopt_v4(..).
>    - Similarly, changed the function name mptcp_setsockopt_sol_ip_set_tos(..)
>     to mptcp_setsockopt_v4_set_tos(..) for uniformity.
>
> include/net/ip.h       |  2 +-
> net/ipv4/ip_sockglue.c |  2 +-
> net/mptcp/sockopt.c    | 41 +++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/ip.h b/include/net/ip.h
> index cf229a531194..e9e050f5af99 100644
> --- a/include/net/ip.h
> +++ b/include/net/ip.h
> @@ -762,7 +762,6 @@ void ip_icmp_error(struct sock *sk, struct sk_buff *skb, int err, __be16 port,
> 		   u32 info, u8 *payload);
> void ip_local_error(struct sock *sk, int err, __be32 daddr, __be16 dport,
> 		    u32 info);
> -

Still a deleted line to restore here.

Regards,

Mat


> static inline void ip_cmsg_recv(struct msghdr *msg, struct sk_buff *skb)
> {
> 	ip_cmsg_recv_offset(msg, skb->sk, skb, 0, 0);
> @@ -789,5 +788,6 @@ int ip_sock_set_mtu_discover(struct sock *sk, int val);
> void ip_sock_set_pktinfo(struct sock *sk);
> void ip_sock_set_recverr(struct sock *sk);
> void ip_sock_set_tos(struct sock *sk, int val);
> +void  __ip_sock_set_tos(struct sock *sk, int val);
>
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
> index 8137cc3a4296..ded47f0483ed 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -598,6 +598,43 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
> 	return ret;
> }
>
> +static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
> +				       sockptr_t optval, unsigned int optlen)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *sk = (struct sock *)msk;
> +	int ret, val;
> +	int err;
> +
> +	err = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
> +
> +	if (err != 0)
> +		return err;
> +
> +	lock_sock(sk);
> +	sockopt_seq_inc(msk);
> +	val = inet_sk(sk)->tos;
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
> +static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
> +			       sockptr_t optval, unsigned int optlen)
> +{
> +	switch (optname) {
> +	case IP_TOS:
> +		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
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
> +		return mptcp_setsockopt_v4(msk, optname, optval, optlen);
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
