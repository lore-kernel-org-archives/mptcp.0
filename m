Content-Type: multipart/mixed; boundary="===============3582307743094374279=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-net] mptcp: fix DATA_FIN processing for
 orphaned sockets.
Date: Tue, 16 Feb 2021 18:05:46 -0800
Message-ID: <f59d8596-3ca-78d4-8a9f-8e50d3d08357@linux.intel.com>
In-Reply-To: 723de05edd19a88776331f585deb6ce72d959eca.1613398456.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7819

--===============3582307743094374279==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Feb 2021, Paolo Abeni wrote:

> Currently we move orphaned msk socket directly from FIN_WAIT2
> state to close, with the rationale that incoming additional
> data could be just dropped by the TCP stack/TW sockets.
>
> Anyhow we miss sending MPTCP-level ack on incoming DATA_FIN,
> and that may hang the peers.
>
> Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> I hope nobody is keeping track of nr of follow-ups x commit,
> because the referenced one could score a world record :(((
> ---
> net/mptcp/protocol.c | 9 ++++-----
> 1 file changed, 4 insertions(+), 5 deletions(-)
>

Thanks for catching this. Fix looks ready for the export branch, and -net =

(if tests are good). Also a candidate for 5.11-stable?


Mat


> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ee5a2981df6da..f15c79ff6a53c 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2297,13 +2297,12 @@ static void mptcp_worker(struct work_struct *work)
> 	__mptcp_check_send_data_fin(sk);
> 	mptcp_check_data_fin(sk);
>
> -	/* if the msk data is completely acked, or the socket timedout,
> -	 * there is no point in keeping around an orphaned sk
> +	/* There is no point in keeping aroud an orphaned sk timedout or closed,
> +	 * but we need the msk around to reply to incoming DATA_FIN, even if
> +	 * orphaned and in FIN_WAIT2 state
> 	 */
> 	if (sock_flag(sk, SOCK_DEAD) &&
> -	    (mptcp_check_close_timeout(sk) ||
> -	    (state !=3D sk->sk_state &&
> -	    ((1 << inet_sk_state_load(sk)) & (TCPF_CLOSE | TCPF_FIN_WAIT2))))) {
> +	    (mptcp_check_close_timeout(sk) || sk->sk_state =3D=3D TCP_CLOSE)) {
> 		inet_sk_state_store(sk, TCP_CLOSE);
> 		__mptcp_destroy_sock(sk);
> 		goto unlock;
> -- =

> 2.26.2
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============3582307743094374279==--
