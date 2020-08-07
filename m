Content-Type: multipart/mixed; boundary="===============4797757937420349283=="
MIME-Version: 1.0
From: David Laight <David.Laight at ACULAB.COM>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 25/26] net: pass a sockptr_t into ->setsockopt
Date: Fri, 07 Aug 2020 09:18:03 +0000
Message-ID: <f21589f1262640b09ca27ed20f8e6790@AcuMS.aculab.com>
In-Reply-To: 6357942b-0b6e-1901-7dce-e308c9fac347@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5507

--===============4797757937420349283==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Eric Dumazet
> Sent: 06 August 2020 23:21
> =

> On 7/22/20 11:09 PM, Christoph Hellwig wrote:
> > Rework the remaining setsockopt code to pass a sockptr_t instead of a
> > plain user pointer.  This removes the last remaining set_fs(KERNEL_DS)
> > outside of architecture specific code.
> >
> > Signed-off-by: Christoph Hellwig <hch(a)lst.de>
> > Acked-by: Stefan Schmidt <stefan(a)datenfreihafen.org> [ieee802154]
> > ---
> =

> =

> ...
> =

> > diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
> > index 594e01ad670aa6..874f01cd7aec42 100644
> > --- a/net/ipv6/raw.c
> > +++ b/net/ipv6/raw.c
> > @@ -972,13 +972,13 @@ static int rawv6_sendmsg(struct sock *sk, struct =
msghdr *msg, size_t len)
> >  }
> >
> =

> ...
> =

> >  static int do_rawv6_setsockopt(struct sock *sk, int level, int optname,
> > -			    char __user *optval, unsigned int optlen)
> > +			       sockptr_t optval, unsigned int optlen)
> >  {
> >  	struct raw6_sock *rp =3D raw6_sk(sk);
> >  	int val;
> >
> > -	if (get_user(val, (int __user *)optval))
> > +	if (copy_from_sockptr(&val, optval, sizeof(val)))
> >  		return -EFAULT;
> >
> =

> converting get_user(...)   to  copy_from_sockptr(...) really assumed the =
optlen
> has been validated to be >=3D sizeof(int) earlier.
> =

> Which is not always the case, for example here.
> =

> User application can fool us passing optlen=3D0, and a user pointer of ex=
actly TASK_SIZE-1

Won't the user pointer force copy_from_sockptr() to call
copy_from_user() which will then do access_ok() on the entire
range and so return -EFAULT.

The only problems arise if the kernel code adds an offset to the
user address.
And the later patch added an offset to the copy functions.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

--===============4797757937420349283==--
