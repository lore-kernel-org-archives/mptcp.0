Content-Type: multipart/mixed; boundary="===============5189390756566941289=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v5 mptcp-next 4/5] mptcp: remove id 0
 address
Date: Wed, 03 Mar 2021 12:09:02 -0800
Message-ID: <4f5cbae0-ff9a-fa76-7dd5-d29dd6a8ea6@linux.intel.com>
In-Reply-To: 96af88c9f74f6c75d307d1297d3c7293495b930f.1614776769.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8007

--===============5189390756566941289==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Mar 2021, Geliang Tang wrote:

> This patch added a new function mptcp_nl_remove_id_zero_address to
> remove the id 0 address.
>
> In this function, fill the remove list with the id 0, and pass it to
> mptcp_pm_remove_addr and mptcp_pm_remove_subflow.
>
> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/pm_netlink.c | 35 +++++++++++++++++++++++++++++++++++
> 1 file changed, 35 insertions(+)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 2bd61d55186b..6d04f5f77c61 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1164,6 +1164,33 @@ static void mptcp_pm_free_addr_entry(struct mptcp_=
pm_addr_entry *entry)
> 	}
> }
>
> +static int mptcp_nl_remove_id_zero_address(struct net *net)
> +{
> +	struct mptcp_sock *msk;
> +	long s_slot =3D 0, s_num =3D 0;
> +	struct mptcp_rm_list list =3D { .nr =3D 0 };
> +
> +	list.ids[list.nr++] =3D 0;
> +
> +	while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=3D NULL)=
 {
> +		struct sock *sk =3D (struct sock *)msk;
> +
> +		if (list_empty(&msk->conn_list))
> +			goto next;
> +
> +		lock_sock(sk);
> +		mptcp_pm_remove_addr(msk, &list);
> +		mptcp_pm_remove_subflow(msk, &list);
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
> static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *i=
nfo)
> {
> 	struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_ADDR];
> @@ -1176,6 +1203,14 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *s=
kb, struct genl_info *info)
> 	if (ret < 0)
> 		return ret;
>
> +	/* the zero id address is special: the first address used by the msk
> +	 * always gets such an id, so different subflows can have different zero
> +	 * id addresses. Additionally zero id is not accounted for in id_bitmap.
> +	 * Let's use an 'mptcp_rm_list' instead of the common remove code.
> +	 */
> +	if (addr.addr.id =3D=3D 0)
> +		return mptcp_nl_remove_id_zero_address(sock_net(skb->sk));
> +

For nonzero address IDs, we know that the ID maps to a single IP address =

for all MPTCP connections in the namespace.

For address ID =3D=3D 0, different MPTCP connections could be using differe=
nt =

IP addresses for id 0:

Socket A: using IP 1.2.3.4 for id 0, IP 11.22.33.44 for id 1
Socket B: using IP 5.6.7.8 for id 0, IP 11.22.33.44 for id 1

I don't think there is a use case for userspace asking to "delete all =

subflows with local ID 0 regardless of IP address".

Instead, I suggest that the del_addr netlink command require the full IP =

address when using id 0. If you pass the address in to =

mptcp_nl_remove_id_zero_address(), it can then remove only subflows using =

id 0 and the exact IP.


Thanks for the revisions, the first three patches look good!

Mat


> 	spin_lock_bh(&pernet->lock);
> 	entry =3D __lookup_addr_by_id(pernet, addr.addr.id);
> 	if (!entry) {
> -- =

> 2.29.2

--
Mat Martineau
Intel
--===============5189390756566941289==--
