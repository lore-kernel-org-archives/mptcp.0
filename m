Content-Type: multipart/mixed; boundary="===============7875396033091829998=="
MIME-Version: 1.0
From: 'Christoph Hellwig' <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 03/26] bpfilter: reject kernel addresses
Date: Thu, 23 Jul 2020 16:44:55 +0200
Message-ID: <20200723144455.GA12280@lst.de>
In-Reply-To: c3dc5b4d84e64230bb6ca8df7bb70705@AcuMS.aculab.com
X-Status: 
X-Keywords:                  
X-UID: 5247

--===============7875396033091829998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2020 at 02:42:11PM +0000, David Laight wrote:
> From: Christoph Hellwig
> > Sent: 23 July 2020 07:09
> > =

> > The bpfilter user mode helper processes the optval address using
> > process_vm_readv.  Don't send it kernel addresses fed under
> > set_fs(KERNEL_DS) as that won't work.
> =

> What sort of operations is the bpf filter doing on the sockopt buffers?
> =

> Any attempts to reject some requests can be thwarted by a second
> application thread modifying the buffer after the bpf filter has
> checked that it allowed.
> =

> You can't do security by reading a user buffer twice.

I'm not saying that I approve of the design, but the current bpfilter
design uses process_vm_readv to access the buffer, which obviously does
not work with kernel buffers.
--===============7875396033091829998==--
