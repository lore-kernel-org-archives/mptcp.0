Content-Type: multipart/mixed; boundary="===============2142818296113243077=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v3 1/3] mptcp: move sockopt function into
 a new file
Date: Mon, 08 Mar 2021 17:11:16 -0800
Message-ID: <c4baa824-236a-3122-5643-52ec1f4d5051@linux.intel.com>
In-Reply-To: 52d5d27301add1db21558a61e12a1b166fb8e934.1615197863.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 8079

--===============2142818296113243077==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Mar 2021, Paolo Abeni wrote:

> The MPTCP sockopt implementation is going to be much
> more big and complex soon. Let's move it to a different
> source file.
>
> No functional change intended.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/Makefile   |   2 +-
> net/mptcp/protocol.c | 110 ----------------------------------
> net/mptcp/protocol.h |   5 ++
> net/mptcp/sockopt.c  | 136 +++++++++++++++++++++++++++++++++++++++++++
> 4 files changed, 142 insertions(+), 111 deletions(-)
> create mode 100644 net/mptcp/sockopt.c
>
> diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
> index aae2ede220edc..b3b83ce426777 100644
> --- a/net/mptcp/Makefile
> +++ b/net/mptcp/Makefile
> @@ -2,7 +2,7 @@
> obj-$(CONFIG_MPTCP) +=3D mptcp.o
>
> mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o =
diag.o \
> -	   mib.o pm_netlink.o
> +	   mib.o pm_netlink.o sockopt.o
>
> obj-$(CONFIG_SYN_COOKIES) +=3D syncookies.o
> obj-$(CONFIG_INET_MPTCP_DIAG) +=3D mptcp_diag.o
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d6b3112fac299..48c1ea454cd7d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2819,116 +2819,6 @@ static void mptcp_destroy(struct sock *sk)
> 	sk_sockets_allocated_dec(sk);
> }
>
> -static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optna=
me,
> -				       sockptr_t optval, unsigned int optlen)
> -{
> -	struct sock *sk =3D (struct sock *)msk;
> -	struct socket *ssock;
> -	int ret;
> -
> -	switch (optname) {
> -	case SO_REUSEPORT:
> -	case SO_REUSEADDR:
> -		lock_sock(sk);
> -		ssock =3D __mptcp_nmpc_socket(msk);
> -		if (!ssock) {
> -			release_sock(sk);
> -			return -EINVAL;
> -		}
> -
> -		ret =3D sock_setsockopt(ssock, SOL_SOCKET, optname, optval, optlen);
> -		if (ret =3D=3D 0) {
> -			if (optname =3D=3D SO_REUSEPORT)
> -				sk->sk_reuseport =3D ssock->sk->sk_reuseport;
> -			else if (optname =3D=3D SO_REUSEADDR)
> -				sk->sk_reuse =3D ssock->sk->sk_reuse;
> -		}
> -		release_sock(sk);
> -		return ret;
> -	}
> -
> -	return sock_setsockopt(sk->sk_socket, SOL_SOCKET, optname, optval, optl=
en);
> -}
> -
> -static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
> -			       sockptr_t optval, unsigned int optlen)
> -{
> -	struct sock *sk =3D (struct sock *)msk;
> -	int ret =3D -EOPNOTSUPP;
> -	struct socket *ssock;
> -
> -	switch (optname) {
> -	case IPV6_V6ONLY:
> -		lock_sock(sk);
> -		ssock =3D __mptcp_nmpc_socket(msk);
> -		if (!ssock) {
> -			release_sock(sk);
> -			return -EINVAL;
> -		}
> -
> -		ret =3D tcp_setsockopt(ssock->sk, SOL_IPV6, optname, optval, optlen);
> -		if (ret =3D=3D 0)
> -			sk->sk_ipv6only =3D ssock->sk->sk_ipv6only;
> -
> -		release_sock(sk);
> -		break;
> -	}
> -
> -	return ret;
> -}
> -
> -static int mptcp_setsockopt(struct sock *sk, int level, int optname,
> -			    sockptr_t optval, unsigned int optlen)
> -{
> -	struct mptcp_sock *msk =3D mptcp_sk(sk);
> -	struct sock *ssk;
> -
> -	pr_debug("msk=3D%p", msk);
> -
> -	if (level =3D=3D SOL_SOCKET)
> -		return mptcp_setsockopt_sol_socket(msk, optname, optval, optlen);
> -
> -	/* @@ the meaning of setsockopt() when the socket is connected and
> -	 * there are multiple subflows is not yet defined. It is up to the
> -	 * MPTCP-level socket to configure the subflows until the subflow
> -	 * is in TCP fallback, when TCP socket options are passed through
> -	 * to the one remaining subflow.
> -	 */
> -	lock_sock(sk);
> -	ssk =3D __mptcp_tcp_fallback(msk);
> -	release_sock(sk);
> -	if (ssk)
> -		return tcp_setsockopt(ssk, level, optname, optval, optlen);
> -
> -	if (level =3D=3D SOL_IPV6)
> -		return mptcp_setsockopt_v6(msk, optname, optval, optlen);
> -
> -	return -EOPNOTSUPP;
> -}
> -
> -static int mptcp_getsockopt(struct sock *sk, int level, int optname,
> -			    char __user *optval, int __user *option)
> -{
> -	struct mptcp_sock *msk =3D mptcp_sk(sk);
> -	struct sock *ssk;
> -
> -	pr_debug("msk=3D%p", msk);
> -
> -	/* @@ the meaning of setsockopt() when the socket is connected and
> -	 * there are multiple subflows is not yet defined. It is up to the
> -	 * MPTCP-level socket to configure the subflows until the subflow
> -	 * is in TCP fallback, when socket options are passed through
> -	 * to the one remaining subflow.
> -	 */
> -	lock_sock(sk);
> -	ssk =3D __mptcp_tcp_fallback(msk);
> -	release_sock(sk);
> -	if (ssk)
> -		return tcp_getsockopt(ssk, level, optname, optval, option);
> -
> -	return -EOPNOTSUPP;
> -}
> -
> void __mptcp_data_acked(struct sock *sk)
> {
> 	if (!sock_owned_by_user(sk))
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index d9b403c4b3389..bd6b70b85364d 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -594,6 +594,11 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, co=
nst struct sock *ssk);
> void mptcp_data_ready(struct sock *sk, struct sock *ssk);
> bool mptcp_finish_join(struct sock *sk);
> bool mptcp_schedule_work(struct sock *sk);
> +int mptcp_setsockopt(struct sock *sk, int level, int optname,
> +		     sockptr_t optval, unsigned int optlen);
> +int mptcp_getsockopt(struct sock *sk, int level, int optname,
> +		     char __user *optval, int __user *option);
> +
> void __mptcp_check_push(struct sock *sk, struct sock *ssk);
> void __mptcp_data_acked(struct sock *sk);
> void __mptcp_error_report(struct sock *sk);
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> new file mode 100644
> index 0000000000000..479f756539693
> --- /dev/null
> +++ b/net/mptcp/sockopt.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Multipath TCP
> + *
> + * Copyright (c) 2021, Red Hat.
> + */
> +
> +#define pr_fmt(fmt) "MPTCP: " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <net/sock.h>
> +#include <net/protocol.h>
> +#include <net/tcp.h>
> +#include <net/mptcp.h>
> +#include "protocol.h"
> +
> +static struct sock *__mptcp_tcp_fallback(struct mptcp_sock *msk)

