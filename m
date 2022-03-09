Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34B35127
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 21:37:41 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1nS3zu-0007ux-1Y; Wed, 09 Mar 2022 22:37:30 +0100
Date: Wed, 9 Mar 2022 22:37:30 +0100
From: Florian Westphal <fw@strlen.de>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 3/4] mptcp: handle join requests via pernet
 listen socket
Message-ID: <20220309213730.GC26501@breakpoint.cc>
References: <20220224155010.23676-1-fw@strlen.de>
 <20220224155010.23676-4-fw@strlen.de>
 <ab1f9296-3637-d13a-bfe3-97183f593190@intel.com>
 <20220308184531.GA22024@breakpoint.cc>
 <d796fef2-d380-c92a-7516-617992a20460@intel.com>
 <20220309125351.GB26501@breakpoint.cc>
 <4e545ab7-7a9c-921a-0095-6a7e5803cdae@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4e545ab7-7a9c-921a-0095-6a7e5803cdae@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Kishen Maloor <kishen.maloor@intel.com> wrote:
> On 3/9/22 4:53 AM, Florian Westphal wrote:
> > Kishen Maloor <kishen.maloor@intel.com> wrote:
> >>>> Over a newly established MPTCP connection following listen(s1), the =
PM can issue an=20
> >>>> ADD_ADDR with B. In light of this change there would be no listener =
created for B.=20
> >>>> But if the remote endpoint immediately established a subflow in resp=
onse (to the=20
> >>>> ADD_ADDR), then that would create a subflow (connection) socket at B.
> >>>> It appears (and correct me if I'm wrong) that bind(s2, B) would fail=
 after this point (?).
> >>>
> >>> Why would that fail? You can bind x:y even if there is an established
> >>> connection from x:y to q:r.
> >>
> >> If I establish an MPTCP connection using mptcp_connect individually as=
=20
> >> Client and Server, then I am unable to bind a 3rd (new) Server process=
 at the Client's=20
> >> addr+port [1]. Why is this the case?
> >=20
> > Whats [1]?
> > I suspect this patch series needs following addition in patch 3:
> >=20
> > diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> > --- a/net/mptcp/ctrl.c
> > +++ b/net/mptcp/ctrl.c
> > @@ -337,6 +337,8 @@ static int mptcp_init_join_sk(struct net *net, stru=
ct sock *sk, struct mptcp_joi
> >  	if (!tb)
> >  		return -ENOMEM;
> > =20
> > +	ssock->sk->sk_reuse =3D 1;
> > +	ssock->sk->sk_reuseport =3D 1;
> >  	inet_csk(ssock->sk)->icsk_bind_hash =3D tb;
> >  	return 0;
> >  }
> >=20
> > After that, follwing sequence should work:
> >=20
> > 1. bind(0.0.0.0, p1) // listen, accept etc, initial subflow established
> > 2. announce p2
> > 3. receive join on addr, p2
> > 4. bind(0.0.0.0, p2)
> >=20
> > 4) should work because sk used for endpoint in 3) has reuse flag set
> > and is not in listen state.
> >=20
> > cf. include/net/inet_hashtables.h, line 47:
> > 2) If all sockets have sk->sk_reuse set, and none of them
> >    TCP_LISTEN state, the port may be shared.
> >=20
>=20
> Wouldn't 4) fail if the socket being bound at the time does not have the =
SO_REUSExxx flag(s) set?

Yes, it needs SO_REUSEADDR set.

> If so, that would be application level thing and in that situation we don=
't have a way to
> avoid a race.  Whereas when we require an explicit listener, we could hav=
e the kernel take a step
> back (and not create a listener) to break the race.

Uh, what?  Sorry, I am totally lost.  I have no idea what the problem is
that we're solving here.

EOD, I am out of ideas.  Feel free to toss this patchset, I have no idea
what to do.
