Content-Type: multipart/mixed; boundary="===============2090515906449040668=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "mptcp: cope with later TCP fallback"
Date: Tue, 21 Jan 2020 21:33:46 +0100
Message-ID: <bc848ea94d7a865240a5bcc04f912eff33b9e1a2.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.2001210850550.4301@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 3454

--===============2090515906449040668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-01-21 at 08:51 -0800, Mat Martineau wrote:
> On Tue, 21 Jan 2020, Mat Martineau wrote:
> =

> > On Tue, 21 Jan 2020, Paolo Abeni wrote:
> > =

> > > kbuildbot reported a build breakage with IPV6 disabled.
> > > =

> > > Signed-off-by: Paolo Abeni <pabeni(a)redha.com>
> =

> One more thing - typo in signoff      ^^^^^

Thanks, will fix.

> > > ---
> > > net/mptcp/protocol.c | 12 ++++++++++--
> > > 1 file changed, 10 insertions(+), 2 deletions(-)
> > > =

> > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > index 6da609791c7a..4e289ff748ad 100644
> > > --- a/net/mptcp/protocol.c
> > > +++ b/net/mptcp/protocol.c
> > > @@ -26,6 +26,15 @@
> > > =

> > > static void __mptcp_close(struct sock *sk, long timeout);
> > > =

> > > +static const struct proto_ops * tcp_proto_ops(struct sock *sk)
> > > +{
> > > +#if IS_ENABLED(IPV6)
> > =

> > Does this need to be IS_ENABLED(CONFIG_IPV6) ?

yep, CONFIG_IPV6 is the thing.

v2 is coming.

Cheers,

Paolo

--===============2090515906449040668==--
