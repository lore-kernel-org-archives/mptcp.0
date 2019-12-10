Content-Type: multipart/mixed; boundary="===============2217251954351810498=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1 2/4] imptcp: cleanup fallback handling
Date: Mon, 09 Dec 2019 18:04:47 -0800
Message-ID: <alpine.OSX.2.21.1912091752400.11558@mjmartin-mac01.local>
In-Reply-To: d4fa8aa7b939cf3a81ea2c191255d2e5ea74407d.1575934525.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2854

--===============2217251954351810498==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Dec 2019, Paolo Abeni wrote:

> The 'fallback' field has many different meanings:
> tcp fallback socket, first subflow, listening socket.
> Enforcing the correct usage is not easy - currently we have
> several problems:
>
> 1) this will fail, but it should not:
> fd =3D socket(AF_INET{,6}, SOCK_STREAM, MPTCP_PROTO);
> setsockopt(fd, SOL_IP{,V6}, //...) =3D -1 EOPNOTSUPP (Operation not suppo=
rted)
>
> 2) this will report success, but it should not:
> fd =3D socket(AF_INET{,6}, SOCK_STREAM, MPTCP_PROTO);
> connect(fd, //)
> bind(fd, //) =3D 0
>
> 3) this will report success, but it should not:
> fd =3D socket(AF_INET{,6}, SOCK_STREAM, MPTCP_PROTO);
> listen(fd, // )
> s =3D accept(fd, )
> bind(s, ...) =3D 0
>
> This patch:
>
> - explicitly handle the msk socket status in some missing places
> - wrap msk->subflow access with helpers describing the expected
>  semantic
> - use the above to enforce correct syscall behavior
> - create on demand the subflow socket for setsockopt(), if possible
>
> RFC -> v1:
> - drop __mptcp_first_socket() helper, always use __mptcp_nmpc_socket()
>   instead
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 182 +++++++++++++++++++++++++++----------------
> 1 file changed, 115 insertions(+), 67 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f0944a5b562d..2a78123a20f4 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -22,25 +22,33 @@
> #include <net/mptcp.h>
> #include "protocol.h"
>
> -static struct socket *__mptcp_fallback_get_ref(const struct mptcp_sock *=
msk)
> +/* if msk has a single subflow socket, and the mp_capable handshake is n=
ot
> + * completed yet or has failed - that is, the socket is Not MP Capable,
> + * returns it.
> + * Otherwise returns NULL
> + */
> +static struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk)
> {
> -	sock_owned_by_me((const struct sock *)msk);
> -
> 	if (!msk->subflow)
> 		return NULL;
>
> -	sock_hold(msk->subflow->sk);
> 	return msk->subflow;
> }
>
> -static struct socket *mptcp_fallback_get_ref(const struct mptcp_sock *ms=
k)
> +/* if msk has a single subflow, and the mp_capable handshake is failed,
> + * get a reference and return it.
> + * Otherwise returns NULL
> + */
> +static struct socket *__mptcp_tcp_fallback_get(const struct mptcp_sock *=
msk)
> {
> -	struct socket *ssock;
> +	struct socket *ssock =3D __mptcp_nmpc_socket(msk);
>
> -	lock_sock((struct sock *)msk);
> -	ssock =3D __mptcp_fallback_get_ref(msk);
> -	release_sock((struct sock *)msk);
> +	sock_owned_by_me((const struct sock *)msk);
>
> +	if (!ssock || tcp_sk(ssock->sk)->is_mptcp)
> +		return NULL;
> +
> +	sock_hold(ssock->sk);
> 	return ssock;
> }
>
> @@ -57,6 +65,49 @@ static struct sock *mptcp_subflow_get(const struct mpt=
cp_sock *msk)
> 	return NULL;
> }
>
> +static bool __mptcp_can_create_subflow(const struct mptcp_sock *msk)
> +{
> +	return ((struct sock *)msk)->sk_state =3D=3D TCP_CLOSE;
> +}
> +
> +static struct socket *mptcp_socket_create_get(struct mptcp_sock *msk, in=
t state)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *sk =3D (struct sock *)msk;
> +	struct socket *ssock;
> +	int err;
> +
> +	lock_sock(sk);
> +	ssock =3D __mptcp_nmpc_socket(msk);
> +	if (ssock)
> +		goto set_state;
> +
> +	if (!__mptcp_can_create_subflow(msk)) {
> +		ssock =3D ERR_PTR(-EINVAL);
> +		goto release;
> +	}
> +
> +	err =3D mptcp_subflow_create_socket(sk, &ssock);
> +	if (err) {
> +		ssock =3D ERR_PTR(err);
> +		goto release;
> +	}
> +
> +	msk->subflow =3D ssock;
> +	subflow =3D mptcp_subflow_ctx(msk->subflow->sk);
> +	subflow->request_mptcp =3D 1; /* @@ if MPTCP enabled */
> +	subflow->request_version =3D 1; /* only v1 supported */
> +
> +set_state:
> +	sock_hold(ssock->sk);
> +	if (state !=3D TCP_MAX_STATES)
> +		inet_sk_state_store(sk, state);
> +
> +release:
> +	release_sock(sk);
> +	return ssock;
> +}
> +
> static bool mptcp_ext_cache_refill(struct mptcp_sock *msk)
> {
> 	if (!msk->cached_ext)
> @@ -221,7 +272,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
> 		return -EOPNOTSUPP;
>
> 	lock_sock(sk);
> -	ssock =3D __mptcp_fallback_get_ref(msk);
> +	ssock =3D __mptcp_tcp_fallback_get(msk);
> 	if (ssock) {
> 		release_sock(sk);
> 		pr_debug("fallback passthrough");
> @@ -324,7 +375,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
> 	long timeo;
>
> 	lock_sock(sk);
> -	ssock =3D __mptcp_fallback_get_ref(msk);
> +	ssock =3D __mptcp_tcp_fallback_get(msk);
> 	if (ssock) {
> 		release_sock(sk);
> 		pr_debug("fallback-read subflow=3D%p",
> @@ -579,7 +630,11 @@ static struct sock *mptcp_accept(struct sock *sk, in=
t flags, int *err,
> 	struct socket *listener;
> 	struct sock *newsk;
>
> -	listener =3D msk->subflow;
> +	listener =3D __mptcp_nmpc_socket(msk);
> +	if (WARN_ON_ONCE(!listener)) {
> +		*err =3D -EINVAL;
> +		return NULL;
> +	}
>
> 	pr_debug("msk=3D%p, listener=3D%p", msk, mptcp_subflow_ctx(listener->sk)=
);
> 	newsk =3D inet_csk_accept(listener->sk, flags, err, kern);
> @@ -665,8 +720,8 @@ static int mptcp_setsockopt(struct sock *sk, int leve=
l, int optname,
> 	optval =3D (char __kernel __force *)uoptval;
>
> 	pr_debug("msk=3D%p", msk);
> -	ssock =3D mptcp_fallback_get_ref(msk);
> -	if (ssock) {
> +	ssock =3D mptcp_socket_create_get(msk, TCP_MAX_STATES);

I think it would be helpful to have something like

#define MPTCP_SAME_STATE TCP_MAX_STATES

and use that name when calling mptcp_socket_create_get() and leaving the =

sk_state unchanged.

> +	if (!IS_ERR(ssock)) {
> 		pr_debug("subflow=3D%p", ssock->sk);
> 		ret =3D kernel_setsockopt(ssock, level, optname, optval, optlen);
> 		sock_put(ssock->sk);
> @@ -693,8 +748,8 @@ static int mptcp_getsockopt(struct sock *sk, int leve=
l, int optname,
> 	option =3D (int __kernel __force *)uoption;
>
> 	pr_debug("msk=3D%p", msk);
> -	ssock =3D mptcp_fallback_get_ref(msk);
> -	if (ssock) {
> +	ssock =3D mptcp_socket_create_get(msk, TCP_MAX_STATES);
> +	if (!IS_ERR(ssock)) {
> 		pr_debug("subflow=3D%p", ssock->sk);
> 		ret =3D kernel_getsockopt(ssock, level, optname, optval, option);
> 		sock_put(ssock->sk);
> @@ -710,11 +765,14 @@ static int mptcp_getsockopt(struct sock *sk, int le=
vel, int optname,
> static int mptcp_get_port(struct sock *sk, unsigned short snum)
> {
> 	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	struct socket *ssock;
>
> -	pr_debug("msk=3D%p, subflow=3D%p", msk,
> -		 mptcp_subflow_ctx(msk->subflow->sk));
> +	ssock =3D __mptcp_nmpc_socket(msk);
> +	pr_debug("msk=3D%p, subflow=3D%p", msk, ssock);
> +	if (WARN_ON_ONCE(!ssock))
> +		return -EINVAL;
>
> -	return inet_csk_get_port(msk->subflow->sk, snum);
> +	return inet_csk_get_port(ssock->sk, snum);
> }
>
> void mptcp_finish_connect(struct sock *ssk)
> @@ -811,43 +869,13 @@ static struct proto mptcp_prot =3D {
> 	.no_autobind	=3D true,
> };
>
> -static struct socket *mptcp_socket_create_get(struct mptcp_sock *msk)
> -{
> -	struct mptcp_subflow_context *subflow;
> -	struct sock *sk =3D (struct sock *)msk;
> -	struct socket *ssock;
> -	int err;
> -
> -	lock_sock(sk);
> -	ssock =3D __mptcp_fallback_get_ref(msk);
> -	if (ssock)
> -		goto release;
> -
> -	err =3D mptcp_subflow_create_socket(sk, &ssock);
> -	if (err) {
> -		ssock =3D ERR_PTR(err);
> -		goto release;
> -	}
> -
> -	msk->subflow =3D ssock;
> -	subflow =3D mptcp_subflow_ctx(msk->subflow->sk);
> -	subflow->request_mptcp =3D 1; /* @@ if MPTCP enabled */
> -	subflow->request_version =3D 1; /* only v1 supported */
> -
> -	sock_hold(ssock->sk);
> -
> -release:
> -	release_sock(sk);
> -	return ssock;
> -}
> -
> static int mptcp_bind(struct socket *sock, struct sockaddr *uaddr, int ad=
dr_len)
> {
> 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
> 	struct socket *ssock;
> 	int err;
>
> -	ssock =3D mptcp_socket_create_get(msk);
> +	ssock =3D mptcp_socket_create_get(msk, TCP_MAX_STATES);
> 	if (IS_ERR(ssock))
> 		return PTR_ERR(ssock);
>
> @@ -863,7 +891,7 @@ static int mptcp_stream_connect(struct socket *sock, =
struct sockaddr *uaddr,
> 	struct socket *ssock;
> 	int err;
>
> -	ssock =3D mptcp_socket_create_get(msk);
> +	ssock =3D mptcp_socket_create_get(msk, TCP_SYN_SENT);
> 	if (IS_ERR(ssock))
> 		return PTR_ERR(ssock);
>
> @@ -876,6 +904,10 @@ static int mptcp_stream_connect(struct socket *sock,=
 struct sockaddr *uaddr,
> #endif
>
> 	err =3D ssock->ops->connect(ssock, uaddr, addr_len, flags);
> +
> +	/* should we keep msk socket lock instead? and release it this
> +	 * latter state update */

I do think it would be better to keep the lock for this state =

manipulation. This locking gets changed in patch 4, so if this is all =

going to get squashed anyway then I guess it doesn't matter much.

> +	inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
> 	sock_put(ssock->sk);
> 	return err;
> }
> @@ -887,16 +919,16 @@ static int mptcp_getname(struct socket *sock, struc=
t sockaddr *uaddr,
> 	struct socket *ssock;
> 	int ret;
>
> -	if (msk->subflow) {
> -		lock_sock(sock->sk);
> -		ssock =3D __mptcp_fallback_get_ref(msk);
> -		release_sock(sock->sk);
> -		if (ssock) {
> -			pr_debug("subflow=3D%p", ssock->sk);
> -			ret =3D ssock->ops->getname(ssock, uaddr, peer);
> -			sock_put(ssock->sk);
> -			return ret;
> -		}
> +	lock_sock(sock->sk);
> +	ssock =3D __mptcp_nmpc_socket(msk);
> +	if (ssock)
> +		sock_hold(ssock->sk);
> +	release_sock(sock->sk);
> +	if (ssock) {
> +		pr_debug("subflow=3D%p", ssock->sk);
> +		ret =3D ssock->ops->getname(ssock, uaddr, peer);
> +		sock_put(ssock->sk);
> +		return ret;
> 	}
>
> 	switch (af) {
> @@ -962,11 +994,15 @@ static int mptcp_listen(struct socket *sock, int ba=
cklog)
>
> 	pr_debug("msk=3D%p", msk);
>
> -	ssock =3D mptcp_socket_create_get(msk);
> +	ssock =3D mptcp_socket_create_get(msk, TCP_LISTEN);
> 	if (IS_ERR(ssock))
> 		return PTR_ERR(ssock);
>
> 	err =3D ssock->ops->listen(ssock, backlog);
> +
> +	/* should we keep msk socket lock instead? and release it this
> +	 * latter state update */

Same locking comment as mptcp_stream_connect above, and same caveat =

concerning patch 4 and squashing.

Other than these two functions, locking looks ok.


Mat


> +	inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
> 	sock_put(ssock->sk);
> 	return err;
> }
> @@ -985,13 +1021,20 @@ static int mptcp_stream_accept(struct socket *sock=
, struct socket *newsock,
> {
> 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
> 	struct socket *ssock;
> -	int err;
> +	int err =3D -EINVAL;
>
> 	pr_debug("msk=3D%p", msk);
>
> -	ssock =3D mptcp_fallback_get_ref(msk);
> +	lock_sock(sock->sk);
> +	if (sock->sk->sk_state !=3D TCP_LISTEN)
> +		goto unlock_fail;
> +
> +	ssock =3D __mptcp_nmpc_socket(msk);
> 	if (!ssock)
> -		return -EINVAL;
> +		goto unlock_fail;
> +
> +	sock_hold(ssock->sk);
> +	release_sock(sock->sk);
>
> 	err =3D ssock->ops->accept(sock, newsock, flags, kern);
> 	if (err =3D=3D 0 && !is_tcp_proto(newsock->sk->sk_prot)) {
> @@ -1011,6 +1054,10 @@ static int mptcp_stream_accept(struct socket *sock=
, struct socket *newsock,
>
> 	sock_put(ssock->sk);
> 	return err;
> +
> +unlock_fail:
> +	release_sock(sock->sk);
> +	return -EINVAL;
> }
>
> static __poll_t mptcp_poll(struct file *file, struct socket *sock,
> @@ -1023,8 +1070,9 @@ static __poll_t mptcp_poll(struct file *file, struc=
t socket *sock,
>
> 	msk =3D mptcp_sk(sk);
> 	lock_sock(sk);
> -	ssock =3D __mptcp_fallback_get_ref(msk);
> +	ssock =3D __mptcp_nmpc_socket(msk);
> 	if (ssock) {
> +		sock_hold(ssock->sk);
> 		release_sock(sk);
> 		mask =3D ssock->ops->poll(file, ssock, wait);
> 		sock_put(ssock->sk);
> @@ -1061,7 +1109,7 @@ static int mptcp_shutdown(struct socket *sock, int =
how)
> 	if (how =3D=3D SHUT_WR || how =3D=3D SHUT_RDWR)
> 		inet_sk_state_store(sock->sk, TCP_FIN_WAIT1);
>
> -	ssock =3D __mptcp_fallback_get_ref(msk);
> +	ssock =3D __mptcp_tcp_fallback_get(msk);
> 	if (ssock) {
> 		release_sock(sock->sk);
> 		pr_debug("subflow=3D%p", ssock->sk);
> -- =

> 2.21.0

--
Mat Martineau
Intel
--===============2217251954351810498==--
