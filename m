Content-Type: multipart/mixed; boundary="===============0588135545898077647=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: harmonize locking on all socket operations.
Date: Wed, 10 Jul 2019 12:37:36 -0700
Message-ID: <alpine.OSX.2.21.1907101220200.86431@milleral-mobl.amr.corp.intel.com>
In-Reply-To: 4a02318dd3fb1d56bf4bd6dce95de8babf6cbc5d.1562775974.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1481

--===============0588135545898077647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Paolo -

On Wed, 10 Jul 2019, Paolo Abeni wrote:

> The locking schema implied by sendmsg(), recvmsg(), etc.
> requires acquiring the msk's socket lock before manipulating
> the msk internal status.
>
> Additionally, we can't acquire the msk->subflow socket lock while holding
> the msk lock, due to mptcp_finish_connect().
>
> Many socket operations do not enforce the required locking, e.g. we have
> several patterns alike:
>
> 	if (msk->subflow)
> 		// do something with msk->subflow
>
> or:
>
> 	if (!msk->subflow)
> 		// allocate msk->subflow
>
> all without any lock acquired.
>
> They can race with each other and with mptcp_finish_connect() causing
> UAF, null ptr dereference and/or memory leaks.
>
> This patch ensures that all mptcp socket operations access and manipulate
> msk->subflow under the msk socket lock. To avoid breaking the locking
> assumption introduced by mptcp_finish_connect(), while avoiding UAF
> issues, we acquire a reference to the msk->subflow, where needed.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> rfc -> v1:
> - rename *mptcp_socket_get_ref() as *mptcp_fallback_get_ref()
> - use subflow_create_socket() in mptcp_socket_create_get() instead
>   of open-codying it.
> - use mptcp_fallback_get_ref() instead of mptcp_socket_create_get() in
>   mptcp_stream_accept()
> ---
> net/mptcp/protocol.c | 189 +++++++++++++++++++++++++++++++------------
> 1 file changed, 136 insertions(+), 53 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 774ed25d3b6d..619ac2a5022f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

...

> @@ -696,16 +731,20 @@ static int mptcp_getsockopt(struct sock *sk, int le=
vel, int optname,
> 	struct mptcp_sock *msk =3D mptcp_sk(sk);
> 	char __kernel *optval;
> 	int __kernel *option;
> +	struct socket *ssock;
> +	int ret;
>
> 	/* will be treated as __user in tcp_getsockopt */
> 	optval =3D (char __kernel __force *)uoptval;
> 	option =3D (int __kernel __force *)uoption;
>
> 	pr_debug("msk=3D%p", msk);
> +	ssock =3D mptcp_fallback_get_ref(msk);
> 	if (msk->subflow) {

This should use ssock instead of msk->subflow, like setsockopt does.

> -		pr_debug("subflow=3D%p", msk->subflow->sk);
> -		return kernel_getsockopt(msk->subflow, level, optname, optval,
> -					 option);
> +		pr_debug("subflow=3D%p", ssock->sk);
> +		ret =3D kernel_getsockopt(ssock, level, optname, optval, option);
> +		sock_put(ssock->sk);
> +		return ret;
> 	}
>
> 	/* @@ the meaning of setsockopt() when the socket is connected and

Other than that, looks good.

--
Mat Martineau
Intel

--===============0588135545898077647==--
