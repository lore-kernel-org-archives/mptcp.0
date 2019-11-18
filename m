Content-Type: multipart/mixed; boundary="===============6340576781069063044=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC 10/14] recv: make DATA_READY reflect ssk in-sequence
 state
Date: Mon, 18 Nov 2019 12:46:33 +0100
Message-ID: <525d25169a7a800ca7a3775fbf2ec09e47ecb8fd.camel@redhat.com>
In-Reply-To: 20191114173225.21199-11-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2576

--===============6340576781069063044==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-11-14 at 18:32 +0100, Florian Westphal wrote:
> @@ -614,8 +612,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
>  			if (bytes_read < 0) {
>  				if (!copied)
>  					copied =3D bytes_read;
> -				done =3D true;

Why 'done' is not set here anymore? I think we want to quit the
recvmsg() loop on socket error ?!?

[...]
>  		/* only the master socket status is relevant here. The exit
>  		 * conditions mirror closely tcp_recvmsg()
>  		 */
>  		if (copied >=3D target)
> -			break;
> +			goto out;

Double checking I'm following correctly the patch: 'goto out' and
'break;' jump to the same position right? - just after the main
recvmsg() loop.

The same in several places below.

[...]
> +out:
> +	if (more_data_avail) {
> +		if (!test_bit(MPTCP_DATA_READY, &msk->flags))
> +			set_bit(MPTCP_DATA_READY, &msk->flags);

Can we use test_and_set_bit() here? Othewise, don't we need some smp
barriers?

> +	} else if (!wait_data) {
> +		clear_bit(MPTCP_DATA_READY, &msk->flags);
> +
> +		/* .. race-breaker: ssk might get new data after last
> +		 * data_available() returns false.
> +		 */
> +		ssk =3D mptcp_subflow_recv_lookup(msk);
> +		if (unlikely(ssk))
> +			set_bit(MPTCP_DATA_READY, &msk->flags);

Don't we need smp barriers around the bit operations here?

Cheers,

Paolo

--===============6340576781069063044==--
