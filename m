Content-Type: multipart/mixed; boundary="===============1727151547593690565=="
MIME-Version: 1.0
From: Al Viro <viro at zeniv.linux.org.uk>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 02/24] bpfilter: fix up a sparse annotation
Date: Tue, 21 Jul 2020 06:28:21 +0100
Message-ID: <20200721052821.GS2786714@ZenIV.linux.org.uk>
In-Reply-To: 20200721052326.GA10071@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5138

--===============1727151547593690565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2020 at 07:23:26AM +0200, Christoph Hellwig wrote:
> On Tue, Jul 21, 2020 at 04:40:16AM +0200, Luc Van Oostenryck wrote:
> > >  	req.pid =3D current->pid;
> > >  	req.cmd =3D optname;
> > > -	req.addr =3D (long __force __user)optval;
> > > +	req.addr =3D (__force long)optval;
> > =

> > For casts to integers, even '__force' is not needed (since integers
> > can't be dereferenced, the concept of address-space is meaningless
> > for them, so it's never useful to warn when it's dropped and
> > '__force' is thus not needed).
> =

> That's what I thought. but if I remove it here I actually do get a
> warning:
> =

> CHECK   net/bpfilter/bpfilter_kern.c
> net/bpfilter/bpfilter_kern.c:52:21: warning: cast removes address space '=
__user' of expression

Cast to unsigned long.  Or to uintptr_t if you want to be fancy.
--===============1727151547593690565==--
