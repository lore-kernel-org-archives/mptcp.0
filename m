Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2682F26
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 11:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644577431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ry5Dr8Y4Sg3txJVi1L1/jb246S2B18AhlC0oJr0XjqQ=;
	b=dPcnoYwqDsaJVQ2XthXXkCEWLaacRizpwSDwAFEiFNStHzpiDmyDi0HUfBo+7EeXUukIiE
	GHw97jk/p5b8BVpFFen0eLLHing8T4YolRJ9A3jiOOXcd/ZpXYN4WQTlSbQH7M8lZhYzO4
	567lfq8HuC6b3LpMkAsk8NkPV49tOAY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-WDmi2lWbOtuutIU5aiNeLg-1; Fri, 11 Feb 2022 06:03:50 -0500
X-MC-Unique: WDmi2lWbOtuutIU5aiNeLg-1
Received: by mail-wm1-f69.google.com with SMTP id t2-20020a7bc3c2000000b003528fe59cb9so2361219wmj.5
        for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 03:03:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ry5Dr8Y4Sg3txJVi1L1/jb246S2B18AhlC0oJr0XjqQ=;
        b=I7a2F91+OZWRxXkIhUXyC5xLpTg5s5+C1Pp/yuqBWTlv64p+KTHTQH7LYKMKIZdBzD
         659cbrIlJIZnQ3i+tnGLg6szX9DvgbuMgelR79KmKNhD8VmxYLcg82KWxPJrh/G09Oyr
         YIiaf0+s1T6uAweQAN9pzG1h8rAD+w8AaS4xZbf8Rz1U9dOKdzNt4UgiXS7yuZB2xvFN
         66I2xqyFbSYuWqx4NQPqmrKhTZUrHNKj6ZCSsJLofs+mypqDxB5L5vwaGPP5UzD+HFjV
         1n9cqTT0TCGbdtU21MKwG0Bg7nW2YNzXI43HGnnZbYUk5AqE+syU0W2oV4wQjaw1BOdb
         V/PA==
X-Gm-Message-State: AOAM531v8+jmzCiBf4NEZ/SVvaXTRSUWsf5lvwZDkhjuRXs4MywcT4Dj
	vvs9LzAEwakE/tqjlm3B7bEuoHxRN1USfYS1IcgNzAJ2Ooa/ixSJwbpdAa6Z2IQRqm3XzqcYDnn
	rrAlNaRFyLRAgZRU=
X-Received: by 2002:a5d:6a85:: with SMTP id s5mr966973wru.510.1644577429248;
        Fri, 11 Feb 2022 03:03:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdFdz+rg2GVAwkOtKq/2+xwWmym6liF1i/qfUludw8MIRhBEHRa29VZKt0k/hfEvXScUi5dg==
X-Received: by 2002:a5d:6a85:: with SMTP id s5mr966949wru.510.1644577428921;
        Fri, 11 Feb 2022 03:03:48 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id x18sm20760676wrw.17.2022.02.11.03.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 03:03:47 -0800 (PST)
