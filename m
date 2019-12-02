Content-Type: multipart/mixed; boundary="===============8913774896023758776=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 9/9] don't flag parent socket as RCV_SHUTDOWN if
 one one subflow has closed
Date: Mon, 02 Dec 2019 19:00:54 +0100
Message-ID: <20191202180054.GR795@breakpoint.cc>
In-Reply-To: 9fecd7952e5f37bf025d368143f15f1cb69964c5.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2750

--===============8913774896023758776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Sat, 2019-11-30 at 23:49 +0100, Florian Westphal wrote:
> > @@ -642,7 +647,7 @@ bool mptcp_subflow_data_available(struct sock *sk)
> >  		/* set EoF only there is no data available - we already spooled
> >  		 * all the pending skbs
> >  		 */
> > -		if (sk->sk_shutdown & RCV_SHUTDOWN || sk->sk_state =3D=3D TCP_CLOSE)
> > +		if (subflow_is_done(sk))
> >  			subflow->rx_eof =3D 1;
> >  		return false;
> >  	}
> > @@ -666,13 +671,15 @@ static void subflow_data_ready(struct sock *sk)
> >  		return;
> >  	}
> >  =

> > -	/* always propagate the EoF */
> > -	if (mptcp_subflow_data_available(sk) || subflow->rx_eof) {
> > +	if (mptcp_subflow_data_available(sk)) {
> >  		smp_mb__before_atomic();
> >  		set_bit(MPTCP_DATA_READY, &mptcp_sk(parent)->flags);
> >  		smp_mb__after_atomic();
> >  =

> >  		parent->sk_data_ready(parent);
> > +	} else if (subflow->rx_eof) {
> > +		/* tell parent to (re-)check eof on all subflows */
> > +		mptcp_subflow_eof(parent);
> >  	}
> >  }
> > =

> =

> With subflow_state_change() in place, do we still need the above
> chunks?!? e.g. why is not subflow_state_change() enough to catch the
> subflow eof condition?

Right, it might be possible to drop that indeed.
--===============8913774896023758776==--
