Content-Type: multipart/mixed; boundary="===============2306135851386787303=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "mptcp: cope with later TCP fallback"
Date: Mon, 16 Dec 2019 14:24:03 +0100
Message-ID: <a4d92e0b-85fa-53e0-46c7-37ca10b6a0b9@tessares.net>
In-Reply-To: 91571e18e2a8945349d6d84fdc5324a8e76f8637.1576498821.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3079

--===============2306135851386787303==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 16/12/2019 13:22, Paolo Abeni wrote:
> Clean subflow->conn, under the ssk socket lock, and make
> __mptcp_tcp_fallback() less unreadable
> ---
> This should address Mat's concern on the fallback code path

Thank you for looking at that!

The code looks good to me. Should we maybe fix typos in comments? :)

> ---
>   net/mptcp/protocol.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2b20f4d3e179..9e288559e228 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -49,7 +49,17 @@ static struct socket *__mptcp_fallback_to_tcp(struct m=
ptcp_sock *msk,
>   	sock->sk =3D NULL;
>   =

>   	/* socket is now TCP */
> +	lock_sock(ssk);
>   	sock_graft(ssk, sock);
> +	if (subflow->conn) {
> +		/* Clearing the 'conn' field will make the ULP-ovverriden

detail: s/ovverriden/overridden/

> +		 * oops behaving alike plain TCP ones.

detail: s/oops/ops/

and: s/alike/like/

> +		 * Note: we can't release the ULP data on a live socket.
> +		 */
> +		sock_put(subflow->conn);
> +		subflow->conn =3D NULL;
> +	}
> +	release_sock(ssk);
>   	sock->ops =3D sk->sk_family =3D=3D AF_INET6 ? &inet6_stream_ops :
>   						&inet_stream_ops;
>   =

> @@ -76,8 +86,8 @@ static bool __mptcp_needs_tcp_fallback(const struct mpt=
cp_sock *msk)
>   	return msk->first && !tcp_sk(msk->first)->is_mptcp;
>   }
>   =

> -/* if the mp_capable handshake is failed, return a tcp socket
> - * return it.
> +/* if the mp_capable handshake is failed, fallback msk to plain tcp,

detail: s/is/has/

> + * release the socket lock and returns a reference to the now TCP socket

detail: s/returns/return/ (or add 'it' after the coma and 's' at the end =

of 'fallback' and 'release')

and maybe: s/now/current/

>    * Otherwise returns NULL

(same here: s/returns/return/ )

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2306135851386787303==--
