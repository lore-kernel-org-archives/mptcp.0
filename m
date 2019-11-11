Content-Type: multipart/mixed; boundary="===============0200965126639324051=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/4] mptcp: disable on req sk if MD5SIG is enabled
Date: Mon, 11 Nov 2019 13:44:14 -0800
Message-ID: <2a8248416c7c9641baa6e9682da687b9d17e5d02.camel@linux.intel.com>
In-Reply-To: 4efc3c8a58dc8e50c533b262860a63010b8babbd.1573488743.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2472

--===============0200965126639324051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-11-11 at 17:53 +0100, Paolo Abeni wrote:
> Likley we want to update the "mptcp: Create SUBFLOW socket for incoming c=
onnections"
> commit message with something alike:
> =

> Explicitly disable MPTCP if MD5SIG is enable, to prevent TCP option space
> exaustion.
> =

> Squash-to: mptcp: Create SUBFLOW socket for incoming connections
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>  net/mptcp/protocol.c | 8 ++++++++
>  net/mptcp/subflow.c  | 8 ++++++++
>  2 files changed, 16 insertions(+)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 81b7c21f4d3c..bb297e9dd6c5 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -342,6 +342,14 @@ static int mptcp_stream_connect(struct socket *sock,=
 struct sockaddr *uaddr,
>  	if (IS_ERR(ssock))
>  		return PTR_ERR(ssock);
>  =

> +#ifdef CONFIG_TCP_MD5SIG
> +	/* no MPTCP is MD5SIG is enabled on this socket or we may run out of
> +	 * TCP option space.
> +	 */

typo in comment [two places]: "no MPTCP if MD5SIG"

> +	if (rcu_access_pointer(tcp_sk(ssock->sk)->md5sig_info))
> +		mptcp_subflow_ctx(ssock->sk)->request_mptcp =3D 0;

Would it be better to put this check in mptcp_socket_create_get() where
request_mptcp is being initially? Then it only needs to be in one place and
will cause bind() to fail appropriately as well.

Peter.

> +#endif
> +
>  	err =3D ssock->ops->connect(ssock, uaddr, addr_len, flags);
>  	sock_put(ssock->sk);
>  	return err;
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 9b56fe9a83f2..4ab751163965 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -30,6 +30,14 @@ static void subflow_init_req(struct request_sock *req,
>  =

>  	subflow_req->mp_capable =3D 0;
>  =

> +#ifdef CONFIG_TCP_MD5SIG
> +	/* no MPTCP is MD5SIG is enabled on this socket or we may run out of
> +	 * TCP option space.
> +	 */
> +	if (rcu_access_pointer(tcp_sk(sk_listener)->md5sig_info))
> +		return;
> +#endif
> +
>  	if (rx_opt.mptcp.mp_capable && listener->request_mptcp) {
>  		subflow_req->mp_capable =3D 1;
>  		if (rx_opt.mptcp.version >=3D listener->request_version)

--===============0200965126639324051==--
