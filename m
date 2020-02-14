Content-Type: multipart/mixed; boundary="===============6456822359215819457=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net v2 2/3] mptcp: Protect subflow socket options
 before connection completes
Date: Fri, 14 Feb 2020 12:08:49 +0100
Message-ID: <cc7ba4b26f11019c6c110f5f0427fce90de725cd.camel@redhat.com>
In-Reply-To: 20200213203836.225812-3-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3657

--===============6456822359215819457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-02-13 at 12:38 -0800, Mat Martineau wrote:
> Userspace should not be able to directly manipulate subflow socket
> options before a connection is established since it is not yet known if
> it will be an MPTCP subflow or a TCP fallback subflow. TCP fallback
> subflows can be more directly controlled by userspace because they are
> regular TCP connections, while MPTCP subflow sockets need to be
> configured for the specific needs of MPTCP. Use the same logic as
> sendmsg/recvmsg to ensure that socket option calls are only passed
> through to known TCP fallback subflows.
> =

> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> ---
>  net/mptcp/protocol.c | 50 ++++++++++++++++++++++++--------------------
>  1 file changed, 27 insertions(+), 23 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index a8faf66c38d8..0169e7dfc2d1 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -756,60 +756,64 @@ static int mptcp_setsockopt(struct sock *sk, int le=
vel, int optname,
>  			    char __user *optval, unsigned int optlen)
>  {
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
> -	int ret =3D -EOPNOTSUPP;
>  	struct socket *ssock;
> -	struct sock *ssk;
>  =

>  	pr_debug("msk=3D%p", msk);
>  =

>  	/* @@ the meaning of setsockopt() when the socket is connected and
> -	 * there are multiple subflows is not defined.
> +	 * there are multiple subflows is not yet defined. It is up to the
> +	 * MPTCP-level socket to configure the subflows until the subflow
> +	 * is in TCP fallback, when TCP socket options are passed through
> +	 * to the one remaining subflow.
>  	 */
>  	lock_sock(sk);
> -	ssock =3D __mptcp_socket_create(msk, MPTCP_SAME_STATE);
> -	if (IS_ERR(ssock)) {
> +	ssock =3D __mptcp_tcp_fallback(msk);
> +	if (ssock) {
> +		struct sock *ssk =3D ssock->sk;
> +		int ret;
> +
> +		sock_hold(ssk);
>  		release_sock(sk);
> +		ret =3D tcp_setsockopt(ssk, level, optname, optval, optlen);
> +		sock_put(ssk);
>  		return ret;
>  	}
>  =

> -	ssk =3D ssock->sk;
> -	sock_hold(ssk);
>  	release_sock(sk);
>  =

> -	ret =3D tcp_setsockopt(ssk, level, optname, optval, optlen);
> -	sock_put(ssk);
> -
> -	return ret;
> +	return -EOPNOTSUPP;
>  }
>  =

>  static int mptcp_getsockopt(struct sock *sk, int level, int optname,
>  			    char __user *optval, int __user *option)
>  {
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
> -	int ret =3D -EOPNOTSUPP;
>  	struct socket *ssock;
> -	struct sock *ssk;
>  =

>  	pr_debug("msk=3D%p", msk);
>  =

> -	/* @@ the meaning of getsockopt() when the socket is connected and
> -	 * there are multiple subflows is not defined.
> +	/* @@ the meaning of setsockopt() when the socket is connected and
> +	 * there are multiple subflows is not yet defined. It is up to the
> +	 * MPTCP-level socket to configure the subflows until the subflow
> +	 * is in TCP fallback, when socket options are passed through
> +	 * to the one remaining subflow.
>  	 */
>  	lock_sock(sk);
> -	ssock =3D __mptcp_socket_create(msk, MPTCP_SAME_STATE);
> -	if (IS_ERR(ssock)) {
> +	ssock =3D __mptcp_tcp_fallback(msk);
> +	if (ssock) {
> +		struct sock *ssk =3D ssock->sk;
> +		int ret;
> +
> +		sock_hold(ssk);
>  		release_sock(sk);

Since I can't wrap my head on it, I'm going to do ask dumb question:

do we need this refcont at all? (here, in poll and in {recv,send}msg) ?

AFAICS:
- subflows can be freed only by mptcp_close()
- mptcp_close() is called by vfs->release() when the last reference to
the file descriptor associated to the msk socket is dropped.
- every syscall wraps vfs ops with fdget()/fdput() pairs so the file
descriptor can't go away during the syscall execution.

Overall I think the race between mptcp_close() and sock_sendmsg() is
not possible, WDYT ?!?

mptcp_close should need to care of possible cuncurrent BH/receive path
processing.

Paolo

Note: the I this doubt since I was wondering why socket-releated inet_*
operations that do not acquire the sock lock still do not have any
issue racing with close().


--===============6456822359215819457==--