There's still a (now-unused) copy of this function in protocol.c that =

needs to be deleted to avoid a compile warning.

Other than that, I think it would be good to get the patch set in the =

export branch for further testing. Could squash any further tweaks to the =

supported option list.


Mat



> +{
> +	sock_owned_by_me((const struct sock *)msk);
> +
> +	if (likely(!__mptcp_check_fallback(msk)))
> +		return NULL;
> +
> +	return msk->first;
> +}
> +
> +static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optna=
me,
> +				       sockptr_t optval, unsigned int optlen)
> +{
> +	struct sock *sk =3D (struct sock *)msk;
> +	struct socket *ssock;
> +	int ret;
> +
> +	switch (optname) {
> +	case SO_REUSEPORT:
> +	case SO_REUSEADDR:
> +		lock_sock(sk);
> +		ssock =3D __mptcp_nmpc_socket(msk);
> +		if (!ssock) {
> +			release_sock(sk);
> +			return -EINVAL;
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
> +		return ret;
> +	}
> +
> +	return sock_setsockopt(sk->sk_socket, SOL_SOCKET, optname, optval, optl=
en);
> +}
> +
> +static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
> +			       sockptr_t optval, unsigned int optlen)
> +{
> +	struct sock *sk =3D (struct sock *)msk;
> +	int ret =3D -EOPNOTSUPP;
> +	struct socket *ssock;
> +
> +	switch (optname) {
> +	case IPV6_V6ONLY:
> +		lock_sock(sk);
> +		ssock =3D __mptcp_nmpc_socket(msk);
> +		if (!ssock) {
> +			release_sock(sk);
> +			return -EINVAL;
> +		}
> +
> +		ret =3D tcp_setsockopt(ssock->sk, SOL_IPV6, optname, optval, optlen);
> +		if (ret =3D=3D 0)
> +			sk->sk_ipv6only =3D ssock->sk->sk_ipv6only;
> +
> +		release_sock(sk);
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +int mptcp_setsockopt(struct sock *sk, int level, int optname,
> +		     sockptr_t optval, unsigned int optlen)
> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	struct sock *ssk;
> +
> +	pr_debug("msk=3D%p", msk);
> +
> +	if (level =3D=3D SOL_SOCKET)
> +		return mptcp_setsockopt_sol_socket(msk, optname, optval, optlen);
> +
> +	/* @@ the meaning of setsockopt() when the socket is connected and
> +	 * there are multiple subflows is not yet defined. It is up to the
> +	 * MPTCP-level socket to configure the subflows until the subflow
> +	 * is in TCP fallback, when TCP socket options are passed through
> +	 * to the one remaining subflow.
> +	 */
> +	lock_sock(sk);
> +	ssk =3D __mptcp_tcp_fallback(msk);
> +	release_sock(sk);
> +	if (ssk)
> +		return tcp_setsockopt(ssk, level, optname, optval, optlen);
> +
> +	if (level =3D=3D SOL_IPV6)
> +		return mptcp_setsockopt_v6(msk, optname, optval, optlen);
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +int mptcp_getsockopt(struct sock *sk, int level, int optname,
> +		     char __user *optval, int __user *option)
> +{
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	struct sock *ssk;
> +
> +	pr_debug("msk=3D%p", msk);
> +
> +	/* @@ the meaning of setsockopt() when the socket is connected and
> +	 * there are multiple subflows is not yet defined. It is up to the
> +	 * MPTCP-level socket to configure the subflows until the subflow
> +	 * is in TCP fallback, when socket options are passed through
> +	 * to the one remaining subflow.
> +	 */
> +	lock_sock(sk);
> +	ssk =3D __mptcp_tcp_fallback(msk);
> +	release_sock(sk);
> +	if (ssk)
> +		return tcp_getsockopt(ssk, level, optname, optval, option);
> +
> +	return -EOPNOTSUPP;
> +}
> +
> -- =

> 2.26.2
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============2142818296113243077==--
