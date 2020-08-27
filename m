Content-Type: multipart/mixed; boundary="===============5052106638568993149=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: packetdrill MP_JOIN failures
Date: Thu, 27 Aug 2020 11:28:31 +0200
Message-ID: <2566ca959c87c04647fc926fe690f1b545a93dee.camel@redhat.com>
In-Reply-To: 20200826201631.GN10870@MacBook-Pro.local
X-Status: 
X-Keywords:                  
X-UID: 5643

--===============5052106638568993149==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-08-26 at 13:16 -0700, Christoph Paasch wrote:
> Hello,
> =

> On 08/26/20 - 12:03, Paolo Abeni wrote:
> > On Tue, 2020-08-25 at 22:47 +0200, Davide Caratti wrote:
> > > hello,
> > > =

> > > after commit 3960b799b496 ("mptcp: allow creating non-backup subflows=
"),
> > > the mp_join_client.pkt packetdrill scenario detects a mismatch in the
> > > contents of MP_JOIN SYN: when the server's additional address is
> > > transmitted through an ADD_ADDR, the client has no way to set the 'B'
> > > flag [1]. If I well understand, we can toggle the 'B' flag using the
> > > MP_PRIO suboption, but this is not yet in mptcp-net-next [2].
> > > =

> > > Given the current state of mptcp-net-next, I'm for removing the 'B' f=
lag
> > > from the current test [2] and adding another specific test case once =
the
> > > support for MP_PRIO is implemented (by the way, in case nobody is
> > > already planning to do it I can have a look at it in the next days).
> > > =

> > > Any opinions/feedback appreciated, thank you in advance!
> > =

> > That looks the easier option and is looks reasonable to me.
> > =

> > Additionally and not completely related, we could extend the netlink
> > interface to let user space configure the backup flag for subflows
> > created in response to ADD_ADDR options.
> > =

> > @Christoph: how does mptcp.org behave WRT the above?
> =

> I'm not sure which scenario exactly you have in mind ?

I mean: how does mptcp.org handle the 'backup' flag for subflow created
in response to add_Addr options? is there some default behavior, or it
replies on netlink/user-space?

Thanks

Paolo

--===============5052106638568993149==--
