Content-Type: multipart/mixed; boundary="===============8669830102709893843=="
MIME-Version: 1.0
From: 'Christoph Hellwig' <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: get rid of the address_space override in setsockopt
Date: Wed, 22 Jul 2020 10:07:24 +0200
Message-ID: <20200722080724.GB26864@lst.de>
In-Reply-To: ae6a743aaea3406596dbc89e332b6b3e@AcuMS.aculab.com
X-Status: 
X-Keywords:                  
X-UID: 5166

--===============8669830102709893843==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2020 at 10:26:58AM +0000, David Laight wrote:
> From: Christoph Hellwig
> > Sent: 20 July 2020 13:47
> > =

> > setsockopt is the last place in architecture-independ code that still
> > uses set_fs to force the uaccess routines to operate on kernel pointers.
> > =

> > This series adds a new sockptr_t type that can contained either a kernel
> > or user pointer, and which has accessors that do the right thing, and
> > then uses it for setsockopt, starting by refactoring some low-level
> > helpers and moving them over to it before finally doing the main
> > setsockopt method.
> =

> Another 'gotcha' ...
> =

> On an least some architectures (possibly only m68k) IIRC all structures
> are actually passed by reference.
> (This used to be true for sparc - but it may have changed in the
> last 30 years.)

Tough luck for ABIs wit suboptimal calling conventions.  At least we can
do the right thing for those that do not have the problem.
--===============8669830102709893843==--
