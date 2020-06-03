Content-Type: multipart/mixed; boundary="===============6196617770893848761=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-next] mptcp: add receive buffer
 auto-tuning
Date: Wed, 03 Jun 2020 16:06:36 +0200
Message-ID: <f67740d53f31df60e321dafeab195d020c53c3af.camel@redhat.com>
In-Reply-To: 20200529201005.GA12873@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 4575

--===============6196617770893848761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-05-29 at 22:10 +0200, Florian Westphal wrote:
> Christoph Paasch <cpaasch(a)apple.com> wrote:
> > > After:
> > > ns4 MPTCP -> ns3 (10.0.3.2:10108      ) MPTCP   (duration  5417ms) [ =
OK ]
> > > ns4 MPTCP -> ns3 (10.0.3.2:10109      ) TCP     (duration  5429ms) [ =
OK ]
> > > ns4 TCP   -> ns3 (10.0.3.2:10110      ) MPTCP   (duration  5418ms) [ =
OK ]
> > > ns4 MPTCP -> ns3 (dead:beef:3::2:10111) MPTCP   (duration  5423ms) [ =
OK ]
> > > ns4 MPTCP -> ns3 (dead:beef:3::2:10112) TCP     (duration  5715ms) [ =
OK ]
> > > ns4 TCP   -> ns3 (dead:beef:3::2:10113) MPTCP   (duration  5415ms) [ =
OK ]
> > > Time: 275 seconds
> > > =

> > > Signed-off-by: Florian Westphal <fw(a)strlen.de>
> > > ---
> > Need to also handle the fallback to TCP-case. Otherwise there is a
> > divide-by-0:

[...]

> > server login: [ 1998.037445] divide error: 0000 [#1] SMP KASAN PTI
> > [ 1998.038321] CPU: 3 PID: 1671 Comm: http Kdump: loaded Not tainted 5.=
7.0-rc6.mptcp #43
> > [ 1998.039599] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> > [ 1998.041526] RIP: 0010:mptcp_recvmsg+0x6ae/0xa40

[...]

> WTF?  How can this happen? All TCP -> MPTCP tests passed for me.
> This would mean we call mptcp_recvmsg *without* gping through
> either mptcp_finish_connect or mptcp_accept?
> > @@ -259,8 +259,10 @@ static void subflow_finish_connect(struct sock *sk=
, const struct sk_buff *skb)
> >  				MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
> >  	}
> > =

> > -	if (mptcp_check_fallback(sk))
> > +	if (mptcp_check_fallback(sk)) {
> > +		mptcp_rcv_space_init(mptcp_sk(parent), sk);
> >  		return;
> > +	}
> =

> Oh, wait.  That code is not present in net-next.
> =

> In that case I will wait until this has propagated to net-next; i assume
> I would see the crash with the self test too.

hello Florian,

net-next will not be accepting patches for a while - but I would like to
fix this on some tree, so that periodic tests can be run over there. So, I
will rebase the fallback rework on top of the rx buffer auto-tuning patch.

Ok?

-- =

davide


--===============6196617770893848761==--
