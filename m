Content-Type: multipart/mixed; boundary="===============2378356360069854809=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH v3 05/16] tcp: Add IPPROTO_SUBFLOW
Date: Wed, 10 Oct 2018 13:15:01 -0700
Message-ID: <20181010201501.GD36310@MacBook-Pro-19.local>
In-Reply-To: 1539200845.19533.14.camel@intel.com
X-Status: 
X-Keywords:                  
X-UID: 814

--===============2378356360069854809==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 10/10/18 - 19:47:29, Krystad, Peter wrote:
> On Tue, 2018-10-09 at 20:35 -0700, Mat Martineau wrote:
> > On Tue, 9 Oct 2018, Matthieu Baerts wrote:
> > =

> > > On Sat, Oct 6, 2018 at 1:04 AM Mat Martineau
> > > <mathew.j.martineau(a)linux.intel.com> wrote:
> > > > =

> > > > From: Peter Krystad <peter.krystad(a)intel.com>
> > > > =

> > > > IANA protocol numbers fit in a single byte, however the protocol fi=
eld
> > > > of struct inet_protosw is an unsigned short so defining IPPROTO_SUB=
FLOW
> > > > as a 16-bit value greater than 0xFF with the same LSB as IPPROTO_TC=
P is
> > > > convenient for registering a unique protocol with inet_register_pro=
tosw()
> > > > that still transmits packets with IPPROTO_TCP as the protocol numbe=
r.
> > > =

> > > Should we then call it IPPROTO_TCP_SUBFLOW? :)
> > > =

> > =

> > Hopefully we won't need a special IPPROTO_ for the subflows in the long =

> > run. It could be defined internally for kernel code with some checks to =

> > prevent userspace-owned sockets of this type. Since the MPTCP kernel co=
de =

> > has complete control over the subflow sockets, maybe we could create =

> > regular TCP sockets and modify them before using them (kind of like ULP =

> > does, but without using the ULP infrastructure between an MPTCP socket =
and =

> > its subflows).
> > =

> > Mat
> > =

> The purpose of my approach with IPPROTO_SUBFLOW was it reduced a lot of
> impacts to the TCP code by allowing overriding all the 'struct proto'
> routines, and defining the sock structure size as the size of
> subflow_sock. Tradeoff would be more "if (sk->is_mptcp)" hooks in TCP
> code.

Yes, I think it's a good approach to have a separate struct proto for
subflows.


Christoph

> =

> Peter.
> =

> > =

> > > > =

> > > > Signed-off-by: Peter Krystad <peter.krystad(a)intel.com>
> > > > ---
> > > >  include/uapi/linux/in.h | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > > =

> > > > diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
> > > > index f65975c801e5..6986aecd0f46 100644
> > > > --- a/include/uapi/linux/in.h
> > > > +++ b/include/uapi/linux/in.h
> > > > @@ -78,6 +78,8 @@ enum {
> > > >  #define IPPROTO_MPLS           IPPROTO_MPLS
> > > >    IPPROTO_RAW =3D 255,           /* Raw IP packets                =
       */
> > > >  #define IPPROTO_RAW            IPPROTO_RAW
> > > > +  IPPROTO_SUBFLOW =3D 262,       /* Multipath TCP (IPPROTO_TCP | 0=
x100)  */
> > > > +#define IPPROTO_SUBFLOW                IPPROTO_SUBFLOW
> > > >    IPPROTO_MAX
> > > >  };
> > > >  #endif
> > > > --
> > > > 2.19.1
> > > > =

> > > > _______________________________________________
> > > > mptcp mailing list
> > > > mptcp(a)lists.01.org
> > > > https://lists.01.org/mailman/listinfo/mptcp
> > > =

> > > =

> > > =

> > > -- =

> > > Matthieu Baerts | R&D Engineer
> > > matthieu.baerts(a)tessares.net
> > > Tessares SA | Hybrid Access Solutions
> > > www.tessares.net
> > > 1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
> > > =

> > > Disclaimer: https://www.tessares.net/mail-disclaimer/
> > > =

> > =

> > --
> > Mat Martineau
> > Intel OTC
> > _______________________________________________
> > mptcp mailing list
> > mptcp(a)lists.01.org
> > https://lists.01.org/mailman/listinfo/mptcp
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp

--===============2378356360069854809==--
