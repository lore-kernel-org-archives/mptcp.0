Content-Type: multipart/mixed; boundary="===============2644527273981640355=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 1/2] mptcp: send out
 dedicated ADD_ADDR packet
Date: Wed, 30 Sep 2020 18:04:56 -0700
Message-ID: <20201001010456.GL19948@MacBook-Pro.local>
In-Reply-To: 27b358e8-cff0-0efa-c0c9-484ce8ad6d00@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6122

--===============2644527273981640355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 09/30/20 - 11:31, Matthieu Baerts wrote:
> Hi Christoph, Paolo, Geliang,
> =

> On 29/09/2020 20:07, Christoph Paasch wrote:
> > On 09/29/20 - 11:30, Paolo Abeni wrote:
> > > On Mon, 2020-09-28 at 15:46 +0800, Geliang Tang wrote:
> =

> (...)
> =

> > > > -	/* If the first established packet does not contain MP_CAPABLE
> > > > + data
> > > > +	/* If the first established packet does not contain MP_CAPABLE
> > > > + data or ADD_ADDR
> > > >   	 * then fallback to TCP
> > > >   	 */
> > > > -	if (!mp_opt->mp_capable) {
> > > > +	if (!mp_opt->mp_capable && !mp_opt->add_addr) {
> > > >   		subflow->mp_capable =3D 0;
> > > >   		pr_fallback(msk);
> > > >   		__mptcp_do_fallback(msk);
> > > =

> > > I think the RFC is a bit unclear with this point, because in
> > > section 3.4.1. says:
> > > =

> > > """
> > > This [ADD_ADDR] option can be used at any time during a connection
> > > """
> > > =

> > > but also says that here we expect a mp_capable + data packet.
> > > =

> > > @Christoph, should we accept ADD_ADDR here or should we reject them?
> > =

> > I think we should accept them. There are 2 things that can happen:
> > =

> > * MP_CAPABLE + data comes later on. In that case we can use the received
> >    addr.
> >    Note, for this to happen I am assuming that the ADD_ADDR comes on an
> >    out-of-order packet and that the MP_CAPABLE will still come on the p=
acket
> >    with relative sequence-number 1.
> =

> If the ADD_ADDR comes on an out-of-order packet and because it is a ACK
> without data, is it not dropped earlier by the TCP stack?
> I think we have this behaviour with mptcp.org version.

No, as far as I can see in mptcp.org we do parse the ADD_ADDR even if we
haven't yet received an MP_CAPABLE with data.

cfr., mptcp_handle_options, called from tcp_validate_incoming, which is
called even on ACKs without data.


Christoph

> =

> Cheers,
> Matt
> -- =

> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
--===============2644527273981640355==--
