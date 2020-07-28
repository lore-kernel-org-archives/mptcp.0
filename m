Content-Type: multipart/mixed; boundary="===============2589721637363684742=="
MIME-Version: 1.0
From: David Laight <David.Laight at ACULAB.COM>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 12/26] netfilter: switch nf_setsockopt to sockptr_t
Date: Tue, 28 Jul 2020 08:07:11 +0000
Message-ID: <908ed73081cc42d58a5b01e0c97dbe47@AcuMS.aculab.com>
In-Reply-To: 20200727162357.GA8022@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5337

--===============2589721637363684742==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Christoph Hellwig
> Sent: 27 July 2020 17:24
> =

> On Mon, Jul 27, 2020 at 06:16:32PM +0200, Jason A. Donenfeld wrote:
> > Maybe sockptr_advance should have some safety checks and sometimes
> > return -EFAULT? Or you should always use the implementation where
> > being a kernel address is an explicit bit of sockptr_t, rather than
> > being implicit?
> =

> I already have a patch to use access_ok to check the whole range in
> init_user_sockptr.

That doesn't make (much) difference to the code paths that ignore
the user-supplied length.
OTOH doing the user/kernel check on the base address (not an
incremented one) means that the correct copy function is always
selected.

Perhaps the functions should all be passed a 'const sockptr_t'.
The typedef could be made 'const' - requiring non-const items
explicitly use the union/struct itself.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

--===============2589721637363684742==--
