Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E388A2F39
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 23:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644448365; x=1675984365;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=y91KN0F8ChkexQpWy2Ugntlks192Qr2pW1gvsOa8ajA=;
  b=iOMnxGG+RX48ZPPpZSAiyunsYm8t7DP2qJekZzRCyFjyweq13Y6GDirq
   tjAfVVKL+fZ2TG47WnCc/QpsMi9RdqeA0PqtbgBhHA8rXVG6aKzw1TGgb
   MQ/RFF6+RFbJPBZin53bJ2z8MaE8y6k8nH4Ih5LXRCD5H+fchrGCbePYT
   MF/kZrepSZ+uF5LId1ta8kDDo43BgFxk+vNcaBKeHyeZI8i0xSi6S2Aes
   1gCGVtf2cVFeor6J+NoWzSsH9361IL/Zq3YBI2NtKtyF8xonDoTfGnAqR
   9GF/bBJ8ZLrh6ygNVaSzPZCPzOS4v+Vx6srRULWUbBySNq1xZTOZ6XO1j
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="249574503"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="249574503"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 15:12:45 -0800
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="701451789"
Received: from halucas-mobl3.amr.corp.intel.com ([10.212.241.159])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 15:12:45 -0800
Date: Wed, 9 Feb 2022 15:12:44 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: strict local address ID selection.
In-Reply-To: <1d7dfcc6b0628ef009798298e0e5922513f30083.1644409809.git.pabeni@redhat.com>
Message-ID: <839adf72-edc0-647b-5660-5ae9c175230@linux.intel.com>
References: <1d7dfcc6b0628ef009798298e0e5922513f30083.1644409809.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 9 Feb 2022, Paolo Abeni wrote:

> The address ID selection for MPJ subflows created in response
> to incoming ADD_ADDR option is currently unreliable: it happens
> at MPJ socket creation time, when the local address could be
> unknown.
>
> Additionally, if the no local endpoint is available for the local
> address, a new dummy endpoint is created, confusing the user-land.
>
> This change refactor the code to move the address ID seleciton inside
> the rebuild_header() helper, when the local address eventually
> selected by the route lookup is finally known. If the address used
> is not mapped by any endpoint - and thus can't be advertised/removed
> pick the id 0 instead of allocate a new endpoint.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Note: this should address issues/225, the root cause is that
> dummy endpoint creation causes flush being unreliable when the
> tests flush the endpoints on both sides. This patch addressed that
> avoiding dummy endpoint creation.
>
> Beware! intentional RFC violation included ;)

CI pointed out a !CONFIG_IPV6 build issue.

I'd like to talk about the RFC violation in this week's meeting to better 
understand that. Also worth thinking about in combination with Florian's 
MP_JOIN proposal (listening for MP_JOIN everywhere), which might lead to 
more incoming MP_JOINs.

A couple more comments below:

