Content-Type: multipart/mixed; boundary="===============6343564715592160988=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: Remove all traces of checksum support
Date: Tue, 24 Sep 2019 11:44:50 -0700
Message-ID: <b7d8ade679e9e5132def8d0169d3696871838734.camel@linux.intel.com>
In-Reply-To: 1c2be7cec0d1e181117102a51ee43a3f053a1975.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1919

--===============6343564715592160988==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-09-17 at 11:24 +0200, Paolo Abeni wrote:
> Hi,
> =

> On Mon, 2019-09-16 at 15:10 -0700, Peter Krystad wrote:
> > @@ -152,10 +151,27 @@ void mptcp_parse_option(const unsigned char *ptr,=
 int opsize,
> >  				expected_opsize +=3D TCPOLEN_MPTCP_DSS_ACK64;
> > =


...

> =

> > @@ -701,18 +691,11 @@ void mptcp_write_options(__be32 *ptr, struct mptc=
p_out_options *opts)
> >  		}
> >  =

> >  		if (mpext->use_map) {
> > -			__sum16 checksum;
> > -
> > -			pr_debug("Writing map values");
> >  			put_unaligned_be64(mpext->data_seq, ptr);
> >  			ptr +=3D 2;
> > -			*ptr++ =3D htonl(mpext->subflow_seq);
> > -
> > -			if (mpext->use_checksum)
> > -				checksum =3D mpext->checksum;
> > -			else
> > -				checksum =3D TCPOPT_NOP << 8 | TCPOPT_NOP;
> > -			*ptr =3D htonl(mpext->data_len << 16 | checksum);
> > +			put_unaligned_be32(mpext->subflow_seq, ptr);
> > +			ptr +=3D 1;
> > +			put_unaligned_be16(mpext->data_len, ptr);
> =

> I think we should still set 4 bytes here:
> =

> 	put_unaligned_be32(mpext->subflow_seq << 16 | TCPOPT_NOP << 8 |
> TCPOPT_NOP, ptr);
> 	=

> or we can hit some 'uninit value used' error triggered by syzbot or the
> like.

Sorry Paolo I missed this comment before. I'll send a v2.

Peter.

> Cheers,
> =

> Paolo
> =



--===============6343564715592160988==--
