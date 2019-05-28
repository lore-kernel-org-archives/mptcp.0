Content-Type: multipart/mixed; boundary="===============7423965101210061454=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC 1/3] mptcp: Slightly refactor
 mptcp_established_options_xxx()
Date: Tue, 28 May 2019 11:39:44 -0700
Message-ID: <5031748d93cd359c4943abffeea7202171e65223.camel@linux.intel.com>
In-Reply-To: 2c913f4b58de8dd723f281226eac7741b8db2c42.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1259

--===============7423965101210061454==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-05-23 at 11:00 +0200, Paolo Abeni wrote:
> Hi,
> =

> Thank you for doing this and sharing the code early, very appreciated!
> =

> On Wed, 2019-05-22 at 14:38 -0700, Peter Krystad wrote:
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index 1cd915890ce5..68a2311b56d4 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -797,20 +797,20 @@ static unsigned int tcp_established_options(struc=
t sock *sk, struct sk_buff *skb
> >  		unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
> >  		unsigned int opt_size;
> >  =

> > -		if (mptcp_established_options(sk, &opt_size, &opts->mptcp)) {
> > -			if (remaining >=3D opt_size) {
> > -				opts->options |=3D OPTION_MPTCP;
> > -				size +=3D opt_size;
> > -			}
> > -		} else {
> > -			unsigned int dss_size;
> > +		if ((sk, skb, &opt_size,
> > +					      remaining, &opts->mptcp)) {
> > +			opts->options |=3D OPTION_MPTCP;
> > +			size +=3D opt_size;
> > +			remaining -=3D opt_size;
> > +		}
> > +
> > +		if (mptcp_established_options_dss(sk, skb, &opt_size,
> > +						  remaining, &opts->mptcp)) {
> > +			opts->options |=3D OPTION_MPTCP;
> > +			size +=3D opt_size;
> > +			remaining -=3D opt_size;
> > +		}
> >  =

> > -			if (mptcp_established_options_dss(sk, skb, &dss_size,
> > -							  remaining,
> > -							  &opts->mptcp)) {
> > -				opts->options |=3D OPTION_MPTCP;
> > -				size +=3D dss_size;
> > -			}
> >  		}
> >  	}
> > =

> =

> [Not strictly related to MP_JOIN] I think it could be possibly cleaner
> to expose to the TCP code a single mptcp_established_option() hook and
> handle there all the relevant cases ('plain', _dss() _addr() added by
> the next patch).
> =

> The mptcp code should not change much, and possibly it would remove a
> bunch of duplicate checks (about subflow->mp_capable).

I agree a single hook is cleaner, this ended up like this to make the
individual commits stand alone better as features were added. I will revise
this.

Peter.
 =

> Cheers,
> =

> Paolo
> =



--===============7423965101210061454==--
