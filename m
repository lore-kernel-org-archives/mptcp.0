Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D71192
	for <mptcp@lists.linux.dev>; Thu, 17 Nov 2022 00:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668646249; x=1700182249;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZL0CjjMj7tRsGcJ9xhgbsMYclzxOxs0CEau3FesIKqs=;
  b=Cr3hugxk+9t565OVyzc+I1bMBbialfzjoQukK0He6pSAaaNlHZxbQxMT
   HJOBVpYsYMviwkcZi91fvgbM4Ti15dqJ/wDG4kcfWFcEuNaE+vDqJp0Yv
   +dEGSKFzHVkUcx2lrqfV0cpZJBcmNarxNfNIFQUpnUilzC/tVw/EqX+vO
   dEGc392ceChqyvzZ3JytP8grp7pDr/eO4AVzJEHQfPmMYxomOnBhKTzho
   S3MvVU4uG/nnVppmnQHtixxE2/htUAMGJMmYiFk4fvxs/xccwyy+zbfJF
   2X9QMKcDEJyIu275+0yTlb/6zP723TK+Ef5pv4G9zpBE8eqcjB4R2ReIR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="376979447"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="376979447"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 16:50:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="764542962"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="764542962"
Received: from sanhitag-mobl.amr.corp.intel.com ([10.209.75.217])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 16:50:45 -0800
Date: Wed, 16 Nov 2022 16:50:45 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 1/4] mptcp: add pm listener events
In-Reply-To: <a97e3700eb1034493411759a554ce0ffdb858ddf.1668599064.git.geliang.tang@suse.com>
Message-ID: <ccf73baf-e19a-30d3-0911-26d30efeefde@linux.intel.com>
References: <cover.1668599064.git.geliang.tang@suse.com> <a97e3700eb1034493411759a554ce0ffdb858ddf.1668599064.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 16 Nov 2022, Geliang Tang wrote:

> This patch adds MPTCP netlink events for PM listening socket create and
> close.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

Hi Geliang -

The functionality here looks good, thanks for adding the tests. I have 
some questions below and on patch 4.

> ---
> include/uapi/linux/mptcp.h |  9 ++++++
> net/mptcp/pm_netlink.c     | 57 ++++++++++++++++++++++++++++++++++++++
> net/mptcp/protocol.c       |  3 ++
> net/mptcp/protocol.h       |  2 ++
> 4 files changed, 71 insertions(+)
>
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index dfe19bf13f4c..32af2d278cb4 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -160,6 +160,12 @@ struct mptcp_info {
>  *                           daddr4 | daddr6, sport, dport, backup, if_idx
>  *                           [, error]
>  * The priority of a subflow has changed. 'error' should not be set.
> + *
> + * MPTCP_EVENT_LISTENER_CREATED: family, sport, saddr4 | saddr6
> + * A new PM listener is created.
> + *
> + * MPTCP_EVENT_LISTENER_CLOSED: family, sport, saddr4 | saddr6
> + * A PM listener is closed.
>  */
> enum mptcp_event_type {
> 	MPTCP_EVENT_UNSPEC = 0,
> @@ -174,6 +180,9 @@ enum mptcp_event_type {
> 	MPTCP_EVENT_SUB_CLOSED = 11,
>
> 	MPTCP_EVENT_SUB_PRIORITY = 13,
> +
> +	MPTCP_EVENT_LISTENER_CREATED = 15,
> +	MPTCP_EVENT_LISTENER_CLOSED = 16,
> };
>
> enum mptcp_event_attr {
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 08806f97c8fb..685240f6bc80 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1026,6 +1026,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
> 	if (err)
> 		return err;
>
> +	mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
> +
> 	return 0;
> }
>
> @@ -2149,6 +2151,58 @@ void mptcp_event_addr_announced(const struct sock *ssk,
> 	kfree_skb(skb);
> }
>
> +void mptcp_event_pm_listener(const struct sock *ssk,
> +			     enum mptcp_event_type event)
> +{
> +	const struct inet_sock *issk = inet_sk(ssk);
> +	struct net *net = sock_net(ssk);
> +	struct nlmsghdr *nlh;
> +	struct sk_buff *skb;
> +
> +	if (!genl_has_listeners(&mptcp_genl_family, net, MPTCP_PM_EV_GRP_OFFSET))
> +		return;
> +
> +	skb = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);

This doesn't appear to run in atomic context, so GFP_KERNEL would be 
better.

> +	if (!skb)
> +		return;
> +
> +	nlh = genlmsg_put(skb, 0, 0, &mptcp_genl_family, 0, event);
> +	if (!nlh)
> +		goto nla_put_failure;
> +
> +	if (nla_put_u16(skb, MPTCP_ATTR_FAMILY, ssk->sk_family))
> +		goto nla_put_failure;
> +
> +	if (nla_put_be16(skb, MPTCP_ATTR_SPORT, issk->inet_sport))
> +		goto nla_put_failure;
> +
> +	switch (ssk->sk_family) {
> +	case AF_INET:
> +		if (nla_put_in_addr(skb, MPTCP_ATTR_SADDR4, issk->inet_saddr))
> +			goto nla_put_failure;
> +		break;
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	case AF_INET6: {
> +		const struct ipv6_pinfo *np = inet6_sk(ssk);
> +
> +		if (nla_put_in6_addr(skb, MPTCP_ATTR_SADDR6, &np->saddr))
> +			goto nla_put_failure;
> +		break;
> +	}
> +#endif
> +	default:
> +		WARN_ON_ONCE(1);
> +		goto nla_put_failure;
> +	}
> +
> +	genlmsg_end(skb, nlh);
> +	mptcp_nl_mcast_send(net, skb, GFP_ATOMIC);

GFP_KERNEL here too.

- Mat

> +	return;
> +
> +nla_put_failure:
> +	kfree_skb(skb);
> +}
> +
> void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
> 		 const struct sock *ssk, gfp_t gfp)
> {
> @@ -2194,6 +2248,9 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
> 		if (mptcp_event_sub_closed(skb, msk, ssk) < 0)
> 			goto nla_put_failure;
> 		break;
> +	case MPTCP_EVENT_LISTENER_CREATED:
> +	case MPTCP_EVENT_LISTENER_CLOSED:
> +		break;
> 	}
>
> 	genlmsg_end(skb, nlh);
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1f9b72b62998..c2bb4255969e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2366,6 +2366,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> 			tcp_set_state(ssk, TCP_CLOSE);
> 			mptcp_subflow_queue_clean(ssk);
> 			inet_csk_listen_stop(ssk);
> +			mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CLOSED);
> 		}
> 		__tcp_close(ssk, 0);
>
> @@ -3682,6 +3683,8 @@ static int mptcp_listen(struct socket *sock, int backlog)
> 	if (!err)
> 		mptcp_copy_inaddrs(sock->sk, ssock->sk);
>
> +	mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
> +
> unlock:
> 	release_sock(sock->sk);
> 	return err;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index ffecd103cc50..bae216bff6e4 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -846,6 +846,8 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
> 		 const struct sock *ssk, gfp_t gfp);
> void mptcp_event_addr_announced(const struct sock *ssk, const struct mptcp_addr_info *info);
> void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
> +void mptcp_event_pm_listener(const struct sock *ssk,
> +			     enum mptcp_event_type event);
> bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
>
> void mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
