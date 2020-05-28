Content-Type: multipart/mixed; boundary="===============3526381460577390522=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 2/2] mptcp: add receive buffer
 auto-tuning
Date: Thu, 28 May 2020 20:05:51 +0200
Message-ID: <fc5f23a37f60d5c922eb6eba033008f5d4af604a.camel@redhat.com>
In-Reply-To: 20200528175518.GN2915@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 4544

--===============3526381460577390522==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-05-28 at 19:55 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > On Thu, 2020-05-28 at 15:02 +0200, Florian Westphal wrote:
> > > +static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copie=
d)
> > > +{
> > > +	struct mptcp_subflow_context *subflow;
> > > +	struct sock *sk =3D (struct sock *)msk;
> > > +	u32 time, advmss =3D 1;
> > > +	u64 rtt_us, mstamp;
> > > +
> > > +	sock_owned_by_me(sk);
> > > +
> > > +	if (copied <=3D 0)
> > > +		return;
> > > +
> > > +	msk->rcvq_space.copied +=3D copied;
> > > +
> > > +	rtt_us =3D 0;
> > > +	mptcp_for_each_subflow(msk, subflow) {
> > > +		const struct tcp_sock *tp;
> > > +		u64 sf_rtt_us;
> > > +		u32 sf_advmss;
> > > +
> > > +		tp =3D tcp_sk(mptcp_subflow_tcp_sock(subflow));
> > > +
> > > +		sf_rtt_us =3D READ_ONCE(tp->rcv_rtt_est.rtt_us);
> > > +		sf_advmss =3D READ_ONCE(tp->advmss);
> > > +
> > > +		rtt_us =3D max(sf_rtt_us, rtt_us);
> > > +		advmss =3D max(sf_advmss, advmss);
> > > +	}
> > > +
> > > +	mstamp =3D div_u64(tcp_clock_ns(), NSEC_PER_USEC);
> > > +
> > > +	time =3D tcp_stamp_us_delta(mstamp, msk->rcvq_space.time);
> > > +	if (time < (rtt_us >> 3) || rtt_us =3D=3D 0)
> > > +		return;
> > =

> > what if you cache the rtt_ns value, too, and use it to move the above
> > test before the loop? So that the receive path will loop on the subflow
> > at most once every rtt_us/8.
> =

> Which rtt_us should I cache?  The one used during last measurement
> window?

yes

Additionally we should do the loop if 'cache_rtt_us' =3D=3D 0.

Cheers

/P



--===============3526381460577390522==--
