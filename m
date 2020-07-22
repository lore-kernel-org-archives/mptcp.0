Content-Type: multipart/mixed; boundary="===============4283275145926816162=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: get rid of the address_space override in setsockopt
Date: Wed, 22 Jul 2020 09:56:57 +0200
Message-ID: <20200722075657.GB26554@lst.de>
In-Reply-To: 20200720204756.iengwcguikj2yrxt@ast-mbp.dhcp.thefacebook.com
X-Status: 
X-Keywords:                  
X-UID: 5162

--===============4283275145926816162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2020 at 01:47:56PM -0700, Alexei Starovoitov wrote:
> > a kernel pointer.  This is something that works for most common sockopts
> > (and is something that the ePBF support relies on), but unfortunately
> > in various corner cases we either don't use the passed in length, or in
> > one case actually copy data back from setsockopt, so we unfortunately
> > can't just always do the copy in the highlevel code, which would have
> > been much nicer.
> =

> could you rebase on bpf-next tree and we can route it this way then?
> we'll also test the whole thing before applying.

The bpf-next tree is missing all my previous setsockopt cleanups, so
there series won't apply.
--===============4283275145926816162==--
