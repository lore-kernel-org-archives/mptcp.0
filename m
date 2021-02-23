Content-Type: multipart/mixed; boundary="===============0116688197166486628=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next 1/4] mptcp: skip connecting the
 connected address
Date: Mon, 22 Feb 2021 16:54:05 -0800
Message-ID: <fed5780-b993-959c-539a-5a33357f21ff@linux.intel.com>
In-Reply-To: 75805ea33291f243d15785862ff2f41d9931a3bf.1613965565.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7902

--===============0116688197166486628==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Feb 2021, Geliang Tang wrote:

> This patch added a new helper named lookup_subflow_by_daddr to find
> whether the destination address is in the msk's conn_list.
>
> In mptcp_pm_nl_add_addr_received, use lookup_subflow_by_daddr to check
> whether the announced address is already connected. If it is, skip
> connecting this address.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/pm_netlink.c | 22 ++++++++++++++++++++++
> 1 file changed, 22 insertions(+)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 55fdcb1b5281..9396f9635231 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -140,6 +140,24 @@ static bool lookup_subflow_by_saddr(const struct lis=
t_head *list,
> 	return false;
> }
>
> +static bool lookup_subflow_by_daddr(const struct list_head *list,
> +				    struct mptcp_addr_info *daddr)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct mptcp_addr_info cur;
> +	struct sock_common *skc;
> +
> +	list_for_each_entry(subflow, list, node) {
> +		skc =3D (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
> +
> +		remote_address(skc, &cur);
> +		if (addresses_equal(&cur, daddr, daddr->port))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> static struct mptcp_pm_addr_entry *
> select_local_address(const struct pm_nl_pernet *pernet,
> 		     struct mptcp_sock *msk)
> @@ -476,6 +494,10 @@ static void mptcp_pm_nl_add_addr_received(struct mpt=
cp_sock *msk)
> 	pr_debug("accepted %d:%d remote family %d",
> 		 msk->pm.add_addr_accepted, add_addr_accept_max,
> 		 msk->pm.remote.family);
> +
> +	if (lookup_subflow_by_daddr(&msk->conn_list, &msk->pm.remote))
> +		return;
> +

If the subflow exists, the incoming ADD_ADDR should be treated the same as =

if pm->accept_addr was false (see mptcp_pm_add_addr_received()). We need =

to send the ADD_ADDR echo so the peer doesn't retransmit the ADD_ADDR.

> 	msk->pm.add_addr_accepted++;
> 	msk->pm.subflows++;
> 	if (msk->pm.add_addr_accepted >=3D add_addr_accept_max ||
> -- =

> 2.29.2

--
Mat Martineau
Intel
--===============0116688197166486628==--
