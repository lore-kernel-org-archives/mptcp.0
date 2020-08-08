Content-Type: multipart/mixed; boundary="===============1364580697806971291=="
MIME-Version: 1.0
From: David Laight <David.Laight at ACULAB.COM>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 25/26] net: pass a sockptr_t into ->setsockopt
Date: Sat, 08 Aug 2020 13:54:06 +0000
Message-ID: <ed3741fdf1774cfbbd59d06ecb6994d8@AcuMS.aculab.com>
In-Reply-To: 90f626a4-d9e5-91a5-b71d-498e3b125da1@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5527

--===============1364580697806971291==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Eric Dumazet
> Sent: 07 August 2020 19:29
> =

> On 8/7/20 2:18 AM, David Laight wrote:
> > From: Eric Dumazet
> >> Sent: 06 August 2020 23:21
> >>
> >> On 7/22/20 11:09 PM, Christoph Hellwig wrote:
> >>> Rework the remaining setsockopt code to pass a sockptr_t instead of a
> >>> plain user pointer.  This removes the last remaining set_fs(KERNEL_DS)
> >>> outside of architecture specific code.
> >>>
> >>> Signed-off-by: Christoph Hellwig <hch(a)lst.de>
> >>> Acked-by: Stefan Schmidt <stefan(a)datenfreihafen.org> [ieee802154]
> >>> ---
> >>
> >>
> >> ...
> >>
> >>> diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
> >>> index 594e01ad670aa6..874f01cd7aec42 100644
> >>> --- a/net/ipv6/raw.c
> >>> +++ b/net/ipv6/raw.c
> >>> @@ -972,13 +972,13 @@ static int rawv6_sendmsg(struct sock *sk, struc=
t msghdr *msg, size_t len)
> >>>  }
> >>>
> >>
> >> ...
> >>
> >>>  static int do_rawv6_setsockopt(struct sock *sk, int level, int optna=
me,
> >>> -			    char __user *optval, unsigned int optlen)
> >>> +			       sockptr_t optval, unsigned int optlen)
> >>>  {
> >>>  	struct raw6_sock *rp =3D raw6_sk(sk);
> >>>  	int val;
> >>>
> >>> -	if (get_user(val, (int __user *)optval))
> >>> +	if (copy_from_sockptr(&val, optval, sizeof(val)))
> >>>  		return -EFAULT;
> >>>
> >>
> >> converting get_user(...)   to  copy_from_sockptr(...) really assumed t=
he optlen
> >> has been validated to be >=3D sizeof(int) earlier.
> >>
> >> Which is not always the case, for example here.
> >>
> >> User application can fool us passing optlen=3D0, and a user pointer of=
 exactly TASK_SIZE-1
> >
> > Won't the user pointer force copy_from_sockptr() to call
> > copy_from_user() which will then do access_ok() on the entire
> > range and so return -EFAULT.
> >
> > The only problems arise if the kernel code adds an offset to the
> > user address.
> > And the later patch added an offset to the copy functions.
> =

> I dunno, I definitely got the following syzbot crash
> =

> No repro found by syzbot yet, but I suspect a 32bit binary program
> did :
> =

> setsockopt(fd, 0x29, 0x24, 0xffffffffffffffff, 0x0)

A few too many ffs...

> BUG: KASAN: wild-memory-access in memcpy include/linux/string.h:406 [inli=
ne]
> BUG: KASAN: wild-memory-access in copy_from_sockptr_offset include/linux/=
sockptr.h:71 [inline]
> BUG: KASAN: wild-memory-access in copy_from_sockptr include/linux/sockptr=
.h:77 [inline]
> BUG: KASAN: wild-memory-access in do_rawv6_setsockopt net/ipv6/raw.c:1023=
 [inline]
> BUG: KASAN: wild-memory-access in rawv6_setsockopt+0x1a1/0x6f0 net/ipv6/r=
aw.c:1084
> Read of size 4 at addr 00000000ffffffff by task syz-executor.0/28251

Yep, the code is nearly, but not quite right.
The problem is almost certainly that access_ok(x, 0) always returns success.

In any case the check for a valid user address ought to be exactly
the same one that later selects between copy_to/from_user() and memcpy().

The latter compares the address against 'TASK_SIZE'.
However that isn't the right value either - I think it reads
the value from 'current' that set_fs() sets.
What this code needs is any address that is above the highest
user address and below (or equal to) to lowest kernel one.

On i386 (and probably most 32bit linux) this is 0xc0000000.
On x86-64 this could be any address in the address 'black hole'.
Picking 1ull<<63 may be best.
Quite what the correct #define is requires further research.

There is actually scope for making init_user_sockptr(kern_address)
save a value that will cause copy_to/from_sockptr() go into
the user-copy path with an address that access_ok() will reject.
Then the -EFAULT will get generated in the 'expected' place
and there is no scope for failing to test it's return value.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

--===============1364580697806971291==--
