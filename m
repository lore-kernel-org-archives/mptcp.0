Content-Type: multipart/mixed; boundary="===============4187596052423975519=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/3] mptcp: fix compilation error without IPV6
Date: Thu, 17 Oct 2019 16:18:02 +0200
Message-ID: <58ec006aee870b478003a6c331fbcf561070dd70.camel@redhat.com>
In-Reply-To: 20191016161528.4336-3-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2230

--===============4187596052423975519==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-10-16 at 18:15 +0200, Matthieu Baerts wrote:
>   net/mptcp/options.c: In function =E2=80=98mptcp_established_options_add=
r=E2=80=99:
>   net/mptcp/options.c:478:9: error: =E2=80=98struct mptcp_out_options=E2=
=80=99 has no member named =E2=80=98addr6=E2=80=99; did you mean =E2=80=98a=
ddr=E2=80=99?
>     478 |   opts->addr6 =3D ((struct sockaddr_in6 *)&saddr)->sin6_addr;
>         |         ^~~~~
>         |         addr
> =

> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> ---
> =

> Notes:
>     To squash in "mptcp: Add ADD_ADDR handling"
> =

>  net/mptcp/options.c | 2 ++
>  1 file changed, 2 insertions(+)
> =

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index c948951509e1..6cfcf2ce44fe 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -470,6 +470,7 @@ static bool mptcp_established_options_addr(struct soc=
k *sk,
>  		opts->addr_id =3D id;
>  		opts->addr =3D ((struct sockaddr_in *)&saddr)->sin_addr;
>  		*size =3D TCPOLEN_MPTCP_ADD_ADDR;
> +#if IS_ENABLED(CONFIG_IPV6)
>  	} else if (saddr.ss_family =3D=3D AF_INET6) {
>  		if (remaining < TCPOLEN_MPTCP_ADD_ADDR6)
>  			return false;
> @@ -477,6 +478,7 @@ static bool mptcp_established_options_addr(struct soc=
k *sk,
>  		opts->addr_id =3D id;
>  		opts->addr6 =3D ((struct sockaddr_in6 *)&saddr)->sin6_addr;
>  		*size =3D TCPOLEN_MPTCP_ADD_ADDR6;
> +#endif

I think that the preferred codying style here is something alike:

		// ipv4 branch
	} =

#if IS_ENABLED(CONFIG_IPV6)
	else if (/* ... */) {
		// ...
	}
#endif

yep, without the preprocess conditional that would be against the
codying rules, but looks like checkpatch would be happy here.

The rationale is that is more clear in both the patch and the resulting
code what is protected by the conditional.

/P

--===============4187596052423975519==--
