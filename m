Content-Type: multipart/mixed; boundary="===============4845137993420847586=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] Squash-to: "mptcp: cope with later TCP
 fallback"
Date: Mon, 16 Dec 2019 14:49:56 -0800
Message-ID: <alpine.OSX.2.21.1912161444010.6806@mjmartin-mac01.local>
In-Reply-To: 23d83c427a276680e731ec50541e7599ecc80b9a.1576518799.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3095

--===============4845137993420847586==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Dec 2019, Paolo Abeni wrote:

> Clean subflow->conn, under the ssk socket lock, and make
> __mptcp_tcp_fallback() less unreadable.
>
> v1 -> v2:
> - fix more typos (Matt)
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 14 ++++++++++++--
> 1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2b20f4d3e179..5ebc34750da4 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -49,7 +49,17 @@ static struct socket *__mptcp_fallback_to_tcp(struct m=
ptcp_sock *msk,
> 	sock->sk =3D NULL;
>
> 	/* socket is now TCP */
> +	lock_sock(ssk);
> 	sock_graft(ssk, sock);
> +	if (subflow->conn) {
> +		/* Clearing the 'conn' field will make the ULP-overriden
> +		 * ops behaving like plain TCP ones.
> +		 * Note: we can't release the ULP data on a live socket.
> +		 */
> +		sock_put(subflow->conn);
> +		subflow->conn =3D NULL;
> +	}
> +	release_sock(ssk);

I looked through all of the callbacks that subflow_ulp_init() modifies for =

a subflow struct sock, and everything I looked at reverted to regular TCP =

behavior if subflow->conn is NULL. So I *think* it's ok - still trying to =

keep an eye open for corner cases.


Mat


> 	sock->ops =3D sk->sk_family =3D=3D AF_INET6 ? &inet6_stream_ops :
> 						&inet_stream_ops;
>
> @@ -76,8 +86,8 @@ static bool __mptcp_needs_tcp_fallback(const struct mpt=
cp_sock *msk)
> 	return msk->first && !tcp_sk(msk->first)->is_mptcp;
> }
>
> -/* if the mp_capable handshake is failed, return a tcp socket
> - * return it.
> +/* if the mp_capable handshake has failed, it fallbacks msk to plain TCP,
> + * releases the socket lock and returns a reference to the now TCP socke=
t.
>  * Otherwise returns NULL
>  */
> static struct socket *__mptcp_tcp_fallback(struct mptcp_sock *msk)
> -- =

> 2.21.0

--
Mat Martineau
Intel
--===============4845137993420847586==--
