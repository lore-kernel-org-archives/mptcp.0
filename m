Content-Type: multipart/mixed; boundary="===============3826787781737014170=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 03/24] net: add a new sockptr_t type
Date: Mon, 20 Jul 2020 19:43:22 +0200
Message-ID: <20200720174322.GA21785@lst.de>
In-Reply-To: 20200720163748.GA1292162@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5130

--===============3826787781737014170==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2020 at 09:37:48AM -0700, Eric Biggers wrote:
> How does this not introduce a massive security hole when
> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE?
> =

> AFAICS, userspace can pass in a pointer >=3D TASK_SIZE,
> and this code makes it be treated as a kernel pointer.

Yeah, we'll need to validate that before initializing the pointer.

But thinking this a little further:  doesn't this mean any
set_fs(KERNEL_DS) that has other user pointers than the one it is
intended for has the same issue?  Pretty much all of these are gone
in mainline now, but in older stable kernels there might be some
interesting cases, especially in the compat ioctl handlers.
--===============3826787781737014170==--