>
> RFC -> v1:
> - don't bail if ID lookup fails, use 0 instead
> ---
> net/mptcp/pm_netlink.c | 39 ++++++----------------------
> net/mptcp/protocol.c   |  3 +++
> net/mptcp/protocol.h   |  3 ++-
> net/mptcp/subflow.c    | 59 ++++++++++++++++++++++++++++++++++++------
> 4 files changed, 64 insertions(+), 40 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 46346f009485..5f6395b10fdc 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -83,16 +83,6 @@ static bool addresses_equal(const struct mptcp_addr_info *a,
> 	return a->port == b->port;
> }
>
> -static bool address_zero(const struct mptcp_addr_info *addr)
> -{
> -	struct mptcp_addr_info zero;
> -
> -	memset(&zero, 0, sizeof(zero));
> -	zero.family = addr->family;
> -
> -	return addresses_equal(addr, &zero, true);
> -}
> -
> static void local_address(const struct sock_common *skc,
> 			  struct mptcp_addr_info *addr)
> {
> @@ -998,7 +988,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
> 	struct mptcp_addr_info skc_local;
> 	struct mptcp_addr_info msk_local;
> 	struct pm_nl_pernet *pernet;
> -	int ret = -1;
> +	int ret = 0;
>
> 	if (WARN_ON_ONCE(!msk))
> 		return -1;
> @@ -1011,9 +1001,6 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
> 	if (addresses_equal(&msk_local, &skc_local, false))
> 		return 0;
>
> -	if (address_zero(&skc_local))
> -		return 0;
> -
> 	pernet = net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
>
> 	rcu_read_lock();
> @@ -1024,24 +1011,14 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
> 		}
> 	}
> 	rcu_read_unlock();
> -	if (ret >= 0)
> -		return ret;
> -
> -	/* address not found, add to local list */
> -	entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
> -	if (!entry)
> -		return -ENOMEM;
> -
> -	entry->addr = skc_local;
> -	entry->addr.id = 0;
> -	entry->addr.port = 0;
> -	entry->ifindex = 0;
> -	entry->flags = 0;
> -	entry->lsk = NULL;
> -	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
> -	if (ret < 0)
> -		kfree(entry);
>
> +	/* if src address is not mapped by any endpoint, we can't reliably pick an
> +	 * ID without creating "dummy" endpoint which would unexpectly pollute the
> +	 * netns.
> +	 * In such case arbitrary pick the 0 id. This is an RFC violation, as the
> +	 * mapping for ID 0 is not unique, but an unconsequential one: lacking the
> +	 * endpoint the peer can't generate RM_ADDR for this address
> +	 */

Minor - might as well wrap this comment to 80 columns.

> 	return ret;
> }
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3324e1c61576..57caf470e500 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -117,6 +117,9 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
> 	list_add(&subflow->node, &msk->conn_list);
> 	sock_hold(ssock->sk);
> 	subflow->request_mptcp = 1;
> +
> +	/* This is the first subflow, always with id 0 */
> +	subflow->local_id_valid = 1;
> 	mptcp_sock_graft(msk->first, sk->sk_socket);
>
> 	return 0;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index beb5ee38656a..f63b6f35d669 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -453,7 +453,8 @@ struct mptcp_subflow_context {
> 		rx_eof : 1,
> 		can_ack : 1,        /* only after processing the remote a key */
> 		disposable : 1,	    /* ctx can be free at ulp release time */
> -		stale : 1;	    /* unable to snd/rcv data, do not use for xmit */
> +		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
> +		local_id_valid : 1; /* local_id is correctly initialized */
> 	enum mptcp_data_avail data_avail;
> 	u32	remote_nonce;
> 	u64	thmac;
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 485f00dcaf84..8d045c24da59 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -481,7 +481,45 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
> 	mptcp_subflow_reset(sk);
> }
>
> -struct request_sock_ops mptcp_subflow_request_sock_ops;
> +static int subflow_chk_local_id(struct sock *sk)
> +{
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> +	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
> +	int err;
> +
> +	if (likely(subflow->local_id_valid))
> +		return 0;
> +
> +	err = mptcp_pm_get_local_id(msk, (struct sock_common *)sk);
> +	if (err < 0)
> +		return err;
> +
> +	subflow->local_id = err;
> +	subflow->local_id_valid = 1;
> +	return 0;
> +}
> +
> +static int subflow_rebuild_header(struct sock *sk)
> +{
> +	int err = subflow_chk_local_id(sk);
> +
> +	if (unlikely(err < 0))
> +		return err;
> +
> +	return inet_sk_rebuild_header(sk);
> +}
> +
> +static int subflow_v6_rebuild_header(struct sock *sk)
> +{
> +	int err = subflow_chk_local_id(sk);
> +
> +	if (unlikely(err < 0))
> +		return err;
> +
> +	return inet6_sk_rebuild_header(sk);
> +}
> +
> + struct request_sock_ops mptcp_subflow_request_sock_ops;

Accidental space added at the beginning of this line.

