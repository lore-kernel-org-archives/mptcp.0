Content-Type: multipart/mixed; boundary="===============0262351901358789945=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 09/11] tcp: Check for filled TCP option
 space before SACK
Date: Mon, 16 Dec 2019 18:28:13 +0100
Message-ID: <efc70920e3dcdb694ad5791b845f4cf05478b07f.camel@redhat.com>
In-Reply-To: d5b3a6ed-fb57-e74d-ef63-ebc4ce49e4b7@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 3083

--===============0262351901358789945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-12-16 at 08:55 -0800, Eric Dumazet wrote:
> On 12/16/19 4:52 AM, Paolo Abeni wrote:
> > Thank you for the feedback!
> > =

> > Unfortunatelly, the above commit is not enough when MPTCP is enabled,
> > as, without this patch, we can reach the following code:
> > =

> > 		const unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
> > 		opts->num_sack_blocks =3D
> > 			min_t(unsigned int, eff_sacks,
> > 			      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
> > 			      TCPOLEN_SACK_PERBLOCK);
> > =

> > with 'size =3D=3D MAX_TCP_OPTION_SPACE' and num_sack_blocks will be
> > miscalculated. So we need 'fix' but only for MPTCP/when MPTCP is
> > enabled. Still ok for a -net commit?
> > =

> =

> Does it means MPTCP flows can not use SACK at all ? That would be very ba=
d.
> =

> What is the size of MPTCP options ?

MPTCP DSS+ACK+csum is up to 28 bytes, but an MPTCP stream does not need
to attach such option to each packet.

Bare MPTCP ACK are at most 12 bytes, so there is enough room for sack.

The MPTCP specs allow for different opt sizes, because e.g. sequence
numbers can be either 32 or 64 bits. Currently we only implement 64
bits seq.

Paolo


--===============0262351901358789945==--
