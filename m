Content-Type: multipart/mixed; boundary="===============6611431371147443164=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v8 mptcp-next 0/8] Add REMOVE_ADDR support
Date: Wed, 02 Sep 2020 17:20:12 +0200
Message-ID: <0b745566127668456049f6af4c7372c838a35fbb.camel@redhat.com>
In-Reply-To: CA+WQbwvYqYZYq0CNHYiO0+_1WMQzaf6k8h8-BX15VHE4u=hX3Q@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5698

--===============6611431371147443164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-09-02 at 19:30 +0800, Geliang Tang wrote:
> Hi Paolo,
> =

> Thanks for your review.
> =

> Paolo Abeni <pabeni(a)redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=882=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8812:02=E5=86=99=E9=81=93=EF=BC=9A
> > On Mon, 2020-08-24 at 19:36 +0800, Geliang Tang wrote:
> > > v8:
> > >  - drop anno_list in v7.
> > >    We don't need to add a new list, conn_list is enough for the signal
> > > address and local subflow.
> > =

> > I think this could be problematic.
> > =

> > An MPTCP socket could refuse or delay the creation of new subflows for
> > addresses received via ADD_ADDR.
> > =

> > But an MPTCP should send REMOVE_ADDR for accounced addresses, even if
> > no subflows exists on top of them.
> > =

> > Removing the anno_list we lose this ability.
> =

> Yes, we can't cover this case, but the v7 code with anno_list can't cover
> it either. Since anno_list only recorded the local announced addresses,
> we need also record the received addresses on the remote side.

I think we don't need this latter list ?!? when the mptcp receives an
ADD_ADDR option it will either create a new subflow with such address
or will never use such address later.

When the mptcp stack receives a REMOVE_ADDR option, it just need to
check vs the existing subflows. If the relevant address has been
ignored, no additional action is needed.

Do I miss something?

Thanks!

Paolo

--===============6611431371147443164==--
