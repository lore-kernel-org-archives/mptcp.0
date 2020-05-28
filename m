Content-Type: multipart/mixed; boundary="===============3833065180568952483=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 2/2] mptcp: add receive buffer
 auto-tuning
Date: Thu, 28 May 2020 19:48:50 +0200
Message-ID: <9d1f3c59c12898b7bf8c7fe23cc8a9ae30ea7340.camel@redhat.com>
In-Reply-To: 20200528130239.16498-3-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4536

--===============3833065180568952483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-05-28 at 15:02 +0200, Florian Westphal wrote:
> +static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *sk =3D (struct sock *)msk;
> +	u32 time, advmss =3D 1;
> +	u64 rtt_us, mstamp;
> +
> +	sock_owned_by_me(sk);
> +
> +	if (copied <=3D 0)
> +		return;
> +
> +	msk->rcvq_space.copied +=3D copied;
> +
> +	rtt_us =3D 0;
> +	mptcp_for_each_subflow(msk, subflow) {
> +		const struct tcp_sock *tp;
> +		u64 sf_rtt_us;
> +		u32 sf_advmss;
> +
> +		tp =3D tcp_sk(mptcp_subflow_tcp_sock(subflow));
> +
> +		sf_rtt_us =3D READ_ONCE(tp->rcv_rtt_est.rtt_us);
> +		sf_advmss =3D READ_ONCE(tp->advmss);
> +
> +		rtt_us =3D max(sf_rtt_us, rtt_us);
> +		advmss =3D max(sf_advmss, advmss);
> +	}
> +
> +	mstamp =3D div_u64(tcp_clock_ns(), NSEC_PER_USEC);
> +
> +	time =3D tcp_stamp_us_delta(mstamp, msk->rcvq_space.time);
> +	if (time < (rtt_us >> 3) || rtt_us =3D=3D 0)
> +		return;

what if you cache the rtt_ns value, too, and use it to move the above
test before the loop? So that the receive path will loop on the subflow
at most once every rtt_us/8.

The value used to skip the update will be not accurated, but should not
matter much, right? The correct value will still be used to update the
rcvbuf below.

WDYT?

Thanks!

Paolo

--===============3833065180568952483==--
