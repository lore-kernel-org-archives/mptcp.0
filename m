Content-Type: multipart/mixed; boundary="===============5251658394640683595=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/5] mptcp: Add missing ADD_ADDR handling
Date: Wed, 16 Oct 2019 17:20:25 +0200
Message-ID: <cd8bbd3b-031b-3dc8-3af0-ff244d356d43@tessares.net>
In-Reply-To: 20191015230613.16981-3-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2178

--===============5251658394640683595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 16/10/2019 01:06, Peter Krystad wrote:
> Add missing piece that copies IPv6 address into TCP option
> =

> squashto: Add ADD_ADDR handling
> =

> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> ---
>   net/mptcp/options.c | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)
> =

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 4bb3766fce5e..a63137b73557 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -463,14 +463,22 @@ static bool mptcp_established_options_addr(struct s=
ock *sk,
>   	if (mptcp_pm_addr_signal(msk, &id, &saddr))
>   		return false;
>   =

> -	if (saddr.ss_family =3D=3D AF_INET && remaining < TCPOLEN_MPTCP_ADD_ADD=
R)
> -		return false;
> -
> -	opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
> -	opts->addr_id =3D id;
> -	opts->addr.s_addr =3D ((struct sockaddr_in *)&saddr)->sin_addr.s_addr;
> -	*size =3D TCPOLEN_MPTCP_ADD_ADDR;
> -
> +	if (saddr.ss_family =3D=3D AF_INET) {
> +		if (remaining < TCPOLEN_MPTCP_ADD_ADDR)
> +			return false;
> +		opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
> +		opts->addr_id =3D id;
> +		opts->addr =3D ((struct sockaddr_in *)&saddr)->sin_addr;
> +		*size =3D TCPOLEN_MPTCP_ADD_ADDR;
> +	}
> +	if (saddr.ss_family =3D=3D AF_INET6) {

I hope you don't mind if I use a "else if" here when applying the patch.

> +		if (remaining < TCPOLEN_MPTCP_ADD_ADDR6)
> +			return false;
> +		opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR6;
> +		opts->addr_id =3D id;
> +		opts->addr6 =3D ((struct sockaddr_in6 *)&saddr)->sin6_addr;
> +		*size =3D TCPOLEN_MPTCP_ADD_ADDR6;
> +	}

and if I add a new line here like before.

>   	msk->addr_signal =3D 0;
>   =

>   	return true;

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5251658394640683595==--
