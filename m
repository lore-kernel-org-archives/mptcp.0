Content-Type: multipart/mixed; boundary="===============7943370752178674325=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 6/6] mptcp: use mptcp backlog.
Date: Wed, 11 Nov 2020 10:26:09 +0100
Message-ID: <3a4b26eab4d26df3a2176d9935c57f2074535606.camel@redhat.com>
In-Reply-To: 19e6933468367fc79a905ec5359a4283debae324.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6657

--===============7943370752178674325==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-11-11 at 10:02 +0100, Davide Caratti wrote:
> hello,
> =

> On Tue, 2020-11-10 at 12:25 +0100, Paolo Abeni wrote:
> > We have some tasks triggered by the subflow receive path
> > which require to access the msk socket status, specifically:
> > mptcp_clean_una() and mptcp_push_pending()
> > =

> > We have almost everything in place to use the msk backlog
> > and a standard !owned by user schema for that.
> > =

> > Introduce a dummy per msk sk_buff to trigger into the backlog
> > as needed.
> > =

> > Since the worker is no more used to clean the acked data,
> > for fallback sockets we need to explicitly call flush them.
> > =

> > As added bonus we can simplify a lot mptcp_poll() and
> > move the timer update under the data lock
> > =

> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > --
> > rfc v3-> v2:
> >  - dfrag_release is always invoked under sock spin lock,
> >    must use mem_release
> >  - move the mem_reclaim in mptcp_clean_una
> >  - cleanup poll, leveraging the previous patch
> > ---
> >  net/mptcp/options.c  |  18 +++--
> >  net/mptcp/protocol.c | 183 +++++++++++++++++++++++++++----------------
> >  net/mptcp/protocol.h |   8 ++
> >  3 files changed, 134 insertions(+), 75 deletions(-)
> > =

> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index 3986454a0340..48dd6622a04c 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -189,7 +189,7 @@ static void mptcp_parse_option(const struct sk_buff=
 *skb,
> >  				ptr +=3D 4;
> >  			}
> > =

> > -			pr_debug("data_ack=3D%llu", mp_opt->data_ack);
> > +			pr_debug("64=3D%d data_ack=3D%llx", mp_opt->ack64, mp_opt->data_ack=
);
> =

> why are you changing (here and in hunks below) the format specifier of
> DACKs from decimal to hex format? =


whoops, this is an unneeded/unindended change that slipped in - it's
there as debug hint, fits better my personal preference/setup.

Will be dropped in later iteration.

Cheers,

Paolo

--===============7943370752178674325==--
