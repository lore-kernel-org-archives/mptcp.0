Content-Type: multipart/mixed; boundary="===============3164181395753123444=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v4 2/3] mptcp: pm nl: support IPv4
 mapped in v6 addresses
Date: Mon, 21 Dec 2020 18:16:48 +0800
Message-ID: <CA+WQbwv2zbaVHv1gVPxbvRXOovJvfO_LNZKf6+8Sfa1w6XF6zQ@mail.gmail.com>
In-Reply-To: 20201219130700.1053584-3-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7230

--===============3164181395753123444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Thanks for your patches, and for your help.

Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2020=E5=B9=B412=
=E6=9C=8819=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=889:07=E5=86=99=E9=
=81=93=EF=BC=9A
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
> Co-developed-by: Geliang Tang <geliangtang(a)gmail.com>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> ---
>  net/mptcp/pm_netlink.c | 37 +++++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 12 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 9b1f6298bbdb..6ef00b3799d4 100644
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
> @@ -133,8 +138,8 @@ static bool lookup_subflow_by_saddr(const struct list=
_head *list,
>  }
>
>  static struct mptcp_pm_addr_entry *
> -select_local_address(const struct pm_nl_pernet *pernet,
> -                    struct mptcp_sock *msk)
> +select_local_address(const struct pm_nl_pernet *pernet, struct mptcp_soc=
k *msk,
> +                    struct mptcp_addr_info *remote)
>  {
>         struct mptcp_pm_addr_entry *entry, *ret =3D NULL;
>

I think we should avoid adding a new parameter here, we can call
remote_address again in this function to get the remote address.

> @@ -144,11 +149,19 @@ select_local_address(const struct pm_nl_pernet *per=
net,
>                 if (!(entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
>                         continue;
>
> +               if (entry->addr.family !=3D remote->family)

I think we should add a "{" here ...

> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +                       if ((entry->addr.family =3D=3D AF_INET &&
> +                            !ipv6_addr_v4mapped(&remote->addr6)) ||
> +                           (remote->family =3D=3D AF_INET &&
> +                            !ipv6_addr_v4mapped(&entry->addr.addr6)))
> +#endif
> +                               continue;

... and add a "}" here.


-Geliang

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
> @@ -346,7 +359,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(st=
ruct mptcp_sock *msk)
>             msk->pm.subflows < msk->pm.subflows_max) {
>                 remote_address((struct sock_common *)sk, &remote);
>
> -               local =3D select_local_address(pernet, msk);
> +               local =3D select_local_address(pernet, msk, &remote);
>                 if (local) {
>                         msk->pm.local_addr_used++;
>                         msk->pm.subflows++;
> --
> 2.29.2
>
--===============3164181395753123444==--
