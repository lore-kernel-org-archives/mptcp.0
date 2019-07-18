Content-Type: multipart/mixed; boundary="===============0369955395706561145=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2] mptcp: harmonize locking on all socket
 operations.
Date: Thu, 18 Jul 2019 10:55:41 -0700
Message-ID: <df008864fc44adbcadcf5b94ad104db97833ac1a.camel@linux.intel.com>
In-Reply-To: f3fb40cd330e058e8eb21b3701eb0c5c01dc2324.1562860777.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1536

--===============0369955395706561145==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


v2 change looks good to me.

Peter.



On Thu, 2019-07-11 at 18:48 +0200, Paolo Abeni wrote:
> The locking schema implied by sendmsg(), recvmsg(), etc.
> requires acquiring the msk's socket lock before manipulating
> the msk internal status.
> =

> Additionally, we can't acquire the msk->subflow socket lock while holding
> the msk lock, due to mptcp_finish_connect().
> =

> Many socket operations do not enforce the required locking, e.g. we have
> several patterns alike:
> =

> 	if (msk->subflow)
> 		// do something with msk->subflow
> =

> or:
> =

> 	if (!msk->subflow)
> 		// allocate msk->subflow
> =

> all without any lock acquired.
> =

> They can race with each other and with mptcp_finish_connect() causing
> UAF, null ptr dereference and/or memory leaks.
> =

> This patch ensures that all mptcp socket operations access and manipulate
> msk->subflow under the msk socket lock. To avoid breaking the locking
> assumption introduced by mptcp_finish_connect(), while avoiding UAF
> issues, we acquire a reference to the msk->subflow, where needed.
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>  v1 -> v2:
>  - fix msk->subflow misusage in mptcp_getsockopt()
> =

> rfc -> v1:
>  - rename *mptcp_socket_get_ref() as *mptcp_fallback_get_ref()
>  - use subflow_create_socket() in mptcp_socket_create_get() instead
>    of open-codying it.
>  - use mptcp_fallback_get_ref() instead of mptcp_socket_create_get() in
>    mptcp_stream_accept()
> ---
>  net/mptcp/protocol.c | 191 +++++++++++++++++++++++++++++++------------
>  1 file changed, 137 insertions(+), 54 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 774ed25d3b6d..d31f5b48a566 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -24,6 +24,28 @@ static inline bool before64(__u64 seq1, __u64 seq2)
>  =

>  #define after64(seq2, seq1)	before64(seq1, seq2)
>  =

