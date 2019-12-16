Content-Type: multipart/mixed; boundary="===============7430222252064431364=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 09/11] tcp: Check for filled TCP option
 space before SACK
Date: Mon, 16 Dec 2019 13:52:12 +0100
Message-ID: <b9833b748f61c043a2827daee060d4ad4171996e.camel@redhat.com>
In-Reply-To: 47545b88-94db-e9cd-2f9f-2c6d665246e2@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 3076

--===============7430222252064431364==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2019-12-13 at 15:22 -0800, Eric Dumazet wrote:
> =

> On 12/13/19 3:00 PM, Mat Martineau wrote:
> > The SACK code would potentially add four bytes to the expected
> > TCP option size even if all option space was already used.
> > =

> > Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> > ---
> >  net/ipv4/tcp_output.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > =

> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index 9e04d45bc0e4..710ab45badfa 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -748,6 +748,9 @@ static unsigned int tcp_established_options(struct =
sock *sk, struct sk_buff *skb
> >  		size +=3D TCPOLEN_TSTAMP_ALIGNED;
> >  	}
> >  =

> > +	if (size + TCPOLEN_SACK_BASE_ALIGNED >=3D MAX_TCP_OPTION_SPACE)
> > +		return size;
> > +
> >  	eff_sacks =3D tp->rx_opt.num_sacks + tp->rx_opt.dsack;
> >  	if (unlikely(eff_sacks)) {
> >  		const unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
> > =

> =

> Hmmm... I thought I already fixed this issue ?
> =

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D9424e2e7ad93ffffa88f882c9bc5023570904b55
> =

> Please do not mix fixes (targeting net tree) in a patch series targeting =
net-next

Thank you for the feedback!

Unfortunatelly, the above commit is not enough when MPTCP is enabled,
as, without this patch, we can reach the following code:

		const unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
		opts->num_sack_blocks =3D
			min_t(unsigned int, eff_sacks,
			      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
			      TCPOLEN_SACK_PERBLOCK);

with 'size =3D=3D MAX_TCP_OPTION_SPACE' and num_sack_blocks will be
miscalculated. So we need 'fix' but only for MPTCP/when MPTCP is
enabled. Still ok for a -net commit?

Additionally we can clean-up the fix a bit, using something alike the
following, so that it will never add an additional branching
istruction.

---
+               if (unlikely(remaining < TCPOLEN_SACK_BASE_ALIGNED +
+                                        TCPOLEN_SACK_PERBLOCK))
+                       return size;
+
                opts->num_sack_blocks =3D
                        min_t(unsigned int, eff_sacks,
                              (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
                              TCPOLEN_SACK_PERBLOCK);
-               if (likely(opts->num_sack_blocks))
-                       size +=3D TCPOLEN_SACK_BASE_ALIGNED +
-                               opts->num_sack_blocks * TCPOLEN_SACK_PERBLO=
CK;
+
+               size +=3D TCPOLEN_SACK_BASE_ALIGNED +
+                       opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
---

Thank you!

Paolo

--===============7430222252064431364==--
