Content-Type: multipart/mixed; boundary="===============1556836741447365574=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: packetdrill MP_JOIN failures
Date: Thu, 27 Aug 2020 08:35:19 -0700
Message-ID: <20200827153519.GU10870@MacBook-Pro.local>
In-Reply-To: 2566ca959c87c04647fc926fe690f1b545a93dee.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5647

--===============1556836741447365574==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 08/27/20 - 11:28, Paolo Abeni wrote:
> On Wed, 2020-08-26 at 13:16 -0700, Christoph Paasch wrote:
> > Hello,
> > =

> > On 08/26/20 - 12:03, Paolo Abeni wrote:
> > > On Tue, 2020-08-25 at 22:47 +0200, Davide Caratti wrote:
> > > > hello,
> > > > =

> > > > after commit 3960b799b496 ("mptcp: allow creating non-backup subflo=
ws"),
> > > > the mp_join_client.pkt packetdrill scenario detects a mismatch in t=
he
> > > > contents of MP_JOIN SYN: when the server's additional address is
> > > > transmitted through an ADD_ADDR, the client has no way to set the '=
B'
> > > > flag [1]. If I well understand, we can toggle the 'B' flag using the
> > > > MP_PRIO suboption, but this is not yet in mptcp-net-next [2].
> > > > =

> > > > Given the current state of mptcp-net-next, I'm for removing the 'B'=
 flag
> > > > from the current test [2] and adding another specific test case onc=
e the
> > > > support for MP_PRIO is implemented (by the way, in case nobody is
> > > > already planning to do it I can have a look at it in the next days).
> > > > =

> > > > Any opinions/feedback appreciated, thank you in advance!
> > > =

> > > That looks the easier option and is looks reasonable to me.
> > > =

> > > Additionally and not completely related, we could extend the netlink
> > > interface to let user space configure the backup flag for subflows
> > > created in response to ADD_ADDR options.
> > > =

> > > @Christoph: how does mptcp.org behave WRT the above?
> > =

> > I'm not sure which scenario exactly you have in mind ?
> =

> I mean: how does mptcp.org handle the 'backup' flag for subflow created
> in response to add_Addr options? is there some default behavior, or it
> replies on netlink/user-space?

By default, the backup flag is not set on a subflow.
To mark it as "backup" it depends on which PM is loaded.

For the "fullmesh", one can use "ip link set dev ethX multipath backup".

For the netlink PM, one can mark a specific local address as backup which
means that a subflow using that address will get the B-flag in the MP_JOIN.


Does that clarify it?


Christoph

--===============1556836741447365574==--
