Content-Type: multipart/mixed; boundary="===============7599089752807388815=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: sockopt: pass set/getsockopt to subflows
Date: Thu, 15 Aug 2019 12:08:44 -0700
Message-ID: <alpine.OSX.2.21.1908151109190.43379@tdsilva-mobl.amr.corp.intel.com>
In-Reply-To: 20190815162432.22562-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1641

--===============7599089752807388815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 15 Aug 2019, Florian Westphal wrote:

> This allows to e.g. set tcp congestion control algorithm
> on all subflows by issuing the setsockopt on the mptcp meta socket.
>
> In the future we could keep a record of sockopts so we can "replay"
> them when another subflow is added at a later point in time.
>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---

Hi Florian -

There are a few problems with passing through all the socket options, and =

adding subflows later is one of them.

A bigger problem is options that will break MPTCP or lead to unexpected =

code paths. We don't want TCP_FASTOPEN (for now) or TCP_MD5SIG, for =

example. Fortunately TCP_ULP checks for existing icsk_ulp_ops. The MPTCP =

socket owns the subflow sockets and the subflows have been modified for =

MPTCP use, so I think it would be better to whitelist specific options =

that we know are safe to adjust. It also limits the combinations of TCP =

subflow features we have to consider for implementation and testing.

I'd also like to be careful about committing to userspace behavior (like =

"getsockopt returns info for the first subflow"), since we don't want to =

break userspace later.


The socket option API is a tricky spot for us. While we want an MPTCP =

socket act as much like a TCP socket as possible for compatibility with =

existing userspace programs, dealing with them in a meaningful and correct =

way across a group of subflows can require special handling.

What do you think about limiting this to SOL_TCP / TCP_CONGESTION for now, =

and we can expand support for other options as needed?


Mat



> net/mptcp/protocol.c | 47 ++++++++++++++++++++++++++++++++++++++++----
> 1 file changed, 43 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index aaa71b161c1a..e41a4daf4f99 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -711,9 +711,10 @@ static int mptcp_setsockopt(struct sock *sk, int lev=
el, int optname,
> 			    char __user *uoptval, unsigned int optlen)
> {
> 	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	const struct subflow_context *subflow;
> 	char __kernel *optval;
> 	struct socket *ssock;
> -	int ret;
> +	int ret, err, subflows;
>
> 	/* will be treated as __user in tcp_setsockopt */
> 	optval =3D (char __kernel __force *)uoptval;
> @@ -729,13 +730,36 @@ static int mptcp_setsockopt(struct sock *sk, int le=
vel, int optname,
>
> 	/* @@ the meaning of setsockopt() when the socket is connected and
> 	 * there are multiple subflows is not defined.
> +	 *
> +	 * We attempt to perfom the operation on all current subflows, but
> +	 * only return error if all subflow setsockopt failed.
> 	 */
> -	return 0;
> +	ret =3D 0;
> +	err =3D 0;
> +	subflows =3D 0;
> +	lock_sock(sk);
> +	list_for_each_entry(subflow, &msk->conn_list, node) {
> +		struct socket *tcp_sk =3D mptcp_subflow_tcp_socket(subflow);
> +		int tmp;
> +
> +		tmp =3D kernel_setsockopt(tcp_sk, level, optname, optval, optlen);
> +		if (tmp =3D=3D 0)
> +			subflows++;
> +		else if (err =3D=3D 0)
> +			err =3D tmp;
> +	}
> +	release_sock(sk);
> +
> +	if (subflows =3D=3D 0 && err)
> +		ret =3D err;
> +
> +	return ret;
> }
>
> static int mptcp_getsockopt(struct sock *sk, int level, int optname,
> 			    char __user *uoptval, int __user *uoption)
> {
> +	const struct subflow_context *subflow;
> 	struct mptcp_sock *msk =3D mptcp_sk(sk);
> 	char __kernel *optval;
> 	int __kernel *option;
> @@ -755,10 +779,25 @@ static int mptcp_getsockopt(struct sock *sk, int le=
vel, int optname,
> 		return ret;
> 	}
>
> -	/* @@ the meaning of setsockopt() when the socket is connected and
> +	/* @@ the meaning of getsockopt() when the socket is connected and
> 	 * there are multiple subflows is not defined.
> +	 *
> +	 * We use the first subflow in the list.
> 	 */
> -	return 0;
> +	lock_sock(sk);
> +	subflow =3D list_first_entry_or_null(&msk->conn_list,
> +					   struct subflow_context, node);
> +	if (subflow) {
> +		struct socket *tcp_sk =3D mptcp_subflow_tcp_socket(subflow);
> +
> +		ret =3D kernel_getsockopt(tcp_sk, level, optname, optval, option);
> +	} else {
> +		ret =3D -ENOTCONN;
> +	}
> +
> +	release_sock(sk);
> +
> +	return ret;
> }
>
> static int mptcp_get_port(struct sock *sk, unsigned short snum)
> -- =

> 2.21.0
>
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp
>

--
Mat Martineau
Intel

--===============7599089752807388815==--
