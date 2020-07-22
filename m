Content-Type: multipart/mixed; boundary="===============5088731047141625638=="
MIME-Version: 1.0
From: 'Christoph Hellwig' <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: get rid of the address_space override in setsockopt
Date: Wed, 22 Jul 2020 10:06:46 +0200
Message-ID: <20200722080646.GA26864@lst.de>
In-Reply-To: 60c52e31e9f240718fcda0dd5c2faeca@AcuMS.aculab.com
X-Status: 
X-Keywords:                  
X-UID: 5165

--===============5088731047141625638==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2020 at 09:38:23AM +0000, David Laight wrote:
> From: Christoph Hellwig
> > Sent: 20 July 2020 13:47
> >
> > setsockopt is the last place in architecture-independ code that still
> > uses set_fs to force the uaccess routines to operate on kernel pointers.
> > =

> > This series adds a new sockptr_t type that can contained either a kernel
> > or user pointer, and which has accessors that do the right thing, and
> > then uses it for setsockopt, starting by refactoring some low-level
> > helpers and moving them over to it before finally doing the main
> > setsockopt method.
> =

> Are you planning to make the equivalent change to getsockopt()?

No.  Only setsockopt can be fed kernel addresses from bpf-cgroup.
There is no point in complicating the read side interface when it
doesn't have that problem.
--===============5088731047141625638==--
