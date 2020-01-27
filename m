Content-Type: multipart/mixed; boundary="===============7389300326350007579=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 net-next 1/2] mptcp: protocol: fix panic on
 user pointer access
Date: Mon, 27 Jan 2020 15:26:00 +0100
Message-ID: <1a83de21-7bd7-4a05-30fe-52091efdc4a4@tessares.net>
In-Reply-To: 20200126234101.7256-2-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3522

--===============7389300326350007579==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 27/01/2020 00:41, Florian Westphal wrote:
> Its not possible to call the kernel_(s|g)etsockopt functions here,
> the address points to user memory:

I am sorry for this maybe stupid question but why can we not use these =

functions directly? Is it because of the "(g|s)et_fs()"?

[...]
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 39fdca79ce90..f8232e9f08e7 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -778,17 +778,23 @@ static void mptcp_destroy(struct sock *sk)
>   {
>   }
>   =

> +static int subflow_setsockopt(struct socket *sock, int level, int optnam=
e,
> +			       char __user *optval, unsigned int optlen)
> +{
> +	if (level =3D=3D SOL_SOCKET)

Can we arrive in this case with MPTCP? I guess not form the userspace' =

syscall but maybe from somewhere else in the kernel code?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7389300326350007579==--
