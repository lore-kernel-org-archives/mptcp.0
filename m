Content-Type: multipart/mixed; boundary="===============7427865628193945920=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v7 mptcp-next 1/7] mptcp: create the
 listening socket for new port
Date: Wed, 09 Dec 2020 19:24:42 +0800
Message-ID: <CA+WQbwv5JcHiBNCZX3u9oc+_h9sdGHrPehW7_vZi4NYEDXLurg@mail.gmail.com>
In-Reply-To: 54b4c91f012ff1e47bf7f8f048ae07e95b62d64a.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7101

--===============7427865628193945920==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thanks for your help.

Paolo Abeni <pabeni(a)redhat.com> =E4=BA=8E2020=E5=B9=B412=E6=9C=889=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=887:14=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 2020-12-07 at 14:30 +0800, Geliang Tang wrote:
> > Hi Paolo, Mat,
> >
> > On Thu, Dec 03, 2020 at 05:36:08PM -0800, Mat Martineau wrote:
> > > On Mon, 30 Nov 2020, Geliang Tang wrote:
> > >
> > > > This patch created a listening socket when an address with a port-n=
umber
> > > > is added by PM netlink. Then binded the new port to the socket, and
> > > > listened for the connection.
> > > >
> > > > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > > > ---
> > > > net/mptcp/pm_netlink.c | 58 +++++++++++++++++++++++++++++++++++++++=
+++
> > > > net/mptcp/protocol.c   |  2 +-
> > > > net/mptcp/protocol.h   |  3 +++
> > > > net/mptcp/subflow.c    |  4 +--
> > > > 4 files changed, 64 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > > > index 5151cfcd6962..c296927bf167 100644
> > > > --- a/net/mptcp/pm_netlink.c
> > > > +++ b/net/mptcp/pm_netlink.c
> > > > @@ -26,6 +26,7 @@ struct mptcp_pm_addr_entry {
> > > >   struct list_head        list;
> > > >   struct mptcp_addr_info  addr;
> > > >   struct rcu_head         rcu;
> > > > + struct socket           *lsk;
> > >
> > > Two things to fix up:
> > >
> > > Non-zero lsk is not released everywhere mptcp_pm_addr_entry structs a=
re
> > > freed.
> > >
> > > lsk is not initialized in mptcp_pm_nl_get_local_id()
> > >
> > > > };
> > > >
> > > > struct mptcp_pm_add_entry {
> > > > @@ -732,6 +733,53 @@ static struct pm_nl_pernet *genl_info_pm_nl(st=
ruct genl_info *info)
> > > >   return net_generic(genl_info_net(info), pm_nl_pernet_id);
> > > > }
> > > >
> > > > +static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
> > > > +                                     struct mptcp_pm_addr_entry *e=
ntry)
> > > > +{
> > > > + struct sockaddr_storage addr;
> > > > + struct mptcp_sock *msk;
> > > > + struct socket *ssock;
> > > > + int backlog =3D 20;
> > >
> > > Any comment on the choice of '20' here? Could it be too small for a h=
igh
> > > connection rate, or worth a sysctl?
> > >
> > > Thanks,
> > >
> > > Mat
> > >
> > > > + int err;
> > > > +
> > > > + err =3D sock_create_kern(sock_net(sk), entry->addr.family,
> > > > +                        SOCK_STREAM, IPPROTO_MPTCP, &entry->lsk);
> > > > + if (err)
> > > > +         return err;
> > > > +
> > > > + msk =3D mptcp_sk(entry->lsk->sk);
> > > > + if (!msk) {
> > > > +         err =3D -EINVAL;
> > > > +         goto out;
> > > > + }
> > > > +
> > > > + ssock =3D __mptcp_nmpc_socket(msk);
> > > > + if (!ssock) {
> > > > +         err =3D -EINVAL;
> > > > +         goto out;
> > > > + }
> > > > +
> > > > + mptcp_info2sockaddr(&entry->addr, &addr);
> > > > + err =3D kernel_bind(ssock, (struct sockaddr *)&addr,
> > > > +                   sizeof(struct sockaddr_in));
> > > > + if (err) {
> > > > +         pr_warn("kernel_bind error, err=3D%d", err);
> > > > +         goto out;
> > > > + }
> > > > +
> > > > + err =3D kernel_listen(ssock, backlog);
> > > > + if (err) {
> > > > +         pr_warn("kernel_listen error, err=3D%d", err);
> > > > +         goto out;
> > > > + }
> > > > +
> > > > + return 0;
> > > > +
> > > > +out:
> > > > + sock_release(entry->lsk);
> >
> > I need some help about releasing the MPTCP type listening socket. When I
> > use "sock_release(entry->lsk)" to release it, I'll get a deadlock warni=
ng
> > like this:
> >
> > ----
> >
> > [   55.789592] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > [   55.789593] WARNING: possible recursive locking detected
> > [   55.789594] 5.10.0-rc6-mptcp+ #742 Not tainted
> > [   55.789595] --------------------------------------------
> > [   55.789596] pm_nl_ctl/5583 is trying to acquire lock:
> > [   55.789597] ffff9ff9883cb960 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: __=
mptcp_close_ssk+0x52/0x160
> > [   55.789604]
> >                but task is already holding lock:
> > [   55.789605] ffff9ff949c1c1a0 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mp=
tcp_close+0x45/0x320
> > [   55.789608]
> >                other info that might help us debug this:
> > [   55.789609]  Possible unsafe locking scenario:
> >
> > [   55.789610]        CPU0
> > [   55.789610]        ----
> > [   55.789611]   lock(k-sk_lock-AF_INET);
> > [   55.789613]   lock(k-sk_lock-AF_INET);
> > [   55.789614]
> >                 *** DEADLOCK ***
> >
> > [   55.789615]  May be due to missing lock nesting notation
>
> Uhm... this lock warning is quite strange. We already hit that lock
> sequence in several others places, with no splat. The lock sequence per
> se is safe, as the lock is for different 'struct sock'
>
> I'm wondering if you are get any others eariler warning, fooling
> lockdepth ?!?

No other warnings, I only got this deadlock warning.

-Geliang

>
> Thanks,
>
> Paolo
>
--===============7427865628193945920==--
