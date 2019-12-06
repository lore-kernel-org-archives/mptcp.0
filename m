Content-Type: multipart/mixed; boundary="===============2202367719917736560=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Remove flags field from struct
 mptcp_options_received
Date: Fri, 06 Dec 2019 08:55:00 -0800
Message-ID: <78a39ed29a00923b938014117af9b28958380147.camel@linux.intel.com>
In-Reply-To: 2c5c11e0a9e8d465d9a64c38d61dd411ef2b2814.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2829

--===============2202367719917736560==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Davide, Matt -

Thanks Davide.

This patch and the other like it are all I plan to do for part 1 for
"optimizing struct mptcp_received_options". The other MPTCP options that
really grow the size are introduced after kselftest commit.

Now that we will be v1 past kselftest I will need to modify the ADD_ADDR
handling for v1 change, and this will then effect how the struct
mptcp_received_options is optimized.

Peter.


  =

On Fri, 2019-12-06 at 09:31 +0100, Davide Caratti wrote:
> On Thu, 2019-12-05 at 15:43 -0800, Peter Krystad wrote:
> > This field is only used temporarily while parsing options,
> > use a local variable instead.
> > =

> > Also move key fields to final position and fix indents.
> > =

> > Formatted to apply directly to Handle MPTCP TCP options.
> > =

> > squashto: Handle MPTCP TCP options
> > =

> > Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> > ---
> >  include/linux/tcp.h |  7 +++----
> >  net/mptcp/options.c | 17 ++++++++---------
> >  2 files changed, 11 insertions(+), 13 deletions(-)
> =

> LGTM,
> =

> Acked-by: Davide Caratti <dcaratti(a)redhat.com>
> =

>=20

--===============2202367719917736560==--
