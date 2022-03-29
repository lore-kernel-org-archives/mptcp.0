Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC1817C9
	for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 01:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648516173; x=1680052173;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=P5E8Ku/F7Jk+83lFOo/+E1UDTJxPXdpDzkd+H5NJFy0=;
  b=a/hb1HLAfUZ2xt7Gv8YxSPAQltQE99yy+PiYe6kWoMqB9ROVjWfSuup6
   ZKedvFzgMzxgABEuqLxdF/r36I7lX33PLpVGWZUYReRwZepLheBRiMVJe
   MT9LWMpLnb80cfGM/2yf8hNCPUasN4dfQACiCF9dN4zgq2le3o3OpYDRX
   Arj9bwLq2hcM4bXk2AmP03d753vc7drp2NtKRJX67iNHd/6+5cDKvIWYu
   Y6lanZOZbj83ShPuUMzbHr1FBkswnvKwCXfzbaVdUzX2M0a3a+0jBPXG/
   cVMhlm0eslj1GmL3jRKuO3sSrOyNSlmXLcKA80RPTgvqaGFWopZugC85+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="256711520"
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="256711520"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 18:09:32 -0700
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="564162904"
Received: from pchung1-mobl.amr.corp.intel.com ([10.209.44.61])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 18:09:32 -0700
Date: Mon, 28 Mar 2022 18:09:32 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 3/3] mptcp: listen diag dump support
In-Reply-To: <20220328124913.29768-4-fw@strlen.de>
Message-ID: <972fd6c2-8dfa-971f-c28c-45ab5c48@linux.intel.com>
References: <20220328124913.29768-1-fw@strlen.de> <20220328124913.29768-4-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 28 Mar 2022, Florian Westphal wrote:

> makes 'ss -Ml' show mptcp listen sockets.
>
> Iterate over the tcp listen sockets and pick those that have mptcp ulp
> info attached.
>
> mptcp_diag_get_info() is modified to prefer msk->first for mptcp sockets
> in listen state.  This reports accurate number for recv and send queue
> (pending / max connection backlog counters).
>
> Sample output:
> ss -Mil
> State        Recv-Q Send-Q Local Address:Port  Peer Address:Port
> LISTEN       0      20     127.0.0.1:12000     0.0.0.0:*
>         subflows_max:2
>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
> Changes:
>  - place functionality in helper function
>  - prefer msk->first for msk listeners
>  - more verbose commit message
>
> net/mptcp/mptcp_diag.c | 88 ++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 88 insertions(+)
>
> diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
> index c4992eeb67d8..076dd99d35d9 100644
> --- a/net/mptcp/mptcp_diag.c
> +++ b/net/mptcp/mptcp_diag.c
> @@ -69,8 +69,80 @@ static int mptcp_diag_dump_one(struct netlink_callback *cb,
> struct mptcp_diag_ctx {
> 	long s_slot;
> 	long s_num;
> +	unsigned int l_slot;
> +	unsigned int l_num;
> };
>
> +static void mptcp_diag_dump_listeners(struct sk_buff *skb, struct netlink_callback *cb,
> +				      const struct inet_diag_req_v2 *r,
> +				      bool net_admin)
> +{
> +	struct mptcp_diag_ctx *diag_ctx = (void *)cb->ctx;
> +	struct net *net = sock_net(skb->sk);
> +	struct nlattr *bc;
> +	int i;
> +
> +	for (i = diag_ctx->l_slot; i < INET_LHTABLE_SIZE; i++) {
> +		struct inet_listen_hashbucket *ilb;
> +		struct hlist_nulls_node *node;
> +		struct sock *sk;
> +		int num = 0;
> +
> +		ilb = &tcp_hashinfo.listening_hash[i];
> +
> +		rcu_read_lock();
> +		spin_lock(&ilb->lock);
> +		sk_nulls_for_each(sk, node, &ilb->nulls_head) {
> +			const struct mptcp_subflow_context *ctx = mptcp_subflow_ctx(sk);
> +			struct inet_sock *inet = inet_sk(sk);
> +			int ret;
> +
> +			if (num < diag_ctx->l_num)
> +				goto next_listen;
> +
> +			if (!ctx || strcmp(inet_csk(sk)->icsk_ulp_ops->name, "mptcp"))
> +				goto next_listen;
> +
> +			sk = ctx->conn;
> +			if (!sk || !net_eq(sock_net(sk), net))
> +				goto next_listen;
> +
> +			if (r->sdiag_family != AF_UNSPEC &&
> +			    sk->sk_family != r->sdiag_family)
> +				goto next_listen;
> +
> +			if (r->id.idiag_sport != inet->inet_sport &&
> +			    r->id.idiag_sport)
> +				goto next_listen;
> +
> +			if (!refcount_inc_not_zero(&sk->sk_refcnt))
> +				goto next_listen;
> +
> +			ret = sk_diag_dump(sk, skb, cb, r, bc, net_admin);

As the kbuild bot noticed, bc is uninitialized here.

> +					   sock_put(sk);

Extra tabs here.

It built and ran fine, with some manual tests and diag.sh. Speaking of 
diag.sh, some coverage there for the new MPTCP listener functionality 
would be good.

- Mat

> +			if (ret < 0) {
> +				spin_unlock(&ilb->lock);
> +				rcu_read_unlock();
> +				diag_ctx->l_slot = i;
> +				diag_ctx->l_num = num;
> +				return;
> +			}
> +			diag_ctx->l_num = num + 1;
> +			num = 0;
> +next_listen:
> +			++num;
> +		}
> +		spin_unlock(&ilb->lock);
> +		rcu_read_unlock();
> +
> +		cond_resched();
> +		diag_ctx->l_num = 0;
> +	}
> +
> +	diag_ctx->l_num = 0;
> +	diag_ctx->l_slot = i;
> +}
> +
> static void mptcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
> 			    const struct inet_diag_req_v2 *r)
> {
> @@ -114,6 +186,9 @@ static void mptcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
> 		}
> 		cond_resched();
> 	}
> +
> +	if ((r->idiag_states & TCPF_LISTEN) && r->id.idiag_dport == 0)
> +		mptcp_diag_dump_listeners(skb, cb, r, net_admin);
> }
>
> static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
> @@ -124,6 +199,19 @@ static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
>
> 	r->idiag_rqueue = sk_rmem_alloc_get(sk);
> 	r->idiag_wqueue = sk_wmem_alloc_get(sk);
> +
> +	if (inet_sk_state_load(sk) == TCP_LISTEN) {
> +		struct sock *lsk = READ_ONCE(msk->first);
> +
> +		if (lsk) {
> +			/* override with settings from tcp listener,
> +			 * so Send-Q will show accept queue.
> +			 */
> +			r->idiag_rqueue = READ_ONCE(lsk->sk_ack_backlog);
> +			r->idiag_wqueue = READ_ONCE(lsk->sk_max_ack_backlog);
> +		}
> +	}
> +
> 	if (!info)
> 		return;
>
> -- 
> 2.35.1
>
>
>

--
Mat Martineau
Intel
