Content-Type: multipart/mixed; boundary="===============3745310811007552378=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [Weekly meetings] MoM - 23rd of January 2020
Date: Tue, 28 Jan 2020 17:43:13 +0100
Message-ID: <d75ec7229a6c2286f1b52eeb52ee20289b922f08.camel@redhat.com>
In-Reply-To: 9c637883-ad74-d916-1bbf-8256ac86c4ac@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3543

--===============3745310811007552378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-01-24 at 17:38 +0100, Matthieu Baerts wrote:
> On 24/01/2020 11:14, Paolo Abeni wrote:
> > On Thu, 2020-01-23 at 22:42 +0100, Matthieu Baerts wrote:
> > >       - checkpatch: 3 issues:
> > >           - one space/tabs mix (1 tabs + 9 spaces instead of 2 tabs +=
 1
> > > space)
> > >           - one extra space after '*' when declaring a function
> > >           - one comparison to "NULL": var =3D=3D NULL instead of !var
> > >           =E2=86=92 we can wait for when we will need to send a new v=
ersion
> > >           =E2=86=92 *Matth* can send patches and apply them later
> > =

> > Would be good including the above, but I personally have hard time to
> > do anything before next Mon.
> =

> Where can we apply these very small fixes now that the series is =

> applied? I can send the patches but do we want to ignore them or apply =

> them if we modify the code around?

I would go with "net" patches to address the above (and ev. review on
the mptcp ML before the actual upstream submission).

> > We discussed off-line this topic. We think that a netlink-based,
> > simple and allowing future features could be created with a reasonable
> > effort. The idea would be to initially support only a few commands:
> > =

> > 	- announce the provided address[es]
> > 		* argument is an address [list]
> > =

> > 	- add new subflows using the provided address[es]
> > 		* argument is an address [list]
> > 		=

> > 	- add subflows for each announced address
> > 		* argument is a single number: the maximum number
> > 		  of allowed subflows created for the addresses
> > 		  announced by the peers. 0 =3D=3D no subflows creation
> > 		  for the announced received.
> > =

> > each command will affect all the MPTCP sockets created in the current
> > netns after that the netlink command is issued.
> =

> If I understand well, you want something different than the netlink =

> path-manager we have on MPTCP out-of-tree, right?
> =

> This PM acts per MPTCP connection while here, you want to act on all =

> existing and future connections, right?
> =

> For the two first items, is it not something we can already achieve with =

> the "basic" PM via sysctl per NS but only valid for one address to =

> announce/create a subflow?

Yes, but the current basic PM uses the not so clean procfs interface.
The idea is get something could fit upstream more nicely. It will
(initially) operate on a netns basic, could be extended to something
compatible with out-of-tree PM later.

> > The idea is that we should be able to easily plug both self-tests and
> > almost reasonable "production" behaviours with the above.
> =

> To replace the basic PM them or already support the "server PM" we were =

> mentioning in the notes?
> =


The idea would be replacing the current basic PM, still keeping the
code as small as possible.

The 'server PM' should likely obtained extending this NL interface
(and/or basic behaviour should already fit some/most server scenarios).

Cheers,

Paolo

--===============3745310811007552378==--
