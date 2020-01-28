Content-Type: multipart/mixed; boundary="===============1499598781833699832=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 net-next 1/2] mptcp: protocol: fix panic on
 user pointer access
Date: Tue, 28 Jan 2020 12:31:50 +0100
Message-ID: <7c857e2ef171a16afdc16e64a939e5a21715bf88.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.2001271702020.11293@obarba-mobl2.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3532

--===============1499598781833699832==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-01-27 at 17:22 -0800, Mat Martineau wrote:
> On Mon, 27 Jan 2020, Matthieu Baerts wrote:
> =

> > Hi Florian,
> > =

> > On 27/01/2020 00:41, Florian Westphal wrote:
> > > Its not possible to call the kernel_(s|g)etsockopt functions here,
> > > the address points to user memory:
> > =

> > I am sorry for this maybe stupid question but why can we not use these =

> > functions directly? Is it because of the "(g|s)et_fs()"?
> =

> Yes, the set_fs(KERNEL_DS) bypasses some checks for userspace memory =

> ranges.
> =

> > [...]
> > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > index 39fdca79ce90..f8232e9f08e7 100644
> > > --- a/net/mptcp/protocol.c
> > > +++ b/net/mptcp/protocol.c
> > > @@ -778,17 +778,23 @@ static void mptcp_destroy(struct sock *sk)
> > >   {
> > >   }
> > >   +static int subflow_setsockopt(struct socket *sock, int level, int =

> > > optname,
> > > +			       char __user *optval, unsigned int optlen)
> > > +{
> > > +	if (level =3D=3D SOL_SOCKET)
> > =

> > Can we arrive in this case with MPTCP? I guess not form the userspace' =

> > syscall but maybe from somewhere else in the kernel code?
> =

> Right now there isn't any code in mptcp_setsockopt() that checks which =

> levels or options are allowed through to the subflows. We discussed =

> whitelisting the socket options allowed to pass through to the subflows - =

> but the patch to whitelist TCP_CONGESTION was mostly dropped and allowed =

> everything instead of allowing nothing. I'm not sure that's what was =

> intended, I will add it to this week's agenda.
> =

> For this patch, though, the SOL_SOCKET check is needed to match =

> kernel_setsockopt behavior.

Uhm... I think handling of SOL_SOCKET is not needed ?!? we reach
mptcp_setsockopt via __sys_setsockopt(), which already took care of
SOL_SOCKET case. The check inside kernel_{get,set}sockopt was
rendundant. I think calling directly ssock->ops->setsockopt suffice
(and also keep the code smaller)

Thanks,

Paolo

--===============1499598781833699832==--
