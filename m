Content-Type: multipart/mixed; boundary="===============6645356188216557465=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: Re-factor mptcp_create_subflow()
Date: Tue, 25 Jun 2019 14:54:54 +0200
Message-ID: <e3c6c48a-27f2-5fb3-df48-725ac2dd69f3@tessares.net>
In-Reply-To: 20190624230636.3513-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1445

--===============6645356188216557465==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 25/06/2019 01:06, Peter Krystad wrote:
> Move to subflow.c (because it belongs there) and rename.
> Outgoing MP_JOIN requests will use this routine to create
> subflow sockets.
> =

> squashto: Associate MPTCP context with TCP socket
> =

> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> ---
>  net/mptcp/protocol.c | 33 +++------------------------------
>  net/mptcp/protocol.h |  1 +
>  net/mptcp/subflow.c  | 25 +++++++++++++++++++++++++
>  3 files changed, 29 insertions(+), 30 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 775510bdbd4c..f2909457ef31 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -817,33 +817,6 @@ static struct proto mptcp_prot =3D {
>  	.no_autobind	=3D 1,
>  };
>  =

> -static int mptcp_subflow_create(struct sock *sk)
> -{
> -	struct mptcp_sock *msk =3D mptcp_sk(sk);
> -	struct net *net =3D sock_net(sk);
> -	struct socket *sf;
> -	int err;
> -
> -	pr_debug("msk=3D%p", msk);
> -	err =3D sock_create_kern(net, PF_INET, SOCK_STREAM, IPPROTO_TCP, &sf);
> -	if (!err) {
> -		lock_sock(sf->sk);
> -		err =3D tcp_set_ulp(sf->sk, "mptcp");
> -		release_sock(sf->sk);
> -		if (!err) {
> -			struct subflow_context *subflow =3D subflow_ctx(sf->sk);
> -
> -			pr_debug("subflow=3D%p", subflow);
> -			msk->subflow =3D sf;
> -			subflow->conn =3D sk;
> -			subflow->request_mptcp =3D 1; // @@ if MPTCP enabled
> -			subflow->request_cksum =3D 1; // @@ if checksum enabled
> -			subflow->version =3D 0;
> -		}
> -	}
> -	return err;
> -}
> -
>  static int mptcp_bind(struct socket *sock, struct sockaddr *uaddr, int a=
ddr_len)
>  {
>  	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
> @@ -855,7 +828,7 @@ static int mptcp_bind(struct socket *sock, struct soc=
kaddr *uaddr, int addr_len)
>  		return err;
>  =

>  	if (!msk->subflow) {
> -		err =3D mptcp_subflow_create(sock->sk);
> +		err =3D subflow_create_socket(sock->sk, &msk->subflow);
>  		if (err)
>  			return err;
>  	}
> @@ -874,7 +847,7 @@ static int mptcp_stream_connect(struct socket *sock, =
struct sockaddr *uaddr,
>  		return err;
>  =

>  	if (!msk->subflow) {
> -		err =3D mptcp_subflow_create(sock->sk);
> +		err =3D subflow_create_socket(sock->sk, &msk->subflow);
>  		if (err)
>  			return err;
>  	}
> @@ -933,7 +906,7 @@ static int mptcp_listen(struct socket *sock, int back=
log)
>  	pr_debug("msk=3D%p", msk);
>  =

>  	if (!msk->subflow) {
> -		err =3D mptcp_subflow_create(sock->sk);
> +		err =3D subflow_create_socket(sock->sk, &msk->subflow);
>  		if (err)
>  			return err;
>  	}
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index ffc2452b4e77..e081b48d3f0d 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -201,6 +201,7 @@ mptcp_subflow_tcp_socket(const struct subflow_context=
 *subflow)
>  }
>  =

>  void subflow_init(void);
> +int subflow_create_socket(struct sock *sk, struct socket **new_sock);
>  =

>  extern const struct inet_connection_sock_af_ops ipv4_specific;
>  =

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index a858cc966724..1236739425bc 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -201,6 +201,31 @@ static void subflow_data_ready(struct sock *sk)
>  	}
>  }
>  =

> +int subflow_create_socket(struct sock *sk, struct socket **new_sock)
> +{
> +	struct net *net =3D sock_net(sk);
> +	struct socket *sf;
> +	int err;
> +
> +	err =3D sock_create_kern(net, PF_INET, SOCK_STREAM, IPPROTO_TCP, &sf);
> +	if (!err) {
> +		lock_sock(sf->sk);
> +		err =3D tcp_set_ulp(sf->sk, "mptcp");
> +		release_sock(sf->sk);
> +		if (!err) {
> +			struct subflow_context *subflow =3D subflow_ctx(sf->sk);
> +
> +			pr_debug("subflow=3D%p", subflow);
> +			*new_sock =3D sf;
> +			subflow->conn =3D sk;
> +			subflow->request_mptcp =3D 1; // @@ if MPTCP enabled
> +			subflow->request_cksum =3D 1; // @@ if checksum enabled
> +			subflow->version =3D 0;
> +		}
> +	}

When applying this, I remember what Paolo recently said: upstream
prefers keeping the expected/main code path with no indentation.

I hope you don't mind if I slightly change this when applying the patch.
We would then have:

    err =3D sock_create_kern(net, PF_INET, SOCK_STREAM, IPPROTO_TCP, &sf);
    if (err)
        return err;

   lock_sock(sf->sk);
   (...)

Cheers,
Matt

> +	return err;
> +}
> +
>  static struct subflow_context *subflow_create_ctx(struct sock *sk,
>  						  struct socket *sock,
>  						  gfp_t priority)
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============6645356188216557465==--
