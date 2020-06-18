Content-Type: multipart/mixed; boundary="===============1164884978952293516=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 1/4] Squash-to: "net: mptcp: improve fallback
 to TCP"
Date: Thu, 18 Jun 2020 14:01:56 -0700
Message-ID: <alpine.OSX.2.22.394.2006181400260.19717@adhawale-mobl.amr.corp.intel.com>
In-Reply-To: dab15370315ced25255947ec1ea3d9b62e3387b9.1592477699.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4734

--===============1164884978952293516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 18 Jun 2020, Paolo Abeni wrote:

> We need to take care of shutdown, too: drop the
> special fallback handling.
>
> Additionally invoke the state_change op on the
> relevant socket (the msk one).
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 12 +++---------
> 1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index faa804f63c81..2c15bf4cdb53 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1404,8 +1404,6 @@ static void mptcp_subflow_shutdown(struct sock *ssk=
, int how,
> 		break;
> 	}
>
> -	/* Wake up anyone sleeping in poll. */
> -	ssk->sk_state_change(ssk);
> 	release_sock(ssk);
> }
>
> @@ -2091,18 +2089,11 @@ static int mptcp_shutdown(struct socket *sock, in=
t how)
> {
> 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
> 	struct mptcp_subflow_context *subflow;
> -	struct socket *ssock;
> 	int ret =3D 0;
>
> 	pr_debug("sk=3D%p, how=3D%d", msk, how);
>
> 	lock_sock(sock->sk);
> -	ssock =3D __mptcp_tcp_fallback(msk);
> -	if (ssock) {
> -		release_sock(sock->sk);
> -		return inet_shutdown(ssock, how);
> -	}
> -
> 	if (how =3D=3D SHUT_WR || how =3D=3D SHUT_RDWR)
> 		inet_sk_state_store(sock->sk, TCP_FIN_WAIT1);
>
> @@ -2128,6 +2119,9 @@ static int mptcp_shutdown(struct socket *sock, int =
how)
> 		mptcp_subflow_shutdown(tcp_sk, how, 1, msk->write_seq);
> 	}
>
> +	/* Wake up anyone sleeping in poll. */
> +	sock->sk->sk_state_change(sock->sk);
> +

I had added this to mptcp_shutdown in my WIP too, so looks good to me!

> out_unlock:
> 	release_sock(sock->sk);
>
> -- =

> 2.26.2

--
Mat Martineau
Intel
--===============1164884978952293516==--
