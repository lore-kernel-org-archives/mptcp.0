Content-Type: multipart/mixed; boundary="===============4292651286649917026=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: add port
 number announced check"
Date: Wed, 25 Nov 2020 10:09:21 +0100
Message-ID: <27ecc5a31ad8e90da92f896952626bee80be3e47.camel@redhat.com>
In-Reply-To: c2933d16461c96e6389b7b16f2eb8c48ebf6ce93.1606281979.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6919

--===============4292651286649917026==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-11-25 at 13:28 +0800, Geliang Tang wrote:
> Use a more strict check in mptcp_pm_sport_in_anno_list.
> =

> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  net/mptcp/pm_netlink.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> =

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 09e96007a56a..da8d2c77a02d 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -111,6 +111,19 @@ static void remote_address(const struct sock_common =
*skc,
>  #endif
>  }
>  =

> +static void source_address(const struct sock *sk,
> +			   struct mptcp_addr_info *addr)
> +{
> +	addr->family =3D ((struct sock_common *)sk)->skc_family;

If sk can be a request_sock, and thus we are forced to access the 5-
tuple fields via sock_common, it's better to specify a sock_common
argument...

> +	addr->port =3D inet_sk(sk)->inet_sport;

... and this access will be invalid if 'sk' is a request_socket, you
should use skc_num instead (which is in host byte order).

> +	if (addr->family =3D=3D AF_INET)
> +		addr->addr.s_addr =3D inet_sk(sk)->inet_saddr;

Same here, you should use 'skc_rcv_saddr'

> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	else if (addr->family =3D=3D AF_INET6)
> +		addr->addr6 =3D inet_sk(sk)->pinet6->saddr;

Same here, you should use 'skc_v6_rcv_saddr'

Cheers,

Paolo

--===============4292651286649917026==--
