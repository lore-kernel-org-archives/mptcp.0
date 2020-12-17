Content-Type: multipart/mixed; boundary="===============5044155719587207831=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 1/2] mptcp: convert IPv4
 address to IPv4-mapped
Date: Wed, 16 Dec 2020 16:23:40 -0800
Message-ID: <f4a83eea-4bb0-87db-c05f-225b2a1f52fe@linux.intel.com>
In-Reply-To: 5df4ef900cea6618e5df0756474ecd5bbae3c9f8.1608102360.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7203

--===============5044155719587207831==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Dec 2020, Geliang Tang wrote:

> Currently, PM doesn't create subflow with IPv4-mapped IPv6 socket. This
> patch converts the IPv4 address to IPv4-mapped IPv6 address to fix it.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/pm_netlink.c | 25 ++++++++++++++++++++++---
> 1 file changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index cc4ca013a06b..987e83cdee11 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -133,6 +133,19 @@ static bool lookup_subflow_by_saddr(const struct lis=
t_head *list,
> 	return false;
> }
>
> +static void mptcp_pm_addr_convert_v4mapped(struct mptcp_sock *msk,
> +					   struct mptcp_addr_info *addr)
> +{
> +	struct mptcp_addr_info local;
> +
> +	local_address((struct sock_common *)msk, &local);
> +	if (ipv6_addr_v4mapped(&local.addr6) &&
> +	    addr->family =3D=3D AF_INET) {
> +		ipv6_addr_set_v4mapped(addr->addr.s_addr, &addr->addr6);
> +		addr->family =3D AF_INET6;
> +	}
> +}
> +
> static struct mptcp_pm_addr_entry *
> select_local_address(const struct pm_nl_pernet *pernet,
> 		     struct mptcp_sock *msk)
> @@ -145,6 +158,8 @@ select_local_address(const struct pm_nl_pernet *perne=
t,
> 		if (!(entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
> 			continue;
>
> +		mptcp_pm_addr_convert_v4mapped(msk, &entry->addr);
> +

This is modifying the contents of pernet->local_addr_list, not a copy of =

the entry, when the msk has a v4mapped address. I'm not sure that's the =

way to fix this, and might leave some corner cases unaddressed.

Did you look at modifying addresses_equal() so it can detect equivalent =

IPv4 and v4mapped addresses?

> 		/* avoid any address already in use by subflows and
> 		 * pending join
> 		 */

There's some code just below this comment that would need to be updated - =

I'm not sure why the address family needs to be checked before calling =

lookup_subflow_by_saddr(), except as an optimization.

I will talk to the group about v4mapped address handling at the meeting =

tomorrow to see if there are other opinions on how this should be handled =

(I will check this email thread and =

https://github.com/multipath-tcp/mptcp_net-next/issues/122 for any updates =

first). I'll follow up on the github issue if needed.

Mat


> @@ -159,9 +174,11 @@ select_local_address(const struct pm_nl_pernet *pern=
et,
> }
>
> static struct mptcp_pm_addr_entry *
> -select_signal_address(struct pm_nl_pernet *pernet, unsigned int pos)
> +select_signal_address(struct pm_nl_pernet *pernet,
> +		      struct mptcp_sock *msk)
> {
> 	struct mptcp_pm_addr_entry *entry, *ret =3D NULL;
> +	unsigned int pos =3D msk->pm.add_addr_signaled;
> 	int i =3D 0;
>
> 	rcu_read_lock();
> @@ -173,6 +190,9 @@ select_signal_address(struct pm_nl_pernet *pernet, un=
signed int pos)
> 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
> 		if (!(entry->addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
> 			continue;
> +
> +		mptcp_pm_addr_convert_v4mapped(msk, &entry->addr);
> +
> 		if (i++ =3D=3D pos) {
> 			ret =3D entry;
> 			break;
> @@ -346,8 +366,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(st=
ruct mptcp_sock *msk)
>
> 	/* check first for announce */
> 	if (msk->pm.add_addr_signaled < msk->pm.add_addr_signal_max) {
> -		local =3D select_signal_address(pernet,
> -					      msk->pm.add_addr_signaled);
> +		local =3D select_signal_address(pernet, msk);
>
> 		if (local) {
> 			if (mptcp_pm_alloc_anno_list(msk, local)) {
> -- =

> 2.29.2
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============5044155719587207831==--
