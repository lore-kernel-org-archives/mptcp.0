Content-Type: multipart/mixed; boundary="===============3241473560006344427=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: use
 WRITE_ONCE/READ_ONCE for the pernet *_max"
Date: Mon, 01 Feb 2021 14:21:57 -0800
Message-ID: <13ed1e0-4d0-ced2-199d-a86394a78c1b@linux.intel.com>
In-Reply-To: 3dae331b8fe7af727433d1d0eb0043538747f92e.1612053047.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7557

--===============3241473560006344427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, 31 Jan 2021, Geliang Tang wrote:

> As Jakub suggested, drop all the READ_ONCEs in the original patch.
>
> And the commit message needs to be updated too:
>
> -
>
> Subject: mptcp: use WRITE_ONCE for the pernet *_max
>
> This patch uses WRITE_ONCE() for all the pernet add_addr_signal_max,
> add_addr_accept_max, local_addr_max and subflows_max fields in struct
> pm_nl_pernet to avoid concurrency issues.
>
> -
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/pm_netlink.c | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)

Yes, Jakub was correct to point out that READ_ONCE() isn't needed when all =

of the writes are done with the lock held.

I'll go ahead and apply this locally and resubmit v2 now. Matthieu, I =

guess you should apply as well so the topgit tree updates correctly when =

the patches are applied on net-next.

Mat


>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 7d6081d9a1db..c429bd82313e 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -616,11 +616,11 @@ static int mptcp_pm_nl_append_new_local_addr(struct=
 pm_nl_pernet *pernet,
> 		pernet->next_id =3D entry->addr.id;
>
> 	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
> -		addr_max =3D READ_ONCE(pernet->add_addr_signal_max);
> +		addr_max =3D pernet->add_addr_signal_max;
> 		WRITE_ONCE(pernet->add_addr_signal_max, addr_max + 1);
> 	}
> 	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
> -		addr_max =3D READ_ONCE(pernet->local_addr_max);
> +		addr_max =3D pernet->local_addr_max;
> 		WRITE_ONCE(pernet->local_addr_max, addr_max + 1);
> 	}
>
> @@ -932,11 +932,11 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *sk=
b, struct genl_info *info)
> 		return -EINVAL;
> 	}
> 	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
> -		addr_max =3D READ_ONCE(pernet->add_addr_signal_max);
> +		addr_max =3D pernet->add_addr_signal_max;
> 		WRITE_ONCE(pernet->add_addr_signal_max, addr_max - 1);
> 	}
> 	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
> -		addr_max =3D READ_ONCE(pernet->local_addr_max);
> +		addr_max =3D pernet->local_addr_max;
> 		WRITE_ONCE(pernet->local_addr_max, addr_max - 1);
> 	}
>
> @@ -1140,12 +1140,12 @@ mptcp_nl_cmd_set_limits(struct sk_buff *skb, stru=
ct genl_info *info)
> 	int ret;
>
> 	spin_lock_bh(&pernet->lock);
> -	rcv_addrs =3D READ_ONCE(pernet->add_addr_accept_max);
> +	rcv_addrs =3D pernet->add_addr_accept_max;
> 	ret =3D parse_limit(info, MPTCP_PM_ATTR_RCV_ADD_ADDRS, &rcv_addrs);
> 	if (ret)
> 		goto unlock;
>
> -	subflows =3D READ_ONCE(pernet->subflows_max);
> +	subflows =3D pernet->subflows_max;
> 	ret =3D parse_limit(info, MPTCP_PM_ATTR_SUBFLOWS, &subflows);
> 	if (ret)
> 		goto unlock;
> -- =

> 2.29.2

--
Mat Martineau
Intel
--===============3241473560006344427==--
