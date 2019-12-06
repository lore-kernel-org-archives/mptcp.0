Content-Type: multipart/mixed; boundary="===============8240163528210998433=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 5/5] mptcp: avoid acquiring the msk lock in
 mptcp_finisch_connect()
Date: Fri, 06 Dec 2019 07:16:21 -0800
Message-ID: <27996D55-DD9F-4C0F-B4E1-A22123369975@apple.com>
In-Reply-To: b0076fb69854694ac48b5e10927859aa9e20104f.1575634848.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2821

--===============8240163528210998433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

"[MPTCP] [RFC PATCH 5/5] mptcp: avoid acquiring the msk lock in mptcp_finis=
ch_connect()"

I know there are two native German speakers here on this list, but let's no=
t push it too far =F0=9F=98=82


Christoph

> On Dec 6, 2019, at 4:22 AM, Paolo Abeni <pabeni(a)redhat.com> wrote:
> =

> No longer required, just document the unlocked access with WRITE_ONCE()
> Since we now always acquire msk -> ssk lock in order, we can also
> avoid the msk lock/subflow lookup()/get()/ msk unlock()/ subflow op/ subf=
low put
> dance in most ops - simply keep the msk lock held the whole time.
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 181 ++++++++++++++++++-------------------------
> 1 file changed, 75 insertions(+), 106 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 6ec4aed0338e..c9a729643c0b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -55,10 +55,10 @@ static struct socket *__mptcp_first_socket(const stru=
ct mptcp_sock *msk)
> }
> =

> /* if msk has a single subflow, and the mp_capable handshake is failed,
> - * get a reference and return it.
> + * return it.
>  * Otherwise returns NULL
>  */
> -static struct socket *__mptcp_tcp_fallback_get(const struct mptcp_sock *=
msk)
> +static struct socket *__mptcp_tcp_fallback(const struct mptcp_sock *msk)
> {
> 	struct socket *ssock;
> =

> @@ -69,7 +69,6 @@ static struct socket *__mptcp_tcp_fallback_get(const st=
ruct mptcp_sock *msk)
> 	if (tcp_sk(ssock->sk)->is_mptcp)
> 		return NULL;
> =

> -	sock_hold(ssock->sk);
> 	return ssock;
> }
> =

> @@ -93,28 +92,23 @@ static bool __mptcp_can_create_subflow(const struct m=
ptcp_sock *msk)
> 	return state =3D=3D TCP_CLOSE || state =3D=3D TCP_LISTEN;
> }
> =

> -static struct socket *mptcp_socket_create_get(struct mptcp_sock *msk, in=
t state)
> +static struct socket *__mptcp_socket_create(struct mptcp_sock *msk, int =
state)
> {
> 	struct mptcp_subflow_context *subflow;
> 	struct sock *sk =3D (struct sock *)msk;
> 	struct socket *ssock;
> 	int err;
> =

> -	lock_sock(sk);
> 	ssock =3D __mptcp_nmpc_socket(msk);
> 	if (ssock)
> 		goto set_state;
> =

> -	if (!__mptcp_can_create_subflow(msk)) {
> -		ssock =3D ERR_PTR(-EINVAL);
> -		goto release;
> -	}
> +	if (!__mptcp_can_create_subflow(msk))
> +		return ERR_PTR(-EINVAL);
> =

> 	err =3D mptcp_subflow_create_socket(sk, &ssock);
> -	if (err) {
> -		ssock =3D ERR_PTR(err);
> -		goto release;
> -	}
> +	if (err)
> +		return ERR_PTR(err);
> =

> 	subflow =3D mptcp_subflow_ctx(ssock->sk);
> 	list_add(&subflow->node, &msk->conn_list);
> @@ -122,12 +116,8 @@ static struct socket *mptcp_socket_create_get(struct=
 mptcp_sock *msk, int state)
> 	subflow->request_version =3D 1; /* only v1 supported */
> =

> set_state:
> -	sock_hold(ssock->sk);
> 	if (state !=3D TCP_MAX_STATES)
> 		inet_sk_state_store(sk, state);
> -
> -release:
> -	release_sock(sk);
> 	return ssock;
> }
> =

> @@ -287,12 +277,11 @@ static int mptcp_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
> 		return -EOPNOTSUPP;
> =

> 	lock_sock(sk);
> -	ssock =3D __mptcp_tcp_fallback_get(msk);
> +	ssock =3D __mptcp_tcp_fallback(msk);
> 	if (ssock) {
> -		release_sock(sk);
> 		pr_debug("fallback passthrough");
> 		ret =3D sock_sendmsg(ssock, msg);
> -		sock_put(ssock->sk);
> +		release_sock(sk);
> 		return ret;
> 	}
> =

> @@ -394,13 +383,12 @@ static int mptcp_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
> 	long timeo;
> =

> 	lock_sock(sk);
> -	ssock =3D __mptcp_tcp_fallback_get(msk);
> +	ssock =3D __mptcp_tcp_fallback(msk);
> 	if (ssock) {
> -		release_sock(sk);
> 		pr_debug("fallback-read subflow=3D%p",
> 			 mptcp_subflow_ctx(ssock->sk));
> 		copied =3D sock_recvmsg(ssock, msg, flags);
> -		sock_put(ssock->sk);
> +		release_sock(sk);
> 		return copied;
> 	}
> =

