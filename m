Content-Type: multipart/mixed; boundary="===============2708753533144529878=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: Remove all traces of checksum support
Date: Wed, 02 Oct 2019 09:51:24 -0700
Message-ID: <325df870ab39050f1673894d610d952c121ecaa3.camel@linux.intel.com>
In-Reply-To: c1ea0ccb-aa7f-24de-8903-be2f6218300d@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1988

--===============2708753533144529878==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-10-02 at 11:33 +0200, Matthieu Baerts wrote:
> Hi Peter,
> =

> On 01/10/2019 14:14, Matthieu Baerts wrote:
> > Hi Paolo, Peter,
> > =

> > On 30/09/2019 16:08, Paolo Abeni wrote:
> > > Hi,
> > > =

> > > On Wed, 2019-09-25 at 16:44 -0700, Peter Krystad wrote:
> > > > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > > > index f1f5ab3990ab..400fbb0060f3 100644
> > > > --- a/net/mptcp/protocol.h
> > > > +++ b/net/mptcp/protocol.h
> > > > @@ -173,7 +173,7 @@ struct subflow_request_sock {
> > > >  	struct	tcp_request_sock sk;
> > > >  	u8	mp_capable : 1,
> > > >  		mp_join : 1,
> > > > -		checksum : 1,
> > > > +		unused : 1,
> > > >  		backup : 1,
> > > >  		version : 4;
> > > >  	u8	local_id;
> > > =

> > > Sorry I did not notice this beforehand. It looks a little strange to =
me
> > > creating a new struct with some 'unused' field. But I think is not
> > > blocking: we can merge the patch as-is and ev. drop the field later -
> > > if there is agreement on that.
> > =

> > I agree that it is certainly better to remove it in this context.
> =

> I hope you don't mind if I remove this "unused" field when applying your
> patch. I had to apply this bit manually anyway and I guess if we need an
> "unused" field, it would be better at the end.

No problem.

Peter.

> I can of course still change that again later if needed!
> =

> Cheers,
> Matt

--===============2708753533144529878==--
