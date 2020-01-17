Content-Type: multipart/mixed; boundary="===============4850305189318552628=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Optimize DSS fields in
 mptcp_options_received
Date: Fri, 17 Jan 2020 19:40:57 +0100
Message-ID: <5cb6c4ec11a9ecf7d9b6b4b9b839531dc3f40690.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.2001170950400.60719@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 3408

--===============4850305189318552628==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-01-17 at 10:08 -0800, Mat Martineau wrote:
> On Thu, 16 Jan 2020, Peter Krystad wrote:
> =

> > Use union to minimize space used in structure.
> > Allow 32-bit DSS to be received at the same time as MP_CAPABLE.
> > =

> > squashto: Implement MPTCP receive path
> > =

> > Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> > ---
> > include/linux/tcp.h | 18 ++++++++++++------
> > 1 file changed, 12 insertions(+), 6 deletions(-)
> > =

> > diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> > index 6abf8d9f1a42..a9200a86a6d2 100644
> > --- a/include/linux/tcp.h
> > +++ b/include/linux/tcp.h
> > @@ -80,12 +80,18 @@ struct tcp_sack_block {
> > =

> > #if IS_ENABLED(CONFIG_MPTCP)
> > struct mptcp_options_received {
> > -	u64	sndr_key;
> > -	u64	rcvr_key;
> > -	u32	data_ack32;
> > -	u32	data_seq32;
> > -	u64	data_ack;
> > -	u64	data_seq;
> > +	union {
> > +		struct {
> > +			u64	sndr_key;
> > +			u64	rcvr_key;
> > +			u32	data_ack32;
> > +			u32	data_seq32;
> > +		};
> > +		struct {
> > +			u64	data_ack;
> > +			u64	data_seq;
> > +		};
> > +	};
> =

> If one of the goals is to ensure that mixed 32/64 ack/seq is working (as =

> mentioned in next commit message), I think it would be better to express =

> that as a union with the data_ack/data_seq and sndr_key/rcvr_key values =

> rather than depend on struct alignment:
> =

>  	struct {
>  		union {
>  			struct {
>  				u64	sndr_key;
>  				u64	rcvr_key;
>  			};
>  			struct {
>  				u64	data_ack;
>  				u64	data_seq;
>  			};
>  		};
>  		u32	data_ack32;
>  		u32	data_seq32;
>  	};

I'm really low on coffee here, so please perdom me for the likely dumb
comment, but... =


why do we need data_*32 and  *_key simult? I think we don't allow MPC
and DSS in the same packet ?!?

Thanks,

Paolo

--===============4850305189318552628==--
