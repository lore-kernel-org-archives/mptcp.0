Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1772C80
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 02:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644544989; x=1676080989;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iS6W5C5BH9vKtcFFhl5Wjt/LhxQoASpCbOMGiYfF84I=;
  b=LK80HyvmO9viCvPlUEPKL8NWFQbNnuHXUk6l4Eqs09UxDU0YDSNAQicP
   2lGmToHTgCML2F1vBgfd+Y74m6g6s1Tm0IJat+kr/Vji1Hz2LRa9OBvMy
   9//sZMIMgz858aicSR+bhGBEOKeIT7Gvvm8BPDZgNYojWW/L7rHh94M/V
   phHnIxAf+tCvoSU0bJpJwOJtohiV8/hFkOf9mHmwdl5eHHC2D5EGSUlJR
   H30BkM5HfSvzDXA4N0M5AvCTviqNoCuKTEmDn4b/gJ5YAkVXdWKqhTVSo
   lWD/Nhsf9LQZGcSpsfH5k/yIu8MNZ5BqGIL3lWXR6Q6uUYRS/fvKBe7wJ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="336061433"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="336061433"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 18:03:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="701925357"
Received: from dbosneag-mobl1.amr.corp.intel.com ([10.212.211.192])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 18:03:07 -0800
Date: Thu, 10 Feb 2022 18:03:06 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 3/4] mptcp: handle join requests via pernet
 listen socket
In-Reply-To: <20220210152949.19572-4-fw@strlen.de>
Message-ID: <2fca6a8-62b3-9f8-d08-62bf352c071@linux.intel.com>
References: <20220210152949.19572-1-fw@strlen.de> <20220210152949.19572-4-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 10 Feb 2022, Florian Westphal wrote:

> Currently mptcp adds kernel-based listener socket for all
> netlink-configured mptcp address endpoints.
>
> This has caveats because kernel may interfere with unrelated programs
> that use same address/port pairs.
>

It looks like they still interfere with each other, but now in the 
opposite way: TCP listeners can now be created that interfere with 
MP_JOINs (and the MPTCP side loses).

Since mptcp_handle_join() is only called if the listener lookup fails, if 
a TCP listen socket has been created for an address & port advertised by 
MPTCP, that TCP listener will be looked up, process the SYN, and send a 
regular TCP SYN/ACK. The peer will then reject it due to lack of correct 
MPTCP options.

Seems like a few more TCP changes are needed to handle this listener 
collision well for both TCP and MPTCP, and without too much overhead. Is 
it too expensive to look for MPTCP options in every incoming TCP SYN 
header? Or to have the MPTCP PM code setting a "check for MP_JOIN" bit on 
TCP listener sockets that match advertised addresses?


-Mat

