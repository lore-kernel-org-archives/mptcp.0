Content-Type: multipart/mixed; boundary="===============9040348578136395079=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next 3/5] mptcp: deal with
 MPTCP_PM_ADDR_FLAG_BACKUP in PM netlink
Date: Fri, 04 Dec 2020 11:54:07 +0100
Message-ID: <379ba9349f352c9287eb555025b0bd8468f65361.camel@redhat.com>
In-Reply-To: CA+WQbwsdOv4O+-nEORWHjJJse10bnTH0YDbKZTPkxTKzBZ2p9g@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7045

--===============9040348578136395079==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-12-02 at 12:35 +0800, Geliang Tang wrote:
> Hi Mat,
> =

> Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2020=E5=B9=
=B412=E6=9C=882=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=888:40=E5=86=99=
=E9=81=93=EF=BC=9A
> > On Mon, 30 Nov 2020, Geliang Tang wrote:
> > =

> > > Hi Mat,
> > > =

> > > Thanks for your review.
> > > =

> > > Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2020=E5=
=B9=B411=E6=9C=8821=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=889:17=E5=86=
=99=E9=81=93=EF=BC=9A
> > > > On Fri, 20 Nov 2020, Geliang Tang wrote:
> > > > =

> > > > > This patch added the MP_PRIO support for PM netlink:
> > > > > =

> > > > > When PM netlink adds an address, check whether the
> > > > > MPTCP_PM_ADDR_FLAG_BACKUP flag is set. If it is, check whether th=
is
> > > > > address had been added in the local address list. If it had been,=
 then
> > > > > call mptcp_nl_addr_backup to deal with this address.
> > > > > =

> > > > > In mptcp_nl_addr_backup, we traverse all the existing msk sockets=
 to find
> > > > > the relevant sockets, and get the backup value according to wheth=
er the
> > > > > MPTCP_PM_ADDR_FLAG_BACKUP flag is set, then call
> > > > > mptcp_pm_nl_mp_prio_send_ack to send out a MP_PRIO ACK packet.
> > > > > =

> > > > > In mptcp_pm_nl_mp_prio_send_ack, we set or clear the
> > > > > MPTCP_PM_ADDR_FLAG_BACKUP flag.
> > > > > =

> > > > > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > > > > ---
> > > > > net/mptcp/pm_netlink.c | 41 +++++++++++++++++++++++++++++++++++++=
++++
> > > > > 1 file changed, 41 insertions(+)
> > > > > =

> > > > > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > > > > index dd48af3c5ed5..58960e1cdc32 100644
> > > > > --- a/net/mptcp/pm_netlink.c
> > > > > +++ b/net/mptcp/pm_netlink.c
> > > > > @@ -535,6 +535,11 @@ void mptcp_pm_nl_mp_prio_send_ack(struct mpt=
cp_sock *msk,
> > > > >                       return;
> > > > >               }
> > > > > =

> > > > > +             if (addr->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
> > > > > +                     addr->flags &=3D =E2=80=BEMPTCP_PM_ADDR_FLA=
G_BACKUP;
> > > > > +             else
> > > > > +                     addr->flags |=3D MPTCP_PM_ADDR_FLAG_BACKUP;
> > > > > +
> > > > =

> > > > Why is the backup bit inverted here? It's not clear why it's change=
d, and
> > > > why bkup is passed in based on the value of the bit when read by the
> > > > calling function.
> > > > =

> > > =

> > > I think we can use backup command not only to 'turn on' a subflow's b=
ackup
> > > bit, but also to 'turn off' a subflow's backup bit. So the pm_nl_ctl =
backup
> > > command will work like this:
> > > =

> > > # pm_nl_ctl add 10.0.2.1 flags signal; pm_nl_ctl dump
> > > id 1 flags signal 10.0.2.1
> > > # pm_nl_ctl add 10.0.2.1 flags backup; pm_nl_ctl dump
> > > id 1 flags signal,backup 10.0.2.1
> > > # pm_nl_ctl add 10.0.2.1 flags backup; pm_nl_ctl dump
> > > id 1 flags signal 10.0.2.1
> > =

> > I would prefer to have the 'backup' bit in the netlink flags set the
> > backup bit directly - if the backup flag is 0 the subflow backup bit ge=
ts
> > set to 0, and if the netlink backup flag is 1 the subflow backup bit ge=
ts
> > set to 1. Paolo, does that interpretation of the backup flag match what
> > you were thinking too?
> =

> Should we add an argument behind backup for the pm_nl_ctl tool? Then we
> can use pm_nl_ctl to set backup flag like this:
> =

>  pm_nl_ctl add 10.0.2.1 flags backup 1
>  pm_nl_ctl add 10.0.2.1 flags backup 0
> =

> Or add a new argument 'set' instead of using 'add' when changing
> the backup flag:
> =

>  pm_nl_ctl set 10.0.2.1 flags backup 1
>  pm_nl_ctl set 10.0.2.1 flags backup 0

This patch changes the semantic of the MPTCP_PM_CMD_ADD_ADDR netlink
command depending on the presence of the backup flag.

I think is quite confusing.

The backup flag should be the only attribute we are allowed to change
on an existing endpoint, but that may change in the future - e.g. if we
will ever allow setting setsockopt() on the listening socket for port-
based endpoint.

I think it would be better add another NL command to update the
existing address. It may still use the same parsing helper
as MPTCP_PM_CMD_ADD_ADDR, than it will lookup the address by ID and
will set the address backup flag according to the value provided by the
user.

The pm_nl_ctl syntax is not extremely important IMHO, but the ip route
syntax will be much more interesting.

Something alike:

ip mptcp endpoint set id <nr> flags backup # the endpoint become a backup o=
ne
ip mptcp endpoint set id <nr> flags nobackup # the endpoint become a non ba=
ckup one
ip mptcp endpoint set id <nr> flags "" # the endpoint become a non backup o=
ne
ip mptcp endpoint set id <nr> flags signal # the endpoint become a non back=
up one, 'signal' is ignored
ip mptcp endpoint set id <nr> flags signal,backup # the endpoint become a b=
ackup one, 'signal' is ignored

pm_nl_ctl could opt for something similar, e.g.:

pm_nl_ctl set 10.0.2.1 flags backup
pm_nl_ctl set 10.0.2.1 flags nobackup
pm_nl_ctl set 10.0.2.1 flags signal,backup
pm_nl_ctl set 10.0.2.1 flags signal

etc...

The only special thing will ne the 'nobackup' keyword, just to be more
expressive than leaving the flag list empty.

WDYT?

Thanks,

Paolo

--===============9040348578136395079==--
