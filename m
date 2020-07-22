Content-Type: multipart/mixed; boundary="===============1786381816393167185=="
MIME-Version: 1.0
From: Alexei Starovoitov <alexei.starovoitov at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: get rid of the address_space override in setsockopt
Date: Wed, 22 Jul 2020 10:09:41 -0700
Message-ID: <CAADnVQKy0+rsRftEzp4PvxQtj7uOwybz0Nd4_h0FR37p2Q=X4w@mail.gmail.com>
In-Reply-To: 20200722075657.GB26554@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5180

--===============1786381816393167185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2020 at 12:56 AM Christoph Hellwig <hch(a)lst.de> wrote:
>
> On Mon, Jul 20, 2020 at 01:47:56PM -0700, Alexei Starovoitov wrote:
> > > a kernel pointer.  This is something that works for most common socko=
pts
> > > (and is something that the ePBF support relies on), but unfortunately
> > > in various corner cases we either don't use the passed in length, or =
in
> > > one case actually copy data back from setsockopt, so we unfortunately
> > > can't just always do the copy in the highlevel code, which would have
> > > been much nicer.
> >
> > could you rebase on bpf-next tree and we can route it this way then?
> > we'll also test the whole thing before applying.
>
> The bpf-next tree is missing all my previous setsockopt cleanups, so
> there series won't apply.

Right. I've realized that after sending that email two days ago.
Now bpf-next->net-next PR is pending and as soon as it's merged
bpf-next will have all the recent bits.
--===============1786381816393167185==--