> @@ -645,25 +633,26 @@ static int mptcp_setsockopt(struct sock *sk, int le=
vel, int optname,
> {
> 	struct mptcp_sock *msk =3D mptcp_sk(sk);
> 	char __kernel *optval;
> +	int ret =3D -EOPNOTSUPP;
> 	struct socket *ssock;
> -	int ret;
> =

> 	/* will be treated as __user in tcp_setsockopt */
> 	optval =3D (char __kernel __force *)uoptval;
> =

> 	pr_debug("msk=3D%p", msk);
> -	ssock =3D mptcp_socket_create_get(msk, TCP_MAX_STATES);
> +
> +	/* @@ the meaning of setsockopt() when the socket is connected and
> +	 * there are multiple subflows is not defined.
> +	 */
> +	lock_sock(sk);
> +	ssock =3D __mptcp_socket_create(msk, TCP_MAX_STATES);
> 	if (!IS_ERR(ssock)) {
> 		pr_debug("subflow=3D%p", ssock->sk);
> 		ret =3D kernel_setsockopt(ssock, level, optname, optval, optlen);
> -		sock_put(ssock->sk);
> -		return ret;
> 	}
> +	release_sock(sk);
> =

> -	/* @@ the meaning of setsockopt() when the socket is connected and
> -	 * there are multiple subflows is not defined.
> -	 */
> -	return -EOPNOTSUPP;
> +	return ret;
> }
> =

> static int mptcp_getsockopt(struct sock *sk, int level, int optname,
> @@ -671,27 +660,28 @@ static int mptcp_getsockopt(struct sock *sk, int le=
vel, int optname,
> {
> 	struct mptcp_sock *msk =3D mptcp_sk(sk);
> 	char __kernel *optval;
> +	int ret =3D -EOPNOTSUPP;
> 	int __kernel *option;
> 	struct socket *ssock;
> -	int ret;
> =

> 	/* will be treated as __user in tcp_getsockopt */
> 	optval =3D (char __kernel __force *)uoptval;
> 	option =3D (int __kernel __force *)uoption;
> =

> 	pr_debug("msk=3D%p", msk);
> -	ssock =3D mptcp_socket_create_get(msk, TCP_MAX_STATES);
> +	lock_sock(sk);
> +
> +	/* @@ the meaning of getsockopt() when the socket is connected and
> +	 * there are multiple subflows is not defined.
> +	 */
> +	ssock =3D __mptcp_socket_create(msk, TCP_MAX_STATES);
> 	if (!IS_ERR(ssock)) {
> 		pr_debug("subflow=3D%p", ssock->sk);
> 		ret =3D kernel_getsockopt(ssock, level, optname, optval, option);
> -		sock_put(ssock->sk);
> -		return ret;
> 	}
> +	release_sock(sk);
> =

> -	/* @@ the meaning of getsockopt() when the socket is connected and
> -	 * there are multiple subflows is not defined.
> -	 */
> -	return -EOPNOTSUPP;
> +	return ret;
> }
> =

> static int mptcp_get_port(struct sock *sk, unsigned short snum)
> @@ -711,51 +701,27 @@ void mptcp_finish_connect(struct sock *sk,
> 			  struct mptcp_subflow_context *subflow)
> {
> 	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	u64 ack_seq;
> =

> -	if (subflow->mp_capable) {
> -		u64 ack_seq;
> +	if (!subflow->mp_capable)
> +		return;
> =

> -		/* sk (new subflow socket) is already locked, but we need
> -		 * to lock the parent (mptcp) socket now to add the tcp socket
> -		 * to the subflow list.
> -		 *
> -		 * From lockdep point of view, this creates an ABBA type
> -		 * deadlock: Normally (sendmsg, recvmsg, ..), we lock the mptcp
> -		 * socket, then acquire a subflow lock.
> -		 * Here we do the reverse: "subflow lock, then mptcp lock".
> -		 *
> -		 * Its alright to do this here, because this subflow is not yet
> -		 * on the mptcp sockets subflow list.
> -		 *
> -		 * IOW, if another CPU has this mptcp socket locked, it cannot
> -		 * acquire this particular subflow, because subflow->sk isn't
> -		 * on msk->conn_list.
> -		 *
> -		 * This function can be called either from backlog processing
> -		 * (BH will be enabled) or from softirq, so we need to use BH
> -		 * locking scheme.
> -		 */
> -		local_bh_disable();
> -		bh_lock_sock_nested(sk);
> +	pr_debug("msk=3D%p, token=3D%u", msk, subflow->token);
> +	mptcp_crypto_key_sha(subflow->remote_key, NULL, &ack_seq);
> +	ack_seq++;
> +	subflow->map_seq =3D ack_seq;
> +	subflow->map_subflow_seq =3D 1;
> +	subflow->rel_write_seq =3D 1;
> =

> -		msk->remote_key =3D subflow->remote_key;
> -		msk->local_key =3D subflow->local_key;
> -		msk->token =3D subflow->token;
> -
> -		pr_debug("msk=3D%p, token=3D%u", msk, msk->token);
> -
> -		mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
> -		msk->write_seq =3D subflow->idsn + 1;
> -		ack_seq++;
> -		msk->ack_seq =3D ack_seq;
> -		msk->can_ack =3D 1;
> -		subflow->map_seq =3D ack_seq;
> -		subflow->map_subflow_seq =3D 1;
> -		subflow->rel_write_seq =3D 1;
> -		bh_unlock_sock(sk);
> -		local_bh_enable();
> -	}
> -	inet_sk_state_store(sk, TCP_ESTABLISHED);
> +	/* the socket is not connected yet, no msk/subflow ops can access/race
> +	 * accessing the field below
> +	 */
> +	WRITE_ONCE(msk->remote_key, subflow->remote_key);
> +	WRITE_ONCE(msk->local_key, subflow->local_key);
> +	WRITE_ONCE(msk->token, subflow->token);
> +	WRITE_ONCE(msk->write_seq, subflow->idsn + 1);
> +	WRITE_ONCE(msk->ack_seq, ack_seq);
> +	WRITE_ONCE(msk->can_ack, 1);
> }
> =

> static struct proto mptcp_prot =3D {
> @@ -783,12 +749,17 @@ static int mptcp_bind(struct socket *sock, struct s=
ockaddr *uaddr, int addr_len)
> 	struct socket *ssock;
> 	int err;
> =

> -	ssock =3D mptcp_socket_create_get(msk, TCP_MAX_STATES);
> -	if (IS_ERR(ssock))
> -		return PTR_ERR(ssock);
> +	lock_sock(sock->sk);
> +	ssock =3D __mptcp_socket_create(msk, TCP_MAX_STATES);
> +	if (IS_ERR(ssock)) {
> +		err =3D PTR_ERR(ssock);
> +		goto unlock;
> +	}
> =

> 	err =3D ssock->ops->bind(ssock, uaddr, addr_len);
> -	sock_put(ssock->sk);
> +
> +unlock:
> +	release_sock(sock->sk);
> 	return err;
> }
> =

> @@ -799,9 +770,12 @@ static int mptcp_stream_connect(struct socket *sock,=
 struct sockaddr *uaddr,
> 	struct socket *ssock;
> 	int err;
> =

> -	ssock =3D mptcp_socket_create_get(msk, TCP_SYN_SENT);
> -	if (IS_ERR(ssock))
> -		return PTR_ERR(ssock);
> +	lock_sock(sock->sk);
> +	ssock =3D __mptcp_socket_create(msk, TCP_SYN_SENT);
> +	if (IS_ERR(ssock)) {
> +		err =3D PTR_ERR(ssock);
> +		goto unlock;
> +	}
> =

> #ifdef CONFIG_TCP_MD5SIG
> 	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
> @@ -816,7 +790,9 @@ static int mptcp_stream_connect(struct socket *sock, =
struct sockaddr *uaddr,
> 	/* should we keep msk socket lock instead? and release it this
> 	 * latter state update */
> 	inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
> -	sock_put(ssock->sk);
> +
> +unlock:
> +	release_sock(sock->sk);
> 	return err;
> }
> =

> @@ -897,16 +873,21 @@ static int mptcp_listen(struct socket *sock, int ba=
cklog)
> =

> 	pr_debug("msk=3D%p", msk);
> =

> -	ssock =3D mptcp_socket_create_get(msk, TCP_LISTEN);
> -	if (IS_ERR(ssock))
> -		return PTR_ERR(ssock);
> +	lock_sock(sock->sk);
> +	ssock =3D __mptcp_socket_create(msk, TCP_LISTEN);
> +	if (IS_ERR(ssock)) {
> +		err =3D PTR_ERR(ssock);
> +		goto unlock;
> +	}
> =

> 	err =3D ssock->ops->listen(ssock, backlog);
> =

> 	/* should we keep msk socket lock instead? and release it this
> 	 * latter state update */
> 	inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
> -	sock_put(ssock->sk);
> +
> +unlock:
> +	release_sock(sock->sk);
> 	return err;
> }
> =

> @@ -952,10 +933,8 @@ static __poll_t mptcp_poll(struct file *file, struct=
 socket *sock,
> 	lock_sock(sk);
> 	ssock =3D __mptcp_nmpc_socket(msk);
> 	if (ssock) {
> -		sock_hold(ssock->sk);
> -		release_sock(sk);
> 		ret =3D ssock->ops->poll(file, ssock, wait);
> -		sock_put(ssock->sk);
> +		release_sock(sk);
> 		return ret;
> 	}
> =

> @@ -978,7 +957,6 @@ static int mptcp_shutdown(struct socket *sock, int ho=
w)
> {
> 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
> 	struct mptcp_subflow_context *subflow;
> -	struct socket *ssock;
> 	int ret =3D 0;
> =

> 	pr_debug("sk=3D%p, how=3D%d", msk, how);
> @@ -988,15 +966,6 @@ static int mptcp_shutdown(struct socket *sock, int h=
ow)
> 	if (how =3D=3D SHUT_WR || how =3D=3D SHUT_RDWR)
> 		inet_sk_state_store(sock->sk, TCP_FIN_WAIT1);
> =

> -	ssock =3D __mptcp_tcp_fallback_get(msk);
> -	if (ssock) {
> -		release_sock(sock->sk);
> -		pr_debug("subflow=3D%p", ssock->sk);
> -		ret =3D kernel_sock_shutdown(ssock, how);
> -		sock_put(ssock->sk);
> -		return ret;
> -	}
> -
> 	mptcp_for_each_subflow(msk, subflow) {
> 		struct socket *tcp_socket;
> =

> -- =

> 2.21.0
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org


--===============8240163528210998433==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+PGhlYWQ+PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0
L2h0bWw7IGNoYXJzZXQ9dXRmLTgiPjwvaGVhZD48Ym9keSBzdHlsZT0id29yZC13cmFwOiBicmVh
ay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6IGFmdGVyLXdoaXRl
LXNwYWNlOyIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48aSBjbGFzcz0iIj4iW01QVENQXSBbUkZD
IFBBVENIIDUvNV0gbXB0Y3A6IGF2b2lkIGFjcXVpcmluZyB0aGUgbXNrIGxvY2sgaW4gbXB0Y3Bf
PGIgY2xhc3M9IiI+ZmluaXNjaDwvYj5fY29ubmVjdCgpIjwvaT48L2Rpdj48ZGl2IGNsYXNzPSIi
PjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPkkga25vdyB0aGVyZSBhcmUgdHdvIG5h
dGl2ZSBHZXJtYW4gc3BlYWtlcnMgaGVyZSBvbiB0aGlzIGxpc3QsIGJ1dCBsZXQncyBub3QgcHVz
aCBpdCB0b28gZmFyIPCfmII8L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48
ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPkNocmlzdG9waDwv
ZGl2PjxkaXY+PGJyIGNsYXNzPSIiPjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIGNsYXNzPSIiPjxk
aXYgY2xhc3M9IiI+T24gRGVjIDYsIDIwMTksIGF0IDQ6MjIgQU0sIFBhb2xvIEFiZW5pICZsdDs8
YSBocmVmPSJtYWlsdG86cGFiZW5pQHJlZGhhdC5jb20iIGNsYXNzPSIiPnBhYmVuaUByZWRoYXQu
Y29tPC9hPiZndDsgd3JvdGU6PC9kaXY+PGJyIGNsYXNzPSJBcHBsZS1pbnRlcmNoYW5nZS1uZXds
aW5lIj48ZGl2IGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+Tm8gbG9uZ2VyIHJlcXVpcmVkLCBqdXN0
IGRvY3VtZW50IHRoZSB1bmxvY2tlZCBhY2Nlc3Mgd2l0aCBXUklURV9PTkNFKCk8YnIgY2xhc3M9
IiI+U2luY2Ugd2Ugbm93IGFsd2F5cyBhY3F1aXJlIG1zayAtJmd0OyBzc2sgbG9jayBpbiBvcmRl
ciwgd2UgY2FuIGFsc288YnIgY2xhc3M9IiI+YXZvaWQgdGhlIG1zayBsb2NrL3N1YmZsb3cgbG9v
a3VwKCkvZ2V0KCkvIG1zayB1bmxvY2soKS8gc3ViZmxvdyBvcC8gc3ViZmxvdyBwdXQ8YnIgY2xh
c3M9IiI+ZGFuY2UgaW4gbW9zdCBvcHMgLSBzaW1wbHkga2VlcCB0aGUgbXNrIGxvY2sgaGVsZCB0
aGUgd2hvbGUgdGltZS48YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPlNpZ25lZC1vZmYtYnk6IFBh
b2xvIEFiZW5pICZsdDs8YSBocmVmPSJtYWlsdG86cGFiZW5pQHJlZGhhdC5jb20iIGNsYXNzPSIi
PnBhYmVuaUByZWRoYXQuY29tPC9hPiZndDs8YnIgY2xhc3M9IiI+LS0tPGJyIGNsYXNzPSIiPiBu
ZXQvbXB0Y3AvcHJvdG9jb2wuYyB8IDE4MSArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tPGJyIGNsYXNzPSIiPiAxIGZpbGUgY2hhbmdlZCwgNzUgaW5zZXJ0aW9ucygr
KSwgMTA2IGRlbGV0aW9ucygtKTxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+ZGlmZiAtLWdpdCBh
L25ldC9tcHRjcC9wcm90b2NvbC5jIGIvbmV0L21wdGNwL3Byb3RvY29sLmM8YnIgY2xhc3M9IiI+
aW5kZXggNmVjNGFlZDAzMzhlLi5jOWE3Mjk2NDNjMGIgMTAwNjQ0PGJyIGNsYXNzPSIiPi0tLSBh
L25ldC9tcHRjcC9wcm90b2NvbC5jPGJyIGNsYXNzPSIiPisrKyBiL25ldC9tcHRjcC9wcm90b2Nv
bC5jPGJyIGNsYXNzPSIiPkBAIC01NSwxMCArNTUsMTAgQEAgc3RhdGljIHN0cnVjdCBzb2NrZXQg
Kl9fbXB0Y3BfZmlyc3Rfc29ja2V0KGNvbnN0IHN0cnVjdCBtcHRjcF9zb2NrICptc2spPGJyIGNs
YXNzPSIiPiB9PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj4gLyogaWYgbXNrIGhhcyBhIHNpbmds
ZSBzdWJmbG93LCBhbmQgdGhlIG1wX2NhcGFibGUgaGFuZHNoYWtlIGlzIGZhaWxlZCw8YnIgY2xh
c3M9IiI+LSAqIGdldCBhIHJlZmVyZW5jZSBhbmQgcmV0dXJuIGl0LjxiciBjbGFzcz0iIj4rICog
cmV0dXJuIGl0LjxiciBjbGFzcz0iIj4gJm5ic3A7KiBPdGhlcndpc2UgcmV0dXJucyBOVUxMPGJy
IGNsYXNzPSIiPiAmbmJzcDsqLzxiciBjbGFzcz0iIj4tc3RhdGljIHN0cnVjdCBzb2NrZXQgKl9f
bXB0Y3BfdGNwX2ZhbGxiYWNrX2dldChjb25zdCBzdHJ1Y3QgbXB0Y3Bfc29jayAqbXNrKTxiciBj
bGFzcz0iIj4rc3RhdGljIHN0cnVjdCBzb2NrZXQgKl9fbXB0Y3BfdGNwX2ZhbGxiYWNrKGNvbnN0
IHN0cnVjdCBtcHRjcF9zb2NrICptc2spPGJyIGNsYXNzPSIiPiB7PGJyIGNsYXNzPSIiPiA8c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
c3RydWN0IHNvY2tldCAqc3NvY2s7PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj5AQCAtNjksNyAr
NjksNiBAQCBzdGF0aWMgc3RydWN0IHNvY2tldCAqX19tcHRjcF90Y3BfZmFsbGJhY2tfZ2V0KGNv
bnN0IHN0cnVjdCBtcHRjcF9zb2NrICptc2spPGJyIGNsYXNzPSIiPiA8c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYgKHRjcF9zayhz
c29jay0mZ3Q7c2spLSZndDtpc19tcHRjcCk8YnIgY2xhc3M9IiI+IDxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cmV0dXJuIE5V
TEw7PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj4tPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnNvY2tfaG9sZChzc29jay0mZ3Q7c2sp
OzxiciBjbGFzcz0iIj4gPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPnJldHVybiBzc29jazs8YnIgY2xhc3M9IiI+IH08YnIgY2xhc3M9
IiI+PGJyIGNsYXNzPSIiPkBAIC05MywyOCArOTIsMjMgQEAgc3RhdGljIGJvb2wgX19tcHRjcF9j
YW5fY3JlYXRlX3N1YmZsb3coY29uc3Qgc3RydWN0IG1wdGNwX3NvY2sgKm1zayk8YnIgY2xhc3M9
IiI+IDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj5yZXR1cm4gc3RhdGUgPT0gVENQX0NMT1NFIHx8IHN0YXRlID09IFRDUF9MSVNURU47
PGJyIGNsYXNzPSIiPiB9PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj4tc3RhdGljIHN0cnVjdCBz
b2NrZXQgKm1wdGNwX3NvY2tldF9jcmVhdGVfZ2V0KHN0cnVjdCBtcHRjcF9zb2NrICptc2ssIGlu
dCBzdGF0ZSk8YnIgY2xhc3M9IiI+K3N0YXRpYyBzdHJ1Y3Qgc29ja2V0ICpfX21wdGNwX3NvY2tl
dF9jcmVhdGUoc3RydWN0IG1wdGNwX3NvY2sgKm1zaywgaW50IHN0YXRlKTxiciBjbGFzcz0iIj4g
ezxiciBjbGFzcz0iIj4gPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPnN0cnVjdCBtcHRjcF9zdWJmbG93X2NvbnRleHQgKnN1YmZsb3c7
PGJyIGNsYXNzPSIiPiA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+c3RydWN0IHNvY2sgKnNrID0gKHN0cnVjdCBzb2NrICopbXNrOzxi
ciBjbGFzcz0iIj4gPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPnN0cnVjdCBzb2NrZXQgKnNzb2NrOzxiciBjbGFzcz0iIj4gPHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlu
dCBlcnI7PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj4tPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmxvY2tfc29jayhzayk7PGJyIGNs
YXNzPSIiPiA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+c3NvY2sgPSBfX21wdGNwX25tcGNfc29ja2V0KG1zayk7PGJyIGNsYXNzPSIi
PiA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+aWYgKHNzb2NrKTxiciBjbGFzcz0iIj4gPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5nb3RvIHNldF9zdGF0ZTs8YnIg
Y2xhc3M9IiI+PGJyIGNsYXNzPSIiPi08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYgKCFfX21wdGNwX2Nhbl9jcmVhdGVfc3ViZmxv
dyhtc2spKSB7PGJyIGNsYXNzPSIiPi08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnNzb2NrID0gRVJSX1BUUigtRUlOVkFMKTs8
YnIgY2xhc3M9IiI+LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+Z290byByZWxlYXNlOzxiciBjbGFzcz0iIj4tPHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPn08YnIg
Y2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj5pZiAoIV9fbXB0Y3BfY2FuX2NyZWF0ZV9zdWJmbG93KG1zaykpPGJyIGNs
YXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPnJldHVybiBFUlJfUFRSKC1FSU5WQUwpOzxiciBjbGFzcz0iIj48YnIg
Y2xhc3M9IiI+IDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj5lcnIgPSBtcHRjcF9zdWJmbG93X2NyZWF0ZV9zb2NrZXQoc2ssICZhbXA7
c3NvY2spOzxiciBjbGFzcz0iIj4tPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmIChlcnIpIHs8YnIgY2xhc3M9IiI+LTxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
c3NvY2sgPSBFUlJfUFRSKGVycik7PGJyIGNsYXNzPSIiPi08c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmdvdG8gcmVsZWFzZTs8
YnIgY2xhc3M9IiI+LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj59PGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYgKGVycik8YnIgY2xhc3M9IiI+
KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+cmV0dXJuIEVSUl9QVFIoZXJyKTs8YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPiA8
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+c3ViZmxvdyA9IG1wdGNwX3N1YmZsb3dfY3R4KHNzb2NrLSZndDtzayk7PGJyIGNsYXNzPSIi
PiA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+bGlzdF9hZGQoJmFtcDtzdWJmbG93LSZndDtub2RlLCAmYW1wO21zay0mZ3Q7Y29ubl9s
aXN0KTs8YnIgY2xhc3M9IiI+QEAgLTEyMiwxMiArMTE2LDggQEAgc3RhdGljIHN0cnVjdCBzb2Nr
ZXQgKm1wdGNwX3NvY2tldF9jcmVhdGVfZ2V0KHN0cnVjdCBtcHRjcF9zb2NrICptc2ssIGludCBz
dGF0ZSk8YnIgY2xhc3M9IiI+IDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5zdWJmbG93LSZndDtyZXF1ZXN0X3ZlcnNpb24gPSAxOyAv
KiBvbmx5IHYxIHN1cHBvcnRlZCAqLzxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+IHNldF9zdGF0
ZTo8YnIgY2xhc3M9IiI+LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj5zb2NrX2hvbGQoc3NvY2stJmd0O3NrKTs8YnIgY2xhc3M9IiI+
IDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj5pZiAoc3RhdGUgIT0gVENQX01BWF9TVEFURVMpPGJyIGNsYXNzPSIiPiA8c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlu
ZXRfc2tfc3RhdGVfc3RvcmUoc2ssIHN0YXRlKTs8YnIgY2xhc3M9IiI+LTxiciBjbGFzcz0iIj4t
cmVsZWFzZTo8YnIgY2xhc3M9IiI+LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5yZWxlYXNlX3NvY2soc2spOzxiciBjbGFzcz0iIj4g
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPnJldHVybiBzc29jazs8YnIgY2xhc3M9IiI+IH08YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIi
PkBAIC0yODcsMTIgKzI3NywxMSBAQCBzdGF0aWMgaW50IG1wdGNwX3NlbmRtc2coc3RydWN0IHNv
Y2sgKnNrLCBzdHJ1Y3QgbXNnaGRyICptc2csIHNpemVfdCBsZW4pPGJyIGNsYXNzPSIiPiA8c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPnJldHVybiAtRU9QTk9UU1VQUDs8YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPiA8c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+bG9j
a19zb2NrKHNrKTs8YnIgY2xhc3M9IiI+LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5zc29jayA9IF9fbXB0Y3BfdGNwX2ZhbGxiYWNr
X2dldChtc2spOzxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnNzb2NrID0gX19tcHRjcF90Y3BfZmFsbGJhY2so
bXNrKTs8YnIgY2xhc3M9IiI+IDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pZiAoc3NvY2spIHs8YnIgY2xhc3M9IiI+LTxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
cmVsZWFzZV9zb2NrKHNrKTs8YnIgY2xhc3M9IiI+IDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cHJfZGVidWcoImZhbGxiYWNr
IHBhc3N0aHJvdWdoIik7PGJyIGNsYXNzPSIiPiA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnJldCA9IHNvY2tfc2VuZG1zZyhz
c29jaywgbXNnKTs8YnIgY2xhc3M9IiI+LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+c29ja19wdXQoc3NvY2stJmd0O3NrKTs8
YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cmVsZWFzZV9zb2NrKHNrKTs8YnIgY2xhc3M9IiI+IDxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+cmV0dXJuIHJldDs8YnIgY2xhc3M9IiI+IDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj59PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0i
Ij5AQCAtMzk0LDEzICszODMsMTIgQEAgc3RhdGljIGludCBtcHRjcF9yZWN2bXNnKHN0cnVjdCBz
b2NrICpzaywgc3RydWN0IG1zZ2hkciAqbXNnLCBzaXplX3QgbGVuLDxiciBjbGFzcz0iIj4gPHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PmxvbmcgdGltZW87PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj4gPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmxvY2tfc29jayhzayk7
PGJyIGNsYXNzPSIiPi08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+c3NvY2sgPSBfX21wdGNwX3RjcF9mYWxsYmFja19nZXQobXNrKTs8
YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj5zc29jayA9IF9fbXB0Y3BfdGNwX2ZhbGxiYWNrKG1zayk7PGJyIGNs
YXNzPSIiPiA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+aWYgKHNzb2NrKSB7PGJyIGNsYXNzPSIiPi08c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnJlbGVhc2Vfc29j
ayhzayk7PGJyIGNsYXNzPSIiPiA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnByX2RlYnVnKCJmYWxsYmFjay1yZWFkIHN1YmZs
b3c9JXAiLDxiciBjbGFzcz0iIj4gPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+IG1wdGNwX3N1YmZsb3dfY3R4KHNzb2Nr
LSZndDtzaykpOzxiciBjbGFzcz0iIj4gPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5jb3BpZWQgPSBzb2NrX3JlY3Ztc2coc3Nv
Y2ssIG1zZywgZmxhZ3MpOzxiciBjbGFzcz0iIj4tPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5zb2NrX3B1dChzc29jay0mZ3Q7
c2spOzxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5yZWxlYXNlX3NvY2soc2spOzxiciBjbGFzcz0iIj4g
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj5yZXR1cm4gY29waWVkOzxiciBjbGFzcz0iIj4gPHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPn08YnIgY2xhc3M9IiI+PGJy
IGNsYXNzPSIiPkBAIC02NDUsMjUgKzYzMywyNiBAQCBzdGF0aWMgaW50IG1wdGNwX3NldHNvY2tv
cHQoc3RydWN0IHNvY2sgKnNrLCBpbnQgbGV2ZWwsIGludCBvcHRuYW1lLDxiciBjbGFzcz0iIj4g
ezxiciBjbGFzcz0iIj4gPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPnN0cnVjdCBtcHRjcF9zb2NrICptc2sgPSBtcHRjcF9zayhzayk7
PGJyIGNsYXNzPSIiPiA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+Y2hhciBfX2tlcm5lbCAqb3B0dmFsOzxiciBjbGFzcz0iIj4rPHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PmludCByZXQgPSAtRU9QTk9UU1VQUDs8YnIgY2xhc3M9IiI+IDxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5zdHJ1Y3Qgc29ja2V0ICpz
c29jazs8YnIgY2xhc3M9IiI+LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pbnQgcmV0OzxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+
IDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj4vKiB3aWxsIGJlIHRyZWF0ZWQgYXMgX191c2VyIGluIHRjcF9zZXRzb2Nrb3B0ICovPGJy
IGNsYXNzPSIiPiA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+b3B0dmFsID0gKGNoYXIgX19rZXJuZWwgX19mb3JjZSAqKXVvcHR2YWw7
PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj4gPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnByX2RlYnVnKCJtc2s9JXAiLCBtc2spOzxi
ciBjbGFzcz0iIj4tPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPnNzb2NrID0gbXB0Y3Bfc29ja2V0X2NyZWF0ZV9nZXQobXNrLCBUQ1Bf
TUFYX1NUQVRFUyk7PGJyIGNsYXNzPSIiPis8YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4vKiBAQCB0aGUgbWVh
bmluZyBvZiBzZXRzb2Nrb3B0KCkgd2hlbiB0aGUgc29ja2V0IGlzIGNvbm5lY3RlZCBhbmQ8YnIg
Y2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj4gKiB0aGVyZSBhcmUgbXVsdGlwbGUgc3ViZmxvd3MgaXMgbm90IGRlZmlu
ZWQuPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+ICovPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+bG9ja19zb2NrKHNrKTs8
YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj5zc29jayA9IF9fbXB0Y3Bfc29ja2V0X2NyZWF0ZShtc2ssIFRDUF9N
QVhfU1RBVEVTKTs8YnIgY2xhc3M9IiI+IDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pZiAoIUlTX0VSUihzc29jaykpIHs8YnIgY2xh
c3M9IiI+IDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+cHJfZGVidWcoInN1YmZsb3c9JXAiLCBzc29jay0mZ3Q7c2spOzxiciBj
bGFzcz0iIj4gPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj5yZXQgPSBrZXJuZWxfc2V0c29ja29wdChzc29jaywgbGV2ZWwsIG9w
dG5hbWUsIG9wdHZhbCwgb3B0bGVuKTs8YnIgY2xhc3M9IiI+LTxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+c29ja19wdXQoc3Nv
Y2stJmd0O3NrKTs8YnIgY2xhc3M9IiI+LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cmV0dXJuIHJldDs8YnIgY2xhc3M9IiI+
IDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj59PGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cmVsZWFzZV9zb2NrKHNrKTs8YnIgY2xhc3M9IiI+PGJy
IGNsYXNzPSIiPi08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+LyogQEAgdGhlIG1lYW5pbmcgb2Ygc2V0c29ja29wdCgpIHdoZW4gdGhl
IHNvY2tldCBpcyBjb25uZWN0ZWQgYW5kPGJyIGNsYXNzPSIiPi08c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+ICogdGhlcmUgYXJlIG11
bHRpcGxlIHN1YmZsb3dzIGlzIG5vdCBkZWZpbmVkLjxiciBjbGFzcz0iIj4tPHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPiAqLzxiciBj
bGFzcz0iIj4tPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPnJldHVybiAtRU9QTk9UU1VQUDs8YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5yZXR1cm4g
cmV0OzxiciBjbGFzcz0iIj4gfTxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+IHN0YXRpYyBpbnQg
bXB0Y3BfZ2V0c29ja29wdChzdHJ1Y3Qgc29jayAqc2ssIGludCBsZXZlbCwgaW50IG9wdG5hbWUs
PGJyIGNsYXNzPSIiPkBAIC02NzEsMjcgKzY2MCwyOCBAQCBzdGF0aWMgaW50IG1wdGNwX2dldHNv
Y2tvcHQoc3RydWN0IHNvY2sgKnNrLCBpbnQgbGV2ZWwsIGludCBvcHRuYW1lLDxiciBjbGFzcz0i
Ij4gezxiciBjbGFzcz0iIj4gPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPnN0cnVjdCBtcHRjcF9zb2NrICptc2sgPSBtcHRjcF9zayhz
ayk7PGJyIGNsYXNzPSIiPiA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+Y2hhciBfX2tlcm5lbCAqb3B0dmFsOzxiciBjbGFzcz0iIj4r
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPmludCByZXQgPSAtRU9QTk9UU1VQUDs8YnIgY2xhc3M9IiI+IDxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pbnQgX19rZXJuZWwg
Km9wdGlvbjs8YnIgY2xhc3M9IiI+IDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5zdHJ1Y3Qgc29ja2V0ICpzc29jazs8YnIgY2xhc3M9
IiI+LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj5pbnQgcmV0OzxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+IDxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4vKiB3aWxsIGJl
IHRyZWF0ZWQgYXMgX191c2VyIGluIHRjcF9nZXRzb2Nrb3B0ICovPGJyIGNsYXNzPSIiPiA8c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
b3B0dmFsID0gKGNoYXIgX19rZXJuZWwgX19mb3JjZSAqKXVvcHR2YWw7PGJyIGNsYXNzPSIiPiA8
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+b3B0aW9uID0gKGludCBfX2tlcm5lbCBfX2ZvcmNlICopdW9wdGlvbjs8YnIgY2xhc3M9IiI+
PGJyIGNsYXNzPSIiPiA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+cHJfZGVidWcoIm1zaz0lcCIsIG1zayk7PGJyIGNsYXNzPSIiPi08
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+c3NvY2sgPSBtcHRjcF9zb2NrZXRfY3JlYXRlX2dldChtc2ssIFRDUF9NQVhfU1RBVEVTKTs8
YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj5sb2NrX3NvY2soc2spOzxiciBjbGFzcz0iIj4rPGJyIGNsYXNzPSIi
Pis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+LyogQEAgdGhlIG1lYW5pbmcgb2YgZ2V0c29ja29wdCgpIHdoZW4gdGhlIHNvY2tldCBp
cyBjb25uZWN0ZWQgYW5kPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+ICogdGhlcmUgYXJlIG11bHRpcGxlIHN1
YmZsb3dzIGlzIG5vdCBkZWZpbmVkLjxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPiAqLzxiciBjbGFzcz0iIj4r
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPnNzb2NrID0gX19tcHRjcF9zb2NrZXRfY3JlYXRlKG1zaywgVENQX01BWF9TVEFURVMpOzxi
ciBjbGFzcz0iIj4gPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPmlmICghSVNfRVJSKHNzb2NrKSkgezxiciBjbGFzcz0iIj4gPHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj5wcl9kZWJ1Zygic3ViZmxvdz0lcCIsIHNzb2NrLSZndDtzayk7PGJyIGNsYXNzPSIiPiA8c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPnJldCA9IGtlcm5lbF9nZXRzb2Nrb3B0KHNzb2NrLCBsZXZlbCwgb3B0bmFtZSwgb3B0dmFs
LCBvcHRpb24pOzxiciBjbGFzcz0iIj4tPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5zb2NrX3B1dChzc29jay0mZ3Q7c2spOzxi
ciBjbGFzcz0iIj4tPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj5yZXR1cm4gcmV0OzxiciBjbGFzcz0iIj4gPHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPn08YnIgY2xh
c3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj5yZWxlYXNlX3NvY2soc2spOzxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+LTxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj4vKiBAQCB0aGUgbWVhbmluZyBvZiBnZXRzb2Nrb3B0KCkgd2hlbiB0aGUgc29ja2V0IGlzIGNv
bm5lY3RlZCBhbmQ8YnIgY2xhc3M9IiI+LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4gKiB0aGVyZSBhcmUgbXVsdGlwbGUgc3ViZmxv
d3MgaXMgbm90IGRlZmluZWQuPGJyIGNsYXNzPSIiPi08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+ICovPGJyIGNsYXNzPSIiPi08c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
cmV0dXJuIC1FT1BOT1RTVVBQOzxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnJldHVybiByZXQ7PGJyIGNsYXNz
PSIiPiB9PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj4gc3RhdGljIGludCBtcHRjcF9nZXRfcG9y
dChzdHJ1Y3Qgc29jayAqc2ssIHVuc2lnbmVkIHNob3J0IHNudW0pPGJyIGNsYXNzPSIiPkBAIC03
MTEsNTEgKzcwMSwyNyBAQCB2b2lkIG1wdGNwX2ZpbmlzaF9jb25uZWN0KHN0cnVjdCBzb2NrICpz
ayw8YnIgY2xhc3M9IiI+IDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPiAmbmJzcDtzdHJ1Y3QgbXB0Y3Bfc3ViZmxvd19j
b250ZXh0ICpzdWJmbG93KTxiciBjbGFzcz0iIj4gezxiciBjbGFzcz0iIj4gPHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnN0cnVjdCBt
cHRjcF9zb2NrICptc2sgPSBtcHRjcF9zayhzayk7PGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+dTY0IGFja19z
ZXE7PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj4tPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmIChzdWJmbG93LSZndDttcF9jYXBh
YmxlKSB7PGJyIGNsYXNzPSIiPi08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnU2NCBhY2tfc2VxOzxiciBjbGFzcz0iIj4rPHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PmlmICghc3ViZmxvdy0mZ3Q7bXBfY2FwYWJsZSk8YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cmV0dXJu
OzxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+Lyogc2sgKG5ldyBzdWJmbG93IHNv
Y2tldCkgaXMgYWxyZWFkeSBsb2NrZWQsIGJ1dCB3ZSBuZWVkPGJyIGNsYXNzPSIiPi08c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PiAqIHRvIGxvY2sgdGhlIHBhcmVudCAobXB0Y3ApIHNvY2tldCBub3cgdG8gYWRkIHRoZSB0Y3Ag
c29ja2V0PGJyIGNsYXNzPSIiPi08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPiAqIHRvIHRoZSBzdWJmbG93IGxpc3QuPGJyIGNs
YXNzPSIiPi08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPiAqPGJyIGNsYXNzPSIiPi08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPiAqIEZyb20gbG9ja2RlcCBw
b2ludCBvZiB2aWV3LCB0aGlzIGNyZWF0ZXMgYW4gQUJCQSB0eXBlPGJyIGNsYXNzPSIiPi08c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPiAqIGRlYWRsb2NrOiBOb3JtYWxseSAoc2VuZG1zZywgcmVjdm1zZywgLi4pLCB3ZSBsb2Nr
IHRoZSBtcHRjcDxiciBjbGFzcz0iIj4tPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4gKiBzb2NrZXQsIHRoZW4gYWNxdWlyZSBh
IHN1YmZsb3cgbG9jay48YnIgY2xhc3M9IiI+LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+ICogSGVyZSB3ZSBkbyB0aGUgcmV2
ZXJzZTogInN1YmZsb3cgbG9jaywgdGhlbiBtcHRjcCBsb2NrIi48YnIgY2xhc3M9IiI+LTxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+ICo8YnIgY2xhc3M9IiI+LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+ICogSXRzIGFscmlnaHQgdG8gZG8gdGhpcyBoZXJl
LCBiZWNhdXNlIHRoaXMgc3ViZmxvdyBpcyBub3QgeWV0PGJyIGNsYXNzPSIiPi08c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPiAq
IG9uIHRoZSBtcHRjcCBzb2NrZXRzIHN1YmZsb3cgbGlzdC48YnIgY2xhc3M9IiI+LTxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
ICo8YnIgY2xhc3M9IiI+LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+ICogSU9XLCBpZiBhbm90aGVyIENQVSBoYXMgdGhpcyBt
cHRjcCBzb2NrZXQgbG9ja2VkLCBpdCBjYW5ub3Q8YnIgY2xhc3M9IiI+LTxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+ICogYWNx
dWlyZSB0aGlzIHBhcnRpY3VsYXIgc3ViZmxvdywgYmVjYXVzZSBzdWJmbG93LSZndDtzayBpc24n
dDxiciBjbGFzcz0iIj4tPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4gKiBvbiBtc2stJmd0O2Nvbm5fbGlzdC48YnIgY2xhc3M9
IiI+LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+ICo8YnIgY2xhc3M9IiI+LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+ICogVGhpcyBmdW5jdGlvbiBjYW4g
YmUgY2FsbGVkIGVpdGhlciBmcm9tIGJhY2tsb2cgcHJvY2Vzc2luZzxiciBjbGFzcz0iIj4tPHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj4gKiAoQkggd2lsbCBiZSBlbmFibGVkKSBvciBmcm9tIHNvZnRpcnEsIHNvIHdlIG5lZWQg
dG8gdXNlIEJIPGJyIGNsYXNzPSIiPi08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPiAqIGxvY2tpbmcgc2NoZW1lLjxiciBjbGFz
cz0iIj4tPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj4gKi88YnIgY2xhc3M9IiI+LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+bG9jYWxfYmhfZGlzYWJsZSgp
OzxiciBjbGFzcz0iIj4tPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5iaF9sb2NrX3NvY2tfbmVzdGVkKHNrKTs8YnIgY2xhc3M9
IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj5wcl9kZWJ1ZygibXNrPSVwLCB0b2tlbj0ldSIsIG1zaywgc3ViZmxvdy0mZ3Q7dG9r
ZW4pOzxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPm1wdGNwX2NyeXB0b19rZXlfc2hhKHN1YmZsb3ctJmd0O3Jl
bW90ZV9rZXksIE5VTEwsICZhbXA7YWNrX3NlcSk7PGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+YWNrX3NlcSsr
OzxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPnN1YmZsb3ctJmd0O21hcF9zZXEgPSBhY2tfc2VxOzxiciBjbGFz
cz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPnN1YmZsb3ctJmd0O21hcF9zdWJmbG93X3NlcSA9IDE7PGJyIGNsYXNzPSIiPis8
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+c3ViZmxvdy0mZ3Q7cmVsX3dyaXRlX3NlcSA9IDE7PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0i
Ij4tPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj5tc2stJmd0O3JlbW90ZV9rZXkgPSBzdWJmbG93LSZndDtyZW1vdGVfa2V5Ozxi
ciBjbGFzcz0iIj4tPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj5tc2stJmd0O2xvY2FsX2tleSA9IHN1YmZsb3ctJmd0O2xvY2Fs
X2tleTs8YnIgY2xhc3M9IiI+LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+bXNrLSZndDt0b2tlbiA9IHN1YmZsb3ctJmd0O3Rv
a2VuOzxiciBjbGFzcz0iIj4tPGJyIGNsYXNzPSIiPi08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnByX2RlYnVnKCJtc2s9JXAs
IHRva2VuPSV1IiwgbXNrLCBtc2stJmd0O3Rva2VuKTs8YnIgY2xhc3M9IiI+LTxiciBjbGFzcz0i
Ij4tPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj5tcHRjcF9jcnlwdG9fa2V5X3NoYShtc2stJmd0O3JlbW90ZV9rZXksIE5VTEws
ICZhbXA7YWNrX3NlcSk7PGJyIGNsYXNzPSIiPi08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPm1zay0mZ3Q7d3JpdGVfc2VxID0g
c3ViZmxvdy0mZ3Q7aWRzbiArIDE7PGJyIGNsYXNzPSIiPi08c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmFja19zZXErKzs8YnIg
Y2xhc3M9IiI+LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+bXNrLSZndDthY2tfc2VxID0gYWNrX3NlcTs8YnIgY2xhc3M9IiI+
LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+bXNrLSZndDtjYW5fYWNrID0gMTs8YnIgY2xhc3M9IiI+LTxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+c3ViZmxv
dy0mZ3Q7bWFwX3NlcSA9IGFja19zZXE7PGJyIGNsYXNzPSIiPi08c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnN1YmZsb3ctJmd0
O21hcF9zdWJmbG93X3NlcSA9IDE7PGJyIGNsYXNzPSIiPi08c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnN1YmZsb3ctJmd0O3Jl
bF93cml0ZV9zZXEgPSAxOzxiciBjbGFzcz0iIj4tPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5iaF91bmxvY2tfc29jayhzayk7
PGJyIGNsYXNzPSIiPi08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPmxvY2FsX2JoX2VuYWJsZSgpOzxiciBjbGFzcz0iIj4tPHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
Pn08YnIgY2xhc3M9IiI+LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj5pbmV0X3NrX3N0YXRlX3N0b3JlKHNrLCBUQ1BfRVNUQUJMSVNI
RUQpOzxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPi8qIHRoZSBzb2NrZXQgaXMgbm90IGNvbm5lY3RlZCB5ZXQs
IG5vIG1zay9zdWJmbG93IG9wcyBjYW4gYWNjZXNzL3JhY2U8YnIgY2xhc3M9IiI+KzxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4gKiBh
Y2Nlc3NpbmcgdGhlIGZpZWxkIGJlbG93PGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+ICovPGJyIGNsYXNzPSIi
Pis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+V1JJVEVfT05DRShtc2stJmd0O3JlbW90ZV9rZXksIHN1YmZsb3ctJmd0O3JlbW90ZV9r
ZXkpOzxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPldSSVRFX09OQ0UobXNrLSZndDtsb2NhbF9rZXksIHN1YmZs
b3ctJmd0O2xvY2FsX2tleSk7PGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+V1JJVEVfT05DRShtc2stJmd0O3Rv
a2VuLCBzdWJmbG93LSZndDt0b2tlbik7PGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+V1JJVEVfT05DRShtc2st
Jmd0O3dyaXRlX3NlcSwgc3ViZmxvdy0mZ3Q7aWRzbiArIDEpOzxiciBjbGFzcz0iIj4rPHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPldS
SVRFX09OQ0UobXNrLSZndDthY2tfc2VxLCBhY2tfc2VxKTs8YnIgY2xhc3M9IiI+KzxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5XUklU
RV9PTkNFKG1zay0mZ3Q7Y2FuX2FjaywgMSk7PGJyIGNsYXNzPSIiPiB9PGJyIGNsYXNzPSIiPjxi
ciBjbGFzcz0iIj4gc3RhdGljIHN0cnVjdCBwcm90byBtcHRjcF9wcm90ID0gezxiciBjbGFzcz0i
Ij5AQCAtNzgzLDEyICs3NDksMTcgQEAgc3RhdGljIGludCBtcHRjcF9iaW5kKHN0cnVjdCBzb2Nr
ZXQgKnNvY2ssIHN0cnVjdCBzb2NrYWRkciAqdWFkZHIsIGludCBhZGRyX2xlbik8YnIgY2xhc3M9
IiI+IDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj5zdHJ1Y3Qgc29ja2V0ICpzc29jazs8YnIgY2xhc3M9IiI+IDxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pbnQgZXJyOzxi
ciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5zc29jayA9IG1wdGNwX3NvY2tldF9jcmVhdGVf
Z2V0KG1zaywgVENQX01BWF9TVEFURVMpOzxiciBjbGFzcz0iIj4tPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmIChJU19FUlIoc3Nv
Y2spKTxiciBjbGFzcz0iIj4tPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5yZXR1cm4gUFRSX0VSUihzc29jayk7PGJyIGNsYXNz
PSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+bG9ja19zb2NrKHNvY2stJmd0O3NrKTs8YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5zc29jayA9
IF9fbXB0Y3Bfc29ja2V0X2NyZWF0ZShtc2ssIFRDUF9NQVhfU1RBVEVTKTs8YnIgY2xhc3M9IiI+
KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj5pZiAoSVNfRVJSKHNzb2NrKSkgezxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5lcnIgPSBQVFJf
RVJSKHNzb2NrKTs8YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+Z290byB1bmxvY2s7PGJyIGNsYXNzPSIi
Pis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+fTxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+IDxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5lcnIgPSBzc29jay0mZ3Q7b3Bz
LSZndDtiaW5kKHNzb2NrLCB1YWRkciwgYWRkcl9sZW4pOzxiciBjbGFzcz0iIj4tPHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnNvY2tf
cHV0KHNzb2NrLSZndDtzayk7PGJyIGNsYXNzPSIiPis8YnIgY2xhc3M9IiI+K3VubG9jazo8YnIg
Y2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj5yZWxlYXNlX3NvY2soc29jay0mZ3Q7c2spOzxiciBjbGFzcz0iIj4gPHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PnJldHVybiBlcnI7PGJyIGNsYXNzPSIiPiB9PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj5AQCAt
Nzk5LDkgKzc3MCwxMiBAQCBzdGF0aWMgaW50IG1wdGNwX3N0cmVhbV9jb25uZWN0KHN0cnVjdCBz
b2NrZXQgKnNvY2ssIHN0cnVjdCBzb2NrYWRkciAqdWFkZHIsPGJyIGNsYXNzPSIiPiA8c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+c3Ry
dWN0IHNvY2tldCAqc3NvY2s7PGJyIGNsYXNzPSIiPiA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aW50IGVycjs8YnIgY2xhc3M9IiI+
PGJyIGNsYXNzPSIiPi08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+c3NvY2sgPSBtcHRjcF9zb2NrZXRfY3JlYXRlX2dldChtc2ssIFRD
UF9TWU5fU0VOVCk7PGJyIGNsYXNzPSIiPi08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYgKElTX0VSUihzc29jaykpPGJyIGNsYXNz
PSIiPi08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPnJldHVybiBQVFJfRVJSKHNzb2NrKTs8YnIgY2xhc3M9IiI+KzxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5sb2Nr
X3NvY2soc29jay0mZ3Q7c2spOzxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnNzb2NrID0gX19tcHRjcF9zb2Nr
ZXRfY3JlYXRlKG1zaywgVENQX1NZTl9TRU5UKTs8YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pZiAoSVNfRVJS
KHNzb2NrKSkgezxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5lcnIgPSBQVFJfRVJSKHNzb2NrKTs8YnIg
Y2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+Z290byB1bmxvY2s7PGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+fTxiciBjbGFz
cz0iIj48YnIgY2xhc3M9IiI+ICNpZmRlZiBDT05GSUdfVENQX01ENVNJRzxiciBjbGFzcz0iIj4g
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPi8qIG5vIE1QVENQIGlmIE1ENVNJRyBpcyBlbmFibGVkIG9uIHRoaXMgc29ja2V0IG9yIHdl
IG1heSBydW4gb3V0IG9mPGJyIGNsYXNzPSIiPkBAIC04MTYsNyArNzkwLDkgQEAgc3RhdGljIGlu
dCBtcHRjcF9zdHJlYW1fY29ubmVjdChzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2Fk
ZHIgKnVhZGRyLDxiciBjbGFzcz0iIj4gPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPi8qIHNob3VsZCB3ZSBrZWVwIG1zayBzb2NrZXQg
bG9jayBpbnN0ZWFkPyBhbmQgcmVsZWFzZSBpdCB0aGlzPGJyIGNsYXNzPSIiPiA8c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+ICogbGF0
dGVyIHN0YXRlIHVwZGF0ZSAqLzxiciBjbGFzcz0iIj4gPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmluZXRfc2tfc3RhdGVfc3RvcmUo
c29jay0mZ3Q7c2ssIGluZXRfc2tfc3RhdGVfbG9hZChzc29jay0mZ3Q7c2spKTs8YnIgY2xhc3M9
IiI+LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj5zb2NrX3B1dChzc29jay0mZ3Q7c2spOzxiciBjbGFzcz0iIj4rPGJyIGNsYXNzPSIi
Pit1bmxvY2s6PGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cmVsZWFzZV9zb2NrKHNvY2stJmd0O3NrKTs8YnIg
Y2xhc3M9IiI+IDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj5yZXR1cm4gZXJyOzxiciBjbGFzcz0iIj4gfTxiciBjbGFzcz0iIj48YnIg
Y2xhc3M9IiI+QEAgLTg5NywxNiArODczLDIxIEBAIHN0YXRpYyBpbnQgbXB0Y3BfbGlzdGVuKHN0
cnVjdCBzb2NrZXQgKnNvY2ssIGludCBiYWNrbG9nKTxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+
IDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj5wcl9kZWJ1ZygibXNrPSVwIiwgbXNrKTs8YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPi08
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+c3NvY2sgPSBtcHRjcF9zb2NrZXRfY3JlYXRlX2dldChtc2ssIFRDUF9MSVNURU4pOzxiciBj
bGFzcz0iIj4tPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPmlmIChJU19FUlIoc3NvY2spKTxiciBjbGFzcz0iIj4tPHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5yZXR1
cm4gUFRSX0VSUihzc29jayk7PGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+bG9ja19zb2NrKHNvY2stJmd0O3Nr
KTs8YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj5zc29jayA9IF9fbXB0Y3Bfc29ja2V0X2NyZWF0ZShtc2ssIFRD
UF9MSVNURU4pOzxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmIChJU19FUlIoc3NvY2spKSB7PGJyIGNsYXNz
PSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPmVyciA9IFBUUl9FUlIoc3NvY2spOzxiciBjbGFzcz0iIj4rPHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5n
b3RvIHVubG9jazs8YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj59PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj4g
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPmVyciA9IHNzb2NrLSZndDtvcHMtJmd0O2xpc3Rlbihzc29jaywgYmFja2xvZyk7PGJyIGNs
YXNzPSIiPjxiciBjbGFzcz0iIj4gPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPi8qIHNob3VsZCB3ZSBrZWVwIG1zayBzb2NrZXQgbG9j
ayBpbnN0ZWFkPyBhbmQgcmVsZWFzZSBpdCB0aGlzPGJyIGNsYXNzPSIiPiA8c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+ICogbGF0dGVy
IHN0YXRlIHVwZGF0ZSAqLzxiciBjbGFzcz0iIj4gPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmluZXRfc2tfc3RhdGVfc3RvcmUoc29j
ay0mZ3Q7c2ssIGluZXRfc2tfc3RhdGVfbG9hZChzc29jay0mZ3Q7c2spKTs8YnIgY2xhc3M9IiI+
LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj5zb2NrX3B1dChzc29jay0mZ3Q7c2spOzxiciBjbGFzcz0iIj4rPGJyIGNsYXNzPSIiPit1
bmxvY2s6PGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cmVsZWFzZV9zb2NrKHNvY2stJmd0O3NrKTs8YnIgY2xh
c3M9IiI+IDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj5yZXR1cm4gZXJyOzxiciBjbGFzcz0iIj4gfTxiciBjbGFzcz0iIj48YnIgY2xh
c3M9IiI+QEAgLTk1MiwxMCArOTMzLDggQEAgc3RhdGljIF9fcG9sbF90IG1wdGNwX3BvbGwoc3Ry
dWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBzb2NrZXQgKnNvY2ssPGJyIGNsYXNzPSIiPiA8c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+bG9j
a19zb2NrKHNrKTs8YnIgY2xhc3M9IiI+IDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5zc29jayA9IF9fbXB0Y3Bfbm1wY19zb2NrZXQo
bXNrKTs8YnIgY2xhc3M9IiI+IDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pZiAoc3NvY2spIHs8YnIgY2xhc3M9IiI+LTxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
c29ja19ob2xkKHNzb2NrLSZndDtzayk7PGJyIGNsYXNzPSIiPi08c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnJlbGVhc2Vfc29j
ayhzayk7PGJyIGNsYXNzPSIiPiA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnJldCA9IHNzb2NrLSZndDtvcHMtJmd0O3BvbGwo
ZmlsZSwgc3NvY2ssIHdhaXQpOzxiciBjbGFzcz0iIj4tPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5zb2NrX3B1dChzc29jay0m
Z3Q7c2spOzxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5yZWxlYXNlX3NvY2soc2spOzxiciBjbGFzcz0i
Ij4gPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj5yZXR1cm4gcmV0OzxiciBjbGFzcz0iIj4gPHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPn08YnIgY2xhc3M9IiI+PGJy
IGNsYXNzPSIiPkBAIC05NzgsNyArOTU3LDYgQEAgc3RhdGljIGludCBtcHRjcF9zaHV0ZG93bihz
dHJ1Y3Qgc29ja2V0ICpzb2NrLCBpbnQgaG93KTxiciBjbGFzcz0iIj4gezxiciBjbGFzcz0iIj4g
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPnN0cnVjdCBtcHRjcF9zb2NrICptc2sgPSBtcHRjcF9zayhzb2NrLSZndDtzayk7PGJyIGNs
YXNzPSIiPiA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+c3RydWN0IG1wdGNwX3N1YmZsb3dfY29udGV4dCAqc3ViZmxvdzs8YnIgY2xh
c3M9IiI+LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj5zdHJ1Y3Qgc29ja2V0ICpzc29jazs8YnIgY2xhc3M9IiI+IDxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pbnQgcmV0
ID0gMDs8YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPiA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cHJfZGVidWcoInNrPSVwLCBob3c9
JWQiLCBtc2ssIGhvdyk7PGJyIGNsYXNzPSIiPkBAIC05ODgsMTUgKzk2Niw2IEBAIHN0YXRpYyBp
bnQgbXB0Y3Bfc2h1dGRvd24oc3RydWN0IHNvY2tldCAqc29jaywgaW50IGhvdyk8YnIgY2xhc3M9
IiI+IDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj5pZiAoaG93ID09IFNIVVRfV1IgfHwgaG93ID09IFNIVVRfUkRXUik8YnIgY2xhc3M9
IiI+IDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+aW5ldF9za19zdGF0ZV9zdG9yZShzb2NrLSZndDtzaywgVENQX0ZJTl9XQUlU
MSk7PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj4tPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnNzb2NrID0gX19tcHRjcF90Y3BfZmFs
bGJhY2tfZ2V0KG1zayk7PGJyIGNsYXNzPSIiPi08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYgKHNzb2NrKSB7PGJyIGNsYXNzPSIi
Pi08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPnJlbGVhc2Vfc29jayhzb2NrLSZndDtzayk7PGJyIGNsYXNzPSIiPi08c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PnByX2RlYnVnKCJzdWJmbG93PSVwIiwgc3NvY2stJmd0O3NrKTs8YnIgY2xhc3M9IiI+LTxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+cmV0ID0ga2VybmVsX3NvY2tfc2h1dGRvd24oc3NvY2ssIGhvdyk7PGJyIGNsYXNzPSIiPi08
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPnNvY2tfcHV0KHNzb2NrLSZndDtzayk7PGJyIGNsYXNzPSIiPi08c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnJldHVy
biByZXQ7PGJyIGNsYXNzPSIiPi08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+fTxiciBjbGFzcz0iIj4tPGJyIGNsYXNzPSIiPiA8c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
bXB0Y3BfZm9yX2VhY2hfc3ViZmxvdyhtc2ssIHN1YmZsb3cpIHs8YnIgY2xhc3M9IiI+IDxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+c3RydWN0IHNvY2tldCAqdGNwX3NvY2tldDs8YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPi0t
IDxiciBjbGFzcz0iIj4yLjIxLjA8YnIgY2xhc3M9IiI+X19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX188YnIgY2xhc3M9IiI+bXB0Y3AgbWFpbGluZyBsaXN0IC0t
IDxhIGhyZWY9Im1haWx0bzptcHRjcEBsaXN0cy4wMS5vcmciIGNsYXNzPSIiPm1wdGNwQGxpc3Rz
LjAxLm9yZzwvYT48YnIgY2xhc3M9IiI+VG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byA8
YSBocmVmPSJtYWlsdG86bXB0Y3AtbGVhdmVAbGlzdHMuMDEub3JnIiBjbGFzcz0iIj5tcHRjcC1s
ZWF2ZUBsaXN0cy4wMS5vcmc8L2E+PGJyIGNsYXNzPSIiPjwvZGl2PjwvZGl2PjwvYmxvY2txdW90
ZT48L2Rpdj48YnIgY2xhc3M9IiI+PC9ib2R5PjwvaHRtbD4=
--===============8240163528210998433==--
