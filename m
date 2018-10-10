Content-Type: multipart/mixed; boundary="===============4475908752958069733=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH v3 10/16] mptcp: Add shutdown() socket
 operation
Date: Wed, 10 Oct 2018 14:43:54 +0200
Message-ID: <dab89dd1-671b-32f5-c2fd-0127d9b2d16e@tessares.net>
In-Reply-To: 20181005225918.9786-11-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 810

--===============4475908752958069733==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 06/10/2018 00:59, Mat Martineau wrote:
> From: Peter Krystad <peter.krystad(a)intel.com>
> =

> Signed-off-by: Peter Krystad <peter.krystad(a)intel.com>
> ---
>  net/mptcp/protocol.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2fa9031a77ca..3d10ab287bd6 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -255,6 +255,25 @@ int mptcp_stream_accept(struct socket *sock, struct =
socket *newsock, int flags,
>  	return inet_accept(sock, newsock, flags, kern);
>  }
>  =

> +int mptcp_stream_shutdown(struct socket *sock, int how)
> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
> +	int ret =3D 0;
> +
> +	pr_debug("sk=3D%p, how=3D%d", msk, how);
> +
> +	if (msk->subflow) {
> +		pr_debug("subflow=3D%p", msk->subflow->sk);
> +		ret =3D kernel_sock_shutdown(msk->subflow, how);
> +	}
> +	if (msk->connection_list) {
> +		pr_debug("conn_list->subflow=3D%p", msk->connection_list->sk);
> +		ret =3D kernel_sock_shutdown(msk->connection_list, how);

Just to be sure, can we have "subflow !=3D NULL" and "connection_list !=3D
NULL"?
Because I saw the possible override of "ret" here but it is not possible
to have both a "subflow" and a "connection_list" (we could use a "else
if" here I guess).

Cheers,
Matthieu

> +	}
> +
> +	return ret;
> +}
> +
>  static struct proto mptcp_prot =3D {
>  	.name		=3D "MPTCP",
>  	.owner		=3D THIS_MODULE,
> @@ -284,7 +303,7 @@ const struct proto_ops mptcp_stream_ops =3D {
>  	.poll		   =3D tcp_poll,
>  	.ioctl		   =3D inet_ioctl,
>  	.listen		   =3D mptcp_stream_listen,
> -	.shutdown	   =3D inet_shutdown,
> +	.shutdown	   =3D mptcp_stream_shutdown,
>  	.setsockopt	   =3D sock_common_setsockopt,
>  	.getsockopt	   =3D sock_common_getsockopt,
>  	.sendmsg	   =3D inet_sendmsg,
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============4475908752958069733==--
