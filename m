Content-Type: multipart/mixed; boundary="===============5390017434471626296=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 03/12] mptcp: trigger msk processing even for
 OoO data
Date: Mon, 03 Aug 2020 14:09:11 +0200
Message-ID: <20200803120911.GN29169@breakpoint.cc>
In-Reply-To: 5058b1696c5821aa29983a098cbf8d17c1db8c9f.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5438

--===============5390017434471626296==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Sun, 2020-08-02 at 00:30 +0200, Florian Westphal wrote:
> > Paolo Abeni <pabeni(a)redhat.com> wrote:
> > > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > > index beb34b8a5363..e964f3670d75 100644
> > > --- a/net/mptcp/protocol.h
> > > +++ b/net/mptcp/protocol.h
> > > @@ -268,6 +268,9 @@ mptcp_subflow_rsk(const struct request_sock *rsk)
> > >  	return (struct mptcp_subflow_request_sock *)rsk;
> > >  }
> > >  =

> > > +#define MPTCP_SUBFLOW_DATA_AVAIL	1
> > > +#define MPTCP_SUBFLOW_OOO_DATA		2
> > =

> > Nit: maybe make this an enum. =

> =

> And move it outside the bitfield, right? well, looks like the standard
> should allows that, but I would prefer not mixing enum and int into the
> bitfield...

I would not mix it with bitfield either.

> > OTOH, at the end of the series,
> > OOO_DATA seems to be set but never used?
> =

> It' used "indirectly" in mptcp_data_ready(). The latter is called when =

> data_avail !=3D 0, but wakes-up the reader only if
> =

> 	data_avail =3D=3D MPTCP_SUBFLOW_DATA_AVAIL

Ah, yes, thanks for explaining.
--===============5390017434471626296==--
