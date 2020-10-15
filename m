Content-Type: multipart/mixed; boundary="===============3902747121360943010=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] Squash-to: "mptcp: refactor shutdown and
 close"
Date: Thu, 15 Oct 2020 16:51:52 +0200
Message-ID: <5ca9f3dcf03cc45acb1cd569552b7ce06140a085.camel@redhat.com>
In-Reply-To: f20c5df58852b95e9df9bbf63b5b796e4b701a0f.1602772180.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6320

--===============3902747121360943010==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-10-15 at 16:30 +0200, Davide Caratti wrote:
> when the data-fin is acked on all subflows, the socket goes in
> FIN_WAIT_2 state. Call __mptcp_destroy_sock() to transmit a TCP FIN.

Note for the reviewers: the above happens only for orphaned msk, and
follows quite closely what plain TCP does.
> =

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/98
> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> ---
>  net/mptcp/protocol.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 5b32741f2af3..95566f120e72 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1859,7 +1859,8 @@ static void mptcp_worker(struct work_struct *work)
>  	 */
>  	if (sock_flag(sk, SOCK_DEAD) &&
>  	    (mptcp_check_close_timeout(sk) ||
> -	    (state !=3D sk->sk_state && sk->sk_state =3D=3D TCP_CLOSE))) {
> +	    (state !=3D sk->sk_state &&
> +	    ((1 << inet_sk_state_load(sk)) & (TCPF_CLOSE | TCPF_FIN_WAIT2))))) {
>  		inet_sk_state_store(sk, TCP_CLOSE);
>  		__mptcp_destroy_sock(sk, 0);
>  		goto unlock;

LGTM! Thanks Davide!

/P

--===============3902747121360943010==--
