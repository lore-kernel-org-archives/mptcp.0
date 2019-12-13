Content-Type: multipart/mixed; boundary="===============5790193999110529414=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 1/4] mptcp: add helper to forcefully fallback
 the msk socket to TCP
Date: Fri, 13 Dec 2019 16:27:29 +0100
Message-ID: <7aa700cb15b01c994fb4274d9659f6999ac1ae3b.camel@redhat.com>
In-Reply-To: 8599ff8e65531ddfa8d0cd110e89b2e82bd9368c.1576247361.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2943

--===============5790193999110529414==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-12-13 at 15:33 +0100, Paolo Abeni wrote:
> will be used in later patch
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>  net/mptcp/protocol.c | 42 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 39 insertions(+), 3 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index c15232461a61..b6d753ed8397 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -24,6 +24,38 @@
>  =

>  #define MPTCP_SAME_STATE TCP_MAX_STATES
>  =

> +static void __mptcp_close(struct sock *sk, long timeout);
> +
> +/* MP_CAPABLE handshake failed, convert msk to plain tcp, replacing
> + * socket->sk and stream ops and destroying msk
> + * return the msk socket, as we can't access msk anymore after this func=
tion
> + * completes
> + */
> +static struct socket *__mptcp_fallback_to_tcp(struct mptcp_sock *msk,
> +					      struct sock *ssk)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct socket *sock;
> +	struct sock *sk;
> +
> +	sk =3D (struct sock *)msk;
> +	sock =3D sk->sk_socket;
> +	subflow =3D mptcp_subflow_ctx(ssk);
> +
> +	/* detach the msk socket */
> +	list_del_init(&subflow->node);
> +	sock_orphan(sk);

Here we need an additional

	sock->sk =3D NULL;

to avoid a later WARN_ON(parent->sk); in sock_graft()

Cheers,

Paolo

--===============5790193999110529414==--
