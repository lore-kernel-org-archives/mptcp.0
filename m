Content-Type: multipart/mixed; boundary="===============2531981772395481781=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH] Squash-to: "tcp: Prevent coalesce/collapse
 when skb has MPTCP extensions"
Date: Thu, 19 Dec 2019 03:02:38 +0100
Message-ID: <20191219020238.GB795@breakpoint.cc>
In-Reply-To: alpine.OSX.2.21.1912181557200.32925@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 3171

--===============2531981772395481781==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> > moving bits from skb1 to skb2, as the mapping in skb2 will already
> > fit, and mapping in skb1 will be dropped as/if needed.
> > =

> > When coalescing to a newly allocated skb, we transfer the relevant
> > extension to. An MPTCP specific helper is added for that goal,
> > possibly we could use/create a generic one.
> > =

> > Completely untested, just to collect early feedback.
> > =

> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > ---
> > include/net/mptcp.h  | 38 ++++++++++++++++++++++++++++++++++++++
> > include/net/tcp.h    |  2 +-
> > net/ipv4/tcp_input.c |  9 +++++----
> > 3 files changed, 44 insertions(+), 5 deletions(-)
> > =

> > diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> > index 43ddfdf9e4a3..8a702e7566e6 100644
> > --- a/include/net/mptcp.h
> > +++ b/include/net/mptcp.h
> > @@ -27,17 +27,55 @@ struct mptcp_ext {
> > =

> > #ifdef CONFIG_MPTCP
> > =

> > +static inline void mptcp_skb_ext_move(struct sk_buff *to,
> > +				      const struct sk_buff *from)
> > +{
> > +	skb_ext_put(to);
> =

> We don't want to accidentally free the ext. Since the refcount is part of
> the ext (not the skb), better to leave it unchanged. It may or may not be
> referenced by other skbs.

Maybe change this so that the extension from the first skb is carried
over.

This should be fine because mptcp_skb_can_collapse() told us
that the extensions are the same.

> > +	to->active_extensions =3D from->active_extensions;
> > +	to->extensions =3D from->extensions;
> > +	from->extensions =3D NULL;
> > +	from->active_extensions =3D 0;
> > +}
> =

> For the "move" case, do we care if there are active non-MPTCP extensions?

I don't think so.  Current code doesn't copy/consider them and with
exception of mptcp they have no meaning/use anymore at this point.
--===============2531981772395481781==--
