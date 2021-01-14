Content-Type: multipart/mixed; boundary="===============0239797449360937126=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v5 2/4] mptcp: pm nl: support IPv4
 mapped in v6 addresses
Date: Thu, 14 Jan 2021 11:31:20 +0800
Message-ID: <CA+WQbwsOMenC7LqBOQY+ug8C4=VQYdRtDFFuNutzAt=Nar-cPw@mail.gmail.com>
In-Reply-To: 20210113175453.1945886-3-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7350

--===============0239797449360937126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2021=E5=B9=B41=E6=
=9C=8814=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=881:55=E5=86=99=E9=81=
=93=EF=BC=9A
>
> On one side, we can allow the creation of subflows between v4 mapped in
> v6 and v4 addresses. For that we look for v4mapped addresses between the
> local address we want to select and the remote one.
>
> On the other side, we also properly deal with received v4mapped
> addresses, either announced ones or set via Netlink.
>
> Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/122
> Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> Co-developed-by: Geliang Tang <geliangtang(a)gmail.com>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> ---
>
> Notes:
>     v4 -> v5:
>     - select_local_address(): extract info from sk again instead of using
>       remote
>     - also add explicit braces in select_local_address to avoid confusions
>     - move the declaration of 'remote' to reduce the scope and to do it o=
nly
>       when needed.
>     - add missing Mat' suggesting-by tag (sorry, I forgot that earlier)
>
>  net/mptcp/pm_netlink.c | 39 +++++++++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 12 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 9b1f6298bbdb..83976b9ee99b 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -60,15 +60,20 @@ static bool addresses_equal(const struct mptcp_addr_i=
nfo *a,
>  {
>         bool addr_equals =3D false;
>
> -       if (a->family !=3D b->family)
> -               return false;
> -
> -       if (a->family =3D=3D AF_INET)
> -               addr_equals =3D a->addr.s_addr =3D=3D b->addr.s_addr;
> +       if (a->family =3D=3D b->family) {
> +               if (a->family =3D=3D AF_INET)
> +                       addr_equals =3D a->addr.s_addr =3D=3D b->addr.s_a=
ddr;
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -       else
> -               addr_equals =3D !ipv6_addr_cmp(&a->addr6, &b->addr6);
> +               else
> +                       addr_equals =3D !ipv6_addr_cmp(&a->addr6, &b->add=
r6);
> +       } else if (a->family =3D=3D AF_INET) {
> +               if (ipv6_addr_v4mapped(&b->addr6))
> +                       addr_equals =3D a->addr.s_addr =3D=3D b->addr6.s6=
_addr32[3];
> +       } else if (b->family =3D=3D AF_INET) {
> +               if (ipv6_addr_v4mapped(&a->addr6))
> +                       addr_equals =3D a->addr6.s6_addr32[3] =3D=3D b->a=
ddr.s_addr;
>  #endif
> +       }
>
>         if (!addr_equals)
>                 return false;
> @@ -137,6 +142,7 @@ select_local_address(const struct pm_nl_pernet *perne=
t,
>                      struct mptcp_sock *msk)
>  {
>         struct mptcp_pm_addr_entry *entry, *ret =3D NULL;
> +       struct sock *sk =3D (struct sock *)msk;
>
>         rcu_read_lock();
>         __mptcp_flush_join_list(msk);
> @@ -144,11 +150,20 @@ select_local_address(const struct pm_nl_pernet *per=
net,
>                 if (!(entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
>                         continue;
>
> +               if (entry->addr.family !=3D sk->sk_family) {
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +                       if ((entry->addr.family =3D=3D AF_INET &&
> +                            !ipv6_addr_v4mapped(&sk->sk_v6_daddr)) ||
> +                           (sk->sk_family =3D=3D AF_INET &&
> +                            !ipv6_addr_v4mapped(&entry->addr.addr6)))
> +#endif
> +                               continue;
> +               }
> +
>                 /* avoid any address already in use by subflows and
>                  * pending join
>                  */
> -               if (entry->addr.family =3D=3D ((struct sock *)msk)->sk_fa=
mily &&
> -                   !lookup_subflow_by_saddr(&msk->conn_list, &entry->add=
r)) {
> +               if (!lookup_subflow_by_saddr(&msk->conn_list, &entry->add=
r)) {
>                         ret =3D entry;
>                         break;
>                 }
> @@ -310,7 +325,6 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
>

This patch looks good to me. But the following cleanup in
mptcp_pm_create_subflow_or_signal_addr is not related with ipv4mapped
address, could we split it into a new patch when merging this patchset?
Do you think it's necessary to do this?

Thanks.

-Geliang

>  static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *ms=
k)
>  {
> -       struct mptcp_addr_info remote =3D { 0 };
>         struct sock *sk =3D (struct sock *)msk;
>         struct mptcp_pm_addr_entry *local;
>         struct pm_nl_pernet *pernet;
> @@ -344,13 +358,14 @@ static void mptcp_pm_create_subflow_or_signal_addr(=
struct mptcp_sock *msk)
>         /* check if should create a new subflow */
>         if (msk->pm.local_addr_used < msk->pm.local_addr_max &&
>             msk->pm.subflows < msk->pm.subflows_max) {
> -               remote_address((struct sock_common *)sk, &remote);
> -
>                 local =3D select_local_address(pernet, msk);
>                 if (local) {
> +                       struct mptcp_addr_info remote =3D { 0 };
> +
>                         msk->pm.local_addr_used++;
>                         msk->pm.subflows++;
>                         check_work_pending(msk);
> +                       remote_address((struct sock_common *)sk, &remote);
>                         spin_unlock_bh(&msk->pm.lock);
>                         __mptcp_subflow_connect(sk, &local->addr, &remote=
);
>                         spin_lock_bh(&msk->pm.lock);
> --
> 2.29.2
>
--===============0239797449360937126==--
