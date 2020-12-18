Content-Type: multipart/mixed; boundary="===============6348968637296678681=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 1/2] mptcp: convert IPv4
 address to IPv4-mapped
Date: Fri, 18 Dec 2020 19:27:18 +0800
Message-ID: <20201218112718.GA11566@MiBook>
In-Reply-To: d3cbdcc0-4471-7a4d-1b1e-d69be80d231c@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7216

--===============6348968637296678681==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Fri, Dec 18, 2020 at 12:06:51AM +0100, Matthieu Baerts wrote:
> Hi Geliang, Mat,
> =

> On 17/12/2020 01:23, Mat Martineau wrote:
> > On Wed, 16 Dec 2020, Geliang Tang wrote:
> > =

> > > Currently, PM doesn't create subflow with IPv4-mapped IPv6 socket. Th=
is
> > > patch converts the IPv4 address to IPv4-mapped IPv6 address to fix it.
> > > =

> > > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > > ---
> > > net/mptcp/pm_netlink.c | 25 ++++++++++++++++++++++---
> > > 1 file changed, 22 insertions(+), 3 deletions(-)
> > > =

> > > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > > index cc4ca013a06b..987e83cdee11 100644
> > > --- a/net/mptcp/pm_netlink.c
> > > +++ b/net/mptcp/pm_netlink.c
> > > @@ -145,6 +158,8 @@ select_local_address(const struct pm_nl_pernet
> > > *pernet,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(entry->addr.flags & =
MPTCP_PM_ADDR_FLAG_SUBFLOW))
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
ntinue;
> > > =

> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_pm_addr_convert_v4m=
apped(msk, &entry->addr);
> > > +
> > =

> > This is modifying the contents of pernet->local_addr_list, not a copy of
> > the entry, when the msk has a v4mapped address. I'm not sure that's the
> > way to fix this, and might leave some corner cases unaddressed.
> > =

> > Did you look at modifying addresses_equal() so it can detect equivalent
> > IPv4 and v4mapped addresses?
> =

> Maybe something like that the patch I joined?
> =

> I didn't try much but maybe more what we want?

Thanks for your help. Your patch is much better than mine. I added your
code in v3 with only a slightly change in addresses_equal. I added your
Co-developed-by tag in v3 if you don't mind:

@@ -66,12 +66,11 @@ static bool addresses_equal(const struct mptcp_addr_inf=
o *a,
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
                else
                        addr_equals =3D !ipv6_addr_cmp(&a->addr6, &b->addr6=
);
-       } else if (a->family =3D=3D AF_INET6) {
-               if (b->family =3D=3D AF_INET && ipv6_addr_v4mapped(&a->addr=
6))
-                       addr_equals =3D a->addr6.s6_addr32[3] =3D=3D b->add=
r.s_addr;
-       } else if (b->family =3D=3D AF_INET6) {
+       } else {
                if (a->family =3D=3D AF_INET && ipv6_addr_v4mapped(&b->addr=
6))
                        addr_equals =3D a->addr.s_addr =3D=3D b->addr6.s6_a=
ddr32[3];
+               if (b->family =3D=3D AF_INET && ipv6_addr_v4mapped(&a->addr=
6))
+                       addr_equals =3D a->addr6.s6_addr32[3] =3D=3D b->add=
r.s_addr;
 #endif
        }

And I added the following code in mptcp_info2sockaddr to deal with the
IPv4-mapped back to IPv4 case too:

--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1082,7 +1082,10 @@ static void mptcp_info2sockaddr(const struct mptcp_a=
ddr_info *info,
        if (addr->ss_family =3D=3D AF_INET) {
                struct sockaddr_in *in_addr =3D (struct sockaddr_in *)addr;

-               in_addr->sin_addr =3D info->addr;
+               if (info->family =3D=3D AF_INET)
+                       in_addr->sin_addr =3D info->addr;
+               else
+                       in_addr->sin_addr.s_addr =3D info->addr6.s6_addr32[=
3];
                in_addr->sin_port =3D info->port;
        }
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)

Also in v3 I added two new IPv4-mapped back to IPv4 testcases:

+# signal subflow v6-map-v4
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl add "::ffff:10.0.3.2" flags subflow
+run_tests $ns1 $ns2 10.0.1.1
+chk_join_nr "single subflow v6-map-v4" 1 1 1
+
+# signal address v6-map-v4
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+ip netns exec $ns1 ./pm_nl_ctl add "::ffff:10.0.2.1" flags signal
+run_tests $ns1 $ns2 10.0.1.1
+chk_join_nr "signal address v6-map-v4" 1 1 1
+chk_add_nr 1 1

Thanks.

-Geliang

> =

> Cheers,
> Matt
> -- =

> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net

> >From 36f5e1f9bade5329e82a85fb6330db57a165c04c Mon Sep 17 00:00:00 2001
> From: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Date: Fri, 18 Dec 2020 00:03:12 +0100
> Subject: [PATCH] mptcp: support v4mappedv6
> =

> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> ---
>  net/mptcp/pm_netlink.c | 22 +++++++++++++---------
>  net/mptcp/subflow.c    | 17 +++++++++++------
>  2 files changed, 24 insertions(+), 15 deletions(-)
> =

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 9b1f6298bbdb..6c89a9e0099b 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -60,15 +60,20 @@ static bool addresses_equal(const struct mptcp_addr_i=
nfo *a,
>  {
>  	bool addr_equals =3D false;
>  =

> -	if (a->family !=3D b->family)
> -		return false;
> -
> -	if (a->family =3D=3D AF_INET)
> -		addr_equals =3D a->addr.s_addr =3D=3D b->addr.s_addr;
> +	if (a->family =3D=3D b->family) {
> +		if (a->family =3D=3D AF_INET)
> +			addr_equals =3D a->addr.s_addr =3D=3D b->addr.s_addr;
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -	else
> -		addr_equals =3D !ipv6_addr_cmp(&a->addr6, &b->addr6);
> +		else
> +			addr_equals =3D !ipv6_addr_cmp(&a->addr6, &b->addr6);
> +	} else if (a->family =3D=3D AF_INET6) {
> +		if (b->family =3D=3D AF_INET && ipv6_addr_v4mapped(&a->addr6))
> +			addr_equals =3D a->addr6.s6_addr32[3] =3D=3D b->addr.s_addr;
> +	} else if (b->family =3D=3D AF_INET6) {
> +		if (a->family =3D=3D AF_INET && ipv6_addr_v4mapped(&b->addr6))
> +			addr_equals =3D a->addr.s_addr =3D=3D b->addr6.s6_addr32[3];
>  #endif
> +	}
>  =

>  	if (!addr_equals)
>  		return false;
> @@ -147,8 +152,7 @@ select_local_address(const struct pm_nl_pernet *perne=
t,
>  		/* avoid any address already in use by subflows and
>  		 * pending join
>  		 */
> -		if (entry->addr.family =3D=3D ((struct sock *)msk)->sk_family &&
> -		    !lookup_subflow_by_saddr(&msk->conn_list, &entry->addr)) {
> +		if (!lookup_subflow_by_saddr(&msk->conn_list, &entry->addr)) {
>  			ret =3D entry;
>  			break;
>  		}
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 278cbe3e539e..11cc0ef3ae3c 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1074,10 +1074,11 @@ void mptcpv6_handle_mapped(struct sock *sk, bool =
mapped)
>  #endif
>  =

>  static void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
> -				struct sockaddr_storage *addr)
> +				struct sockaddr_storage *addr,
> +				unsigned short family)
>  {
>  	memset(addr, 0, sizeof(*addr));
> -	addr->ss_family =3D info->family;
> +	addr->ss_family =3D family;
>  	if (addr->ss_family =3D=3D AF_INET) {
>  		struct sockaddr_in *in_addr =3D (struct sockaddr_in *)addr;
>  =

> @@ -1088,7 +1089,11 @@ static void mptcp_info2sockaddr(const struct mptcp=
_addr_info *info,
>  	else if (addr->ss_family =3D=3D AF_INET6) {
>  		struct sockaddr_in6 *in6_addr =3D (struct sockaddr_in6 *)addr;
>  =

> -		in6_addr->sin6_addr =3D info->addr6;
> +		if (info->family =3D=3D AF_INET)
> +			ipv6_addr_set_v4mapped(info->addr.s_addr,
> +					       &in6_addr->sin6_addr);
> +		else
> +			in6_addr->sin6_addr =3D info->addr6;
>  		in6_addr->sin6_port =3D info->port;
>  	}
>  #endif
> @@ -1132,11 +1137,11 @@ int __mptcp_subflow_connect(struct sock *sk, cons=
t struct mptcp_addr_info *loc,
>  	subflow->remote_key =3D msk->remote_key;
>  	subflow->local_key =3D msk->local_key;
>  	subflow->token =3D msk->token;
> -	mptcp_info2sockaddr(loc, &addr);
> +	mptcp_info2sockaddr(loc, &addr, ssk->sk_family);
>  =

>  	addrlen =3D sizeof(struct sockaddr_in);
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -	if (loc->family =3D=3D AF_INET6)
> +	if (addr.ss_family =3D=3D AF_INET6)
>  		addrlen =3D sizeof(struct sockaddr_in6);
>  #endif
>  	ssk->sk_bound_dev_if =3D loc->ifindex;
> @@ -1152,7 +1157,7 @@ int __mptcp_subflow_connect(struct sock *sk, const =
struct mptcp_addr_info *loc,
>  	subflow->remote_id =3D remote_id;
>  	subflow->request_join =3D 1;
>  	subflow->request_bkup =3D !!(loc->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
> -	mptcp_info2sockaddr(remote, &addr);
> +	mptcp_info2sockaddr(remote, &addr, ssk->sk_family);
>  =

>  	mptcp_add_pending_subflow(msk, subflow);
>  	err =3D kernel_connect(sf, (struct sockaddr *)&addr, addrlen, O_NONBLOC=
K);
> -- =

> 2.29.2
>=20

--===============6348968637296678681==--
