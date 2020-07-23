Content-Type: multipart/mixed; boundary="===============5454621646277407022=="
MIME-Version: 1.0
From: David Laight <David.Laight at ACULAB.COM>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 03/26] bpfilter: reject kernel addresses
Date: Thu, 23 Jul 2020 14:42:11 +0000
Message-ID: <c3dc5b4d84e64230bb6ca8df7bb70705@AcuMS.aculab.com>
In-Reply-To: 20200723060908.50081-4-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5246

--===============5454621646277407022==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Christoph Hellwig
> Sent: 23 July 2020 07:09
> =

> The bpfilter user mode helper processes the optval address using
> process_vm_readv.  Don't send it kernel addresses fed under
> set_fs(KERNEL_DS) as that won't work.

What sort of operations is the bpf filter doing on the sockopt buffers?

Any attempts to reject some requests can be thwarted by a second
application thread modifying the buffer after the bpf filter has
checked that it allowed.

You can't do security by reading a user buffer twice.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

--===============5454621646277407022==--
