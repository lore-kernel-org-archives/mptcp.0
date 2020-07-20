Content-Type: multipart/mixed; boundary="===============6640047396288616507=="
MIME-Version: 1.0
From: Eric Biggers <ebiggers at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 03/24] net: add a new sockptr_t type
Date: Mon, 20 Jul 2020 10:55:43 -0700
Message-ID: <20200720175543.GF1292162@gmail.com>
In-Reply-To: 20200720174322.GA21785@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5132

--===============6640047396288616507==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2020 at 07:43:22PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 20, 2020 at 09:37:48AM -0700, Eric Biggers wrote:
> > How does this not introduce a massive security hole when
> > CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE?
> > =

> > AFAICS, userspace can pass in a pointer >=3D TASK_SIZE,
> > and this code makes it be treated as a kernel pointer.
> =

> Yeah, we'll need to validate that before initializing the pointer.
> =

> But thinking this a little further:  doesn't this mean any
> set_fs(KERNEL_DS) that has other user pointers than the one it is
> intended for has the same issue?  Pretty much all of these are gone
> in mainline now, but in older stable kernels there might be some
> interesting cases, especially in the compat ioctl handlers.

Yes.  I thought that eliminating that class of bug is one of the main
motivations for your "remove set_fs" work.  See commit 128394eff343
("sg_write()/bsg_write() is not fit to be called under KERNEL_DS") for a ca=
se
where this type of bug was fixed.

Are you aware of any specific cases that weren't already fixed?  If there a=
re
any, they need to be urgently fixed.

- Eric
--===============6640047396288616507==--
