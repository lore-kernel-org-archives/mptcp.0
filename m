Content-Type: multipart/mixed; boundary="===============7261269930732794202=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC 1/2] mptcp: Export low-level routines for IPv6
Date: Tue, 29 Oct 2019 09:10:49 +0100
Message-ID: <913e9354f171ff56e9042828db176608b1b2e32f.camel@redhat.com>
In-Reply-To: 50123b1e298480f7c09d2de8694b90588ef9e7b0.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2342

--===============7261269930732794202==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-10-28 at 16:46 -0700, Peter Krystad wrote:
> On Thu, 2019-10-17 at 11:12 +0200, Paolo Abeni wrote:
> > On Wed, 2019-10-16 at 17:02 -0700, Peter Krystad wrote:
> > > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > > index 791f2c19cfb8..6f09fdfdd523 100644
> > > --- a/net/mptcp/protocol.h
> > > +++ b/net/mptcp/protocol.h
> > > @@ -268,6 +268,9 @@ int mptcp_subflow_connect(struct sock *sk, struct=
 sockaddr *local,
> > >  int mptcp_subflow_create_socket(struct sock *sk, struct socket **new=
_sock);
> > >  =

> > >  extern const struct inet_connection_sock_af_ops ipv4_specific;
> > > +#if IS_ENABLED(CONFIG_IPV6)
> > > +extern const struct inet_connection_sock_af_ops ipv6_specific;
> > > +#endif
> > >  =

> > >  void mptcp_proto_init(void);
> > > =

> > uhmm.. _if_ we want to squash these patches, this chunk should likely
> > go to a different patch than all the above - possibly "mptcp: Handle
> > MP_CAPABLE options for outgoing connections". Perhaps squashing is not
> > a good idea in this case.
> =

> Squashing depends on if we want the patch sequence to look like we did v6=
 at
> the same time as v4, i.e. as each feature is introduced it has both v4 an=
d v6.
> I'm in favor of not squashing this patch.

Ok, not a big deal. We just need to double check the total patch count
when we will be near to the submission shape - to make the series as
palatable as possible.

Cheers,

Paolo

--===============7261269930732794202==--
