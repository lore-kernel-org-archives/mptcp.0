Content-Type: multipart/mixed; boundary="===============4164677246234632153=="
MIME-Version: 1.0
From: Eric Dumazet <eric.dumazet at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net 2/2] mptcp: better msk-level shutdown.
Date: Wed, 13 Jan 2021 11:21:00 +0100
Message-ID: <a42a3c10-0183-a232-aec6-b1e6bbfaa800@gmail.com>
In-Reply-To: 4cd18371d7caa6ee4a4e7ef988b50b45e362e177.1610471474.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7339

--===============4164677246234632153==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 1/12/21 6:25 PM, Paolo Abeni wrote:
> Instead of re-implementing most of inet_shutdown, re-use
> such helper, and implement the MPTCP-specific bits at the
> 'proto' level.
> =

> The msk-level disconnect() can now be invoked, lets provide a
> suitable implementation.
> =

> As a side effect, this fixes bad state management for listener
> sockets. The latter could lead to division by 0 oops since
> commit ea4ca586b16f ("mptcp: refine MPTCP-level ack scheduling").
> =

> Fixes: 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state machin=
e")
> Fixes: ea4ca586b16f ("mptcp: refine MPTCP-level ack scheduling")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>  net/mptcp/protocol.c | 62 ++++++++++++--------------------------------
>  1 file changed, 17 insertions(+), 45 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2ff8c7caf74f..81faeff8f3bb 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2642,11 +2642,12 @@ static void mptcp_copy_inaddrs(struct sock *msk, =
const struct sock *ssk)
>  =

>  static int mptcp_disconnect(struct sock *sk, int flags)
>  {
> -	/* Should never be called.
> -	 * inet_stream_connect() calls ->disconnect, but that
> -	 * refers to the subflow socket, not the mptcp one.
> -	 */
> -	WARN_ON_ONCE(1);
> +	struct mptcp_subflow_context *subflow;
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +
> +	__mptcp_flush_join_list(msk);
> +	mptcp_for_each_subflow(msk, subflow)
> +		tcp_disconnect(mptcp_subflow_tcp_sock(subflow), flags);

Ouch.

tcp_disconnect() is supposed to be called with socket lock being held.

Really, CONFIG_LOCKDEP=3Dy should have warned you :/


--===============4164677246234632153==--
