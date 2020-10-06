Content-Type: multipart/mixed; boundary="===============4909223570462015859=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] Squash-to: "mptcp: refactor shutdown and
 close"
Date: Mon, 05 Oct 2020 17:21:18 -0700
Message-ID: <alpine.OSX.2.23.453.2010051721010.13171@srinathb-mobl.amr.corp.intel.com>
In-Reply-To: 4e09117934d8b4501cc32f83a850041a0dd6d917.1601895836.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6208

--===============4909223570462015859==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 5 Oct 2020, Paolo Abeni wrote:

> With the additional SM handling, fallback socket will
> go through an unneeded timeout, because they never
> get the DATA_FIN from the peer.
>
> In case of fallback, we can just close the msk and
> invoke directly tcp_close on the subflow.
>
> This fixes diag.sh self-tests failure in current export
> branch
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 29be694c1d94..7d5905968fac 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2102,7 +2102,8 @@ static void mptcp_close(struct sock *sk, long timeo=
ut)
> 	lock_sock(sk);
> 	sk->sk_shutdown =3D SHUTDOWN_MASK;
>
> -	if (sk->sk_state =3D=3D TCP_LISTEN) {
> +	if (sk->sk_state =3D=3D TCP_LISTEN ||
> +	    __mptcp_check_fallback((struct mptcp_sock *)sk)) {
> 		inet_sk_state_store(sk, TCP_CLOSE);
> 		goto cleanup;
> 	} else if (sk->sk_state =3D=3D TCP_CLOSE) {
> -- =

> 2.26.2

Looks good to me. Thanks Paolo.

--
Mat Martineau
Intel
--===============4909223570462015859==--