> +static struct socket *__mptcp_fallback_get_ref(const struct mptcp_sock *=
msk)
> +{
> +	sock_owned_by_me((const struct sock *)msk);
> +
> +	if (!msk->subflow)
> +		return NULL;
> +
> +	sock_hold(msk->subflow->sk);
> +	return msk->subflow;
> +}
> +
> +static struct socket *mptcp_fallback_get_ref(const struct mptcp_sock *ms=
k)
> +{
> +	struct socket *ssock;
> +
> +	lock_sock((struct sock *)msk);
> +	ssock =3D __mptcp_fallback_get_ref(msk);
> +	release_sock((struct sock *)msk);
> +
> +	return ssock;
> +}
> +
>  static struct sock *mptcp_subflow_get_ref(const struct mptcp_sock *msk)
>  {
>  	struct subflow_context *subflow;
> @@ -158,17 +180,22 @@ static int mptcp_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
>  {
>  	int mss_now =3D 0, size_goal =3D 0, ret =3D 0;
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	struct socket *ssock;
>  	size_t copied =3D 0;
>  	struct sock *ssk;
>  	long timeo;
>  =

>  	pr_debug("msk=3D%p", msk);
> -	if (msk->subflow) {
> +	lock_sock(sk);
> +	ssock =3D __mptcp_fallback_get_ref(msk);
> +	if (ssock) {
> +		release_sock(sk);
>  		pr_debug("fallback passthrough");
> -		return sock_sendmsg(msk->subflow, msg);
> +		ret =3D sock_sendmsg(ssock, msg);
> +		sock_put(ssock->sk);
> +		return ret;
>  	}
>  =

> -	lock_sock(sk);
>  	ssk =3D mptcp_subflow_get_ref(msk);
>  	if (!ssk) {
>  		release_sock(sk);
> @@ -364,18 +391,22 @@ static int mptcp_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
>  	struct subflow_context *subflow;
>  	struct mptcp_read_arg arg;
>  	read_descriptor_t desc;
> +	struct socket *ssock;
>  	struct tcp_sock *tp;
>  	struct sock *ssk;
>  	int copied =3D 0;
>  	long timeo;
>  =

> -	if (msk->subflow) {
> -		pr_debug("fallback-read subflow=3D%p",
> -			 subflow_ctx(msk->subflow->sk));
> -		return sock_recvmsg(msk->subflow, msg, flags);
> +	lock_sock(sk);
> +	ssock =3D __mptcp_fallback_get_ref(msk);
> +	if (ssock) {
> +		release_sock(sk);
> +		pr_debug("fallback-read subflow=3D%p", subflow_ctx(ssock->sk));
> +		copied =3D sock_recvmsg(ssock, msg, flags);
> +		sock_put(ssock->sk);
> +		return copied;
>  	}
>  =

> -	lock_sock(sk);
>  	ssk =3D mptcp_subflow_get_ref(msk);
>  	if (!ssk) {
>  		release_sock(sk);
> @@ -673,15 +704,19 @@ static int mptcp_setsockopt(struct sock *sk, int le=
vel, int optname,
>  {
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
>  	char __kernel *optval;
> +	struct socket *ssock;
> +	int ret;
>  =

>  	/* will be treated as __user in tcp_setsockopt */
>  	optval =3D (char __kernel __force *)uoptval;
>  =

>  	pr_debug("msk=3D%p", msk);
> -	if (msk->subflow) {
> -		pr_debug("subflow=3D%p", msk->subflow->sk);
> -		return kernel_setsockopt(msk->subflow, level, optname, optval,
> -					 optlen);
> +	ssock =3D mptcp_fallback_get_ref(msk);
> +	if (ssock) {
> +		pr_debug("subflow=3D%p", ssock->sk);
> +		ret =3D kernel_setsockopt(ssock, level, optname, optval, optlen);
> +		sock_put(ssock->sk);
> +		return ret;
>  	}
>  =

>  	/* @@ the meaning of setsockopt() when the socket is connected and
> @@ -696,16 +731,20 @@ static int mptcp_getsockopt(struct sock *sk, int le=
vel, int optname,
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
>  	char __kernel *optval;
>  	int __kernel *option;
> +	struct socket *ssock;
> +	int ret;
>  =

>  	/* will be treated as __user in tcp_getsockopt */
>  	optval =3D (char __kernel __force *)uoptval;
>  	option =3D (int __kernel __force *)uoption;
>  =

>  	pr_debug("msk=3D%p", msk);
> -	if (msk->subflow) {
> -		pr_debug("subflow=3D%p", msk->subflow->sk);
> -		return kernel_getsockopt(msk->subflow, level, optname, optval,
> -					 option);
> +	ssock =3D mptcp_fallback_get_ref(msk);
> +	if (ssock) {
> +		pr_debug("subflow=3D%p", ssock->sk);
> +		ret =3D kernel_getsockopt(ssock, level, optname, optval, option);
> +		sock_put(ssock->sk);
> +		return ret;
>  	}
>  =

>  	/* @@ the meaning of setsockopt() when the socket is connected and
> @@ -817,9 +856,35 @@ static struct proto mptcp_prot =3D {
>  	.no_autobind	=3D 1,
>  };
>  =

> +static struct socket *mptcp_socket_create_get(struct mptcp_sock *msk)
> +{
> +	struct sock *sk =3D (struct sock *)msk;
> +	struct socket *ssock;
> +	int err;
> +
> +	lock_sock(sk);
> +	ssock =3D __mptcp_fallback_get_ref(msk);
> +	if (ssock)
> +		goto release;
> +
> +	err =3D subflow_create_socket(sk, &ssock);
> +	if (err) {
> +		ssock =3D ERR_PTR(err);
> +		goto release;
> +	}
> +
> +	msk->subflow =3D ssock;
> +	sock_hold(ssock->sk);
> +
> +release:
> +	release_sock(sk);
> +	return ssock;
> +}
> +
>  static int mptcp_bind(struct socket *sock, struct sockaddr *uaddr, int a=
ddr_len)
>  {
>  	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
> +	struct socket *ssock;
>  	int err =3D -ENOTSUPP;
>  =

>  	pr_debug("msk=3D%p", msk);
> @@ -827,18 +892,20 @@ static int mptcp_bind(struct socket *sock, struct s=
ockaddr *uaddr, int addr_len)
>  	if (uaddr->sa_family !=3D AF_INET) // @@ allow only IPv4 for now
>  		return err;
>  =

> -	if (!msk->subflow) {
> -		err =3D subflow_create_socket(sock->sk, &msk->subflow);
> -		if (err)
> -			return err;
> -	}
> -	return inet_bind(msk->subflow, uaddr, addr_len);
> +	ssock =3D mptcp_socket_create_get(msk);
> +	if (IS_ERR(ssock))
> +		return PTR_ERR(ssock);
> +
> +	err =3D inet_bind(ssock, uaddr, addr_len);
> +	sock_put(ssock->sk);
> +	return err;
>  }
>  =

>  static int mptcp_stream_connect(struct socket *sock, struct sockaddr *ua=
ddr,
>  				int addr_len, int flags)
>  {
>  	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
> +	struct socket *ssock;
>  	int err =3D -ENOTSUPP;
>  =

>  	pr_debug("msk=3D%p", msk);
> @@ -846,19 +913,20 @@ static int mptcp_stream_connect(struct socket *sock=
, struct sockaddr *uaddr,
>  	if (uaddr->sa_family !=3D AF_INET) // @@ allow only IPv4 for now
>  		return err;
>  =

> -	if (!msk->subflow) {
> -		err =3D subflow_create_socket(sock->sk, &msk->subflow);
> -		if (err)
> -			return err;
> -	}
> +	ssock =3D mptcp_socket_create_get(msk);
> +	if (IS_ERR(ssock))
> +		return PTR_ERR(ssock);
>  =

> -	return inet_stream_connect(msk->subflow, uaddr, addr_len, flags);
> +	err =3D inet_stream_connect(ssock, uaddr, addr_len, flags);
> +	sock_put(ssock->sk);
> +	return err;
>  }
>  =

>  static int mptcp_getname(struct socket *sock, struct sockaddr *uaddr,
>  			 int peer)
>  {
>  	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
> +	struct socket *ssock;
>  	struct sock *ssk;
>  	int ret;
>  =

> @@ -876,16 +944,20 @@ static int mptcp_getname(struct socket *sock, struc=
t sockaddr *uaddr,
>  		return inet_getname(sock, uaddr, peer);
>  	}
>  =

> -	if (msk->subflow) {
> -		pr_debug("subflow=3D%p", msk->subflow->sk);
> -		return inet_getname(msk->subflow, uaddr, peer);
> +	lock_sock(sock->sk);
> +	ssock =3D __mptcp_fallback_get_ref(msk);
> +	if (ssock) {
> +		release_sock(sock->sk);
> +		pr_debug("subflow=3D%p", ssock->sk);
> +		ret =3D inet_getname(ssock, uaddr, peer);
> +		sock_put(ssock->sk);
> +		return ret;
>  	}
>  =

>  	/* @@ the meaning of getname() for the remote peer when the socket
>  	 * is connected and there are multiple subflows is not defined.
>  	 * For now just use the first subflow on the list.
>  	 */
> -	lock_sock(sock->sk);
>  	ssk =3D mptcp_subflow_get_ref(msk);
>  	if (!ssk) {
>  		release_sock(sock->sk);
> @@ -901,29 +973,36 @@ static int mptcp_getname(struct socket *sock, struc=
t sockaddr *uaddr,
>  static int mptcp_listen(struct socket *sock, int backlog)
>  {
>  	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
> +	struct socket *ssock;
>  	int err;
>  =

>  	pr_debug("msk=3D%p", msk);
>  =

> -	if (!msk->subflow) {
> -		err =3D subflow_create_socket(sock->sk, &msk->subflow);
> -		if (err)
> -			return err;
> -	}
> -	return inet_listen(msk->subflow, backlog);
> +	ssock =3D mptcp_socket_create_get(msk);
> +	if (IS_ERR(ssock))
> +		return PTR_ERR(ssock);
> +
> +	err =3D inet_listen(ssock, backlog);
> +	sock_put(ssock->sk);
> +	return err;
>  }
>  =

>  static int mptcp_stream_accept(struct socket *sock, struct socket *newso=
ck,
>  			       int flags, bool kern)
>  {
>  	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
> +	struct socket *ssock;
> +	int err;
>  =

>  	pr_debug("msk=3D%p", msk);
>  =

> -	if (!msk->subflow)
> +	ssock =3D mptcp_fallback_get_ref(msk);
> +	if (!ssock)
>  		return -EINVAL;
>  =

> -	return inet_accept(sock, newsock, flags, kern);
> +	err =3D inet_accept(sock, newsock, flags, kern);
> +	sock_put(ssock->sk);
> +	return err;
>  }
>  =

>  static __poll_t mptcp_poll(struct file *file, struct socket *sock,
> @@ -932,13 +1011,19 @@ static __poll_t mptcp_poll(struct file *file, stru=
ct socket *sock,
>  	struct subflow_context *subflow;
>  	const struct mptcp_sock *msk;
>  	struct sock *sk =3D sock->sk;
> +	struct socket *ssock;
>  	__poll_t ret =3D 0;
>  =

>  	msk =3D mptcp_sk(sk);
> -	if (msk->subflow)
> -		return tcp_poll(file, msk->subflow, wait);
> -
>  	lock_sock(sk);
> +	ssock =3D __mptcp_fallback_get_ref(msk);
> +	if (ssock) {
> +		release_sock(sk);
> +		ret =3D tcp_poll(file, ssock, wait);
> +		sock_put(ssock->sk);
> +		return ret;
> +	}
> +
>  	mptcp_for_each_subflow(msk, subflow) {
>  		struct socket *tcp_sock;
>  =

> @@ -954,23 +1039,21 @@ static int mptcp_shutdown(struct socket *sock, int=
 how)
>  {
>  	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
>  	struct subflow_context *subflow;
> +	struct socket *ssock;
>  	int ret =3D 0;
>  =

>  	pr_debug("sk=3D%p, how=3D%d", msk, how);
>  =

> -	if (msk->subflow) {
> -		pr_debug("subflow=3D%p", msk->subflow->sk);
> -		return kernel_sock_shutdown(msk->subflow, how);
> +	lock_sock(sock->sk);
> +	ssock =3D __mptcp_fallback_get_ref(msk);
> +	if (ssock) {
> +		release_sock(sock->sk);
> +		pr_debug("subflow=3D%p", ssock->sk);
> +		ret =3D kernel_sock_shutdown(ssock, how);
> +		sock_put(ssock->sk);
> +		return ret;
>  	}
>  =

> -	/* protect against concurrent mptcp_close(), so that nobody can
> -	 * remove entries from the conn list and walking the list
> -	 * is still safe.
> -	 *
> -	 * We can't use MPTCP socket lock to protect conn_list changes,
> -	 * as we need to update it from the BH via the mptcp_finish_connect()
> -	 */
> -	lock_sock(sock->sk);
>  	mptcp_for_each_subflow(msk, subflow) {
>  		struct socket *tcp_socket;
>  =



--===============0369955395706561145==--
