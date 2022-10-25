Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889017B
	for <mptcp@lists.linux.dev>; Tue, 25 Oct 2022 23:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666741713; x=1698277713;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=krztFdn7roUL9lzVqTfUuCPea2Sn4xIaJTazFUW646o=;
  b=RVgtKKqnPqC8OobtY2C2KIwVN2ncXSL09/bpv1jKL2xwApj8TRHTrWhg
   JtjlIM4pGZS2QdNm51LEufyPC+sAA1+5F+pPMvYy7RfF/JmQ7mXvBYqx7
   t9JJQIWzqX6jVwMP2lWokwa/eu/+4IPDBsGah8rEtxf6XkG+24JUiEjF4
   VqYHqSND3gxCIa9fBWVniM0qLDDgLe9QzKq0o8FjxkOobR+04hfv32FQn
   04CNuBwEVPF4SD4kOJd7Ol21Z+4Ds7NxXD28z/lLAABVgBaTWpZN9S5Wt
   h77HxY5Brf1QLWKyXQNCjTu4u0j7NLq0m82RMIWVPVN84jnzxeNLMibza
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="306548349"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="306548349"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 16:48:32 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="662992933"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="662992933"
Received: from knnguyen-mobl1.amr.corp.intel.com ([10.209.107.240])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 16:48:32 -0700
Date: Tue, 25 Oct 2022 16:48:32 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev, Ossama Othman <ossama.othman@intel.com>
Subject: Re: [RFC mptcp-next] mptcp: add pm listener events
In-Reply-To: <20221025092444.6646-1-geliang.tang@suse.com>
Message-ID: <1797dfcf-d766-d4be-247d-8882748e977d@linux.intel.com>
References: <20221025092444.6646-1-geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 25 Oct 2022, Geliang Tang wrote:

> This patch adds MPTCP netlink events for PM listening socket create and
> close.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/313
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> include/uapi/linux/mptcp.h |  9 ++++++
> net/mptcp/pm_netlink.c     | 66 +++++++++++++++++++++++++++++++++++++-
> net/mptcp/protocol.h       |  3 ++
> 3 files changed, 77 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index dfe19bf13f4c..4307807ba8d4 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -160,6 +160,12 @@ struct mptcp_info {
>  *                           daddr4 | daddr6, sport, dport, backup, if_idx
>  *                           [, error]
>  * The priority of a subflow has changed. 'error' should not be set.
> + *
> + * MPTCP_EVENT_LISTENER_CREATED: loc_id, family, sport, saddr4 | saddr6
> + * A new PM listener is created.
> + *
> + * MPTCP_EVENT_LISTENER_CLOSED: loc_id, family, sport, saddr4 | saddr6
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
> index 9813ed0fde9b..85cdd957bb11 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -894,8 +894,13 @@ static bool address_use_port(struct mptcp_pm_addr_entry *entry)
> /* caller must ensure the RCU grace period is already elapsed */
> static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
> {
> -	if (entry->lsk)
> +	if (entry->lsk) {
> +		struct mptcp_sock *msk = mptcp_sk(entry->lsk->sk);
> +
> 		sock_release(entry->lsk);
> +		mptcp_event_pm_listener(msk, &entry->addr,
> +					MPTCP_EVENT_LISTENER_CLOSED);
> +	}

It would be better to send the event before the sock_release() to ensure 
the msk pointer is valid.

> 	kfree(entry);
> }
>
> @@ -1008,6 +1013,9 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
> 		goto out;
> 	}
>
> +	mptcp_event_pm_listener(msk, &entry->addr,
> +				MPTCP_EVENT_LISTENER_CREATED);
> +

Hi Geliang -

I think my github issue did not have enough detail :)

I was thinking the events should be triggered for any MPTCP listening 
socket. So, MPTCP_EVENT_LISTENER_CREATED would be sent from 
mptcp_listen(), and then send the _CLOSED event when any MPTCP listener is 
destroyed.

This would allow a userspace PM to act when any process in the net 
namespace creates a listening socket.

- Mat


> 	ssock = __mptcp_nmpc_socket(msk);
> 	if (!ssock) {
> 		err = -EINVAL;
> @@ -2159,6 +2167,58 @@ void mptcp_event_addr_announced(const struct sock *ssk,
> 	kfree_skb(skb);
> }
>
> +void mptcp_event_pm_listener(const struct mptcp_sock *msk,
> +			     const struct mptcp_addr_info *info,
> +			     enum mptcp_event_type event)
> +{
> +	struct net *net = sock_net((struct sock *)msk);
> +	struct nlmsghdr *nlh;
> +	struct sk_buff *skb;
> +
> +	if (!genl_has_listeners(&mptcp_genl_family, net, MPTCP_PM_EV_GRP_OFFSET))
> +		return;
> +
> +	skb = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
> +	if (!skb)
> +		return;
> +
> +	nlh = genlmsg_put(skb, 0, 0, &mptcp_genl_family, 0, event);
> +	if (!nlh)
> +		goto nla_put_failure;
> +
> +	if (nla_put_u8(skb, MPTCP_ATTR_LOC_ID, info->id))
> +		goto nla_put_failure;
> +
> +	if (nla_put_u16(skb, MPTCP_ATTR_FAMILY, info->family))
> +		goto nla_put_failure;
> +
> +	if (nla_put_be16(skb, MPTCP_ATTR_SPORT, info->port))
> +		goto nla_put_failure;
> +
> +	switch (info->family) {
> +	case AF_INET:
> +		if (nla_put_in_addr(skb, MPTCP_ATTR_SADDR4, info->addr.s_addr))
> +			goto nla_put_failure;
> +		break;
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	case AF_INET6:
> +		if (nla_put_in6_addr(skb, MPTCP_ATTR_SADDR6, &info->addr6))
> +			goto nla_put_failure;
> +		break;
> +#endif
> +	default:
> +		WARN_ON_ONCE(1);
> +		goto nla_put_failure;
> +	}
> +
> +	genlmsg_end(skb, nlh);
> +	mptcp_nl_mcast_send(net, skb, GFP_ATOMIC);
> +	return;
> +
> +nla_put_failure:
> +	kfree_skb(skb);
> +}
> +
> void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
> 		 const struct sock *ssk, gfp_t gfp)
> {
> @@ -2204,6 +2264,10 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
> 		if (mptcp_event_sub_closed(skb, msk, ssk) < 0)
> 			goto nla_put_failure;
> 		break;
> +	case MPTCP_EVENT_LISTENER_CREATED:
> +		break;
> +	case MPTCP_EVENT_LISTENER_CLOSED:
> +		break;
> 	}
>
> 	genlmsg_end(skb, nlh);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 8f48f881adf8..be1e8f434b1c 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -839,6 +839,9 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
> 		 const struct sock *ssk, gfp_t gfp);
> void mptcp_event_addr_announced(const struct sock *ssk, const struct mptcp_addr_info *info);
> void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
> +void mptcp_event_pm_listener(const struct mptcp_sock *msk,
> +			     const struct mptcp_addr_info *info,
> +			     enum mptcp_event_type event);
> bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
>
> static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
