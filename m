Content-Type: multipart/mixed; boundary="===============1997159727087055756=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-next 5/5] mptcp: add netlink event support
Date: Wed, 20 Jan 2021 18:15:57 +0100
Message-ID: <e9d41ab0-1672-e581-e1e3-495399600011@tessares.net>
In-Reply-To: 20210120154337.27997-6-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7461

--===============1997159727087055756==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 20/01/2021 16:43, Florian Westphal wrote:
> Allow userspace (mptcpd) to subscribe to mptcp genl multicast events.
> This implementation reuses the same event API as the mptcp kernel fork
> to ease integration of existing tools, e.g. mptcpd.
> =

> Supported events include:
> 1. start and close of an mptcp connection
> 2. start and close of subflows (joins)
> 3. announce and withdrawals of addresses
> 4. subflow priority (backup/non-backup) change.
> =

> Signed-off-by: Florian Westphal <fw(a)strlen.de>

Thank you for the v2!

(...)

 > diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
 > index 3674a451a18c..4983ced8e1f8 100644
 > --- a/include/uapi/linux/mptcp.h
 > +++ b/include/uapi/linux/mptcp.h
 > @@ -36,6 +36,7 @@ enum {
 >   /* netlink interface */
 >   #define MPTCP_PM_NAME		"mptcp_pm"
 >   #define MPTCP_PM_CMD_GRP_NAME	"mptcp_pm_cmds"
 > +#define MPTCP_PM_EV_GRP_NAME    "mptcp_events"

We will check if it is OK for Ossama :)

(...)

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index e2f40985b450..c2939362f47a 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c

(...)

> +static int mptcp_event_put_token_and_ssk(struct sk_buff *skb,
> +					 const struct mptcp_sock *msk,
> +					 const struct sock *ssk)
> +{
> +	const struct sock *sk =3D (const struct sock *)msk;
> +	const struct mptcp_subflow_context *sf;
> +	u8 sk_err;
> +
> +	if (nla_put_u32(skb, MPTCP_ATTR_TOKEN, msk->token))
> +		return -EMSGSIZE;
> +
> +	if (mptcp_event_add_subflow(skb, ssk))
> +		return -EMSGSIZE;
> +
> +	sf =3D mptcp_subflow_ctx(ssk);
> +	if (WARN_ON_ONCE(!sf))
> +		return -EINVAL;
> +
> +	if (nla_put_u8(skb, MPTCP_ATTR_BACKUP, sf->backup))
> +		return -EMSGSIZE;
> +
> +	if (ssk->sk_bound_dev_if &&
> +	    nla_put_s32(skb, MPTCP_ATTR_IF_IDX, ssk->sk_bound_dev_if))
> +		return -EMSGSIZE;
> +
> +	sk_err =3D ssk->sk_err;

Could we have an error set on the msk? (sk->sk_err)
I don't remember why but in mptcp.org, we take the one of the subflow if =

there is one and we fallback to the sk_err of the meta. But I don't =

remember in which case we can have sk_err set on the meta. And not sure =

if we can have one in the msk :)

It seems that we look for sk_err only in the ssk (subflow.c) and in =

mptcp_recvmsg() but maybe just because this code is an adaptation of the =

one from TCP?

> +	if (sk_err && sk->sk_state =3D=3D TCP_ESTABLISHED &&
> +	    nla_put_u8(skb, MPTCP_ATTR_ERROR, sk_err))
> +		return -EMSGSIZE;
> +
> +	return 0;
> +}

Thank you for the other modifications!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1997159727087055756==--
