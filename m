Content-Type: multipart/mixed; boundary="===============4586895493980906786=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 3/4] mptcp: warn once if exceeding tcp opt
 space for dss/mp_capable
Date: Fri, 15 Nov 2019 13:35:49 +0100
Message-ID: <a7516d29575754eeacd475033630599fba46f445.camel@redhat.com>
In-Reply-To: 29159a1b50d0bff06933324da4c47afa0b0ed177.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2552

--===============4586895493980906786==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-11-14 at 22:43 -0800, Peter Krystad wrote:
> > @@ -279,22 +265,27 @@ bool mptcp_established_options(struct sock *sk, s=
truct sk_buff *skb,
> >  			       struct mptcp_out_options *opts)
> >  {
> >  	unsigned int opt_size =3D 0;
> > +	bool ret =3D false;
> >  =

> >  	if (!mptcp_subflow_ctx(sk)->mp_capable)
> >  		return false;
> >  =

> > -	if (mptcp_established_options_mp(sk, &opt_size, remaining, opts)) {
> > -		*size +=3D opt_size;
> > -		remaining -=3D opt_size;
> > -		return true;
> > -	} else if (mptcp_established_options_dss(sk, skb, &opt_size, remainin=
g,
> > -						 opts)) {
> > -		*size +=3D opt_size;
> > -		remaining -=3D opt_size;
> > -		return true;
> > -	}
> > +	if (mptcp_established_options_mp(sk, &opt_size, remaining, opts))
> > +		ret =3D true;
> > +	else if (mptcp_established_options_dss(sk, skb, &opt_size, remaining,
> > +						 opts))
> > +		ret =3D true;
> >  =

> > -	return false;
> > +	/* we reserved enough space for the above options, and exceeding the
> > +	 * TCP option space would be fatal
> > +	 */
> > +	if (WARN_ON_ONCE(opt_size > remaining))
> > +		return false;
> =

> It seems to me, and maybe I am missing something, but all this change add=
s to
> existing functionality is showing this warning when
> mptcp_established_options_mp() fails due to lack of remaining option spac=
e.
> The small change I propose above does the same, yes?

This change has a few goals:
- consolidating the check vs TCP option space exhaustion: there is a
single warn_on(). Currently we have already one, and we need to add
another one in mptcp_established_options_mp(), plus v1 support will
require adding at least one more.
- documenting that we don't actually expect to exhaust TCP option space
with MP_CAPABLE/MP_JOIN or DSS (as we don't send DSS and MP_CAPABLE
together)
- the assumption that DSS will never exhaust TCP option space allow to
simplify the code a bit.

yes, alternatively we can add more warn_on(). That will uglify a bit
the v1 code.

> I also think the logic here needs to be re-visited, since in both solutio=
ns if
> we want to send MP_CAPABLE and there isn't room we should fallback to TCP=
 and
> not 'else if' the dss option.

TCP option exhaustion with MP_CAPABLE should only happen in case of
bugs, I think WARN_ON() is enough.

Cheers,

Paolo

--===============4586895493980906786==--
