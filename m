Content-Type: multipart/mixed; boundary="===============1184246012721479396=="
MIME-Version: 1.0
From: David Laight <David.Laight at ACULAB.COM>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: get rid of the address_space override in setsockopt
Date: Tue, 21 Jul 2020 09:38:23 +0000
Message-ID: <60c52e31e9f240718fcda0dd5c2faeca@AcuMS.aculab.com>
In-Reply-To: 20200720124737.118617-1-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5140

--===============1184246012721479396==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Christoph Hellwig
> Sent: 20 July 2020 13:47
>
> setsockopt is the last place in architecture-independ code that still
> uses set_fs to force the uaccess routines to operate on kernel pointers.
> =

> This series adds a new sockptr_t type that can contained either a kernel
> or user pointer, and which has accessors that do the right thing, and
> then uses it for setsockopt, starting by refactoring some low-level
> helpers and moving them over to it before finally doing the main
> setsockopt method.

Are you planning to make the equivalent change to getsockopt()?
Having mismatched interfaces would be very strange.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

--===============1184246012721479396==--
