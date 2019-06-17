Content-Type: multipart/mixed; boundary="===============1505917510248390495=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v3] mptcp: proto_ops cannot be const
Date: Mon, 17 Jun 2019 15:32:00 +0200
Message-ID: <eedd293d-c30f-2dad-6626-ba10c33749aa@tessares.net>
In-Reply-To: 20190617130224.21141-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1414

--===============1505917510248390495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On 17/06/2019 15:02, Matthieu Baerts wrote:
> This partially reverts 2cb651944bde (mptcp: fix checkpatch issues).
> =

> The proto_ops cannot be const as recommended by checkpatch because we
> start from inet_stream_ops and we modify only what we need to modify.
> =

> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> ---
>  net/mptcp/protocol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f3bb7646ac07..ce2374ea7871 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -158,7 +158,7 @@ static int mptcp_stream_connect(struct socket *sock, =
struct sockaddr *uaddr,
>  	return inet_stream_connect(msk->subflow, uaddr, addr_len, flags);
>  }
>  =

> -static const struct proto_ops mptcp_stream_ops;
> +static struct proto_ops mptcp_stream_ops;
>  =

>  static struct inet_protosw mptcp_protosw =3D {
>  	.type		=3D SOCK_STREAM,
> =


I had to apply this patch after having applied all the other ones

- 98bdade702b1: "squashed" in "mptcp: Associate MPTCP context with TCP
socket"
- de4dbb2c0a8e: conflict in t/mptcp-add-mptcp_poll
- 1c436e0370c2: conflict in t/mptcp-Add-shutdown-socket-operation
- a083a2836977..8ea5282ba8cf: result

Cheers,
Matt

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============1505917510248390495==--
