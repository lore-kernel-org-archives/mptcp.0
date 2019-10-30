Content-Type: multipart/mixed; boundary="===============5709107661815914572=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 2/2] mptcp: sendmsg: transmit on backup if
 other subflows have been closed
Date: Wed, 30 Oct 2019 16:14:03 +0100
Message-ID: <6a4d6f0bef7b05292e77ec1b7998837cc988c793.camel@redhat.com>
In-Reply-To: 20191030140357.11880-3-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2356

--===============5709107661815914572==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2019-10-30 at 15:03 +0100, Florian Westphal wrote:
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d15d64d16136..2b847e079619 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -344,6 +344,38 @@ static int mptcp_sendmsg_frag(struct sock *sk, struc=
t sock *ssk,
>  	return ret;
>  }
>  =

> +static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *backup =3D NULL;
> +
> +	sock_owned_by_me((const struct sock *)msk);
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk =3D mptcp_subflow_tcp_socket(subflow)->sk;
> +
> +		if (!sk_stream_is_writeable(ssk)) {
> +			struct socket *sock =3D ssk->sk_socket;
> +
> +			if (sock)
> +				set_bit(SOCK_NOSPACE, &sock->flags);

Out of sheer ignorance, why is this required? I thought setting NOSPACE
was required only before waiting for memory.

[...]
> @@ -366,23 +398,36 @@ static int mptcp_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len)
>  		return ret;
>  	}
>  =

> -	ssk =3D mptcp_subflow_get(msk);
> -	if (!ssk) {
> -		release_sock(sk);
> -		return -ENOTCONN;
> -	}
> -
> -	if (!msg_data_left(msg)) {
> +	if (unlikely(!msg_data_left(msg))) {
> +		ssk =3D mptcp_subflow_get(msk);
>  		pr_debug("empty send");
>  		ret =3D sock_sendmsg(ssk->sk_socket, msg);
>  		goto out;
>  	}
>  =

> +	timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
> +
> +	smp_mb__before_atomic();
> +	clear_bit(MPTCP_SEND_SPACE, &msk->flags);
> +	smp_mb__after_atomic();

Perhaps the above lines could be moved just before the
sk_stream_wait_memory() call below?

Cheers,

Paolo

--===============5709107661815914572==--