Message-ID: <1571d4e58ebf36eb436b0056f3ae7254d3a3114d.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 3/4] mptcp: handle join requests via pernet
 listen socket
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Date: Fri, 11 Feb 2022 12:03:46 +0100
In-Reply-To: <20220210152949.19572-4-fw@strlen.de>
References: <20220210152949.19572-1-fw@strlen.de>
	 <20220210152949.19572-4-fw@strlen.de>
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2022-02-10 at 16:29 +0100, Florian Westphal wrote:
> Currently mptcp adds kernel-based listener socket for all
> netlink-configured mptcp address endpoints.
> 
> This has caveats because kernel may interfere with unrelated programs
> that use same address/port pairs.
> 
> RFC 8664 says:
>  Demultiplexing subflow SYNs MUST be done using the token; this is
>  unlike traditional TCP, where the destination port is used for
>  demultiplexing SYN packets.  Once a subflow is set up, demultiplexing
>  packets is done using the 5-tuple, as in traditional TCP.
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
>  include/net/mptcp.h  |  10 ++
>  net/ipv6/tcp_ipv6.c  |  19 ++--
>  net/mptcp/ctrl.c     | 214 ++++++++++++++++++++++++++++++++++++++++++-
>  net/mptcp/protocol.c |   2 +-
>  net/mptcp/protocol.h |   2 +-
>  net/mptcp/subflow.c  |   3 +
>  6 files changed, 236 insertions(+), 14 deletions(-)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 5ee422b56902..49c188b978e1 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -189,6 +189,7 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
>  				  struct sk_buff *skb);
>  
>  __be32 mptcp_get_reset_option(const struct sk_buff *skb);
> +struct sock *__mptcp_handle_join(int af, struct sk_buff *skb);
>  
>  static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
>  {
> @@ -199,6 +200,11 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
>  }
>  static inline struct sock *mptcp_handle_join(int af, struct sk_buff *skb)
>  {
> +	const struct tcphdr *th = tcp_hdr(skb);
> +
> +	if (th->syn && !th->ack && !th->rst && !th->fin)
> +		return __mptcp_handle_join(af, skb);
> +
>  	return NULL;
>  }
>  #else
> @@ -283,9 +289,13 @@ static inline struct sock *mptcp_handle_join(int af, struct sk_buff *skb) { retu
>  
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>  int mptcpv6_init(void);
> +int mptcpv6_init_net(struct net *net);
> +void mptcpv6_exit_net(struct net *net);
>  void mptcpv6_handle_mapped(struct sock *sk, bool mapped);
>  #elif IS_ENABLED(CONFIG_IPV6)
>  static inline int mptcpv6_init(void) { return 0; }
> +static inline int mptcpv6_init_net(struct net *net) { return 0; }
> +static inline void mptcpv6_exit_net(struct net *net) { }
>  static inline void mptcpv6_handle_mapped(struct sock *sk, bool mapped) { }
>  #endif
>  
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 788040db8e9e..3b8608d35dcd 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -2233,13 +2233,22 @@ static struct inet_protosw tcpv6_protosw = {
>  
>  static int __net_init tcpv6_net_init(struct net *net)
>  {
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
>  }
>  
>  static void __net_exit tcpv6_net_exit(struct net *net)
>  {
>  	inet_ctl_sock_destroy(net->ipv6.tcp_sk);
> +	mptcpv6_exit_net(net);
>  }
>  
>  static struct pernet_operations tcpv6_net_ops = {
> @@ -2264,15 +2273,9 @@ int __init tcpv6_init(void)
>  	if (ret)
>  		goto out_tcpv6_protosw;
>  
> -	ret = mptcpv6_init();
> -	if (ret)
> -		goto out_tcpv6_pernet_subsys;
> -
>  out:
>  	return ret;
>  
> -out_tcpv6_pernet_subsys:
> -	unregister_pernet_subsys(&tcpv6_net_ops);
>  out_tcpv6_protosw:
>  	inet6_unregister_protosw(&tcpv6_protosw);
>  out_tcpv6_protocol:
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index ae20b7d92e28..bba345f092af 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -21,6 +21,12 @@ static int mptcp_pernet_id;
>  static int mptcp_pm_type_max = __MPTCP_PM_TYPE_MAX;
>  #endif
>  
> +struct mptcp_join_sk {
> +	struct sock *sk;
> +	struct inet_bind_bucket *tb;
> +	struct inet_bind_hashbucket head;
> +};
> +
>  struct mptcp_pernet {
>  #ifdef CONFIG_SYSCTL
>  	struct ctl_table_header *ctl_table_hdr;
> @@ -32,6 +38,18 @@ struct mptcp_pernet {
>  	u8 checksum_enabled;
>  	u8 allow_join_initial_addr_port;
>  	u8 pm_type;
> +
> +	/* pernet listener to handle mptcp join requests
> +	 * based on the mptcp token.
> +	 *
> +	 * Has to be pernet because tcp uses
> +	 * sock_net(sk_listener) to obtain the net namespace for
> +	 * the syn/ack route lookup.
> +	 */

A possible alternative would be proving a __tcp_conn_request() variant
which uses an exiplicit 'net' argument. tcp_conn_request() could be an
inline on top of the above.

Or we can use a global per-cpu set of "listeners", setting the net
field just before calling tcp_conn_request.

> +	struct mptcp_join_sk join4;
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	struct mptcp_join_sk join6;
> +#endif
>  };
>  
>  static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
> @@ -185,13 +203,176 @@ static void mptcp_pernet_del_table(struct mptcp_pernet *pernet) {}
>  
>  #endif /* CONFIG_SYSCTL */
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

This should be called under the RCU lock, right? we could have
__mptcp_token_lookup_sock variant that does not touches the msk
reference count.

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

If I read correctly, at this point 'refcounted' should be 'false' in
the caller (either tcp_v4_rcv or tcp_v6_rcv), so we don't need to
acquire a reference to lsk ?!?

/P

