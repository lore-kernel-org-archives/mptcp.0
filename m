Content-Type: multipart/mixed; boundary="===============4961959112822496282=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 1/2] mptcp: refactor recvmsg()
Date: Wed, 18 Sep 2019 11:27:00 +0200
Message-ID: <8722cc5a3e24820317a0e39bc02be900482fe347.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.1909171600520.32589@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 1874

--===============4961959112822496282==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-09-17 at 16:05 -0700, Mat Martineau wrote:
> @@ -658,60 +653,44 @@ static int mptcp_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
> > =

> > 		if (unlikely(before(ssn, subflow->map_subflow_seq))) {
> > 			/* Mapping covers data later in the subflow stream,
> > -			 * discard unmapped data.
> > +			 * currently unsupported.
> > 			 */
> > -			pr_debug("Mapping covers data later in stream");
> > -			discard_len =3D subflow->map_subflow_seq - ssn;
> > +			WARN_ONCE(1, "Mapping covers data later in stream");
> > +			copied =3D -EBADFD;
> > +			break;
> > 		} else if (unlikely(!before(ssn, (subflow->map_subflow_seq +
> > 						  subflow->map_data_len)))) {
> > 			/* Mapping ends earlier in the subflow stream.
> > -			 * Invalidate the mapping and try again.
> > +			 * Invalid
> > 			 */
> > -			subflow->map_valid =3D 0;
> > -			pr_debug("Invalid mapping ssn=3D%d map_seq=3D%d map_data_len=3D%d",
> > -				 ssn, subflow->map_subflow_seq,
> > -				 subflow->map_data_len);
> > -			continue;
> > -		} else {
> > -			ack_seq =3D get_mapped_dsn(subflow);
> > -
> > -			if (before64(ack_seq, old_ack)) {
> > -				/* Mapping covers data already received,
> > -				 * discard data in the current mapping
> > -				 * and invalidate the map
> > -				 */
> > -				u64 map_end_dsn =3D subflow->map_seq +
> > -					subflow->map_data_len;
> > -				discard_len =3D min(map_end_dsn - ack_seq,
> > -						  old_ack - ack_seq);
> > -				subflow->map_valid =3D 0;
> > -				pr_debug("Duplicate MPTCP data found");
> > -			}
> > +			WARN_ONCE(1, "Mapping covers old data ssn=3D%d "
> > +				  "map_seq=3D%d map_data_len=3D%d", ssn,
> =

> Checkpatch will complain about concatenating string constants like this - =

> it allows long lines when string constants are involved.

Thank you for the review.

I was unable to compress the message in a single line fitting 80 chars,
so I opted for splitting it (checkpatch would complain anyway)

I'll mangle the messages and re-submit (fixing the typo in 2/2, too)

Thanks,

Paolo



--===============4961959112822496282==--
