Content-Type: multipart/mixed; boundary="===============4184921971308528204=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH] Squash-to: "tcp: Prevent coalesce/collapse
 when skb has MPTCP extensions"
Date: Thu, 19 Dec 2019 09:53:57 +0100
Message-ID: <d11662385cf850886c0202696c96d0ce52e37461.camel@redhat.com>
In-Reply-To: 20191219015437.GA795@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 3173

--===============4184921971308528204==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-12-19 at 02:54 +0100, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> =

> I think this looks good, thanks Paolo!
> =

> Some comments below.
> =

> > diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> > index 43ddfdf9e4a3..8a702e7566e6 100644
> > --- a/include/net/mptcp.h
> > +++ b/include/net/mptcp.h
> > @@ -27,17 +27,55 @@ struct mptcp_ext {
> >  =

> >  #ifdef CONFIG_MPTCP
> >  =

> > +static inline void mptcp_skb_ext_move(struct sk_buff *to,
> > +				      const struct sk_buff *from)
> > +{
> > +	skb_ext_put(to);
> > +
> > +	to->active_extensions =3D from->active_extensions;
> > +	to->extensions =3D from->extensions;
> > +	from->extensions =3D NULL;
> > +	from->active_extensions =3D 0;
> > +}
> =

> You can remove the '=3D NULL' assignment, @to is free'd and ext core
> doesn't look at ->extensions if active_extensions =3D=3D 0.

Oks, I tried to play the 'better safe than sorry' game ;)
> =

> >  static inline bool mptcp_skb_ext_exist(const struct sk_buff *skb)
> >  {
> >  	return skb_ext_exist(skb, SKB_EXT_MPTCP);
> >  }
> >  =

> > +static inline bool mptcp_ext_matches(const struct mptcp_ext *to_ext,
> > +				     const struct mptcp_ext *from_ext)
> > +{
> > +	return !memcmp(&from_ext->data_seq, &to_ext->data_seq);
> =

> Is this supposed to be
> =

> 	return !memcmp(from_ext, to_ext, sizeof(*to_ext));
> or
> 	return from_ext->data_seq =3D=3D to_ext->data_seq;
> =

> ?
> =

> I assume its the former?

Yep, the former. Definitely low on coffee here :) Which is a poor
excuse as you commented even later ;)

> Maybe make this
> =

> return to_ext =3D=3D from_ext ||
>        (to_ext && from_ext && memcmp(...) =3D=3D 0);
> =

> > +static inline bool mptcp_skb_can_collapse(const struct sk_buff *to,
> > +					  const struct sk_buff *from)
> > +{
> > +	const struct mptcp_ext *from_ext =3D skb_ext_find(from, SKB_EXT_MPTCP=
);
> > +	const struct mptcp_ext *to_ext =3D skb_ext_find(to, SKB_EXT_MPTCP);
> > +
> > +	return !from_ext || (to_ext && mptcp_ext_matches(to_ext, from_ext));
> =

> I would prefer to handle 'to =3D=3D NULL' in mptcp_ext_matches, see below.

Ok agreed. I think togethar with the above change the resulting code
should be quite nice. And I'll add the comment you suggest below.

I'm still wondering if the mptcp_skb_ext_move() deserve a generic
helper, but WARN_ON suggested above looks quite MPTCP-specific.

Thank you all for the feedback!

Paolo

--===============4184921971308528204==--
