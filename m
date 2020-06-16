Content-Type: multipart/mixed; boundary="===============1445303710545064341=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v2 2/3] mptcp: add REUSEADDR/REUSEADDR
 support
Date: Tue, 16 Jun 2020 13:59:22 -0700
Message-ID: <alpine.OSX.2.22.394.2006161331510.21710@ajaladi-mobl.amr.corp.intel.com>
In-Reply-To: 20200616122531.2443-3-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4712

--===============1445303710545064341==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 16 Jun 2020, Florian Westphal wrote:

> This will e.g. make 'sshd restart' work when MPTCP is used, as we will
> now set this option on the listener socket instead of only the mptcp
> socket (where it has no effect).
>
> We still need to copy the setting to the master socket so that a
> subsequent getsockopt() returns the expected value.
>
> Reported-by: Christoph Paasch <cpaasch(a)apple.com>
> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> net/mptcp/protocol.c | 34 +++++++++++++++++++++++++++++++++-
> 1 file changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f9429c6f5b96..b2338680497a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1628,6 +1628,37 @@ static void mptcp_destroy(struct sock *sk)
> 	sk_sockets_allocated_dec(sk);
> }
>
> +static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optna=
me,
> +				       char __user *optval, unsigned int optlen)
> +{
> +	struct sock *sk =3D (struct sock *)msk;
> +	int ret =3D -EOPNOTSUPP;
> +	struct socket *ssock;
> +
> +	switch (optname) {
> +	case SO_REUSEPORT:
> +	case SO_REUSEADDR:
> +		lock_sock(sk);
> +		ssock =3D __mptcp_socket_create(msk, MPTCP_SAME_STATE);
> +		if (IS_ERR(ssock)) {
> +			release_sock(sk);
> +			return PTR_ERR(ssock);
> +		}
> +
> +		ret =3D sock_setsockopt(ssock, SOL_SOCKET, optname, optval, optlen);
> +		if (ret =3D=3D 0) {
> +			if (optname =3D=3D SO_REUSEPORT)
> +				sk->sk_reuseport =3D ssock->sk->sk_reuseport;
> +			else if (optname =3D=3D SO_REUSEADDR)
> +				sk->sk_reuse =3D ssock->sk->sk_reuse;
> +		}
> +		release_sock(sk);
> +		break;

Returning EOPNOTSUPP for all the other SOL_SOCKET options would be a =

significant change in behavior from MPTCP in 5.7 (or 5.8, depending on =

whether this goes to net or net-next), and also different from every other =

kind of socket. Even of not all the SOL_SOCKET options end up doing much =

yet, it seems more consistent for userspace if this switch statement has a =

default case that calls sock_setsockopt() on the msk. What do you think?


Mat


> +	}
> +
> +	return ret;
> +}
> +
> static int mptcp_setsockopt(struct sock *sk, int level, int optname,
> 			    char __user *optval, unsigned int optlen)
> {
> @@ -1637,7 +1668,8 @@ static int mptcp_setsockopt(struct sock *sk, int le=
vel, int optname,
> 	pr_debug("msk=3D%p", msk);
>
> 	if (level =3D=3D SOL_SOCKET)
> -		return -EOPNOTSUPP;
> +		return mptcp_setsockopt_sol_socket(msk, optname,
> +						   optval, optlen);
>
> 	/* @@ the meaning of setsockopt() when the socket is connected and
> 	 * there are multiple subflows is not yet defined. It is up to the
> -- =

> 2.26.2

--
Mat Martineau
Intel
--===============1445303710545064341==--
