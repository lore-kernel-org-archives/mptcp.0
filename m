Content-Type: multipart/mixed; boundary="===============7941243588691359571=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp 7/7] mptcp: add netlink event support
Date: Tue, 19 Jan 2021 22:31:46 +0100
Message-ID: <85d38d39-fe36-5605-88be-f67ed14864f8@tessares.net>
In-Reply-To: 20210114173654.7618-8-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7428

--===============7941243588691359571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 14/01/2021 18:36, Florian Westphal wrote:
> Allow userspace (mptcpd) to subscribe to mptcp genl multicast events.
> This implementation reuses the same event API as the mptcp kernel fork
> to ease integration of existing tools, e.g. mptcpd.
> =

> Supported events include:
> 1. start and close of an mptcp connection
> 2. start and close of subflows (joins)
> 3. announce and withdrawals of addresses
> 4. subflow priority (backup/non-backup) change.

Thank you for looking at that, that's really nice! :)

The previous patches look really good to me but I would not mind a =

second look for the previous patches modifying how the locks are used: =

I'm not sure I have a good global view to give a proper review on these =

ones.

My comments for this patch are below if you don't mind looking:

> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index 3674a451a18c..7ee275a2cfdd 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -36,6 +36,7 @@ enum {
>   /* netlink interface */
>   #define MPTCP_PM_NAME		"mptcp_pm"
>   #define MPTCP_PM_CMD_GRP_NAME	"mptcp_pm_cmds"
> +#define MPTCP_PM_EV_GRP_NAME    "mptcp_events"
>   #define MPTCP_PM_VER		0x1
>   =

>   /*
> @@ -104,4 +105,73 @@ struct mptcp_info {
>   	__u64	mptcpi_rcv_nxt;
>   };
>   =

> +/*
> + * MPTCP_EVENT_CREATED: token, family, saddr4 | saddr6, daddr4 | daddr6,
> + *                         sport, dport
> + *    A new MPTCP connection has been created. It is the good time to al=
locate
> + *    memory and send ADD_ADDR if needed. Depending on the traffic-patte=
rns
> + *    it can take a long time until the MPTCP_EVENT_ESTABLISHED is sent.
> + *
> + * MPTCP_EVENT_ESTABLISHED: token, family, saddr4 | saddr6, daddr4 | dad=
dr6,
> + *			    sport, dport
> + *    A MPTCP connection is established (can start new subflows).
> + *
> + * MPTCP_EVENT_CLOSED: token
> + *    A MPTCP connection has stopped.
> + *
> + * MPTCP_EVENT_ANNOUNCED: token, rem_id, family, daddr4 | daddr6 [, dpor=
t]
> + *    A new address has been announced by the peer.
> + *
> + * MPTCP_EVENT_REMOVED: token, rem_id
> + *    An address has been lost by the peer.
> + *
> + * MPTCP_EVENT_SUB_ESTABLISHED: token, family, saddr4 | saddr6,
> + *                              daddr4 | daddr6, sport, dport, backup,
> + *                              if_idx

Even if it is quite obvious, should we add a comment for this one like =

for the others, e.g.

   A new subflow has been established.

(at least to explain that "sub" stands for "subflow" :) )

> + *
> + * MPTCP_EVENT_SUB_CLOSED: token, family, saddr4 | saddr6, daddr4 | dadd=
r6,
> + *                         sport, dport, backup, if_idx
> + *    A subflow has been closed.

I noticed that the error (copy of sk_err) is not in the arguments.
Is it simply because we don't need them in the first version or because =

there is a technical issue?

A PM might want to know why a subflow has been closed: was it closed by =

a RST, timeout, etc.?

No issue for me to add it later (if it is possible) ;-)

> + *
> + * MPTCP_EVENT_SUB_PRIORITY: token, family, saddr4 | saddr6, daddr4 | da=
ddr6,
> + *                              sport, dport, backup, if_idx
> + */

May we add a short description here too?

   The priority of a subflow has changed.

(...)

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 8d0628590ca8..8c193e009886 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c

(...)

> +static int mptcp_event_sub_established(struct sk_buff *skb, const struct=
 mptcp_sock *msk, const struct sock *ssk)

(tiny detail: is it OK to have such long line? Same for the functions =

below. Just to avoid checkpatch warnings but it is maybe not catched by =

checkpatch?)

(...)

> +static int mptcp_event_sub_closed(struct sk_buff *skb, const struct mptc=
p_sock *msk, const struct sock *ssk)
> +{
> +	if (mptcp_event_sub_established(skb, msk, ssk))

That looks strange to call mptcp_event_sub_established() in =

mptcp_event_sub_closed() but I understand we want to pack the same info :)

(...)

> +void mptcp_event_addr_removed(const struct mptcp_sock *msk, uint8_t id)
> +{
> +	struct net *net =3D sock_net((const struct sock *)msk);
> +        struct nlmsghdr *nlh;

(detail: the indentation is not correct)

(...)

> +	return mptcp_nl_mcast_send(net, skb, GFP_ATOMIC);

Just out of curiosity, is it always OK to have a "return f()" here while =

the current function returns a "void"? I am sure it is OK because the =

called function also returns "void" but no issues with some compilers =

(and some options) nor static analytic tools?

(no need to change of course, just I would not have thought about =

writing it like that)

> +
> +nla_put_failure:
> +	kfree_skb(skb);
> +}
> +
> +void mptcp_event_addr_announced(const struct mptcp_sock *msk, const stru=
ct mptcp_addr_info *info)
> +{
> +	struct net *net =3D sock_net((const struct sock *)msk);
> +        struct nlmsghdr *nlh;

(detail: the indentation is not correct)

> +	struct sk_buff *skb;
> +
> +	if (!genl_has_listeners(&mptcp_genl_family, net, MPTCP_PM_EV_GRP_OFFSET=
))
> +		return;
> +
> +	skb =3D nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
> +	if (!skb)
> +		return;
> +
> +	nlh =3D genlmsg_put(skb, 0, 0, &mptcp_genl_family, 0, MPTCP_EVENT_ANNOU=
NCED);
> +	if (!nlh)
> +		goto nla_put_failure;
> +
> +	if (nla_put_u32(skb, MPTCP_ATTR_TOKEN, msk->token))
> +		goto nla_put_failure;
> +
> +	if (nla_put_u32(skb, MPTCP_ATTR_REM_ID, info->id))

I think it's a u8 for rem ID.
Same above in mptcp_event_addr_removed()

> +		goto nla_put_failure;
> +
> +	if (nla_put_be16(skb, MPTCP_ATTR_DPORT, info->port))
> +		goto nla_put_failure;
> +
> +	switch (info->family) {
> +	case AF_INET:
> +		if (nla_put_in_addr(skb, MPTCP_ATTR_DADDR4, info->addr.s_addr))

(I should not review that late, I blocked here a few seconds thinking =

you were using the "source" addr for DADDR :) )

> +			goto nla_put_failure;
> +		break;
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	case AF_INET6:
> +		if (nla_put_in6_addr(skb, MPTCP_ATTR_DADDR6, &info->addr6))
> +			goto nla_put_failure;
> +		break;
> +#endif
> +	default:
> +		WARN_ON_ONCE(1);
> +		goto nla_put_failure;
> +	}
> +
> +	genlmsg_end(skb, nlh);
> +	return mptcp_nl_mcast_send(net, skb, GFP_ATOMIC);
> +
> +nla_put_failure:
> +	kfree_skb(skb);
> +}
> +
> +void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *ms=
k, const struct sock *ssk, gfp_t gfp)
> +{
> +	struct net *net =3D sock_net((const struct sock *)msk);
> +        struct nlmsghdr *nlh;

(detail: the indentation is not correct)

> +	struct sk_buff *skb;
> +
> +	if (!genl_has_listeners(&mptcp_genl_family, net, MPTCP_PM_EV_GRP_OFFSET=
))
> +		return;
> +
> +	skb =3D nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
> +	if (!skb)
> +		return;
> +
> +	nlh =3D genlmsg_put(skb, 0, 0, &mptcp_genl_family, 0, type);
> +	if (!nlh)
> +		goto nla_put_failure;
> +
> +	switch (type) {
> +	case MPTCP_EVENT_UNSPEC:
> +		WARN_ON_ONCE(1);
> +		break;

Probably useless but should we move this to the end and add "default"?

> +	case MPTCP_EVENT_CREATED:
> +	case MPTCP_EVENT_ESTABLISHED:
> +		if (mptcp_event_created(skb, msk, ssk) < 0)
> +			goto nla_put_failure;
> +		break;
> +	case MPTCP_EVENT_CLOSED:
> +		if (nla_put_u32(skb, MPTCP_ATTR_TOKEN, msk->token) < 0)
> +			goto nla_put_failure;
> +		break;
> +	case MPTCP_EVENT_ANNOUNCED:
> +	case MPTCP_EVENT_REMOVED:
> +		/* call mptcp_event_addr_announced()/removed instead */
> +		WARN_ON_ONCE(1);
> +		break;
> +	case MPTCP_EVENT_SUB_ESTABLISHED:
> +	case MPTCP_EVENT_SUB_PRIORITY:
> +		if (mptcp_event_sub_established(skb, msk, ssk) < 0)
> +			goto nla_put_failure;
> +		break;
> +	case MPTCP_EVENT_SUB_CLOSED:
> +		if (mptcp_event_sub_closed(skb, msk, ssk) < 0)
> +			goto nla_put_failure;
> +		break;
> +	}

(...)

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7941243588691359571==--
