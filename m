Content-Type: multipart/mixed; boundary="===============3906692159645492289=="
MIME-Version: 1.0
From: Todd Malsbary <todd.malsbary at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: use rightmost 64 bits in
 ADD_ADDR HMAC
Date: Tue, 19 May 2020 09:00:06 -0700
Message-ID: <cc760b468795bc4a189b1e3e0c6ab22bfccad757.camel@linux.intel.com>
In-Reply-To: 7dd1f4ae-c6dd-c1f9-375c-d644cf7e8b22@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4419

--===============3906692159645492289==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matthieu,

On Tue, 2020-05-19 at 17:11 +0200, Matthieu Baerts wrote:
> Hi Todd,
> =

> On 19/05/2020 02:30, Christoph Paasch wrote:
> > On 18/05/20 - 15:29:16, Todd Malsbary wrote:
> > > This changes the HMAC used in the ADD_ADDR option from the leftmost 64
> > > bits to the rightmost 64 bits as described in RFC 8684, section 3.4.1.
> > > =

> > > Signed-off-by: Todd Malsbary <todd.malsbary(a)linux.intel.com>
> > =

> > Nice find!
> =

> Yes, good catch!
> =

> Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> =

> I guess we should send that to -net branch, ideally before the release =

> of v5.7, not to introduce incompatibilities between versions. What do =

> you think?
> =


Sounds good to me.  Just to double check on the process: send this
patch out again to the netdev list with [PATCH net] as the prefix, and
cc this list?

Thanks,
-Todd

--===============3906692159645492289==--
