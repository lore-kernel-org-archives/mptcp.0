Content-Type: multipart/mixed; boundary="===============3438843062155531631=="
MIME-Version: 1.0
From: Ido Schimmel <idosch at idosch.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 19/26] net/ipv6: switch ipv6_flowlabel_opt to
 sockptr_t
Date: Mon, 27 Jul 2020 21:22:59 +0300
Message-ID: <20200727182259.GA1931870@shredder>
In-Reply-To: 20200727161555.GA7817@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5328

--===============3438843062155531631==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2020 at 06:15:55PM +0200, Christoph Hellwig wrote:
> I have to admit I didn't spot the difference between the good and the
> bad output even after trying hard..
> =

> But can you try the patch below?
> =

> ---
> From cce2d2e1b43ecee5f4af7cf116808b74b330080f Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch(a)lst.de>
> Date: Mon, 27 Jul 2020 17:42:27 +0200
> Subject: net: remove sockptr_advance
> =

> sockptr_advance never properly worked.  Replace it with _offset variants
> of copy_from_sockptr and copy_to_sockptr.
> =

> Fixes: ba423fdaa589 ("net: add a new sockptr_t type")
> Reported-by: Jason A. Donenfeld <Jason(a)zx2c4.com>
> Reported-by: Ido Schimmel <idosch(a)idosch.org>
> Signed-off-by: Christoph Hellwig <hch(a)lst.de>

Tested-by: Ido Schimmel <idosch(a)mellanox.com>

Thanks!
--===============3438843062155531631==--