-Mat

> EXPORT_SYMBOL_GPL(mptcp_subflow_request_sock_ops);
> static struct tcp_request_sock_ops subflow_request_sock_ipv4_ops;
>
> @@ -1404,12 +1442,9 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
> 		get_random_bytes(&subflow->local_nonce, sizeof(u32));
> 	} while (!subflow->local_nonce);
>
> -	if (!local_id) {
> -		err = mptcp_pm_get_local_id(msk, (struct sock_common *)ssk);
> -		if (err < 0)
> -			goto failed;
> -
> -		local_id = err;
> +	if (local_id) {
> +		subflow->local_id = local_id;
> +		subflow->local_id_valid = 1;
> 	}
>
> 	mptcp_pm_get_flags_and_ifindex_by_id(sock_net(sk), local_id,
> @@ -1435,7 +1470,6 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
> 	pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d", msk,
> 		 remote_token, local_id, remote_id);
> 	subflow->remote_token = remote_token;
> -	subflow->local_id = local_id;
> 	subflow->remote_id = remote_id;
> 	subflow->request_join = 1;
> 	subflow->request_bkup = !!(flags & MPTCP_PM_ADDR_FLAG_BACKUP);
> @@ -1735,6 +1769,9 @@ static void subflow_ulp_clone(const struct request_sock *req,
> 		new_ctx->token = subflow_req->token;
> 		new_ctx->ssn_offset = subflow_req->ssn_offset;
> 		new_ctx->idsn = subflow_req->idsn;
> +
> +		/* this is the first subflow, id is always 0 */
> +		new_ctx->local_id_valid = 1;
> 	} else if (subflow_req->mp_join) {
> 		new_ctx->ssn_offset = subflow_req->ssn_offset;
> 		new_ctx->mp_join = 1;
> @@ -1744,6 +1781,9 @@ static void subflow_ulp_clone(const struct request_sock *req,
> 		new_ctx->remote_id = subflow_req->remote_id;
> 		new_ctx->token = subflow_req->token;
> 		new_ctx->thmac = subflow_req->thmac;
> +
> +		/* let rebuild header later get the correct ID */
> +		new_ctx->local_id_valid = 0;
> 	}
> }
>
> @@ -1796,6 +1836,7 @@ void __init mptcp_subflow_init(void)
> 	subflow_specific.conn_request = subflow_v4_conn_request;
> 	subflow_specific.syn_recv_sock = subflow_syn_recv_sock;
> 	subflow_specific.sk_rx_dst_set = subflow_finish_connect;
> +	subflow_specific.rebuild_header = subflow_rebuild_header;
>
> 	tcp_prot_override = tcp_prot;
> 	tcp_prot_override.release_cb = tcp_release_cb_override;
> @@ -1808,6 +1849,7 @@ void __init mptcp_subflow_init(void)
> 	subflow_v6_specific.conn_request = subflow_v6_conn_request;
> 	subflow_v6_specific.syn_recv_sock = subflow_syn_recv_sock;
> 	subflow_v6_specific.sk_rx_dst_set = subflow_finish_connect;
> +	subflow_v6_specific.rebuild_header = subflow_v6_rebuild_header;
>
> 	subflow_v6m_specific = subflow_v6_specific;
> 	subflow_v6m_specific.queue_xmit = ipv4_specific.queue_xmit;
> @@ -1815,6 +1857,7 @@ void __init mptcp_subflow_init(void)
> 	subflow_v6m_specific.net_header_len = ipv4_specific.net_header_len;
> 	subflow_v6m_specific.mtu_reduced = ipv4_specific.mtu_reduced;
> 	subflow_v6m_specific.net_frag_header_len = 0;
> +	subflow_v6m_specific.rebuild_header = subflow_rebuild_header;
>
> 	tcpv6_prot_override = tcpv6_prot;
> 	tcpv6_prot_override.release_cb = tcp_release_cb_override;
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
