Content-Type: multipart/mixed; boundary="===============1144333732813268677=="
MIME-Version: 1.0
From: David Laight <David.Laight at ACULAB.COM>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: get rid of the address_space override in setsockopt
Date: Tue, 21 Jul 2020 10:26:58 +0000
Message-ID: <ae6a743aaea3406596dbc89e332b6b3e@AcuMS.aculab.com>
In-Reply-To: 20200720124737.118617-1-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5143

--===============1144333732813268677==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Christoph Hellwig
> Sent: 20 July 2020 13:47
> =

> setsockopt is the last place in architecture-independ code that still
> uses set_fs to force the uaccess routines to operate on kernel pointers.
> =

> This series adds a new sockptr_t type that can contained either a kernel
> or user pointer, and which has accessors that do the right thing, and
> then uses it for setsockopt, starting by refactoring some low-level
> helpers and moving them over to it before finally doing the main
> setsockopt method.

Another 'gotcha' ...

On an least some architectures (possibly only m68k) IIRC all structures
are actually passed by reference.
(This used to be true for sparc - but it may have changed in the
last 30 years.)

	David
 =


-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

--===============1144333732813268677==--
