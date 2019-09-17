Content-Type: multipart/mixed; boundary="===============0749654570092613985=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: Remove all traces of checksum support
Date: Tue, 17 Sep 2019 11:24:00 +0200
Message-ID: <1c2be7cec0d1e181117102a51ee43a3f053a1975.camel@redhat.com>
In-Reply-To: 20190916221016.16210-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1859

--===============0749654570092613985==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 2019-09-16 at 15:10 -0700, Peter Krystad wrote:
> @@ -152,10 +151,27 @@ void mptcp_parse_option(const unsigned char *ptr, i=
nt opsize,
>  				expected_opsize +=3D TCPOLEN_MPTCP_DSS_ACK64;
>  			else
>  				expected_opsize +=3D TCPOLEN_MPTCP_DSS_ACK32;
> +		}
> +
> +		if (mp_opt->use_map) {
> +			if (mp_opt->dsn64)
> +				expected_opsize +=3D TCPOLEN_MPTCP_DSS_MAP64;
> +			else
> +				expected_opsize +=3D TCPOLEN_MPTCP_DSS_MAP32;
> +		}
>  =

> -			if (opsize < expected_opsize)
> -				break;
> +		/* RFC 6824, Section 3.3:
> +		 * If a checksum is present, but its use had
> +		 * not been negotiated in the MP_CAPABLE handshake,
> +		 * the checksum field MUST be ignored.
> +		 */
> +		if (opsize !=3D expected_opsize &&
> +		    opsize !=3D expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM)
> +			break;

My understanding is that we should look for RFC 6824 bis compliance -
is that correct? =


If so, than we should reset the subflow connection if opsize =3D=3D
expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM, and just ignore other bad
len. Is that correct? (looks a bit weird to me)

I'm unsure we can reset the stream from mptcp_parse_option() even
providing it the relevant sock variable (and that would be a quite
invasive change).

Perhaps we can mark the pkts/DSS/MPTCP ext as 'bad' using an additional
flag and send the reset later? (even at rcvmsg time) =


> @@ -701,18 +691,11 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_=
out_options *opts)
>  		}
>  =

>  		if (mpext->use_map) {
> -			__sum16 checksum;
> -
> -			pr_debug("Writing map values");
>  			put_unaligned_be64(mpext->data_seq, ptr);
>  			ptr +=3D 2;
> -			*ptr++ =3D htonl(mpext->subflow_seq);
> -
> -			if (mpext->use_checksum)
> -				checksum =3D mpext->checksum;
> -			else
> -				checksum =3D TCPOPT_NOP << 8 | TCPOPT_NOP;
> -			*ptr =3D htonl(mpext->data_len << 16 | checksum);
> +			put_unaligned_be32(mpext->subflow_seq, ptr);
> +			ptr +=3D 1;
> +			put_unaligned_be16(mpext->data_len, ptr);

I think we should still set 4 bytes here:

	put_unaligned_be32(mpext->subflow_seq << 16 | TCPOPT_NOP << 8 |
TCPOPT_NOP, ptr);
	=

or we can hit some 'uninit value used' error triggered by syzbot or the
like.

Cheers,

Paolo


--===============0749654570092613985==--
