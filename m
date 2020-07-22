Content-Type: multipart/mixed; boundary="===============8472021248469070799=="
MIME-Version: 1.0
From: David Laight <David.Laight at ACULAB.COM>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: get rid of the address_space override in setsockopt
Date: Wed, 22 Jul 2020 08:21:21 +0000
Message-ID: <eafa16fad33a4255a97b55a56e58ae1a@AcuMS.aculab.com>
In-Reply-To: 20200722080646.GA26864@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5167

--===============8472021248469070799==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: 'Christoph Hellwig'
> Sent: 22 July 2020 09:07
> On Tue, Jul 21, 2020 at 09:38:23AM +0000, David Laight wrote:
> > From: Christoph Hellwig
> > > Sent: 20 July 2020 13:47
> > >
> > > setsockopt is the last place in architecture-independ code that still
> > > uses set_fs to force the uaccess routines to operate on kernel pointe=
rs.
> > >
> > > This series adds a new sockptr_t type that can contained either a ker=
nel
> > > or user pointer, and which has accessors that do the right thing, and
> > > then uses it for setsockopt, starting by refactoring some low-level
> > > helpers and moving them over to it before finally doing the main
> > > setsockopt method.
> >
> > Are you planning to make the equivalent change to getsockopt()?
> =

> No.  Only setsockopt can be fed kernel addresses from bpf-cgroup.
> There is no point in complicating the read side interface when it
> doesn't have that problem.

You realise that one of the SCTP getsockopt() is actually a command!
It is one of the requests that changes state and should probably
have been a separate system call.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

--===============8472021248469070799==--
