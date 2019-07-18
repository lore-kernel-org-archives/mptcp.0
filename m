Content-Type: multipart/mixed; boundary="===============7298870205733158391=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 1/9] Extend path manager interface
Date: Thu, 18 Jul 2019 10:45:36 -0700
Message-ID: <416760388618f4309b66df55e1adcbb6311467b6.camel@linux.intel.com>
In-Reply-To: 52407635dbbe55fba3639ae76c3126decdaafe43.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1531

--===============7298870205733158391==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-07-18 at 09:29 +0200, Paolo Abeni wrote:
> Hi,
> =

> I have some questions out of sheer ignorance on my side, please see
> below ;)
> =

> On Wed, 2019-07-17 at 15:12 -0700, Peter Krystad wrote:
> > @@ -48,19 +82,48 @@ void pm_rm_addr(struct mptcp_sock *msk, u8 id)
> >  	pr_debug("msk=3D%p", msk);
> >  }
> >  =

> > +/* path manager helpers */
> > +
> >  bool pm_addr_signal(struct mptcp_sock *msk, unsigned int *size,
> >  		    unsigned int remaining, struct mptcp_out_options *opts)
> >  {
> > -	if (!msk || !msk->addr_signal)
> > +	if (!msk->pm.fully_established || !msk->addr_signal)
> >  		return false;
> >  =

> > -	if (msk->pm.family =3D=3D AF_INET && remaining < TCPOLEN_MPTCP_ADD_AD=
DR)
> > +	if (!msk->pm.local_valid)
> >  		return false;
> >  =

> > -	pr_debug("msk=3D%p", msk);
> > +	if (msk->pm.local_family =3D=3D AF_INET &&
> > +	    remaining < TCPOLEN_MPTCP_ADD_ADDR)
> > +		return false;
> > +
> > +	pr_debug("msk=3D%p, addr_id=3D%d", msk, msk->pm.local_id);
> >  	opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
> > -	opts->addr_id =3D msk->pm.addr_id;
> > -	opts->addr.s_addr =3D msk->pm.addr.s_addr;
> > +	opts->addr_id =3D msk->pm.local_id;
> > +	opts->addr.s_addr =3D msk->pm.local_addr.s_addr;
> > +	*size =3D TCPOLEN_MPTCP_ADD_ADDR;
> > +	msk->addr_signal =3D 0;
> =

> Strictly speaking not related to this patch, but more to the existing
> code... perhaps 'opts' updating belong to
> options.c/mptcp_established_options_addr() more than the path manager?

Agreed, I'll revise.

> =

> > index 7f15f6aab93d..8c04774ea2ec 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -77,15 +77,33 @@ static inline u32 mptcp_option(u8 subopt, u8 len, u=
8 nib, u8 field)
> >  		     ((nib & 0xF) << 8) | field);
> >  }
> >  =

> > -struct pm_data {
> > -	u8 addr_id;
> > -	sa_family_t family;
> > +struct mptcp_pm_data {
> > +	u8	local_valid;
> > +	u8	local_id;
> > +	sa_family_t local_family;
> > +	union {
> > +		struct in_addr local_addr;
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +		struct in6_addr local_addr6;
> > +#endif
> > +	};
> > +	u8	remote_valid;
> > +	u8	remote_id;
> > +	sa_family_t remote_family;
> >  	union {
> > -		struct in_addr addr;
> > +		struct in_addr remote_addr;
> >  #if IS_ENABLED(CONFIG_IPV6)
> > -		struct in6_addr addr6;
> > +		struct in6_addr remote_addr6;
> >  #endif
> >  	};
> =

> Are we going to need a list/container here? (to handle multiples addrs)
> I see is likely too early to cope with the extra complexity, just to
> have a clearer picture of the road ahead ;)
> =


Indeed. For now this is a list of length one. :) =


Although you night argue for some of our primary use cases this is probably
enough...

Peter.


> Cheers,
> =

> Paolo
> =



--===============7298870205733158391==--
