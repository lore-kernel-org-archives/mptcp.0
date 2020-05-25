Content-Type: multipart/mixed; boundary="===============0521101324407718923=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-next 2/2] mptcp: move recbuf adjustment
 to recvmsg path
Date: Mon, 25 May 2020 16:55:45 +0200
Message-ID: <24c34db5505371e9e6e462e46ffa778517b0f78a.camel@redhat.com>
In-Reply-To: 20200525120243.4160-3-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4487

--===============0521101324407718923==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-05-25 at 14:02 +0200, Florian Westphal wrote:
> @@ -933,6 +926,22 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
>  	return moved > 0;
>  }
>  =

> +static void mptcp_rcv_space_adjust(struct mptcp_sock *msk)
> +{
> +	struct sock *sk =3D (struct sock *)msk;
> +	const struct mptcp_subflow_context *subflow;
> +	const struct sock *ssk;
> +	int rcvbuf =3D 0;

Reverse x-mas tree ;)

> @@ -975,8 +987,10 @@ static int mptcp_recvmsg(struct sock *sk, struct msg=
hdr *msg, size_t len,
>  		copied +=3D bytes_read;
>  =

>  		if (skb_queue_empty(&sk->sk_receive_queue) &&
> -		    __mptcp_move_skbs(msk))
> +		    __mptcp_move_skbs(msk)) {
> +			mptcp_rcv_space_adjust(msk);
>  			continue;
> +		}
>  =

>  		/* only the master socket status is relevant here. The exit
>  		 * conditions mirror closely tcp_recvmsg()

We currently don't check the SOCK_RCVBUF_LOCK here, while we do that in
the other mptcp_rcv_space_adjust() call-site.

It likely should not matter as ssk userlocks mimics msk's ones, but for
consistency we could always do the test before trying to update the
buffer (e.g. move the userlocks check inside mptcp_rcv_space_adjust()),
WDYT?

Thanks!

Paolo

--===============0521101324407718923==--
