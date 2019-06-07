Content-Type: multipart/mixed; boundary="===============8100113499917741546=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 6/7] mptcp: Check flags in MP_CAPABLE option
Date: Fri, 07 Jun 2019 13:24:41 +0200
Message-ID: <a03e6a76-64d0-0792-426e-25188ceeaa8b@tessares.net>
In-Reply-To: 20190606003632.2863-7-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1312

--===============8100113499917741546==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo,

On 06/06/2019 02:36, Peter Krystad wrote:
> squashto: Handle MPTCP TCP options

Thank you for the patch and the review!

- 5f1e8d8943f5: "squash" in "mptcp: Handle MPTCP TCP options". Note that
I had to modify the variables, please see below
- signed-off was already there
- 062cef9d7641: conflict
- 666387ce8fc1..2d097652ba6c: result


> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> ---
>  net/mptcp/options.c  | 6 +++++-
>  net/mptcp/protocol.h | 7 ++++---
>  2 files changed, 9 insertions(+), 4 deletions(-)
> =

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index df4405d268f0..98d582207cb0 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -29,8 +29,12 @@ void mptcp_parse_option(const unsigned char *ptr, int =
opsize,
>  		if (mp_opt->version !=3D 0)
>  			break;
>  =

> -		mp_opt->mp_capable =3D 1;
>  		mp_opt->flags =3D *ptr++;
> +		if (!((mp_opt->flags & MPTCP_CAP_FLAG_MASK) =3D=3D MPTCP_CAP_HMAC_SHA1=
) ||
> +		    (mp_opt->flags & MPTCP_CAP_EXTENSIBILITY))
> +			break;
> +
> +		mp_opt->mp_capable =3D 1;

I had to switch back to "opt_rx->mptcp" instead of "mp_opt" as I didn't
take your first patch of this series. When you will provide a v2 for
this patch 1/7, can you do a rebase first and do the opposite change to
use "mp_opt" please?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============8100113499917741546==--
