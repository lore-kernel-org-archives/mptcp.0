Content-Type: multipart/mixed; boundary="===============6332454660503088161=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 4/4] man: mptcp man page
Date: Wed, 22 Apr 2020 16:29:11 +0200
Message-ID: <8624a4e4-171e-54a1-9f92-7f176c4f8cfa@tessares.net>
In-Reply-To: 45b999f7934fbd75a2b27afcafa541f31d5aaa03.1587139599.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4225

--===============6332454660503088161==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

I think you missed some of my previous comments :)

I managed to get a review from an English native!

On 17/04/2020 18:08, Paolo Abeni wrote:
> describe the mptcp subcommands implemented so far.
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>   man/man8/ip-mptcp.8 | 142 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 142 insertions(+)
>   create mode 100644 man/man8/ip-mptcp.8
> =

> diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
> new file mode 100644
> index 00000000..5ed0457b
> --- /dev/null
> +++ b/man/man8/ip-mptcp.8
> @@ -0,0 +1,142 @@

(...)

> +.SH DESCRIPTION
> +
> +MPTCP is a transport protocol build on top of TCP that allows TCP

s/build/built/

> +connections to use multiple paths to maximize resource usage and increase
> +redundancy. The ip-mptcp sub-commands allow configuring several aspects =
of the
> +MPTCP path manager, which is in charge of subflows creation:
> +
> +.P
> +The
> +.B endpoint
> +object specifies the IP addresses that will be used and/or announced for
> +additional subflows:
> +
> +.TS
> +l l.
> +ip mptcp endpoint add	add new MPTCP endpoint
> +ip mptcp endpoint delete	delete existing MPTCP endpoint
> +ip mptcp endpoint show	get existing MPTCP endpoint
> +ip mptcp endpoint flush	flush all existing MPTCP endpoints
> +.TE
> +
> +.TP
> +.IR ID
> +is a unique numeric identifier for the given endpoint
> +
> +.TP
> +.BR signal
> +the endpoint will be announced/signaled to each peer via an ADD_ADDR MPT=
CP

s/signaled/signalled/

> +sub-option
> +
> +.TP
> +.BR subflow
> +If the MPTCP limits allow for additional subflows creation, the endpoint=
 will

s/subflows creation/subflow creations/

or: s/If the MPTCP limits allow for additional subflows creation/If =

additional subflow creation is allowed by MPTCP limits/

detail: s/If/if/

> +be used as the source address to create an additional subflow after that
> +the MPTCP connection is established.

s/after that the MPTCP connection is established/after the MPTCP =

connection has been established/

or: s/after that the MPTCP connection is established/after the =

establishment of the MPTCP connection/

> +
> +.TP
> +.BR backup
> +the endpoint will be announced as a backup address, if this is a
> +.BR signal
> +endpoint, or the subflow will be created as a backup one if this a

s/this a/this is a/

> +.BR subflow
> +endpoint

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6332454660503088161==--
