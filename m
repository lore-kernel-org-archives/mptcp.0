Content-Type: multipart/mixed; boundary="===============4257420118401783086=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][RFC mptcp-next 2/6] mptcp: add echo field in
 mptcp_out_options
Date: Fri, 29 Jan 2021 16:43:23 +0100
Message-ID: <8d7345486a031da4dc746710831b83e6502a8ea4.camel@redhat.com>
In-Reply-To: 2ae1ee585b508fe596788a747dfac676127afa4c.1611667027.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7533

--===============4257420118401783086==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2021-01-26 at 21:21 +0800, Geliang Tang wrote:
> This patch added a new field echo in mptcp_out_options, it will be used
> when using the trace event to dump the mptcp_out_options info.
> =

> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  include/net/mptcp.h | 1 +
>  net/mptcp/options.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> =

> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 5694370be3d4..85b39d901150 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -46,6 +46,7 @@ struct mptcp_out_options {
>  #endif
>  	};
>  	u8 addr_id;
> +	u8 echo;
>  	u16 port;
>  	u64 ahmac;
>  	u8 rm_id;

This data structure is quite critical for performances, we should avoid
adding more fields there (note: there is a pending ticket to shrink it
using union).

I suggest avoiding touching this at all for tracepoint's sake

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 331d460d82fa..465144afade8 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -634,6 +634,7 @@ static bool mptcp_established_options_add_addr(struct=
 sock *sk, struct sk_buff *
>  	if (drop_other_suboptions)
>  		*size -=3D opt_size;
>  	opts->addr_id =3D saddr.id;
> +	opts->echo =3D echo;
>  	if (port)
>  		opts->port =3D ntohs(saddr.port);
>  	if (saddr.family =3D=3D AF_INET) {
> @@ -659,7 +660,7 @@ static bool mptcp_established_options_add_addr(struct=
 sock *sk, struct sk_buff *
>  	}
>  #endif
>  	pr_debug("addr_id=3D%d, ahmac=3D%llu, echo=3D%d, port=3D%d",
> -		 opts->addr_id, opts->ahmac, echo, opts->port);
> +		 opts->addr_id, opts->ahmac, opts->echo, opts->port);
>  =

>  	return true;
>  }

--===============4257420118401783086==--
