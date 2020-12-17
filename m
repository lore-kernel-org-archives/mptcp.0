Content-Type: multipart/mixed; boundary="===============5142372497464344157=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next 1/3] mptcp: create subflow or
 signal addr for newly added address
Date: Thu, 17 Dec 2020 14:58:00 -0800
Message-ID: <78de87a-5b21-6298-f62c-21fb46a9ca50@linux.intel.com>
In-Reply-To: 73d430a234a018dbef408242b1b40461e96dfb91.1608111058.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7206

--===============5142372497464344157==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Dec 2020, Geliang Tang wrote:

> Currently, when a new MPTCP endpoint is added, the existing MPTCP sockets
> are not affected.
>
> This patch implemented a new function mptcp_nl_add_subflow_or_signal_addr,
> invoked when an address is added from PM netlink. This function traversed
> the MPTCP sockets list and invoked mptcp_pm_create_subflow_or_signal_addr
> to try to create a subflow or signal an address for the newly added
> address, if local constraint allows that.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/pm_netlink.c | 37 +++++++++++++++++++++++++++++++++++++
> 1 file changed, 37 insertions(+)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 987e83cdee11..2614d3e80ab6 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -883,6 +883,41 @@ static struct pm_nl_pernet *genl_info_pm_nl(struct g=
enl_info *info)
> 	return net_generic(genl_info_net(info), pm_nl_pernet_id);
> }
>
> +static int mptcp_nl_add_subflow_or_signal_addr(struct net *net,
> +					       struct mptcp_addr_info *addr)

Looks like 'addr' carried over from copying =

mptcp_nl_remove_subflow_or_signal_addr() - it's not used in this function. =

See comment in mptcp_nl_cmd_add_addr() below.

> +{
> +	struct mptcp_sock *msk;
> +	long s_slot =3D 0, s_num =3D 0;
> +
> +	while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=3D NULL)=
 {
> +		struct pm_nl_pernet *pernet =3D net_generic(net, pm_nl_pernet_id);
> +		struct sock *sk =3D (struct sock *)msk;
> +
> +		spin_lock_bh(&msk->pm.lock);
> +		if (!READ_ONCE(msk->fully_established)) {
> +			spin_unlock_bh(&msk->pm.lock);
> +			goto next;
> +		}
> +
> +		msk->pm.add_addr_signal_max =3D READ_ONCE(pernet->add_addr_signal_max);
> +		msk->pm.add_addr_accept_max =3D READ_ONCE(pernet->add_addr_accept_max);
> +		msk->pm.local_addr_max =3D READ_ONCE(pernet->local_addr_max);

Does it still make sense to have per-msk copies of these values, rather =

than referring directly to the pernet values?

> +		spin_unlock_bh(&msk->pm.lock);
> +
> +		lock_sock(sk);
> +		spin_lock_bh(&msk->pm.lock);
> +		mptcp_pm_create_subflow_or_signal_addr(msk);
> +		spin_unlock_bh(&msk->pm.lock);
> +		release_sock(sk);
> +
> +next:
> +		sock_put(sk);
> +		cond_resched();
> +	}
> +
> +	return 0;
> +}
> +
> static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *i=
nfo)
> {
> 	struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_ADDR];
> @@ -918,6 +953,8 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb,=
 struct genl_info *info)
> 		return ret;
> 	}
>
> +	mptcp_nl_add_subflow_or_signal_addr(sock_net(skb->sk), &entry->addr);

The entry->addr is ignored in mptcp_nl_add_subflow_or_signal_addr() right =

now.

It looks like the select_signal_address() and select_local_address() are =

intended to select the newest entries anyway, so you could either remove =

the addr parameter or use it to make sure the expected address is =

announced or connected.

> +
> 	return 0;
> }
>
> -- =

> 2.29.2

--
Mat Martineau
Intel
--===============5142372497464344157==--
