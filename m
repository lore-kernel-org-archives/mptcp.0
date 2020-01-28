Content-Type: multipart/mixed; boundary="===============7506324279650621175=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 net-next 1/2] mptcp: protocol: fix panic on
 user pointer access
Date: Tue, 28 Jan 2020 14:48:53 +0100
Message-ID: <28ccbe252d0799248278b9a4f4cc05e2fb38e4e7.camel@redhat.com>
In-Reply-To: f91bfb0e-6685-af08-0d30-72b80138bfb1@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3534

--===============7506324279650621175==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-01-28 at 14:35 +0100, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 28/01/2020 12:31, Paolo Abeni wrote:
> > On Mon, 2020-01-27 at 17:22 -0800, Mat Martineau wrote:
> > > On Mon, 27 Jan 2020, Matthieu Baerts wrote:
> > > =

> > > > Hi Florian,
> > > > =

> > > > On 27/01/2020 00:41, Florian Westphal wrote:
> > > > > Its not possible to call the kernel_(s|g)etsockopt functions here,
> > > > > the address points to user memory:
> > > > =

> > > > I am sorry for this maybe stupid question but why can we not use th=
ese
> > > > functions directly? Is it because of the "(g|s)et_fs()"?
> > > =

> > > Yes, the set_fs(KERNEL_DS) bypasses some checks for userspace memory
> > > ranges.
> > > =

> > > > [...]
> > > > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > > > index 39fdca79ce90..f8232e9f08e7 100644
> > > > > --- a/net/mptcp/protocol.c
> > > > > +++ b/net/mptcp/protocol.c
> > > > > @@ -778,17 +778,23 @@ static void mptcp_destroy(struct sock *sk)
> > > > >    {
> > > > >    }
> > > > >    +static int subflow_setsockopt(struct socket *sock, int level,=
 int
> > > > > optname,
> > > > > +			       char __user *optval, unsigned int optlen)
> > > > > +{
> > > > > +	if (level =3D=3D SOL_SOCKET)
> > > > =

> > > > Can we arrive in this case with MPTCP? I guess not form the userspa=
ce'
> > > > syscall but maybe from somewhere else in the kernel code?
> > > =

> > > Right now there isn't any code in mptcp_setsockopt() that checks which
> > > levels or options are allowed through to the subflows. We discussed
> > > whitelisting the socket options allowed to pass through to the subflo=
ws -
> > > but the patch to whitelist TCP_CONGESTION was mostly dropped and allo=
wed
> > > everything instead of allowing nothing. I'm not sure that's what was
> > > intended, I will add it to this week's agenda.
> > > =

> > > For this patch, though, the SOL_SOCKET check is needed to match
> > > kernel_setsockopt behavior.
> > =

> > Uhm... I think handling of SOL_SOCKET is not needed ?!? we reach
> > mptcp_setsockopt via __sys_setsockopt(), which already took care of
> > SOL_SOCKET case. The check inside kernel_{get,set}sockopt was
> > rendundant. I think calling directly ssock->ops->setsockopt suffice
> > (and also keep the code smaller)
> =

> Do we need to protect against other parts of the kernel calling:
> =

>    sock->ops->(g|s)etsockopt()
> =

> directly, possibly with level =3D=3D SOL_SOCKET?

I think we don't, as we don't for tcp_{g,s}etsockopt(). Why need that
additionallty here?!?

Paolo

--===============7506324279650621175==--
