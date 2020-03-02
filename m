Content-Type: multipart/mixed; boundary="===============8590026439191119245=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/2] mptcp: fix compilation warning without IPv6
Date: Mon, 02 Mar 2020 14:46:54 +0100
Message-ID: <00593c18bb000ea6cf0fd9a4b7b7611b9187079b.camel@redhat.com>
In-Reply-To: 20200302090911.1442823-2-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3839

--===============8590026439191119245==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-03-02 at 10:09 +0100, Matthieu Baerts wrote:
> net/mptcp/pm_netlink.c: In function =E2=80=98mptcp_pm_nl_append_new_local=
_addr=E2=80=99:
> net/mptcp/pm_netlink.c:58:5: warning: =E2=80=98addr_equals=E2=80=99 may b=
e used uninitialized in this function [-Wmaybe-uninitialized]
>    58 |  if (!addr_equals)
>       |     ^
> net/mptcp/pm_netlink.c:46:7: note: =E2=80=98addr_equals=E2=80=99 was decl=
ared here
>    46 |  bool addr_equals;
>       |       ^~~~~~~~~~~
> =

> Fixes: c3a214585944 (mptcp: add netlink based PM)
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> ---
> =

> Notes:
>     to be squashed in "mptcp: add netlink based PM"
> =

>  net/mptcp/pm_netlink.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> =

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 0887fae982fc..c430ab37910a 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -50,9 +50,11 @@ static bool addresses_equal(const struct mptcp_addr_in=
fo *a,
>  =

>  	if (a->family =3D=3D AF_INET)
>  		addr_equals =3D a->addr.s_addr =3D=3D b->addr.s_addr;
> -#if IS_ENABLED(CONFIG_MPTCP_IPV6)
>  	else
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
>  		addr_equals =3D !ipv6_addr_cmp(&a->addr6, &b->addr6);
> +#else
> +		addr_equals =3D false;
>  #endif

If we init 'addr_equals' to 'false' we can avoid the #else branch here.

(Thanks for fixing by mistakes!)

/P

--===============8590026439191119245==--
