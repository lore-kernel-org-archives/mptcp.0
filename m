Content-Type: multipart/mixed; boundary="===============7965933455888976902=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Optimize DSS fields in
 mptcp_options_received
Date: Fri, 17 Jan 2020 14:00:22 -0800
Message-ID: <d95c33c1557f0a34cee0b8684058a361cbc77e46.camel@linux.intel.com>
In-Reply-To: 5cb6c4ec11a9ecf7d9b6b4b9b839531dc3f40690.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3412

--===============7965933455888976902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-01-17 at 19:40 +0100, Paolo Abeni wrote:
> On Fri, 2020-01-17 at 10:08 -0800, Mat Martineau wrote:
> > On Thu, 16 Jan 2020, Peter Krystad wrote:
> > =

> > > Use union to minimize space used in structure.
> > > Allow 32-bit DSS to be received at the same time as MP_CAPABLE.
> > > =

> > > squashto: Implement MPTCP receive path
> > > =

> > > Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> > > ---
> > > include/linux/tcp.h | 18 ++++++++++++------
> > > 1 file changed, 12 insertions(+), 6 deletions(-)
> > > =

> > > diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> > > index 6abf8d9f1a42..a9200a86a6d2 100644
> > > --- a/include/linux/tcp.h
> > > +++ b/include/linux/tcp.h
> > > @@ -80,12 +80,18 @@ struct tcp_sack_block {
> > > =

> > > #if IS_ENABLED(CONFIG_MPTCP)
> > > struct mptcp_options_received {
> > > -	u64	sndr_key;
> > > -	u64	rcvr_key;
> > > -	u32	data_ack32;
> > > -	u32	data_seq32;
> > > -	u64	data_ack;
> > > -	u64	data_seq;
> > > +	union {
> > > +		struct {
> > > +			u64	sndr_key;
> > > +			u64	rcvr_key;
> > > +			u32	data_ack32;
> > > +			u32	data_seq32;
> > > +		};
> > > +		struct {
> > > +			u64	data_ack;
> > > +			u64	data_seq;
> > > +		};
> > > +	};
> > =

> > If one of the goals is to ensure that mixed 32/64 ack/seq is working (a=
s =

> > mentioned in next commit message), I think it would be better to expres=
s =

> > that as a union with the data_ack/data_seq and sndr_key/rcvr_key values =

> > rather than depend on struct alignment:
> > =

> >  	struct {
> >  		union {
> >  			struct {
> >  				u64	sndr_key;
> >  				u64	rcvr_key;
> >  			};
> >  			struct {
> >  				u64	data_ack;
> >  				u64	data_seq;
> >  			};
> >  		};
> >  		u32	data_ack32;
> >  		u32	data_seq32;
> >  	};
> =

> I'm really low on coffee here, so please perdom me for the likely dumb
> comment, but... =

> =

> why do we need data_*32 and  *_key simult? I think we don't allow MPC
> and DSS in the same packet ?!?

The mutipath-tcp.org implementation would do this so (and also data_*32 + I=
Pv4
add_addr). If we know we won't ever do these combinations, and we only want=
 to
work with ourselves, then it is not necessary.

Peter.

> Thanks,
> =

> Paolo
>=20

--===============7965933455888976902==--
