Content-Type: multipart/mixed; boundary="===============2360544459527221576=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-net] mptcp: fix joined subflows with
 unblocking sk
Date: Mon, 27 Jul 2020 10:59:47 +0200
Message-ID: <0c60e99d58d3b143070bcb975a9c1c308e04579b.camel@redhat.com>
In-Reply-To: 20200727083857.3137824-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5301

--===============2360544459527221576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-07-27 at 10:38 +0200, Matthieu Baerts wrote:
> Unblocking sockets used for outgoing connections were not containing
> inet info about the initial connection due to a typo there: the value of
> "err" variable is negative in the kernelspace.
> =

> This fixes the creation of additional subflows where the remote port has
> to be reused if the other host didn't announce another one. This also
> fixes inet_diag showing blank info about MPTCP sockets from unblocking
> sockets doing a connect().
> =

> Fixes: 41be81a8d3d0 ("mptcp: fix unblocking connect()")
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> ---
>  net/mptcp/protocol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3980fbb6f31e..c0abe738e7d3 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1833,7 +1833,7 @@ static int mptcp_stream_connect(struct socket *sock=
, struct sockaddr *uaddr,
>  	/* on successful connect, the msk state will be moved to established by
>  	 * subflow_finish_connect()
>  	 */
> -	if (!err || err =3D=3D EINPROGRESS)
> +	if (!err || err =3D=3D -EINPROGRESS)
>  		mptcp_copy_inaddrs(sock->sk, ssock->sk);
>  	else
>  		inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));

LGTM! thanks for fixing my bugs :)

Feel free to go upstream ASAP ;)

Thanks,

Paolo

--===============2360544459527221576==--
