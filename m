Content-Type: multipart/mixed; boundary="===============2181733952239311196=="
MIME-Version: 1.0
From: Jason A. Donenfeld <Jason at zx2c4.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 12/26] netfilter: switch nf_setsockopt to sockptr_t
Date: Tue, 28 Jul 2020 10:17:28 +0200
Message-ID: <CAHmME9pUbRmJq1Qcj10eENt15cuQHkiXJNKrUDmmC18n2mLKDA@mail.gmail.com>
In-Reply-To: 908ed73081cc42d58a5b01e0c97dbe47@AcuMS.aculab.com
X-Status: 
X-Keywords:                  
X-UID: 5338

--===============2181733952239311196==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2020 at 10:07 AM David Laight <David.Laight(a)aculab.com> w=
rote:
>
> From: Christoph Hellwig
> > Sent: 27 July 2020 17:24
> >
> > On Mon, Jul 27, 2020 at 06:16:32PM +0200, Jason A. Donenfeld wrote:
> > > Maybe sockptr_advance should have some safety checks and sometimes
> > > return -EFAULT? Or you should always use the implementation where
> > > being a kernel address is an explicit bit of sockptr_t, rather than
> > > being implicit?
> >
> > I already have a patch to use access_ok to check the whole range in
> > init_user_sockptr.
>
> That doesn't make (much) difference to the code paths that ignore
> the user-supplied length.
> OTOH doing the user/kernel check on the base address (not an
> incremented one) means that the correct copy function is always
> selected.

Right, I had the same reaction in reading this, but actually, his code
gets rid of the sockptr_advance stuff entirely and never mutates, so
even though my point about attacking those pointers was missed, the
code does the better thing now -- checking the base address and never
mutating the pointer. So I think we're good.

>
> Perhaps the functions should all be passed a 'const sockptr_t'.
> The typedef could be made 'const' - requiring non-const items
> explicitly use the union/struct itself.

I was thinking the same, but just by making the pointers inside the
struct const. However, making the whole struct const via the typedef
is a much better idea. That'd probably require changing the signature
of init_user_sockptr a bit, which would be fine, but indeed I think
this would be a very positive change.

Jason
--===============2181733952239311196==--
