Content-Type: multipart/mixed; boundary="===============8379606632565306001=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 11/12] mptcp: allow picking different xmit
 subflows
Date: Sun, 02 Aug 2020 01:50:46 +0200
Message-ID: <20200801235046.GI29169@breakpoint.cc>
In-Reply-To: 960519a1162d5a416245fa239e57392ab0efa0be.1596216310.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5428

--===============8379606632565306001==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> Update the scheduler to less trivial heuristic: cache
> the last used subflow, and try to send on it a reasonably
> long burst of data. When the burst or the subflow send
> space is exausted, move to the next one with available
> send space.
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>  net/mptcp/protocol.c | 112 +++++++++++++++++++++++++++++++++++++------
>  net/mptcp/protocol.h |   6 ++-
>  2 files changed, 101 insertions(+), 17 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ef5b68c4ff49..89c0400593d1 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1012,39 +1012,112 @@ static void mptcp_nospace(struct sock *sk, struc=
t sock *ssk)
>  		set_bit(SOCK_NOSPACE, &sock->flags);
>  }
>  =

> +static bool mptcp_subflow_active(struct mptcp_subflow_context *subflow,
> +				 bool fallback)
> +{
> +	struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> +
> +	/* subflow must be open for write */
> +	if ((1 << ssk->sk_state) &
> +	    (TCPF_CLOSE | TCPF_LAST_ACK | TCPF_CLOSING | TCPF_FIN_WAIT2 |
> +	     TCPF_FIN_WAIT1))
> +		return false;

Hmmm, why is this not checking for TCP_ESTABLISHED -> true, rather than
checking 'states i do not want'?

> +	/* we can xmit on MPC and fallen back subflows in
> +	 * TCP_SYN_SENT/TCP_SYN_RECV status, but we need fully established
> +	 * MP_JOIN subflows.
> +	 */

I don't understand this comment.  The part with 'fully established
MP_JOIN' is clear to me.

Is this about SYN_SENT state is fine if ssk tested is the 'msk->first'
subflow?

If so, it might make sense to re-arrange the check to something like
'subflow->request_join && established && subflow->fully_established &&
!fallback' -> return true
else, return state =3D=3D ESTABLISHED?

or even, ".. else subflow requal to msk->first and state eq ESTABLISHED
return true'?

>  static void ssk_check_wmem(struct sock *sk, struct sock *ssk)
> @@ -1142,6 +1215,7 @@ static int mptcp_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
>  		}
>  =

>  		copied +=3D ret;
> +		msk->snd_burst -=3D ret;

Maybe add a comment that ret > snd_burst is fine.

>  		tx_ok =3D msg_data_left(msg);
>  		if (!tx_ok)
> @@ -1358,6 +1432,10 @@ static bool __mptcp_move_skbs(struct mptcp_sock *m=
sk)
>  	unsigned int moved =3D 0;
>  	bool done;
>  =

> +	if (((struct sock *)msk)->sk_state =3D=3D TCP_CLOSE)
> +		return false;

This looks funny -- why is this needed?

>  static struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *m=
sk)
>  {
> +	bool fallback =3D __mptcp_check_fallback(msk);
>  	struct mptcp_subflow_context *subflow;
>  	struct sock *backup =3D NULL;
>  =

> @@ -1521,6 +1600,9 @@ static struct sock *mptcp_subflow_get_retrans(const=
 struct mptcp_sock *msk)
>  	mptcp_for_each_subflow(msk, subflow) {
>  		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
>  =

> +		if (!mptcp_subflow_active(subflow, fallback))
> +			continue;

Hmm, should this be a separate bug fix (prevent non-fully-established-join)?
--===============8379606632565306001==--
