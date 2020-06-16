Content-Type: multipart/mixed; boundary="===============4786999356324780942=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v2 1/3] net: use mptcp setsockopt
 function for SOL_SOCKET on mptcp sockets
Date: Tue, 16 Jun 2020 13:50:38 -0700
Message-ID: <alpine.OSX.2.22.394.2006161319130.21710@ajaladi-mobl.amr.corp.intel.com>
In-Reply-To: 20200616122531.2443-2-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4711

--===============4786999356324780942==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 16 Jun 2020, Florian Westphal wrote:

> setsockopt(mptcp_fd, SOL_SOCKET, ...)...  appears to work (returns 0),
> but it has no effect -- this is because the MPTCP layer never has a
> chance to copy the settings to the subflow socket.
>
> Skip the generic handling for the mptcp case and return -EOPNOTSUPP.
> Next patch adds handling for SOL_SOCKET to mptcp.
>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> net/mptcp/protocol.c |  3 +++
> net/socket.c         | 12 +++++++++++-
> 2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index faa804f63c81..f9429c6f5b96 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1636,6 +1636,9 @@ static int mptcp_setsockopt(struct sock *sk, int le=
vel, int optname,
>
> 	pr_debug("msk=3D%p", msk);
>
> +	if (level =3D=3D SOL_SOCKET)
> +		return -EOPNOTSUPP;
> +
> 	/* @@ the meaning of setsockopt() when the socket is connected and
> 	 * there are multiple subflows is not yet defined. It is up to the
> 	 * MPTCP-level socket to configure the subflows until the subflow
> diff --git a/net/socket.c b/net/socket.c
> index d5b555845b37..98b70fcaff19 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2091,6 +2091,16 @@ SYSCALL_DEFINE4(recv, int, fd, void __user *, ubuf=
, size_t, size,
> 	return __sys_recvfrom(fd, ubuf, size, flags, NULL, NULL);
> }
>
> +static bool sock_use_custom_sol_socket(const struct socket *sock)
> +{
> +	const struct sock *sk =3D sock->sk;
> +
> +	/* Use sock->ops->setsockopt() for MPTCP */
> +	return sk->sk_protocol =3D=3D IPPROTO_MPTCP &&

Is it worth using IS_ENABLED(CONFIG_MPTCP) first in this boolean =

expression so this all compiles out when MPTCP is not enabled? On one hand =

it's a microoptimization on a path where performance doesn't matter much, =

but on the other hand we have tried to make things compile out where we =

can.


Mat


> +	       sk->sk_type =3D=3D SOCK_STREAM &&
> +	       (sk->sk_family =3D=3D AF_INET || sk->sk_family =3D=3D AF_INET6);
> +}
> +
> /*
>  *	Set a socket option. Because we don't know the option lengths we have
>  *	to pass the user mode parameter for the protocols to sort out.
> @@ -2129,7 +2139,7 @@ static int __sys_setsockopt(int fd, int level, int =
optname,
> 			optval =3D (char __user __force *)kernel_optval;
> 		}
>
> -		if (level =3D=3D SOL_SOCKET)
> +		if (level =3D=3D SOL_SOCKET && !sock_use_custom_sol_socket(sock))
> 			err =3D
> 			    sock_setsockopt(sock, level, optname, optval,
> 					    optlen);
> -- =

> 2.26.2

--
Mat Martineau
Intel
--===============4786999356324780942==--
