Content-Type: multipart/mixed; boundary="===============6378430798483010614=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 01/12] mptcp: msk is writable according to msk
 write space
Date: Sun, 02 Aug 2020 00:23:01 +0200
Message-ID: <20200801222301.GA29169@breakpoint.cc>
In-Reply-To: aa6bae778983c8f5d02a15e443482fc24ea2a56a.1596216310.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5421

--===============6378430798483010614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> Currently, when checking for the 'msk is writable' condition,
> we look at the individual subflows write space. That works
> well while we sends data via a single subflow, but will not
> as soon as we will enable concurrent xmit on multiple subflows.
> =

> Let's use the msk write space instead.

Why do we need MPTCP_SEND_SPACE bit after this change?

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>  net/mptcp/protocol.c | 42 ++++++++++++++++++++++++------------------
>  net/mptcp/subflow.c  |  3 +--
>  2 files changed, 25 insertions(+), 20 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3b9ae98c67bb..d51b1d95dfb8 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -612,8 +612,15 @@ static void mptcp_clean_una(struct sock *sk)
>  		sk_mem_reclaim_partial(sk);
>  =

>  		/* Only wake up writers if a subflow is ready */
> -		if (test_bit(MPTCP_SEND_SPACE, &msk->flags))
> +		if (sk_stream_is_writeable(sk)) {
> +			set_bit(MPTCP_SEND_SPACE, &mptcp_sk(sk)->flags);

mptcp sk has enough wmem, so MPTCP_SEND_SPACE is set.

> @@ -799,21 +806,27 @@ static int mptcp_sendmsg_frag(struct sock *sk, stru=
ct sock *ssk,
>  	return ret;
>  }
>  =

> -static void mptcp_nospace(struct mptcp_sock *msk, struct socket *sock)
> +static void mptcp_nospace(struct sock *sk, struct sock *ssk)
>  {
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	struct socket *sock;
> +
>  	clear_bit(MPTCP_SEND_SPACE, &msk->flags);

This clears it, helper is called when msk wmem occupancy is too large.

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 7e838bc6e364..bd2201d62ae6 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -926,8 +926,7 @@ static void subflow_write_space(struct sock *sk)
>  	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
>  	struct sock *parent =3D subflow->conn;
>  =

> -	sk_stream_write_space(sk);
> -	if (sk_stream_is_writeable(sk)) {
> +	if (sk_stream_is_writeable(parent)) {
>  		set_bit(MPTCP_SEND_SPACE, &mptcp_sk(parent)->flags);

here, its set again when wmem occupancy of msk is low enough again.

So, AFAICS we can just remove it completely.

If not, perhaps add a comment as to what its signalling vs. 'msk is
writeable/not writeable'.

Otherwise looks like a good cleanup to me.
--===============6378430798483010614==--
