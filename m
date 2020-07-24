Content-Type: multipart/mixed; boundary="===============0830701736428161457=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: get rid of the address_space override in setsockopt v2
Date: Fri, 24 Jul 2020 15:43:42 -0700
Message-ID: <20200724.154342.1433271593505001306.davem@davemloft.net>
In-Reply-To: 20200723060908.50081-1-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5294

--===============0830701736428161457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Christoph Hellwig <hch(a)lst.de>
Date: Thu, 23 Jul 2020 08:08:42 +0200

> setsockopt is the last place in architecture-independ code that still
> uses set_fs to force the uaccess routines to operate on kernel pointers.
> =

> This series adds a new sockptr_t type that can contained either a kernel
> or user pointer, and which has accessors that do the right thing, and
> then uses it for setsockopt, starting by refactoring some low-level
> helpers and moving them over to it before finally doing the main
> setsockopt method.
> =

> Note that apparently the eBPF selftests do not even cover this path, so
> the series has been tested with a testing patch that always copies the
> data first and passes a kernel pointer.  This is something that works for
> most common sockopts (and is something that the ePBF support relies on),
> but unfortunately in various corner cases we either don't use the passed
> in length, or in one case actually copy data back from setsockopt, or in
> case of bpfilter straight out do not work with kernel pointers at all.
> =

> Against net-next/master.
> =

> Changes since v1:
>  - check that users don't pass in kernel addresses
>  - more bpfilter cleanups
>  - cosmetic mptcp tweak

Series applied to net-next, I'm build testing and will push this out when
that is done.

Thanks.
--===============0830701736428161457==--
