Content-Type: multipart/mixed; boundary="===============8944921090795233668=="
MIME-Version: 1.0
From: Todd Malsbary <todd.malsbary at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: use rightmost 64 bits in
 ADD_ADDR HMAC
Date: Tue, 19 May 2020 19:00:51 -0700
Message-ID: <fc274901d410ffebad0670359b6307699819d283.camel@linux.intel.com>
In-Reply-To: 20200520010926.GF45434@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 4430

--===============8944921090795233668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Tue, 2020-05-19 at 18:09 -0700, Christoph Paasch wrote:
> Hello,
> =

> On 18/05/20 - 15:29:16, Todd Malsbary wrote:
> > This changes the HMAC used in the ADD_ADDR option from the leftmost 64
> > bits to the rightmost 64 bits as described in RFC 8684, section 3.4.1.
> > =

> > Signed-off-by: Todd Malsbary <todd.malsbary(a)linux.intel.com>
> > ---
> > =

> > I found this while adding support to packetdrill for the ADD_ADDR v1
> > option.  The computation I used for the HMAC in the pending
> > packetdrill work gave a different result than what was being computed
> > by the kernel.
> > =

> > It appears that the usage of the leftmost bits has been in place since
> > at least 2016 in the out-of-tree code (commit de09a83186666).  Given
> > that, is the issue in the implementation or the RFC?
> > =

> >  net/mptcp/options.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > =

> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index ece6f92cf7d1..0e11fb3d908f 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -550,7 +550,7 @@ static u64 add_addr_generate_hmac(u64 key1, u64 key=
2, u8 addr_id,
> >  =

> >  	mptcp_crypto_hmac_sha(key1, key2, msg, 7, hmac);
> >  =

> > -	return get_unaligned_be64(hmac);
> > +	return get_unaligned_be64(&hmac[MPTCP_ADDR_HMAC_LEN - sizeof(u64)]);
> =

> as I was trying to do the same change in out-of-tree MPTCP, I realize
> something maybe a little bit late:
> =

> I think MPTCP_ADDR_HMAC_LEN is the wrong variable, no?
> =

> We want to take the rightmost bits of the SHA-256 output. Meaning, we need
> to get the right most out of mptcp_hashed_key in mptcp_crypto_hmac_sha().
> =

> Because this latter function is already only copying the first 160bits to
> hashed_out - thus we are missing the remaining bits...
> =

> =

> Right?
> =

> =


I wondered the same thing, but my read of the RFC is the rightmost 64
bits of the 160 bits.  From Section 3.4.1:

"The Truncated HMAC parameter present in this option is the rightmost
64 bits of an HMAC, negotiated and calculated in the same way as for
MP_JOIN as described in Section 3.2."

Then back in Section 3.2 the HMAC is defined as:

"This specification defines that HMAC as defined in [RFC2104] is
used, along with the SHA-256 hash algorithm [RFC6234], and that the
output is truncated to the leftmost 160 bits (20 octets). Due to
option space limitations, the HMAC included in the SYN/ACK is
truncated to the leftmost 64 bits, but this is acceptable, ..."

I left the "Due to ..." sentence in there since that implies to me that
the leftmost/rightmost selection is taken after the 160 bit truncation,
but I'll admit that it could argued either way.  Thoughts?

-Todd


--===============8944921090795233668==--
