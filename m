Content-Type: multipart/mixed; boundary="===============6615335410525915382=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 1/3] mptcp: fix compilation warning without IPV6
Date: Wed, 16 Oct 2019 18:17:38 +0200
Message-ID: <cf035507-04b4-d215-4d14-4393c26a94da@tessares.net>
In-Reply-To: 20191016161528.4336-2-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2185

--===============6615335410525915382==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 16/10/2019 18:15, Matthieu Baerts wrote:
>    net/mptcp/pm.c:228:23: warning: unused variable =E2=80=98addr6=E2=80=
=99 [-Wunused-variable]
>      228 |  struct sockaddr_in6 *addr6 =3D (struct sockaddr_in6 *)saddr;
>          |                       ^~~~~
> =

> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> ---
> =

> Notes:
>      To squash in "mptcp: Add path manager interface"
> =

>   net/mptcp/pm.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> =

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index b14308ad11a3..f521bf0c5f69 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -224,8 +224,10 @@ void mptcp_pm_add_addr6(struct mptcp_sock *msk, cons=
t struct in6_addr *addr,
>   int mptcp_pm_addr_signal(struct mptcp_sock *msk, u8 *id,
>   			 struct sockaddr_storage *saddr)
>   {
> -	struct sockaddr_in *addr =3D (struct sockaddr_in *)saddr;
> +#if IS_ENABLED(CONFIG_IPV6)
>   	struct sockaddr_in6 *addr6 =3D (struct sockaddr_in6 *)saddr;
> +#endif
> +	struct sockaddr_in *addr =3D (struct sockaddr_in *)saddr;

I forgot to say that I also fixed the "reversed Christmas tree" order.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6615335410525915382==--
