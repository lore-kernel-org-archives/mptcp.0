Content-Type: multipart/mixed; boundary="===============8307575691765439850=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC 06/14] sendmsg: block until mptcp sk is writeable
Date: Mon, 18 Nov 2019 12:29:57 +0100
Message-ID: <c5c49589a929e651f957fee74b1eb264cdc35104.camel@redhat.com>
In-Reply-To: 20191114173225.21199-7-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2574

--===============8307575691765439850==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-11-14 at 18:32 +0100, Florian Westphal wrote:
> This disables transmit of new data until the peer has acked
> enough mptcp data to get below the wspace write threshold (more than
> half of wspace upperlimit is available again).
> =

> Also have poll not report EPOLLOUT in this case, its not relevant if a
> subflow is writeable.
> =

> The latter is a temporary workaround that is needed because mptcp_poll
> walks the subflows and calls __tcp_poll on each of them.
> Because subflow ssk is usually writable, we will have to undo-that
> if the mptcp sndbuf is exhausted.  This won't be needed anymore once
> __tcp_poll is removed, I am working on this.
> =

> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  net/mptcp/protocol.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2144e80b8704..83be407e1dd6 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -406,6 +406,18 @@ static int mptcp_sendmsg(struct sock *sk, struct msg=
hdr *msg, size_t len)
>  		return ret;
>  	}
>  =

> +	timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
> +
> +	mptcp_clean_una(sk);
> +
> +	while (!sk_stream_memory_free(sk)) {
> +		ret =3D sk_stream_wait_memory(sk, &timeo);
> +		if (ret)
> +			goto out;
> +
> +		mptcp_clean_una(sk);
> +	}
> +

Can we move the above loop to the non fallback case only ? e.g. after
the below !mptcp_subflow_get(msk) checks?

If so, we could have a single loop checking for:

!sk_stream_memory_free(sk) || !mptcp_subflow_get_send()

(together with the next patch)

Cheers,

Paolo

--===============8307575691765439850==--
