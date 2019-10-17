Content-Type: multipart/mixed; boundary="===============6888270702894592533=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: fix warnings reported by checkpatch
Date: Thu, 17 Oct 2019 15:26:58 +0200
Message-ID: <d8bd92945661a2d41195dc3249249a3eae445935.camel@redhat.com>
In-Reply-To: 20191010142745.6436-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2212

--===============6888270702894592533==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2019-10-10 at 16:27 +0200, Matthieu Baerts wrote:
> WARNING: line over 80 characters
> #233: FILE: net/mptcp/options.c:47:
> +                * negotiated, the receiver MUST close the subflow with a=
 RST as it is
> =

> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> ---
> =

> Notes:
>     to be squashed in "mptcp: Handle MPTCP TCP options"
> =

>  net/mptcp/options.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index cee4280647fe..adf65d3ff27b 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -44,8 +44,8 @@ void mptcp_parse_option(const unsigned char *ptr, int o=
psize,
>  		 *
>  		 * Section 3.3.0:
>  		 * "If a checksum is not present when its use has been
> -		 * negotiated, the receiver MUST close the subflow with a RST as it is
> -		 * considered broken."
> +		 * negotiated, the receiver MUST close the subflow with a RST as
> +		 * it is considered broken."
>  		 *
>  		 * We don't implement DSS checksum - fall back to TCP.
>  		 */

This one and the next 2 patches are IMHO uncontroversially good, but
the 4th is a bit against my personal taste - I would keep the
checkpatch offenders instead;). No objections on the 5th patch.

Cheers,

Paolo

--===============6888270702894592533==--