> RFC 8664 says:
> Demultiplexing subflow SYNs MUST be done using the token; this is
> unlike traditional TCP, where the destination port is used for
> demultiplexing SYN packets.  Once a subflow is set up, demultiplexing
> packets is done using the 5-tuple, as in traditional TCP.
>
> This patch deviates from this in that it retrains the existing checks of
> verifying the incoming requests destination vs. the list of announced
> addresses.
>
> This can be relaxed later if deemed appropriate.
>
> The pernet 'listening' socket is not a listening socket from userspace
> point of view, it is not part of any hashes and not bound to any address
> or port.
>
> TPROXY-like semantics apply: If tcp demux cannot find a socket, check
> if the packet is a join request with a valid token.
>
> If so, the pernet listener is returned and tcp processing resumes.
> Otherwise, handling is intentical as if there is no socket.
>
> This patch does not handle timewait sockets.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
> include/net/mptcp.h  |  10 ++
> net/ipv6/tcp_ipv6.c  |  19 ++--
> net/mptcp/ctrl.c     | 214 ++++++++++++++++++++++++++++++++++++++++++-
> net/mptcp/protocol.c |   2 +-
> net/mptcp/protocol.h |   2 +-
> net/mptcp/subflow.c  |   3 +
> 6 files changed, 236 insertions(+), 14 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 5ee422b56902..49c188b978e1 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -189,6 +189,7 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
> 				  struct sk_buff *skb);
>
> __be32 mptcp_get_reset_option(const struct sk_buff *skb);
> +struct sock *__mptcp_handle_join(int af, struct sk_buff *skb);
>
> static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
> {
> @@ -199,6 +200,11 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
> }
> static inline struct sock *mptcp_handle_join(int af, struct sk_buff *skb)
> {
> +	const struct tcphdr *th = tcp_hdr(skb);
> +
> +	if (th->syn && !th->ack && !th->rst && !th->fin)
> +		return __mptcp_handle_join(af, skb);
> +
> 	return NULL;
> }
> #else
> @@ -283,9 +289,13 @@ static inline struct sock *mptcp_handle_join(int af, struct sk_buff *skb) { retu
>
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> int mptcpv6_init(void);
> +int mptcpv6_init_net(struct net *net);
> +void mptcpv6_exit_net(struct net *net);
> void mptcpv6_handle_mapped(struct sock *sk, bool mapped);
> #elif IS_ENABLED(CONFIG_IPV6)
> static inline int mptcpv6_init(void) { return 0; }
> +static inline int mptcpv6_init_net(struct net *net) { return 0; }
> +static inline void mptcpv6_exit_net(struct net *net) { }
> static inline void mptcpv6_handle_mapped(struct sock *sk, bool mapped) { }
> #endif
>
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 788040db8e9e..3b8608d35dcd 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -2233,13 +2233,22 @@ static struct inet_protosw tcpv6_protosw = {
>
> static int __net_init tcpv6_net_init(struct net *net)
> {
> -	return inet_ctl_sock_create(&net->ipv6.tcp_sk, PF_INET6,
> -				    SOCK_RAW, IPPROTO_TCP, net);
> +	int err = inet_ctl_sock_create(&net->ipv6.tcp_sk, PF_INET6,
> +				       SOCK_RAW, IPPROTO_TCP, net);
> +	if (err)
> +		return err;
> +
> +	err = mptcpv6_init_net(net);
> +	if (err)
> +		inet_ctl_sock_destroy(net->ipv6.tcp_sk);
> +
> +	return err;
> }
>
> static void __net_exit tcpv6_net_exit(struct net *net)
> {
> 	inet_ctl_sock_destroy(net->ipv6.tcp_sk);
> +	mptcpv6_exit_net(net);
> }
>
> static struct pernet_operations tcpv6_net_ops = {
> @@ -2264,15 +2273,9 @@ int __init tcpv6_init(void)
> 	if (ret)
> 		goto out_tcpv6_protosw;
>
> -	ret = mptcpv6_init();
> -	if (ret)
> -		goto out_tcpv6_pernet_subsys;
> -
> out:
> 	return ret;
>
> -out_tcpv6_pernet_subsys:
> -	unregister_pernet_subsys(&tcpv6_net_ops);
> out_tcpv6_protosw:
> 	inet6_unregister_protosw(&tcpv6_protosw);
> out_tcpv6_protocol:
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index ae20b7d92e28..bba345f092af 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -21,6 +21,12 @@ static int mptcp_pernet_id;
> static int mptcp_pm_type_max = __MPTCP_PM_TYPE_MAX;
> #endif
>
> +struct mptcp_join_sk {
> +	struct sock *sk;
> +	struct inet_bind_bucket *tb;
> +	struct inet_bind_hashbucket head;
> +};
> +
> struct mptcp_pernet {
> #ifdef CONFIG_SYSCTL
> 	struct ctl_table_header *ctl_table_hdr;
> @@ -32,6 +38,18 @@ struct mptcp_pernet {
> 	u8 checksum_enabled;
> 	u8 allow_join_initial_addr_port;
> 	u8 pm_type;
> +
> +	/* pernet listener to handle mptcp join requests
> +	 * based on the mptcp token.
> +	 *
> +	 * Has to be pernet because tcp uses
> +	 * sock_net(sk_listener) to obtain the net namespace for
> +	 * the syn/ack route lookup.
> +	 */
> +	struct mptcp_join_sk join4;
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	struct mptcp_join_sk join6;
> +#endif
> };
>
> static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
> @@ -185,13 +203,176 @@ static void mptcp_pernet_del_table(struct mptcp_pernet *pernet) {}
>
> #endif /* CONFIG_SYSCTL */
>
> +struct sock *__mptcp_handle_join(int af, struct sk_buff *skb)
> +{
> +	struct mptcp_options_received mp_opt;
> +	struct mptcp_pernet *pernet;
> +	struct mptcp_sock *msk;
> +	struct socket *ssock;
> +	struct sock *lsk;
> +	struct net *net;
> +
> +	/* paranoia check: don't allow 0 destination port,
> +	 * else __inet_inherit_port will insert the child socket
> +	 * into the phony hash slot of the pernet listener.
> +	 */
> +	if (tcp_hdr(skb)->dest == 0)
> +		return NULL;
> +
> +	mptcp_get_options(skb, &mp_opt);
> +
> +	if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPJ))
> +		return NULL;
> +
> +	net = dev_net(skb_dst(skb)->dev);
> +	if (!mptcp_is_enabled(net))
> +		return NULL;
> +
> +	/* RFC8684: If the token is unknown [..], the receiver will send
> +	 * back a reset (RST) signal, analogous to an unknown port in TCP,
> +	 * containing an MP_TCPRST option (Section 3.6) [..]
> +	 */
> +	msk = mptcp_token_get_sock(net, mp_opt.token);
> +	if (!msk) {
> +		struct mptcp_ext *ext = skb_ext_add(skb, SKB_EXT_MPTCP);
> +
> +		if (ext) {
> +			memset(ext, 0, sizeof(*ext));
> +			ext->reset_reason = MPTCP_RST_EMPTCP;
> +		}
> +		return NULL;
> +	}
> +
> +	sock_put((struct sock *)msk);
> +	pernet = mptcp_get_pernet(net);
> +
> +	switch (af) {
> +	case AF_INET:
> +		lsk = pernet->join4.sk;
> +		break;
> +	case AF_INET6:
> +		lsk = pernet->join6.sk;
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return NULL;
> +	}
> +
> +	msk = mptcp_sk(lsk);
> +	ssock = __mptcp_nmpc_socket(msk);
> +	lsk = ssock->sk;
> +	sock_hold(lsk);
> +	return lsk;
> +}
> +
> +static struct socket *mptcp_create_join_listen_socket(struct net *net, int af)
> +{
> +	struct socket *s, *ssock;
> +	int err;
> +
> +	err = sock_create_kern(net, af, SOCK_STREAM, IPPROTO_MPTCP, &s);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	ssock = __mptcp_nmpc_socket(mptcp_sk(s->sk));
> +	if (!ssock) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	ssock->sk->sk_max_ack_backlog = SOMAXCONN;
> +	inet_sk_state_store(ssock->sk, TCP_LISTEN);
> +
> +	s->sk->sk_max_ack_backlog = SOMAXCONN;
> +	inet_sk_state_store(s->sk, TCP_LISTEN);
> +
> +	s->sk->sk_net_refcnt = 1;
> +	get_net_track(net, &s->sk->ns_tracker, GFP_KERNEL);
> +	sock_inuse_add(net, 1);
> +
> +	return s;
> +out:
> +	sock_release(s);
> +	return ERR_PTR(err);
> +}
> +
> +static int mptcp_init_join_sk(struct net *net, struct sock *sk, struct mptcp_join_sk *join_sk)
> +{
> +	struct socket *ssock = __mptcp_nmpc_socket(mptcp_sk(sk));
> +	struct inet_hashinfo *table = ssock->sk->sk_prot->h.hashinfo;
> +	struct inet_bind_bucket *tb;
> +
> +	spin_lock_init(&join_sk->head.lock);
> +	INIT_HLIST_HEAD(&join_sk->head.chain);
> +
> +	/* Our "listen socket" isn't bound to any address or port.
> +	 * Conceptually, SYN packet with mptcp join request are steered to
> +	 * this pernet socket just like TPROXY steals arbitrary connection
> +	 * requests to assign them to listening socket with different
> +	 * address or port.
> +	 *
> +	 * The bind_bucket is needed for sake of __inet_inherit_port(),
> +	 * so it can place the new child socket in the correct
> +	 * bind_bucket slot.
> +	 *
> +	 * A phony head is used to hide this socket from normal sk loookup.
> +	 */
> +	tb = inet_bind_bucket_create(table->bind_bucket_cachep,
> +				     net, &join_sk->head, 0, 0);
> +	if (!tb)
> +		return -ENOMEM;
> +
> +	inet_csk(ssock->sk)->icsk_bind_hash = tb;
> +	return 0;
> +}
> +
> static int __net_init mptcp_net_init(struct net *net)
> {
> 	struct mptcp_pernet *pernet = mptcp_get_pernet(net);
> +	struct socket *sock;
> +	int err;
>
> 	mptcp_pernet_set_defaults(pernet);
>
> -	return mptcp_pernet_new_table(net, pernet);
> +	err = mptcp_pernet_new_table(net, pernet);
> +	if (err)
> +		return err;
> +
> +	sock = mptcp_create_join_listen_socket(net, AF_INET);
> +	if (IS_ERR(sock)) {
> +		err = PTR_ERR(sock);
> +		goto out_table;
> +	}
> +
> +	err = mptcp_init_join_sk(net, sock->sk, &pernet->join4);
> +	if (err) {
> +		sock_release(sock);
> +		goto out_table;
> +	}
> +
> +	/* struct sock is still reachable via sock->sk_socket backpointer */
> +	pernet->join4.sk = sock->sk;
> +	return err;
> +
> +out_table:
> +	if (!net_eq(net, &init_net))
> +		mptcp_pernet_del_table(pernet);
> +	return err;
> +}
> +
> +static void __net_exit mptcp_exit_join_sk(struct mptcp_join_sk *jsk)
> +{
> +	struct socket *ssock = __mptcp_nmpc_socket(mptcp_sk(jsk->sk));
> +	struct inet_bind_bucket *tb;
> +	struct inet_hashinfo *table;
> +
> +	table = ssock->sk->sk_prot->h.hashinfo;
> +
> +	tb = inet_csk(ssock->sk)->icsk_bind_hash;
> +	inet_bind_bucket_destroy(table->bind_bucket_cachep, tb);
> +
> +	ssock = jsk->sk->sk_socket;
> +	sock_release(ssock);
> }
>
> /* Note: the callback will only be called per extra netns */
> @@ -200,6 +381,7 @@ static void __net_exit mptcp_net_exit(struct net *net)
> 	struct mptcp_pernet *pernet = mptcp_get_pernet(net);
>
> 	mptcp_pernet_del_table(pernet);
> +	mptcp_exit_join_sk(&pernet->join4);
> }
>
> static struct pernet_operations mptcp_pernet_ops = {
> @@ -219,12 +401,36 @@ void __init mptcp_init(void)
> }
>
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -int __init mptcpv6_init(void)
> +int __net_init mptcpv6_init_net(struct net *net)
> {
> +	struct mptcp_pernet *pernet = mptcp_get_pernet(net);
> +	struct socket *sock;
> 	int err;
>
> -	err = mptcp_proto_v6_init();
> +	if (net_eq(net, &init_net)) {
> +		err = mptcp_proto_v6_init();
> +		if (err)
> +			return err;
> +	}
>
> -	return err;
> +	sock = mptcp_create_join_listen_socket(net, AF_INET6);
> +	if (IS_ERR(sock))
> +		return PTR_ERR(sock);
> +
> +	err = mptcp_init_join_sk(net, sock->sk, &pernet->join6);
> +	if (err) {
> +		sock_release(sock);
> +		return err;
> +	}
> +
> +	pernet->join6.sk = sock->sk;
> +	return 0;
> +}
> +
> +void __net_exit mptcpv6_exit_net(struct net *net)
> +{
> +	struct mptcp_pernet *pernet = mptcp_get_pernet(net);
> +
> +	mptcp_exit_join_sk(&pernet->join6);
> }
> #endif
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3324e1c61576..980e6531bf4e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3776,7 +3776,7 @@ static struct inet_protosw mptcp_v6_protosw = {
> 	.flags		= INET_PROTOSW_ICSK,
> };
>
> -int __init mptcp_proto_v6_init(void)
> +int __net_init mptcp_proto_v6_init(void)
> {
> 	int err;
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 03e3880d274d..c6b2cf26bc88 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -647,7 +647,7 @@ static inline bool mptcp_has_another_subflow(struct sock *ssk)
>
> void __init mptcp_proto_init(void);
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -int __init mptcp_proto_v6_init(void);
> +int __net_init mptcp_proto_v6_init(void);
> #endif
>
> struct sock *mptcp_sk_clone(const struct sock *sk,
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index d50cf555ea40..d54c6685c036 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -116,6 +116,9 @@ static void subflow_init_req(struct request_sock *req, const struct sock *sk_lis
>
> static bool subflow_use_different_sport(struct mptcp_sock *msk, const struct sock *sk)
> {
> +	if (inet_sk(sk)->inet_sport == 0)
> +		return true;
> +
> 	return inet_sk(sk)->inet_sport != inet_sk((struct sock *)msk)->inet_sport;
> }
>
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
